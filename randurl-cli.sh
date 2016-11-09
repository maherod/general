#!/usr/bin/env bash

# METHODS

CURL_POST="/usr/bin/curl -s -H 'X-Forwarded-for: 1.2.3.4' -A 'iMacAppStore/1.0.1 (Macintosh; U; Intel Mac OS X 10.6.7; en) AppleWebKit/533.20.25' -si -X POST"
CURL_GET="/usr/bin/curl -s -H 'X-Forwarded-for: 1.2.3.4' -A 'iMacAppStore/1.0.1 (Macintosh; U; Intel Mac OS X 10.6.7; en) AppleWebKit/533.20.25' -si"  
CURL_HEAD="/usr/bin/curl -s -H 'X-Forwarded-for: 1.2.3.4' -A 'iMacAppStore/1.0.1 (Macintosh; U; Intel Mac OS X 10.6.7; en) AppleWebKit/533.20.25' -sI"  

# VARS

GFILE="/tmp/$1"

WEB=$1
BURI=$2
QUAN=$3
METHOD=$4

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
BOLD="\033[1m"
RESET="\033[0m"

# Begin

echo -e "${YELLOW}-----------------------------------------------"${RESET}
echo -e "${BOLD}This script generates random params to site"
echo -e "to utilize and test it's caching capablities"
echo -e ""
echo -e "Usage: COMMAND FQDN URI QUAN METHOD (GET/POST/HEAD)"
echo -e "${YELLOW}-----------------------------------------------"${RESET}

function GEN {
 cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n $QUAN > $GFILE
}

function GET {
 clear
  echo -e "${YELLOW}------------------------------------"${RESET}
  echo -e "${BOLD}Testing $WEB with GET Method"
  echo -e "Total: $QUAN Requests"
  echo -e "Base URI: $BURI"
  echo -e "HIT CTRL+C to Stop"${RESET}
  echo -e "${YELLOW}------------------------------------"${RESET}
  GEN
  for i in `cat $GFILE`
   do $CURL_GET ${WEB}"/"${BURI}"/"$i > /dev/null ;
  done
}

function GETS {
 clear
  echo -e "${YELLOW}------------------------------------"${RESET}
  echo -e "${BOLD}Testing $WEB with GET Method"
  echo -e "Total: $QUAN Requests"
  echo -e "HIT CTRL+C to Stop"${RESET}
  echo -e "${YELLOW}------------------------------------"${RESET}
  for i in $(seq 1 $QUAN) 
   do $CURL_GET ${WEB}"/"${QUAN} > /dev/null ;
  done
}

function POST {
 clear
  echo -e "${YELLOW}------------------------------------"${RESET}
  echo -e "${BOLD}Testing $WEB with POST Method"
  echo -e "Total: $QUAN Requests"
  echo -e "Base URI: $BURI"
  echo -e "HIT CTRL+C to Stop"${RESET}
  echo -e "${YELLOW}------------------------------------"${RESET}
  GEN
  for i in `cat $GFILE`
   do $CURL_POST ${WEB}"/"${BURI}"/"$i > /dev/null ;
  done
}

function HEAD {
 clear
  echo -e "${YELLOW}------------------------------------"${RESET}
  echo -e "${BOLD}Testing $WEB with HEAD Method"
  echo -e "Total: $QUAN Requests"
  echo -e "Base URI: $BURI"
  echo -e "HIT CTRL+C to Stop"${RESET}
  echo -e "${YELLOW}------------------------------------"${RESET}
  GEN
  for i in `cat $GFILE`
   do $CURL_HEAD ${WEB}"/"${BURI}"/"$i > /dev/null ;
  done
}

# Calling Web Function
if [ "$METHOD" == "GET" ]; then
 GET
fi

if [ "$METHOD" == "POST" ]; then
 POST 
fi

if [ "$METHOD" == "HEAD" ]; then
 HEAD 
fi

if [ "$METHOD" == "STATIC" ]; then
 GETS 
fi

# Deleting Output files
if [ -f $GFILE ]; then
 rm $GFILE
fi
