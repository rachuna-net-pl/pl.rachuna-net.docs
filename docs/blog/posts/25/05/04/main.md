---
date:
    created: 2025-05-04
authors:
    - maciej-rachuna
title: VSCODE - Developowanie projektów packer z użyciem kontenera
tags:
    - vscode
    - packer
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/packer.png){height=20px} VSCODE - Developowanie projektów packer z użyciem kontenera

Niniejszy wpis stanowi kontynuację poprzedniego artykułu: [![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/container.png){height=20px} **VS Code – Automatyczne uruchamianie kontenera MkDocs przy starcie projektu**](/blog/2025/05/03/vscode---automatyczne-uruchamianie-kontenera-mkdocs-przy-starcie-projektu/)

!!! info
    W tym materiale omówiono, jak skonfigurować środowisko Visual Studio Code do pracy z projektami Packer w kontenerze Docker, w tym:

    - automatyczne pobieranie tagów obrazu Dockera z GitLab Container Registry,
    - uruchamianie planów Terraform z poziomu kontenera,
    - bezpieczne uwierzytelnianie przy użyciu klucza SSH i dostępu do prywatnych modułów.

<!-- more -->
---
## 🎯 Założenia

Skrypty dodane repozytorium [ubuntu](https://gitlab.com/pl.rachuna-net/infrastructure/packer/ubuntu/-/commit/4baaa955abba291ad9ad0e4a069675dc17c8cae3?merge_request_iid=3)

Główne założenia to:

- Uruchamianie taska, który zrobi `Update Docker Tags`
- Uruchamianie taska, który zrobi `[PACKER] Packer fmt`
- Uruchamianie taska, który zrobi `[PACKER] Packer validate`
- Uruchamianie taska, który zrobi `[PACKER] Packer build`


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
      "label": "[PACKER] Packer fmt",
      "type": "shell",
      "command": "docker run --rm --name packer-dev -u root -v ${workspaceFolder}:/packer -v ~/.profile:/root/.profile ${input:packer_image} bash -c 'cd /packer && bash /packer/scripts/packer_fmt.bash'",
      "args": [],
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "shared"
      }
    },
    {
      "label": "[PACKER] Packer validate",
      "type": "shell",
      "command": "docker run --rm --name packer-dev -u root -v ${workspaceFolder}:/packer -v ~/.profile:/root/.profile ${input:packer_image} bash -c 'cd /packer && bash /packer/scripts/packer_validate.bash'",
      "args": [],
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "shared"
      }
    },
    {
      "label": "[PACKER] Packer build",
      "type": "shell",
      "command": "docker run --rm --name packer-dev -u root -v ${workspaceFolder}:/packer -v ~/.profile:/root/.profile ${input:packer_image} bash -c 'cd /packer && bash /packer/scripts/packer_build.bash'",
      "args": [],
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "shared"
      }
    },
  ],
  "inputs": [
    {
      "id": "packer_image",
      "type": "pickString",
      "description": "Wybierz obraz Dockera",
      "options": [
        "registry.gitlab.com/pl.rachuna-net/containers/packer:1.0.0",
        "registry.gitlab.com/pl.rachuna-net/containers/packer:1.0.1"
      ],
      "default": "registry.gitlab.com/pl.rachuna-net/containers/packer:1.0.1"
    },
  ]
}
```
---
## 💲 Env
.env
```bash
#!/usr/bin/env bash

export PACKER_PROJECT_ID="69245188"
export PACKER_REGISTRY_ID="8589299"
export CONTAINER_PROJECT_ID=$PACKER_PROJECT_ID
export CONTAINER_REGISTRY_ID=$PACKER_REGISTRY_ID

export PACKER_LOG=1

#### PROXMOX CLUSTER VARIABLES ####
export PKR_VAR_proxmox_node_name="xxx"
export PKR_VAR_proxmox_api_username="root@pam"
export PKR_VAR_proxmox_api_password="xxx"
export PKR_VAR_proxmox_api_tls_verify="false"

### ISO VARIABLES ###
export PKR_VAR_iso_storage_pool="local"

### VM VARIABLES ###
export PKR_VAR_vm_id="901"
export PKR_VAR_ssh_username="xxx"
export PKR_VAR_ssh_password="xxx"
export PKR_VAR_ssh_public_key="ssh..."
```


---
## 📟 Skrypty

Przykładowy skrypt `scripts/packer_fmt.bash`

```bash
#!/usr/bin/env bash

set -euxo pipefail
source .env


packer init .
for file in $(find pkrvars -type f -name "*.hcl"); do
    # walidacja pod kątem formatowania
    packer fmt -var-file=$file .
done
```

Przykładowy skrypt `scripts/packer_validate.bash`

```bash
#!/usr/bin/env bash

set -euxo pipefail
source .env


packer init .
for file in $(find pkrvars -type f -name "*.hcl"); do
    # walidacja pod kątem semantyki
    packer validate -var-file=$file .
done
```

Przykładowy skrypt `scripts/packer_build.bash`

```bash
#!/usr/bin/env bash

set -euxo pipefail
source .env


packer init .
for file in $(find pkrvars -type f -name "*.hcl"); do
    # Create a new vm template
    packer build -var-file=$file .
done
```

Przykładowy skrypt `scripts/vscode_tasks_update_docker_tags.bash`
```bash
#!/usr/bin/env bash

set -euo pipefail
source ~/.profile
source .env

OUTPUT_FILE=".vscode/tasks.json"
AUTH_HEADER="PRIVATE-TOKEN: $GITLAB_TOKEN"

# Pobierz listę tagów z rejestru
TEST_CURL=$(curl -s -H "$AUTH_HEADER" "https://gitlab.com/api/v4/projects/${CONTAINER_PROJECT_ID}/registry/repositories/${CONTAINER_REGISTRY_ID}/tags")
echo $TEST_CURL

TAGS=$(curl -s -H "$AUTH_HEADER" "https://gitlab.com/api/v4/projects/${CONTAINER_PROJECT_ID}/registry/repositories/${CONTAINER_REGISTRY_ID}/tags" | jq '[.[].location]')

# Sprawdź, czy pobrano tagi
if [ -z "$TAGS" ]; then
  echo "Nie udało się pobrać tagów z rejestru. Upewnij się, że token jest poprawny i masz dostęp do projektu."
  exit 1
fi


cat .vscode/tasks.json
jq --argjson tags "$TAGS" \
  '.inputs[0].options = $tags | .inputs[0].default = $tags[$tags | length - 1]' \
  .vscode/tasks.json > tmp.json && mv tmp.json .vscode/tasks.json
```