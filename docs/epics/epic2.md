---
title: Epic 2
hide:
- navigation
---
# Epic 2 - Utworzenie procesów gitlab-ci

!!! notes
    🔁 Modularne CI/CD w GitLab – nowy etap automatyzacji w pl.rachuna-net  
    Rozpoczynamy wdrażanie spójnych, skalowalnych i wielokrotnego użytku pipeline’ów CI/CD, zgodnych z zasadami DevOps i podejściem komponentowym.

---
## [🎯 Cel epiki](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-31)

Celem epiki jest zaprojektowanie i wdrożenie ustandaryzowanych procesów CI/CD w przestrzeni pl.rachuna-net z wykorzystaniem GitLab CI, zgodnie z podejściem modularnym i komponentowym.

Projekt zakłada utworzenie dedykowanej struktury repozytoriów, komponentów oraz definicji pipeline’ów, które umożliwią zarządzanie i automatyzację procesów testowania, budowania, publikowania oraz wdrażania aplikacji i bibliotek w spójny, skalowalny sposób.

---
## Przygotowanie grup i repozytoriów za pomocą Terraform

### przestrzeń **pl.rachuna-net / cicd**

* [x] [DEVOPS-32](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-32): Definicja grupy [pl.rachuna-net/cicd](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/_cicd.tf?ref_type=heads)
* [x] [DEVOPS-33](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-33): Definicja grupy [pl.rachuna-net/cicd/components](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/_components.tf?ref_type=heads)
* [x] [DEVOPS-34](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-34): Definicja repozytorium [pl.rachuna-net/cicd/gitlab-profile](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/gitlab-profile.tf?ref_type=heads)
* [x] [DEVOPS-35](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-35): Definicja repozytorium [pl.rachuna-net/cicd/gitlab-ci](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/gitlab-ci.tf?ref_type=heads)
* [x] [DEVOPS-36](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-36): Definicja repozytorium [pl.rachuna-net/cicd/components/release](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/release.tf?ref_type=heads)
* [x] [DEVOPS-37](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-37): Definicja repozytorium [pl.rachuna-net/cicd/components/validate](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/validate.tf?ref_type=heads)
* [x] [DEVOPS-38](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-38): Definicja repozytorium [pl.rachuna-net/cicd/components/unit-tests](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/unit-tests.tf?ref_type=heads)
* [x] [DEVOPS-39](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-39):  Definicja repozytorium [pl.rachuna-net/cicd/components/build](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/build.tf?ref_type=heads)
* [x] [DEVOPS-40](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-40): Definicja repozytorium [pl.rachuna-net/cicd/components/publish](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/publish.tf?ref_type=heads)
* [x] [DEVOPS-41](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-41): Definicja repozytorium [pl.rachuna-net/cicd/components/deploy](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/deploy.tf?ref_type=heads)
* [x] [DEVOPS-42](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-42):  Definicja repozytorium [pl.rachuna-net/cicd/components/integration-test](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/integration-test.tf?ref_type=heads)
* [x] [DEVOPS-104](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-104):  Definicja repozytorium [pl.rachuna-net/cicd/components/prepare](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/prepare.tf?ref_type=heads)


### przestrzeń **pl.rachuna-net / containers**
* [x] [DEVOPS-58](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-58): Utworzenie repozytorium [pl.rachuna-net/containers/semantic-release](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/containers/semantic-release.tf?ref_type=heads)
* [x] [DEVOPS-44](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-44): Przygotowanie repozytorium [pl.rachuna-net/containers/python](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/containers/python.tf?ref_type=heads)
* [x] [DEVOPS-81](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-81): Przygotowanie repozytorium [pl.rachuna-net/containers/vault](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/containers/vault.tf?ref_type=heads)

---
### (prepare) Przygotowanie procesu

