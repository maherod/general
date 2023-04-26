#!/usr/bin/env bash

# Variables
USER_AGENT="iMacAppStore/1.0.1 (Macintosh; U; Intel Mac OS X 10.6.7; en) AppleWebKit/533.20.25"
IP_ADDRESS="1.2.3.4"
OUTPUT_FILE="randtmp.txt"

# Colors
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
BOLD="\033[1m"
RESET="\033[0m"

# Functions
gen_params() {
  # Generates random parameters and writes them to a file
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n "$QUANTITY" > "$OUTPUT_FILE"
}

send_requests() {
  # Sends HTTP requests to the specified endpoint with the specified method
  local method="$1"
  printf "${YELLOW}------------------------------------${RESET}\n"
  printf "${BOLD}Testing %s with %s Method\n" "$ENDPOINT" "$method"
  printf "Total: %d Requests\n" "$QUANTITY"
  printf "Base URI: %s\n" "$BASE_URI"
  printf "HIT CTRL+C to Stop\n${RESET}"
  printf "${YELLOW}------------------------------------${RESET}\n"
  gen_params
  sleep 2
  count=0
  while read -r param; do
    # Send the request and redirect output to /dev/null
    /usr/bin/curl -s \
      -H "X-Forwarded-for: $IP_ADDRESS" \
      -A "$USER_AGENT" \
      -s${method:0:1} \
      -X "$method" \
      "$ENDPOINT/$BASE_URI/$param" \
      >/dev/null || {
        printf "${RED}Error: Failed to send %s request\n${RESET}" "$method"
        exit 1
      }
    count=$((count+1))
    progress=$((count*100/QUANTITY))
    printf "Progress: [%-20s] %d%%\r" "$(printf "${GREEN}"; printf '%*s' $((progress/5)) '' | tr ' ' '='; printf "${RESET}")" "$progress"
    sleep 0.1
  done <"$OUTPUT_FILE"
  rm -f "$OUTPUT_FILE"
}

# Main script
printf "${YELLOW}-----------------------------------------------${RESET}\n"
printf "${BOLD}This script generates random params to site\n"
printf "to utilize and test its caching capabilities\n"
printf "${YELLOW}-----------------------------------------------${RESET}\n"

# Read user input
read -rp "Enter FQDN: " ENDPOINT
read -rp "Base URI: " BASE_URI
read -rp "Number of Requests: " QUANTITY
read -rp "Enter GET, POST, or HEAD: " METHOD

# Validate user input
if [[ -z "$ENDPOINT" ]]; then
  printf "${YELLOW}------------------------------${RESET}\n"
  printf "${RED}No Site Provided, Quitting${RESET}\n"
  printf "${YELLOW}------------------------------${RESET}\n"
  exit 1
fi

if [[ -z "$METHOD" ]]; then
  printf "${YELLOW}--------------------------------${RESET}\n"
  printf "${RED}No Method Provided, Quitting${RESET}\n"
  printf "${YELLOW}--------------------------------${RESET}\n"
  exit 1
fi

# Call the send_requests function with the specified method
case "$METHOD" in
  GET | POST | HEAD)
    send_requests "$METHOD"
    ;;
  *)
    printf "${YELLOW}----------------------------------${RESET}\n"
    printf "${RED}Invalid Method: %s${RESET}\n" "$METHOD"
    printf "${YELLOW}----------------------------------${RESET}\n"
    exit 1
    ;;
esac

printf "${YELLOW}-----------------------------------------------${RESET}\n"
printf "${BOLD}Finished${RESET}\n"
printf "${YELLOW}-----------------------------------------------${RESET}\n"


