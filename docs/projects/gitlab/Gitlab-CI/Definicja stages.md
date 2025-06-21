---
title: Definicja stages
description: Definicja stages
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){height=20px} Definicja stages

W ramach dyscypliny ustalono standard stages, w którym deweloper powinien się poruszać. [:octicons-arrow-right-24: _configs/_stages.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/_configs/_stages.yml?ref_type=heads)

---
Przykładowa zawartość pliku:
```yaml
---
stages:
    ### Standard w ramach dyscypliny
    - prepare           # przygotowanie środowiska, instalacja zależności, inicjalizacja.
    - validate          # weryfikacja poprawności konfiguracji, linting, planowanie zmian (Terraform, Ansible), pre-commit checks.
    - unit-test         # testy jednostkowe dla kodu (Go, .NET, Node.js itp.).
    - sast              # analiza statyczna kodu (Static Application Security Testing).
    - dast              # analiza dynamiczna aplikacji (Dynamic Application Security Testing).
    - build             # budowanie artefaktów (Packer, kontenery, kod źródłowy).
    - publish           # publikacja artefaktów, obrazów kontenerowych, paczek NuGet, npm itp.
    - release           # Wydawanie wersji
    - deploy            # wdrażanie aplikacji, infrastruktury, konfiguracji.
    - integration-test  # testy integracyjne, e2e, testy akceptacyjne.
    - cleanup           # usuwanie tymczasowych zasobów, sprzątanie środowiska.

```