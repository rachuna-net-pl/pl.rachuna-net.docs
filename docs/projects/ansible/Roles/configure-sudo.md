---
title: configure-sudo
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} configure-sudo

!!! note
  Rola Ansible do konfiguracji sudo na serwerach Linux.  

### Wymagania

- Ansible w wersji co najmniej 2.9
- System operacyjny: Debian, Ubuntu, Alpine, RedHat Enterprise Linux (7, 8, 9)
- Dostęp do repozytoriów pakietów systemowych
- Uprawnienia administratora (root) na docelowych serwerach

---
### Funkcjonalność

Rola wykonuje następujące operacje:

1. **Instalacja sudo** - instaluje pakiet sudo dla danego systemu operacyjnego:
   - Debian/Ubuntu: `sudo`
   - Alpine: `sudo`
   - RedHat: `sudo`

2. **Konfiguracja uprawnień sudo** - modyfikuje plik `/etc/sudoers`:
   - Konfiguruje uprawnienia NOPASSWD dla domyślnej grupy administracyjnej
   - Dodaje uprawnienia NOPASSWD dla dodatkowych grup użytkowników
   - Zachowuje bezpieczne uprawnienia pliku konfiguracyjnego

---
### Zmienne

#### Zmienne konfiguracyjne (defaults/main.yml)

| Zmienna                    | Domyślna wartość | Opis                                                          |
|---------------------------|------------------|---------------------------------------------------------------|
| `input_debug`             | `false`          | Włącza debugowanie (wyświetlanie informacji o systemie)       |
| `input_custom_groups_to_sudo` | `[]`        | Lista dodatkowych grup, którym mają być nadane uprawnienia sudo |

#### Zmienne wewnętrzne (vars/main.yml)

| Zmienna                    | Opis                                                                |
|---------------------------|---------------------------------------------------------------------|
| `var_sudo_config_path`    | Ścieżka do pliku konfiguracyjnego sudo (`/etc/sudoers`)            |
| `var_sudo_maintenance_group` | Nazwa domyślnej grupy administracyjnej (sudo/wheel) zależna od systemu |

---
### Użycie

#### Podstawowe użycie z domyślnymi ustawieniami

```yaml
- hosts: all
  roles:
    - role: pl_rachuna_net.configure_sudo
```

#### Użycie z dodatkowymi grupami sudo

```yaml
- hosts: all
  roles:
    - role: pl_rachuna_net.configure_sudo
      vars:
        input_debug: true
        input_custom_groups_to_sudo:
          - admins
          - developers
```

---
### Bezpieczeństwo

Rola implementuje następujące praktyki bezpieczeństwa:

- Konfiguracja uprawnień NOPASSWD tylko dla określonych grup
- Zachowanie odpowiednich uprawnień pliku sudoers
- Możliwość elastycznego zarządzania uprawnieniami poprzez grupy

---

### Testowanie
Rola zawiera testy Molecule, które można uruchomić poleceniem:

```bash
molecule test
```
!!! note
    Testy znajdują się w katalogu `molecule/default/` i obejmują:
    - Instalację sudo
    - Konfigurację uprawnień
    - Weryfikację ustawień pliku sudoers

---
## Uwagi

!!! warning
    ⚠️ **Ważne**: 
    - Upewnij się, że grupy wymienione w `input_custom_groups_to_sudo` istnieją w systemie
    - Nadawanie uprawnień NOPASSWD powinno być stosowane rozważnie
    - Zaleca się regularne audytowanie uprawnień sudo w systemie
