---
title: Wstęp do Ansible
description: Wstęp do Ansible
tags:
- ansible
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} Ansible

!!! info
    **Ansible**[^ansible] to narzędzie do automatyzacji IT, które umożliwia zarządzanie konfiguracją systemów, wdrażanie aplikacji oraz automatyzację zadań administracyjnych. Jest agentless (nie wymaga instalacji na zarządzanych maszynach) i działa na zasadzie push, komunikując się z hostami za pomocą SSH lub WinRM.

### Kluczowe cechy:
- **Idempotentność** – ponowne wykonanie tego samego playbooka nie zmienia systemu, jeśli nie jest to konieczne.
- **Deklaratywność** – konfiguracje opisuje się w **YAML** (playbooki).
- **Rozszerzalność** – możliwość użycia **ról**, **modułów** i **kolekcji**.
- **Bez agentów** – działa bez potrzeby instalowania dodatkowego oprogramowania na zarządzanych maszynach.
- **Skalowalność** – obsługuje setki i tysiące hostów jednocześnie.

### Typowe zastosowania:
- Automatyzacja wdrożeń aplikacji.
- Konfiguracja i zarządzanie infrastrukturą.
- Orkiestracja procesów IT.
- Testowanie i weryfikacja konfiguracji (np. z Molecule).


[^ansible]: źródło: [https://docs.ansible.com/](https://docs.ansible.com/)
