#!/data/data/com.termux/files/usr/bin/bash

clear
echo -e "\e[96m"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "      ADEM1545 INSTALLATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 1

# Install required packages
echo -e "\e[93m→ Installing required packages...\e[0m"
pkg update -y
pkg upgrade -y
pkg install curl git wget python jq termux-api -y

# Clone the project from GitHub
echo -e "\e[92m→ Downloading project from GitHub...\e[0m"
git clone https://github.com/ademlo1545bobby/adem1545

# Enter the directory and give execution permission
cd adem1545
chmod +x install.sh

# Launch the main script
echo -e "\e[94m→ Starting ADEM1545...\e[0m"
bash install.sh
