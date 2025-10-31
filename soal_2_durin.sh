#!/bin/bash
# 🔁 DHCP RELAY CONFIGURATION – Durin
# Prefix jaringan: 192.224

PREFIX="192.224"
DHCP_SERVER="${PREFIX}.4.4"   # IP Aldarion (DHCP Server)
INTERFACES="eth1 eth2 eth3 eth4 eth5"  # koneksi antar subnet

echo "[1/3] Menulis konfigurasi relay..."
cat <<EOF > /etc/default/isc-dhcp-relay
SERVERS="${DHCP_SERVER}"
INTERFACES="${INTERFACES}"
OPTIONS=""
EOF

echo "[2/3] Menjalankan DHCP relay daemon..."
dhcrelay -d ${DHCP_SERVER} ${INTERFACES} &
sleep 2

echo "[3/3] DHCP Relay Durin siap meneruskan permintaan ke ${DHCP_SERVER}"
