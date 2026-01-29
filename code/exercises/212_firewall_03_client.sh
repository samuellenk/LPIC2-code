#!/bin/bash

IPT="/sbin/iptables"

# Default-Policy setzen:
$IPT -P INPUT   DROP
$IPT -P OUTPUT  DROP
$IPT -P FORWARD DROP

# vorhandene Regeln entfernen:
$IPT -F

# ein-/ausgehend Loopback erlauben:
$IPT -A INPUT  -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# bestehende Verbindungen erlauben:
$IPT -A INPUT  -m state --state RELATED,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# ein-/ausgehend SSH erlauben:
$IPT -A INPUT  -m state --state NEW -p tcp --dport ssh -j ACCEPT
$IPT -A OUTPUT -m state --state NEW -p tcp --dport ssh -j ACCEPT

# ausgehend http(s) erlauben:
$IPT -A OUTPUT -m state --state NEW -m multiport -p tcp --dport http,https -j ACCEPT

# ausgehend DNS erlauben:
$IPT -A OUTPUT -m state --state NEW -p udp --dport domain -j ACCEPT
$IPT -A OUTPUT -m state --state NEW -p tcp --dport domain -j ACCEPT

# ein-/ausgehend Ping erlauben:
$IPT -A OUTPUT -m state --state NEW -p icmp --icmp-type echo-request -j ACCEPT
$IPT -A INPUT  -m state --state NEW -p icmp --icmp-type echo-request -j ACCEPT
