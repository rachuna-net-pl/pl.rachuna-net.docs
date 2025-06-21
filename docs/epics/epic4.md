---
title: Epic 4
hide:
- navigation
---
# Epic 4 - Integracja z Sonarqube cloud

!!! notes
    Proces obejmuje utworzenie organizacji w **SonarCloud**, przygotowanie kontenera sonar-scanner, komponentu sast oraz pełną integrację repozytoriów CI/CD i kontenerów. Dzięki wykorzystaniu infrastruktury jako kodu (Terraform) oraz zapytań GraphQL do GitLaba, integracja będzie skalowalna i łatwa w utrzymaniu.

---
## [🎯 Cel epiki](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-64)

Celem epika jest pełna integracja środowiska CI/CD grupy `pl.rachuna-net` z platformą **SonarCloud** – usługą typu SaaS dostarczaną przez SonarSource. Inicjatywa ta ma na celu zapewnienie **ciągłej analizy jakości kodu**, wykrywanie błędów, debtu technicznego i luk bezpieczeństwa w całym łańcuchu buildów, w sposób spójny i zautomatyzowany.

Zakres obejmuje:

* utworzenie organizacji SonarCloud i repozytoriów infrastrukturalnych,
* zbudowanie kontenera `sonar-scanner`,
* utworzenie komponentu `sast` do analiz statycznych,
* skalowalną integrację z wszystkimi repozytoriami GitLab w ramach `pl.rachuna-net` (poprzez GraphQL),
* wdrożenie mechanizmu automatycznego podłączania projektów do SonarQube na poziomie komponentów CI/CD i kontenerów.

---
## Czynności manualne
* [x] [DEVOPS-65](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-65): Utworzenie organizacji w [https://sonarcloud.io](https://sonarcloud.io/organizations/pl-rachuna-net/projects?sort=name&view=leak)

---
## Przygotowanie grup i repozytoriów za pomocą Terraform

* [x] [DEVOPS-66](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-66): Definicja repozytorium [pl.rachuna-net/containers/sonar-scanner](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/containers/sonar-scanner.tf?ref_type=heads)
* [x] [DEVOPS-67](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-67): Definicja repozytorium [pl.rachuna-net/cicd/components/sast](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/cicd/components/sast.tf?ref_type=heads)

---
## Utworzenie obrazu sonar-scanner

* [x] [DEVOPS-68](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-68): Utworzenie obrazu z `sonar-scanner-cli` - [v1.0.0](https://gitlab.com/pl.rachuna-net/containers/sonar-scanner/-/releases/v1.0.0)

---
## components/sonarqube

* [x] [DEVOPS-69](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-69):  Utworzenie komponentu [sast](https://gitlab.com/pl.rachuna-net/cicd/components/sast/-/releases/v1.0.0)

---
## Skalowanie rozwiązania

Wyciągniecie wszytkistkich repozytoriów z [graphql](https://gitlab.com/-/graphql-explorer)
```
query groupProjects {
  group(fullPath: "pl.rachuna-net") {
    projects(includeSubgroups: true)
    {
      nodes {
        fullPath
      },
    }
  }
}
```

* [x] [DEVOPS-111](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-111): Integracja z Sonarque `pl.rachuna-net/containers/mkdocs`
* [x] [DEVOPS-79](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-79): Integracja z Sonarque `pl.rachuna-net/containers/python`
* [x] [DEVOPS-74](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-74): Integracja z Sonarque `pl.rachuna-net/containers/semantic-release`
* [x] [DEVOPS-73](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-73): Integracja z Sonarque `pl.rachuna-net/containers/sonar-scanner`
* [x] [DEVOPS-75](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-75): Integracja z Sonarque `pl.rachuna-net/containers/sonar-terraform`
* [x] [DEVOPS-102](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-102): Integracja z Sonarque `pl.rachuna-net/containers/vault`
* [x] [DEVOPS-70](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-70): Integracja z Sonarque `pl.rachuna-net/infrastructure/terraform/iac-gitlab`
* [x] [DEVOPS-72](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-72): Integracja z Sonarque `pl.rachuna-net/infrastructure/terraform/modules/gitlab-group`
* [x] [DEVOPS-71](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-71): Integracja z Sonarque `pl.rachuna-net/infrastructure/terraform/modules/gitlab-project`
