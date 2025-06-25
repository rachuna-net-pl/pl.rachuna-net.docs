---
title: Epic 6
hide:
- navigation
---
# [Epic 6 - Utworzenie vault and consul na proxmox](https://gitlab.com/groups/pl.rachuna-net/-/milestones/6)

---
## Przygotowanie grup i repozytoriów za pomocą Terraform
---
- [x] Utworzenie repozytorium `pl.rachuna-net/infrastructure/ansible/playbooks/install-vault`
- [x] Utworzenie repozytorium `pl.rachuna-net/infrastructure/ansible/roles/install-consul`
- [x] Utworzenie repozytorium `pl.rachuna-net/infrastructure/ansible/roles/install-vault`
- [x] Utworzenie repozytorium `pl.rachuna-net/infrastructure/terraform/modules/proxmox-container`
- [x] Utworzenie repozytorium `pl.rachuna-net/infrastructure/terraform/modules/proxmox-download-container`
- [x] Utworzenie repozytorium `pl.rachuna-net/containers/consul`
- [x] Utworzenie repozytorium `pl.rachuna-net/containers/vault`
- [x] Utworzenie repozytorium `pl.rachuna-net/infrastructure/terraform/consul`
* [ ] Utworzenie repozytorium `pl.rachuna-net/infrastructure/terraform/iac-vault`
- [ ] Utworzenie repozytorium `pl.rachuna-net/infrastructure/terraform/modules/vault-pki-cert-ca`

---
## Utworzenie modułów terraform 
---
- [x] Utworzenie modułu [proxmox-download-container](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/proxmox-download-container/-/releases/v1.0.0)
- [x] Utworzenie modułu [proxmox-container](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/proxmox-container/-/releases/v1.0.0)
- [x] Utworzenie wirtualnych maszyn `ct01011`, `ct01012` i `ct01013` [v1.0.2](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/releases/v1.0.2)
- [x] Utworzenie modułu [vault-pki-cert-ca](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/proxmox-download-container/-/releases/v1.1.0)

---
## Instalacja clustra consul & vault
---
- [x] Instalacja consul
- [x] Utworzenie polityk dla consul [v1.0.1](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/consul/-/tags/v1.0.1)
- [ ] Instalacja vault
- [ ] Utworzenie polityk dla vault

---
## Utworzenie obrazów dockerowych
---
- [x] Utworzenie obrazu dockerowego z consul [v1.0.0](https://gitlab.com/pl.rachuna-net/containers/consul/container_registry/8767399)
- [x] Utworzenie obrazu dockerowego z vault [v1.0.0](https://gitlab.com/pl.rachuna-net/containers/vault/container_registry/8767913)


---
## Utworzenie konfiguracji [iac-vault](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-vault)

* [x] [DEVOPS-87](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-87): Utworzenie Storage dla certyfikatów i kluczy prywatnych (kv-certificates)
* [x] [DEVOPS-88](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-88): Utworzenie pki-root-ca i wygenerowanie jego
* [x] [DEVOPS-89](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-89): Utworzenie pki-internal-services i wygenerowanie internal-services intermediate CA
* [x] [DEVOPS-90](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-90): Utworzenie pki-dmz-services i wygenerowanie dmz-services intermediate CA
* [x] [DEVOPS-91](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-91): Utworzenie pki-mikrotik i wygenerowanie mikrotik intermediate CA
* [x] [DEVOPS-92](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-92): Utworzenie pki-proxmox i wygenerowanie proxmox intermediate CA
* [x] [DEVOPS-93](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-93): Utworzenie pki-storage i wygenerowanie gtorage intermediate CA
* [x] [DEVOPS-94](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-94): Utworzenie certyfikatu dla consul.rachuna-net.pl
* [x] [DEVOPS-95](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-95): Utworzenie certyfikatu dla vault.rachuna-net.pl
* [x] [DEVOPS-98](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-98): Ustawienie logowania dla mrachuna za pomocą userpass
* [x] [DEVOPS-99](https://rachunamaciej-1749966293420.atlassian.net/browse/DEVOPS-99): Utworzenie Storage dla devops (kv-devops)
