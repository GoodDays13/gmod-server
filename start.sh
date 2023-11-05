#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: first argument is required."
    exit 1
fi

gamemode="$1"
if [ "$gamemode" = "terrortown" ]; then
    CollectionID=2897213518
    map=ttt_abyss
elif [ "$gamemode" = "prop_hunt" ]; then
    CollectionID=2960831314
    map=ph_restaurant
elif [ "$gamemode" = "guesswho" ]; then
    CollectionID=2960794037
    map=gm_1950s_neighborhood
else
    echo "Invalid gamemode specified"
    exit 1
fi

if [ -z "$3" ]; then
    if ! [[ -d .venv ]]; then
        python -m venv .venv
        source ./.venv/bin/activate
        pip install -r .pythonreqs.txt
    else
        source ./.venv/bin/activate
    fi

    python workshop_generator.py -i "$CollectionID" -o garrysmod/lua/autorun/server -f gamemode_workshop.lua
    python workshop_generator.py -i 2961097669 -o garrysmod/lua/autorun/server -f server_workshop.lua

    deactivate
fi

if [ ! -z "$2" ]; then
    map="$2"
else
    echo "Map not provided, using $map"
fi

read -p "Start $gamemode on $map? (Y/n): " confirm
confirm="${confirm:-y}"
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Server start cancelled."
    exit 0
fi

./srcds_run -game garrysmod -conlog -port 13337 -console -conclearlog -condebug -tvdisable -maxplayers 127 +gamemode "$gamemode" +servercfgfile "$gamemode".cfg +map "$map" +host_workshop_collection "$CollectionID"

