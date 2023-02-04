#! /bin/bash
#
# Post Install after cloning a Debian VM on Proxmox

# Update and install packages
apt update -y && apt upgrade -y
apt install vim git screen rsync sudo -y
usermod -aG sudo eycer

# Give a new VM name
read -p "What is the hostname?: " NEW_HOSTNAME
echo $NEW_HOSTNAME > /etc/hostname

sed -i "s/deb01/$NEW_HOSTNAME/g" /etc/hosts

# Give a new IP
read -p "What is the new IP address?: " NEW_IP
sed -i "s/192.168.0.16/$NEW_IP/g" /etc/network/interfaces

ifdown ens18
ifup ens18

# Reset the machine ID
rm -f /etc/machine-id /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
dbus-uuidgen --ensure

# Regenerate ssh keys
sudo rm /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server

# Verify everything is ok and reboot
