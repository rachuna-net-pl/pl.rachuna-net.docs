---
title: Epic 5
hide:
- navigation
---
# [Epic 5 - Utworzenie gitlab-runners na proxmox](https://gitlab.com/groups/pl.rachuna-net/-/milestones/5)

---
## Przygotowanie grup i repozytoriów za pomocą Terraform
---
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/proxmox](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/38)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/terraform/modules/proxmox-vm](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/39)
- [x] Utworzenie repozytorium [pl.rachuna-net/containers/ansible](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/46)
- [x] Utworzenie grupy repozytoriów [pl.rachuna-net/infrastructure/ansible](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/40)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/inventory](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/41)
- [x] Utworzenie grupy repozytoriów [pl.rachuna-net/infrastructure/ansible/playbooks](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/42)
- [x] Utworzenie grupy repozytoriów [pl.rachuna-net/infrastructure/ansible/roles](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/43)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/44)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/playbooks/gitlab-runner](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/51)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/configure-ssh](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/45)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/configure-sudo](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/47)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/set-hotname](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/48)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/install-packages](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/49)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/active-directory-client](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/50)
- [x] Utworzenie repozytorium [pl.rachuna-net/infrastructure/ansible/roles/gitlab-runner](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/issues/52)

---
## Terraform
---
- [x] Utworzenie modułu tworzącego maszynę wirtualną [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/proxmox-vm/-/releases/v1.0.0)
- [x] Utworzenie maszyny wirtualnej [vm01001](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/vm01001.tf)
- [x] Utworzenie maszyny wirtualnej [vm01002](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/vm01002.tf)

---
## Utworzenie procesu CI
---
- [x] Utworzenie kontenera z ansible [v1.0.0](https://gitlab.com/pl.rachuna-net/containers/ansible/-/releases/v1.0.0)
- [x] Wydanie komponentu `validate` z `ansible-playbook --check` [v1.3.0](hhttps://gitlab.com/pl.rachuna-net/cicd/components/validate/-/releases/v1.3.0)
- [x] Wydanie komponentu `unit-test` z `molecule test` [v1.1.0](https://gitlab.com/pl.rachuna-net/cicd/components/unit-test/-/releases/v1.1.0)
- [x] Wydanie komponentu `deploy` z `ansible-playbook` [v1.1.0](https://gitlab.com/pl.rachuna-net/cicd/components/deploy/-/releases/v1.1.0)

---
## Utworzenie projektu ansible
---

1. - [x] Utworzenie roli [configure-ssh](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh/-/releases/v1.0.0)
2. - [x] Utworzenie roli [configure-sudo](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/configure-sudo/-/releases/v1.0.0)
3. - [x] Utworzenie roli [set-hostname](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/set-hostname/-/releases/v1.0.0)
4. - [x] Utworzenie roli [install-packages](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/install-packages/-/releases/v1.0.0)
5. - [x] Utworzenie roli [active-directory-client](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/active-directory-client/-/releases/v1.0.2)
6. - [x] Utworzenie roli [gitlab-runner](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/gitlab-runner/-/releases/v1.0.2)

---

1. Playbook [linux-hardening](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening)
   
      1.  [x] Utworzenie inventory dla [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/inventory/-/blob/cdbbbf093a522791b1b93e27f66b2cd2b845a199/hosts.yml)
      2.  [x] Utworzenie playbook testującego połączenie [test_connection.yml](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening/-/blob/main/playbooks/test_connection.yml)
      3.  [x] Podłączenie roli `configure-ssh` do projektu [v1.1.0](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening/-/releases/v1.1.0)
      4.  [x] Podłączenie roli `configure-sudo` do projektu [v1.2.0](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening/-/releases/v1.2.0)
      5.  [x] Podłączenie roli `set-hostname` do projektu [v1.3.0](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening/-/releases/v1.3.0)
      6.  [x] Podłączenie roli `install-packages` do projektu [v1.4.0](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening/-/releases/v1.4.0)
      7.  [x] Podłączenie roli `active-directory-client` do projektu [v1.4.1](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening/-/releases/v1.4.0)

1. Playbook [gitlab-runner](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening)
      1.  [x] Utworzenie inventory dla [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/gitlab-runner/-/releases/v1.0.0)
      2.  [x] Podłączenie roli `gitlab-runner` do projektu [v1.1.0](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/gitlab-runner/-/releases/v1.1.0)