Sim, mas há um detalhe conceitual importante:

**OIDC/OpenID Connect não se conecta diretamente ao Active Directory ou ao Entra ID.**

OIDC é o **protocolo**. O Active Directory e o Entra ID são os **provedores de identidade (IdPs)**.

A arquitetura fica assim:

Angular

   |

   | OIDC

   v

ZITADEL

   |

   +--> Active Directory

   |

   +--> Microsoft Entra ID

   |

   +--> Google

   |

   +--> Usuários Locais

---

# No caso do Entra ID

Essa é a integração mais simples.

O [Microsoft Entra ID](https://www.office.com/search?q=Microsoft+Entra+ID&EntityRepresentationId=2f2eabaa-caa1-8434-b440-0ec909759dd1) já suporta nativamente:

- OAuth2
- OIDC
- SAML

O [ZITADEL](https://www.office.com/search?q=ZITADEL&EntityRepresentationId=bc40ae3e-17f9-88d5-adec-23b30ff8e3f3) pode federar a autenticação para o Entra ID e o usuário nem percebe. [[zitadel.com]](https://zitadel.com/docs/self-hosting/deploy/overview), [[deepwiki.com]](https://deepwiki.com/zitadel/zitadel/6-deployment-and-operations)

Fluxo:

Usuário

   |

   v

ZITADEL

   |

   v

Entra ID

   |

   v

JWT Token

---

# No caso do Active Directory On-Premises

Aqui existem algumas possibilidades.

## Opção 1 (mais comum)

Active Directory

      |

      v

Microsoft Entra Connect

      |

      v

Entra ID

      |

      v

ZITADEL

Esse é o modelo que a maioria das empresas modernas utiliza.

Vantagens:

✅ Cloud Ready

✅ Menos componentes

✅ MFA do Microsoft 365

✅ Menor manutenção

---

## Opção 2

ADFS

Active Directory

      |

      v

ADFS

      |

      v

ZITADEL

``

Muito comum em empresas mais antigas.

---

## Opção 3

LDAP Federation

Alguns Identity Providers conseguem consultar o AD diretamente via:

LDAP

LDAPS

Fluxo:

ZITADEL

    |

 LDAP

    |

 Active Directory

Você precisará validar na POC exatamente qual mecanismo de federação atende melhor sua realidade operacional.

---

# Para seu projeto eu faria assim

Você comentou:

- Sistema novo
- Sem migração
- Multi-tenant by design
- On-Premise First
- Cloud Ready

Eu desenharia desde o início:

Aplicações

    |

    v

ZITADEL

    |

    +--> Local Users

    |

    +--> Entra ID

    |

    +--> Active Directory (quando necessário)

Assim cada cliente escolhe seu provedor.

Exemplo:

Cliente A

    -> Usuários locais

Cliente B

    -> Entra ID

Cliente C

    -> Active Directory

Cliente D

    -> Google Workspace

Sua aplicação Angular e suas APIs .NET continuam enxergando apenas:

OIDC

JWT

Ou seja, você nunca precisa escrever código específico para AD, Entra ID ou Google.

---

# Minha recomendação para 2026

Se você está começando do zero, eu definiria como regra arquitetural:

Aplicação fala apenas OIDC.

Nunca:

Aplicação -> LDAP

Aplicação -> Active Directory

Aplicação -> Entra ID

Quem resolve isso é o Identity Provider.

No seu cenário, o fluxo ideal seria:

Angular

   |

ASP.NET API

   |

OIDC

   |

ZITADEL

   |

+---------------------+

| Local Users         |

| Entra ID            |

| Active Directory    |

+---------------------+

Isso preserva completamente seu objetivo de ser:

✅ Multi-tenant

✅ On-Premises

✅ Cloud Compatible

✅ Independente de fornecedor

✅ Fácil de evoluir no futuro

---

### Correção de português

Seu texto:

> "Azure id"

Mais correto:

> **Azure AD** (nome antigo)

ou, atualmente:

> **Microsoft Entra ID** ✅

Seu texto:

> "me permite conectar tanto no Active Directory quanto Azure id?"

Mais natural:

> **O OIDC/OpenID Connect me permite integrar tanto com o Active Directory quanto com o Microsoft Entra ID?** ✅