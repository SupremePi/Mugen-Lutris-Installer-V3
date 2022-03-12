#!/bin/bash
#
# Description : Easy Mugen-Lutris Setup
# Author      : Retro-Devils & Supreme Team
# Version     : 3.5
#
clear

install() {
    local IS_RASPBERRYPI
    IS_RASPBERRYPI=$(grep </proc/cpuinfo 'BCM2711')
    cd "$INSTALL_DIR" || exit 1

    if [[ -z $IS_RASPBERRYPI ]]; then
        echo "Please note this installer is only for the Pi4 Boards"
        sleep 5
    fi

    if [[ ! -d $HOME/RetroPie-Setup ]]; then
        echo "Sorry.The mugen installer is only available for builds with RetroPie installed."
        sleep 5
        exit
    fi

    curl -s https://raw.githubusercontent.com/SupremePi/Mugen-Lutris-Installer-V3/main/mugen-lutris-v3.sh | bash
}

install
