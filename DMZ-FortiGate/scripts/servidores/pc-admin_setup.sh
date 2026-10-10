#!/bin/bash
# PC-ADMIN: nombre del equipo; la IP llega por DHCP desde la VLAN 20
sudo hostnamectl set-hostname PC-ADMIN
sudo sed -i 's/^127.0.1.1 .*/127.0.1.1 PC-ADMIN/' /etc/hosts
sudo netplan apply
ip -br a
ip route