* [x] [DEVOPS-105](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-105): Przygotowanie komponentu wyświetlającego dane o procesie [v1.0.2](https://gitlab.com/pl.rachuna-net/cicd/components/prepare/-/releases/v1.0.2)
* [x] [DEVOPS-101](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-101): Dopisanie w module terraform gitlab-project obsługę variables dla projektu [v1.1.0](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/releases/v1.1.0)
* [x] [DEVOPS-57](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-57): Integracja z terraform z vault
* [x] [DEVOPS-63](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-63): Ustawianie variables w grupie root (pl.rachuna-net) przez terraform iac-gitlab
---
### (validate) Walidacja

#### yamllint 
* [x] [DEVOPS-49](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-49): Utworzenie obrazu kontenerowego python [v1.0.2](https://gitlab.com/pl.rachuna-net/containers/python/-/blob/main/Dockerfile?ref_type=heads)
* [x] [DEVOPS-51](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-51): Utworzenie komponentu z użyciem `yamlint` [v1.1.0](https://gitlab.com/pl.rachuna-net/cicd/components/validate/-/releases/v1.1.0)

#### terraform fmt i validate
* [x] [DEVOPS-60](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-60): Utworzenie kontenerowego terraform [v1.1.2](https://gitlab.com/pl.rachuna-net/containers/terraform/-/releases/v1.1.2)
* [x] [DEVOPS-51](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-51): Utworzenie komponentu z użyciem `terraform fmt` i `validate` [v1.0.0](https://gitlab.com/pl.rachuna-net/cicd/components/validate/-/releases/v1.0.1)

---
### (unit-test) Unit-Test

#### terraform plan
* [x] [DEVOPS-52](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-52): Utworzenie komponentu z użyciem terraform plan [v1.0.1](https://gitlab.com/pl.rachuna-net/cicd/components/unit-test/-/releases/v1.0.1)

---
### (build) Kompilacja

#### docker build
* [x] [DEVOPS-53](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-53): Utworzenie komponentu z docker build [v1.0.1](https://gitlab.com/pl.rachuna-net/cicd/components/build/-/releases/v1.0.1)

### (publish) Publikacja
---
#### docker publish
* [x] [DEVOPS-54](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-54): Utworzenie komponentu docker publish [v1.0.1](https://gitlab.com/pl.rachuna-net/cicd/components/publish/-/releases/v1.0.1)


---
### Komponent release

#### versioning
* [x] [DEVOPS-59](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-59): Utworzenie obrazu kontenerowego [semantic-release v1.0.1](https://gitlab.com/pl.rachuna-net/containers/semantic-release/-/releases/v1.0.1)
* [x] [DEVOPS-50](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-50): Wydanie komponentu z wersjonowaniem [v1.0.1](https://gitlab.com/pl.rachuna-net/cicd/components/versioning/-/releases/v1.0.1)

#### publish version in secret vault
* [x] [DEVOPS-82](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-82): Utworzenie obrazu kontenerowego vault [v1.0.0](https://gitlab.com/pl.rachuna-net/containers/vault/-/releases/v1.0.0)
* [x] [DEVOPS-83](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-83): Dodanie do komponentu release odkładania wersji w vaulcie [v1.1.0](https://gitlab.com/pl.rachuna-net/cicd/components/release/-/releases/v1.1.0)

---
### (deploy) Wdrożenie
---
#### terraform apply
* [x] [DEVOPS-55](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-55): Utworzenie komponentu z użyciem terraform apply [v1.0.0](https://gitlab.com/pl.rachuna-net/cicd/components/deploy/-/releases/v1.0.0)

---
### (integration-test) Test integracyjne

#### docker smoke-test
* [x] [DEVOPS-56](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-56): Utworzenie komponentu z smoketest dla docker [v1.0.0](https://gitlab.com/pl.rachuna-net/cicd/components/integration-test/-/releases/v1.0.0)

---
## Przygotowanie procesu ci/cd

* [x] [DEVOPS-45](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-45): Utworzenie [stages](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/_configs/_stages.yml?ref_type=heads)
* [x] [DEVOPS-46](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-46): Utworzenie [workflow](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/_configs/_workflow.yml?ref_type=heads)
* [x] [DEVOPS-80](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-80): Utworzenie procesu [default](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/.gitlab-ci.yml?ref_type=heads)
* [x] [DEVOPS-48](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-48): Utworzenie procesu dla budowania kontenerów [docker](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/containers/docker.yml?ref_type=heads)
* [x] [DEVOPS-47](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-47): Utworzenie procesu dla [terraform](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/infrastructure/terraform.yml?ref_type=heads)
