#!/data/data/com.termux/files/usr/bin/bash

# Colors
cyan='\033[1;36m'
yellow='\033[1;33m'
green='\033[1;32m'
red='\033[1;31m'
nc='\033[0m'

clear
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "        ADEM1545 INSTALL SCRIPT"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}"
sleep 1

echo -e "${yellow}[+] Installing required packages...${nc}"
pkg update -y && pkg upgrade -y
pkg install -y git curl wget

# Clone your project
cd $HOME
[ -d "adem1545" ] && rm -rf adem1545

echo -e "${yellow}[+] Cloning GitHub repository...${nc}"
if git clone https://github.com/ademlo1545bobby/adem1545; then
  echo -e "${green}[✔] Repository cloned successfully.${nc}"
else
  echo -e "${red}[✘] Failed to clone repository. Check your URL.${nc}"
  exit 1
fi

# Run your script
cd adem1545 || { echo -e "${red}[✘] Cannot enter 'adem1545' folder.${nc}"; exit 1; }

chmod +x adem1545.sh
command -v dos2unix >/dev/null && dos2unix adem1545.sh
bash adem1545.sh || { echo -e "${red}[✘] Failed to run 'adem1545.sh'.${nc}"; exit 1; }
