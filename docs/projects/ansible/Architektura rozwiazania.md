---
title: Architektura rozwiązania
description: Architektura rozwiązania
tags:
- ansible
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} Architektura rozwiązania

Architektura została zaprojektowana z myślą o modularności, przejrzystości oraz łatwości utrzymania konfiguracji infrastruktury przy użyciu Ansible. Każdy element infrastruktury jest zarządzany jako osobne, wersjonowane repozytorium GitLab, co umożliwia:

* niezależny rozwój ról i playbooków,
* testowanie i walidację przy użyciu CI/CD,
* ponowne wykorzystanie ról w różnych projektach,
* automatyzację wdrożeń za pomocą pipeline’ów GitLab CI.

---

## Struktura w repozytorium

Poniżej przestawiona jest infrastruktura grup i repozytoriów w gitlabie dla projektu [Ansible](https://gitlab.com/pl.rachuna-net/infrastructure/ansible)

```bash
pl.rachuna-net/infrastructure/ansible
├── inventory                # repozytorium z konfiguracją
├── playbooks                # repozytoria z plabyookami
│   └── linux-hardening
└── roles                    # repozytoria z ansible roles
    ├── configure-ssh
    ├── configure-sudo
    ├── gitlab-runners
    ├── install-consul
    ├── install-packages
    └── set-hostname
```

---

## Zasady organizacji repozytoriów

* **inventory** – zawiera pliki inwentaryzacyjne (`hosts`) oraz zmienne grupowe/hostowe. To punkt wejścia dla playbooków.
* **playbooks** – każdy katalog reprezentuje osobny playbook dedykowany do konkretnego celu (np. hardening systemów Linux).
* **roles** – każda rola odpowiada za jedną funkcjonalność, zgodnie z konwencją [Ansible Galaxy](https://docs.ansible.com/ansible/latest/dev_guide/collections_galaxy.html).

---

## Przepływ pracy (Workflow)

1. **Tworzenie roli** – nowa rola jest dodawana jako osobne repozytorium w `roles/`, rozwijana i testowana niezależnie (np. z użyciem Molecule).
2. **Tworzenie playbooka** – playbook zawiera logiczne połączenie ról i jest uruchamiany na wskazanych hostach.
3. **Zarządzanie konfiguracją** – inventory zarządza środowiskami, np. `prod`, `dev`, `test`, wraz z odpowiednimi zmiennymi.
4. **Automatyzacja** – pipeline GitLab CI integruje testy oraz ewentualne wdrożenia (np. przez tagowanie commitów lub merge na `main`).

---

## Rozszerzenia i przyszłe kierunki

* Integracja z **Terraformem** w celu automatycznego provisioningu infrastruktury.
* Wdrożenie **centralnego rejestru ról** (np. za pomocą GitLab Packages).
* Testy ról z użyciem **Ansible Molecule** i symulacja środowisk na Proxmox lub Dockerze.
* Standaryzacja tagowania i wersjonowania ról oraz playbooków.
