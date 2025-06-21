---
title: Instalacja Gitlab Runners
description: Instalacja Gitlab Runners
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){width=20px} Instalacja Gitlab Runners


---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} Utworzenie virtualnych maszyn na proxmox


Za pomocą definicji w terraform utworzone zostają dwa gitlab-runnery [ct01001](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/ct01001.tf?ref_type=heads
) i [ct01002](
https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/ct01002.tf?ref_type=heads)

Przykładowa definicja
```tf
module "ct01001" {
  source = "git@gitlab.com:pl.rachuna-net/infrastructure/terraform/modules/proxmox-container.git?ref=v1.1.0"

  hostname      = "ct01001.rachuna-net.pl"
  description   = "gitlab-runner s1"
  node_name     = "pve-s1"
  vm_id         = 1001
  pool_id       = "gitlab-runner"
  protection    = true
  start_on_boot = true
  tags          = ["gitlab-runner", "ubuntu"]
  unprivileged  = true
  is_dmz        = false
  mac_address   = "BC:24:11:AC:D3:B5"

  cpu_cores = 2
  memory = {
    dedicated = 1024
    swap      = 1024
  }
  disk = {
    storage_name = local.storage_name
    disk_size    = 32
  }

  operating_system = {
    template_file = join("/", [local.ct_storage_name, "ubuntu-24.10.tar.zst"])
    type          = "ubuntu"
  }

  root = {
    password    = var.container_password
    ssh_pub_key = var.technical_user_ssh_pub_key
  }
}
```

---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} Konfiguracja inventory

Definicja hostów
```yaml
---
all:
  children:
    linux:
      children:
        ubuntu:
          children:
            gitlab-runner:
              hosts:
                ct01001:
                ct01002:
```

Grupa gitlab-runner
```
gitlab-runner
└── configuration.yml
```

`group_vars/gitlab-runner/configuration.yml`
```yaml
---
gitlab_runner_configuration:
  concurrent: 100
  check_interval: 0
  shutdown_timeout: 0
  session_timeout: 3600
  runners:
    - name: "pl.rachuna-net.runner.cd"
      url: "https://gitlab.com"
      register_runner:
        id: "{{ lookup('env', 'GITLAB_RUNNER_CD_ID') }}"
        token: "{{ lookup('env', 'GITLAB_RUNNER_CD_TOKEN') }}"
        register_gitlab_api_token: "{{ lookup('env', 'GITLAB_TOKEN') }}"
        description: "GitLab Runner for pl.rachuna-net"
        tag_list: ["onprem", "process-cd"]
        runner_type: "group_type"
        group_id: "{{ lookup('env', 'GITLAB_GROUP_REPOSITORY_ID') }}"
        access_level: "not_protected"
      executor: "docker"
      docker:
        tls_verify: false
        image: "docker:latest"
        privileged: true
        disable_entrypoint_overwrite: false
        oom_kill_disable: false
        disable_cache: false
        volumes:
          - "/cache"
          - "/var/run/docker.sock:/var/run/docker.sock"
          - "/etc/ssl/certs:/etc/ssl/certs:ro"
        shm_size: 0
        network_mode: "host"
    - name: "pl.rachuna-net.runner.ci"
      url: "https://gitlab.com"
      register_runner:
        id: "{{ lookup('env', 'GITLAB_RUNNER_CI_ID') }}"
        token: "{{ lookup('env', 'GITLAB_RUNNER_CI_TOKEN') }}"
        register_gitlab_api_token: "{{ lookup('env', 'GITLAB_TOKEN') }}"
        description: "GitLab Runner for pl.rachuna-net"
        tag_list: ["onprem", "process-ci"]
        runner_type: "group_type"
        group_id: "{{ lookup('env', 'GITLAB_GROUP_REPOSITORY_ID') }}"
        access_level: "not_protected"
      executor: "docker"
      docker:
        network_mode: "bridge"
        tls_verify: false
        image: "docker:latest"
        privileged: true
        disable_entrypoint_overwrite: false
        oom_kill_disable: false
        disable_cache: false
        volumes:
          - "/cache"
          - "/var/run/docker.sock:/var/run/docker.sock"
          - "/etc/ssl/certs:/etc/ssl/certs:ro"
        shm_size: 0
```
---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/ansible.png){width=20px} Instalacja za pomocą ansible

Należy uruchomić dwa playbooki:

1. [linux-hardening](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/linux-hardening)
1. [gitlab-runner](https://gitlab.com/pl.rachuna-net/infrastructure/ansible/playbooks/gitlab-runner)
