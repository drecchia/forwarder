#!/bin/bash
iptables -t filter -A FORWARD -j ACCEPT

IFS=','
read -a lport <<< "$LISTEN_PORT"
read -a lproto <<< "$LISTEN_PROTO"
read -a ftarget <<< "$TARGET"
read -a ftport <<< "$TARGET_PORT"

size=${#lport[@]}
for ((x=0; x < $size ; x++)); do
        ip=$(ping -c 1 ${ftarget[$x]} | awk '/PING/ { print $3 }'| tr -d '():')
	iptables -t nat -A PREROUTING -p ${lproto[$x]} --dport ${lport[$x]} -j DNAT --to ${ip}:${ftport[$x]}
done

iptables -t nat -A POSTROUTING -j MASQUERADE
tail -f /dev/null
