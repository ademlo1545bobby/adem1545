#!/data/data/com.termux/files/usr/bin/bash

cyan='\033[1;36m'
nc='\033[0m'

function logo() {
  clear
  echo -e "$cyan"
  echo "   [1;36m▄▄▄▄▄   ▄▄▄▄   ▓█████ ▄▄▄▄   ▄▄▄▄▄"
  echo "   ██████ ▓█████ ▒█▀▀█ ██████ ▓█████"
  echo "   █▄▀▀▄█ ▒█░░░░ ▒█░░░ █▄▀▀▄█ ▒█░░░░"
  echo "   ▀▀▀▀▀  ░▀▀▀▀  ░▀▀▀▀ ▀▀▀▀▀  ░▀▀▀▀ "
  echo "       >> ꪖᦔꫀꪑ⛏️ -  1 5 4 5 <<"
  echo -e "$nc"
}

# Twilio bilgilerini ayarla
TWILIO_SID="AC4f712d02cba9f1b36a0b28d6e394415d"
TWILIO_AUTH_TOKEN="db4162b7e884be44ee412a4791286b10"
TWILIO_PHONE_NUMBER="+17153331869"

function send_custom_sms() {
  logo
  read -p "Enter country code (e.g. +90): " code
  read -p "Enter phone number (e.g. 5551234567): " number
  read -p "Enter message: " message
  full_number="${code}${number}"

  response=$(curl -s -X POST "https://api.twilio.com/2010-04-01/Accounts/$TWILIO_SID/Messages.json" \
    --data-urlencode "To=$full_number" \
    --data-urlencode "From=$TWILIO_PHONE_NUMBER" \
    --data-urlencode "Body=$message" \
    -u "$TWILIO_SID:$TWILIO_AUTH_TOKEN")

  echo "$response" | grep -q '"status":' && echo "[✓] Message sent!" || echo "[X] Failed to send!"
  read -p "Press Enter to continue..."
}

function send_verification_spam() {
  logo
  read -p "Enter country code (e.g. +90): " code
  read -p "Enter phone number (e.g. 5551234567): " number
  read -p "How many messages to send?: " amount
  full_number="${code}${number}"

  for ((i=1; i<=amount; i++)); do
    code=$(shuf -i 100000-999999 -n 1)
    msg="Your verification code is: $code"
    curl -s -X POST "https://api.twilio.com/2010-04-01/Accounts/$TWILIO_SID/Messages.json" \
      --data-urlencode "To=$full_number" \
      --data-urlencode "From=$TWILIO_PHONE_NUMBER" \
      --data-urlencode "Body=$msg" \
      -u "$TWILIO_SID:$TWILIO_AUTH_TOKEN" > /dev/null

    echo "[$i/$amount] Sent code: $code"
    sleep 1
  done

  echo "[✓] Done sending verification codes."
  read -p "Press Enter to continue..."
}

function ip_info() {
  logo
  read -p "Enter IP address: " ip
  curl -s "http://ip-api.com/json/$ip" | jq . | head -n 15
  read -p "Press Enter to continue..."
}

function port_scan() {
  logo
  read -p "Enter target IP: " target
  for port in 21 22 23 25 53 80 443 3306 8080; do
    timeout 1 bash -c "echo >/dev/tcp/$target/$port" 2>/dev/null &&
    echo "Port $port is open" ||
    echo "Port $port is closed"
  done
  read -p "Press Enter to continue..."
}

function whois_tool() {
  logo
  read -p "Enter domain name (e.g. google.com): " domain
  whois $domain | head -n 20
  read -p "Press Enter to continue..."
}

function admin_finder() {
  logo
  read -p "Enter website (include https://): " site
  paths=("admin" "admin/login" "administrator" "adminpanel" "admin-area" "cpanel" "login" "admin1" "admin2")
  for path in "${paths[@]}"; do
    url="$site/$path"
    status=$(curl -o /dev/null -s -w "%{http_code}" "$url")
    [[ "$status" == "200" ]] && echo "[+] Found: $url" || echo "[-] Not found: $url"
  done
  read -p "Press Enter to continue..."
}

function md5_cracker() {
  logo
  read -p "Enter MD5 hash: " hash
  results=$(curl -s "https://md5.gromweb.com/?md5=$hash")
  if echo "$results" | grep -q '<em class="long-content string">'; then
    echo -n "Result: "
    echo "$results" | grep -A1 '<em class="long-content string">' | tail -n1 | sed 's/<[^>]*>//g'
  else
    echo "No result found!"
  fi
  read -p "Press Enter to continue..."
}

function system_info() {
  logo
  echo "[+] User: $(whoami)"
  echo "[+] UID/GID: $(id)"
  echo "[+] System Info: $(uname -a)"
  read -p "Press Enter to continue..."
}

function calendar_time() {
  logo
  date
  cal | head -n 8
  read -p "Press Enter to continue..."
}

function wifi_info() {
  logo
  termux-wifi-connectioninfo | jq .
  read -p "Press Enter to continue..."
}

function internet_check() {
  logo
  if curl -s https://www.google.com > /dev/null; then
    echo "Internet connection is active!"
  else
    echo "No internet connection!"
  fi
  read -p "Press Enter to continue..."
}

# Ana Menü
while true; do
  logo
  echo -e "${cyan}1.${nc} Send Custom SMS"
  echo -e "${cyan}2.${nc} Send Verification Code Spam"
  echo -e "${cyan}3.${nc} IP Info"
  echo -e "${cyan}4.${nc} Port Scanner"
  echo -e "${cyan}5.${nc} Whois Tool"
  echo -e "${cyan}6.${nc} Admin Panel Finder"
  echo -e "${cyan}7.${nc} MD5 Hash Cracker"
  echo -e "${cyan}8.${nc} System Info"
  echo -e "${cyan}9.${nc} Calendar & Time"
  echo -e "${cyan}10.${nc} WiFi Info"
  echo -e "${cyan}11.${nc} Internet Check"
  echo -e "${cyan}12.${nc} Exit"
  echo
  read -p "Enter your choice: " choice
  case $choice in
    1) send_custom_sms ;;
    2) send_verification_spam ;;
    3) ip_info ;;
    4) port_scan ;;
    5) whois_tool ;;
    6) admin_finder ;;
    7) md5_cracker ;;
    8) system_info ;;
    9) calendar_time ;;
    10) wifi_info ;;
    11) internet_check ;;
    12)
      echo -e "${cyan}Exiting panel... Take care, friend.${nc}"
      exit
      ;;
    *) echo "Invalid selection!" && sleep 1 ;;
  esac
done