---
title: Skrypt uruchamiający packer
description: Skrypt uruchamiający packer
tags:
- packer
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/packer.png){width=20px} Skrypt uruchamiający packer

!!! info
    Skrypt Bash automatyzuje proces budowy i wdrażania szablonów maszyn wirtualnych Ubuntu Linux na Proxmox VE przy użyciu narzędzia Packer.
    Dzięki temu można zdefiniować wiele konfiguracji maszyn w katalogu pkrvars/, a skrypt kolejno je przetwarza.


Skrypt podzielony jest na trzy główne sekcje:

- Definicja zmiennych środowiskowych dla Proxmox i maszyny wirtualnej.
- Wyszukiwanie plików .hcl w katalogu pkrvars/, które zawierają konfiguracje różnych maszyn wirtualnych.
- Automatyczna walidacja i budowa maszyn wirtualnych dla każdego pliku .hcl.
  

**Przykład skryptu uruchamiającego projekt**
```bash
#!/bin/bash

#### PROXMOX CLUSTER VARIABLES ####
export PKR_VAR_proxmox_node_name="pve"
export PKR_VAR_proxmox_api_username="root@pam"
export PKR_VAR_proxmox_api_password="<< twoje tajne hasło >>"
export PKR_VAR_proxmox_api_tls_verify="false"

### ISO VARIABLES ###
export PKR_VAR_iso_storage_pool="local"

### VM VARIABLES ###
# Możesz ustawić konkretny vm_id. Puste oznacza następny id liczony od 100
# export PKR_VAR_vm_id=

export PKR_VAR_ssh_username="ubuntu"
export PKR_VAR_ssh_password="qwerty123"
export PACKER_LOG=1

# Wyszkujemy w katalogu pkrvars wszystkie definicje maszyn wirtualnych i je uruchamiamy
for file in $(find pkrvars -type f -name "*.hcl"); do
    packer fmt -check -var-file=$file .   # walidacja pod kątem formatowania
    packer validate -var-file=$file .     # walidacja pod kątem semantyki
    packer build -var-file=$file .        # Odpalamy proces
done
```