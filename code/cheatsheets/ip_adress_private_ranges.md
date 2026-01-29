# Private IP-Adressen

## Hintergrund

- Beschreibung im [RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918)

## IPv4

| Netzadressbereich                 |    # Hosts | CIDR-Notation    | Netzklasse                  |
|-----------------------------------|-----------:|------------------|-----------------------------|
| `10.0.0.0` - `10.255.255.255`     | 16.777.216 | `10.0.0.0/8`     | **Klasse A**: 1 Netzwerk    |
| `172.16.0.0` - `172.31.255.255`   |  1.048.576 | `172.16.0.0/12`  | **Klasse B**: 16 Netzwerke  |
| `192.168.0.0` - `192.168.255.255` |     65.536 | `192.168.0.0/16` | **Klasse C**: 256 Netzwerke |

- [Liste reservierter IPv4-Adressen](https://en.wikipedia.org/wiki/List_of_reserved_IP_addresses#IPv4)
- in der Praxis werden diese Netze oft ist in verschiedene [Subnetze](https://de.wikipedia.org/wiki/Subnetz) unterteilt

### Sonderfälle

| Netzadressbereich                 |    # Hosts | CIDR-Notation    | Netzklasse                  | Besonderheit       |
|-----------------------------------|-----------:|------------------|-----------------------------|--------------------|
| `127.0.0.0` - `127.255.255.255`   | 16.777.216 | `127.0.0.0/8`    | **Klasse A**: 1 Netzwerk    | Loopback           |
| `169.254.0.0` - `169.254.255.255` |     65.536 | `169.254.0.0/16` | **Klasse B**: 1 Netzwerk    | Link Local (APIPA) |

## IPv6

| Netzadressbereich | CIDR   | Besonderheit                                                                          |
|-------------------|--------|---------------------------------------------------------------------------------------|
| `fc00::/7`        | `/7`   | Unique Local Addresses (ULA); entspricht am ehesten `10/8`, `172.16/12`, `192.168/16` |
| `fe80::/10`       | `/10`  | Link-Local; entspricht `169.254/16` (APIPA)                                           |
| `::1`             | `/128` | Loopback; entspricht `127.0.0.1`                                                      |
| `::/128`          | `/128` | nicht angegeben; entspricht `0.0.0.0`                                                 |

- [Liste reservierter IPv6-Adressen](https://en.wikipedia.org/wiki/List_of_reserved_IP_addresses#IPv6)
