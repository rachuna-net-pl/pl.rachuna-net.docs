---
date:
    created: 2025-05-12
authors:
    - maciej-rachuna
title: "VSCODE - Developowanie projektów terraform z użyciem kontenera"
categories:
    - vscode
tags:
    - vscode
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/container.png){height=20px} VSCODE - Developowanie projektów terraform z użyciem kontenera

Niniejszy wpis stanowi kontynuację poprzedniego artykułu: [![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/container.png){height=20px} **VS Code – Automatyczne uruchamianie kontenera MkDocs przy starcie projektu**](/blog/2025/05/03/vscode---automatyczne-uruchamianie-kontenera-mkdocs-przy-starcie-projektu/)

!!! info
    W tym materiale omówiono, jak skonfigurować środowisko Visual Studio Code do pracy z projektami Terraform w kontenerze Docker, w tym:

    - automatyczne pobieranie tagów obrazu Dockera z GitLab Container Registry,
    - uruchamianie planów Terraform z poziomu kontenera,
    - bezpieczne uwierzytelnianie przy użyciu klucza SSH i dostępu do prywatnych modułów.

<!-- more -->
---
## 🎯 Założenia

Skrypty dodane repozytorium [proxmox](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/commit/39299440b267841cbdbeb54208446062ec10197e)

Główne założenia to:

- Uruchamianie taska, który zrobi `terraform validate`
- Uruchamianie taska, który zrobi `terraform plan`
- Uruchamianie taska, który zrobi `terraform apply`

---
## ⚙️ Konfiguracja pliku `tasks.json`

W folderze `.vscode` projektu należy utworzyć (lub edytować) plik `tasks.json` o następującej zawartości:
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Update Docker Tags",
      "type": "shell",
      "command": "bash ${workspaceFolder}/scripts/vscode_tasks_update_docker_tags.bash",
      "runOptions": {
        "runOn": "folderOpen"
      },
      "problemMatcher": []
    },
    {
      "label": "terraform validate",
      "type": "shell",
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "--name",
        "terraform-dev",
        "-u",
        "root",
        "-v",
        "${workspaceFolder}:/terraform",
        "-v",
        "~/.ssh/gitlab-runner:/root/.ssh/gitlab-runner",
        "-v",
        "~/.profile:/root/.profile",
        "-v",
        "~/.gitconfig:/root/.gitconfig",
        "${input:dockerImage}",
        "bash",
        "-c",
        "cd /terraform && bash /terraform/scripts/terraform_validate.sh"
      ],
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "shared"
      }
    },
    {
      "label": "terraform plan",
      "type": "shell",
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "--name",
        "terraform-dev",
        "-u",
        "root",
        "-v",
        "${workspaceFolder}:/terraform",
        "-v",
        "~/.ssh/gitlab-runner:/root/.ssh/gitlab-runner",
        "-v",
        "~/.profile:/root/.profile",
        "-v",
        "~/.gitconfig:/root/.gitconfig",
        "${input:dockerImage}",
        "bash",
        "-c",
        "cd /terraform && bash /terraform/scripts/terraform_plan.sh"
      ],
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "shared"
      }
    },
    {
      "label": "terraform apply",
      "type": "shell",
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "--name",
        "terraform-dev",
        "-u",
        "root",
        "-v",
        "${workspaceFolder}:/terraform",
        "-v",
        "~/.ssh/gitlab-runner:/root/.ssh/gitlab-runner",
        "-v",
        "~/.profile:/root/.profile",
        "-v",
        "~/.gitconfig:/root/.gitconfig",
        "${input:dockerImage}",
        "bash",
        "-c",
        "cd /terraform && bash /terraform/scripts/terraform_apply.sh"
      ],
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "shared"
      }
    }
  ],
  "inputs": [
    {
      "id": "dockerImage",
      "type": "pickString",
      "description": "Wybierz obraz Dockera",
      "options": [
        "registry.gitlab.com/pl.rachuna-net/containers/terraform:1.0.0",
        "registry.gitlab.com/pl.rachuna-net/containers/terraform:1.0.1"
      ],
      "default": "registry.gitlab.com/pl.rachuna-net/containers/terraform:1.0.1"
    }
  ]
}
```

---
## 📟 Skrypty

Przykładowy skrypt `scripts/terraform_validate.sh`

```bash
#!/bin/bash
source .env
source ~/.profile

CI_SERVER_URL="https://gitlab.com"
CI_PROJECT_ID="69335832"
CI_USERNAME="${GITLAB_USER}"
CI_JOB_TOKEN="${GITLAB_TOKEN}"
TF_STATE_NAME="default"

# Terraform init
echo "🔗 Terraform init"
terraform init \
  -backend-config="address=${CI_SERVER_URL}/api/v4/projects/${CI_PROJECT_ID}/terraform/state/${TF_STATE_NAME}" \
  -backend-config="lock_address=${CI_SERVER_URL}/api/v4/projects/${CI_PROJECT_ID}/terraform/state/${TF_STATE_NAME}/lock" \
  -backend-config="unlock_address=${CI_SERVER_URL}/api/v4/projects/${CI_PROJECT_ID}/terraform/state/${TF_STATE_NAME}/lock" \
  -backend-config="username=${CI_USERNAME}" \
  -backend-config="password=${CI_JOB_TOKEN}" \
  -backend-config="lock_method=POST" \
  -backend-config="unlock_method=DELETE" \
  -backend-config="retry_wait_min=5"

echo "🕵 terraform fmt"
terraform fmt -recursive

echo "✅ terraform validate"
terraform validate
```