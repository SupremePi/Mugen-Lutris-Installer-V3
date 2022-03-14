#!/bin/bash
#
# Description : Easy Mugen-Lutris Setup
# Author      : Retro-Devils & Supreme Team
# Version     : 3.5
#
clear

setup_start() {
echo "$(tput setaf 6)
  _   _   _     _   _   _   _   _     _   _   _   _   _   _   _   _   _
 / \ / \ / \   / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \ / \ / \ / \ 
( T | H | E ) ( M | U | G | E | N | ( I | N | S | T | A | L | L | E | R )
 \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/
  _   _     _   _   _     _   _   _   _   _   _   _     _   _   _   _  
 / \ / \   / \ / \ / \   / \ / \ / \ / \ / \ / \ / \   / \ / \ / \ / \ 
( B | Y ) ( T | H | E ) ( S | U | P | R | E | M | E ) ( T | E | A | M )
 \_/ \_/   \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ 
  _   _   _     _   _   _   _   _   _   _   _   _   _   _   _  
 / \ / \ / \   / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ 
( A | N | D ) ( R | E | T | R | O | - | D | E | V | I ) L | S )
 \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ 


$(tput sgr0)"
sleep 5
gui_mugen
}

function gui_mugen() {
    while true; do
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 26 76 26)
        local options=(
            - "*** MUGEN - SELECTIONS ***" \
            1 "Mugen Full Install with all updates"
            2 "Mugen Full Install without updates"
            - "" \
            - "*** LUTRIS - SELECTIONS ***" \
            3 "Lutris Full Install with all updates"
            4 "Lutris Full Install without updates (If Mugen Installed)"
            - "" \
            - "*** MESA-VULKAN - SELECTIONS ***" \
            5 "Mesa-Vulkan Full Install with all updates"
            6 "Mesa-Vulkan Full Install without updates"
            - "" \
            - "*** BOX86-WINE - SELECTIONS ***" \
            7 "Box86-Wine Full Install with all updates"
            8 "Box86-Wine Full Install without updates"
            - "" \
            - "*** UNINSTALL IT ALL WINE/BOX86/MUGEN/MESA/VULKAN ***" \
            9 "Remove All Mugen Mesa-Vulkan Box86-Wine" \
        )


        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    mugen_update_check
                    ;;
                2)
                    mugen_check
                    ;;
                3)
                    lutris_update_check
                    ;;
                4)
                    lutris_check
                    ;;
                5)
                    mesa_vulkan_update_check
                    ;;
                6)
                    mesa_vulkan_check
                    ;;
                7)
                    box86_wine_update_check
                    ;;
                8)
                    box86_wine_check
                    ;;
                9)
                    clean_check
					;;
                -)
                    none
                    ;;
            esac
        else
            break
        fi
    done
}


mugen_update_check() { 
update_check
mugen_check
}

lutris_update_check() { 
update_check
lutris_check
}

mesa_vulkan_update_check() { 
update_check
mesa-vulkan-installer
mesa-vulkan-shortcuts
}

box86_wine_update_check() { 
update_check
box86-wine-installer
box86-wine-shortcuts
box86-wine-es
box86-wine-desktop
box86-wine-roms
box86-wine-mono-gecko
}

mesa_vulkan_check() { 
mesa-vulkan-installer
mesa-vulkan-shortcuts
}

box86_wine_check() { 
box86-wine-installer
box86-wine-shortcuts
box86-wine-es
box86-wine-desktop
box86-wine-roms
box86-wine-mono-gecko
}


update_check() { 

echo -e "$(tput setaf 2)
***Please note you selected the full update, This could take up to 40 mins*** 
$(tput sgr0)"
sleep 10

echo -e "$(tput setaf 2)
Lets first make sure your up to date!
$(tput sgr0)"
sleep 3
clear

sudo apt -y clean
sleep 2
sudo apt-get -y update --allow-releaseinfo-change
sleep 2
#Double check update.
sudo apt -y update
sleep 2
sudo apt -y upgrade
sleep 2

echo -e "$(tput setaf 2)
Done!
$(tput sgr0)"
sleep 3
clear

echo -e "$(tput setaf 2)
Lets now check and install the pixel desktop for needed UI environment.
$(tput sgr0)"
sleep 3

cd $HOME/RetroPie-Setup
sudo ./retropie_packages.sh raspbiantools lxde
cd

echo -e "$(tput setaf 2)
Done!
$(tput sgr0)"
sleep 3
clear

echo -e "$(tput setaf 2)
Lets Now Install needed applactions!...
$(tput sgr0)"
sleep 3

sudo apt -y install python3-pip 
sleep 2
sudo apt -y install timidity-daemon timidity fluid-soundfont-gm
sleep 2
sudo apt -y install matchbox-window-manager
sleep 2

echo -e "$(tput setaf 2)
Done!
$(tput sgr0)"
sleep 3
clear

echo -e "$(tput setaf 2)
Lets now run package cleanup.
$(tput sgr0)"
sleep 3

cd $HOME/RetroPie-Setup
sudo ./retropie_packages.sh raspbiantools package_cleanup
cd

echo -e "$(tput setaf 2)
Done!
$(tput sgr0)"
sleep 3
clear
}

