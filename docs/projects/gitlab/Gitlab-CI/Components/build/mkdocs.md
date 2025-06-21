---
title: mkdocs
---

!!! note
    Komponent `mkdocs-build` umożliwia automatyczne budowanie statycznej dokumentacji technicznej przy użyciu [MkDocs](https://www.mkdocs.org/) – popularnego narzędzia do tworzenia dokumentacji z plików Markdown. Dokumentacja jest generowana do katalogu `public/`, który może być później wykorzystany jako artefakt lub wdrożony np. za pomocą GitLab Pages.

---
## ⚙️ Parametry wejściowe (`inputs`)

| Nazwa          | Typ    | Domyślna wartość                                             | Opis                                                   |
| -------------- | ------ | ------------------------------------------------------------ | ------------------------------------------------------ |
| `docker_image` | string | `registry.gitlab.com/pl.rachuna-net/containers/mkdocs:1.0.0` | Obraz Dockera zawierający MkDocs i wymagane zależności |

---
## 🧬 Zmienne środowiskowe

| Nazwa zmiennej           | Wartość                      |
| ------------------------ | ---------------------------- |
| `CONTAINER_IMAGE_MKDOCS` | `$[[ inputs.docker_image ]]` |

---
## 🧱 Zależności

* **Pliki lokalne**:

  * `/source/logo.yml` – wyświetla logo komponentu
  * `/source/input_variables_mkdocs.yml` – ustawia dodatkowe zmienne środowiskowe, jeśli wymagane

* **Wymagany plik w repozytorium**:

  * `mkdocs.yml` – plik konfiguracyjny MkDocs
  * katalog `docs/` – zawierający dokumentację w formacie Markdown

---
## 🚀 Job: `build mkdocs project`

* Etap: `build`
* Buduje stronę dokumentacji MkDocs do katalogu `public/`
* Artefakty są zapisywane i mogą być wykorzystane np. w `pages:` lub `deploy:` jobach

### 📜 Skrypt

```bash
mkdocs build --site-dir public
```

### 📁 Artefakty

```yaml
artifacts:
  paths:
    - public
```

---
## 🧪 Przykład użycia

```yaml
include:
  - component: $CI_SERVER_FQDN/pl.rachuna-net/cicd/components/build/mkdocs@$COMPONENT_VERSION_BUILD
  ### release
  - local: _configs/release.yml

🚀 build mkdocs project:
  variables:
    CONTAINER_IMAGE_MKDOCS: $CONTAINER_IMAGE_MKDOCS
  rules:
    - when: on_success
```
