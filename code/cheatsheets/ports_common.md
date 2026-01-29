# Ports für LPIC-2

| Service (aus LPIC‑2 Lernzielen)           | `/etc/services`    | Protokoll/-e |
|-------------------------------------------|--------------------|--------------|
| Syslog / rsyslog                          | `syslog 514`       | udp          |
| SSH (OpenSSH)                             | `ssh 22`           | tcp          |
| Telnet                                    | `telnet 23`        | tcp          |
| FTP (vsftpd, ProFTPD, Pure‑FTPd)          | `ftp 21`           | tcp          |
| FTPS (implicit TLS/SSL)                   | `ftps 990`         | tcp          |
| SFTP (SSH‑based file transfer)            | `ssh 22`           | tcp          |
| HTTP (Apache, Nginx, lighttpd, etc.)      | `http 80`          | tcp          |
| HTTPS (HTTP over TLS/SSL)                 | `https 443`        | tcp          |
| SMTP (Postfix, Sendmail, Exim)            | `smtp 25`          | tcp          |
| SMTPS / Submission (secure SMTP)          | `smtps 465`        | tcp          |
| Mail submission (587)                     | `submission 587`   | tcp          |
| POP3 (mail retrieval)                     | `pop3 110`         | tcp          |
| POP3S (secure POP3)                       | `pop3s 995`        | tcp          |
| IMAP2 (mail retrieval)                    | `imap 143`         | tcp, udp     |
| IMAP3 (mail retrieval)                    | `imap 220`         | tcp, udp     |
| IMAPS (secure IMAP)                       | `imaps 993`        | tcp          |
| DNS (named, BIND)                         | `domain 53`        | tcp, udp     |
| DHCP server                               | `dhcps 67`         | udp          |
| DHCP client                               | `dhcpc 68`         | udp          |
| NTP (Network Time Protocol)               | `ntp 123`          | udp          |
| NFS (Network File System)                 | `nfs 2049`         | tcp, udp     |
| Samba / SMB (NetBIOS‑NS)                  | `netbios-ns 137`   | udp          |
| Samba / SMB (NetBIOS‑DG)                  | `netbios-dgm 138`  | udp          |
| Samba / SMB (NetBIOS‑SSN)                 | `netbios-ssn 139`  | tcp          |
| Samba / SMB (Direct TCP/IP)               | `microsoft-ds 445` | tcp          |
| CUPS (Common UNIX Printing System)        | `ipp 631`          | tcp, udp     |
| LDAP (OpenLDAP, 389‑dir)                  | `ldap 389`         | tcp, udp     |
| LDAPS (LDAP over SSL/TLS)                 | `ldaps 636`        | tcp          |
| MySQL / MariaDB                           | `mysql 3306`       | tcp          |
| SNMP (Simple Network Management Protocol) | `snmp 161`         | udp          |
| SNMP Trap                                 | `snmptrap 162`     | udp          |
| rsync                                     | `rsync 873`        | tcp          |
| X11 (X Window System)                     | `x11 6000`         | tcp          |
| OpenVPN                                   | `openvpn 1194`     | udp, tcp     |
| IPsec – IKE                               | `isakmp 500`       | udp          |
| RADIUS (authentication)                   | `radius 1812`      | udp          |
| RADIUS (accounting)                       | `radius-acct 1813` | udp          |
| SMB over NetBIOS (WINS)                   | `wins 1515`        | tcp, udp     |
| LDAP over TCP (for Sun Directory)         | `ldap 389`         | tcp          |
| Kerberos (KDC)                            | `kerberos 88`      | tcp, udp     |
| Kerberos (kpasswd)                        | `kerberos-sec 464` | tcp, udp     |
| HTTP‑Proxy (Squid, etc.)                  | `http-proxy 3128`  | tcp          |
| HTTPS‑Proxy                               | `https-proxy 8080` | tcp          |