clean_check() { 
#Remove if found.
sudo rm -r /opt/retropie/ports/wine 2>/dev/null
sudo rm -r /opt/retropie/emulators/box86 2>/dev/null
sudo rm -r /opt/retropie/emulators/wine 2>/dev/null
sudo rm -r /opt/retropie/configs/wine 2>/dev/null
sudo rm -r /opt/retropie/configs/ports/wine* 2>/dev/null
sudo rm -r /home/pi/.wine 2>/dev/null
sudo rm -r /home/pi/box86 2>/dev/null
sudo rm -r /home/pi/wine 2>/dev/null
sudo rm -f /usr/local/bin/box86 2>/dev/null
sudo rm -f /usr/local/bin/wine 2>/dev/null
sudo rm -f /usr/local/bin/wineboot 2>/dev/null
sudo rm -f /usr/local/bin/winecfg 2>/dev/null
sudo rm -f /usr/local/bin/wineserver 2>/dev/null
sudo rm -f /usr/local/bin/winetricks 2>/dev/null
sudo rm -f /usr/bin/wine_desktop 2>/dev/null
sudo rm -f /usr/bin/version-mugen 2>/dev/null
sudo rm -f /usr/share/bash-completion/completions/wine 2>/dev/null
sudo rm -r /home/pi/RetroPie/roms/wine 2>/dev/null
sudo rm -r /home/pi/RetroPie/roms/ports/wine 2>/dev/null
sudo rm -r /home/pi/RetroPie/roms/ports/Mugen 2>/dev/null
sudo rm -r /home/pi/RetroPie/roms/ports/mugen.sh 2>/dev/null
sudo rm -r /home/pi/.qjoypad3 2>/dev/null
sudo rm -r /home/pi/mesa_vulkan 2>/dev/null
cd $HOME
clear
}

mugen_check() {
mesa-vulkan-installer
mesa-vulkan-shortcuts
box86-wine-installer
box86-wine-shortcuts
box86-wine-es
box86-wine-desktop
box86-wine-roms
install_mugen
setup_controller
box86-wine-mono-gecko
echo -e "$(tput setaf 2)
Now Rebooting to save changes, please wait...
$(tput sgr0)"
sleep 3
clear

sudo reboot
} 


mesa-vulkan-installer() {

install_script_message() {
echo -e "$(tput setaf 2)
Now going to install Mesa Vulkan.
$(tput sgr0)"
sleep 3
}

INSTALL_DIR="$HOME/mesa_vulkan"
SOURCE_CODE_URL="https://gitlab.freedesktop.org/mesa/mesa/-/tree/20.3"
PI_VERSION_NUMBER=$(awk </proc/device-tree/model '{print $3}')

install() {
    echo -e "\nInstalling,...\n"
    cd "$INSTALL_DIR" || exit
    sudo ninja -C build install
    echo
    #glxinfo -B
echo -e "$(tput setaf 2)
Done!
$(tput sgr0)"
sleep 3
}

install_full_deps() {
    echo -e "\nInstalling deps...\n"
    sudo apt-get install -y libxcb-randr0-dev libxrandr-dev \
        libxcb-xinerama0-dev libxinerama-dev libxcursor-dev \
        libxcb-cursor-dev libxkbcommon-dev xutils-dev \
        xutils-dev libpthread-stubs0-dev libpciaccess-dev \
        libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev \
        bison flex libssl-dev libgnutls28-dev x11proto-dri2-dev \
        x11proto-dri3-dev libx11-dev libxcb-glx0-dev \
        libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev \
        libva-dev x11proto-randr-dev x11proto-present-dev \
        libclc-dev libelf-dev git build-essential mesa-utils \
        libvulkan-dev ninja-build libvulkan1 python-mako \
        libdrm-dev libxshmfence-dev libxxf86vm-dev libwayland-dev \
        python3-mako wayland-protocols libwayland-egl-backend-dev \
        cmake libassimp-dev python3-pip
    install_meson
}

install_meson() {
    echo -e "\nChecking if meson is installed...\n"
    if ! pip3 list | grep -F meson &>/dev/null; then
        isPackageInstalled meson && sudo apt-get remove -y meson
        sudo pip3 install meson --force-reinstall
    fi
}

clone_repo() {
    echo -e "\nCloning mesa repo...\n"
    cd || exit
    git clone -b mesa-20.3.5 https://gitlab.freedesktop.org/mesa/mesa.git "$INSTALL_DIR" && cd "$_" || exit
}

compile() {
    local EXTRA_PARAM

    [[ -d $INSTALL_DIR ]] && rm -rf "$INSTALL_DIR"
    install_full_deps
    clone_repo

    [[ -d "$INSTALL_DIR"/build ]] && rm -rf "$INSTALL_DIR"/build

    if [[ $PI_VERSION_NUMBER -eq 4 ]]; then
        EXTRA_PARAM="-mcpu=cortex-a72 -mfpu=neon-fp-armv8 -mfloat-abi=hard"
    fi

    # Check in a future the next params for better performance. It seems it's failing due some incompatible params.
    # ... -Dgallium-drivers=v3d,kmsro,vc4,zink,virgl
    meson --prefix /usr -Dgles1=disabled -Dgles2=enabled -Dplatforms=x11 -Dvulkan-drivers=broadcom -Ddri-drivers= -Dgallium-drivers=v3d,kmsro,vc4,virgl -Dbuildtype=release -Dc_args="$EXTRA_PARAM" -Dcpp_args="$EXTRA_PARAM" build
    echo -e "\nCompiling... Estimated time on Raspberry Pi 4 over USB/SSD drive (Not overclocked): ~12 min. \n"
    time ninja -C build -j"$(nproc)"
    install
}

rm_mesa_vulkan() {
if [ -d /home/pi/mesa_vulkan ]; then
sudo rm -r /home/pi/mesa_vulkan
cd $HOME
clear
fi
}

install_script_message
compile
rm_mesa_vulkan
}

