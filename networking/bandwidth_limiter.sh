#!/bin/bash

# Variables
DEV="bond0"
TC="/sbin/tc"
BW="4000mbit"
U32="$TC filter add dev $DEV protocol ip parent 1:0 prio 1 u32"
DPORT="443"
PID="/var/run/limiter.pid"

# Functions
setl() {
  if [ -f "$PID" ]; then
    echo "Bandwidth limiter already running with $BW set on port $DPORT"
  else
    $TC qdisc add dev "$DEV" root handle 1: htb default 30
    $TC class add dev "$DEV" parent 1: classid 1:1 htb rate "$BW"
    $U32 match ip dport "$DPORT" 0xffff flowid 1:1
    touch "$PID"
  fi
}

nol() {
  $TC qdisc del dev "$DEV" root
  rm "$PID"
}

showl() {
  if [ -f "$PID" ]; then
    $TC -s -d class show dev "$DEV"
  else
    echo "Bandwidth limiter not running"
  fi
}

# Main
case "$1" in
  start)
    setl
    echo "Bandwidth limiter is set to BW: $BW on DPORT $DPORT"
    ;;
  stop)
    nol
    echo "Stopping bandwidth limiter"
    ;;
  status)
    showl
    ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    exit 1
esac

