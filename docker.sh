#!/usr/bin/bash

# This script creates, re-creates, and starts the following docker containers to host the module for multiplayer:
#   nwn_lot       runs Neverwinter Nights server process
#   webserver     runs nginx web server to server the files so the user does not need to manually install .mod, .hak, and other files

# This script has permissive/lazy/weak error handling so it can be run the first time and subsequently without failing or reporting errors

# docker ps
# docker kill

# Input variables
# LOT_LOCAL_IP
# NWN_DIR

case $(uname) in
Darwin)
  CMD_7Z=7zz
  NWN_DIR="$HOME/.local/share/Neverwinter Nights"
  #echo macOS
  ;;

Linux)
  CMD_7Z=7z
  NWN_DIR="$HOME/Documents/Neverwinter Nights"
  #echo linux
  ;;

*)
  echo other
  exit
  ;;
esac

which nwn_nwsync_write 2>/dev/null
if [ $? != 0 ]; then
  echo nwn_nwsync_write not found in path
  exit 1
fi

if [ -z "$LOT_LOCAL_IP" ]; then
  LOT_LOCAL_IP=$(hostname -I | head | sed -rn 's/^([0-9.]+).*$/\1/p')
fi

LOT_PUBLIC_IP=$(curl ifconfig.me 2>/dev/null)
DOWNLOADS=$HOME/Downloads
LOT_VERSION="2.0.6"

if [ -n "$ZSH_VERSINO" ]; then
  LOT_MOD_NAME="The_Lord_of_Terror_${LOT_VERSION:gs/./_}"
elif [ -n "$BASH" ]; then
  LOT_MOD_NAME="The_Lord_of_Terror_${LOT_VERSION//./_}"
else
  echo unknown shell
  exit 1
fi

if [ -z "$LOT_MOD_NAME" ]; then
  echo LOT_MOD_NAME is blank
  exit
fi

if [ -z "$LOT_DIR" ]; then
	LOT_DIR=$HOME/lot
fi

function header {
	figlet "$@"
}

function setup1 {
	header "setup1"
	mkdir "$LOT_DIR" 2>/dev/null
	cd "$LOT_DIR" || exit
	mkdir lot_docker webserver 2>/dev/null
	cd lot_docker || exit

	src="${NWN_DIR}/modules/${LOT_MOD_NAME}.mod"
	if ! cmp --silent "$src" "modules/${LOT_MOD_NAME}.mod"; then
		echo /bin/cp "$src" modules/
		mkdir modules &>/dev/null
		/bin/cp "$src" modules/ || exit
	fi
}

function supporting {
	header "supporting"
	cd ../lot_docker || exit

	src="${NWN_DIR}/hak/lot2.hak"
	if ! cmp --silent hak/lot2.hak "$src"; then
		mkdir hak &>/dev/null
		echo /bin/cp "$src" hak/
		/bin/cp "$src" hak/ || exit
	fi

	if [ ! -e hak/cep3_core3.hak ]; then
		mkdir hak &>/dev/null
		#F="${DOWNLOADS}/cep_3.1.1_releasec_0.7z"
		F="${DOWNLOADS}/cep_3.1.2.7z"
		if [ ! -e "$F" ]; then
			echo "$F does not exist"
			exit 1
		fi
		#$CMD_7Z x "${F}"
		mkdir -p tlk
		cd tlk
		$CMD_7Z e "${F}" "CEP 3.1.2"/tlk/*tlk
		mkdir -p ../hak
		cd ../hak
    $CMD_7Z e "${F}" "CEP 3.1.2"/hak/*hak
    cd ..

	fi

}

function web {
	header "web"
	cd ../webserver || exit

	echo stopping nwn_nginx
	sudo docker stop nwn_nginx &>/dev/null

	echo removing nwn_nginx
	sudo docker rm nwn_nginx &>/dev/null

	echo creating nwn_nginx
	#docker xrun -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" abevoelker/docker-nginx: -c "${LOT_DIR}/nginx.conf"
	#	docker xrun -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" -v "${LOT_DIR}/nginx.conf":/etc/nginx/nginx.conf:ro nginx

	cat <<EOF >../default.conf
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        autoindex on;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
       root   /usr/share/nginx/html;
    }
}
EOF

	sudo docker run -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" -v "${LOT_DIR}/default.conf":/etc/nginx/conf.d/default.conf:ro nginx
}

function nwn {
	header "nwn"
	cd ../lot_docker || exit
  #NWN_AUTOSAVEINTERVAL=15
	cat <<EOF >env.txt
    NWN_ILR=0
    NWN_PORT=5121
    NWN_MODULE=${LOT_MOD_NAME}
    NWN_PUBLICSERVER=0
    NWN_SERVERNAME="The Lord of Terror ${LOT_VERSION}"
    NWN_ONEPARTY=1
    NWN_DIFFICULTY=3
    NWN_NWSYNCURL=http://${LOT_PUBLIC_IP}:8000
EOF

	echo stopping nwn_lot
	sudo docker stop nwn_lot &>/dev/null

	echo removing nwn_lot
	sudo docker rm nwn_lot &>/dev/null

	echo creating nwn_lot
	#sudo docker run --platform linux/amd64 -dit -p 5121:5121/udp --name nwn_lot -v "$(pwd):/nwn/home" --env-file=env.txt nwnxee/unified:build8193.37.14
	sudo docker run --platform linux/amd64 -dit -p 5121:5121/udp --name nwn_lot -v "$(pwd):/nwn/home" --env-file=env.txt nwnxee/unified:latest
}

function nwsync {
	header "nwsync"
	cd ../lot_docker || exit
	nwn_nwsync_write --description="The Lord of Terror Server Data" ../webserver modules/${LOT_MOD_NAME}.mod
}

# if no parameters are passed, then use these
if [ $# -eq 0 ]; then
	set -- sync web nwn
fi

# pre check options
for i in "$@"; do
	case $i in

	web|nwn|sync)
		;;

  *)
    echo unknown option $i
    exit 1
    ;;

	esac
done

setup1
supporting

for i in "$@"; do
	case $i in

	web)
		web
		;;

	nwn)
		nwn
		;;

	sync)
		nwsync
		;;

	esac
done
