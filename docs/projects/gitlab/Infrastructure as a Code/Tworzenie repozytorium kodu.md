---
title: Tworzenie repozytorium
description: Tworzenie repozytorium w GitLab za pomocą Terraform
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} Tworzenie repozytorium w GitLab za pomocą Terraform

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

📄 **Ścieżka pliku:** `pl.rachuna-net/containers/terraform.tf`

```hcl
module "terraform" {
  source = "git@gitlab.com:pl.rachuna-net/infrastructure/terraform/modules/gitlab-project.git?ref=v1.0.0"

  name        = "terraform"
  description = "Obraz Dockerowy z narzędziem Terraform."
  visibility  = "public"
  tags        = ["docker", "terraform"]
  icon_type   = "terraform"

  parent_group = local.parent_name
  project_type = local.project_type

  # sonarqube
  sonarqube_cloud_project_id = "pl.rachuna-net_terraform"
  is_enabled_sonarqube       = true
}
```

---
### Weryfikacja planu Terraform

Po zapisaniu konfiguracji należy uruchomić polecenie `terraform plan`, które zwróci listę planowanych zmian:

```bash
(...)
Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create
Terraform will perform the following actions:
  (...)
  # module.pl_rachuna-net.module.containers.module.terraform.gitlab_project.project will be created
  + resource "gitlab_project" "project" {
      + allow_merge_on_skipped_pipeline                  = (known after apply)
      + allow_pipeline_trigger_approve_deployment        = (known after apply)
      + analytics_access_level                           = (known after apply)
      + auto_cancel_pending_pipelines                    = (known after apply)
      + auto_devops_deploy_strategy                      = (known after apply)
      + auto_devops_enabled                              = (known after apply)
      + autoclose_referenced_issues                      = true
      + avatar                                           = ".terraform/modules/pl_rachuna-net.containers.terraform/images/terraform.png"
      + avatar_hash                                      = "f7cd482f4fc2f965b66c2fcc61dc1306013386b9843e9441f29b6880931d67a5"
      + avatar_url                                       = (known after apply)
      + build_git_strategy                               = "clone"
      + build_timeout                                    = (known after apply)
      + builds_access_level                              = (known after apply)
      + ci_config_path                                   = "containers/docker.yml@pl.rachuna-net/cicd/gitlab-ci"
      + ci_default_git_depth                             = (known after apply)
      + ci_forward_deployment_enabled                    = (known after apply)
      + ci_pipeline_variables_minimum_override_role      = (known after apply)
      + ci_restrict_pipeline_cancellation_role           = (known after apply)
      + ci_separated_caches                              = (known after apply)
      + container_registry_access_level                  = (known after apply)
      + container_registry_enabled                       = (known after apply)
      + default_branch                                   = (known after apply)
      + description                                      = "Terraform for Docker containers"
      + emails_enabled                                   = (known after apply)
      + empty_repo                                       = (known after apply)
      + environments_access_level                        = (known after apply)
      + feature_flags_access_level                       = (known after apply)
      + forking_access_level                             = (known after apply)
      + group_runners_enabled                            = (known after apply)
      + http_url_to_repo                                 = (known after apply)
      + id                                               = (known after apply)
      + infrastructure_access_level                      = (known after apply)
      + initialize_with_readme                           = true
      + issues_access_level                              = (known after apply)
      + issues_enabled                                   = (known after apply)
      + keep_latest_artifact                             = (known after apply)
      + lfs_enabled                                      = (known after apply)
      + merge_method                                     = (known after apply)
      + merge_pipelines_enabled                          = (known after apply)
      + merge_requests_access_level                      = (known after apply)
      + merge_requests_enabled                           = (known after apply)
      + merge_trains_enabled                             = (known after apply)
      + mirror_overwrites_diverged_branches              = (known after apply)
      + mirror_trigger_builds                            = (known after apply)
      + model_experiments_access_level                   = (known after apply)
      + model_registry_access_level                      = (known after apply)
      + monitor_access_level                             = (known after apply)
      + name                                             = "terraform"
      + namespace_id                                     = 105069007
      + only_allow_merge_if_all_discussions_are_resolved = (known after apply)
      + only_allow_merge_if_pipeline_succeeds            = (known after apply)
      + only_mirror_protected_branches                   = (known after apply)
      + packages_enabled                                 = (known after apply)
      + pages_access_level                               = (known after apply)
      + path_with_namespace                              = (known after apply)
      + pipelines_enabled                                = (known after apply)
      + pre_receive_secret_detection_enabled             = (known after apply)
      + prevent_merge_without_jira_issue                 = (known after apply)
      + printing_merge_request_link_enabled              = (known after apply)
      + public_builds                                    = (known after apply)
      + public_jobs                                      = (known after apply)
      + releases_access_level                            = (known after apply)
      + remove_source_branch_after_merge                 = (known after apply)
      + repository_access_level                          = (known after apply)
      + repository_storage                               = (known after apply)
      + request_access_enabled                           = (known after apply)
      + requirements_access_level                        = (known after apply)
      + restrict_user_defined_variables                  = (known after apply)
      + runners_token                                    = (sensitive value)
      + security_and_compliance_access_level             = (known after apply)
      + shared_runners_enabled                           = (known after apply)
      + snippets_access_level                            = (known after apply)
      + snippets_enabled                                 = (known after apply)
      + squash_option                                    = (known after apply)
      + ssh_url_to_repo                                  = (known after apply)
      + tags                                             = [
          + "docker",
          + "terraform",
        ]
      + topics                                           = (known after apply)
      + visibility_level                                 = "public"
      + web_url                                          = (known after apply)
      + wiki_access_level                                = (known after apply)
      + wiki_enabled                                     = (known after apply)

      + container_expiration_policy (known after apply)

      + push_rules (known after apply)
    }
    (...)
Plan: 13 to add, 0 to change, 0 to destroy.
```

---
### Wdrożenie zmian

Jeśli planowane zmiany są zgodne z oczekiwaniami, należy wdrożyć je do **`main`** poprzez **Merge Request (MR)**, co spowoduje utworzenie grupy repozytoriów w GitLab.

---
### Podsumowanie

Wdrożenie grupy repozytoriów w GitLab za pomocą Terraform zapewnia automatyzację, powtarzalność i centralizację zarządzania. Po poprawnym wykonaniu opisanych kroków, nowa grupa repozytoriów będzie gotowa do użytku.

🚀 **Gotowe!** Grupa repozytoriów została pomyślnie utworzona przy użyciu Terraform. 🎉

![](/projects/gitlab/Infrastructure as a Code/images/project_repository.png)