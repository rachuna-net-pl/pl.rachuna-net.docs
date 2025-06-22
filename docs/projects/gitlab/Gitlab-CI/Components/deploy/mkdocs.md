---
title: mkdocs
---

!!! note
    Komponent `mkdocs-deploy` umożliwia automatyczne **publikowanie statycznej dokumentacji z MkDocs do GitLab Pages**. Wykorzystuje mechanizm GitLab Pages do hostowania wygenerowanej strony internetowej bez konieczności użycia dodatkowych serwerów czy zewnętrznej infrastruktury.

    Ten komponent zakłada, że dokumentacja została wcześniej zbudowana i znajduje się w katalogu `public/`.

---
### ⚙️ Parametry wejściowe (`inputs`)

| Nazwa          | Typ    | Domyślna wartość                                             | Opis                                       |
| -------------- | ------ | ------------------------------------------------------------ | ------------------------------------------ |
| `docker_image` | string | `registry.gitlab.com/pl.rachuna-net/containers/mkdocs:1.0.0` | Obraz Dockera używany do publikacji strony |

---
### 🧬 Zmienne środowiskowe

| Nazwa zmiennej          | Wartość                      |
| ----------------------- | ---------------------------- |
| `CONTAINER_IMAGE_PAGES` | `$[[ inputs.docker_image ]]` |

---
### 🧱 Zależności

* **Pliki lokalne**:

  * `/source/logo.yml` – logo komponentu
  * `/source/input_variables_mkdocs.yml` – zmienne wspierające MkDocs

* **Katalog `public/`**:

  * Musi zawierać zawartość strony MkDocs (wynik działania `mkdocs build`)

---
### 💿 Job: `mkdocs deploy`

* Etap: `deploy`
* Publikuje zawartość katalogu `public/` jako stronę GitLab Pages
* Obsługuje środowiska (`environment:`) z dynamicznym URL

#### 📜 Skrypt

```bash
git config --global --add safe.directory ${CI_PROJECT_DIR}
# Wyświetlenie logo i zmiennych (z .logo i .input-variables-mkdocs)
```

#### 📁 Publikacja do GitLab Pages

```yaml
pages:
  publish: public
```

!!! warning
    Katalog `public/` musi istnieć – powinien zostać wygenerowany wcześniej, np. przez komponent `mkdocs-build`.

---
### 🌐 Środowisko

```yaml
environment:
  name: $CI_COMMIT_REF_NAME
  url: https://$CI_PROJECT_NAMESPACE.gitlab.io/$CI_PROJECT_NAME
```

Dzięki temu:

* adres strony jest dostępny w GitLab UI
* strona będzie publicznie widoczna pod URL-em zależnym od projektu i namespace'u

---
### 🧪 Przykład użycia

```yaml
include:
  - component: $CI_SERVER_FQDN/pl.rachuna-net/cicd/components/deploy/pages@$COMPONENT_VERSION_DEPLOY

💿 mkdocs deploy:
  needs:
    - job: 🚀 build mkdocs project
      artifacts: true
  variables:
    CONTAINER_IMAGE_PAGES: $CONTAINER_IMAGE_MKDOCS
  rules: !reference [.rule:deploy:mkdocs, rules]
```