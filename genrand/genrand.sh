#!/usr/bin/env bash

# Define color codes
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
BOLD="\033[1m"
RESET="\033[0m"

# Print header message
echo -e "${YELLOW}------------------------------------------------------"${RESET}
echo -e "${BOLD}This script generates random strings output to a file"
echo -e "${YELLOW}------------------------------------------------------"${RESET}
echo ""

# Prompt user for quantity of random strings to generate
read -p "Please enter Quantity: " QUAN

# Define function to generate random strings
function GEN {
  # Use /dev/urandom as a source of random data, filter out non-alphanumeric characters,
  # wrap the output to 8 characters per line, and limit the output to the specified quantity
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8| head -n $QUAN
}

# Output generated strings to a file (uncomment the next line and set the FILE variable),
# or directly to the terminal (leave the line commented out)
# FILE="output.txt"
# GEN > $FILE
GEN
