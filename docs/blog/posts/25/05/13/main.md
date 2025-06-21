---
date:
    created: 2025-05-13
authors:
    - maciej-rachuna
title: ANSIBLE - Testowanie ról Ansible z użyciem Molecule i Proxmox
categories:
    - ansible
    - molecule
tags:
    - ansible
    - molecule
---

# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){height=20px} ANSIBLE - Testowanie ról Ansible z użyciem Molecule i Proxmox

Molecule to framework umożliwiający automatyczne testowanie ról Ansible w odizolowanych środowiskach. W integracji z **Proxmox** pozwala na dynamiczne tworzenie maszyn wirtualnych na podstawie istniejących szablonów (**VM Templates**), uruchamianie roli Ansible, a następnie walidację jej działania.  

Proces testowania obejmuje:  
1. **Klonowanie nowej VM** na serwerze Proxmox z predefiniowanego szablonu.  
2. **Provisioning** – uruchomienie roli Ansible i konfiguracja systemu.  
3. **Weryfikację poprawności konfiguracji** za pomocą testów Ansible lub Testinfra.  
4. **Usunięcie instancji** po zakończeniu testów, aby nie pozostawiać zbędnych zasobów.  

Dzięki temu testowanie ról Ansible w Proxmox jest szybkie, powtarzalne i zautomatyzowane, co pozwala na wykrywanie błędów jeszcze przed wdrożeniem na produkcję. 🚀


## Architektura rozwiązania
--8<-- "docs/blog/posts/25/05/13/architektura-test-role.drawio.html"

<!-- more -->

## Krok 1. Utworzenie template z proxmox

Dokładnie opisałem to w tym artykule [Tworzymy template vm na proxmox - alpine](/blog/2025/05/02/httpsgitlabcomplrachuna-netinfrastructureterraformmodulesgitlab-project-rawmainimagesterraformpngheight20px-terraform---utworzenie-maszyny-wirtualnej-za-pomoc%C4%85-na-proxmox/)
## Krok 2. Napisanie roli

Przygotowałem sobie rolę (konfiguracja serwera SSH) [configure-ssh](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh)

## Krok 3. Przygotowanie molecule

Przygotowanie venv
```bash
python3 -m venv ~/.venvs/molecule
source ~/.venvs/molecule/bin/activate
pip install --upgrade pip

pip3 install ansible-core molecule molecule-proxmox pytest-testinfra ansible-lint molecule-plugins requests testinfra
```

Utworzenie projektu molecule
```bash
molecule init role nazwa_roli
```
Napisanie małego testu w pythonie `molecule/default/tests/test_sshd_config.py` 
```py
import pytest

SSHD_SERVICE_NAME = "sshd"
SSHD_CONFIG_PATH = "/etc/ssh/sshd_config"
SSHD_PORT = "22"
PERMIT_ROOT_LOGIN = "no"
PASSWORD_AUTHENTICATION = "no"

def get_hostname(host):
    """Pobiera rzeczywisty hostname testowanego serwera"""
    return host.check_output("hostname")


def test_sshd_running_and_enabled(host):
    """Test sprawdzający, czy usługa SSHD działa i jest włączona"""
    ssh_service = host.service(SSHD_SERVICE_NAME)

    assert ssh_service.is_running, "❌ SSHD nie jest uruchomione!"
    assert ssh_service.is_enabled, "❌ SSHD nie jest ustawione do uruchamiania przy starcie systemu!"

def test_sshd_config_exist(host):
    """Test sprawdzający poprawność konfiguracji SSHD"""

    sshd_config = host.file(SSHD_CONFIG_PATH)
    assert sshd_config.exists, f"❌ Plik konfiguracji SSHD nie istnieje: {SSHD_CONFIG_PATH}"

def test_sshd_config_check_mode(host):
    """Test sprawdzający uprawnienia pliku konfiguracji SSHD"""  

    sshd_config = host.file(SSHD_CONFIG_PATH)
    assert sshd_config.user == "root", "❌ Plik konfiguracji SSHD nie jest własnością roota!"
    assert sshd_config.group == "root", "❌ Plik konfiguracji SSHD nie jest grupy roota!"
    assert sshd_config.mode == 0o644, "❌ Plik konfiguracji SSHD nie ma praw 644!"

def test_sshd_config_is_empty(host):
    """Test sprawdzający zawartość konfiguracji SSHD"""

    sshd_config = host.file(SSHD_CONFIG_PATH)
    sshd_config_content = sshd_config.content_string.strip()
    assert sshd_config_content, "❌ Plik konfiguracji SSHD jest pusty!"

def test_sshd_config_is_set_permit_root_login(host):
    """Test sprawdzający, czy w konfiguracji SSHD jest ustawione `PermitRootLogin`"""
    sshd_config = host.file(SSHD_CONFIG_PATH)
    sshd_config_content = sshd_config.content_string

    assert "PermitRootLogin "+PERMIT_ROOT_LOGIN in sshd_config_content, "❌ `PermitRootLogin {PERMIT_ROOT_LOGIN}` nie jest ustawione!"

def test_sshd_config_is_set_password_authentication(host):
    """Test sprawdzający, czy w konfiguracji SSHD jest ustawione `PasswordAuthentication`"""
    sshd_config = host.file(SSHD_CONFIG_PATH)
    sshd_config_content = sshd_config.content_string

    assert "PasswordAuthentication "+PASSWORD_AUTHENTICATION in sshd_config_content, "❌ `PermitRootLogin {PASSWORD_AUTHENTICATION}` nie jest ustawione!"

def test_sshd_config_is_set_port(host):
    """Test sprawdzający, czy w konfiguracji SSHD jest ustawione `Port`"""
    sshd_config = host.file(SSHD_CONFIG_PATH)
    sshd_config_content = sshd_config.content_string

    assert "Port "+SSHD_PORT in sshd_config_content, "❌ `Port {SSHD_PORT}` nie jest ustawione!"   

```

