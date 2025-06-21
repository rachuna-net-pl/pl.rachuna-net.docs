---
date:
    created: 2025-04-02
authors:
    - maciej-rachuna
title: VAGRANT - Środowisko developerskie
tags:
    - vagrant
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/vagrant.png){height=20px} VAGRANT - Środowisko developerskie

!!! tip
    Vagrant to narzędzie open-source stworzone przez HashiCorp, które służy do tworzenia i zarządzania wirtualnymi środowiskami deweloperskimi. Jego głównym celem jest ułatwienie tworzenia spójnych i przenośnych środowisk, które można łatwo uruchomić na różnych maszynach.

<!-- more -->

Całe repozytorium znajduje się [tutaj](https://gitlab.com/pl.rachuna-net/tools/vagrant)

## Wymagane
- [Vagrant](https://developer.hashicorp.com/vagrant/tutorials/get-started/install?product_intent=vagrant)
- [VirtualBox]

## Krok 1. Przeczytaj plik Vagrantfile
```ruby
### Definicja zmiennych środowiskowych
hostname = ENV['VAGRANT_HOSTNAME'] || 'dev-station'
vm_memory = ENV['VAGRANT_VM_MEMORY'] || 2048
num_cpus = ENV['VAGRANT_NUM_CPUS'] || 2
vm_base_image = ENV['VAGRANT_VM_BASE_IMAGE'] || 'ubuntu/jammy64'
repositories_dir = ENV['VAGRANT_REPOSITORIES_DIR'] || '/repo'
home_dir = ENV['HOME']
```
## Krok 2. Przygotowanie skryptu bash
```bash
#!/bin/env bash
VAGRANT_HOSTNAME=dev-station
VAGRANT_VM_MEMORY=4096
VAGRANT_NUM_CPUS=4
VAGRANT_VM_BASE_IMAGE=ubuntu/jammy64
VAGRANT_REPOSITORIES_DIR=/repo

vagrant up
```
## Krok 3. Przygotowanie plików w profilu użytkwnika
Pliki z tego katalogu `userfiles` zostaną skopiowane do katalogu domowego użytkownika `~/`

```bash
-rw-rw-r-- 1 vagrant vagrant  209 Apr  2 09:02 .gitconfig
-rw-rw-r-- 1 vagrant vagrant  911 Apr  2 09:01 .profile
-rw-rw-r-- 1 vagrant vagrant 4011 Apr  2 09:16 .zshrc
```
## Krok 4. Uruchomienie maszyny virtualnej
```bash
vagrant up
```
## Krok 5. Integracja z Visual Studio Code
**Instalacja pluginów**
```bash
ms-vscode-remote.remote-ssh
alefragnani.project-manager
```

**konfiguracja ssh**
Edycja pliku `.ssh/config`

```ini
Host dev-station
    HostName 127.0.0.1
    Port 2222
    User vagrant
    IdentityFile /repo/pl.rachuna-net/tools/vagrant/.vagrant/machines/default/virtualbox/private_key
    ForwardX11 yes
```
Test połączenia ssh dev-station

**Dodanie do projektu w pluginie Project Manager**
Edycja pliku `project.json`
```json
{
    "name": "pl.rachuna-net/tools/vagrant",
    "rootPath": "vscode-remote://ssh-remote+dev-station/repo/pl.rachuna-net/tools/vagrant",
    "paths": [],
    "tags": []
}
```