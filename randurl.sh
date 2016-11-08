#!/usr/bin/env bash

# METHODS

CURL_POST="/usr/bin/curl -s -H 'X-Forwarded-for: 1.2.3.4' -A 'iMacAppStore/1.0.1 (Macintosh; U; Intel Mac OS X 10.6.7; en) AppleWebKit/533.20.25' -si -X POST"
CURL_GET="/usr/bin/curl -s -H 'X-Forwarded-for: 1.2.3.4' -A 'iMacAppStore/1.0.1 (Macintosh; U; Intel Mac OS X 10.6.7; en) AppleWebKit/533.20.25' -si"  

# COLORS
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
BOLD="\033[1m"
RESET="\033[0m"

echo -e "${YELLOW}-----------------------------------------------"${RESET}
echo -e "${BOLD}This script generates random params to site"
echo -e "to utilize and test it's caching capablities"
echo -e "${YELLOW}-----------------------------------------------"${RESET}
read -p "Enter FQDN: " WEB
read -p "Base URI: " BURI
read -p "Number of Requests: " QUAN
read -p  "Enter (1) for GET Requests or (2) for POST Requests: " METHOD

function GEN {
 cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n $QUAN > /tmp/$WEB
}

function GET {
 clear
  echo -e "${YELLOW}------------------------------------"${RESET}
  echo -e "${BOLD}Testing $WEB with GET Method"
  echo -e "Total: $QUAN Requests"
  echo -e "Base URI : $BURI"
  echo -e "HIT CTRL+C to Stop"${RESET}
  echo -e "${YELLOW}------------------------------------"${RESET}
  for i in `cat /tmp/$WEB`
   do $CURL_GET ${WEB}"/"${BURI}"/"$i > /dev/null ;
  done
}

function POST {
 clear
  echo -e "${YELLOW}------------------------------------"${RESET}
  echo -e "${BOLD}Testing $WEB with POST Method"
  echo -e "Total: $QUAN Requests"
  echo -e "Base URI : $BURI"
  echo -e "HIT CTRL+C to Stop"${RESET}
  echo -e "${YELLOW}------------------------------------"${RESET}
  for i in `cat /tmp/$WEB`
   do $CURL_POST ${WEB}"/"${BURI}"/"$i > /dev/null ;
  done
}

if [ -z "$WEB" ]
 then
   clear
   echo -e "${YELLOW}------------------------------"${RESET}
   echo -e "${RED}No Site Provided, Quitting"${RESET}
   echo -e "${YELLOW}------------------------------"${RESET}
   exit 1
fi

if [ -z "$METHOD" ]
 then
   clear
   echo -e "${YELLOW}--------------------------------"${RESET}
   echo -e "${RED}No Method Provided, Quitting"${RESET}
   echo -e "${YELLOW}--------------------------------"${RESET}
   exit 1
fi

if [ -z "$BURI" ]
 then
   clear
   echo -e "${YELLOW}--------------------------------"${RESET}
   echo -e "${RED}No BURI Provided, Quitting"${RESET}
   echo -e "${YELLOW}--------------------------------"${RESET}
   exit 1
fi

if [ -z "$QUAN" ]
 then
   clear
   echo -e "${YELLOW}--------------------------------"${RESET}
   echo -e "${RED}No Quantity Provided, Quitting"${RESET}
   echo -e "${YELLOW}--------------------------------"${RESET}
   exit 1
fi

# Calling GEN Function
GEN


# Calling Web Script
if [ $METHOD = "1" ]; then
  GET 
else
  POST
fi

# Deleting Output files
rm /tmp/$WEB
