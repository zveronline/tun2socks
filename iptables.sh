#!/bin/bash
#echo 1 > /proc/sys/net/ipv4/ip_forward
IPT=/sbin/iptables
PUB_IF=eth0
$IPT -F
$IPT -t nat -F
$IPT -t nat -A POSTROUTING -o $PUB_IF -j MASQUERADE
$IPT -t nat -A POSTROUTING -j MASQUERADE
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A INPUT -m state ! --state NEW -i $PUB_IF -j ACCEPT
$IPT -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -m state ! --state NEW -i $PUB_IF -j ACCEPT
$IPT -A FORWARD -i $PUB_IF -j ACCEPT
