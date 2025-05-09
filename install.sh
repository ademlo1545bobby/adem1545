#!/data/data/com.termux/files/usr/bin/bash

# Colors
readonly cyan='\033[1;36m'
readonly yellow='\033[1;33m'
readonly green='\033[1;32m'
readonly red='\033[1;31m'
readonly nc='\033[0m'

clear
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "        ADEM1545 INSTALLER"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${nc}"
sleep 1

# Update packages and install essentials
echo -e "${yellow}[!] Updating packages...${nc}"
pkg update -y && pkg upgrade -y
pkg install -y git curl wget

# Download the panel from GitHub
echo -e "${yellow}[!] Cloning panel from GitHub...${nc}"
cd $HOME
if [ -d "adem1545" ]; then
  echo -e "${yellow}[!] Removing old 'adem1545' folder...${nc}"
  rm -rf adem1545
fi

if git clone https://github.com/ademlo1545bobby/adem1545; then
  echo -e "${green}[✔] Panel downloaded successfully.${nc}"
else
  echo -e "${red}[✘] Failed to download the panel. Check the GitHub link.${nc}"
  exit 1
fi

# Enter directory and set permissions
cd adem1545 || { echo -e "${red}[✘] Failed to enter the 'adem1545' directory.${nc}"; exit 1; }

# Fix line endings if necessary
if command -v dos2unix >/dev/null 2>&1; then
  dos2unix adem1545.sh >/dev/null 2>&1
fi

chmod +x adem1545.sh

# Launch the panel
echo -e "${green}[✔] Launching panel...${nc}"
bash adem1545.sh || {
  echo -e "${red}[✘] Failed to start the panel.${nc}"
  exit 1
}
