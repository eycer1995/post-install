#! /bin/bash

# interfaces config
echo "auto enp2s0" >> /etc/network/interfaces
echo "iface enp2s0 inet static" >> /etc/network/interfaces
echo "address 192.168.0.126" >> /etc/network/interfaces
echo "gateway 192.168.0.1" >> /etc/network/interfaces
echo "netmask 255.255.255.0" >> /etc/network/interfaces
echo "dns-nameservers 8.8.8.8 8.8.4.4" >> /etc/network/interfaces

# resolvconf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
systemctl restart networking.service

# avoid suspension
echo "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf
echo "HandleLidSwitchExternalPower=ignore" >> /etc/systemd/logind.conf
systemctl restart systemd-logind.service

apt update -y && upgrade -y

apt install vim git rsync screen podman sudo -y

