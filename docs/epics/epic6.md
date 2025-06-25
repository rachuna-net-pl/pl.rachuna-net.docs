---
title: Epic 6
hide:
- navigation
---
# Epic 6 - Hardening maszyn linuxowych za pomocą Ansible

!!! notes
      Projekt zakłada stworzenie ustandaryzowanego systemu zabezpieczania serwerów linuksowych w organizacji. Dzięki automatyzacji z użyciem Terraform i Ansible, proces będzie powtarzalny, skalowalny i łatwy do utrzymania. Zwiększy to poziom bezpieczeństwa środowisk IT i zmniejszy ryzyko błędów konfiguracyjnych.

---
## [🎯 Cel epiki](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-130)
Celem epika jest zaprojektowanie i wdrożenie zautomatyzowanego procesu hardeningu (utwardzania) systemów linuksowych w środowisku rachuna-net. Proces ma na celu podniesienie poziomu bezpieczeństwa systemów poprzez ustandaryzowane role Ansible, szablonowe repozytoria oraz infrastrukturę jako kod (IaC) opartą o Terraform.

Zakres techniczny:

* Terraform – przygotowanie modułów infrastrukturalnych i kontenerowych, w tym automatyzacja tworzenia maszyn wirtualnych i kontenerów Proxmox.
* Repozytoria i grupy GitLab – pełna struktura repozytoriów Ansible, Terraform oraz kontenerów, tworzona i wersjonowana za pomocą Terraform.
* Ansible – stworzenie zestawu wielokrotnego użytku ról (m.in. `configure-ssh`, `configure-sudo`, `install-packages`, `set-hostname`, `ca-certificates`, `active-directory-client`), zorganizowanych w ramach dedykowanych playbooków i inventory.
* Playbook hardeningowy – zbudowany z modularnych ról i gotowy do zautomatyzowanego uruchamiania na nowych maszynach linuksowych.
* Realizacja epika pozwoli ujednolicić i zautomatyzować wdrażanie polityk bezpieczeństwa systemów operacyjnych, zwiększając ich odporność na ataki i ułatwiając zgodność z najlepszymi praktykami DevSecOps.

---
## Przygotowanie grup i repozytoriów za pomocą Terraform

* [x] [DEVOPS-135](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-135): Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/iac-proxmox](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/terraform/iac-proxmox.tf?ref_type=heads)
* [x] [DEVOPS-163](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-163): Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/proxmox-container](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/terraform/modules/proxmox-container.tf?ref_type=heads)
* [x] [DEVOPS-164](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-164): Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/proxmox-download-container](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/terraform/modules/proxmox-download-container.tf?ref_type=heads)
* [x] [DEVOPS-136](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-136): Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/proxmox-vm](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/terraform/modules/proxmox-vm.tf?ref_type=heads)
* [x] [DEVOPS-137](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-137): Utworzenie repozytorium [pl.rachuna-net/containers/ansible](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/containers/ansible.tf?ref_type=heads)
* [x] [DEVOPS-138](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-138): Utworzenie grupy repozytoriów [pl.rachuna-net/infrastructure/ansible](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/_ansible.tf?ref_type=heads)
* [x] [DEVOPS-139](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-139): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/inventory](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/inventory.tf?ref_type=heads)
* [x] [DEVOPS-140](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-140): Utworzenie grupy repozytoriów [pl.rachuna-net/infrastructure/ansible/playbooks](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/_playbooks.tf?ref_type=heads)
* [x] [DEVOPS-141](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-141): Utworzenie grupy repozytoriów [pl.rachuna-net/infrastructure/ansible/roles](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/_roles.tf?ref_type=heads)
* [x] [DEVOPS-142](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-142): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening.tf?ref_type=heads)
* [x] [DEVOPS-143](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-143): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/configure-ssh](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh.tf?ref_type=heads)
* [x] [DEVOPS-144](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-144): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/configure-sudo](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/roles/configure-sudo.tf?ref_type=heads)
* [x] [DEVOPS-145](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-145): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/set-hostname](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/roles/set-hostname.tf?ref_type=heads)
* [x] [DEVOPS-146](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-146): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/install-packages](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/roles/install-packages.tf?ref_type=heads)
* [x] [DEVOPS-147](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-147): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/ca-certficates](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/roles/ca-certificates.tf?ref_type=heads)
* [x] [DEVOPS-148](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-148): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/proxmox-nodes](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/roles/proxmox-nodes.tf?ref_type=heads)
* [x] [DEVOPS-149](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-149): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/users-managment](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/roles/users-managment.tf?ref_type=heads)
* [x] [DEVOPS-169](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-169): Paramatryzacja grupy [pl.rachuna-net/infrastructure/ansible/roles](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/_roles.tf?ref_type=heads)
* [x] [DEVOPS-171](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-171): Paramatryzacja grupy [pl.rachuna-net/infrastructure/ansible](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/_ansible.tf?ref_type=heads)

