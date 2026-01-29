#!/bin/bash

IPT="/sbin/iptables"

# vorhandene Regeln entfernen
$IPT -F
$IPT -X

# Default-Policy setzen
$IPT -P INPUT   DROP
$IPT -P OUTPUT  DROP
$IPT -P FORWARD DROP

# Routing aktivieren
echo "1" > /proc/sys/net/ipv4/ip_forward

# Interfaces (Intern, DMZ, Extern)
INT=eth0
DMZ=eth1
EXT=eth2

# Management-Konsole fuer Firewall
MGMT=192.168.100.200

# Server DMZ
PROXY=10.10.10.20
MAIL=10.10.10.30
MONITOR=10.10.10.40
WEBSERVER=10.10.10.50
DNS=10.10.10.60

# Server extern
NTP=172.16.15.14

# Bestehende Verbindungen erlauben
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Loopback freischalten
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# Eigene Chains anlegen
$IPT -N int_to_dmz
$IPT -N dmz_to_ext
$IPT -N ext_to_dmz

# Verkehr aufteilen
$IPT -A FORWARD -i $INT -o $DMZ -j int_to_dmz
$IPT -A FORWARD -i $DMZ -o $EXT -j dmz_to_ext
$IPT -A FORWARD -i $EXT -o $DMZ -j ext_to_dmz

### Verkehr internen Netz -> DMZ
$IPT -A int_to_dmz -m state --state NEW -p tcp --dport 8080 -d $PROXY -j ACCEPT
$IPT -A int_to_dmz -m state --state NEW -p tcp --dport ftp -d $WEBSERVER -j ACCEPT
$IPT -A int_to_dmz -m state --state NEW -p tcp --dport https -d $MONITOR -j ACCEPT
$IPT -A int_to_dmz -m state --state NEW -p tcp -m multiport --dport pop3,imap -d $MAIL -j ACCEPT
$IPT -A int_to_dmz -m state --state NEW -p tcp --dport ssh -s $MGMT -j ACCEPT
$IPT -A int_to_dmz -m state --state NEW -p icmp --icmp-type echo-request -j ACCEPT
$IPT -A int_to_dmz -j ext_to_dmz

### Verkehr DMZ -> Internet
$IPT -A dmz_to_ext -m state --state NEW -p udp --dport ntp -d $NTP -j ACCEPT
$IPT -A dmz_to_ext -m state --state NEW -p tcp -m multiport --dport smtp,smtps -s $MAIL -j ACCEPT
$IPT -A dmz_to_ext -m state --state NEW -p tcp -m multiport --dport http,https -s $PROXY -j ACCEPT
$IPT -A dmz_to_ext -m state --state NEW -p tcp --dport domain -s $DNS -j ACCEPT
$IPT -A dmz_to_ext -m state --state NEW -p udp --dport domain -s $DNS -j ACCEPT
$IPT -A dmz_to_ext -j REJECT

### Verkehr Internet -> DMZ
$IPT -A ext_to_dmz -m state --state NEW -p tcp -m multiport --dport smtp,smtps -d $MAIL -j ACCEPT
$IPT -A ext_to_dmz -m state --state NEW -p tcp -m multiport --dport http,https -d $WEBSERVER -j ACCEPT
$IPT -A ext_to_dmz -m state --state NEW -p tcp --dport domain -d $DNS -j ACCEPT
$IPT -A ext_to_dmz -m state --state NEW -p udp --dport domain -d $DNS -j ACCEPT
$IPT -A ext_to_dmz -m state --state NEW -p icmp --icmp-type fragmentation-needed -j ACCEPT
$IPT -A ext_to_dmz -j REJECT

### Regeln Firewall eingehend
$IPT -A INPUT -i $INT -m state --state NEW -p tcp --dport ssh -s $MGMT -j ACCEPT
$IPT -A INPUT -i $DMZ -m state --state NEW -p udp --dport snmp -s $MONITOR -j ACCEPT

### Regeln Firewall ausgehend
$IPT -A OUTPUT -o $DMZ -m state --state NEW -p tcp --dport 8080 -d $PROXY -j ACCEPT
$IPT -A OUTPUT -o $DMZ -m state --state NEW -p tcp --dport domain -d $DNS -j ACCEPT
$IPT -A OUTPUT -o $DMZ -m state --state NEW -p udp --dport domain -d $DNS -j ACCEPT
$IPT -A OUTPUT -o $EXT -m state --state NEW -p udp --dport ntp -j ACCEPT
$IPT -A OUTPUT -o $EXT -m state --state NEW -p icmp --icmp-type fragmentation-needed -j ACCEPT
