---
title: install-packages
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} install-packages

!!! note
    Rola Ansible do instalacji i zarządzania pakietami na serwerach Linux.  
    Umożliwia instalację, aktualizację i usuwanie pakietów oraz zarządzanie repozytoriami na systemach Debian, Ubuntu, Alpine oraz RedHat.

---
### Wymagania

- Ansible w wersji co najmniej 2.9
- System operacyjny:
  - Debian (10, 11, 12)
  - Ubuntu (18.04, 20.04, 22.04, 24.04)
  - Alpine (3.15-3.19)
  - RedHat Enterprise Linux (7, 8, 9)
  - Fedora (37-40)
- Dostęp do repozytoriów pakietów systemowych
- Uprawnienia administratora (root)

---
### Funkcjonalność

Rola wykonuje następujące operacje:

1. **Aktualizacja cache pakietów**:
   - apt dla Debian/Ubuntu
   - dnf dla RedHat/Fedora
   - apk dla Alpine

2. **Zarządzanie repozytoriami**:
   - Instalacja niezbędnych pakietów (gpg, wget, apt-transport-https)
   - Dodawanie kluczy repozytoriów
   - Konfiguracja nowych źródeł pakietów
   - Obsługa repozytoriów z podpisem własnym

3. **Zarządzanie pakietami**:
   - Instalacja wybranych pakietów
   - Usuwanie niepotrzebnych pakietów
   - Aktualizacja systemu (opcjonalnie)
   - Czyszczenie pamięci podręcznej i nieużywanych zależności

---
### Zmienne

#### Zmienne konfiguracyjne (defaults/main.yml)

| Zmienna                    | Domyślna wartość | Opis                                                    |
|---------------------------|------------------|----------------------------------------------------------|
| `input_debug`             | `false`          | Włącza debugowanie                                       |
| `input_disable_reboot`    | `false`          | Wyłącza automatyczny restart po aktualizacjach          |
| `input_packages_upgrade`  | `true`           | Włącza aktualizację wszystkich pakietów                 |
| `input_ubuntu_repositories` | `[]`           | Lista repozytoriów dla Debian/Ubuntu                     |
| `input_redhat_repositories` | `[]`           | Lista repozytoriów dla RedHat/Fedora                    |
| `input_packages_to_install` | `[]`           | Lista pakietów do zainstalowania                        |
| `input_packages_to_remove` | `[]`            | Lista pakietów do usunięcia                             |

#### Przykłady konfiguracji repozytoriów

##### Dla Ubuntu/Debian:
```yaml
input_ubuntu_repositories:
  - repo: "deb http://przykład.com/ubuntu focal main"
    filename: "przykład"
    state: present
    repository_key: "http://przykład.com/key.gpg"  # lub
    self_signed_repository_key: "http://przykład.com/self-signed.key"
    keyring_name: "przykład-archive-keyring.gpg"
```

##### Dla RedHat/Fedora:
```yaml
input_redhat_repositories:
  - name: "przykład-repo"
    description: "Przykładowe Repozytorium"
    baseurl: "http://przykład.com/rhel/$releasever/$basearch/"
    gpgkey: "http://przykład.com/RPM-GPG-KEY"
    repository_key: "http://przykład.com/RPM-GPG-KEY"
```

---
### Przykłady użycia

#### Podstawowa instalacja pakietów

```yaml
- hosts: all
  roles:
    - role: install_packages
      vars:
        input_packages_to_install:
          - htop
          - vim
          - curl
```

#### Dodanie repozytorium i instalacja pakietów

```yaml
- hosts: all
  roles:
    - role: install_packages
      vars:
        input_ubuntu_repositories:
          - repo: "ppa:przykład/repo"
            state: present
        input_packages_to_install:
          - pakiet-z-repo
```

#### Pełna konfiguracja

```yaml
- hosts: all
  roles:
    - role: pl_rachuna_net.install_packages
      vars:
        input_debug: true
        input_packages_upgrade: true
        input_disable_reboot: false
        input_packages_to_install:
          - nginx
          - postgresql
        input_packages_to_remove:
          - apache2
```

---
### Bezpieczeństwo

- Weryfikacja podpisów GPG dla repozytoriów
- Bezpieczne zarządzanie kluczami
- Kontrola aktualizacji systemu
- Czyszczenie nieużywanych pakietów

---
### Testowanie

Rola zawiera testy Molecule, które można uruchomić poleceniem:

```bash
molecule test
```

!!! note
    Testy sprawdzają:
    
    - Instalację pakietów
    - Konfigurację repozytoriów
    - Aktualizację systemu
    - Usuwanie pakietów

---
### Uwagi
!!! warning
    ⚠️ **Ważne**: 
    
    - Zaleca się testowanie na środowisku testowym
    - Ostrożnie z funkcją aktualizacji systemu
    - Warto robić kopie zapasowe przed aktualizacjami
    - Niektóre zmiany mogą wymagać restartu
