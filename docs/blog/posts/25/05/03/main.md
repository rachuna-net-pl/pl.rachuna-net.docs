---
date:
    created: 2025-05-03
authors:
    - maciej-rachuna
title: VSCODE - Automatyczne uruchamianie kontenera MkDocs przy starcie projektu
categories:
    - vscode
tags:
    - vscode
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/container.png){height=20px} VSCODE - Automatyczne uruchamianie kontenera MkDocs przy starcie projektu

W tym artykule pokazano, jak skonfigurować Visual Studio Code tak, aby uruchamiał kontener MkDocs bezpośrednio z poziomu zadania (task), uruchamianego ręcznie lub automatycznie.

!!! info
    Wielu twórców dokumentacji technicznej korzysta z MkDocs, aby wygodnie budować i serwować strony dokumentacyjne w oparciu o Markdown. Kiedy projekt dokumentacji rozwijany jest lokalnie, warto zadbać o to, aby środowisko uruchamiało się automatycznie wraz z otwarciem projektu – najlepiej w kontenerze Dockera.

<!-- more -->
---
## 🎯 Założenia

Konfiguracja opiera się na gotowym obrazie kontenera:
```
registry.gitlab.com/pl.rachuna-net/containers/mkdocs:1.0.1
```

Celem jest uruchomienie tego obrazu z zamontowanym katalogiem projektu jako `/docs`, a następnie automatyczne wykonanie komendy:
```bash
mkdocs build && mkdocs serve -a 0.0.0.0:8000
```

---
## 🧩 Wymagane rozszerzenia VS Code

Aby wszystko działało poprawnie, należy zainstalować następujące rozszerzenia:

- ✅ **Docker** – [oficjalny plugin od Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
  - Umożliwia integrację z Dockerem (kontenery, obrazy, logi itp.)
  - Pozwala śledzić uruchomione kontenery i łatwiej debugować taski

Instalację można przeprowadzić:
- Z poziomu **Marketplace** (`Ctrl+Shift+X` → wyszukać *Docker*),
- Lub ręcznie z linku powyżej.

---

## ⚙️ Konfiguracja pliku `tasks.json`

W folderze `.vscode` projektu należy utworzyć (lub edytować) plik `tasks.json` o następującej zawartości:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Start MkDocs container",
      "type": "shell",
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "--name", "mkdocs-dev",
        "-p", "8000:8000",
        "-v", "${workspaceFolder}:/docs",
        "${input:dockerImage}",
        "sh", "-c",
        "mkdocs build && mkdocs serve -a 0.0.0.0:8000"
      ],
      "runOptions": {
        "runOn": "folderOpen"
      },
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
        "registry.gitlab.com/pl.rachuna-net/containers/mkdocs:1.0.0",
        "registry.gitlab.com/pl.rachuna-net/containers/mkdocs:1.0.1"
      ],
    }
  ]
}


```

**Co robi ten task?**

- Uruchamia taska automatycznie po otwarciu projektu `runOptions` → `"runOn": "folderOpen"`
- Uruchamia kontener z obrazem MkDocs,
- Mapuje lokalny katalog projektu do `/docs` w kontenerze,
- Serwuje stronę na porcie `8000`,
- Wszystko odbywa się w widocznym terminalu zintegrowanym w VS Code.

---
## 🚀 Automatyczne uruchamianie przy starcie projektu

Visual Studio Code domyślnie nie uruchamia tasków automatycznie przy otwarciu folderu. Można jednak skorzystać z rozszerzenia:

- 🧩 **VS Code Tasks Auto Run** – pozwala ustawić, które taski mają uruchamiać się automatycznie po otwarciu projektu

Dla pełnej automatyzacji warto połączyć to z prostym `runOptions` typu `"runOn": "folderOpen"`, jeśli nie przeszkadza wywołanie taska za każdym razem.

---
## 🔄 Automatyczna aktualizacja tagów Dockera z GitLab Container Registry

Aby zadanie uruchamiające kontener było jak najbardziej elastyczne, warto zautomatyzować aktualizację dostępnych tagów obrazu Dockera – szczególnie gdy obrazy są regularnie aktualizowane i tagowane (np. `1.0.0`, `1.0.1`, `latest`, itp.).

**Korzyści z podejścia dynamicznego**

- Unika konieczności ręcznego aktualizowania pliku `tasks.json` po wypuszczeniu nowego obrazu,
- Pozwala użytkownikowi wybrać obraz z aktualnej listy podczas uruchamiania kontenera,
- Zmniejsza ryzyko uruchamiania kontenera ze starym lub nieistniejącym tagiem.

---

W tym celu przygotowano prosty skrypt bashowy, który łączy się z GitLab API, pobiera listę tagów konkretnego obrazu i aktualizuje je dynamicznie w pliku `.vscode/tasks.json`.

### Defincja autorun skryptu
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
      "label": "Start MkDocs container",
      (...)
    }
  ],
  (...)
}
```
### Skrypt aktualizujący tagi

Plik `scripts/vscode_tasks_update_docker_tags.bash` może wyglądać następująco:

```bash
#!/usr/bin/env bash

set -euo pipefail
source ~/.profile

# Ustawienia projektu i rejestru
PROJECT_ID="69188507"
REGISTRY_ID="8581031"
OUTPUT_FILE=".vscode/tasks.json"
AUTH_HEADER="PRIVATE-TOKEN: $GITLAB_TOKEN"

# Pobierz listę tagów z GitLab Container Registry
TAGS=$(curl -s -H "$AUTH_HEADER" \
  "https://gitlab.com/api/v4/projects/${PROJECT_ID}/registry/repositories/${REGISTRY_ID}/tags" |
  jq '[.[].location]')

# Sprawdź, czy pobrano tagi
if [ -z "$TAGS" ]; then
  echo "Nie udało się pobrać tagów z rejestru. Upewnij się, że token jest poprawny i masz dostęp do projektu."
  exit 1
fi

# Nadpisz pole 'options' oraz ustaw ostatni tag jako domyślny
jq --argjson tags "$TAGS" \
  '.inputs[0].options = $tags | .inputs[0].default = $tags[$tags | length - 1]' \
  "$OUTPUT_FILE" > tmp.json && mv tmp.json "$OUTPUT_FILE"
```
**Jak to działa?**

- Skrypt wykorzystuje API GitLaba do pobrania listy tagów obrazu Dockera w rejestrze projektu.
- Zwracana tablica tagów jest przetwarzana za pomocą `jq` i podstawiana do sekcji `inputs[0].options` w pliku `.vscode/tasks.json`.
- Automatycznie ustawiany jest najnowszy (ostatni) tag jako domyślny (`default`).

---

### Token i uprawnienia

Do działania tego skryptu potrzebny jest **token dostępu GitLab API**, przechowywany w zmiennej środowiskowej `GITLAB_TOKEN`, który zdefinowany jest `~/.profile`:

```bash
export GITLAB_TOKEN="glpat-xxxxxxx"
```