## Krok 4. Konfiguracja molecule
```
---
driver:
    name: molecule-proxmox
    options:
        debug: true
        # api_host:                       # from TEST_PROXMOX_HOST
        # api_user:                       # from TEST_PROXMOX_USER
        # api_password:                   # from TEST_PROXMOX_PASSWORD
        # node:                           # from TEST_PROXMOX_NODE
        ssh_user: pkr_admin
        ssh_port: 22
        ssh_identity_file: /tmp/molecule
        timeout: 3600

platforms:
    - name: molecule-ubuntu
      template_name: ubuntu-24.10
      full: false
      pool: molecule
      net:
          net0: 'virtio,bridge=vmbr0,tag=10'
      ipconfig:
          ipconfig0: "ip=dhcp"
      core: 1
      cpu: 1
      memory: 2048

    - name: molecule-alpine
      template_name: alpine-3.21.2
      full: false
      pool: molecule
      net:
          net0: 'virtio,bridge=vmbr0,tag=10'
      ipconfig:
          ipconfig0: "ip=dhcp"
      core: 1
      cpu: 1
      memory: 2048

    - name: molecule-alma
      template_name: AlmaLinux-9.5
      full: false
      pool: molecule
      net:
          net0: 'virtio,bridge=vmbr0,tag=10'
      ipconfig:
          ipconfig0: "ip=dhcp"
      core: 1
      cpu: 1
      memory: 2048

provisioner:
    name: ansible
    env:
        ANSIBLE_ROLES_PATH: ../../../../roles/
        ANSIBLE_HOST_KEY_CHECKING: False
        ANSIBLE_FORCE_COLOR: True
    config_options:
        ssh-connection:
            host_key_checking: false

verifier:
    name: testinfra
    options:
        v: true
        s: true

```
Pierwsze uruchomienie się nie udało, powodem było to, że defaultowe playbooki nie spełniają moich oczekiwań

## Krok 5. Dostowanie defaultowych playbooków

