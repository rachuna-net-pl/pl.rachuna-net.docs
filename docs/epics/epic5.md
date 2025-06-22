---
title: Epic 4
hide:
- navigation
---
# Epic 4 - Utworzenie template vm na proxmox za pomocą packera

!!! notes
    Projekt zakłada stworzenie systemu do automatycznego budowania gotowych maszyn wirtualnych (template’ów) za pomocą Packer’a. Szablony takie jak Ubuntu, Alpine czy AlmaLinux będą wersjonowane i gotowe do wdrożenia w infrastrukturze, co znacząco przyspieszy provisioning środowisk. Automatyzacja zapewni spójność, oszczędność czasu oraz wyeliminowanie błędów manualnych.

---
## [🎯 Cel epiki](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-112)

Celem epika jest przygotowanie zautomatyzowanego systemu budowania szablonów maszyn wirtualnych (VM templates) przy użyciu narzędzia HashiCorp Packer. System ma umożliwiać tworzenie wersjonowanych, powtarzalnych i łatwo wdrażalnych obrazów systemów operacyjnych (np. Ubuntu, Alpine, AlmaLinux), gotowych do dalszego wykorzystania w infrastrukturze (np. w Proxmox, CI/CD, środowiskach testowych).

Zakres prac obejmuje:

* Utworzenie grupy projektowej oraz dedykowanych repozytoriów dla Packer'a i każdego z typów obrazów.
* Wydanie bazowego kontenera z zainstalowanym Packerem jako podstawy do procesów budowania.
* Konfigurację procesów CI/CD automatyzujących tworzenie oraz testowanie template’ów.
* Przygotowanie trzech wersjonowanych template’ów systemów: Ubuntu, Alpine oraz Alma.

Efektem realizacji będzie w pełni zautomatyzowany proces generowania szablonów maszyn wirtualnych gotowych do wykorzystania w środowiskach produkcyjnych i deweloperskich.


---
## Przygotowanie grup i repozytoriów za pomocą Terraform

* [x] [DEVOPS-113](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-113): Utworzenie repozytorium dla projektu [pl.rachuna-net/containers/packer](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/containers/packer.tf?ref_type=heads)
* [x] [DEVOPS-114](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-114): Utworzenie grupy [pl.rachuna-net/infrastructure/packer](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/_packer.tf?ref_type=heads)
* [x] [DEVOPS-115](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-115): Utworzenie repozytorium dla projektu [pl.rachuna-net/infrastructure/packer/ubuntu](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/packer/ubuntu.tf?ref_type=heads)
* [x] [DEVOPS-116](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-116): Utworzenie repozytorium dla projektu [pl.rachuna-net/infrastructure/packer/alpine](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/packer/alpine.tf?ref_type=heads)
* [x] [DEVOPS-117](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-117): Utworzenie repozytorium dla projektu [pl.rachuna-net/infrastructure/packer/alma](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/packer/alma.tf?ref_type=heads)
* [x] [DEVOPS-123](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-123): Utworzenie repozytorium dla projektu [pl.rachuna-net/infrastructure/packer/gitlab-profile](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/infrastructure/packer/gitlab-profile.tf?ref_type=heads)
* [x] [DEVOPS-128](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-128): Parametryzacja grupy [pl.rachuna-net/containers/packer](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/containers/packer.tf?ref_type=heads) pod proces gitlab-ci

---
## Przygotowanie procesu CI/CD

* [x] [DEVOPS-118](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-118): Wydanie obrazu dockerowego z packerem [1.0.0](https://gitlab.com/pl.rachuna-net/containers/packer/container_registry/8817411)
* [x] [DEVOPS-127](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-127): Wydanie procesu gitlab-ci [v1.4.0](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/releases/v1.4.0)
    * [x] [DEVOPS-124](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-124): Wydanie komponentu prepare [v1.0.3](https://gitlab.com/pl.rachuna-net/cicd/components/prepare/-/releases/v1.0.3)
    * [x] [DEVOPS-125](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-125): Wydanie komponentu validate [v1.1.0](https://gitlab.com/pl.rachuna-net/cicd/components/validate/-/releases/v1.1.0)
    * [x] [DEVOPS-126](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-126): Wydanie komponentu build [v1.1.0](https://gitlab.com/pl.rachuna-net/cicd/components/validate/-/releases/v1.1.0)


---
## Utworzenie template na proxmox

* [x] [DEVOPS-120](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-120): Utworzenie template Ubuntu dla proxmox [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/packer/ubuntu/-/releases/v1.0.0)
* [x] [DEVOPS-120](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-120): Utworzenie template Alpine dla proxmox [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/packer/alpine/-/releases/v1.0.0)
* [x] [DEVOPS-122](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-122): Utworzenie template Alma dla proxmox [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/packer/alma/-/releases/v1.0.0)
