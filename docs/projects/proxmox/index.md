---
title: Proxmox
description: Proxmox
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/proxmox.png){width=20px} Proxmox
---

!!! info
    **Proxmox**[^1] to otwartoźródłowa platforma do wirtualizacji serwerów, która umożliwia zarządzanie maszynami wirtualnymi oraz kontenerami w jednym, wygodnym interfejsie webowym. System wspiera zarówno wirtualizację opartą o KVM, jak i lekkie kontenery LXC, co pozwala na elastyczne wykorzystanie zasobów sprzętowych. Proxmox oferuje funkcje klastrowania, wysokiej dostępności (HA), backupów oraz zaawansowane opcje zarządzania siecią i pamięcią masową. Dzięki temu jest chętnie wykorzystywany zarówno w środowiskach testowych, jak i produkcyjnych – od małych firm po duże centra danych.

---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/mikrotik.png){width=20px} Architektura siecowa

--8<-- "docs/projects/proxmox/network_architecture.html"

## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/linux.png){width=20px} Architektura siecowa
| vmid  | hostname | node   | DMZ | opis            |
|-------|----------|--------|-----|-----------------|
|ct01001|ct01001   | pve-s1 |     |gitlab-runner s1 |
|ct01002|ct01002   | pve-s2 |     |gitlab-runner s2 |
|ct01011|ct01011   | pve-s1 |     |Hashicorp Vault & Consul |
|ct01012|ct01012   | pve-s2 |     |Hashicorp Vault & Consul |
|ct01013|ct01013   | pve-s3 |     |Hashicorp Vault & Consul |
|ct01021|ct01021   | pve-s1 |     |Internal Web-Proxy |
|ct01022|ct01022   | pve-s2 |     |Internal Web-Proxy |

---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} [Infrastructure as a Code](Infrastructure as a Code/index.md)

Dzięki podejściu Infrastructure as a Code (IaC) możliwe jest automatyczne zarządzanie infrastrukturą Proxmox za pomocą narzędzia Terraform, co pozwala na szybkie i powtarzalne tworzenie, modyfikowanie oraz wersjonowanie maszyn wirtualnych i zasobów w środowisku Proxmox.

---

[^1]: [proxmox.com](https://www.proxmox.com/en/)