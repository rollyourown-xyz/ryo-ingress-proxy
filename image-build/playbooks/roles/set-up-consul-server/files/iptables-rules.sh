#!/bin/sh
IPT="/sbin/iptables"

# By default, drop everything except outgoing traffic
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT ACCEPT


## General Rules
################

# Allow incoming and outgoing for loopback interfaces
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# ICMP rule
$IPT -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# Allow established connections:
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


## Consul Ports
###############

# Allow Consul DNS server on TCP and UDP Ports 8600
$IPT -A INPUT -p udp -m udp --dport 8600 -j ACCEPT
$IPT -A INPUT -p tcp -m tcp --dport 8600 -j ACCEPT

# Allow Consul HTTP API on TCP Port 8500
$IPT -A INPUT -p tcp -m tcp --dport 8500 -j ACCEPT

# Allow Consul LAN Serf on TCP and UDP Ports 8301
$IPT -A INPUT -p udp -m udp --dport 8301 -j ACCEPT
$IPT -A INPUT -p tcp -m tcp --dport 8301 -j ACCEPT

# Allow Consul WAN Serf on TCP and UDP Ports 8302
$IPT -A INPUT -p udp -m udp --dport 8302 -j ACCEPT
$IPT -A INPUT -p tcp -m tcp --dport 8302 -j ACCEPT

# Allow Consul Server RCP on TCP Port 8300
$IPT -A INPUT -p tcp -m tcp --dport 8300 -j ACCEPT

