#!/bin/bash
# 🧩 DNS SLAVE CONFIGURATION – Amdir (ns2.k26.com)
DOMAIN="k26.com"
PREFIX="192.224"

echo "[1/5] Menyiapkan direktori zona & runtime..."
mkdir -p /etc/bind/zones /run/named
chmod 775 /run/named

echo "[2/5] Menulis named.conf.options..."
cat > /etc/bind/named.conf.options <<EOF
options {
    directory "/var/cache/bind";
    listen-on port 53 { any; };
    listen-on-v6 { none; };
    allow-query { ${PREFIX}.0.0/16; };
    recursion yes;
};
EOF

echo "[3/5] Menulis konfigurasi zone slave..."
cat > /etc/bind/named.conf.local <<EOF
zone "${DOMAIN}" {
    type slave;
    masters { ${PREFIX}.3.2; };
    file "/etc/bind/zones/db.${DOMAIN}";
};

zone "${PREFIX}.in-addr.arpa" {
    type slave;
    masters { ${PREFIX}.3.2; };
    file "/etc/bind/zones/db.${PREFIX}.rev";
};
EOF

echo "[4/5] Validasi konfigurasi..."
named-checkconf

echo "[5/5] Restart layanan DNS..."
service named restart
echo "✅ Amdir (ns2.${DOMAIN}) aktif sebagai DNS Slave!"
