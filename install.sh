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
pkg install curl git wget python jq termux-api -y

# Step 2: Clone the repository
if [ -d "adem1545" ]; then
  echo -e "${yellow}[!] Existing folder found. Removing...${nc}"
  rm -rf adem1545
fi

echo -e "${green}[✓] Downloading adem1545 panel...${nc}"
git clone https://github.com/ademlo1545bobby/adem1545

# Step 3: Set permissions and enter folder
cd adem1545 || { echo -e "${red}[X] Failed to enter directory!${nc}"; exit 1; }
chmod +x adem1545.sh

# Step 4: Start the panel automatically
echo -e "${blue}→ Launching ADEM1545 Panel...${nc}"
bash adem1545.sh
