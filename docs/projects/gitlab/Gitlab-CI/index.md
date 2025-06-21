---
title: Infrastruktura procesów gitlab-ci
description: Infrastruktura procesów gitlab-ci
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){height=20px} Infrastruktura procesów gitlab-ci

**GitLab CI/CD**[^1] (Continuous Integration/Continuous Deployment) to wbudowany w **GitLab** system automatyzacji procesów budowania, testowania i wdrażania kodu. Działa na podstawie pliku konfiguracyjnego `.gitlab-ci.yml`, który definiuje **pipeline** – zestaw zadań wykonywanych automatycznie po zmianach w repozytorium.  

Pipeline składa się z **jobów** (zadań) pogrupowanych w **stage** (etapy), np. `build`, `test`, `deploy`. GitLab CI uruchamia je w określonej kolejności, a wykonanie może odbywać się na **GitLab Runnerach** – agentach uruchamiających zadania.  

Dzięki GitLab CI/CD możliwe jest **ciągłe dostarczanie (CD)**, czyli automatyczne wdrażanie aplikacji na produkcję lub do środowisk testowych. Obsługuje kontenery, chmury i infrastruktury on-premise, ułatwiając zarządzanie cyklem życia oprogramowania. 🚀

---
## Architektura projektu gitlab-ci w `pl.rachuna-net`

!!! question inline
    Kod źródłowy projektu znajduje się [tutaj](https://gitlab.com/pl.rachuna-net/cicd/ "https://gitlab.com/pl.rachuna-net/cicd/"). 

Projekt zawiera
```bash
├─ gitlab-ci                 # repozytorium z generycznymi procesami ci
└─ components                # grupa zawierająca komponenty (`ci/cd catalog`)
    ├── build                # zadania odpowiedzialne za budowanie
    ├── deploy               # zadania odpowiedzialne za deployment
    ├── integration-test     # zadania odpowiedzialne za testy integracyjne
    ├── publish              # zadania odpowiedzialne za publikacje artefaktów
    ├── sast                 # zadania odpowiedzialne za SAST
    ├── unit-test            # zadania odpowiedzialne za unit-test
    ├── validate             # zadania odpowiedzialne za validacje obiektów
    └── versioning           # zadania odpowiedzialne za wersjonowanie
```

!!! tip
    Taki podział komponentów jest bardzo dobry pod kątem odpowiedzialności różnych zespołów i ułatwia zarządzanie procesami CI/CD.

Projekt jest podzielony na logiczne komponenty, z których każdy odpowiada za określony etap w procesie CI/CD. Oto główne katalogi i ich funkcje:

- **components**: Zawiera komponenty odpowiedzialne za różne zadania, takie jak analiza statyczna kodu (SAST), testy jednostkowe, walidacja konfiguracji, budowanie i publikowanie artefaktów.
- **gitlab-ci**: Zawiera konfiguracje pipeline'ów, w tym pliki YAML definiujące etapy i zadania.
- **gitlab-profile**: Dokumentacja i skrypty wspierające konfigurację GitLab CI/CD.

---
### Rozdzielenie odpowiedzialności

Każdy komponent odpowiada za konkretny etap procesu CI/CD, co pozwala przypisać odpowiedzialność za jego rozwój i utrzymanie do odpowiedniego zespołu. Dzięki temu zespoły mogą skupić się na swoich specjalizacjach, co zwiększa efektywność i jakość pracy.

!!! Example
    **integration-test**: 
    
    Zespół testerów odpowiada za rozwój i utrzymanie testów integracyjnych. Dzięki temu mają pełną kontrolę nad tym, jak testy są definiowane i wykonywane.

    **unit-test**:

    Zespół deweloperów może odpowiadać za komponent testów jednostkowych, ponieważ to oni najlepiej znają kod i jego strukturę.

    **deploy**: 
    
    Zespół DevOps zarządza procesem wdrażania, co pozwala im na optymalizację i dostosowanie pipeline'ów do infrastruktury.

---

### Modularność i ponowne użycie
Każdy komponent jest niezależny i może być używany w różnych projektach. Dzięki temu można łatwo ponownie wykorzystać komponenty w różnych pipeline'ach.
Zmiany w jednym komponencie (np. sast dla analizy bezpieczeństwa) nie wpływają na inne części systemu.


### Skalowalność
Podział na komponenty pozwala na skalowanie zespołów i procesów. Nowe zespoły mogą łatwo przejąć odpowiedzialność za istniejące komponenty lub tworzyć nowe.
W miarę rozwoju organizacji można dodawać kolejne komponenty bez wpływu na istniejące.


### Łatwiejsze zarządzanie i utrzymanie
Każdy komponent jest odpowiedzialny za jedną rzecz (zgodnie z zasadą Single Responsibility Principle). Dzięki temu zmiany w jednym komponencie są łatwiejsze do zarządzania i testowania. Problemy są szybciej identyfikowane, ponieważ każdy komponent ma jasno określoną odpowiedzialność.


### Przejrzystość i współpraca
Taki podział ułatwia współpracę między zespołami. Każdy zespół wie, za co jest odpowiedzialny i jakie komponenty są w jego zakresie. Komponenty są jasno zdefiniowane, co ułatwia komunikację między zespołami.

---
## Kluczowe Etapy Pipeline'u

### 1. Walidacja Konfiguracji

Komponenty takie jak `validate` odpowiadają za sprawdzanie poprawności konfiguracji. Przykładowo, plik validate/docs/terraform.md opisuje, jak używać `terraform fmt` i `terraform validate` do walidacji kodu Terraform.

### 2. Testy Jednostkowe

Testy jednostkowe są kluczowym elementem każdego pipeline'u. Dokumentacja w unit-test/docs/terraform.md opisuje, jak uruchamiać `terraform plan` w celu analizy zmian w infrastrukturze.

### 3. Analiza Statyczna Kodów (SAST)

Komponent SAST, opisany w sast/docs/sonarqube-scanner.md, integruje się z SonarQube, aby przeprowadzać analizę statyczną kodu. Wymaga on dostępu do platformy SonarQube oraz obrazu kontenera `sonar-scanner`.

### 4. Budowanie i Publikowanie Artefaktów

Proces budowania i publikowania artefaktów jest opisany w build/docs/packer.md. Używane są narzędzia takie jak `packer`, które walidują i budują obrazy maszyn wirtualnych.

### 5. Wdrażanie

Komponent `deploy` odpowiada za wdrażanie aplikacji i infrastruktury. Dokumentacja w tym zakresie jest dostępna w katalogu deploy.


[^1]: [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/)