mesa-vulkan-shortcuts() {

echo -e "$(tput setaf 2)
Lets Now Check if Mesa Vulkan is in supplementary.
$(tput sgr0)"
sleep 3
if [ ! -d /opt/retropie/supplementary/mesa ]; then
sudo mkdir /opt/retropie/supplementary/mesa
sudo mkdir /opt/retropie/supplementary/mesa/share 
sudo mkdir /opt/retropie/supplementary/mesa/lib
sudo mkdir /opt/retropie/supplementary/mesa/include
sudo ln -sfn /usr/share/drirc.d /opt/retropie/supplementary/mesa/share
sudo ln -sfn /usr/share/vulkan /opt/retropie/supplementary/mesa/share
sudo ln -sfn /usr/lib/arm-linux-gnueabihf/pkgconfig /opt/retropie/supplementary/mesa/lib
sudo ln -sfn /usr/lib/arm-linux-gnueabihf/dri /opt/retropie/supplementary/mesa/lib
sudo ln -sfn /usr/lib/arm-linux-gnueabihf/lib* /opt/retropie/supplementary/mesa/lib
sudo ln -sfn /usr/include/KHR /opt/retropie/supplementary/mesa/include
sudo ln -sfn /usr/include/GLES3 /opt/retropie/supplementary/mesa/include
sudo ln -sfn /usr/include/GLES2 /opt/retropie/supplementary/mesa/include
sudo ln -sfn /usr/include/GLES /opt/retropie/supplementary/mesa/include
sudo ln -sfn /usr/include/GL /opt/retropie/supplementary/mesa/include
sudo ln -sfn /usr/include/EGL /opt/retropie/supplementary/mesa/include
sudo ln -sfn /usr/include/gbm.h /opt/retropie/supplementary/mesa/include
echo -e "$(tput setaf 2)
Mesa Vulkan was added to supplementary.
$(tput sgr0)"
sleep 3
else
echo -e "$(tput setaf 2)
Sweet Mesa Vulkan was found in supplementary.
$(tput sgr0)"
sleep 3
clear
fi
}

