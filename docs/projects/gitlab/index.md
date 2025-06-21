---
title: Gitlab
description: Gitlab
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){width=20px} Gitlab
---

!!! info
    **GitLab**[^1] to kompleksowa platforma DevOps służąca do zarządzania cyklem życia oprogramowania – od planowania, przez wersjonowanie kodu, aż po testowanie, wdrażanie i monitorowanie. Oferuje zintegrowane narzędzia do zarządzania repozytoriami Git, ciągłej integracji i wdrażania (CI/CD), zarządzania zadaniami, a także kontroli dostępu i bezpieczeństwa. GitLab może działać jako usługa chmurowa (GitLab.com) lub być wdrożony lokalnie (self-hosted), co czyni go elastycznym rozwiązaniem zarówno dla małych zespołów, jak i dużych organizacji.


---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} [Infrastructure as a Code](Infrastructure as a Code/index.md)

Repozytorium zawiera infrastrukturę jako kod (IaC) dla środowiska GitLab, opartą o Terraform. Struktura projektu umożliwia zarządzanie grupami, projektami. 

---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} [Instalacja gitlab-runner](Instalacja Gitlab Runners.md)

Instalacja gitlab-runnera odbywa się za pomocą Terraform, którzy tworzy maszynę wirtualną (container proxmox), a instalacja usługi odbywa się za pomocą Ansible.

---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){width=20px} [Gitlab-CI](Gitlab-CI/index.md)

W projektach GitLab zaleca się stosowanie centralnego repozytorium z definicjami pipeline’ów oraz wspólnymi komponentami CI/CD, co pozwala na standaryzację i łatwiejsze zarządzanie procesami automatyzacji. Kluczowe znaczenie ma również zachowanie spójnej struktury plików `.gitlab-ci.yml`, w tym prawidłowa definicja stages, co ułatwia czytelność, utrzymanie i rozwój pipeline’ów w całej organizacji.

[^1]: [gitlab.com](https://gitlab.com)