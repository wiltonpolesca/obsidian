# Licence System Requirements

## Goal and Success Outcome

Provide each client with independently managed licences for products and their modules or features. Cloud and on-premises clients must receive equivalent access decisions for the same licences, including term, grace-period, and global account-limit rules. Cloud clients use a configured licence server; on-premises clients use an encrypted licence file.

Success means both deployment modes grant access only to licensed capabilities while licences are valid or within the 15-day renewal grace period, and product-usage reports show which clients and active user accounts use which products. No numeric success target was provided.

## Users and Problem

- **Client**: needs access to the products and modules or features it has licensed, with a short renewal window when a licence term ends.
- **Partner company**: represents the provider to its clients and may receive selected licences at no charge.
- **On-premises system**: needs to read the client's licence file and determine which product capabilities are available.
- **Cloud-connected client environment**: needs to connect to the licence server API to have its licences recognized automatically without uploading a licence file.

Assumption: the client and its on-premises system are the primary users/consumers; the person or process that issues licences is not yet specified.

## Scope

### In Scope

- Support multiple products and a hierarchy of product modules or features up to three levels deep.
- Assign an independent licence to each module or feature.
- Specify one global maximum number of active user accounts for each client's licence set, across all licensed products and features.
- Enforce the global account limit when a licence is renewed.
- Classify licences by the contract with the client or partner using `Partner`, `Test`, `Temporary`, or `Ordinary` categories.
- Produce reports that show how products are used and by which client and active user accounts, with licence category available for reporting.
- Apply a renewal only after negotiation is complete, a new contract is signed, and payment is received.
- Register partner companies and record their relationship as representatives to their clients.
- Allow selected licences to be provided to partner companies at no charge.
- Enforce a maximum licence term of 365 days and a 15-day renewal grace period.
- Generate one encrypted licence file per client for on-premises use only.
- Provide a licence server API and configure the cloud deployment to use it for automatic recognition without file uploads; on-premises clients use the encrypted licence file instead.

### Out of Scope

- Negotiation, contract-signing, and payment-processing workflows; these are prerequisites to applying a renewal but are performed outside this licensing feature.
- Defining encryption, file-format, transport, or on-premises deployment technology.
- Billing, audit, and reporting beyond product-usage reports by client, user account, and licence category.

## Prioritized Requirements

- **REQ-01 (Must)**: The system must support more than one product.
- **REQ-02 (Must)**: Each product must support a hierarchy of modules or features up to three levels deep.
- **REQ-03 (Must)**: Each module or feature must have its own distinguishable licence; a licence for one module or feature must not implicitly grant access to another.
- **REQ-04 (Must)**: Each licence must be classified according to the contract with the client or partner as `Partner`, `Test`, `Temporary`, or `Ordinary`; this category must be available for usage reporting.
- **REQ-05 (Must)**: Each licence must have an end date, and its validity term must not exceed 365 days.
- **REQ-06 (Must)**: When a licence reaches its end date, the client must retain access for a 15-day renewal grace period. After the grace period, the licence must be fully expired and must no longer grant access.
- **REQ-07 (Must)**: The system must generate an encrypted file containing all licences for one client for use by on-premises clients only.
- **REQ-08 (Must)**: The on-premises client's system must be able to read its licence file and grant access to licensed modules or features according to their licence status.
- **REQ-09 (Must)**: The system must allow partner companies to be registered and identified as representing the provider to their clients.
- **REQ-10 (Must)**: The system must allow selected licences to be provided to partner companies at no charge.
- **REQ-11 (Must)**: The system must provide a licence server API and configure the cloud deployment to use it for automatic licence recognition without uploading a licence file; on-premises clients use the encrypted licence file.
- **REQ-12 (Must)**: Cloud and on-premises deployments must apply the same licence validity, 15-day grace-period, and global account-limit rules.
- **REQ-13 (Must)**: Each client's licence set must specify one maximum number of active user accounts across all licensed products and features.
- **REQ-14 (Must)**: When a renewed licence set allows fewer active user accounts than are currently active for the client, normal system use must remain unavailable until an Admin signs in and manually deactivates enough accounts to meet the new global limit.
- **REQ-15 (Must)**: A licence renewal may be applied only after negotiation, signing of a new contract, and receipt of payment.
- **REQ-16 (Must)**: The system must support product-usage reports that identify the client, product or feature used, and active user account, and allow reporting by licence category.

## Acceptance Criteria