Oryginalny playbook znajduje się ~/.venvs/molecule/lib/python3.12/site-packages/molecule_proxmox/playbooks/create.yml
```bash
cp ~/.venvs/molecule/lib/python3.12/site-packages/molecule_proxmox/playbooks/create.yml molecule/default/create.yml
```
```yml
---
- name: Create
  hosts: localhost
  connection: local
  gather_facts: false
  vars:
      options: "{{ molecule_yml.driver.options }}"
  tasks:
    - name: "Load proxmox secrets."
      ansible.builtin.include_vars: "{{ options.proxmox_secrets }}"
      when: options.proxmox_secrets is defined
      no_log: true
    - name: "Create molecule instance(s)."
      community.general.proxmox_kvm:
        state: present
        
        {--api_host: "{{ api_host | d(options.api_host) | d(omit) }}"
        api_user: "{{ api_user | d(options.api_user) | d(omit) }}"
        api_password: "{{ api_password | d(options.api_password) | d(omit) }}"--}
        {++api_host: "{{ api_host | d(options.api_host) | d(lookup('env', 'TEST_PROXMOX_HOST')) | d(omit) }}"
        api_port: "{{ api_port | d(options.api_port) | d(lookup('env', 'TEST_PROXMOX_PORT') | int) | d(omit) }}"
        api_user: "{{ api_user | d(options.api_user) | d(lookup('env', 'TEST_PROXMOX_USER')) | d(omit) }}"
        api_password: "{{ api_password | d(options.api_password) | d(lookup('env', 'TEST_PROXMOX_PASSWORD')) | d(omit) }}"++}
        api_token_id: "{{ api_token_id | d(options.api_token_id) | d(omit) }}"
        api_token_secret: "{{ api_token_secret | d(options.api_token_secret) | d(omit) }}"
        vmid: "{{ p.proxmox_template_vmid | d(p.template_vmid, true) | d(omit, true) }}"
        clone: "{{ p.proxmox_template_name | d(p.template_name, true) | d(options.template_name, true) | d(p.box, true) | d('molecule', true) }}"
        name: "{{ p.name }}"
        {--node: "{{ options.node }}"--}
        {++node: "{{ options.node | d(lookup('env', 'TEST_PROXMOX_NODE'))  }}"++}
        timeout: "{{ options.timeout | d(omit) }}"
        pool: "{{ options.pool | d(omit) }}"
        newid: "{{ p.newid | d(p.newid, true) | d(omit, true) }}"
      loop: "{{ molecule_yml.platforms }}"
      loop_control:
        loop_var: p
        label: "{{ p.name }}"
      register: proxmox_clone

    - name: "Update molecule instance config(s)"
      community.general.proxmox_kvm:
        state: present
        update: true
        {--api_host: "{{ api_host | d(options.api_host) | d(omit) }}"
        api_user: "{{ api_user | d(options.api_user) | d(omit) }}"
        api_password: "{{ api_password | d(options.api_password) | d(omit) }}"--}
        {++api_host: "{{ api_host | d(options.api_host) | d(lookup('env', 'TEST_PROXMOX_HOST')) | d(omit) }}"
        api_port: "{{ api_port | d(options.api_port) | d(lookup('env', 'TEST_PROXMOX_PORT') | int) | d(omit) }}"
        api_user: "{{ api_user | d(options.api_user) | d(lookup('env', 'TEST_PROXMOX_USER')) | d(omit) }}"
        api_password: "{{ api_password | d(options.api_password) | d(lookup('env', 'TEST_PROXMOX_PASSWORD')) | d(omit) }}"++}
        api_token_id: "{{ api_token_id | d(options.api_token_id) | d(omit) }}"
        api_token_secret: "{{ api_token_secret | d(options.api_token_secret) | d(omit) }}"
        vmid: "{{ rc.vmid }}"
        {--node: "{{ options.node }}"--}
        {++node: "{{ options.node | d(lookup('env', 'TEST_PROXMOX_NODE'))  }}"++}
        timeout: "{{ options.timeout | d(omit) }}"
        ciuser: "{{ rc.p.ciuser | d(omit, true) }}"
        {++ # W celu przyszpieszenia stawiania vm, nie chce klonować dysku
        full: "{{ p.full | d(options.full) | d(omit) }}"++}
        cipassword: "{{ rc.p.cipassword | d(omit, true) }}"
        citype: "{{ rc.p.citype | d(omit, true) }}"
        ipconfig: "{{ rc.p.ipconfig | d(omit, true) }}"
        nameservers: "{{ rc.p.nameservers | d(omit, true) }}"
        searchdomains: "{{ rc.p.searchdomains | d(omit, true) }}"
        sshkeys: "{{ rc.p.sshkeys | d(omit, true) }}"
      when: >
        rc.p.ciuser is defined or
        rc.p.cipassword is defined or
        rc.p.citype is defined or
        rc.p.ipconfig is defined or
        rc.p.nameservers is defined or
        rc.p.searchdomains is defined or
        rc.p.sshkeys is defined
      loop: "{{ proxmox_clone.results }}"
      loop_control:
        loop_var: rc
        label: "{{ rc.p.name, rc.vmid }}"

    - name: "Start molecule instance(s)."
      proxmox_qemu_agent:
        {--api_host: "{{ api_host | d(options.api_host) | d(omit) }}"
        api_user: "{{ api_user | d(options.api_user) | d(omit) }}"
        api_password: "{{ api_password | d(options.api_password) | d(omit) }}"--}
        {++api_host: "{{ api_host | d(options.api_host) | d(lookup('env', 'TEST_PROXMOX_HOST')) | d(omit) }}"
        api_port: "{{ api_port | d(options.api_port) | d(lookup('env', 'TEST_PROXMOX_PORT') | int) | d(omit) }}"
        api_user: "{{ api_user | d(options.api_user) | d(lookup('env', 'TEST_PROXMOX_USER')) | d(omit) }}"
        api_password: "{{ api_password | d(options.api_password) | d(lookup('env', 'TEST_PROXMOX_PASSWORD')) | d(omit) }}"++}
        api_token_id: "{{ api_token_id | d(options.api_token_id) | d(omit) }}"
        api_token_secret: "{{ api_token_secret | d(options.api_token_secret) | d(omit) }}"
        vmid: "{{ rc.vmid }}"
        timeout: "{{ options.timeout | d(omit) }}"
      loop: "{{ proxmox_clone.results }}"
      loop_control:
        loop_var: rc
        label: "{{ rc.p.name, rc.vmid }}"
      register: proxmox_qemu_agent

    - name: "Populate instance configs."
      ansible.builtin.set_fact:
        instance_config:
          instance: "{{ ra.rc.p.name }}"
          address: "{{ ra.addresses[0] }}"
          user: "{{ options.ssh_user | d('molecule') }}"
          port: 22
          identity_file: "{{ options.ssh_identity_file }}"
          vmid: "{{ ra.vmid }}"
      loop: "{{ proxmox_qemu_agent.results }}"
      loop_control:
        loop_var: ra
        label: "{{ ra.rc.p.name, ra.vmid, ra.addresses[0] }}"
      register: instance_configs

    - name: "Set instance_config fact."
      ansible.builtin.set_fact:
        instance_configs: "{{ instance_configs.results | map(attribute='ansible_facts.instance_config') | list }}"

    - name: "Write instance configs."
      ansible.builtin.copy:
        content: "{{ instance_configs | to_nice_yaml }}"
        dest: "{{ molecule_instance_config }}"
        mode: '0644'

```
Oryginalny playbook znajduje się ~/.venvs/molecule/lib/python3.12/site-packages/molecule_proxmox/playbooks/destroy.yml
```bash
cp ~/.venvs/molecule/lib/python3.12/site-packages/molecule_proxmox/playbooks/destroy.yml molecule/default/destroy.yml
```

