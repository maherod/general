#!/usr/bin/env bash

DEV="eth0"
_TC="/sbin/tc"
BW="1mbit"
U32="$_TC filter add dev $DEV protocol ip parent 1:0 prio 1 u32"
DPORT="443"

function setl {
  $_TC qdisc add dev $DEV root handle 1: htb default 30
  $_TC class add dev $DEV parent 1: classid 1:1 htb rate $BW
  $U32 match ip dport $DPORT 0xffff flowid 1:1
}

function nol {
  $_TC qdisc del dev $DEV root
}

function showl {
  $_TC -s qdisc ls dev $DEV
}

case "$1" in
  start)
  setl
  echo "Bandwidth Limited to $BW on dport $DPORT"
  ;;

  stop)
  nol
        echo "Stopped Bandwidth Shaping"
  ;;

  status)
  clear
  for i in {1..8} ; do showl ; sleep 1 ; clear ; done
  ;;

  *)
    echo $"Usage: $0 {start|stop|status}"
    exit 1
esac
