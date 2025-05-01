#!/data/data/com.termux/files/usr/bin/bash

# Renkler
cyan='\033[1;36m'
yellow='\033[1;33m'
green='\033[1;32m'
blue='\033[1;34m'
red='\033[1;31m'
nc='\033[0m'

clear
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "         ADEM1545 INSTALLER"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}"
sleep 1

# 1. Gerekli paketleri yükle
echo -e "${yellow}[+] Installing required packages...${nc}"
pkg update -y && pkg upgrade -y
pkg install curl git wget python jq termux-api -y

# 2. Eski klasör varsa sil
if [ -d "$HOME/adem1545" ]; then
  echo -e "${yellow}[!] Old folder detected. Removing it...${nc}"
  rm -rf $HOME/adem1545
fi

# 3. GitHub'dan projeyi indir
echo -e "${green}[✓] Downloading adem1545 panel...${nc}"
cd $HOME
git clone https://github.com/ademlo1545bobby/adem1545

# 4. Yetki ver ve çalıştır
cd adem1545 || { echo -e "${red}[X] Failed to enter folder!${nc}"; exit 1; }
chmod +x adem1545.sh

# 5. Paneli başlat
echo -e "${blue}→ Launching ADEM1545 Panel...${nc}"
bash adem1545.sh