```yml
---
- name: Destroy
  hosts: localhost
  connection: local
  gather_facts: false
  vars:
      options: "{{ molecule_yml.driver.options }}"
  tasks:
    - name: "Load proxmox secrets."
      ansible.builtin.include_vars: "{{ options.proxmox_secrets }}"
      when: options.proxmox_secrets is defined
      no_log: true

    # Remove instances by numeric vmid instead of by name, which seems
    # safer and more reliable. Since the Ansible lookup() plugin complains
    # even when error=ingore is set, just create an empty file to ignore
    # a missing instance_configs.
    - name: "Check for instance configs."
      ansible.builtin.stat:
        path: "{{ molecule_instance_config }}"
      register: instance_config_stat

    - name: "Write empty instance configs."
      ansible.builtin.copy:
        content: "[]"
        dest: "{{ molecule_instance_config }}"
        mode: '0644'
      when: not instance_config_stat.stat.exists

    - name: "Remove molecule instance(s)."
      community.general.proxmox_kvm:
        {--api_host: "{{ api_host | d(options.api_host) | d(omit) }}"
        api_user: "{{ api_user | d(options.api_user) | d(omit) }}"
        api_password: "{{ api_password | d(options.api_password) | d(omit) }}"--}
        {++api_host: "{{ api_host | d(options.api_host) | d(lookup('env', 'TEST_PROXMOX_HOST')) | d(omit) }}"
        api_port: "{{ api_port | d(options.api_port) | d(lookup('env', 'TEST_PROXMOX_PORT') | int) | d(omit) }}"
        api_user: "{{ api_user | d(options.api_user) | d(lookup('env', 'TEST_PROXMOX_USER')) | d(omit) }}"
        api_password: "{{ api_password | d(options.api_password) | d(lookup('env', 'TEST_PROXMOX_PASSWORD')) | d(omit) }}"++}
        api_token_id: "{{ api_token_id | d(options.api_token_id) | d(omit) }}"
        api_token_secret: "{{ api_token_secret | d(options.api_token_secret) | d(omit) }}"
        {--node: "{{ options.node }}"--}
        {++node: "{{ options.node | d(lookup('env', 'TEST_PROXMOX_NODE'))  }}"++}
        state: absent
        vmid: "{{ i.vmid }}"
        force: yes
        timeout: "{{ options.timeout | d(omit) }}"
      loop: "{{ lookup('file', molecule_instance_config) | from_yaml }}"
      loop_control:
        loop_var: i
        label: "{{ i.instance, i.vmid }}"
```

