---
date:
    created: 2025-05-21
authors:
    - maciej-rachuna
title: DOTNET - Przygotowanie skryptów deweloperskich
categories:
    - ansible
    - molecule
tags:
    - ansible
    - molecule
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/dotnet.png){height=20px} DRAFT: DOTNET - Przygotowanie skryptów deweloperskich

Artykuł jest w postaci notatki

```bash
#!/usr/bin/env bash
set -euo pipefail

# load credeantials
source .env

# NU1603 - https://learn.microsoft.com/pl-pl/nuget/reference/errors-and-warnings/nu1603
ARGS="--packages $NUGET_PACKAGES --verbosity minimal -p:WarningsAsError=NU1603"

# Jeśli masz problem z nugetproxy
ARGS+="--disable-parallel"

# https://learn.microsoft.com/pl-pl/dotnet/core/tools/dotnet-nuget-add-source
dotnet nuget add source $PROXY_NUGET_URL --name "$PROXY_NUGET_SOURCE" --username "$PROXY_NUGET_USERNAME" --password "$PROXY_NUGET_PASSWORD" --store-password-in-clear-text
if [$? -ne 0]; then
    echo "Source add $PROXY_NUGET_SOURCE error"
else
    echo "Source $PROXY_NUGET_SOURCE is added"
fi

dotnet nuget disable nuget.org
if [$? -ne 0]; then
    echo "Source disabled 'nuget.org' error"
else
    echo "Source 'nuget.org' is disabled"
fi

# Znajdź wszystkie pliki solucji i przywróć pakiety
find . type f --name "*.sln" |while read -r sln; do
    dotnet restore $sln $ARGS
    if [$? -ne 0]; then
        echo "Dotnet restore failed for $sln"
    else
        echo "Dotnet restore successful for $sln"
    fi  
done
```