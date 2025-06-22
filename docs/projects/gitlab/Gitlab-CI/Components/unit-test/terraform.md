---
title: terraform
---

!!! note
    Komponent `terraform-plan` umożliwia wykonanie polecenia `terraform plan`, służącego do sprawdzenia planowanych zmian w infrastrukturze przed ich zastosowaniem. Wspiera integrację z backendem stanu Terraform oraz umożliwia ustawienie zmiennych, takich jak token GitLab czy tryb debugowania.

### ⚙️ Parametry wejściowe (`inputs`)

| Nazwa           | Typ    | Domyślna wartość                                                | Opis                                                                 |
| --------------- | ------ | --------------------------------------------------------------- | -------------------------------------------------------------------- |
| `docker_image`  | string | `registry.gitlab.com/pl.rachuna-net/containers/terraform:1.0.0` | Obraz Dockera z zainstalowanym Terraformem                           |
| `tf_state_name` | string | `default`                                                       | Nazwa pliku stanu Terraform (używana podczas inicjalizacji backendu) |
| `debug`         | string | `"false"`                                                       | Czy włączyć tryb debugowania (`TF_LOG=debug`)                        |

---
### 🧬 Zmienne środowiskowe

| Nazwa zmiennej              | Wartość                       |
| --------------------------- | ----------------------------- |
| `CONTAINER_IMAGE_TERRAFORM` | `$[[ inputs.docker_image ]]`  |
| `TF_STATE_NAME`             | `$[[ inputs.tf_state_name ]]` |
| `TF_VAR_gitlab_token`       | `$GITLAB_TOKEN`               |
| `DEBUG`                     | `$[[ inputs.debug ]]`         |

---
### 🧱 Zależności

* **Pliki lokalne**:

  * `/source/input_variables_terraform.yml` – konfiguracja zmiennych wejściowych
  * `/source/logo.yml` – logo komponentu
  * `/source/terraform_init.yml` – logika inicjalizacji backendu Terraform

* **Wymagana zmienna**: `GITLAB_TOKEN` (przekazywana jako `TF_VAR_gitlab_token`)

---
### 🧪 Job: `terraform plan`

* Wykonuje `terraform plan` na skonfigurowanym stanie Terraform.
* Umożliwia inspekcję planowanych zmian w infrastrukturze bez ich stosowania.
* Nie wykonuje się automatycznie – wymaga jawnego wywołania.

#### 📜 Skrypt

```bash
terraform plan
```

!!! info
    Inicjalizacja (`terraform init`) wykonywana jest w sekcji `before_script`.

---
### 🧪 Przykład użycia

```yaml
include:
  - component: $CI_SERVER_FQDN/pl.rachuna-net/cicd/components/unit-test/terraform@$COMPONENT_VERSION_UNIT_TEST
    inputs:
      docker_image: $CONTAINER_IMAGE_TERRAFORM

🧪 terraform plan:
  rules: !reference [.rule:unit-test:terraform, rules]
```