Com esse contexto adicional, minha recomendação muda um pouco.

Se os requisitos estratégicos forem:

- ✅ On-Premise First
- ✅ Compatível com Cloud
- ✅ Multi-tenant by Design
- ✅ Open Source
- ✅ Integração com C#, Angular, PostgreSQL
- ✅ Possibilidade de crescer para SaaS

então eu faria uma análise diferente da que faria para uma aplicação corporativa tradicional.

---

# Revisitando o requisito de Multi-Tenant

Muitas equipes acreditam que:

> "Keycloak suporta multi-tenant"

Sim, suporta.

Mas existe uma diferença importante entre:

## Multi-tenant suportado

e

## Multi-tenant como conceito central da arquitetura

---

# Keycloak

O [Keycloak](https://www.office.com/search?q=Keycloak&EntityRepresentationId=d0578738-00f3-82d1-b20e-9c03df1b58ca) implementa isolamento através de **Realms**.

Exemplo:

Realm A

 ├─ usuários

 ├─ roles

 └─ aplicações

Realm B

 ├─ usuários

 ├─ roles

 └─ aplicações

Isso funciona muito bem.

Porém, quando você chega a:

- dezenas de tenants
- centenas de tenants
- automação de provisionamento
- SaaS

a gestão de Realms começa a ficar mais complexa.

Ainda assim, o Keycloak continua sendo uma solução extremamente completa e madura para IAM corporativo. [[skycloak.io]](https://skycloak.io/blog/zitadel-alternatives-developers/), [[alternativeto.net]](https://alternativeto.net/software/keycloak/?license=opensource)

---

# ZITADEL

O [ZITADEL](https://www.office.com/search?q=ZITADEL&EntityRepresentationId=bc40ae3e-17f9-88d5-adec-23b30ff8e3f3) nasceu com uma visão mais moderna.

Ele adota uma arquitetura fortemente orientada a:

- API First
- Cloud Native
- Multi-tenant
- Organizations

Por isso, muitos times SaaS o consideram uma alternativa moderna ao Keycloak. [[skycloak.io]](https://skycloak.io/blog/zitadel-alternatives-developers/), [[alternativeto.net]](https://alternativeto.net/software/zitadel/)

Seu modelo conceitual fica próximo de:

Organization

 ├─ Users

 ├─ Applications

 ├─ Roles

 └─ Policies

Em sistemas SaaS isso costuma ser mais natural.

---

# Authentik

O [Authentik](https://www.office.com/search?q=Authentik&EntityRepresentationId=b0573ffc-a663-878d-95ea-578df00b4663) provavelmente possui a melhor experiência administrativa entre as opções open source que discutimos. [[alternativeto.net]](https://alternativeto.net/software/keycloak/?license=opensource), [[alternativeto.net]](https://alternativeto.net/software/zitadel/)

Para:

- times pequenos
- startups
- produtos novos

ele é extremamente atraente.

Porém, quando falamos de:

On-Premise Enterprise +

Multi-Tenant SaaS +

Grande Escala

eu ainda colocaria Keycloak e Zitadel na frente.

---

# Se eu estivesse começando o projeto hoje

## Cenário 1

Aplicação corporativa tradicional

Cliente único

Até 20 sistemas integrados

AD / LDAP

On-Premise

``

Escolha:

🥇 Keycloak

---

## Cenário 2

Produto SaaS

100 clientes

500 clientes

1000 clientes

Escolha:

🥇 Zitadel

🥈 Keycloak

🥉 Authentik

[[skycloak.io]](https://skycloak.io/blog/zitadel-alternatives-developers/), [[alternativeto.net]](https://alternativeto.net/software/zitadel/)

---

# Sua arquitetura futura

Pelo contexto das perguntas anteriores, eu imagino algo próximo disto:

Angular

     |

     v

API Gateway

     |

     +----------------+

     |                |

     v                v

Maintenance API   Inventory API

     |                |

     +-------+--------+

             |

             v

        PostgreSQL

             ^

             |

         Identity

             |

     Keycloak/Zitadel

---

# Minha recomendação pessoal

Se eu recebesse hoje uma missão para criar seu sistema de manutenção com:

- MQTT
- NATS
- Angular
- C#
- PostgreSQL
- IA futura
- On-Premise First
- Cloud Ready
- Multi-Tenant

eu faria o seguinte:

### Fase 1

Utilizaria:

Keycloak

porque:

- extremamente maduro
- enorme comunidade
- excelente documentação
- integra perfeitamente com Angular e .NET
- risco tecnológico muito baixo

[[skycloak.io]](https://skycloak.io/blog/zitadel-alternatives-developers/), [[alternativeto.net]](https://alternativeto.net/software/keycloak/?license=opensource)

---

### Fase 2

Criaria a aplicação já preparada para trocar o IdP.

Nunca deixar o sistema dependente de APIs internas específicas do Keycloak.

Usar somente:

OIDC

OAuth2

JWT

SAML (quando necessário)

---

### Fase 3

Executaria uma POC paralela com:

Zitadel

avaliando:

- onboarding automático de tenant
- automação
- APIs administrativas
- operação Kubernetes
- cenários SaaS

[[skycloak.io]](https://skycloak.io/blog/zitadel-alternatives-developers/), [[alternativeto.net]](https://alternativeto.net/software/zitadel/)

---

# O que eu escolheria para um produto novo em 2026?

Minha classificação seria:

Produto corporativo

1. Keycloak

2. Zitadel

3. Authentik

Produto SaaS multi-tenant

1. Zitadel

2. Keycloak

3. Authentik

---

# E quanto ao restante da arquitetura?

Com o contexto completo do seu projeto, minha stack ideal seria:

Frontend

---------

Angular

Backend

---------

ASP.NET Core

Mensageria

---------

NATS

IoT

---------

MQTT

Banco

---------

PostgreSQL

Busca Vetorial

---------

pgvector

IA

---------

Semantic Kernel

Azure OpenAI

IAM

---------

Keycloak ou Zitadel

Orquestração

---------

Docker

Kubernetes

Se o objetivo é construir um produto de mercado e não apenas um sistema interno, eu investiria algumas semanas fazendo uma comparação prática **Keycloak vs Zitadel**, porque o requisito de **multi-tenant by design** é exatamente onde o Zitadel tende a se destacar mais em relação ao Keycloak. [[skycloak.io]](https://skycloak.io/blog/zitadel-alternatives-developers/), [[alternativeto.net]](https://alternativeto.net/software/zitadel/)

### Correção de português

Seu texto:

> On-Promisse first

O termo correto é:

> **On-Premises First** (mais comum em arquitetura)

ou

> **On-Premise First** (aceito informalmente no mercado)

Além disso:

> Multi-tenant by design

está correto e é amplamente utilizado em documentação técnica. ✅