box86-wine-installer() {

install_script_message() {
echo -e "$(tput setaf 2)
Now going to install Box86 and Wine.
$(tput sgr0)"
sleep 3
}

install_box86_deps() {
    echo -e "\nInstalling box86 deps...\n"
    sudo apt-get install -y libapr1 libaprutil1 libserf-1-1 libsvn1 libutf8proc2 subversion binfmt-support cmake gtk2-engines-murrine libncurses5 libncursesw5 libssl1.0.2 libglu1-mesa zenity mesa-utils libinput10 libxkbcommon-x11-0 matchbox-window-manager xorg
    sudo apt remove -y xserver-xorg-video-fbturbo
}

compile_box86() {
    local PI_VERSION_NUMBER
    local SOURCE_PATH

    INSTALL_DIRECTORY="$HOME/box86"
    PI_VERSION_NUMBER=$(get_raspberry_pi_model_number)
    SOURCE_PATH="https://github.com/ptitSeb/box86.git"

    install_packages_if_missing cmake

    if [[ ! -d "$INSTALL_DIRECTORY" ]]; then
        echo
        git clone "$SOURCE_PATH" "$INSTALL_DIRECTORY" && cd "$_" || exit 1
        git checkout tags/v0.2.4
    else
        echo -e "\nUpdating the repo if proceed,...\n"
        cd "$INSTALL_DIRECTORY" && git pull
        [[ -d "$INSTALL_DIRECTORY"/build ]] && rm -rf "$INSTALL_DIRECTORY"/build
    fi

    mkdir -p build && cd "$_" || exit 1
    echo -e "\nCompiling, please wait...\n"
    cmake .. -DRPI"${PI_VERSION_NUMBER}"=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
    make_with_all_cores
    echo -e "\nCompilation done. Installing...\n"
    sudo make install
    echo -e "\nBox successfully installed.\n"
    rm_box86
}

get_raspberry_pi_model_number() {
    awk </proc/device-tree/model '{print $3}' | head -c 1
}

#
# Install packages if missing
#
install_packages_if_missing() {
    MUST_INSTALL=false
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        MUST_INSTALL=true
    fi

    if [ "$MUST_INSTALL" == false ]; then
        return 0
    fi

    echo -e "\nInstalling dependencies...\n"
    sudo apt install -y "$@"
}

make_with_all_cores() {
    echo -e "\n Compiling..."

    if [ "$(uname -m)" == 'armv7l' ]; then
        time make -j"$(nproc)" OPTOPT="-march=armv8-a+crc -mtune=cortex-a53"
    else
        time make -j"$(nproc)" PLATFORM=rpi1
    fi

    echo
}

# https://github.com/ptitSeb/box86/blob/master/docs/X86WINE.md
install_winex86() {
    local WINE_PKG_I386
    local WINE_PKG
    local DEBIAN_F_PKGS_URL
    local WINETRICKS_URL
    WINE_PKG_I386="https://dl.winehq.org/wine-builds/debian/dists/buster/main/binary-i386/wine-stable-i386_6.0.3~buster-1_i386.deb"
    WINE_PKG="https://dl.winehq.org/wine-builds/debian/dists/buster/main/binary-i386/wine-stable_6.0.3~buster-1_i386.deb"
    DEBIAN_F_PKGS_URL="http://ftp.us.debian.org/debian/pool/main/f/faudio/"
    WINETRICKS_URL="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"

    cd || exit 1

    echo -e "Backing old wine versions to ~/wine-old and /usr/local/bin/wine*old...\n"
    sudo rm -rf ~/wine-old ~/.wine-old /usr/local/bin/wine-old /usr/local/bin/wineboot-old /usr/local/bin/winecfg-old /usr/local/bin/wineserver-old
    [[ -d ~/wine ]] && sudo mv ~/wine ~/wine-old
    [[ -d ~/.wine ]] && sudo mv ~/.wine ~/.wine-old
    [[ -e /usr/local/bin/wine ]] && sudo mv /usr/local/bin/wine /usr/local/bin/wine-old
    [[ -e /usr/local/bin/wineboot ]] && sudo mv /usr/local/bin/wineboot /usr/local/bin/wineboot-old
    [[ -e /usr/local/bin/winecfg ]] && sudo mv /usr/local/bin/winecfg /usr/local/bin/winecfg-old
    [[ -e /usr/local/bin/wineserver ]] && sudo mv /usr/local/bin/wineserver /usr/local/bin/wineserver-old

    echo -e "Downloading...\n"
    wget -q -O wine_stable.deb "$WINE_PKG_I386"
    wget -q -O wine.deb "$WINE_PKG"
    wget -q -r -l1 -np -nd -A "libfaudio0_*~bpo10+1_i386.deb" "$DEBIAN_F_PKGS_URL"

    echo -e "Extract,clean & installing files/pkgs...\n"
    dpkg-deb -x ./wine_stable.deb wine-installer
    dpkg-deb -x ./wine.deb wine-installer
    dpkg-deb -xv ./libfaudio0_*~bpo10+1_i386.deb libfaudio

    mv ./wine-installer/opt/wine* ~/wine
    sudo cp -TRv libfaudio/usr/ /usr/
    rm -rf wine*.deb wine-installer libfaudio0_*~bpo10+1_i386.deb libfaudio
    #sudo rm /usr/local/bin/wine /usr/local/bin/wineboot /usr/local/bin/winecfg /usr/local/bin/wineserver

    echo -e "\nGenerating shortcuts at /usr/local/bin/wine*...\n"
    echo -e '#!/bin/bash\nsetarch linux32 -L '"$HOME/wine/bin/wine "'"$@"' | sudo tee -a /usr/local/bin/wine >/dev/null
    if ! is_kernel_64_bits; then
        sudo rm /usr/local/bin/wine
        sudo ln -f -s ~/wine/bin/wine /usr/local/bin/wine
    fi
    sudo ln -f -s ~/wine/bin/wineboot /usr/local/bin/wineboot
    sudo ln -f -s ~/wine/bin/winecfg /usr/local/bin/winecfg
    sudo ln -f -s ~/wine/bin/wineserver /usr/local/bin/wineserver
    sudo chmod +x /usr/local/bin/wine /usr/local/bin/wineboot /usr/local/bin/winecfg /usr/local/bin/wineserver

    echo -e "Installing some essential components for you..."
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq libstb0 cabextract </dev/null >/dev/null

    wget -q "$WINETRICKS_URL"
    sudo chmod +x winetricks
    sudo cp winetricks /home/pi/wine/bin/
    sudo mv winetricks /usr/local/bin/
    sudo chown pi:pi /home/pi/wine/bin/winetricks
    sudo chown pi:pi /usr/local/bin/winetricks
    generate_icon_winetricks
}

is_kernel_64_bits() {
    if [ "$(uname -m)" == "aarch64" ]; then
        true
    else
        false
    fi
}

generate_icon_winetricks() {
    if [[ ! -e /usr/local/bin/winetricks ]]; then
        return 0
    fi

    if [[ ! -d ~/.local/share/applications ]]; then
        mkdir ~/.local/share/applications
    fi

    echo -e "\nGenerating icon...\n"
    if [[ ! -e ~/.local/share/applications/winetricks.desktop ]]; then
        cat <<EOF >~/.local/share/applications/winetricks.desktop
[Desktop Entry]
Name=Winetricks
Comment=Work around problems and install applications under Wine
Exec=env BOX86_NOBANNER=1 winetricks --gui
Terminal=false
Icon=B13E_wscript.0
Type=Application
Categories=Utility;
EOF
    fi
}

COMPILE_PATH="$HOME/sc/gl4es"
PACKAGES_DEV=(libx11-dev)
GITHUB_PATH="https://github.com/ptitSeb/gl4es.git"

remove_files() {
    sudo rm -rf ~/wine ~/.wine /usr/local/bin/wine /usr/local/bin/wineboot /usr/local/bin/winecfg /usr/local/bin/wineserver /usr/local/bin/winetricks ~/.local/share/applications/winetricks.desktop
}

uninstall() {
    read -p "Do you want to uninstall Wine and all its components (y/N)? " response
    if [[ $response =~ [Yy] ]]; then
        remove_files
        if [[ -e /usr/local/bin/wine ]]; then
            echo -e "I hate when this happens. I could not find the directory, Try to uninstall manually. Apologies."
        fi
        echo -e "\nSuccessfully uninstalled."
    fi
}

if [[ -e /usr/local/bin/wine ]]; then
    echo -e "Wine already installed.\n"
    uninstall
fi

install() {
    install_box86_deps
    compile_box86
    echo -e "\nInstalling Wine x86..."
    install_winex86

echo -e "$(tput setaf 2)
Done!
$(tput sgr0)"
sleep 3
}

rm_box86() {
if [ -d /home/pi/box86 ]; then
sudo rm -r /home/pi/box86
cd $HOME
clear
fi
}

install_script_message
install
}

box86-wine-shortcuts() {

echo -e "$(tput setaf 2)
Lets Now Check if Wine is in emulators.
$(tput sgr0)"
sleep 3

if [ ! -d /opt/retropie/emulators/wine ]; then
sudo mkdir /opt/retropie/emulators/wine
sudo ln -sfn /home/pi/wine/bin /opt/retropie/emulators/wine
sudo ln -sfn /home/pi/wine/share /opt/retropie/emulators/wine
sudo ln -sfn /home/pi/wine/lib /opt/retropie/emulators/wine
echo -e "$(tput setaf 2)
Wine now added to emulators.
$(tput sgr0)"
sleep 3
else
echo -e "$(tput setaf 2)
Sweet Wine found in emulators.
$(tput sgr0)"
sleep 3
fi

echo -e "$(tput setaf 2)
Lets Now Check if Box86 is in emulators.
$(tput sgr0)"
sleep 3
if [ ! -d /opt/retropie/emulators/box86 ]; then
sudo mkdir /opt/retropie/emulators/box86
sudo ln -sfn /usr/local/bin/box86 /opt/retropie/emulators/box86
echo -e "$(tput setaf 2)
Box86 now added to emulators.
$(tput sgr0)"
sleep 3
else
echo -e "$(tput setaf 2)
Sweet Box86 found in emulators.
$(tput sgr0)"
sleep 3
fi
}

