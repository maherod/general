#!/usr/bin/env bash

# COLORS
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
BOLD="\033[1m"
RESET="\033[0m"

echo -e "${YELLOW}------------------------------------------------------"${RESET}
echo -e "${BOLD}This script generates random strings output to a file"
echo -e "${YELLOW}------------------------------------------------------"${RESET}
echo ""
#read -p "Please enter output file: " FILE
read -p "Please enter Quantity: " QUAN

function GEN {
 cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8| head -n $QUAN
}


#GEN > $FILE
GEN
