#!/bin/bash
ip=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

IFS=','
read -a lport <<< "$LISTEN_PORT"
read -a lproto <<< "$LISTEN_PROTO"
read -a ftport <<< "$TARGET_PORT"

echo "iptables -t nat -F FORWARDER 2> /dev/null || ( iptables -t nat -N FORWARDER && iptables -t nat -I PREROUTING 1 -m addrtype --dst-type LOCAL -j FORWARDER && iptables -t nat -I OUTPUT 1 ! -d 127.0.0.0/8 -m addrtype --dst-type LOCAL -j FORWARDER )"

size=${#lport[@]}
for ((x=0; x < $size ; x++)); do
	echo iptables -t nat -A FORWARDER -p ${lproto[$x]} --dport ${lport[$x]} -j DNAT --to ${ip}:${ftport[$x]}
done

echo iptables -t nat -A FORWARDER -j RETURN

