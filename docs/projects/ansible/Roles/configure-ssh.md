---
title: configure-ssh
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} configure-ssh

!!! notes
    Rola Ansible do konfiguracji SSH na serwerach Linux.  
    Umożliwia instalację serwera SSH oraz jego bezpieczną konfigurację na systemach Debian, Ubuntu, Alpine oraz RedHat.

---
### Wymagania

- Ansible w wersji co najmniej 2.9
- System operacyjny: Debian, Ubuntu, Alpine, RedHat Enterprise Linux (7, 8, 9)
- Dostęp do repozytoriów pakietów systemowych
- Uprawnienia administratora (sudo/root) na docelowych serwerach

---
### Funkcjonalność

Rola wykonuje następujące operacje:

1. **Instalacja serwera SSH** - instaluje odpowiedni pakiet SSH dla danego systemu operacyjnego:
   - Debian/Ubuntu: `ssh`
   - Alpine: `openssh`
   - RedHat: `openssh-server` i `openssh-clients`

2. **Konfiguracja bezpieczeństwa SSH** - modyfikuje plik `/etc/ssh/sshd_config`:
   - Ustawia port SSH
   - Wyłącza uwierzytelnianie hasłem
   - Blokuje logowanie jako root
   - Ustawia odpowiednie uprawnienia pliku konfiguracyjnego

3. **Restart usługi SSH** - automatycznie restartuje usługę SSH po zmianach konfiguracji

---
### Zmienne

Rola udostępnia następujące zmienne konfiguracyjne (zdefiniowane w `defaults/main.yml`):

| Zmienna                               | Domyślna wartość | Opis                                                    |
|---------------------------------------|------------------|---------------------------------------------------------|
| `input_debug`                         | `false`          | Włącza debugowanie (wyświetlanie informacji o systemie) |
| `sshd_config.port`                    | `22`             | Port na którym nasłuchuje serwer SSH                   |
| `sshd_config.permit_root_login`       | `"no"`           | Czy zezwolić na logowanie jako root                    |
| `sshd_config.password_authentication` | `"no"`           | Czy zezwolić na uwierzytelnianie hasłem                |

#### Zmienne wewnętrzne (vars/main.yml)

| Zmienna              | Opis                                                           |
|----------------------|----------------------------------------------------------------|
| `var_sshd_config_path` | Ścieżka do pliku konfiguracyjnego SSH (`/etc/ssh/sshd_config`) |
| `var_sshd_service`     | Nazwa usługi SSH (zależna od systemu operacyjnego)            |
| `var_sshd_package`     | Nazwa pakietu SSH (zależna od systemu operacyjnego)           |

---
### Handlery

Rola definiuje następujący handler:

- **🚨 Restart SSHD** - restartuje i włącza usługę SSH po zmianach konfiguracji

---
### Użycie

#### Podstawowe użycie z domyślnymi ustawieniami

```yaml
- hosts: all
  roles:
    - role: configure_ssh
```

#### Użycie z niestandardową konfiguracją

```yaml
- hosts: all
  roles:
    - role: configure_ssh
      vars:
        input_debug: true
        sshd_config:
          port: 2222
          permit_root_login: "no"
          password_authentication: "no"
```

---
### Bezpieczeństwo

Rola implementuje następujące praktyki bezpieczeństwa:

- **Wyłączenie uwierzytelniania hasłem** - wymusza użycie kluczy SSH
- **Blokowanie logowania root** - zapobiega bezpośredniemu logowaniu jako administrator
- **Niestandardowy port** - możliwość zmiany domyślnego portu SSH
- **Odpowiednie uprawnienia** - ustawia właściwe uprawnienia dla pliku konfiguracyjnego

---
### Testowanie

Rola zawiera testy Molecule, które można uruchomić poleceniem:

```bash
molecule test
```

!!! info
    Testy znajdują się w katalogu `molecule/default/` i obejmują:

    - Konwergencję roli
    - Sprawdzenie poprawności konfiguracji SSH
    - Weryfikację działania usługi SSH

---

### Uwagi

!!! warning
    ⚠️ **Ważne**: Po uruchomieniu roli z domyślnymi ustawieniami:
    - Uwierzytelnianie hasłem zostanie wyłączone
    - Logowanie jako root zostanie zablokowane
    - Upewnij się, że masz skonfigurowane klucze SSH przed uruchomieniem roli
