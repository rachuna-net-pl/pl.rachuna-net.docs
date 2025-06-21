---
title: Infrastruktura sieciowa
description: Infrastruktura sieciowa
authors: Maciej Rachuna
---

# 🌐 Infrastruktura sieciowa
---

Poniżej znajduje się architektura sieciowa systemu, która przedstawia sposób organizacji połączeń między poszczególnymi komponentami infrastruktury. Sieć została podzielona na logiczne segmenty (np. warstwę dostępową, sieć prywatną, DMZ), co zapewnia izolację usług, lepsze bezpieczeństwo i kontrolę ruchu. Komunikacja między warstwami odbywa się za pośrednictwem routerów i zapór sieciowych, a dostęp do zasobów jest regulowany za pomocą list kontroli dostępu (ACL) oraz mechanizmów autoryzacji. Całość została zaprojektowana z uwzględnieniem wysokiej dostępności i możliwości skalowania.

[Infrastrucure as a Code](https://gitlab.com/pl.rachuna-net/infrastructure/terraform/router.rachuna-net.pl)

---


--8<-- "docs/projects/Infrastruktura_sieciowa.html"