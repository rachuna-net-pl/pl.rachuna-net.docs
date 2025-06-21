---
title: Wstęp do SonarQube
description: Wstęp do SonarQube
---
# ![](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/modules/gitlab-project/-/raw/main/images/sonarqube.png){height=20px} SonarQube

**SonarQube**[^1] to narzędzie do analizy jakości kodu, które pomaga wykrywać błędy, podatności bezpieczeństwa i problemy związane ze stylem oraz technicznym długiem w kodzie źródłowym. Obsługuje wiele języków programowania i integruje się z popularnymi narzędziami CI/CD, takimi jak GitLab CI, Jenkins czy GitHub Actions. SonarQube oferuje statyczną analizę kodu, raporty z oceną jakości oraz wskazówki dotyczące poprawy kodu. Może działać zarówno lokalnie, jak i w środowisku serwerowym, wspierając zespoły w utrzymaniu wysokiej jakości oprogramowania.

[SonarCloud](https://sonarcloud.io/) to chmurowa wersja **SonarQube**, oferowana jako **SaaS (Software as a Service)** przez firmę SonarSource. Jest to narzędzie do analizy jakości i bezpieczeństwa kodu, które wspiera zespoły programistyczne w utrzymaniu wysokiej jakości oprogramowania. SonarCloud obsługuje ponad **30 języków programowania**, między innymi: Java, JavaScript, Python, Go i C#.  

**Najważniejsze funkcje SonarCloud:**

:   ✅ **Analiza jakości kodu** – wykrywanie błędów, kodu niezgodnego z dobrymi praktykami oraz potencjalnych problemów.  
    ✅ **Wykrywanie podatności bezpieczeństwa** – automatyczna analiza kodu pod kątem zagrożeń i podatności na ataki.  
    ✅ **Integracja z CI/CD** – działa z GitHub, GitLab, Azure DevOps i Bitbucket, analizując kod na bieżąco podczas pull requestów.  
    ✅ **Statystyki i raporty** – przejrzyste raporty dotyczące kodu, pokrycia testami i wskaźników jakości.  
    ✅ **Łatwa konfiguracja** – nie wymaga instalacji i działa w chmurze.  

SonarCloud oferuje **darmowy plan** dla publicznych repozytoriów oraz **płatne plany** dla projektów prywatnych. Jest szczególnie popularny wśród zespołów open-source i firm szukających łatwej integracji z systemami CI/CD bez konieczności samodzielnego hostowania narzędzia.

---
## Links

- [Getting started with GitLab](https://docs.sonarsource.com/sonarqube-cloud/getting-started/gitlab/?_gl=1*110suk1*_gcl_au*NDU4MjQzMTA3LjE3Mzg5MjYzMzQ.*_ga*MTY3OTUyNTA5OC4xNzM4OTI2MzMw*_ga_9JZ0GZ5TC6*MTczOTQzNzc1NS4xMi4xLjE3Mzk0MzgwNzguMTUuMC4w)


[^1]: https://www.sonarsource.com/products/sonarcloud/