#!/bin/bash
# Preparacion de WEB-CAJA (10.13.25.147) y WEB-INVENTARIO (10.13.25.148)
# Uso: sudo ./web_setup.sh WEB-CAJA 147   |   sudo ./web_setup.sh WEB-INVENTARIO 148
set -e
HOST=$1; IP=$2
hostnamectl set-hostname "$HOST"
sed -i "s/^127.0.1.1 .*/127.0.1.1 $HOST/" /etc/hosts

tee /etc/netplan/01-lab.yaml > /dev/null <<NET
network:
  version: 2
  ethernets:
    ens3:
      addresses: [10.13.25.$IP/28]
      routes:
        - to: default
          via: 10.13.25.145
      nameservers:
        addresses: [10.13.25.145]
NET
chmod 600 /etc/netplan/01-lab.yaml
netplan apply

# Apache + PHP + cliente MySQL (llegan por la politica DMZ-UPDATES)
NEEDRESTART_MODE=a apt update
NEEDRESTART_MODE=a apt install -y apache2 php libapache2-mod-php php-mysql

# Copiar el index.php correspondiente (web-caja_index.php o web-inventario_index.php)
# a /var/www/html/index.php antes de recargar Apache
a2ensite 000-default
a2dissite default-ssl || true
systemctl reload apache2

# SSH con contrasena para la administracion desde la VLAN 20
echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config.d/01-lab.conf
systemctl restart ssh
curl http://localhost/
