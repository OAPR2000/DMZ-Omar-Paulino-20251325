#!/bin/bash
# Pruebas de la practica (ejecutar cada bloque en el equipo indicado)

# --- PC-USER (VLAN 10) ---
ip -br a                                   # 10.13.25.x/25
curl http://10.13.25.147                   # Sistema de Caja: funciona
w3m http://10.13.25.148                    # Pagina de bloqueo del FortiGate
ssh -o ConnectTimeout=5 ubuntu@10.13.25.147  # Timeout (DENY-SSH-USERS-to-DMZ)
nc -zv -w3 10.13.25.146 3306               # Timeout (P2-BLOCK-USERS-to-DB-3306)
ping -c3 8.8.8.8                           # Internet (P3-USERS-to-INTERNET)

# --- PC-ADMIN (VLAN 20) ---
ip -br a                                   # 10.25.13.x/25
ssh ubuntu@10.13.25.147                    # Entra (ADMIN-SSH-to-DMZ)
curl http://10.13.25.148                   # Sistema de Inventario (ADMIN-WEB-to-DMZ)

# --- WEB-CAJA (DMZ) ---
ping -c3 10.13.25.10                       # 100% perdida (DENY-DMZ-to-USERS)
ping -c3 10.25.13.10                       # 100% perdida (DENY-DMZ-to-ADMIN)
sudo apt update                            # Funciona (DMZ-UPDATES)
curl -m5 http://example.com                # Timeout (Implicit Deny)
ping -c3 8.8.8.8                           # Falla (Implicit Deny)
