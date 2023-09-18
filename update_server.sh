#!/bin/bash

# Define the installation directory
install_dir="/home/steam/gmod_server"

# Run SteamCMD with the desired options
steamcmd +force_install_dir "$install_dir" +login anonymous +app_update 4020 validate -beta none +quit

