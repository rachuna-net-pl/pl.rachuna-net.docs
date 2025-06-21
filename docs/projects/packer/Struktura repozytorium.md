---
title: Struktura repozytorium
description: Struktura repozytorium
tags:
- packer
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/packer.png){width=20px} Struktura repozytorium

## Struktura katalogów i plików w repozytorium

```
.
├── build.pkr.hcl                            # Definicja procesu budowy i hardeningu maszyny wirtualnej
├── downloaded_iso_path                      # katalog do przecowywania pobranych obrazów iso
├── file_source.pkr.hcl                      # Generowanie plików dla procesu instalacji
├── http                                     # Katalog do przechowywania plików HTTP wykorzystywanych w instalacji
├── locals.pkr.hcl                           # Zmienne lokalne
├── pkrvars                                  # Pliki zmiennych dla poszczególnych wersji Ubuntu Linux
│   └── ubuntu-24.10.hcl
├── provider.pkr.hcl                         # Konfiguracja dostawcy (provider) Proxmox
├── scripts                                  # Katalog ze skryptami
│   └── provisioning.sh
├── template.pkr.hcl                         # Definicja szablonu maszyny wirtualnej
├── templates                                # Szablony plików używane w procesie instalacji
│   ├── meta-data.pkrtpl
│   ├── provisioning.pkrtpl
│   └── user-data.pkrtpl
├── variables.pkr.hcl                        # Ogólne zmienne Packer
├── variables_http.pkr.hcl                   # Zmienne dla serwera HTTP
├── variables_iso.pkr.hcl                    # Zmienne dotyczące ISO
├── variables_proxmox.pkr.hcl                # Zmienne dotyczące konfiguracji Proxmox
├── variables_ssh.pkr.hcl                    # Zmienne SSH
└── variables_vm.pkr.hcl                     # Zmienne konfigurujące maszynę wirtualną
```

---

## Opis kluczowych plików

### **build.pkr.hcl**
Plik **`build.pkr.hcl`** definiuje proces budowy obrazu **Ubuntu Linux** na **Proxmox VE** przy użyciu **Packer**. Główne funkcjonalności:

- Instalacja wymaganych pakietów systemowych (`apk add`).
- Konfiguracja **Cloud-Init** (`setup-cloud-init`), umożliwiająca automatyczne zarządzanie instancjami.
- Zabezpieczenie dostępu poprzez usunięcie kluczy SSH oraz dezaktywację konta `root`.
- Czyszczenie zbędnych plików (historia poleceń, skrypty instalacyjne).

Obraz generowany na podstawie tego pliku jest gotowy do wdrożenia i spełnia wymagania bezpieczeństwa.

---

### **template.pkr.hcl**
Plik **`template.pkr.hcl`** definiuje sposób tworzenia szablonu maszyny wirtualnej **Ubuntu Linux** na **Proxmox VE**.

#### **Najważniejsze funkcjonalności:**

- **Łączenie się z API Proxmox** w celu utworzenia nowej maszyny w puli `templates`.
- **Konfiguracja sprzętowa maszyny wirtualnej**, obejmująca:
  - Liczbę rdzeni procesora i ilość pamięci RAM.
  - Konfigurację interfejsu sieciowego z VLAN (`10` dla testów, `20` dla produkcji).
  - Typ dysku (`scsi`) i alokację przestrzeni dyskowej (`storage.rachuna-net.pl`).
- **Automatyczna instalacja Ubuntu Linux**
- **Konfiguracja dostępu SSH**

---

## Podsumowanie
Struktura repozytorium została zaprojektowana w sposób modularny, co ułatwia **dostosowanie konfiguracji do różnych wersji Ubuntu Linux** oraz pozwala na elastyczne zarządzanie parametrami maszyn wirtualnych. Dzięki automatyzacji wdrożenie systemu jest szybkie, bezpieczne i w pełni zgodne z wymaganiami Proxmox VE.

Repozytorium zapewnia:

✅ **Pełną automatyzację instalacji** – brak interakcji użytkownika.  
✅ **Obsługę wielu wersji Ubuntu Linux** – zmienne w `pkrvars/`.  
✅ **Integrację z Cloud-Init** – dynamiczna konfiguracja VM.  
✅ **Bezpieczne ustawienia dostępu** – brak domyślnych kont, usunięcie kluczy SSH.  

!!! warning "DevOps"
    Dzięki takiej architekturze wdrażanie nowych instancji Ubuntu Linux w **Proxmox VE** jest wydajne, powtarzalne i zgodne z najlepszymi praktykami DevOps. 🚀