box86-wine-es() {
echo -e "$(tput setaf 2)
Now Adding Wine To ES List
$(tput sgr0)"
sleep 3

sudo cp /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.bkp
sudo cp /opt/retropie/configs/all/emulationstation/es_systems.cfg /opt/retropie/configs/all/emulationstation/es_systems.cfg.bkp 2>/dev/null
sudo cp /etc/emulationstation/es_systems.cfg /tmp

cat /tmp/es_systems.cfg |grep -v "</systemList>" > /tmp/templist.xml

ifexist=`cat /tmp/templist.xml |grep wine |wc -l`
if [[ ${ifexist} -gt 0 ]]; then
  echo "Wine already in es_systems.cfg" > /tmp/exists
else
  echo "  <system>" >> /tmp/templist.xml
  echo "    <name>wine</name>" >> /tmp/templist.xml
  echo "    <fullname>Wine</fullname>" >> /tmp/templist.xml
  echo "    <path>/home/pi/RetroPie/roms/wine</path>" >> /tmp/templist.xml
  echo "    <extension>.sh .conf .exe .SH .CONF .EXE</extension>" >> /tmp/templist.xml
  echo "    <command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ wine %ROM%</command>" >> /tmp/templist.xml
  echo "    <platform>wine</platform>" >> /tmp/templist.xml
  echo "    <theme>wine</theme>" >> /tmp/templist.xml
  echo "  </system>" >> /tmp/templist.xml
  echo "</systemList>" >> /tmp/templist.xml
  cp /tmp/templist.xml /opt/retropie/configs/all/emulationstation/es_systems.cfg
  sudo cp /tmp/templist.xml /etc/emulationstation/es_systems.cfg
  sudo chown pi:pi /opt/retropie/configs/all/emulationstation/es_systems.* 2>/dev/null
fi
echo -e "$(tput setaf 2)
Wine Now Added To ES List
$(tput sgr0)"
sleep 3
clear
}

box86-wine-desktop() {
if [ ! -d /home/pi/Desktop ]; then
mkdir /home/pi/Desktop
fi

cat <<\EOF100 > "/home/pi/Desktop/Update-wine-configs.sh"
wine wineboot
EOF100
sudo chmod +x /home/pi/Desktop/Update-wine-configs.sh
}

box86-wine-mono-gecko() {
    wine wineboot
    cd "$HOME" || exit
    wget https://dl.winehq.org/wine/wine-mono/5.1.1/wine-mono-5.1.1-x86.msi
    wget https://dl.winehq.org/wine/wine-gecko/2.47.2/wine-gecko-2.47.2-x86.msi
    wine msiexec /i ~/wine-mono-5.1.1-x86.msi /quiet /qn /norestart PROPERTY1=value1 PROPERTY2=value2
    wine msiexec /i ~/wine-gecko-2.47.2-x86.msi /quiet /qn /norestart PROPERTY1=value1 PROPERTY2=value2
    rm -f wine-mono-5.1.1-x86.msi wine-gecko-2.47.2-x86.msi
}

