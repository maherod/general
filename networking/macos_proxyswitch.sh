#!/bin/bash

# bash script to quickly activate / deactivate proxy on macOS
# maherod@gmail.com

proxy_host="127.0.0.1" 
proxy_port="8080"
interface="wi-fi"
GREEN="\033[1;32m"
RESET="\033[0m"

function proxy_on {
  echo -e "${GREEN}Setting proxy servers to $proxy_host port $proxy_port on interface $interface${RESET}"
  for proxy_type in webproxy streamingproxy securewebproxy; do
    sudo networksetup -set${proxy_type} $interface $proxy_host $proxy_port
    sudo networksetup -set${proxy_type}state $interface on
  done
}

function proxy_off {
  echo -e "${GREEN}Turning off proxy on $interface interface${RESET}"
  for proxy_type in streamingproxystate webproxystate securewebproxystate; do
    sudo networksetup -set${proxy_type} $interface off
  done
}

function show_settings {
  echo -e "${GREEN}Proxy settings:${RESET}"
  networksetup -getwebproxy $interface
  echo -e "${GREEN}Secure proxy settings:${RESET}"
  networksetup -getsecurewebproxy $interface
}

case "$1" in
  enable) proxy_on ;;
  disable) proxy_off ;;
  show) show_settings ;;
  *)
    echo $ "Usage: $0 {enable|disable|show}"
esac
