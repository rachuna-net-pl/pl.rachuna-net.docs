---
title: Importowanie istniejących obiektów
description: Importowanie istniejących obiektów
tags:
- terraform
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} Importowanie istniejących obiektów

### **Terraform Import – Co to jest i do czego służy?**

!!! question "Co to jest terraform import?"
    `terraform import` to polecenie w Terraform, które umożliwia **wprowadzenie istniejących zasobów** do stanu (`state`) Terraform, bez konieczności ich tworzenia od zera. Jest to przydatne, gdy mamy zasoby zarządzane ręcznie lub przez inne narzędzia i chcemy przejąć nad nimi kontrolę za pomocą Terraform.

!!! question "Do czego służy terraform import?"
    - **Przejmowanie kontroli nad istniejącymi zasobami** – jeśli masz już zasoby w chmurze (np. VM w AWS, projekt w GitLab, użytkowników w Azure), możesz je zaimportować do Terraform bez ich ponownego tworzenia.
    - **Unikanie usuwania i ponownego tworzenia zasobów** – jeśli ręcznie utworzony zasób nie znajduje się w stanie Terraform, ale istnieje, można go dodać do `state`, zamiast niszczyć i tworzyć od nowa.
    - **Migracja do Terraform** – jeśli zarządzałeś zasobami ręcznie lub przy pomocy innego narzędzia (np. Ansible, CloudFormation), możesz je przenieść do Terraform.

!!! tips "Ograniczenia terraform import"
    - **Nie importuje konfiguracji (`.tf`)** – dodaje zasoby tylko do `state`, ale nie generuje kodu. Konfigurację trzeba dodać ręcznie.
    - **Brak wsparcia dla całych modułów** – `terraform import` działa na poziomie pojedynczych zasobów, a nie całych modułów.
    - **Niektóre zasoby nie są wspierane** – nie wszystkie dostawcy (`providers`) umożliwiają import wszystkich typów zasobów.

---

# Przykłady importowanie obiektów

## importowanie grupy gitlab
```hcl
import {
  to = module.pl_rachuna-net.module.infrastructure.module.terraform.module.group_modules.gitlab_group.group
  id = "100726684"
}
```
## importowanie projektu gitlab
```hcl
import {
    to = module.pl_rachuna-net.module.infrastructure.module.terraform.module.modules.module.gitlab_group.gitlab_project.project
    id = "66189322"
}
```