::include{file=.gitlab/badges.md}
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/master/images/docs.png){height=20px} docs

[https://rachuna-net.pl](https://rachuna-net.pl)

### Uruchomienie lokalnie

```bash
podman run -it -p 8000:8000 -v ${PWD}:/docs:rw registry.gitlab.com/pl.rachuna-net/containers/mkdocs:1.0.0 bash
mkdocs build && mkdocs serve -a 0.0.0.0:8000
```

## Contributions
Jeśli masz pomysły na ulepszenia, zgłoś problemy, rozwidl repozytorium lub utwórz Merge Request. Wszystkie wkłady są mile widziane!
[Contributions](CONTRIBUTING.md)

## Links
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/reference)
  
::include{file=.gitlab/contributions.md}
::include{file=.gitlab/license.md}
::include{file=.gitlab/authors.md}

