---
title: "Praxis-Beispiel: Postfix verwenden ![](images/LPIC2_logo.png){width=20 height=20}"
subtitle: "LPIC 2"
author: "![SL](images/SL_foto_300.png){width=20 height=20} [&copy; Samuel Lenk](https://linux-trainings.de/)"
theme: "Luebeck"
colortheme: "whale"
aspectratio: 169
colorlinks: true
urlcolor: gray
linkcolor: gray
---

# Einleitung

- dieser Abschnitt bietet ein grundlegendes, eigenständiges Beispiel zur Verwendung vom Postfix-Server

# Voraussetzung

- ein System (VM) als Postfix-Server auf Debian 13
- die Schritte sollten aber (nahezu) deckungsgleich auf anderen Distributionen anwendbar sein

# Installation

Grundpaket suchen:
```bash
apt search postfix
```

Grundpaket installieren:
```bash
sudo apt update
sudo apt install postfix mailutils -y
```

# Default-Konfiguration

Dienst prüfen:
```bash
systemctl status postfix --no-pager
```

im Ausgangszustand ist der Postfix bereits funktionsfähig, mit folgenden Eckdaten:

- nimmt aus dem Netz an diesen Host adressierte Mails an
- zu denen er User in der `/etc/passwd` findet
- akzeptiert Mails in eigenen Subnetz und an Empfänger, die er über DNS ausflösen kann

# Speicherorte und Dateien

- Konfiguration liegt unter `/etc/postfix`
- Haupt-Dateien sind `main.cf` und `master.cf`

# Grundkonfiguration ansehen

Wichtige Einstellungen in der `main.cf`:

- `inet_interfaces = all` = IP-Adressen, auf denen Postfix lauschen soll
- `myhostname = mta.example.net` = Hostname für Postfix-Systems
  - meldet sich damit im SMTP-Protokoll zum Dienst und stellt sich beim Versand anderen Mailservern gegenüber vor
  - korrekte Einstellung sehr wichtig
  - sollte mit **Reverse Lookup** des Mailservers exakt **übereinstimmen**
- `mydestination = $myhostname, localhost.$mydomain, localhost` = alle Domainnamen, für die der Postfix lokal zuständig ist und deren Empfänger er als normale User in `/etc/passwd` findet
- `mynetworks = 127.0.0.0/8, [::1], 172.16.0.0/16` = damit es kein Open Relay wird, nehme nur von diesen Netzen Mails an

aktive Parameter (ohne Kommentare) aus `main.cf` ausgeben:
```bash
postconf -n
```

# Grundkonfiguration anpassen

Werte in `main.cf` anpassen:
```bash
sudo postconf -e "inet_interfaces = all"
sudo postconf -e "myhostname = mta.example.net"
sudo postconf -e "mydestination = $myhostname, localhost.$mydomain, localhost"
sudo postconf -e "mynetworks = 127.0.0.0/8, [::1]/128, 172.16.0.0/16"
```

Änderungen übernehmen:
```bash
sudo systemctl reload postfix
sudo postfix reload
```

Änderung überprüfen:
```bash
sudo postconf -d inet_interfaces \
  myhostname \
  mydestination \
  mynetworks
```
- sollte die neu gesetzten Werte anzeigen

# TLS aktivieren

Zertifikat & Schlüssel erstellen:
```bash
sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/certs/postfix.pem -keyout /etc/ssl/private/postfix.key -subj "/CN=mta.example.net"
```

TLS‑Parameter in `main.cf` setzen:
```bash
sudo postconf -e "smtpd_tls_cert_file = /etc/ssl/certs/postfix.pem"
sudo postconf -e "smtpd_tls_key_file = /etc/ssl/private/postfix.key"
sudo postconf -e "smtpd_tls_security_level = may"
```

Änderungen übernehmen:
```bash
sudo systemctl restart postfix
sudo postfix stop && \
sudo postfix start 
```

Änderung überprüfen:
```bash
sudo postconf -n smtpd_tls_cert_file \
  smtpd_tls_key_file \
  smtpd_tls_security_level
```
- sollte die neu gesetzten Werte anzeigen

# Aliasse und virtuelle Empfänger

Alias für `root`:
```bash
echo "root: admin@example.net" | sudo tee -a /etc/aliases
sudo newaliases
```

User anlegen:
```bash
sudo adduser info
sudo adduser sales
```

simple virtuelle Mailbox:
```bash
sudo postconf -e "virtual_alias_domains = example.org"
sudo postconf -e "virtual_alias_maps = hash:/etc/postfix/virtual"
cat <<EOF | sudo tee /etc/postfix/virtual
info@example.org info
sales@example.org sales
EOF
sudo postmap hash:/etc/postfix/virtual
```

# Konfiguration übernehmen

Syntax prüfen:
```bash
# ??
sudo postconf -n | sudo postmap -c
```

Postfix neu laden:
```bash
sudo systemctl reload postfix
```

# Test‑Mails senden

lokaler Test:
```bash
echo "Testnachricht von $(hostname)" | mail -s "LPIC‑2 Test" info@example.org
```

Abfrage mit dem ensprechenden User:
```bash
sudo -iu info
# als User info aufrufen:
mail
```
- Mail sollte sichtbar sein
- Antwort mit `r`
- Abschluss der Antwort mit [Ctrl] + [D]
- Session beenden nicht vergessen

Remote Test über SMTP mit `nc`:
```bash
printf "EHLO mta.example.net\r\nMAIL FROM:<tux@$(hostname)>\r\nRCPT TO:<webmaster@example.net>\r\nDATA\r\nSubject: Remote Test\r\n\r\nHallo – das war ein Test.\r\n.\r\nQUIT\r\n" | nc -C localhost 25
```
- Abfrage analog wie oben

# Log‑Ausgabe prüfen

Journal abfragen:
```bash
sudo journalctl -u postfix -f
```

klassische Logdatei verfolgen (falls vorhanden):
```bash
tail -f /var/log/mail.log
```

# Mail‑Queue verwalten

Queue‑Inhalt anzeigen (nur aktive):
```bash
sudo postqueue -p
```

Rohdaten einer Queue‑Nachricht ansehen:
```bash
sudo postcat -vq <MSGID>
```
- `<MSGID>` von `postqueue -p`

einzelne Nachricht erneut versuchen:
```bash
sudo postqueue -i <MSGID>
```

alte / hängende Nachrichten löschen:
```bash
sudo postsuper -d -h <MSGID>
```
- `-h` = hard delete

# Weiterführende Befehle und Themen

- weitere Parameter hinzufügen: `postconf -e`, wie `relay_domains`, `transport_maps`
- integriertes Konfig‑Diagnosetool: `postfix check`
