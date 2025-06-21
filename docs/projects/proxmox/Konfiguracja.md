---
title: Konfiguracja nodes
description: Konfiguracja nodes
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/proxmox.png){width=20px} Konfiguracja nodes

Poniżej przedstawiono przykładową konfigurację kart sieciowych w środowisku Proxmox. Odpowiednie ustawienie interfejsów sieciowych jest kluczowe dla prawidłowego działania wirtualizacji oraz zapewnienia komunikacji pomiędzy maszynami wirtualnymi a siecią fizyczną.

---
## Konfiguracja kart sieciowych

/etc/network/interfaces
```bash
auto lo
iface lo inet loopback

iface enp2s0 inet manual

auto vmbr0
  iface vmbr0 inet dhcp
  bridge-ports enp2s0
  bridge-stp off
  bridge-fd 0
  #address 10.3.0.11/24 pve-s1.rachuna-net.pl
  #address 10.3.0.12/24 pve-s2.rachuna-net.pl
  #address 10.3.0.13/24 pve-s3.rachuna-net.pl
  #gateway 10.3.0.1

iface wlo1 inet manual

auto vmbr0.10
iface vmbr0.10 inet manual

auto vmbr0.20
iface vmbr0.20 inet manual
```

---
### Utworzenie clustra proxmox

na pve-s1
```bash
pvecm create rachuna-cluster
```
na pve-s2
```
pvecm add 10.3.0.11
```