box86-wine-roms() {
mkdir /home/pi/RetroPie/roms/wine 2> /dev/null

cat <<\EOF82 > "/home/pi/RetroPie/roms/wine/Wine Config.sh"
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager &
WINEDEBUG=-all LD_LIBRARY_PATH="/opt/retropie/supplementary/mesa/lib/" setarch linux32 -L /opt/retropie/emulators/wine/bin/wine explorer /desktop=shell,`xrandr | grep current | sed 's/.*current //; s/,.*//; s/ //g'` winecfg
EOF82

cat <<\EOF83 > "/home/pi/RetroPie/roms/wine/Wine Desktop.sh"
wine_desktop
EOF83

cat <<\EOF84 > "/home/pi/RetroPie/roms/wine/Wine Explorer.sh"
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager &
WINEDEBUG=-all LD_LIBRARY_PATH="/opt/retropie/supplementary/mesa/lib/" setarch linux32 -L /opt/retropie/emulators/wine/bin/wine explorer /desktop=shell,`xrandr | grep current | sed 's/.*current //; s/,.*//; s/ //g'` explorer
EOF84

cp /home/pi/wine/bin/winetricks /home/pi/RetroPie/roms/wine/Winetricks.sh

sudo chmod +x /home/pi/RetroPie/roms/wine/Wine*Config.sh
sudo chmod +x /home/pi/RetroPie/roms/wine/Wine*Desktop.sh
sudo chmod +x /home/pi/RetroPie/roms/wine/Wine*Explorer.sh
sudo chmod +x /home/pi/RetroPie/roms/wine/Winetricks.sh
sudo chmod +x /home/pi/RetroPie/roms/wine/*

#Move wine files to own folder.
mkdir /home/pi/RetroPie/roms/wine/wine-apps 2> /dev/null
sudo mv /home/pi/RetroPie/roms/wine/*.sh /home/pi/RetroPie/roms/wine/wine-apps/ 2> /dev/null

mkdir /opt/retropie/configs/wine 2> /dev/null
cat <<\EOF86 > "/opt/retropie/configs/wine/emulators.cfg"
wine = "XINIT:wine_desktop %ROM%"
default = "wine"
EOF86

#Add open launcher
sudo cat <<\EOF8383 > "/home/pi/wine_desktop"
#!/bin/bash

[[ ! -n "$(aconnect -o | grep -e TiMidity -e FluidSynth)" ]] && needs_synth="1"

function midi_synth() {
    [[ "$needs_synth" != "1" ]] && return

    case "$1" in
        "start")
            echo "Starting TiMidity"
            timidity -Os -iAD &
            i=0
            until [[ -n "$(aconnect -o | grep TiMidity)" || "$i" -ge 10 ]]; do
                sleep 1
                ((i++))
            done
            ;;
        "stop")
            echo "Stopping TiMidity"
            killall timidity
            ;;
        *)
            ;;
    esac
}

#
# Key lookup function from: https://stackoverflow.com/a/40646371
#
function configValueForKey() {
    if [[ -z "$1" ]] ; then
        echo ""
    else
        echo "$2" | /usr/bin/awk -v "id=$1" 'BEGIN { FS = "=" } $1 == id { print $2 ; exit }'
    fi
}

#
# Default variable values
#
WINEDEBUG=-all
LD_LIBRARY_PATH="/opt/retropie/supplementary/mesa/lib/" 
WINEPREFIX=""
cd /home/pi/RetroPie/roms/wine/

params=("$@")
echo "Launching Wine with params: ${params}"
if [[ -z "${params[0]}" || "${params[0]}" == *"Wine Desktop.sh" ]]; then
    echo "Launching Wine Desktop"
    xset -dpms s off s noblank
    matchbox-window-manager &
    setarch linux32 -L /opt/retropie/emulators/wine/bin/wine explorer /desktop=shell,`xrandr | grep current | sed 's/.*current //; s/,.*//; s/ //g'`
elif [[ "${params[0]}" == *.exe ]]; then
    xset -dpms s off s noblank
    FILE=`readlink -f "$(realpath "$1")"`
    dir=`dirname "$(readlink -f "$(realpath "$1")")"`
    fbname=$(basename "$FILE" .exe)
    echo "$fbname"
    echo "file v '$FILE' "
    echo "dir v '$dir' "
    echo $(basename "$dir")
    cd "$dir"
    #qjoypad $(basename "$dir")  &
    qjoypad "$fbname"  &
    LD_LIBRARY_PATH="/opt/retropie/supplementary/mesa/lib/" setarch linux32 -L /opt/retropie/emulators/wine/bin/wine "$FILE"
elif [[ "${params[0]}" == *Winetricks.sh ]]; then
    echo "Launching Winetricks"
    xset -dpms s off s noblank
    matchbox-window-manager &
    PATH="$PATH:/opt/retropie/emulators/wine/bin/:/home/pi/RetroPie/roms/wine/" BOX86_NOBANNER=1 setarch linux32 -L /home/pi/RetroPie/roms/wine/wine-apps/Winetricks.sh
elif [[ "${params[0]}" == *.sh ]]; then
    echo "Launching with script"
    midi_synth start
    bash "${params[@]}"
    midi_synth stop
    exit
elif [[ "${params[0]}" == *.conf ]]; then
    configFile=$(cat "${params[@]}")
    WINEPREFIX=$(configValueForKey WINEPREFIX "$configFile")
    DIRECTORY=$(configValueForKey DIRECTORY "$configFile")
    PROGRAM=$(configValueForKey PROGRAM "$configFile")
    OPTIONS=$(configValueForKey OPTIONS "$configFile")
    QJOYPADLAYOUT=$(echo $(basename "$(dirname "${PROGRAM}")"))

    echo "Launching with config file"
    echo "WINEPREFIX: $WINEPREFIX"
    echo "DIRECTORY: $DIRECTORY"
    echo "PROGRAM: $PROGRAM"
    echo "OPTIONS: $OPTIONS"
    echo "QJOYPADLAYOUT: $QJOYPADLAYOUT"

    if [[ "$DIRECTORY" ]]; then
        cd "$DIRECTORY"
    fi

    midi_synth start
    xset -dpms s off s noblank
    matchbox-window-manager &
    if [ -d "/home/pi/.qjoypad3" ]; then
        if [ -f "/home/pi/.qjoypad3/${QJOYPADLAYOUT}.lyt" ]; then
            qjoypad "$QJOYPADLAYOUT" &
            echo "Starting qjoypad with $QJOYPADLAYOUT"
        elif [ -f "/home/pi/.qjoypad3/WINE.lyt" ]; then
            qjoypad WINE &
            echo "Starting qjoypad with WINE"
        else
            qjoypad &
            echo "Starting qjoypad with default layout"
        fi
    fi
    setarch linux32 -L /opt/retropie/emulators/wine/bin/wine "${PROGRAM}" "${OPTIONS}"
    midi_synth stop
fi
EOF8383

sudo mv /home/pi/wine_desktop /usr/bin/wine_desktop
sudo chmod +x /usr/bin/wine_desktop
}

