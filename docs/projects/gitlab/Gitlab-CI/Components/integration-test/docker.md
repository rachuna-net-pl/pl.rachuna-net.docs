---
title: docker
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/container.png){height=20px} docker

Ten proces automatyzuje budowanie, testowanie i wdrażanie aplikacji w projekcie GitLab.

---
### Wejściowe zmienne (`inputs`):

- **docker_image**  
  _Opis_: Obraz Docker, na którym zostanie uruchomiony job.  
  _Domyślnie_: `""` (należy podać własny obraz)

- **docker_test_script_path**  
  _Opis_: Ścieżka do skryptu testowego, który zostanie uruchomiony w kontenerze.  
  _Domyślnie_: `container_test.sh`

---
### Przykład użycia
```yaml
include:
  - component: $CI_SERVER_FQDN/pl.rachuna-net/cicd/components/integration-test/docker@$COMPONENT_VERSION_INTEGRATION_TEST

🧪 test docker image:
  needs:
    - job: 🕵 Set Version
      artifacts: true
    - job: 🌐 publish docker image
  variables:
    CONTAINER_IMAGE_DOCKER: $CI_REGISTRY_IMAGE:$RELEASE_CANDIDATE_VERSION
  rules: !reference [.rule:integration-test:docker, rules]
```

---
### Co robi template?

- Wyświetla logo projektu oraz ustawione zmienne wejściowe.
- Uruchamia wskazany skrypt testowy w podanym obrazie Docker.
- Umożliwia łatwą integrację testów kontenerowych w pipeline CI/CD.