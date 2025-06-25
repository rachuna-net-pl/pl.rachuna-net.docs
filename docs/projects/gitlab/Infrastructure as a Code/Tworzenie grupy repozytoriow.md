---
title: Tworzenie grupy repozytoriów
description: Tworzenie grupy repozytoriów w GitLab za pomocą Terraform
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} Tworzenie grupy repozytoriów w GitLab za pomocą Terraform

Niniejsza sekcja dokumentacji opisuje proces tworzenia grupy repozytoriów w GitLab przy użyciu Terraform. Prezentowane podejście umożliwia automatyczne zarządzanie strukturą repozytoriów, co wspiera podejście **Infrastructure as Code (IaC)**.

!!! tips "Korzyści wynikające z użycia Terraform"

    Terraform pozwala na:

    - **Automatyzację** tworzenia i zarządzania grupami repozytoriów,
    - **Wersjonowanie konfiguracji**, co ułatwia kontrolę zmian,
    - **Powtarzalność konfiguracji**, eliminując błędy manualne.

---
### Definiowanie grupy w Terraform

Aby utworzyć grupę repozytoriów w GitLab, należy dodać odpowiednią definicję do pliku konfiguracyjnego Terraform. 

**Repozytorium GitLab zawierające definicję:**  
🔗 [GitLab: pl.rachuna-net/infrastructure/terraform/iac-gitlab](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/iac-gitlab)


####  Przykładowy plik konfiguracyjny Terraform

📄 **Ścieżka pliku:** `pl.rachuna-net/_containers.tf`

```hcl
module "_containers" {
  source = "git@gitlab.com:pl.rachuna-net/infrastructure/terraform/modules/gitlab-group.git?ref=v1.1.0"

  name         = "containers"
  description  = "Repozytoria z obrazami kontenerowymi."
  parent_group = local.parent_name
  visibility   = "public"
  icon_type    = "containers"
}

# Odkomentuj po utworzeniu modułu Packer i dodaniu pierwszego pliku w tym katalogu
# module "containers" {
#   source = "./containers/"
# }
```

---
### Weryfikacja planu Terraform

Po zapisaniu konfiguracji należy uruchomić polecenie `terraform plan`, które zwróci listę planowanych zmian:

```bash
(...)
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.pl_rachuna-net.module.group_containers.gitlab_group.group will be created
  + resource "gitlab_group" "group" {
      + allowed_email_domains_list         = (known after apply)
      + auto_devops_enabled                = (known after apply)
      + avatar                             = ".terraform/modules/pl_rachuna-net.group_containers/images/containers.png"
      + avatar_hash                        = "33c4b6c628d1857414db865643888fc2e32b52157f4cbe6c01305389cd8df351"
      + avatar_url                         = (known after apply)
      + default_branch                     = "main"
      + default_branch_protection          = (known after apply)
      + description                        = "Docker containers"
      + emails_enabled                     = (known after apply)
      + extra_shared_runners_minutes_limit = (known after apply)
      + full_name                          = (known after apply)
      + full_path                          = (known after apply)
      + id                                 = (known after apply)
      + lfs_enabled                        = (known after apply)
      + mentions_disabled                  = (known after apply)
      + name                               = "containers"
      + parent_id                          = 105046057
      + path                               = "containers"
      + permanently_remove_on_delete       = false
      + prevent_forking_outside_group      = (known after apply)
      + project_creation_level             = (known after apply)
      + request_access_enabled             = (known after apply)
      + require_two_factor_authentication  = (known after apply)
      + runners_token                      = (sensitive value)
      + share_with_group_lock              = (known after apply)
      + shared_runners_minutes_limit       = (known after apply)
      + shared_runners_setting             = (known after apply)
      + subgroup_creation_level            = (known after apply)
      + two_factor_grace_period            = (known after apply)
      + visibility_level                   = "public"
      + web_url                            = (known after apply)
      + wiki_access_level                  = (known after apply)

      + default_branch_protection_defaults (known after apply)

      + push_rules (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

---
### Wdrożenie zmian

Jeśli planowane zmiany są zgodne z oczekiwaniami, należy wdrożyć je do **`main`** poprzez **Merge Request (MR)**, co spowoduje utworzenie grupy repozytoriów w GitLab.

---
### Podsumowanie

Wdrożenie grupy repozytoriów w GitLab za pomocą Terraform zapewnia automatyzację, powtarzalność i centralizację zarządzania. Po poprawnym wykonaniu opisanych kroków, nowa grupa repozytoriów będzie gotowa do użytku.

🚀 **Gotowe!** Grupa repozytoriów została pomyślnie utworzona przy użyciu Terraform. 🎉

![](/projects/gitlab/Infrastructure as a Code/images/grp_infrastructure.png)