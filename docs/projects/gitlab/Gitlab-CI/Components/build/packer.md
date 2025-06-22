---
title: packer
---
!!! note
    Ten komponent służy do budowania szablonów maszyn wirtualnych za pomocą Packer.
    Wykorzystuje pliki `.hcl` znajdujące się w katalogu `pkrvars/`, a każde uruchomienie `packer build`
    generuje osobny szablon na podstawie odpowiedniego pliku zmiennych.

    Komponent używa kontenera z preinstalowanym Packerem i automatycznie inicjalizuje środowisko przed budowaniem.

### ⚙️ Parametry wejściowe (`inputs`)

| Nazwa          | Typ    | Domyślna wartość                                             | Opis                                     |
| -------------- | ------ | ------------------------------------------------------------ | ---------------------------------------- |
| `docker_image` | string | `registry.gitlab.com/pl.rachuna-net/containers/packer:1.0.0` | Obraz Dockera z preinstalowanym Packerem |

---
### 🧬 Zmienne środowiskowe

| Nazwa zmiennej           | Wartość                      |
| ------------------------ | ---------------------------- |
| `CONTAINER_IMAGE_PACKER` | `$[[ inputs.docker_image ]]` |
| `PACKER_LOG`             | `0`                          |

---
### 🧱 Zależności

* Pliki lokalne:

  * `/source/input_variables_packer.yml` – ustawienia dodatkowych zmiennych środowiskowych
  * `/source/logo.yml` – logo komponentu

* Wymaga plików `.pkr.hcl` i folderu `pkrvars/` zawierającego konfigurację szablonu maszyny wirtualnej

---
### 💥 Job budujący

#### 💥 Job: `packer build`

* Buduje obraz maszyny wirtualnej na podstawie plików `.hcl` znajdujących się w katalogu `pkrvars/`
* Poprzedzony komendą `packer init`
* Obsługuje wiele plików `*.hcl`
* Uruchamiany tylko ręcznie (`rules: when: never`)
* Domyślnie działa w trybie `-debug`

```bash
packer build -var-file=pkrvars/example.pkrvars.hcl -debug .
```

---
### 🧪 Przykład użycia

```yaml
include:
  - component: $CI_SERVER_FQDN/pl.rachuna-net/cicd/components/build/packer@$COMPONENT_VERSION_BUILD
    inputs:
      docker_image: $CONTAINER_IMAGE_PACKER

💥 packer build:
  rules: !reference [.rule:build:packer, rules]
```