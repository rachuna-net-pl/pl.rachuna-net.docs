---
title: Wstęp do terraform
description: Wstęp do terraform
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} Terraform

!!! info
    **Terraform**[^terraform] to narzędzie typu Infrastructure as Code (IaC), które umożliwia definiowanie, provisionowanie i zarządzanie infrastrukturą za pomocą plików konfiguracyjnych. Dzięki Terraform możesz w sposób deklaratywny opisywać zasoby, takie jak serwery, sieci czy usługi w chmurze, a następnie automatycznie je tworzyć, modyfikować i usuwać, zapewniając spójność środowisk.

Infrastructure as Code (IaC) to podejście do zarządzania infrastrukturą IT, w którym zasoby są definiowane i utrzymywane za pomocą kodu, a nie manualnych operacji. Jednym z najczęściej wykorzystywanych narzędzi do implementacji IaC jest **Terraform**, rozwijany przez firmę HashiCorp. Terraform umożliwia automatyczne tworzenie, aktualizowanie oraz usuwanie zasobów w chmurze i środowiskach lokalnych, na podstawie deklaratywnych plików konfiguracyjnych.

Wdrażając podejście IaC z użyciem Terraform, należy przyjąć szereg kluczowych założeń projektowych, które zapewniają bezpieczeństwo, skalowalność oraz powtarzalność środowisk infrastrukturalnych.

---
## Architektura projektu terrafrom w `pl.rachuna-net`

!!! question inline
    Kod źródłowy projektu znajduje się [tutaj](https://gitlab.com/pl.rachuna-net/infrastructure/terraform "https://gitlab.com/pl.rachuna-net/infrastructure/terraform"). 

```bash
# Przykładowy opis struktury projektu
pl.rachuna-net/infrastructure/terraform
├── consul
├── gitlab
├── gitlab-profile                      # Documentation
├── home.rachuna-net.pl
├── iac-gitlab                          # IaC - Gitlab Management by terraform
├── modules                             # Terraform modules
│   ├── gitlab-group                    # Terraform module for menagment groups
│   ├── gitlab-project                  # Terraform module for menagment projects
│   ├── proxmox-container
│   ├── proxmox-download-container
│   ├── proxmox-vm
│   ├── routeros-bonding
│   ├── routeros-bridge
│   ├── routeros-dhcp-server
│   ├── routeros-dns
│   ├── routeros-ethernet
│   ├── routeros-system
│   ├── routeros-vlan
│   ├── vault-pki-cert-ca
│   └── vault-pki-cert-intermediate
├── proxmox
├── router.rachuna-net.pl
└── vault
```

---
## Założenia projektów Infrastructure as a Code

Infrastructure as Code (IaC) to podejście do zarządzania infrastrukturą IT, w którym zasoby są definiowane i utrzymywane za pomocą kodu, a nie manualnych operacji. Jednym z najczęściej wykorzystywanych narzędzi do implementacji IaC jest **Terraform**, rozwijany przez firmę HashiCorp. Terraform umożliwia automatyczne tworzenie, aktualizowanie oraz usuwanie zasobów w chmurze i środowiskach lokalnych, na podstawie deklaratywnych plików konfiguracyjnych.

Wdrażając podejście IaC z użyciem Terraform, należy przyjąć szereg kluczowych założeń projektowych, które zapewniają bezpieczeństwo, skalowalność oraz powtarzalność środowisk infrastrukturalnych.


[^terraform]: źródło: https://developer.hashicorp.com/terraform/docs

