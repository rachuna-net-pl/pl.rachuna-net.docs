---
title: Instalacja Consul & vault
description: Instalacja Consul & vault
---
# Instalacja ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/consul.png){width=20px} Consul & ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/vault.png){width=20px} Vault


---
## ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/terraform.png){width=20px} Utworzenie maszyn wirtualnych

| Opis | Code |
|------|------|
|Node 1|[ct01011](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/ct01011.tf?ref_type=heads)|
|Node 2|[ct01012](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/ct01012.tf?ref_type=heads)|
|Node 3|[ct01013](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/ct01013.tf?ref_type=heads)|
|HA-Proxy|[ct01021](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/ct01021.tf?ref_type=heads)|
|HA-Proxy|[ct01022](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/proxmox/-/blob/main/virtual_machines/ct01022.tf?ref_type=heads)|

### **Przykładowa definicja noda consul & proxmox**
```hcl
module "ct01101" {
  source = "git@gitlab.com:pl.rachuna-net/infrastructure/terraform/modules/proxmox-container.git?ref=v1.1.0"

  hostname      = "ct01011.rachuna-net.pl"
  description   = "Hashicorp Vault & Consul"
  node_name     = "pve-s1"
  vm_id         = 1011
  pool_id       = "vault-consul"
  protection    = true
  start_on_boot = true
  tags          = ["vault-consul", "ubuntu"]
  unprivileged  = true
  is_dmz        = false
  mac_address   = "BC:24:11:8F:7A:CA"

  cpu_cores = 1
  memory = {
    dedicated = 512
    swap      = 512
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
### **Przykładowa definicja noda haproxy**
```
module "ct01021" {
  source = "git@gitlab.com:pl.rachuna-net/infrastructure/terraform/modules/proxmox-container.git?ref=v1.1.0"

  hostname      = "ct01021.rachuna-net.pl"
  description   = "Internal Web Proxy & Reverse Proxy"
  node_name     = "pve-s1"
  vm_id         = 1021
  pool_id       = "web-proxy"
  protection    = true
  start_on_boot = true
  tags          = ["web-proxy", "ubuntu", "nginx"]
  unprivileged  = true
  is_dmz        = false
  mac_address   = "BC:24:11:7D:DF:F1"

  cpu_cores = 1
  memory = {
    dedicated = 512
    swap      = 512
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



### Aktywacja głównego tokenu consula
```bash
consul acl bootstrap
```

```
AccessorID:       12345678-8901-1234-5678-890123456788
SecretID:         12345678-8901-1234-5678-890123456788
Description:      Bootstrap Token (Global Management)
Local:            false
Create Time:      2025-06-11 21:05:57.312939837 +0000 UTC
Policies:
   00000000-0000-0000-0000-000000000001 - global-management
```

### Iac - Consul
https://gitlab.com/pl.rachuna-net/infrastructure/terraform/consul


### Aktywacja vault
root@ct01011:~# vault operator init
Unseal Key 1: abcd
Unseal Key 2: efgh
Unseal Key 3: ijkl
Unseal Key 4: mnop
Unseal Key 5: rstu

Initial Root Token: hvs.abcdefghijklmnopr
