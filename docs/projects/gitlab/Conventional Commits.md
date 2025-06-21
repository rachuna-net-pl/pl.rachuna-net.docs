---
title: Conventional Commits
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/docs.png){height=20px} Conventional Commits – Standaryzacja wiadomości commitów

!!! tip
    **Conventional Commits** w organizacji `rachuna-net`. Wdrożenie tej konwencji umożliwia uporządkowaną historię zmian, automatyzację wersjonowania i łatwiejszą współpracę zespołową.

    ℹ️ Oficjalna specyfikacja: [conventionalcommits.org](https://www.conventionalcommits.org/en/v1.0.0/)

---
## Format wiadomości commitów

Wiadomość commita powinna być zgodna z poniższym schematem:

```
<typ>[!][(zakres)]: krótki opis zmiany
```

**Przykłady**

```text
feat: dodano obsługę logowania
fix(auth): naprawiono błąd walidacji tokenu
refactor!: przebudowano system autoryzacji (breaking change)
chore(ci): aktualizacja pipeline’a GitLab CI
```

---
### Typy commitów

| Typ        | Opis                                        |
| ---------- | ------------------------------------------- |
| `feat`     | Nowa funkcjonalność                         |
| `fix`      | Poprawka błędu                              |
| `docs`     | Zmiany w dokumentacji                       |
| `style`    | Formatowanie (np. spacje, przecinki)        |
| `refactor` | Refaktoryzacja kodu (bez zmiany zachowania) |
| `test`     | Dodanie lub zmiana testów                   |
| `chore`    | Zadania techniczne (np. zmiany w CI/CD)     |
| `params`   | [**dodane w organizacji `pl.rachuna-net`**] -  Parametryzacja     |

---

## Breaking changes

Aby oznaczyć zmianę łamiącą kompatybilność wsteczną, należy dodać wykrzyknik (`!`) po typie commita.

```bash
git commit -m 'refactor!: zmieniono sposób uwierzytelniania'
```

---
## Korzyści ze stosowania

* ✅ Spójna i czytelna historia commitów
* ✅ Automatyczne generowanie changelogów
* ✅ Wsparcie dla `semantic-release` i automatycznego wersjonowania
* ✅ Łatwiejsze code review i analiza zmian
* ✅ Możliwość automatycznej walidacji commitów w CI/CD

---
## Podsumowanie

Wdrożenie Conventional Commits to szybki krok w stronę lepszej automatyzacji, przejrzystości i jakości pracy w projektach GitLab. Rekomendujemy uwzględnienie tej konwencji w każdym nowym repozytorium oraz integrację z `commitlint`, `semantic-release` i `husky`.
