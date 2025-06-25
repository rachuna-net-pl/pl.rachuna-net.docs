---
title: Importowanie state do gitlab states
description: Importowanie state do gitlab states
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} Importowanie state do gitlab states

!!! note
     Importowanie stanu Terraform do GitLab States pozwala na zarządzanie i synchronizację stanu infrastruktury bezpośrednio w ramach projektu GitLab. Dzięki temu możliwe jest centralne przechowywanie i kontrola stanu, co ułatwia współpracę zespołową oraz automatyzację procesów CI/CD. W niniejszym dokumencie przedstawiono sposób importowania istniejącego stanu Terraform do GitLab za pomocą API.

```bash
#!/bin/env bash

curl --request POST \
     --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
     --header "Content-Type: application/json" \
     --data-binary "@default.json" \
     "https://gitlab.com/api/v4/projects/${PRROJECT_ID}/terraform/state/${TF_STATE_NAME}"
```
