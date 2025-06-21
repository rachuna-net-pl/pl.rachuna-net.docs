---
title: terraform
---

!!! notes
    Komponent `terraform-apply` służy do **automatycznego wdrażania zmian infrastrukturalnych** za pomocą narzędzia [Terraform](https://www.terraform.io/). Działa w oparciu o wcześniej zainicjowany backend oraz dane stanu (state). Wspiera wersjonowanie obrazu Dockera oraz obsługę tokenu GitLaba.

    Job wykonuje `terraform apply -auto-approve`, co oznacza automatyczne zatwierdzanie zmian – powinien być używany tylko w zaufanych i kontrolowanych środowiskach.

---
## ⚙️ Parametry wejściowe (`inputs`)

| Nazwa           | Typ    | Domyślna wartość                                                | Opis                                                                 |
| --------------- | ------ | --------------------------------------------------------------- | -------------------------------------------------------------------- |
| `docker_image`  | string | `registry.gitlab.com/pl.rachuna-net/containers/terraform:1.0.0` | Obraz Dockera z zainstalowanym Terraformem                           |
| `tf_state_name` | string | `default`                                                       | Nazwa pliku stanu Terraform (używana podczas inicjalizacji backendu) |
| `debug`         | string | `"false"`                                                       | Czy włączyć tryb debugowania (`TF_LOG=debug`)                        |

---
## 🧬 Zmienne środowiskowe

| Nazwa zmiennej              | Wartość                       |
| --------------------------- | ----------------------------- |
| `CONTAINER_IMAGE_TERRAFORM` | `$[[ inputs.docker_image ]]`  |
| `TF_STATE_NAME`             | `$[[ inputs.tf_state_name ]]` |
| `TF_VAR_gitlab_token`       | `$GITLAB_TOKEN`               |
| `DEBUG`                     | `$[[ inputs.debug ]]`         |

---
## 🧱 Zależności

* **Pliki lokalne**:

  * `/source/input_variables_terraform.yml` – definiuje zmienne środowiskowe
  * `/source/logo.yml` – wyświetla logo komponentu
  * `/source/terraform_init.yml` – inicjalizuje backend Terraform

* Wymagana zmienna `GITLAB_TOKEN`, przekazywana jako `TF_VAR_gitlab_token`

---
## 💥 Job: `terraform apply`

* Wykonuje komendę `terraform apply -auto-approve`
* Stosuje wcześniej zdefiniowane plany i zmiany w infrastrukturze
* Nie wymaga interakcji ani zatwierdzania ręcznego

### 📜 Skrypt

```bash
terraform apply -auto-approve
```

!!! info
    Inicjalizacja (`terraform init`) jest wykonywana w `before_script`.

---
## 🧪 Przykład użycia

```yaml
include:
  - component: $CI_SERVER_FQDN/pl.rachuna-net/cicd/components/deploy/terraform@$COMPONENT_VERSION_DEPLOY
    inputs:
      docker_image: $CONTAINER_IMAGE_TERRAFORM

💥 terraform apply:
  rules: !reference [.rule:deploy:terraform, rules]
```