---
## Terraform

- [x] [DEVOPS-151](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-151): Utworzenie modułu tworzącego maszynę wirtualną [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/proxmox-vm/-/releases/v1.0.0)
- [x] [DEVOPS-152](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-152): Utworzenie modułu pobierającego containers dla proxmox [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/proxmox-download-container/-/releases/v1.0.0)
- [x] [DEVOPS-153](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-152): Utworzenie modułu tworzącego containers [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/proxmox-container/-/releases/v1.0.0)
- [x] [DEVOPS-154](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-152): Przygotowanie projektu iac-proxmox [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-proxmox/-/releases/v1.0.0)
- [x] Utworzenie maszyny wirtualnej [ct01002](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-proxmox/-/releases/v1.0.0)

---
## Utworzenie procesu CI dla ansible

* [x] [DEVOPS-165](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-165): Utworzenie kontenera z ansible [v1.0.0](https://gitlab.com/pl.rachuna-net/containers/ansible/-/releases/v1.0.0)
* [x] [DEVOPS-166](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-166): Wydanie procesu gitlab-ci [v1.5.0](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/releases/v1.5.0)
    * [x] [DEVOPS-167](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-167): Wydanie komponentu prepare [v1.0.4](https://gitlab.com/pl.rachuna-net/cicd/components/prepare/-/releases/v1.0.4)
    * [x] [DEVOPS-170](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-170): Wydanie komponentu validate [v1.2.0](https://gitlab.com/pl.rachuna-net/cicd/components/prepare/-/releases/v1.2.0)
    * [x] [DEVOPS-168](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-168): Wydanie komponentu unit-test [v1.1.0](https://gitlab.com/pl.rachuna-net/cicd/components/prepare/-/releases/v1.1.0)
    * [x] [DEVOPS-172](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-172): Wydanie komponentu deploy [v1.2.0](https://gitlab.com/pl.rachuna-net/cicd/components/prepare/-/releases/v1.2.0)


---
## Utworzenie projektu ansible
---

* [x] [DEVOPS-161](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-161): Utworzenie roli [active-directory-client](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/ca-certificates/-/releases/v1.0.1)
* [x] [DEVOPS-156](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-156): Utworzenie roli [configure-ssh](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh/-/releases/v1.0.1)
* [x] [DEVOPS-157](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-157): Utworzenie roli [configure-sudo](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/configure-sudo/-/releases/v1.0.3)
* [x] [DEVOPS-159](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-159): Utworzenie roli [install-packages](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/install-packages/-/releases/v1.0.1)
* [x] [DEVOPS-155](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-155): Utworzenie roli [set-hostname](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/set-hostname/-/releases/v1.0.2)
* [x] [DEVOPS-174](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-155): Utworzenie roli [/users-management](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/users-management/-/releases/v1.0.5)

* [x] [DEVOPS-162](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-162): Playbook [linux-hardening](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening/-/releases/v1.0.0)