install_mugen() {
    if [[ ! -d /home/pi/RetroPie/roms/wine/games ]]; then
        mkdir /home/pi/RetroPie/roms/wine/games
    fi

cd /home/pi/RetroPie/roms/wine/games/
wget -q http://network.mugenguild.com/justnopoint/mugen100.zip
unzip -o mugen100.zip
sudo rm mugen100.zip
sudo mv mugen Mugen
cd
sudo chmod 755 -R /home/pi/RetroPie/roms/wine/games/Mugen
sudo chown pi:pi -R /home/pi/RetroPie/roms/wine/games/Mugen

#Remove not needed exe files.
sudo rm -R /home/pi/RetroPie/roms/wine/games/Mugen/old_tools  2>/dev/null
sudo rm /home/pi/RetroPie/roms/wine/games/Mugen/sprmake2.exe  2>/dev/null
sudo rm /home/pi/RetroPie/roms/wine/games/Mugen/sff2png.exe  2>/dev/null
sudo rm /home/pi/RetroPie/roms/wine/games/Mugen/sndmaker.exe  2>/dev/null

curl -s https://raw.githubusercontent.com/SupremePi/Mugen-Lutris-Installer-V3/main/Mugen.cfg -o /home/pi/RetroPie/roms/wine/games/Mugen/data/mugen.cfg
sudo chmod +x /home/pi/RetroPie/roms/wine/games/Mugen/data/mugen.cfg

echo -e "$(tput setaf 2)
Done!
$(tput sgr0)"
clear
sleep 3

sudo cat <<\EOF2323 > "/home/pi/Xwrapper.config"
# Xwrapper.config (Debian X Window System server wrapper configuration file)
#
# This file was generated by the post-installation script of the
# xserver-xorg-legacy package using values from the debconf database.
#
# See the Xwrapper.config(5) manual page for more information.
#
# This file is automatically updated on upgrades of the xserver-xorg-legacy
# package *only* if it has not been modified since the last upgrade of that
# package.
#
# If you have edited this file but would like it to be automatically updated
# again, run the following command as root:
#   dpkg-reconfigure xserver-xorg-legacy
allowed_users=anybody
needs_root_rights=yes
EOF2323

sudo chmod +x /home/pi/Xwrapper.config
sudo mv /home/pi/Xwrapper.config /etc/X11/Xwrapper.config
}

