# Config Durin 
# Interface ke Internet (NAT)
auto eth0
iface eth0 inet dhcp

# Subnet 1 – Laravel Workers
auto eth1
iface eth1 inet static
    address 192.224.1.1
    netmask 255.255.255.0

# Subnet 2 – Clients
auto eth2
iface eth2 inet static
    address 192.224.2.1
    netmask 255.255.255.0

# Subnet 3 – DNS & DHCP
auto eth3
iface eth3 inet static
    address 192.224.3.1
    netmask 255.255.255.0

# Subnet 4 – Database & Forwarder
auto eth4
iface eth4 inet static
    address 192.224.4.1
    netmask 255.255.255.0

# Subnet 5 – PHP Workers
auto eth5
iface eth5 inet static
    address 192.224.5.1
    netmask 255.255.255.0

# Routing + NAT agar jaringan internal bisa akses Internet
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.224.0.0/16
up echo 1 > /proc/sys/net/ipv4/ip_forward


