---
title: 🛠️ Epics
hide:
- navigation
---

# 🛠️ Epics

<!-- Poniżej znajduje się lista epic, które pokażą w jaki sposób zrealizowane były projekty -->

<!-- - [🛠️ Epic 8 - Zarządzanie usługami routerami mikrotik za pomocą terraform](/epics/epic7/)
- [🛠️ Epic 7 - Utworzenie vault and consul na proxmox](/epics/epic6/)
 -->

<div class="grid cards" markdown>

-   __🛠️ Epic 7__ -  Utworzenie gitlab-runners na proxmox
    
    ---
    Celem przedsięwzięcia jest uruchomienie dedykowanych GitLab Runnerów na infrastrukturze Proxmox, co pozwoli na niezależne i bezpieczne wykonywanie zadań CI/CD. Dzięki wykorzystaniu Terraform i Ansible proces wdrożenia będzie w pełni zautomatyzowany, zgodny z wewnętrznymi standardami i łatwy do utrzymania w dłuższej perspektywie.

    [:octicons-arrow-right-24: Więcej](/epics/epic7/)

-   __🛠️ Epic 6__ - Hardening maszyn linuxowych za pomocą Ansible

    ---
    Projekt zakłada stworzenie ustandaryzowanego systemu zabezpieczania serwerów linuksowych w organizacji. Dzięki automatyzacji z użyciem Terraform i Ansible, proces będzie powtarzalny, skalowalny i łatwy do utrzymania. Zwiększy to poziom bezpieczeństwa środowisk IT i zmniejszy ryzyko błędów konfiguracyjnych.
    [:octicons-arrow-right-24: Więcej](/epics/epic6/)

-   __🛠️ Epic 5__ - Utworzenie template vm na proxmox za pomocą packera

    ---
    Projekt zakłada stworzenie systemu do automatycznego budowania gotowych maszyn wirtualnych (template’ów) za pomocą Packer’a. Szablony takie jak Ubuntu, Alpine czy AlmaLinux będą wersjonowane i gotowe do wdrożenia w infrastrukturze, co znacząco przyspieszy provisioning środowisk. Automatyzacja zapewni spójność, oszczędność czasu oraz wyeliminowanie błędów manualnych.
    [:octicons-arrow-right-24: Więcej](/epics/epic5/)

-   __🛠️ Epic 4__ - Integracja z Sonarqube cloud

    ---
    Proces obejmuje utworzenie organizacji w **SonarCloud**, przygotowanie kontenera sonar-scanner, komponentu sast oraz pełną integrację repozytoriów CI/CD i kontenerów. Dzięki wykorzystaniu infrastruktury jako kodu (Terraform) oraz zapytań GraphQL do GitLaba, integracja będzie skalowalna i łatwa w utrzymaniu.
    [:octicons-arrow-right-24: Więcej](/epics/epic4/)

-   __🛠️ Epic 3__ - Utworzenie centralnego miejsca do przechowywania dokumentacji

    ---
    Projekt zakłada uruchomienie centralnej dokumentacji technicznej rachuna-net, zautomatyzowanej i dostępnej publicznie przez GitLab Pages, zintegrowanej z domeną firmową. Ułatwi to zarządzanie wiedzą, onboarding i rozwój projektów.
    [:octicons-arrow-right-24: Więcej](/epics/epic3/)


-   __🛠️ Epic 2__ - tworzenie procesów gitlab-ci

    ---
    Celem epiki jest zaprojektowanie i wdrożenie ustandaryzowanych procesów CI/CD w przestrzeni pl.rachuna-net z wykorzystaniem GitLab CI, zgodnie z podejściem modularnym i komponentowym.
    [:octicons-arrow-right-24: Więcej](/epics/epic2/)

-   __🛠️ Epic 1__ - Zarządzenie przestrzenią pl.rachuna-net w gitlab za pomocą terraform

    ---
    Celem epiki jest uporządkowanie i pełne zautomatyzowanie zarządzania strukturą grup i projektów w przestrzeni pl.rachuna-net na GitLabie przy wykorzystaniu podejścia Infrastructure as Code (IaC) opartego na Terraformie.
    [:octicons-arrow-right-24: Więcej](/epics/epic1/)
</div>