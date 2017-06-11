#!/bin/bash

DEV="bond0"
_TC="/sbin/tc"
BW="4000mbit"
U32="$_TC filter add dev $DEV protocol ip parent 1:0 prio 1 u32"
DPORT="443"
PID="/var/run/limiter.pid"

function setl {
  $_TC qdisc add dev $DEV root handle 1: htb default 30
  $_TC class add dev $DEV parent 1: classid 1:1 htb rate $BW
  $U32 match ip dport $DPORT 0xffff flowid 1:1
  echo "bandwidth limiter is running" > $PID
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
  echo "Bandwidth Limited to $BW on dport $DPORT"
  ;;

  stop)
  nol
        echo "Stopped Bandwidth limiter"
  ;;

  status)
  clear
  for i in {1..2} ; do showl ; sleep 1 ; clear ; done
  ;;

  *)
    echo $"Usage: $0 {start|stop|status}"
    exit 1
esac
