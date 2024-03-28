#!/bin/zsh

#cd $(dirname $0)
cd /Users/jeffmcclure/lot
cd webserver

#docker run -dit -p 5121:5121/udp --name nwn_lot -v $(pwd):/nwn/home -e NWN_ILR=0 -e NWN_PORT=5121 -e NWN_MODULE=lot_1_7_4 -e NWN_PUBLICSERVER=1 -e NWN_SERVERNAME='The Lord of Terror 1.7.4' -e NWN_NWSYNCURL='http://192.168.7.229:8000' urothis/nwserver:8193-buster
#docker pull urothis/nwserver:8193-buster
#docker run -dit -p 5121:5121/udp --name nwn_lot -v $(pwd):/nwn/home -e NWN_ILR=0 -e NWN_PORT=5121 -e NWN_MODULE=lot_1_7_4 -e NWN_PUBLICSERVER=1 -e NWN_SERVERNAME='The Lord of Terror 1.7.4'  urothis/nwserver:8193-buster
#docker run -dit -p 5121:5121/udp --name nwn_lot -v $(pwd):/nwn/home -e NWN_ILR=0 -e NWN_PORT=5121 -e NWN_MODULE=lot_1_7_4 -e NWN_PUBLICSERVER=1 -e NWN_SERVERNAME='The Lord of Terror 1.7.4' beamdog/nwserver:8193.34.1-arm64
#docker run -dit -p 5121:5121/udp --name nwn_lot -v $(pwd):/nwn/home -e NWN_ILR=0 -e NWN_PORT=5121 -e NWN_MODULE=lot_1_7_4 -e NWN_PUBLICSERVER=1 -e NWN_SERVERNAME='The Lord of Terror 1.7.4' urothis/nwserver
#docker run -dit -p 5121:5121/udp --name nwn_lot -v $(pwd):/nwn/home -e NWN_ILR=0 -e NWN_PORT=5121 -e NWN_MODULE=lot_1_7_4 -e NWN_PUBLICSERVER=1 -e NWN_SERVERNAME='The Lord of Terror 1.7.4' urothis/nwserver

function webserver {
	cd ../webserver

	echo stopping nwn_nginx
	docker stop nwn_nginx 2>/dev/null >/dev/null

	echo removing nwn_nginx
	docker rm nwn_nginx 2>/dev/null >/dev/null

	echo creating nwn_nginx
	#docker run -dit -p 192.168.7.229:8000:80 --name nwn_nginx -v $(pwd):/usr/share/nginx/html nginx
	#docker run -dit -p 192.168.40.138:8000:80 --name nwn_nginx -v $(pwd):/usr/share/nginx/html nginx
	docker run -dit -p 192.168.7.229:8000:80 --name nwn_nginx -v $(pwd):/usr/share/nginx/html nginx
}

function nwn {
	cd ../lot_docker
	cat <<EOF >env.txt
    NWN_ILR=0
    NWN_PORT=5121
    NWN_MODULE=lot_1_7_4
    NWN_PUBLICSERVER=0
    NWN_SERVERNAME='The Lord of Terror 1.7.4'
    NWN_ONEPARTY=1
    NWN_DIFFICULTY=3
    NWN_AUTOSAVEINTERVAL=15
    NWN_NWSYNCURL=http://71.254.0.211:8000
EOF

    #NWN_NWSYNCURL=http://ec2-35-91-182-7.us-west-2.compute.amazonaws.com
    #NWN_NWSYNCURL=http://72.95.96.159:8000
	#NWN_NWSYNCURL=http://192.168.7.229:8000

	echo stopping nwn_lot
	docker stop nwn_lot 2>/dev/null >/dev/null

	echo removing nwn_lot
	docker rm nwn_lot 2>/dev/null >/dev/null

	echo copy lot_1_7_4.mod
	/bin/cp /Users/jeffmcclure/Documents/Neverwinter\ Nights/modules/lot_1_7_4.mod modules/lot_1_7_4.mod

	echo creating nwn_lot
	docker run --platform linux/amd64 -dit -p 5121:5121/udp --name nwn_lot -v $(pwd):/nwn/home --env-file=env.txt nwnxee/unified:build8193.36.11
}

function nwsync {
	echo nwsync_write
	cd ../lot_docker
	/Users/jeffmcclure/d/nwn/nwsync/bin/nwsync_write --description="My Cool Module Server Data V1" /Users/jeffmcclure/lot/webserver modules/lot_1_7_4.mod
}

if [ $# -eq 0 ]; then
	set -- webserver nwn nwsync lotcp
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
		rsync -aP -e "ssh -i $AWS_KEY" /Users/jeffmcclure/lot/webserver/ ec2-user@$AWS:/usr/share/nginx/html/
		;;
	esac
done
