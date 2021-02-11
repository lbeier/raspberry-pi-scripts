#!/usr/bin/env bash

# This will allow ipv4 traffic to be forwarded
sudo /bin/su -c "echo -e '\n#Enable IP Routing\nnet.ipv4.ip_forward = 1' > /etc/sysctl.conf"

# Enabling NAT on the Pi. 
sudo iptables -t nat -A POSTROUTING -o nordlynx -j MASQUERADE

# eth0 traffic will go over nordlynx tunnel (tun0 if openvpn)
sudo iptables -A FORWARD -i eth0 -o nordlynx -j ACCEPT

# Allow traffic to from tun0 to back to eth0. RELATED,ESTABLISHED mean only traffic that is know / already active.
sudo iptables -A FORWARD -i nordlynx -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Pi's own loopback traffic.
sudo iptables -A INPUT -i lo -j ACCEPT

# Allows you to ping the Raspberry Pi.
sudo iptables -A INPUT -i eth0 -p icmp -j ACCEPT

# Allows SSH from the internal network.
sudo iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT

# Allows all traffic ESTABLISHED or RELATED to come back. 
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Traffic that does not match any of the above will get dropped. Do this carefully otherwise you lock yourself out of SSH. If this happens, reboot your pi (pull the plug) and restart.
sudo iptables -P FORWARD DROP
sudo iptables -P INPUT DROP

# Save iptables
sudo apt-get install iptables-persistent -y
sudo systemctl enable netfilter-persistent
