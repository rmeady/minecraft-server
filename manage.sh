#!/bin/sh
SERVICE="minecraft_server"
SERVICE_JAR="${SERVICE}.jar"
WORLD="world"
MINECRAFT_PATH="/usr/local/minecraft"
MAX_HEAP=1024
MIN_HEAP=1024

function minecraft_pid {
    local minecraft_pid=$(ps aux | grep "${SERVICE}" | grep -v grep | grep -v SCREEN | awk '{print $2}')
    echo ${minecraft_pid}
}

function start {
    echo "$(date) - Starting Server"
    local minecraft_pid=$(minecraft_pid)
    [ -n "${minecraft_pid}" ] && echo "Minecraft server is already running" && return 0
    screen -dmS "${SERVICE}" java -Xms${MIN_HEAP}M -Xmx${MAX_HEAP}M -jar "${MINECRAFT_PATH}/${SERVICE_JAR}" nogui
}

function stop {
    echo "$(date) - Stopping Server"
    local minecraft_pid=$(minecraft_pid)
    [ -z "${minecraft_pid}" ] && echo "Minecraft server is not running" && return 0
    bash -c "screen -p 0 -X eval 'stuff \"say SERVER SHUTTING DOWN IN 10 SECONDS...\"\015'"
    sleep 10
    bash -c "screen -p 0 -X eval 'stuff \"stop\"\015'"
    sleep 10
}

function message {
    bash -c "screen -p 0 -X eval 'stuff \"say $1\"\015'"
}

function console {
    bash -c "screen -p 0 -X eval 'stuff \"$1\"\015'"
}

while getopts "udrm:c:" opt; do
    case "${opt}" in
    "u")
        start
        ;;
    "d")
        stop
        ;;
    "r")
        stop
        start
        ;;
    "m")
        message "${OPTARG}"
        ;;
    "c")
        console "${OPTARG}"
        ;;
    esac
done