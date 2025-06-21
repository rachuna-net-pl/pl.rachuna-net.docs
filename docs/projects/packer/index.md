---
title: Wstęp do Packer
description: Wstęp do Packer
tags:
- packer
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/packer.png){width=20px} Packer

!!! info
    **Packer**[^packer] to narzędzie open-source stworzone przez HashiCorp, służące do automatycznego budowania, konfigurowania i zarządzania obrazami maszyn wirtualnych. Pozwala na tworzenie identycznych obrazów dla różnych platform, takich jak Proxmox, VMware, AWS, Azure, GCP, VirtualBox, Docker i inne.

### Kluczowe cechy Packer:
- **Obsługa wielu platform** – możliwość tworzenia obrazów dla różnych dostawców chmurowych i systemów wirtualizacji.
- **Deklaratywna konfiguracja** – używa HCL (HashiCorp Configuration Language) do definiowania procesu budowania obrazów.
- **Zautomatyzowane provisionowanie** – integracja z narzędziami jak Ansible, Chef, Puppet czy Shell do konfiguracji systemu.
- **Szybkie i powtarzalne buildy** – umożliwia automatyczne generowanie gotowych do użycia maszyn.

Packer znajduje zastosowanie w DevOps, CI/CD oraz automatyzacji infrastruktury, ułatwiając zarządzanie spójnymi środowiskami testowymi i produkcyjnymi.

[^packer]: źródło: [https://developer.hashicorp.com/packer/docs?product_intent=packer](https://developer.hashicorp.com/packer/docs?product_intent=packer)
