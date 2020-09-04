#!/bin/bash
Red='\033[0;31m'
NC='\033[0m'
Green='\033[0;32m'
function roottest() {
  ROOT_UID=0   # Root has $UID 0.

  if [ "$UID" -eq "$ROOT_UID" ]  # Will the real "root" please stand up?
  then
    echo -e "${Green}RootCheck Good${NC}"
  else
    echo -e "${Red}Run as Root!!${NC}"
    exit n
  fi
}
roottest
pwdv=$(pwd)
function InternetTest() {
  if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    echo -e "${Green}Internet Test Success${NC}"
  else
    echo -e "${Red}Internet Connection Unavailable${NC}"
    exit n
  fi }
function CMDSTEST() {
    if [ $? -eq 0 ]; then
       echo -e $1 "${Green}Installed${NC}"
    else
       echo -e $1 "${Red}Failed${NC}"
    fi
  }
InternetTest
read -p "Install Nordvpn? (y/n)" installnordvpn_y
read -p "Install Brave Browser (y/n)" installbraveb_y
read -p "Install Transmission Torrent Client?(y/n)" installtransmission_y
#Nordvpn
if [[ $installnordvpn_y = "y" ]]
then
    wget -qnc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
    dpkg -i nordvpn-release_1.0.0_all.deb > /dev/null 2>&1

    apt-get -q update
    apt-get -q install nordvpn
    rm nordvpn-release_1.0.0_all.deb
    CMDSTEST NordvpnDownload
    nordvpn login
    CMDSTEST NordvpnLogin
    sudo apt -q autoremove
fi
#Brave Browser
if [[$installbraveb_y = "y"]]
then
    mkdir braveinstallfolder
    cd braveinstallfolder
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc
    apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - $compasswd
    sh -c 'echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com `lsb_release -sc` maish -c 'echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com `lsb_release -sc` main" >> /etc/apt/sources.list.d/brave.list'n" >> /etc/apt/sources.list.d/brave.list'
    apt update
    apt install brave-browser brave-keyring
    cd $pwdv
    rm -r braveinstallfolder
    CMDSTEST Brave
fi


#Transmission
if [[$installtransmission_y = "y"]]
then
  sudo apt-get install transmission
  CMDSTEST Transmission
fi
