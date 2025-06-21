---
title: Epic 1
hide:
- navigation
---
# Epic 1 - Zarządzenie przestrzenią pl.rachuna-net w gitlab za pomocą terraform

!!! notes
    🔧 Automatyzacja GitLab z Terraform – nowy sposób zarządzania przestrzenią pl.rachuna-net
    W ramach działań porządkujących i automatyzujących infrastrukturę naszych zasobów w GitLabie, ukończony został pierwszy etap projektu Infrastructure as Code (IaC) w przestrzeni pl.rachuna-net.

---
## [🎯 Cel epiki](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-1)

Celem epiki jest uporządkowanie i pełne zautomatyzowanie zarządzania strukturą grup i projektów w przestrzeni pl.rachuna-net na GitLabie przy wykorzystaniu podejścia Infrastructure as Code (IaC) opartego na Terraformie. Zakres prac obejmuje:

- Utworzenie modułów Terraform do zarządzania grupami (gitlab-group), projektami (gitlab-project) oraz kontenerami (terraform).

- Manualną inwentaryzację istniejących zasobów (grupy, projekty, obrazy).

- Import istniejących zasobów do Terraform state (terraform import).

- Ujednolicenie struktury folderów i repozytoriów (infrastructure/terraform, modules, iac-gitlab, containers).

- Przeniesienie konfiguracji do zarządzalnych modułów oraz refaktoryzację kodu.

- Weryfikację poprawności działania wszystkich zasobów w CI/CD i przygotowanie środowiska do dalszej rozbudowy automatyzacji.

Epika zakłada stopniowe zastępowanie ręcznego zarządzania strukturą GitLab automatyzacją opartą o kod, co pozwoli na większą kontrolę, powtarzalność i łatwiejsze utrzymanie środowiska w dłuższym okresie czasu.

---
## Manualne tworzenie repozytoriów i grup

* [x] [DEVOPS-8](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-8): Utworzenie manualne grupy `pl.rachuna-net`
* [x] [DEVOPS-9](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-9): Utworzenie manualne grupy `pl.rachuna-net/infrastructure`
* [x] [DEVOPS-10](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-10): Utworzenie manualne repozytorium `pl.rachuna-net/infrastructure/terraform`
* [x] [DEVOPS-11](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-11): Utworzenie manualne repozytorium `pl.rachuna-net/infrastructure/terraform/modules`
* [x] [DEVOPS-12](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-12): Utworzenie manualne repozytorium `pl.rachuna-net/infrastructure/terraform/iac-gitlab`
* [x] [DEVOPS-13](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-13): Utworzenie manualne repozytorium `pl.rachuna-net/infrastructure/terraform/modules/gitlab-group`
* [x] [DEVOPS-14](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-14): Utworzenie manualne repozytorium `pl.rachuna-net/infrastructure/terraform/modules/gitlab-project`

---
## Moduły Terraform

* [x] [DEVOPS-19](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-19): Utworzenie modułu zarządzającego grupami [gitlab-group](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-group)
* [x] [DEVOPS-30](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-30): Utworzenie modułu zarządzającego projektami [gitlab-project](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project)

---
## Utworzenie obrazu z terraform

* [x] [DEVOPS-28](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-28): Utworzenie obrazu z [Terraform](https://gitlab.com/pl.rachuna-net/containers/terraform)


    ??? Example
        ```bash
        podman run -it -v $PWD:/terraform -v ~/.ssh:/root/.ssh -u root terraform:0.0.1 bash

        cd /terraform

        CI_SERVER_URL="https://gitlab.com"
        CI_PROJECT_ID="68613727"
        CI_USERNAME="mrachuna"
        CI_JOB_TOKEN="***"
        TF_STATE_NAME="default"

        terraform init \
          -backend-config="address=${CI_SERVER_URL}/api/v4/projects/${CI_PROJECT_ID}/terraform/state/${TF_STATE_NAME}" \
          -backend-config="lock_address=${CI_SERVER_URL}/api/v4/projects/${CI_PROJECT_ID}/terraform/state/${TF_STATE_NAME}/lock" \
          -backend-config="unlock_address=${CI_SERVER_URL}/api/v4/projects/${CI_PROJECT_ID}/terraform/state/${TF_STATE_NAME}/lock" \
          -backend-config="username=${CI_USERNAME}" \
          -backend-config="password=${CI_JOB_TOKEN}" \
          -backend-config="lock_method=POST" \
          -backend-config="unlock_method=DELETE" \
          -backend-config="retry_wait_min=5" \
          -lock=false \
          -migrate-state
        terraform import module.group_pl_rachuna-net.gitlab_group.group 105046057
        terraform plan
        terraform apply
        ```

---
## Import istniejących zasobów do Terraform

* [x] [DEVOPS-15](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-15): Definicja i import grupy `pl.rachuna-net`
* [x] [DEVOPS-16](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-16): Definicja i import grupy `pl.rachuna-net/infrastructure`
* [x] [DEVOPS-17](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-17): Definicja i import grupy `pl.rachuna-net/infrastructure/terraform`
* [x] [DEVOPS-18](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-18): Definicja i import grupy `pl.rachuna-net/infrastructure/terraform/modules`
* [x] [DEVOPS-23](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-23): Definicja i import grupy `pl.rachuna-net/infrastructure/terraform/iac-gitlab`
* [x] [DEVOPS-20](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-20): Definicja i import grupy `pl.rachuna-net/infrastructure/terraform/modules/gitlab-group`
* [x] [DEVOPS-21](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-21): Definicja i import grupy `pl.rachuna-net/infrastructure/terraform/modules/gitlab-project`

---
## Utworzenie zasobów do Terraform
* [x] [DEVOPS-24](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-24): Definicja grupy `pl.rachuna-net/containers`
* [x] [DEVOPS-25](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-25): Definicja i utworzenie repozytorium `pl.rachuna-net/containers/terraform`
* [x] [DEVOPS-27](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-27): Definicja i utworzenie repozytorium `pl.rachuna-net/gitlab-profile`
* [x] [DEVOPS-29](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-29): Definicja i utworzenie repozytorium `pl.rachuna-net/containers/gitlab-profile`
* [x] [DEVOPS-26](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-26): Definicja i utworzenie repozytorium `pl.rachuna-net/infrastructure/terraform/gitlab-profile`
