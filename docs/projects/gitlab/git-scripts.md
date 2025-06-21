---
title: Git script
description: Git script
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){width=20px} Graphql Explorer

Poniżej znajdują się przydatne skrypty i polecenia ułatwiające codzienną pracę z repozytorium Git w projektach.

---
### Usuwanie lokalnych branchy, które nie istnieją na zdalnym repozytorium

```bash
# Aktualizacja informacji o branchach w zdalnym repozytorium
git fetch --prune

# Usuwanie lokalnych branchy, które nie mają odpowiednika w origin
git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
git branch -vv | awk '/: nie ma]/{print $1}' | xargs git branch -D
```