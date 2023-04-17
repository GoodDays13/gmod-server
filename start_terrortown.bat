@echo off

set CollectionID=2897213518
set gamemode=terrortown
set map=ttt_abyss

call python generate_workshop.py
call python workshop_generator.py -i %CollectionID% -o garrysmod/lua/autorun/server -f gamemode_workshop.lua

start "SRCDS" /B srcds.exe -game garrysmod -conlog -port 13337 -console -conclearlog -condebug -tvdisable -maxplayers 127 +gamemode %gamemode% +servercfgfile %gamemode%.cfg +r_hunkalloclightmaps 0 +map %map% -tickrate 23 +fps_max 23 +host_workshop_collection "%CollectionID%"
