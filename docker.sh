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
    echo "Usage: docker.sh [OPTION] [COMMAND]"
    echo "Manage docker config for Neverwinter Nights"
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

case $(uname) in
Darwin)
    CMD_7Z=7zz
    NWN_DIR="$HOME/.local/share/Neverwinter Nights"
    #echo macOS
    ;;

Linux)
    CMD_7Z=7z
    NWN_DIR="$HOME/.local/share/Neverwinter Nights"
    #echo linux
    ;;

*)
    echo other uname="$(uname)"
    exit
    ;;
esac

# process options/switches
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
    -h | --help)
        help
        ;;
    -l | --local)
        echo local
        OPT_LOCAL=1
        ;;
    -i | --interactive)
        OPT_I=1
        ;;
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
        if [ -e "$key" ]; then
            MODULE_NAME=$(basename "$key")
            MODULE_NAME="${MODULE_NAME%.*}"
        elif [ -e "${NWN_DIR}/modules/${key}.mod" ]; then
            MODULE_NAME="$key"
        elif [ -e "${NWN_DIR}/modules/${key}" ]; then
            MODULE_NAME="${key%.*}"
        else
            # Handle unknown options or non-option arguments
            echo "Unknown option: $1"
            exit 1
        fi
        ;;
    esac
    shift # Remove processed switch
done

# if no commands are set then set all
if [[ -z "$CMD_SYNC" && -z "$CMD_WEB" && -z "$CMD_NWN" ]]; then
    CMD_SYNC=1
    CMD_WEB=1
    CMD_NWN=1
fi

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
    NWN_PUBLIC_IP=$LOT_LOCAL_IP
else
    NWN_PUBLIC_IP=$(curl ifconfig.me 2>/dev/null)
fi

DOWNLOADS=$HOME/Downloads
LOT_VERSION="2.0.6"

if [ -z "$MODULE_NAME" ]; then
    if [ -n "$ZSH_VERSION" ]; then
        MODULE_NAME="The_Lord_of_Terror_${LOT_VERSION:gs/./_}"
    elif [ -n "$BASH" ]; then
        MODULE_NAME="The_Lord_of_Terror_${LOT_VERSION//./_}"
    else
        echo unknown shell
        exit 1
    fi
fi

if [ -z "$MODULE_NAME" ]; then
    echo MODULE_NAME is blank
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

    src="${NWN_DIR}/modules/${MODULE_NAME}.mod"
    if ! cmp --silent "$src" "modules/${MODULE_NAME}.mod"; then
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

    if [ ! -e hak/eotb1-armor1.hak ]; then
        F="${DOWNLOADS}/eob_2_0.zip"
        [ -f "$F" ] || { echo "Error: File '$F' does not exist." >&2; exit 1; }
        $CMD_7Z x "${F}" || { echo "7zip failed for $F"; exit 1; }
    fi

    if [ ! -e "modules/Eye of the Beholder.mod" ]; then
        F="${DOWNLOADS}/eye_of_the_beholder_v6.7.zip"
        [ -f "$F" ] || { echo "Error: File '$F' does not exist." >&2; exit 1; }
        mkdir -p modules || { echo "error mkdir -p modules"; exit 1; }
        cd modules || { echo "error cd modules"; exit 1; }
        $CMD_7Z e "${F}" || { echo "7zip failed for $F"; exit 1; }
        cd ..
    fi

    if [ ! -e hak/cep3_core3.hak ]; then
        F="${DOWNLOADS}/cep_3.1.2.7z"
        [ -f "$F" ] || { echo "Error: File '$F' does not exist." >&2; exit 1; }
        mkdir -p tlk || { echo "error mkdir -p tlk"; exit 1; }
        cd tlk || { echo "error cd tlk"; exit 1; }
        $CMD_7Z e "${F}" "CEP 3.1.2"/tlk/*tlk || { echo "7zip failed for $F"; exit 1; }
        mkdir -p ../hak || { echo "error creating hak" exit 1; }
        cd ../hak || { echo "error cd ../hak" ; exit 2; }
        $CMD_7Z e "${F}" "CEP 3.1.2"/hak/*hak || { echo "7zip failed for $F"; exit 1; }
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
    echo NWN_PUBLIC_IP="$NWN_PUBLIC_IP"

    cd ../lot_docker || exit 10
    #NWN_AUTOSAVEINTERVAL=15
    cat <<EOF >env.txt
    NWN_ILR=0
    NWN_PORT=5121
    NWN_MODULE=${MODULE_NAME}
    NWN_PUBLICSERVER=0
    NWN_SERVERNAME="${MODULE_NAME}"
    NWN_ONEPARTY=1
    NWN_DIFFICULTY=3
    NWN_NWSYNCURL=http://${NWN_PUBLIC_IP}:8000
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
    docker run --platform linux/amd64 "-${OPT}it" -p 5121:5121/udp -p 5120:5120/udp -p 6500:6500/udp --name nwn_lot -v "$(pwd):/nwn/home" --env-file=env.txt nwnxee/unified:latest
}

function nwsync {
    header "nwsync"
    cd ../lot_docker || exit 9
    nwn_nwsync_write --limit-file-size 30 --description="$MODULE_NAME" ../webserver modules/"${MODULE_NAME}".mod
}

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
