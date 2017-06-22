#!/bin/bash

DEV="bond0"
_TC="/sbin/tc"
BW="4000mbit"
U32="$_TC filter add dev $DEV protocol ip parent 1:0 prio 1 u32"
DPORT="443"
PID="/var/run/limiter.pid"

function setl {
  if [ -f $PID ] ; then
   echo "Bandwidth limiter already running with $BW set on port $DPORT"
 else
  $_TC qdisc add dev $DEV root handle 1: htb default 30
  $_TC class add dev $DEV parent 1: classid 1:1 htb rate $BW
  $U32 match ip dport $DPORT 0xffff flowid 1:1
  touch $PID
fi
}

function nol {
  $_TC qdisc del dev $DEV root
  rm $PID
}

function showl {
  if [ -f $PID ] ; then
    $_TC -s -d class show dev $DEV
  else
    echo "bandwidth limiter not running"
 fi
}

case "$1" in
  start)
  setl
  echo "Bandwidth Limiter is set to BW: $BW on DPORT $DPORT"
  ;;

  stop)
  nol
        echo "Stopping Bandwidth limiter"
  sleep 1
  ;;

  status)
  showl 
  ;;

  *)
    echo $"Usage: $0 {start|stop|status}"
    exit 1
esac
