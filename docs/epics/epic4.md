---
title: Epic 4
hide:
- navigation
---
# [Epic 4 - Utworzenie template vm za pomocą packera](https://gitlab.com/groups/pl.rachuna-net/-/milestones/4)

---
## Przygotowanie grup i repozytoriów za pomocą Terraform
---
- [x] Utworzenie repozytorium dla projektu [pl.rachuna-net/containers/packer](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/commit/f55f25b35ea8c255eb24c584d51a668e15b27564)
- [x] Utworzenie grupy [pl.rachuna-net/infrastructure/packer](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/commit/70dd402abb906ad0d41971d058043d951647fc03)
- [x] Utworzenie repozytorium dla projektu [pl.rachuna-net/infrastructure/packer/ubuntu](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/commit/575455698d886ee1f6cc08b3e24b0049d8585ab9)
- [x] Utworzenie repozytorium dla projektu [pl.rachuna-net/infrastructure/packer/alpine](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/commit/56b962635ff7d9c0b418b984622af3b4ead87cab)
- [x] Utworzenie repozytorium dla projektu [pl.rachuna-net/infrastructure/packer/alma](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/gitlab/-/commit/153f7ed81dcf0ffefdf6966d8246bca4916b3c74)

---
## Przygotowanie procesu CI/CD
---
- [x] Wydanie obrazu dockerowego z packerem [1.0.1](registry.gitlab.com/pl.rachuna-net/containers/packer:1.0.1)
- [x] Wydanie komponentu validate [v1.2.0](https://gitlab.com/pl.rachuna-net/cicd/components/validate/-/releases/v1.2.0)
- [x] Wydanie komponentu build [v1.2.0](https://gitlab.com/pl.rachuna-net/cicd/components/build/-/releases/v1.2.0)
- [x] Wydanie procesu w gitlab-ci [v1.8.0](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/releases/v1.8.0)

---
## Utworzenie template na proxmox
---
- [x] Utworzenie template Ubuntu [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/packer/ubuntu/-/releases/v1.0.0)
- [x] Utworzenie template Alpine [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/packer/alpine/-/releases/v1.0.0)
- [x] Utworzenie template Alma [v1.0.0](https://gitlab.com/pl.rachuna-net/infrastructure/packer/alma/-/releases/v1.0.0)
