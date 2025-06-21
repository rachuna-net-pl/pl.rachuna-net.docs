---
title: Consul & vault
description: Consul & vault
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/consul.png){width=20px} Consul & ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/vault.png){width=20px} Vault

## Architektura rozwiązania

**Blue/Green Development** z użyciem HA-Proxy

--8<-- "docs/projects/consul-vault/Infrastruktura_sieciowa.html"

---
!!! note "![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/consul.png){width=20px} Consul"
    **Consul**[^consul] to narzędzie firmy HashiCorp służące do automatycznego wykrywania usług, zarządzania konfiguracją oraz zapewniania komunikacji i zdrowia pomiędzy komponentami rozproszonych systemów. Umożliwia łatwe budowanie nowoczesnych, skalowalnych i bezpiecznych środowisk IT.

!!! note "![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/vault.png){width=20px} Vault"
    **Vault**[^vault] to narzędzie firmy HashiCorp przeznaczone do bezpiecznego przechowywania, zarządzania i kontrolowania dostępu do sekretów, takich jak hasła, klucze API czy certyfikaty. Pozwala centralizować zarządzanie poufnymi danymi oraz automatyzować ich dystrybucję w środowiskach IT.


[^consul]: [https://developer.hashicorp.com/consul](https://developer.hashicorp.com/consul)
[^vault]: [https://developer.hashicorp.com/vault](https://developer.hashicorp.com/vault)