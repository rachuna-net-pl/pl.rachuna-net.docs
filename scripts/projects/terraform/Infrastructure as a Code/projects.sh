#!/bin/bash

# Konfiguracja
GITLAB_URL="https://gitlab.com/api/graphql"  # Zmień na swój adres GitLab, jeśli inny
# GITLAB_TOKEN="glpat-x..."                  # Ustaw swój token GitLab
OUTPUT_FILE="docs/projects/terraform/Infrastructure as a Code/index.md"

# Zapytanie GraphQL
QUERY='{
  "query": "query { group(fullPath: \"pl.rachuna-net/infrastructure/terraform\") { projects(includeSubgroups: false) { nodes { name fullPath } } } }"
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
title: Lista konfiguracji
description: Infrastructure as a Code
tags:
- terraform
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} Konfiguracje Infrastructure as a code
---

Poniżej znajduje się lista projektów Infrastructure as a Code.
"
  echo "| project   | version |"
  echo "|-----------|---------|"

  # Parsowanie, sortowanie i generowanie tabelki
  echo "$RESPONSE" | jq -r '.data.group.projects.nodes | map(select(.name != "gitlab-profile")) | map(select(.name != "home.rachuna-net.pl")) | sort_by(.name)[] | "| [\(.name)](https://gitlab.com/\(.fullPath)) | ![](https://gitlab.com/\(.fullPath)/-/badges/release.svg) |"'
} > "$OUTPUT_FILE"

echo "Tabela Markdown została zapisana do pliku: $OUTPUT_FILE"
