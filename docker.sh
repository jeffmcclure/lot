#!/usr/bin/bash

# This script creates, re-creates, and starts the following docker containers to host the module for multiplayer:
#   nwn_lot       runs Neverwinter Nights server process
#   webserver     runs nginx web server to server the files so the user does not need to manually install .mod, .hak, and other files

# This script has permissive/lazy/weak error handling so it can be run the first time and subsequently without failing or reporting errors
# git clone https://github.com/niv/neverwinter.nim

# docker ps
# docker kill
# docker logs nwn_lot
# docker logs -f nwn_lot
# docker attach nwn_lot

# Input variables
# LOT_LOCAL_IP
# NWN_DIR


function help {
    echo Usage: docker.sh [OPTION] [COMMAND]
    #echo Start, stop or monitor bitcoind
    echo
    echo "If no options are provided same 'docker.sh sync web nwn'"
    echo
    echo 'OPTIONS'
    echo '  -l,--local        use local ip address'
    echo '  -i,--interactive  run docker interactively'
    echo
    echo 'COMMANDS'
    echo '  nwn               stop, create and start nwn docker process'
    echo '  web               stop, create, start web server process'
    echo '  sync              synchronize files for client download via nwsync'
    exit
}

# process options/switches
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        -h|--help)
            help
            ;;
        -l|--local)
            echo local
            OPT_LOCAL=1
            shift # Remove processed switch
            ;;
        -i|--interactive)
            OPT_I=1
            shift # Remove processed switch
            ;;
    esac
done


case $(uname) in
    Darwin|Linux)
        CMD_7Z=7zz
        NWN_DIR="$HOME/.local/share/Neverwinter Nights"
        #echo macOS
        ;;

    #Linux)
        #CMD_7Z=7z
        #NWN_DIR="$HOME/Documents/Neverwinter Nights"
        ##echo linux
        #;;

    *)
        echo other uname="$(uname)"
        exit
        ;;
esac

which nwn_nwsync_write &>/dev/null
if [ $? != 0 ]; then
    echo nwn_nwsync_write not found in path
    exit 1
fi

if [ -z "$LOT_LOCAL_IP" ]; then
    #LOT_LOCAL_IP=$(hostname -I | head | sed -rn 's/^([0-9.]+).*$/\1/p')
    LOT_LOCAL_IP=$(hostname -I | awk 'NR==1 { print $1;exit }')
fi

if [ -n "$OPT_LOCAL" ]; then
    LOT_PUBLIC_IP=$LOT_LOCAL_IP
else
    LOT_PUBLIC_IP=$(curl ifconfig.me 2>/dev/null)
fi

DOWNLOADS=$HOME/Downloads
LOT_VERSION="2.0.6"

if [ -n "$ZSH_VERSION" ]; then
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
    cd "$LOT_DIR" || exit 8
    mkdir lot_docker webserver 2>/dev/null
    cd lot_docker || exit 7

    src="${NWN_DIR}/modules/${LOT_MOD_NAME}.mod"
    if ! cmp --silent "$src" "modules/${LOT_MOD_NAME}.mod"; then
        echo /bin/cp "$src" modules/
        mkdir modules &>/dev/null
        /bin/cp "$src" modules/ || exit 6
    fi
}

function supporting {
    header "supporting"
    cd ../lot_docker || exit 5

    src="${NWN_DIR}/hak/lot2.hak"
    if ! cmp --silent hak/lot2.hak "$src"; then
        mkdir hak &>/dev/null
        echo /bin/cp "$src" hak/
        /bin/cp "$src" hak/ || exit 4
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
        cd tlk || exit 3
        $CMD_7Z e "${F}" "CEP 3.1.2"/tlk/*tlk
        mkdir -p ../hak
        cd ../hak || exit 2
        $CMD_7Z e "${F}" "CEP 3.1.2"/hak/*hak
        cd ..

    fi

}

function web {
    header "web"
    cd ../webserver || exit 11

    echo stopping nwn_nginx
    docker stop nwn_nginx &>/dev/null

    echo removing nwn_nginx
    docker rm nwn_nginx &>/dev/null

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

    docker run -dit -p "${LOT_LOCAL_IP}:8000:80" --name nwn_nginx -v "$(pwd):/usr/share/nginx/html" -v "${LOT_DIR}/default.conf":/etc/nginx/conf.d/default.conf:ro nginx
}

function nwn {
    header "nwn"
    echo LOT_PUBLIC_IP=$LOT_PUBLIC_IP

    cd ../lot_docker || exit 10
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

    if [ -n "$OPT_I" ]; then
        OPT=
    else
        OPT=d
    fi

    #docker run --platform linux/amd64 -dit -p 5121:5121/udp --name nwn_lot -v "$(pwd):/nwn/home" --env-file=env.txt nwnxee/unified:build8193.37.14
    echo docker run --platform linux/amd64 "-${OPT}it" -p 5121:5121/udp --name nwn_lot -v "$(pwd):/nwn/home" --env-file=env.txt nwnxee/unified:latest
    docker run --platform linux/amd64 "-${OPT}it" -p 5121:5121/udp --name nwn_lot -v "$(pwd):/nwn/home" --env-file=env.txt nwnxee/unified:latest
}

function nwsync {
    header "nwsync"
    cd ../lot_docker || exit 9
    nwn_nwsync_write --description="The Lord of Terror Server Data" ../webserver modules/${LOT_MOD_NAME}.mod
}



# if no parameters are passed, then use these
if [ $# -eq 0 ]; then
    echo no args
    set -- sync web nwn
fi


# process commands
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        web)
            CMD_WEB=1
            ;;
        nwn)
            CMD_NWN=1
            ;;
        sync)
            CMD_SYNC=1
            ;;
        *)
            # Handle unknown options or non-option arguments
            echo "Unknown option: $1"
            exit
            ;;
    esac
    shift # Remove processed argument
done

setup1
supporting

if [ -n "$CMD_SYNC" ]; then
    nwsync
fi

if [ -n "$CMD_WEB" ]; then
    web
fi

if [ -n "$CMD_NWN" ]; then
    nwn
fi
