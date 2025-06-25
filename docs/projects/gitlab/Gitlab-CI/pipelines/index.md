---
title: Lista procesów
description: Lista procesów
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/gitlab.png){height=20px} Lista procesów

Poniżej znajduje się lista stworzonych procesów

| process      | description |
|--------------|-------------|
|[.gitlab-ci.yml](.gitlab-ci.yml)| default     |
|[cicd/gitlab-ci.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/cicd/gitlab-ci.yml?ref_type=heads)| Proces dla gitlab-ci|
|[cicd/gitlab-components.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/cicd/gitlab-components.yml?ref_type=heads)| Proces dla gitlab-components|
|[containers/docker.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/containers/docker.yml?ref_type=heads) | Proces dla budowania kontenerów |
|[infrastructure/ansible-playbook.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/infrastructure/ansible-playbook.yml?ref_type=heads)| Proces deploymentu za pomocą ansible|
|[infrastructure/ansible-role.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/infrastructure/ansible-role.yml?ref_type=heads)| Proces wydawniczy dla ansible role|
|[infrastructure/packer.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/infrastructure/packer.yml?ref_type=heads)| Proces dla packer|
|[infrastructure/terraform.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/infrastructure/terraform.yml?ref_type=heads)| Proces dla terraform|
|[mkdocs/pages.yml](https://gitlab.com/pl.rachuna-net/cicd/gitlab-ci/-/blob/main/mkdocs/pages.yml?ref_type=heads)| Proces wydawniczy mkdocs na pages |