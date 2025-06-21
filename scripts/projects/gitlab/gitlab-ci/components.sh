#!/bin/bash

# Konfiguracja
GITLAB_URL="https://gitlab.com/api/graphql"  # Zmień na swój adres GitLab, jeśli inny
# GITLAB_TOKEN="glpat-x..."                  # Ustaw swój token GitLab
OUTPUT_FILE="docs/projects/gitlab/Gitlab-CI/Components.md"

# Zapytanie GraphQL
QUERY='{
  "query": "query { group(fullPath: \"pl.rachuna-net/cicd/components\") { projects(includeSubgroups: true) { nodes { name fullPath } } } }"
}'

# Wykonanie zapytania
RESPONSE=$(curl -s --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $GITLAB_TOKEN" \
  --data "$QUERY" \
  "$GITLAB_URL")

# Sprawdzenie błędów
if [[ -z "$RESPONSE" ]]; then
  echo "Błąd: Brak odpowiedzi z API GitLab." >&2
  exit 1
fi

# Nagłówek tabelki Markdown
{
  echo "---
title: Lista komponentów
description: Lista komponentów
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){height=20px} Lista komponentów

Poniżej znajduje się lista stworzonych komponentów

---
"
  echo "| component | version |"
  echo "|-----------|---------|"

  # Parsowanie, sortowanie i generowanie tabelki
  echo "$RESPONSE" | jq -r '.data.group.projects.nodes | sort_by(.name)[] | "| [\(.name)](https://gitlab.com/\(.fullPath)) | ![](https://gitlab.com/\(.fullPath)/-/badges/release.svg) |"'
} > "$OUTPUT_FILE"

echo "Tabela Markdown została zapisana do pliku: $OUTPUT_FILE"
