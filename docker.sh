#!/bin/zsh

# Script has permissive and lazy error handling so it can be run the first time and subsequently without failing or reporting errors

# Input variables
# LOT_DIR     directory to run docker out of

export LOT_LOCAL_IP=192.168.7.229
export LOT_PUBLIC_IP=71.254.0.211
export LOT_DIR=/Users/jeffmcclure/lot
export LOT_MOD_NAME=lot_1_7_4
export LOT_VERSION="1.7.4"

mkdir $LOT_DIR 2>/dev/null
echo cd $LOT_DIR
cd $LOT_DIR
mkdir lot_docker webserver 2>/dev/null
cd webserver

function webserver {
	cd ../webserver

	echo stopping nwn_nginx
	docker stop nwn_nginx &>/dev/null

	echo removing nwn_nginx
	docker rm nwn_nginx &>/dev/null

	echo creating nwn_nginx
	docker run -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" nginx
}

function nwn {
	cd ../lot_docker
	cat <<EOF >env.txt
    NWN_ILR=0
    NWN_PORT=5121
    NWN_MODULE=${LOT_MOD_NAME}
    NWN_PUBLICSERVER=0
    NWN_SERVERNAME='The Lord of Terror ${LOT_VERSION}'
    NWN_ONEPARTY=1
    NWN_DIFFICULTY=3
    NWN_AUTOSAVEINTERVAL=15
    NWN_NWSYNCURL=http://${LOT_PUBLIC_IP}:8000
EOF

	echo stopping nwn_lot
	docker stop nwn_lot &>/dev/null

	echo removing nwn_lot
	docker rm nwn_lot &>/dev/null

	echo copy ${LOT_MOD_NAME}.mod
	pwd
	/bin/cp /Users/jeffmcclure/Documents/Neverwinter\ Nights/modules/${LOT_MOD_NAME}.mod modules/

	echo creating nwn_lot
	docker run --platform linux/amd64 -dit -p 5121:5121/udp --name nwn_lot -v $(pwd):/nwn/home --env-file=env.txt nwnxee/unified:build8193.36.11
}

function nwsync {
	echo nwsync_write
	cd ../lot_docker
	/Users/jeffmcclure/d/nwn/nwsync/bin/nwsync_write --description="The Lord of Terror Server Data" /Users/jeffmcclure/lot/webserver modules/${LOT_MOD_NAME}.mod
}

if [ $# -eq 0 ]; then
	set -- webserver nwn nwsync
fi

for i in "$@"; do
	case $i in

	webserver)
		webserver
		;;

	nwn)
		nwn
		;;

	nwsync)
		nwsync
		;;

	lotcp)
		echo rsync to AWS
		rsync -aP -e "ssh -i $AWS_KEY" "${LOT_DIR}/webserver/" "ec2-user@${AWS}:/usr/share/nginx/html/"
		;;
	esac
done
