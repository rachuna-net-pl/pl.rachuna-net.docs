---
title: Epic 7
hide:
- navigation
---
# [Epic 7 - Zarządzanie usługami routerami mikrotik za pomocą terraform](https://gitlab.com/groups/pl.rachuna-net/-/milestones/7)

---
## Przygotowanie grup i repozytoriów za pomocą Terraform
---
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/router.rachuna-net.pl](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/55)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/routeros-bonding](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/55)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/routeros-bridge](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/55)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/routeros-dhcp-server](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/55)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/routeros-dns](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/55)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/routeros-ethernet](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/55)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/routeros-system](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/55)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/routeros-vlan](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/55)

---
## Utworzenie modułów
---
- [x] routeros-system [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/routeros-system/-/releases/v1.0.0)
- [x] routeros-ethernet [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/routeros-ethernet/-/releases/v1.0.0)
- [x] routeros-bonding [v1.0.1](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/routeros-bonding/-/releases/v1.0.1)
- [x] routeros-vlan [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/routeros-vlan/-/releases/v1.0.0)
- [x] routeros-bridge [v1.1.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/routeros-bridge/-/releases/v1.1.0)
- [x] routeros-dhcp-server [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/routeros-dhcp-server/-/releases/v1.0.0)
- [x] routeros-dns [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/routeros-dhcp-server/-/releases/v1.0.0)

---
# Terraform rozwój nad projektem
---
- [x] Ustawienie nazwy routera
- [x] Instalacja certyfikatów ssl
- [x] Ustawienie timezone 
- [x] Ustawienie ip/services
- [x] Definicja portów fizycznych eternet
- [x] Definicja bonding portów ethernet
- [x] Definicja vlan
- [x] Definicja bridge
- [x] Definicja serwerów dhcp
- [x] Definicja serwera DNS