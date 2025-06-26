---
title: Epic 7
hide:
- navigation
---
# Epic 7 - Utworzenie gitlab-runners na proxmox

!!! notes
      Projekt zakłada 

---
## [🎯 Cel epiki](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-131)

Celem jest zaprojektowanie, wdrożenie i udokumentowanie kompletnego procesu uruchamiania GitLab Runnerów działających na maszynach wirtualnych w środowisku Proxmox. Projekt zakłada pełną automatyzację cyklu życia tych runnerów — od przygotowania infrastruktury (VM) za pomocą Terraform, przez konfigurację systemów operacyjnych i zabezpieczeń przy użyciu Ansible, aż po integrację z platformą GitLab.

Utworzone zasoby będą wspierać procesy CI/CD wewnątrz organizacji, zwiększając niezależność od runnerów zewnętrznych, zapewniając większą kontrolę nad środowiskiem wykonawczym oraz umożliwiając łatwe skalowanie w zależności od potrzeb zespołów deweloperskich. Projekt uwzględnia również standaryzację podejścia do konfiguracji i wdrażania runnerów, co przekłada się na łatwiejsze utrzymanie, powtarzalność i zgodność z zasadami bezpieczeństwa obowiązującymi w infrastrukturze.


---
## Przygotowanie grup i repozytoriów za pomocą Terraform

* [x] [DEVOPS-179](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-179): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/playbooks/gitlab-runners](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/playbooks/gitlab-runners.tf)
* [x] [DEVOPS-180](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-180): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/gitlab-profile](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/gitlab-profile.tf)
* [x] [DEVOPS-181](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-181): Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/deploy-gitlab-runner](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/ansible/roles/deploy-gitlab-runner.tf)


---
## Terraform

- [x] [DEVOPS-187](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-187):Utworzenie maszyny wirtualnej [ct01001](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-proxmox/-/releases/v1.1.0)
- [x] [DEVOPS-154](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-154): Utworzenie maszyny wirtualnej [ct01002](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-proxmox/-/releases/v1.0.0)

---
## Utworzenie projektu ansible
---

* [x] [DEVOPS-182](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-182): Utworzenie roli [deploy-gitlab-runner](hhttps://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/deploy-gitlab-runner/-/releases/v1.0.0)
* [x] [DEVOPS-183](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-183): Aktualizacja inventory [configure-ssh](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/inventory/-/releases/v1.0.2)
* [x] [DEVOPS-162](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-162): Playbook [linux-hardening](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening/-/releases/v1.0.0)
