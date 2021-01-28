#!/bin/bash

# Simple bash script to quickly activate / deactivate proxy on macOS
# maherod@gmail.com

proxy_host="127.0.0.1" 
proxy_port="8080"
interface="wi-fi"
GREEN="\033[1;32m"
RESET="\033[0m"

function proxy_on {
  echo -e "${GREEN}Setting proxy servers to $proxy_host port $proxy_port on interface $interface"${RESET}
  sudo networksetup -setwebproxy $interface $proxy_host $proxy_port
  sudo networksetup -setstreamingproxy $interface $proxy_host $proxy_port
  sudo networksetup -setsecurewebproxy $interface $proxy_host $proxy_port
  echo -e "${GREEN}Activating proxy servers on $interface"${RESET}
  sudo networksetup -setstreamingproxystate $interface on
  sudo networksetup -setwebproxystate $interface on
  sudo networksetup -setsecurewebproxystate $interface on
}

function proxy_off {
  echo -e "${GREEN}Turning off proxy on $interface interface"${RESET}
  sudo networksetup -setstreamingproxystate $interface off
  sudo networksetup -setwebproxystate $interface off
  sudo networksetup -setsecurewebproxystate $interface off
}

function show_settings {
 echo -e "${GREEN}Proxy settings:"${RESET}
 networksetup -getwebproxy $interface
 echo -e "${GREEN}Secure proxy settings:"${RESET}
 networksetup -getsecurewebproxy $interface
}

case "$1" in
  enable) proxy_on ;;
  disable) proxy_off ;;
  show) show_settings ;;
  *)
    echo $ "Usage: $0 {enable|disable|show}"
esac
