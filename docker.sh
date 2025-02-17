#!/bin/zsh

# This script creates, re-creates, and starts the following docker containers to host the module for multiplayer:
#   nwn_lot       runs Neverwinter Nights server process
#   webserver     runs nginx web server to server the files so the user does not need to manually install .mod, .hak, and other files

# This script has permissive/lazy/weak error handling so it can be run the first time and subsequently without failing or reporting errors

# Input variables
# LOT_LOCAL_IP
# NWN_DIR

LOT_PUBLIC_IP=$(curl ifconfig.me 2>/dev/null)
DOWNLOADS=$HOME/Downloads/lot
LOT_VERSION="2.0.6"
LOT_MOD_NAME="The_Lord_of_Terror_${LOT_VERSION:gs/./_}"

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
		F="${DOWNLOADS}/cep_3.1.1_releasec_0.7z"
		if [ ! -e "$F" ]; then
			echo "$F does not exist"
			exit 1
		fi
		7zz x "${F}"
	fi

}

function web {
	header "web"
	cd ../webserver || exit

	echo stopping nwn_nginx
	docker stop nwn_nginx &>/dev/null

	echo removing nwn_nginx
	docker rm nwn_nginx &>/dev/null

	echo creating nwn_nginx
	#docker run -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" abevoelker/docker-nginx: -c "${LOT_DIR}/nginx.conf"
	#	docker run -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" -v "${LOT_DIR}/nginx.conf":/etc/nginx/nginx.conf:ro nginx

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

	docker run -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" -v "${LOT_DIR}/default.conf":/etc/nginx/conf.d/default.conf:ro nginx
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
	docker stop nwn_lot &>/dev/null

	echo removing nwn_lot
	docker rm nwn_lot &>/dev/null

	echo creating nwn_lot
	docker run --platform linux/amd64 -dit -p 5121:5121/udp --name nwn_lot -v "$(pwd):/nwn/home" --env-file=env.txt nwnxee/unified:build8193.36.12
}

function nwsync {
	header "nwsync"
	cd ../lot_docker || exit
	nwsync_write --description="The Lord of Terror Server Data" ../webserver modules/${LOT_MOD_NAME}.mod
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
