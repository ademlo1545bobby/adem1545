#!/data/data/com.termux/files/usr/bin/bash

# Colors
cyan='\033[1;36m'
yellow='\033[1;33m'
green='\033[1;32m'
blue='\033[1;34m'
red='\033[1;31m'
nc='\033[0m'

clear
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "        ADEM1545 INSTALLER"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}"
sleep 1

# Step 1: Update & install dependencies
echo -e "${yellow}[+] Installing required packages...${nc}"
pkg update -y && pkg upgrade -y
pkg install curl wget unzip jq termux-api -y

# Step 2: Download and extract the panel ZIP
echo -e "${yellow}[+] Downloading panel ZIP from GitHub...${nc}"
wget -q https://github.com/ademlo1545bobby/adem1545/archive/refs/heads/main.zip -O adem1545.zip

if [ -f "adem1545.zip" ]; then
  echo -e "${green}[✓] ZIP downloaded successfully.${nc}"
  unzip -o adem1545.zip > /dev/null
  rm -f adem1545.zip
  mv adem1545-main adem1545
else
  echo -e "${red}[X] Failed to download ZIP file.${nc}"
  exit 1
fi

# Step 3: Set permission and launch
cd adem1545 || { echo -e "${red}[X] Cannot enter folder!${nc}"; exit 1; }
chmod +x adem1545.sh

echo -e "${blue}→ Starting ADEM1545 Panel...${nc}"
bash adem1545.sh
