#!/bin/sh

# Directly use the legacy iptables binary
IPTABLES='/sbin/iptables-legacy'

# Default policy to drop all traffic
$IPTABLES -P INPUT DROP
$IPTABLES -P FORWARD DROP
$IPTABLES -P OUTPUT DROP

# Allow traffic from/to the container itself
$IPTABLES -A INPUT -i lo -j ACCEPT
$IPTABLES -A OUTPUT -o lo -j ACCEPT

# Allow established and related traffic
$IPTABLES -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow traffic from the LAN to the container
$IPTABLES -A INPUT -s 192.168.0.0/24 -j ACCEPT

# Allow the container to respond to internet traffic but block new traffic to the LAN
$IPTABLES -A INPUT -p tcp --dport 99 -j ACCEPT  
$IPTABLES -A OUTPUT -p tcp --sport 99 -d 192.168.0.0/24 -j ACCEPT

# Allow traffic to and from the gateway
$IPTABLES -A INPUT -s 192.168.0.1 -j ACCEPT
$IPTABLES -A OUTPUT -d 192.168.0.1 -j ACCEPT

# Log dropped packets (optional)
$IPTABLES -A INPUT -j LOG --log-prefix "iptables: "
$IPTABLES -A OUTPUT -j LOG --log-prefix "iptables: "

# Keep the container running
tail -f /dev/null

