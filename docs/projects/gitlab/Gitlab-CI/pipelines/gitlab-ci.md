---
title: Gitlab-ci
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){width=20px} Gitlab-component

Gitlab-component to wydzielony, wielokrotnego użytku fragment konfiguracji lub jobów, który może być dołączany do różnych pipeline’ów w projektach GitLab. Umożliwia centralizację i ponowne wykorzystanie wspólnych zadań, szablonów oraz ustawień, co upraszcza zarządzanie procesami CI/CD i zapewnia spójność w całej organizacji.

---
## Gitlab-ci pipeline

![](images/gitlab-ci.png)

* **stage - prepare**
    * **👷 Set Version** -
      Ustawienie wersji budowanego artefaktu na podstawie convenctional commits
* **stage - validate**
    * **🕵 YAML lint** -
      Sprawdzenie formatowania plików konfiguracyjnych (`.yml` lub `.yaml`). Upewnia się, że składnia jest poprawna i zgodna z konwencją.
* **stage - release**
    * **📍 Publish Version** -
      Zatwierdzenie i publikacja wersji (np. dodanie tagu Git, zapisanie metadanych, aktualizacja zewnętrznego rejestru lub katalogu obrazów).
    * **🎉 Publish version in vault** -
      Pulikuje wersję jako secret vault do ponownego reużycia przez proces gitlab-ci
