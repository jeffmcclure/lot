#!/bin/zsh

# This script creates, re-creates, and starts the following docker containers to host the module for multiplayer:
#   nwn_lot       runs Neverwinter Nights server process
#   webserver     runs nginx web server to server the files so the user does not need to manually install .mod, .hak, and other files

# This script has permissive/lazy/weak error handling so it can be run the first time and subsequently without failing or reporting errors

# Input variables
# LOT_LOCAL_IP
# LOT_PUBLIC_IP
# NWN_DIR

DOWNLOADS=$HOME/Downloads/lot
LOT_DIR=$HOME/lot
LOT_VERSION="1.7.4"
LOT_MOD_NAME="lot_${LOT_VERSION:gs/./_}"

mkdir "$LOT_DIR" 2>/dev/null
echo cd "$LOT_DIR"
cd "$LOT_DIR" || exit
mkdir lot_docker webserver 2>/dev/null
cd webserver || exit

function supporting {
  cd ../lot_docker || exit
#  if [ ! -e hak/lothak.hak ]; then
#  fi
#  cep_3.1.1_releasec_0.7z
#  lordofterror106x.rar
#  lordofterrormusic.rar
#  lothakpackfull110704.rar
}

function webserver {
	printf "\n\n%s\n\n\n" "webserver"
	cd ../webserver || exit

	echo stopping nwn_nginx
	docker stop nwn_nginx &>/dev/null

	echo removing nwn_nginx
	docker rm nwn_nginx &>/dev/null

	echo creating nwn_nginx
	docker run -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" nginx
}

function nwn {
	printf "\n\n%s\n\n\n" "nwn"
	cd ../lot_docker || exit
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
	/bin/cp "${NWN_DIR}/modules/${LOT_MOD_NAME}.mod" modules/

	echo creating nwn_lot
	docker run --platform linux/amd64 -dit -p 5121:5121/udp --name nwn_lot -v "$(pwd):/nwn/home" --env-file=env.txt nwnxee/unified:build8193.36.11
}

function nwsync {
	printf "\n\n%s\n\n\n" "nwsync"
	cd ../lot_docker || exit
	nwsync_write --description="The Lord of Terror Server Data" ../webserver modules/${LOT_MOD_NAME}.mod
}

if [ $# -eq 0 ]; then
	set -- web nwn sync
fi

for i in "$@"; do
	case $i in

	web)
		webserver
		;;

	nwn)
		nwn
		;;

	sync)
		nwsync
		;;

	esac
done