setup_controller() {
echo -e "$(tput setaf 2)
Now Installing Qjoypad for Mugen controller setup.
$(tput sgr0)"

sudo dpkg --configure -a
sudo apt-get install qjoypad

    if [[ ! -d /home/pi/.qjoypad3 ]]; then
        mkdir /home/pi/.qjoypad3
    fi

#Add PS3 Qjoypad Layouts

    if [[ -f /home/pi/.qjoypad3/*.lyt ]]; then
        sudo rm /home/pi/.qjoypad3/*.lyt
    fi

cat <<\EOF22 > "/home/pi/.qjoypad3/Spooky_Castle.lyt"
# QJoyPad 4.1 Layout File

Joystick 1 {
	Axis 1: +key 114, -key 113
	Axis 2: +key 116, -key 111
	Axis 4: gradient, maxSpeed 100, mouse+h
	Axis 5: gradient, maxSpeed 100, mouse+v
	Axis 6: +key 114, -key 113
	Axis 7: +key 116, -key 111
	Button 1: key 54
	Button 2: key 50
	Button 3: key 52
	Button 4: key 53
	Button 5: key 37
	Button 6: key 64
	Button 9: key 9
	Button 10: key 104
}

Joystick 2 {
	Axis 1: +key 40, -key 38
	Axis 2: +key 39, -key 25
	Button 1: key 45
	Button 2: key 44
	Button 3: key 31
	Button 4: key 32
	Button 5: key 33
	Button 6: key 46
	Button 9: key 9
	Button 10: key 36
}
EOF22

cat <<\EOF33 > "/home/pi/.qjoypad3/mugen.lyt"
# QJoyPad 4.1 Layout File

Joystick 1 {
	Axis 6: +key 40, -key 38
	Axis 7: +key 39, -key 25
	Button 1: key 45
	Button 2: key 44
	Button 3: key 31
	Button 4: key 32
	Button 5: key 33
	Button 6: key 46
	Button 9: key 9
	Button 10: key 36
}
EOF33

cat <<\EOF44 > "/home/pi/.qjoypad3/Baldurs_Gate.lyt"
# QJoyPad 4.1 Layout File

Joystick 1 {
	Axis 1: +key 114, -key 113
	Axis 2: +key 116, -key 111
	Axis 4: gradient, maxSpeed 5, mouse+h
	Axis 5: gradient, maxSpeed 5, tCurve 0, mouse+v
	Axis 6: gradient, +key 114, -key 113
	Axis 7: +key 116, -key 111
	Button 1: key 54
	Button 2: key 50
	Button 3: mouse 1
	Button 4: mouse 3
	Button 5: key 37
	Button 7: key 119
	Button 8: key 36
	Button 9: key 9
	Button 10: key 104
}

Joystick 2 {
	Axis 1: +key 40, -key 38
	Axis 2: +key 39, -key 25
	Button 1: key 45
	Button 2: key 44
	Button 3: key 31
	Button 4: key 32
	Button 5: key 33
	Button 6: key 46
	Button 9: key 9
	Button 10: key 36
}
EOF44

sudo chmod +x /home/pi/.qjoypad3/*

echo -e "$(tput setaf 2)
Done installing qjoypad.
To set up Qjoypad please visit the pixel desktop to map your controler input and then save the layout as "mugen". 
Once this "mugen" layout is saved boot back into ES and copy your Qjoypad inputs for your mugen games.
For your Convince some have been made with the PS3 controller.
$(tput sgr0)"
sleep 10
}

remove_files_lutris() {
    sudo rm -r /opt/retropie/ports/lutris
    sudo rm -r /opt/retropie/configs/ports/lutris
    sudo rm -r /home/pi/RetroPie/roms/lutris
    sudo rm -r /home/pi/RetroPie/roms/ports/lutris*
    sudo apt purge -y lutris
    cd $HOME
clear
}

uninstall_lutris() {
    read -p "Do you want to uninstall Lutris (y/N)? " response
    if [[ $response =~ [Yy] ]]; then
        remove_files_lutris
        if [[ -e /opt/retropie/ports/lutris ]]; then
            echo -e "I hate when this happens. I could not find the directory, Try to uninstall manually. Apologies."
        fi
        echo -e "\nSuccessfully uninstalled."
    fi
}

lutris_check() {

if [ -d /opt/retropie/ports/lutris ]; then
echo -e "Lutris already installed.\n"
uninstall_lutris
sleep 3 
fi

echo -e "$(tput setaf 2)
Now Installing Lutris To Your PI 4!
$(tput sgr0)"
sleep 3


#will add if missing
echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
sudo apt -y update
sudo apt -y install lutris
    
    if [[ ! -d /opt/retropie/ports ]]; then
        sudo mkdir /opt/retropie/ports
    fi

    if [[ ! -d /opt/retropie/ports/lutris ]]; then
        sudo mkdir /opt/retropie/ports/lutris
    fi
    
    if [[ ! -d /opt/retropie/configs/ports/lutris ]]; then
        mkdir /opt/retropie/configs/ports/lutris
    fi

cat <<\EOF55 > "/opt/retropie/configs/ports/lutris/emulators.cfg"
lutris = "XINIT:/opt/retropie/ports/lutris/lutris.sh"
default = "lutris"
EOF55

sudo chown pi:pi /opt/retropie/ports/lutris/

cat <<\EOF88 > "/opt/retropie/ports/lutris/lutris.sh"
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager &
lutris %U 
EOF88
sudo chmod +x /opt/retropie/ports/lutris/lutris.sh
sudo chown root:root /opt/retropie/ports/lutris
sudo chown root:root /opt/retropie/ports/lutris/*
echo
echo -e "$(tput setaf 2)
Lutris Is Now Installed On Your Desktop. Now Loading menu to Pick Retropie Location for launcher.
$(tput sgr0)"
sleep 3
pick_theme_or_ports
}

pick_theme_or_ports() {
    local choice

    while true; do
       choice=$(dialog --backtitle "$BACKTITLE" --title " Pick Lutris RetroPie location " \
            --ok-label OK --cancel-label Exit \
            --menu "Pick Where To Add Lutris Launcher" 25 100 25 \
            1 "- Add Lutris to RetroPie Theme (No themes curently has lutris art)" \
            2 "- Add Lutris to RetroPie Ports" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) add_lutris_to_theme ;;
            2) add_lutris_to_ports ;;
            *) break ;;
        esac
    done
}

add_lutris_to_theme() {
if [[ ! -e /home/pi/RetroPie/roms/lutris ]]; then
echo -e "$(tput setaf 2)
Now Adding Lutris To Theme. You Can Exit after it is finished.
$(tput sgr0)"
mkdir /home/pi/RetroPie/roms/lutris
cat <<\EOF99 > "/home/pi/RetroPie/roms/lutris/lutris.sh"
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0 _PORT_ lutris
EOF99
sudo chmod +x /home/pi/RetroPie/roms/lutris/lutris.sh

sudo cp /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.bkp
sudo cp /opt/retropie/configs/all/emulationstation/es_systems.cfg /opt/retropie/configs/all/emulationstation/es_systems.cfg.bkp 2>/dev/null
sudo cp /etc/emulationstation/es_systems.cfg /tmp

cat /tmp/es_systems.cfg |grep -v "</systemList>" > /tmp/templist.xml

ifexist=`cat /tmp/templist.xml |grep lutris |wc -l`
if [[ ${ifexist} -gt 0 ]]; then
  echo "lutris already in es_systems.cfg" > /tmp/exists
else
  echo "  <system>" >> /tmp/templist.xml
  echo "    <name>lutris</name>" >> /tmp/templist.xml
  echo "    <path>~/RetroPie/roms/lutris</path>" >> /tmp/templist.xml
  echo "    <extension>.sh .SH</extension>" >> /tmp/templist.xml
  echo "    <command>bash %ROM%</command>" >> /tmp/templist.xml
  echo "    <theme>lutris</theme>" >> /tmp/templist.xml
  echo "  </system>" >> /tmp/templist.xml
  echo "</systemList>" >> /tmp/templist.xml
  cp /tmp/templist.xml /opt/retropie/configs/all/emulationstation/es_systems.cfg
  sudo cp /tmp/templist.xml /etc/emulationstation/es_systems.cfg
  sudo chown pi:pi /opt/retropie/configs/all/emulationstation/es_systems.* 2>/dev/null
fi
echo -e "$(tput setaf 2)
Done You Can Now Exit Or Add Lutris to The Ports as Well.
$(tput sgr0)"
sleep 3
else
echo -e "$(tput setaf 2)
Lutris Already Added To Theme You Can Now Exit.
$(tput sgr0)"
sleep 3
fi
}

add_lutris_to_ports() {
if [[ ! -e /home/pi/RetroPie/roms/ports/lutris ]]; then
echo -e "$(tput setaf 2)
Now Adding Lutris To Ports. You Can Exit after it is finished.
$(tput sgr0)"
sleep 3
mkdir /home/pi/RetroPie/roms/ports/lutris
cat <<\EOF99 > "/home/pi/RetroPie/roms/ports/lutris/lutris.sh"
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0 _PORT_ lutris 
fi
EOF99
sudo chmod +x /home/pi/RetroPie/roms/ports/lutris/lutris.sh
echo -e "$(tput setaf 2)
Done You Can Now Exit Or Add Lutris to The Theme as Well.
$(tput sgr0)"
sleep 3
else
echo -e "$(tput setaf 2)
Lutris Already Added To Ports You Can Now Exit.
$(tput sgr0)"
sleep 3
fi
}

installed_version() {
if [ -f /usr/bin/version-mugen ]; then
sudo rm /usr/bin/version-mugen
fi

if [ ! -f /usr/bin/version-mugen ]; then
sudo bash -c 'cat << EOF > /usr/bin/version-mugen
Supreme Team & Retro-Devils
Mugen & Lutris V3.5
EOF'
sudo chmod +x /usr/bin/version-mugen
fi

setup_start
}

installed_version
