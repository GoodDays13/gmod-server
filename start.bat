@echo off

if "%1"=="" (
    echo Error: first argument is required.
    goto :eof
)

set gamemode=%1
if "%gamemode%" == "terrortown" (
    set CollectionID=2897213518
    set map=ttt_abyss
) else if "%gamemode%" == "prop_hunt" (
    set CollectionID=2960831314
    set map=ph_restaurant
) else if "%gamemode%" == "guesswho" (
    set CollectionID=2960794037
    set map=gm_1950s_neighborhood
) else (
    echo Invalid gamemode specified
    exit
)

call python generate_workshop.py
call python workshop_generator.py -i %CollectionID% -o garrysmod/lua/autorun/server -f gamemode_workshop.lua

if not "%2"=="" (
    set map=%2
) else (
    echo Map not provided, using %map%
)

set /p confirm=Start %gamemode% on %map%? (Y/n): 
if not defined confirm set "confirm=y"
if /i "%confirm%" neq "y" (
    echo Server start cancelled.
    exit
)

start "SRCDS" /B srcds.exe -game garrysmod -conlog -port 13337 -console -conclearlog -condebug -tvdisable -maxplayers 127 +gamemode %gamemode% +servercfgfile %gamemode%.cfg +r_hunkalloclightmaps 0 +map %map% -tickrate 23 +fps_max 23 +host_workshop_collection "%CollectionID%"
