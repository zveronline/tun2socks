#!/bin/sh
sleep 2
ifconfig eth0 down
sleep 2
ifconfig eth0 up
ip tuntap add mode tun dev tun0
ip addr add 198.18.0.1/15 dev tun0
ip link set dev tun0 up
sleep 2
ifconfig tun0 down
sleep 2
ifconfig tun0 up
ip route del default
ip route add default via 198.18.0.1 dev tun0 metric 1
ip route add default via 10.2.0.1 dev eth0 metric 100
ip route add 10.2.0.0/16 via 10.2.0.1 dev eth0
tun2socks -device tun0 -proxy socks5://10.2.0.101:1080 -interface eth0
