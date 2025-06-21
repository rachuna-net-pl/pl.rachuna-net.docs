---
title: sonarqube
---

!!! note

    Komponent `sonar-scanner` służy do integracji z [SonarQube](https://www.sonarqube.org/) lub [SonarCloud](https://sonarcloud.io/) w celu analizy jakości kodu (SAST). Wspiera pełną konfigurację projektu z poziomu zmiennych `inputs`.

    Dzięki wsparciu dla tokenów, organizacji i źródeł – komponent działa niezależnie od języka i struktury projektu.

## ⚙️ Parametry wejściowe (`inputs`)

| Nazwa                       | Typ    | Domyślna wartość                                                    | Opis                                                |
| --------------------------- | ------ | ------------------------------------------------------------------- | --------------------------------------------------- |
| `docker_image`              | string | `registry.gitlab.com/pl.rachuna-net/containers/sonar-scanner:1.0.0` | Obraz Dockera z narzędziem `sonar-scanner`          |
| `sonar_user_home`           | string | `${CI_PROJECT_DIR}/.sonar`                                          | Katalog użytkownika Sonara                          |
| `sonar_host_url`            | string | `https://sonarcloud.io`                                             | URL do instancji Sonar                              |
| `sonar_organization`        | string | `pl-rachuna-net`                                                    | Nazwa organizacji w SonarCloud                      |
| `sonar_project_name`        | string | `""`                                                                | Nazwa projektu Sonar                                |
| `sonar_project_key`         | string | `""`                                                                | Unikalny klucz projektu Sonar                       |
| `sonar_token`               | string | `""`                                                                | Token API do uwierzytelnienia (np. z CI/CD secrets) |
| `sonar_project_description` | string | `""`                                                                | Opis projektu                                       |
| `sonar_project_version`     | string | `1.0.0`                                                             | Wersja projektu                                     |
| `sonar_sources`             | string | `"."`                                                               | Ścieżka do źródeł                                   |

---
## 🧬 Zmienne środowiskowe

| Nazwa zmiennej              | Wartość                                            |
| --------------------------- | -------------------------------------------------- |
| `DOCKER_IMAGE`              | `$[[ inputs.docker_image ]]`                       |
| `SONAR_USER_HOME`           | `$[[ inputs.sonar_user_home ]]`                    |
| `SONAR_HOST_URL`            | `$[[ inputs.sonar_host_url ]]`                     |
| `SONAR_ORGANIZATION`        | `$[[ inputs.sonar_organization ]]`                 |
| `SONAR_PROJECT_KEY`         | `$[[ inputs.sonar_project_key ]]`                  |
| `SONAR_PROJECT_NAME`        | `$[[ inputs.sonar_project_name ]]`                 |
| `SONAR_PROJECT_DESCRIPTION` | `$[[ inputs.sonar_project_description ]]`          |
| `SONAR_PROJECT_VERSION`     | `$[[ inputs.sonar_project_version ]]`              |
| `SONAR_SOURCES`             | `$[[ inputs.sonar_sources ]]`                      |
| `SONAR_TOKEN`               | `$[[ inputs.sonar_token ]]`                        |
| `GIT_DEPTH`                 | `0` (wymagane przez Sonar do analizy historii Git) |

---
## 🧱 Zależności

* Pliki lokalne:

  * `/source/logo.yml` – wyświetlenie logo komponentu
  * `/source/sonarqube_init.yml` – inicjalizacja konfiguracji Sonar
  * `/source/input_variables_sonarqube.yml` – przypisanie zmiennych wejściowych

* Wymagany token `SONAR_TOKEN`, najlepiej jako zmienna `CI/CD secret`

---
## 💪 Job: `sonarqube scanner`

* Wykonuje analizę jakości kodu za pomocą `sonar-scanner`.
* Zbierane dane: błędy, pokrycie testami, duplicaty, wskaźniki jakości.

### 📜 Skrypt

```bash
sonar-scanner \
  -Dsonar.projectKey="${SONAR_PROJECT_KEY}" \
  -Dsonar.organization="${SONAR_ORGANIZATION}" \
  -Dsonar.projectName="${SONAR_PROJECT_NAME}" \
  -Dsonar.projectDescription="${CI_PROJECT_DESCRIPTION}" \
  -Dsonar.projectVersion="${SONAR_PROJECT_VERSION}" \
  -Dsonar.sources="${SONAR_SOURCES}" \
  -Dsonar.sourceEncoding=UTF-8 \
  -Dsonar.token="${SONAR_TOKEN}"
```

---
## 🧪 Przykład użycia

```yaml
include:
  - component: $CI_SERVER_FQDN/pl.rachuna-net/cicd/components/sast/sonarqube@$COMPONENT_VERSION_SAST
    inputs:
      docker_image: $CONTAINER_IMAGE_SONAR_SCANNER


💪 sonarqube scanner:
  needs:
    - job: 🕵 Set Version
      artifacts: true
  variables:
    SONAR_PROJECT_KEY: $SONARQUBE_CLOUD_PROJECT_ID
    SONAR_PROJECT_VERSION: $RELEASE_CANDIDATE_VERSION
  rules:
    - if: $IS_ENABLED_SONARQUBE != "true"
      when: never
    - if: $CI_COMMIT_TAG
      when: never
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
      when: on_success
    - if: $CI_OPEN_MERGE_REQUESTS
      when: on_success

```