---
title: ca-certificates
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} ca-certificates

!!! notes
    Rola Ansible do konfiguracji certyfikatów CA na serwerach Linux.  


---
### Wymagania

- Ansible w wersji co najmniej 2.9
- System operacyjny: Debian, Ubuntu, Alpine, RedHat Enterprise Linux (7, 8, 9)
- Dostęp do repozytoriów pakietów systemowych

---
### Zmienne

Rola udostępnia następujące zmienne konfiguracyjne (zdefiniowane w `defaults/main.yml`):

| Zmienna                  | Domyślna wartość | Opis                                                                                  |
|--------------------------|------------------|---------------------------------------------------------------------------------------|
| `input_debug`            | `false`          | Włącza debugowanie (wyświetlanie informacji o rodzinie systemu)                        |
| `input_ubuntu_repositories` | `[]`          | Lista dodatkowych repozytoriów dla systemów Ubuntu/Debian                            |
| `input_redhat_repositories` | `[]`          | Lista dodatkowych repozytoriów dla systemów RedHat                                  |
| `input_packages_to_install` | `[]`           | Lista pakietów do instalacji (domyślnie puste, rola instaluje `ca-certificates` i `curl`) |
| `input_packages_to_remove` | `[]`            | Lista pakietów do usunięcia                                                          |

Dodatkowo rola oczekuje zmiennej `input_certificates`, która powinna zawierać certyfikaty CA i certyfikaty pośrednie w formie tekstowej, np.:

```yaml
input_certificates:
  ca: |
    -----BEGIN CERTIFICATE-----
    ...
    -----END CERTIFICATE-----
  intermediate: |
    -----BEGIN CERTIFICATE-----
    ...
    -----END CERTIFICATE-----
```

---
### Użycie

Przykładowy playbook wykorzystujący rolę:

```yaml
- hosts: all
  roles:
    - role: pl_rachuna_net.ca_certificates
      vars:
        input_debug: true
        input_certificates:
          ca: "{{ lookup('file', 'files/ca.crt') }}"
          intermediate: "{{ lookup('file', 'files/intermediate.crt') }}"
        input_packages_to_install:
          - ca-certificates
          - curl
```

---
### Testowanie

Rola zawiera testy Molecule, które można uruchomić poleceniem:

```bash
molecule test
```
!!! info
    Testy znajdują się w katalogu `molecule/default/` i obejmują konwergencję oraz sprawdzenie poprawności konfiguracji.
