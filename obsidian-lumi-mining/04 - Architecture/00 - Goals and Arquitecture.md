# Goals and Architecture

## 1 - Purpose

Lumi is a multi-tenant knowledge platform with an integrated AI chat experience. It is designed for on-premises deployment first, with a portable architecture that can also run in cloud environments. Lumi connects tenant-authorized historical data to retrieval-augmented generation (RAG) so users can ask questions and receive grounded answers with traceable sources.

---

## 2 - Goals and Scope

### 2.1 Goals

- Support isolated organizations (tenants) with tenant-scoped users, data, configuration, and AI conversations.
- Provide interactive AI chat grounded in authorized historical tenant data.
- Deploy and operate in customer-controlled on-premises environments first, without preventing later cloud deployment.
- Support independent licensing limits for user seats and enabled features.
- Use centralized SSO.

### 2.2 In Scope

- Tenant lifecycle, users, memberships, roles, and tenant isolation.
- Keycloak-managed SSO with optional federation of external identity providers (e.g. Microsoft, Active Directory); customers are not required to use them.
- User-count and feature-based licensing.
- C#/.NET APIs and workers, an Angular user interface, PostgreSQL, and NATS.
- Production PostgreSQL and a distinct read-only visualization clone sourced from production.
- Historical data ingestion, indexing, tenant-scoped retrieval, and RAG chat.
- On-premises packaging, upgrades, backup/restore, observability, and cloud-compatible deployment profiles.

### 2.3 Out of Scope

- Product capabilities outside the Lumi knowledge-platform scope defined here.
- Direct identity-provider integrations other than Keycloak.
- Identity flows that have not been approved for the Keycloak SSO and identity federation design.
- Unrestricted natural-language SQL execution against production or visualization databases.
- Training or fine-tuning an LLM on tenant data by default.

---

## 3. Terms

- **Tenant:** The organization or customer boundary that owns configuration, users, licenses, source data, and conversations.
- **Tenant member:** A user associated with a tenant and granted a role or explicit permissions.
- **Seat:** One active user counted against a tenant's user limit. The exact treatment of pending invitations and service identities is a product decision.
- **Feature entitlement:** A named capability enabled for a tenant by its license.
- **Production database:** The writable PostgreSQL system of record.
- **Visualization database:** A distinct read-only clone/replica of production used for reporting and historical retrieval. It must not accept application writes.
- **RAG:** Retrieval-augmented generation; the system retrieves authorized source context and supplies it to an LLM to ground a response.
- **On-premises:** Customer-operated infrastructure, including customer-controlled networks, storage, secrets, and model endpoints.

---

## 4. Tenancy, Identity, and Access

The system shall:

- Require an explicit tenant context for every tenant-owned API operation, background job, database query, cache key, event, index record, and chat conversation.
- Prevent cross-tenant data access by default and verify tenant boundaries in automated tests.
- Enforce authorization in the API/application layer and again in data-access or database policies where practical.
- Support tenant membership roles and least-privilege permissions.
- Delegate SSO to Keycloak and allow optional federation of external providers (e.g. Microsoft, Active Directory) through Keycloak.
- Map the stable identity-provider subject to a Lumi user and tenant memberships; identity claims alone do not grant tenant access.
- Audit authentication, membership, license, administrative, data-ingestion, and AI access events without logging secrets or unnecessary prompt contents.
- Use the approved client-to-Keycloak OIDC Authorization Code with PKCE protocol. Optional Keycloak-to-identity-provider federation must not be enabled until its protocol is documented and tested. Production sign-in release remains blocked until the production session strategy is approved and tested.

---

## 5. Architecture diagram

### 5.1 High level architecture

![[clean-architecture.drawio.png]]

### 5.2 High level architecture services

![[architecture-services-v2.drawio.png]]

---

## 6. Architecture Services

### 6.1 Third parties

| Service                         | Description                                                                                                                                                                    | Others                                                                                                                                                   |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Keycloak                        | Keycloak is an open-source identity and access management (IAM) platform that provides user authentication, authorization, and Single Sign-On (SSO) for applications and APIs. | [Documentation](https://www.keycloak.org/documentation)                                                                                                  |
| Traefik                         | Traefik is an API gateway and reverse proxy that provides routing, load balancing, and TLS management for Docker services.                                                     | [Official site](https://traefik.io/traefik)                                                                                                              |
| PostgreSQL                      | Primary relational database responsible for persisting application data, supporting transactional workloads, and ensuring data integrity.                                      | [Documentation](https://www.postgresql.org/docs/)                                                                                                        |
| NATS                            | Lightweight messaging platform that enables asynchronous communication, event streaming, and decoupled interaction between services.                                           | [Documentation](https://docs.nats.io/?_gl=1*lwo6si*_ga*MTc5MzA4NTI4MC4xNzkyNjA2ODky*_ga_6242VH03CH*czE3OTI2MDY4OTEkbzEkZzAkdDE3OTI2MDY4OTEkajYwJGwwJGgw) |
| OpenObserve                     | Centralized observability platform for collecting, storing, and analyzing logs, metrics, and traces.                                                                           | [Documentation](https://openobserve.ai/docs/)                                                                                                            |
| OpenTelemetry-Collector-contrib | Telemetry collection and processing service that receives, transforms, and exports logs, metrics, and traces to observability backends.                                        | [Documentation](https://github.com/open-telemetry/opentelemetry-collector-contrib)                                                                       |
| Portainer                       | Container management platform that provides a web-based interface for managing Docker environments, stacks, containers, and infrastructure resources.                          | [Documentation](https://www.portainer.io)                                                                                                                |

### 6.2 Lumi Services

#### 6.2.1 For general use

ON-GOING ...

| Service                 | Description                                                                                                                                                                          |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| User and Licenses       | Service responsible for managing user permissions and license (how many users have have been contracted, which feature the client is authorized to use, etc.)                        |
| Alarm and Notifications | Service responsible for centralizing all alarms, forwarding them to broker/frontend and managing their acknowledgement (confirmation). (Does not apply to machine telemetry alarms.) |
| Blob Storage            | Centralized service responsible for storing and providing access to documents and images                                                                                             |
| NTP Sync                | Service responsible for connecting to an NTP server and synchronizing the date and time with it.                                                                                     |

---

#### 6.2.2 Internal Lumi Service

ON-GOING ...

| Service                | Description                                                                                                                            | Documentation               |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- |
| Global License manager | Responsible for controling the products, modules, and features available to each customer, including license validity and user limits. | [[Global Licensing System]] |

---

#### 6.2.3 Lumi backend services

ON-GOING ....

| Service       | Description                                                                                                     |
| ------------- | --------------------------------------------------------------------------------------------------------------- |
|               |                                                                                                                 |
|               |                                                                                                                 |
|               |                                                                                                                 |
| Temporal Data | Service responsible to handle temporal data from different types of owners (machine, location, devices, others) |

---