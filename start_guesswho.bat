set CollectionID=2960794037
call python generate_workshop.py
call python workshop_generator.py -i %CollectionID% -o garrysmod/lua/autorun/server -f gamemode_workshop.lua
start "SRCDS" /B srcds.exe -game garrysmod -conlog -port 13337 -console -conclearlog -condebug -tvdisable -maxplayers 127 +gamemode guesswho +r_hunkalloclightmaps 0 +map gm_1950s_neighborhood -tickrate 23 +fps_max 23 +xm_serverid 0 +host_workshop_collection "%CollectionID%"
