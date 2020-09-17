#!/bin/bash
Red='\033[0;31m'
NC='\033[0m'
Green='\033[0;32m'
Blue='\033[0;34m'
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
echo -e  "${Blue}
      ________________
     |'-.--._ _________:
     |  /    |  __    __\

     | |  _  | [\_\= [\_\

     | |.' '. \.........|
     | ( <)  ||:       :|_
      \ '._.' | :.....: |_(o
       '-\_   \ .------./
       _   \   ||.---.||  _
      / \   \  ||     || /  \

     (| []=.--[===[()]===[) |
     <\_/  \_______/ _.' /_/
     ///            (_/_/
     |\\            [\\
     ||:|           | I|
     |::|           | I|
     ||:|           | I|
     ||:|           : \:
     |\:|            \I| A Shri3kinband1t Script
     :/\:            ([])
     ([])             [|
      ||              |\_
     _/_\_            [ -'-.__
  <]   \>            \_____.>
      \__/
                           ${NC}"

read -p "Install Nordvpn? (y/n)" installnordvpn_y
read -p "Install Transmission Torrent Client?(y/n)" installtransmission_y
read -p "Install VLC media player? (y/n)" installvlc_y
read -p "Install PUTTY ssh client? (y/n)" installputty_y
read -p "Install Aircrack-ng? (y/n)" installaircrack_y
read -p "Install PenTester's Framework? (y/n)" installptf_y
read -p "Install Atom? (y/n)" installatom_y
read -p "Install Discord? (y/n)" installdiscord_y
read -p "Install Ettercap? (y/n)" installettercap_y
apt-get update -qq
#Nordvpn
if [ $installnordvpn_y = "y" ]
then
    wget -qnc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
    dpkg -i nordvpn-release_1.0.0_all.deb > /dev/null 2>&1

    apt-get -qq update
    apt-get -qq install nordvpn
    rm nordvpn-release_1.0.0_all.deb
    CMDSTEST NordvpnDownload
    nordvpn login
    CMDSTEST NordvpnLogin
    apt -q autoremove
fi


#Transmission
if [ $installtransmission_y = "y" ]
then
  apt-get install transmission -y
  CMDSTEST Transmission
fi

#VLC
if [ $installvlc_y = "y" ]
then
  apt-get install VLC -y
  CMDSTEST VLC
fi

#PUTTY
if [ $installputty_y = "y" ]
then
  apt-get install putty -y
  CMDSTEST Putty
fi

#Aircrack-ng
if [ $installaircrack_y = "y" ]
then
  apt-get install aircrack-ng -y
  CMDSTEST Aircrack
fi
#PTF
if [ $installptf_y = "y" ]
then
  apt-get install git -y
  git clone https://github.com/trustedsec/ptf
  cd ptf
  pip3 install -r requirements.txt
  CMDSTEST ptf
  echo -e "${Red}You have to run PTF yourself to install everything (and good luck!)${NC}"
fi

#Discord
if [ $installdiscord_y = "y" ]
then
  snap install discord --classic
  CMDSTEST Discord
fi

#Ettercap
if [ $installettercap_y = "y" ]
then
  apt install ettercap
  apt install ettercap-graphical
  CMDSTEST Ettercap GUI
fi

#Atom 
if [ $installatom_y = "y" ]
then 
  snap  install atom --classic
fi
echo "Install done!"