- A product can be represented with module or feature paths at each supported level, up to three levels deep.
- Licences can be associated with individual modules or features and distinguished from licences for other modules or features.
- Each client's licence set specifies one active-account limit across all products and features, and the on-premises file or configured cloud licence server makes that limit available to the client environment.
- A licence records its type and end date. The system rejects a term longer than 365 days, measured from the agreed term start point.
- Partner companies can be registered and identified by their representative relationship.
- A selected licence can be issued to a partner company at no charge without changing its module assignment or validity rules.
- A partner company's clients do not receive no-charge licences solely through the partner relationship.
- The on-premises system continues to grant access for a licence during the defined 15-day grace period and denies access after that period. The precise end-date and grace-period boundary follows the agreed calendar rule.
- A generated encrypted file contains the licences associated with one client and is intended only for that client's on-premises installation.
- The on-premises system can read a valid file and grant access only to the modules or features whose licences are active or within the grace period.
- The cloud deployment is configured to connect to the provided licence server API and recognizes licences automatically without a file upload; on-premises clients use the encrypted licence file.
- Both deployment modes grant equivalent access for the same licence status, including expiration, the 15-day renewal grace period, and the global account limit.
- If a renewed licence set has a lower global account limit than the number of active accounts for the client, normal system use remains unavailable.
- During that over-limit state, an Admin can sign in and manually deactivate accounts until the global active-account count is at or below the renewed limit; normal system use becomes available after compliance is restored.
- A renewal is not applied until negotiation is complete, a new contract is signed, and payment is received.
- Product-usage reports identify the client, product or feature used, active user account, and licence category.
- A licence that has fully expired does not grant access, even if another module or feature for the same client remains licensed.

## Business Rules and Constraints

- A licence applies to an individual module or feature.
- Each client's licence set has one global maximum number of active user accounts across all licensed products and features; the limit is based on accounts, not concurrent sessions.
- After renewal lowers the global account limit below the client's active-account count, normal system use remains blocked until an Admin manually deactivates enough accounts to meet the new limit.
- Licence categories reflect the contract with the client or partner and are available for product-usage reporting.
- Selected licences may be provided to partner companies at no charge; not all partner licences are assumed to be free. This no-charge arrangement applies only to the partner company, not its clients.
- A licence has a required end date and a maximum term of 365 days.
- Access remains available for 15 days after the licence end date to allow renewal; access ends after the grace period.
- Renewal follows negotiation, signing a new contract, and payment; the licensing feature does not perform those commercial steps.
- The 15-day grace period is a renewal buffer, not an outage-support or availability guarantee. The client is responsible for managing outages in its environment.
- The licence file is per client, encrypted, and consumed only by on-premises installations.
- Cloud-connected client environments use a licence server API for automatic licence recognition and do not upload licence files.
- The exact start point for calculating the 365-day term and the exact grace-period boundary have not been defined.

## Assumptions, Dependencies, Risks, and Open Questions

- **Assumption**: each module or feature licence is evaluated independently; parent-module licences do not automatically grant access to descendants.
- **Assumption**: the system permits Admin sign-in during the over-limit state solely to deactivate users; other system use remains unavailable.
- **Open question**: what date starts the 365-day maximum-term calculation: issue date, effective date, or another event?
- **Open question**: is access allowed through the 15th calendar day after the end date, and what time zone or day-boundary rule applies?
- **Open question**: what should the on-premises system do when the file is missing, invalid, outdated, or cannot be read?
- **Open question**: how does the licence server identify and respond to an unknown or unregistered client?
- **Open question**: how does a client receive and apply an updated file after renewal, particularly if the on-premises system is disconnected?
- **Open question**: how is on-premises product-usage data made available for reporting when the installation does not connect to the cloud licence server?
- **Open question**: who can view product-usage reports, and what user-level data and retention rules apply?
- **Open question**: who confirms that contract negotiation, signature, and payment are complete before the renewed licence is applied?
- **Open question**: do contract categories affect access behavior, or are they used only to classify and report usage?
- **Dependency**: the on-premises system must have a defined way to identify the client and associate file contents with product/module access.
- **Dependency**: cloud-connected client environments must be identifiable to the licence server API so it can recognize their licences.
- **Risk**: unclear date boundaries, client identity, or usage-data availability could lead to incorrect access decisions or incomplete reports.

## Technical-Lead Handoff

- Define the product, module, and feature identity model while preserving independent licensing and the three-level hierarchy.
- Propose a licence-file contract and secure encryption approach compatible with the on-premises reader.
- Define cloud licence-server configuration and client identification; the client is responsible for managing outages in its environment.
- Define on-premises file validation and renewal updates, including how refreshed files are provided to disconnected installations.
- Define how partner relationships, partner licence types, and no-charge licences are represented and associated with partner companies and their clients.
- Confirm how licence status is evaluated, including term start, end-date inclusivity, the 15-day grace boundary, and clock/time-zone expectations.
- Define how the global active-account limit is applied and how Admin remediation access works while normal use is blocked after renewal.
- Define the usage data needed for reports across both deployment modes, report access controls, and retention/privacy requirements.
- Define the process or actor that confirms signed-contract and payment completion so a renewal can be applied.
- Confirm whether licences inherit through the hierarchy or remain strictly assigned to individual modules or features.
