---
title: Epic 3
hide:
- navigation
---
# [Epic 3 - Utworzenie centralnego miejsca do przechowywania dokumentacji](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-61)

!!! notes
    😎 Projekt zakłada uruchomienie centralnej dokumentacji technicznej rachuna-net, zautomatyzowanej i dostępnej publicznie przez GitLab Pages, zintegrowanej z domeną firmową. Ułatwi to zarządzanie wiedzą, onboarding i rozwój projektów.

## [🎯 Cel epiki](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-61)

Celem tego epika jest kompleksowe opracowanie i wdrożenie systemu dokumentacji technicznej dla projektów realizowanych w ramach organizacji rachuna-net. Dokumentacja ma być publikowana w nowym repozytorium pl.rachuna-net/docs, hostowana pod domeną rachuna-net.pl i dostępna w nowoczesnej, łatwej do aktualizacji formie, z wykorzystaniem frameworka mkdocs.

Zakres prac obejmuje:

* Utworzenie dedykowanych repozytoriów dla dokumentacji i kontenerów wspierających proces publikacji.
* Stworzenie kontenera mkdocs oraz zautomatyzowanego procesu publikacyjnego.
* Integrację z domeną rachuna-net.pl w celu zapewnienia publicznego dostępu do dokumentacji.
* Integrację GitLab Pages z domeną rachuna-net.pl jako mechanizmu publikacji statycznej dokumentacji.
* Uzupełnienie brakujących sekcji dokumentacyjnych dotyczących projektów infrastrukturalnych, CI/CD oraz kontenerów.
* Realizacja tego epika zapewni ustandaryzowaną, centralną i łatwo dostępną platformę dokumentacyjną wspierającą rozwój oraz utrzymanie systemów i infrastruktury w organizacji.

---
## Przygotowanie grup i repozytoriów za pomocą Terraform

* [x] [DEVOPS-110](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-110): Definicja repozytorium [pl.rachuna-net/docs](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/docs.tf?ref_type=heads)
* [x] [DEVOPS-106](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-106): Definicja repozytorium [pl.rachuna-net/containers/mkdocs](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab/-/blob/main/pl.rachuna-net/containers/mkdocs.tf?ref_type=heads)

---
## Przygotowanie procesu CI/CD
* [x] [DEVOPS-107](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-107): Utworzenie kontenera mkdocs [v1.0.0](https://gitlab.com/pl.rachuna-net/containers/mkdocs/-/releases/v1.0.0)
* [x] [DEVOPS-108](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-108): Stworzenie procesu do publikacji mkdocs

---
## Wydanie dokumentacji
* [x] [DEVOPS-62](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-62): Wydanie wstępu do dokumentacji na [pl.rachuna-net.pl/gitlab-profile](https://gitlab.com/pl.rachuna-net/gitlab-profile/-/releases/v1.0.0)
* [x] [DEVOPS-77](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-77): Uzupełnienie dokumentacji projects/gitlab/Gitlab-CI/components/
* [x] [DEVOPS-78](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-78): Uzupełnienie dokumentacji projects/gitlab/Gitlab-CI/pipelines/
* [x] [DEVOPS-76](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-76):Utworzenie dokumentacji dla kontenerów

---
## Publikacja gitlab-pages i integracja z domeną
* [x] [DEVOPS-109](https://rachuna-net-pl.atlassian.net/browse/DEVOPS-109): Integracja z gitlab-pages zbudowane na mkdocs z domeną rachuna-net.pl