## Krok 5. Uruchamiamy testy
```bash
export TEST_PROXMOX_DEBUG="true"
export TEST_PROXMOX_HOST="<<pve>>"
export TEST_PROXMOX_PORT="8006"
export TEST_PROXMOX_USER="root@pam"
export TEST_PROXMOX_PASSWORD="<<password>>"
export TEST_PROXMOX_NODE="<<node>>"

molecule test

# molecule create
# molecule converge
# molecule verify
# molecule destroy

```
```bash
WARNING  Driver molecule-proxmox does not provide a schema.
INFO     default scenario test matrix: dependency, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Running default > dependency
Molecule default > dependency
00:00
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > cleanup
Molecule default > cleanup
00:00
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
Molecule default > destroy
00:28
PLAY [Destroy] *****************************************************************
TASK [Load proxmox secrets.] ***************************************************
skipping: [localhost]
TASK [Check for instance configs.] *********************************************
ok: [localhost]
TASK [Write empty instance configs.] *******************************************
changed: [localhost]
TASK [Remove molecule instance(s).] ********************************************
skipping: [localhost]
PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
INFO     Running default > syntax
Molecule default > syntax
00:01
playbook: /builds/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh/molecule/default/converge.yml
INFO     Running default > create
Molecule default > create
00:11
PLAY [Create] ******************************************************************
TASK [Create molecule instance(s).] ********************************************
ok: [localhost] => (item=molecule-ubuntu)
ok: [localhost] => (item=molecule-alpine)
ok: [localhost] => (item=molecule-alma)
TASK [Update molecule instance config(s)] **************************************
changed: [localhost] => (item=('molecule-ubuntu', 105))
changed: [localhost] => (item=('molecule-alpine', 106))
changed: [localhost] => (item=('molecule-alma', 107))
TASK [Start molecule instance(s).] *********************************************
ok: [localhost] => (item=('molecule-ubuntu', 105))
ok: [localhost] => (item=('molecule-alpine', 106))
ok: [localhost] => (item=('molecule-alma', 107))
TASK [Populate instance configs.] **********************************************
ok: [localhost] => (item=('molecule-ubuntu', 105, '10.3.1.208'))
ok: [localhost] => (item=('molecule-alpine', 106, '10.3.1.209'))
ok: [localhost] => (item=('molecule-alma', 107, '10.3.1.210'))
TASK [Set instance_config fact.] ***********************************************
ok: [localhost]
TASK [Write instance configs.] *************************************************
changed: [localhost]
PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
INFO     Running default > prepare
Molecule default > prepare
00:05
PLAY [Prepare] *****************************************************************
TASK [Waiting for instance ssh connection.] ************************************
ok: [molecule-alpine]
ok: [molecule-alma]
ok: [molecule-ubuntu]
TASK [Set instance hostname.] **************************************************
ok: [molecule-alma]
ok: [molecule-alpine]
ok: [molecule-ubuntu]
TASK [Gather facts.] ***********************************************************
ok: [molecule-alpine]
ok: [molecule-alma]
ok: [molecule-ubuntu]
TASK [Remove workaround loopback from /etc/hosts file.] ************************
changed: [molecule-alpine]
changed: [molecule-ubuntu]
ok: [molecule-alma]
TASK [Add address and hostname to /etc/hosts file.] ****************************
changed: [molecule-ubuntu]
changed: [molecule-alpine]
changed: [molecule-alma]
PLAY RECAP *********************************************************************
molecule-alma              : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
molecule-alpine            : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
molecule-ubuntu            : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
INFO     Running default > converge
Molecule default > converge
00:10
PLAY [Converge] ****************************************************************
TASK [Gathering Facts] *********************************************************
ok: [molecule-alpine]
ok: [molecule-alma]
ok: [molecule-ubuntu]
TASK [configure-ssh : Include install tasks] ***********************************
included: /builds/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh/tasks/install.yml for molecule-alma, molecule-alpine, molecule-ubuntu
TASK [configure-ssh : debug] ***************************************************
ok: [molecule-alma] => {
    "msg": "RedHat"
}
ok: [molecule-alpine] => {
    "msg": "Alpine"
}
ok: [molecule-ubuntu] => {
    "msg": "Debian"
}
TASK [configure-ssh : [Debian] Install ssh] ************************************
skipping: [molecule-alma]
skipping: [molecule-alpine]
ok: [molecule-ubuntu]
TASK [configure-ssh : [Alpine] Install ssh] ************************************
skipping: [molecule-alma]
skipping: [molecule-ubuntu]
ok: [molecule-alpine]
TASK [configure-ssh : [RedHat] Install ssh] ************************************
skipping: [molecule-alpine]
skipping: [molecule-ubuntu]
ok: [molecule-alma]
TASK [configure-ssh : Include config tasks] ************************************
included: /builds/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh/tasks/config.yml for molecule-alma, molecule-alpine, molecule-ubuntu
TASK [configure-ssh : Set SSH Port] ********************************************
changed: [molecule-ubuntu]
changed: [molecule-alpine]
changed: [molecule-alma]
TASK [configure-ssh : Block Password Authentication ssh] ***********************
changed: [molecule-ubuntu]
changed: [molecule-alpine]
changed: [molecule-alma]
TASK [configure-ssh : Block login as root] *************************************
changed: [molecule-ubuntu]
ok: [molecule-alpine]
changed: [molecule-alma]
TASK [configure-ssh : Change mode file] ****************************************
ok: [molecule-ubuntu]
ok: [molecule-alpine]
changed: [molecule-alma]
RUNNING HANDLER [configure-ssh : Restart SSHD] *********************************
changed: [molecule-alma]
changed: [molecule-alpine]
changed: [molecule-ubuntu]
PLAY RECAP *********************************************************************
molecule-alma              : ok=10   changed=5    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
molecule-alpine            : ok=10   changed=3    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
molecule-ubuntu            : ok=10   changed=4    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
INFO     Running default > idempotence
Molecule default > idempotence
00:08
PLAY [Converge] ****************************************************************
TASK [Gathering Facts] *********************************************************
ok: [molecule-alpine]
ok: [molecule-ubuntu]
ok: [molecule-alma]
TASK [configure-ssh : Include install tasks] ***********************************
included: /builds/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh/tasks/install.yml for molecule-alma, molecule-alpine, molecule-ubuntu
TASK [configure-ssh : debug] ***************************************************
ok: [molecule-alma] => {
    "msg": "RedHat"
}
ok: [molecule-alpine] => {
    "msg": "Alpine"
}
ok: [molecule-ubuntu] => {
    "msg": "Debian"
}
TASK [configure-ssh : [Debian] Install ssh] ************************************
skipping: [molecule-alma]
skipping: [molecule-alpine]
ok: [molecule-ubuntu]
TASK [configure-ssh : [Alpine] Install ssh] ************************************
skipping: [molecule-alma]
skipping: [molecule-ubuntu]
ok: [molecule-alpine]
TASK [configure-ssh : [RedHat] Install ssh] ************************************
skipping: [molecule-alpine]
skipping: [molecule-ubuntu]
ok: [molecule-alma]
TASK [configure-ssh : Include config tasks] ************************************
included: /builds/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh/tasks/config.yml for molecule-alma, molecule-alpine, molecule-ubuntu
TASK [configure-ssh : Set SSH Port] ********************************************
ok: [molecule-ubuntu]
ok: [molecule-alpine]
ok: [molecule-alma]
TASK [configure-ssh : Block Password Authentication ssh] ***********************
ok: [molecule-alpine]
ok: [molecule-ubuntu]
ok: [molecule-alma]
TASK [configure-ssh : Block login as root] *************************************
ok: [molecule-alpine]
ok: [molecule-ubuntu]
ok: [molecule-alma]
TASK [configure-ssh : Change mode file] ****************************************
ok: [molecule-ubuntu]
ok: [molecule-alpine]
ok: [molecule-alma]
PLAY RECAP *********************************************************************
molecule-alma              : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
molecule-alpine            : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
molecule-ubuntu            : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
INFO     Idempotence completed successfully.
INFO     Running default > side_effect
Molecule default > side_effect
00:00
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
Molecule default > verify
00:02
INFO     Executing Testinfra tests found in /builds/pl.rachuna-net/infrastructure/ansible/roles/configure-ssh/molecule/default/tests/...
============================= test session starts ==============================
platform linux -- Python 3.9.21, pytest-8.3.4, pluggy-1.5.0 -- /usr/local/bin/python3.9
rootdir: /
plugins: testinfra-10.1.1, testinfra-6.0.0
collecting ... collected 21 items
tests/test_sshd_config.py::test_sshd_running_and_enabled[ansible://molecule-alma] PASSED [  4%]
tests/test_sshd_config.py::test_sshd_config_exist[ansible://molecule-alma] PASSED [  9%]
tests/test_sshd_config.py::test_sshd_config_check_mode[ansible://molecule-alma] PASSED [ 14%]
tests/test_sshd_config.py::test_sshd_config_is_empty[ansible://molecule-alma] PASSED [ 19%]
tests/test_sshd_config.py::test_sshd_config_is_set_permit_root_login[ansible://molecule-alma] PASSED [ 23%]
tests/test_sshd_config.py::test_sshd_config_is_set_password_authentication[ansible://molecule-alma] PASSED [ 28%]
tests/test_sshd_config.py::test_sshd_config_is_set_port[ansible://molecule-alma] PASSED [ 33%]
tests/test_sshd_config.py::test_sshd_running_and_enabled[ansible://molecule-alpine] PASSED [ 38%]
tests/test_sshd_config.py::test_sshd_config_exist[ansible://molecule-alpine] PASSED [ 42%]
tests/test_sshd_config.py::test_sshd_config_check_mode[ansible://molecule-alpine] PASSED [ 47%]
tests/test_sshd_config.py::test_sshd_config_is_empty[ansible://molecule-alpine] PASSED [ 52%]
tests/test_sshd_config.py::test_sshd_config_is_set_permit_root_login[ansible://molecule-alpine] PASSED [ 57%]
tests/test_sshd_config.py::test_sshd_config_is_set_password_authentication[ansible://molecule-alpine] PASSED [ 61%]
tests/test_sshd_config.py::test_sshd_config_is_set_port[ansible://molecule-alpine] PASSED [ 66%]
tests/test_sshd_config.py::test_sshd_running_and_enabled[ansible://molecule-ubuntu] PASSED [ 71%]
tests/test_sshd_config.py::test_sshd_config_exist[ansible://molecule-ubuntu] PASSED [ 76%]
tests/test_sshd_config.py::test_sshd_config_check_mode[ansible://molecule-ubuntu] PASSED [ 80%]
tests/test_sshd_config.py::test_sshd_config_is_empty[ansible://molecule-ubuntu] PASSED [ 85%]
tests/test_sshd_config.py::test_sshd_config_is_set_permit_root_login[ansible://molecule-ubuntu] PASSED [ 90%]
tests/test_sshd_config.py::test_sshd_config_is_set_password_authentication[ansible://molecule-ubuntu] PASSED [ 95%]
tests/test_sshd_config.py::test_sshd_config_is_set_port[ansible://molecule-ubuntu] PASSED [100%]
============================== 21 passed in 1.37s ==============================
INFO     Verifier completed successfully.
INFO     Running default > cleanup
Molecule default > cleanup
00:00
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
Molecule default > destroy
00:28
PLAY [Destroy] *****************************************************************
TASK [Load proxmox secrets.] ***************************************************
skipping: [localhost]
TASK [Check for instance configs.] *********************************************
ok: [localhost]
TASK [Write empty instance configs.] *******************************************
skipping: [localhost]
TASK [Remove molecule instance(s).] ********************************************
changed: [localhost] => (item=('molecule-ubuntu', '105'))
changed: [localhost] => (item=('molecule-alpine', '106'))
changed: [localhost] => (item=('molecule-alma', '107'))
PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```