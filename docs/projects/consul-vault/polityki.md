🔐 Co to są polityki w HashiCorp Vault?
Polityki (policies) to zestawy reguł opisujące, do jakich zasobów Vaulta dany podmiot (np. użytkownik, aplikacja) ma dostęp oraz jakie operacje może wykonać.

Vault korzysta z RBAC – Role-Based Access Control. Polityki przypisuje się:

użytkownikom (np. przez integrację z LDAP, GitHub, Okta)

tokenom (np. z vault login)

aplikacjom (np. przez AppRole, JWT itd.)