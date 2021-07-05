#!/bin/sh
IPT="/sbin/iptables"

# Reset policies and flush old rules
$IPT -P INPUT ACCEPT
$IPT -P FORWARD ACCEPT
$IPT -P OUTPUT ACCEPT
$IPT -t nat --flush
$IPT -t mangle --flush
$IPT --flush
$IPT --delete-chain


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


## HAProxy Stats Port
#####################

# Allow HAProxy Stats (TCP port 6080)
$IPT -A INPUT -p tcp -m tcp --dport 6080 -j ACCEPT


## Consul Client Ports
######################

# Allow Consul LAN Serf on TCP and UDP Ports 8301
$IPT -A INPUT -p udp -m udp --dport 8301 -j ACCEPT
$IPT -A INPUT -p tcp -m tcp --dport 8301 -j ACCEPT


## Webhook Ports
################

# Allow webhook port (TCP port 9000)
$IPT -A INPUT -p tcp -m tcp --dport 9000 -j ACCEPT


## HTTP/HTTPS Ports
###################

# Allow HTTP Port 80 and HTTPS Port 443
$IPT -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
$IPT -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT


## TCP Ports
############

## CONSUL-TEMPLATE WILL POPULATE THIS PART
