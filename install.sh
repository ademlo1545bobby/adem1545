#!/data/data/com.termux/files/usr/bin/bash

# Renkler
cyan='\033[1;36m'
yellow='\033[1;33m'
green='\033[1;32m'
blue='\033[1;34m'
nc='\033[0m'

clear
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "        ADEM1545 INSTALLER"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}"
sleep 1

# Güncelleme ve gerekli paketlerin yüklenmesi
pkg update -y && pkg upgrade -y
pkg install git curl wget -y

# GitHub'dan paneli indir
cd $HOME
if [ -d "adem1545" ]; then
  rm -rf adem1545
fi
git clone https://github.com/ademlo1545bobby/adem1545

# İzinler verilerek dizine girilmesi
cd adem1545 || exit
chmod +x adem1545.sh

# Panelin başlatılması
bash adem1545.sh
