---
title: Zasady pisania w gitlab-ci
description: Zasady pisania w gitlab-ci
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){height=20px} Zasady pisania w gitlab-ci

Dokument opisuje dobre praktyki, standardy oraz zalecaną strukturę plików `.gitlab-ci.yml` stosowaną w projektach, aby zapewnić czytelność, spójność i łatwość utrzymania pipeline'ów CI/CD w GitLab.

---
### Kolejność sekcji pliku `.gitlab-ci.yml`

Prawidłowa kolejność sekcji w pliku `.gitlab-ci.yml` ułatwia jego czytelność, utrzymanie oraz zapewnia spójność pomiędzy projektami.

```yaml
default:

include:
    - local: _configs/_stages.yml
    - local: _configs/_workflow.yml
    - local: _configs/_jobs_required.yml
    - local: _configs/jobs_docker.yml
    - local: _configs/jobs_terraform.yml

stages:
    ### Standard w ramach dyscypliny opisane w pliku _configs/_stages.yml
    - prepare           # przygotowanie środowiska, instalacja zależności, inicjalizacja.
    - validate          # weryfikacja poprawności konfiguracji, linting, planowanie zmian (Terraform, Ansible), pre-commit checks.
    - unit-test         # testy jednostkowe dla kodu (Go, .NET, Node.js itp.).
    - sast              # analiza statyczna kodu (Static Application Security Testing).
    - dast              # analiza dynamiczna aplikacji (Dynamic Application Security Testing).
    - build             # budowanie artefaktów (Packer, kontenery, kod źródłowy).
    - publish           # publikacja artefaktów, obrazów kontenerowych, paczek NuGet, npm itp.
    - deploy            # wdrażanie aplikacji, infrastruktury, konfiguracji.
    - integration-test  # testy integracyjne, e2e, testy akceptacyjne.
    - cleanup           # usuwanie tymczasowych zasobów, sprzątanie środowiska.

variables:
    # globalne zmienne środowiskowe używane w procesie

workflow:
    # opisanie kiedy pipeline jest uruchamiany (opcjonalnie)

# DEFINICJA JOBÓW
.job:base:
    # szablon dla joba danego typu
job:
    # job z szablonu

.job2:base:
    # szablon dla joba danego typu
job2:
    # job z szablonu

```

---
### Nazywanie i struktura jobów

Aby zapewnić spójność, każdy zdefiniowany job powinien składać się z szablonu `base` oraz zadań, które go rozszerzają i zawierają odpowiednie reguły (rules). W przeciwieństwie do szablonu, zadania te definiują warunki wykonania. Takie podejście umożliwia dostosowanie procesu do parametrów środowiska i rodzaju wyzwalacza. Poniżej znajduje się przykład wraz z opisem elementu procesu odpowiedzialnego za wdrożenie (deploy).

```yaml
.example:deploy:base:
    stage: deploy
    image: python3:latest
    variables:
        PROJECT_NAME: "${CI_REPOSITORY}"
    before_srcipt:
        - echo "before script"
    parallel:
        matrix:
            - OS_TYPE: ['windows', 'linux']
```
Powyżej przedstawiono definicję szablonu dla zadania `deploy`. Taka definicja nie będzie widoczna w pipeline, ponieważ użycie `.` na początku nazwy informuje GitLab, że jest to szablon przeznaczony do dziedziczenia.

```yaml
example:deploy:dry-run:
    extends: ['.example:deploy:base']
    script:
        - example deploy --dry-run
    rules:
        - if: $CI_COMMIT_TAG
          when: never
        - changes:
          - src/**
          - Dockerfile

example:deploy:
    extends: ['.example:deploy:base']
    script:
        - example deploy
    rules:
        - if: $CI_COMMIT_TAG
```

---
### Przekazywanie zmiennych między jobami

W przypadku, kiedy chcemy mieć możliwość parametryzacji procesu CI/CD za pomocą zmiennych, których wartość jest ustawiana w trakcie procesu (np. kolejna przewidywala wersja aplikacji) należy użyć odpowiedniego typu artefaktu w procesie [artifacts:reports:dotenv](https://docs.gitlab.com/ee/ci/yaml/artifacts_reports.html#artifactsreportsdotenv). Dobrą praktyką jest parametryzacja porcesu na początku i jego przepływu, dla przykładu

```yaml
prepare:
    stage: prepare
    script:
    - echo "APP_VERSION=1.0.0" >> prepare.env
    artifacts:
        reports:
            dotenv: prepare.env
```
Powyższy job stworzy odpowiedni plik `.env` ze zmienną APP_VERSION, którą następnie możemy wykorzystać w kolejnych jobach procesu np.:

```yaml
example:deploy:
    extends: ['.example:deploy:base']
    script:
        - echo "Wersja $APP_VERSION"
    rules:
        - if $COMMIT_TAG
    needs:
    - job: prepare
      artifacts: true
```
