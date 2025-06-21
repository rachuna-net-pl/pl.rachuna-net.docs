---
title: Graphql Explorer
description: Graphql Explorer
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){width=20px} Graphql Explorer

Poniżej znajduje się przykład wykorzystania GraphQL do pobierania listy wszystkich repozytoriów w grupie GitLab.

---
### Lista wszystkich repozytoriów
Wyciągniecie wszytkistkich repozytoriów z [graphql](https://gitlab.com/-/graphql-explorer)
```
query groupProjects {
  group(fullPath: "pl.rachuna-net") {
    projects(includeSubgroups: true)
    {
      nodes {
        fullPath
      },
    }
  }
}
```