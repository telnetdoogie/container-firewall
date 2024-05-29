#!/bin/sh

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Set default policies to ACCEPT
iptables-legacy -P INPUT ACCEPT
iptables-legacy -P FORWARD ACCEPT
iptables-legacy -P OUTPUT ACCEPT

# Allow traffic from 'firewall' container to 'test' container
iptables-legacy -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 127.0.0.1:8080
iptables-legacy -t nat -A POSTROUTING -j MASQUERADE

# Log traffic for debugging (optional)
iptables-legacy -A FORWARD -j LOG --log-prefix "IPTables-Forward: " --log-level 4

