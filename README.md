# franx-unified-api-layer

Master's thesis research — University of Amsterdam 2026

**Title:** A Unified API Layer for B2B Fintech Platforms: Centralising Routing and Access Across Internal and External Banking Systems

**Author:** Julian Jansen (15998606)
**Programme:** Master Information Studies — Information Systems
**Supervisor:** Frank Nack (UvA) · Sander Oudejans (Franx)
**Examiner:** Giovanni Sileno (UvA)
**Submitted:** 26 June 2026

---

## Research Question

> How can a unified API layer be designed and evaluated to centralise and standardise routing and access across multiple internal backoffice systems and external banking APIs in B2B fintech?

---

## About This Research

This repository contains supporting materials for a master's thesis conducted as a case study at **Franx**, a Dutch B2B fintech company and subsidiary of ABN AMRO, active in international business finance.

The thesis designs and evaluates an extension of Franx's existing middleware layer — the Adaptive Banking Framework Router (ABFR) — to support:

- Standardised routing across multiple internal backoffice systems via a data-driven Account Routing Table
- Consent-aware access control for external banking API calls via a four-state consent model (Valid, Invalid, Expired, Revoked)
- Integration of ABN AMRO's non-PSD2 APIs as an external backoffice alongside internal systems
- Future-dated payment initiation with periodic status polling via the payment status endpoint

The design draws on PSD2 architectural principles and applies them in a B2B fintech context using non-PSD2 APIs as a practical alternative to the formal TPP licensing route.

---

## Repository Structure

```
franx-unified-api-layer/
├── README.md
├── interviews/
│   ├── Interview_1_IT_Architect_Session1.md
│   ├── Interview_2_QA_Engineer.md
│   ├── Interview_3_Senior_Operations_Engineer.md
│   ├── Interview_4_Payment_Specialist.md
│   ├── Interview_5_Backend_Developer.md
│   ├── Interview_6_Business_Stakeholder.md
│   ├── Interview_7_Senior_Operations_Engineer_Payment_Specialist.md
│   ├── Architecture_Validation_1_IT_Architect.md
│   ├── Architecture_Validation_2_Senior_Operations_Engineer.md
│   ├── Architecture_Validation_3_Payment_Specialist.md
│   └── Architecture_Validation_4_Backend_Developer.md
├── database_inserts/
│   ├── Account.sql
│   ├── AccountRouting.sql
│   ├── Backoffice.sql
│   ├── Corporate.sql
│   ├── CorporateABNConsent.sql
│   └── Portfolio.sql
└── src/
    ├── Abf.Account.Api.zip
    ├── Abf.Account.Router.zip
    ├── Abf.Account.zip
    ├── Abfr.Abn.Gateway.zip
    └── franx-frontend-client-consent.zip
```

---

## Interviews

Eleven semi-structured interviews and validation sessions were conducted with Franx stakeholders. All participant names have been replaced by functional role titles to protect confidentiality.

### Requirements Elicitation (Interviews 1–7)

| File | Role | Topics |
|------|------|--------|
| Interview_1_IT_Architect_Session1 | IT Architect | Inbound PSD2 architecture, eIDAS, OAuth2, JWT, mTLS |
| Interview_2_QA_Engineer | QA Engineer | PSD2 flow testing, consent validation, edge cases |
| Interview_3_Senior_Operations_Engineer | Senior Operations Engineer | Commercial value, routing design, operational impact |
| Interview_4_Payment_Specialist | Payment Specialist | Payment flow, forward contracts, non-PSD2 APIs |
| Interview_5_Backend_Developer | Backend Developer | API standardisation, read/write separation |
| Interview_6_Business_Stakeholder | Business Stakeholder | Commercial value, client segments, pre-funding barrier |
| Interview_7_Senior_Operations_Engineer_Payment_Specialist | Joint session | Routing external calls, consent placement, token caching |

### Architecture Validation Sessions (Validation 1–4)

| File | Role | Topics |
|------|------|--------|
| Architecture_Validation_1_IT_Architect | IT Architect | Routing design, CQRS, TLS certificate, token caching |
| Architecture_Validation_2_Senior_Operations_Engineer | Senior Operations Engineer | Domain separation, routing consistency |
| Architecture_Validation_3_Payment_Specialist | Payment Specialist | Payment initiation, future-dated payments, Access Online redirect |
| Architecture_Validation_4_Backend_Developer | Backend Developer | Adapter pattern, CQRS, gateway separation |

---

## Proof of Concept

The proof of concept is implemented in C# within the Franx environment and tested against the ABN AMRO sandbox. It demonstrates:

- ABFR routing across two internal backoffice systems and the ABN AMRO sandbox API via the Account Routing Table
- Consent lifecycle enforcement using a four-state model (Valid, Invalid, Expired, Revoked) in the Frontend database
- Balance retrieval via the ABN AMRO Business Account Insight API with OAuth2 and TLS authentication
- Status-specific error responses when consent is absent or invalid

Payment initiation and future-dated payment scenarios were validated through API documentation analysis and stakeholder input, not direct implementation.

### Source Components

| File | Description |
|------|-------------|
| Abf.Account.Api.zip | API layer — exposes the unified endpoints to the frontoffice |
| Abf.Account.Router.zip | Routing layer — looks up the Account Routing Table and forwards requests |
| Abf.Account.zip | Account domain — core account operations |
| Abfr.Abn.Gateway.zip | ABN Business Account Gateway — handles OAuth2, TLS, and consent check |
| franx-frontend-client-consent.zip | Frontend consent interface — consent record management |

---

## Database

The `database_inserts/` folder contains SQL scripts to set up the test data used in the proof of concept. The `CorporateABNConsent` table stores consent records per corporate with the following schema:

```sql
CREATE TABLE [dbo].[CorporateABNConsent](
    [Id]          INT IDENTITY(1,1) NOT NULL,
    [CorporateId] INT NOT NULL,
    [Client-Id]   NVARCHAR(200) NOT NULL,
    [API-Key]     NVARCHAR(200) NOT NULL,
    [Status]      NVARCHAR(200) NOT NULL,  -- Valid | Invalid | Expired | Revoked
    [Created]     DATETIME2(7) NOT NULL,
    [CreatedBy]   NVARCHAR(50) NOT NULL,
    [Modified]    DATETIME2(7) NOT NULL,
    [ModifiedBy]  NVARCHAR(50) NOT NULL
)
```

The `AccountRouting` insert shows BackofficeId 3 mapped to an ABN AMRO IBAN, demonstrating how the routing table directs external calls to the ABN Business Account Gateway.

---

## Key Technologies

- **ABN AMRO Business Account Insight API** — account balance and transaction retrieval (non-PSD2)
- **ABN AMRO Business Account Payment API** — payment initiation (non-PSD2)
- **OAuth2 client credentials flow** — authentication towards ABN AMRO APIs
- **Azure Key Vault** — TLS certificate storage
- **C# / .NET** — proof of concept implementation
- **SQL Server** — consent store and routing table

---

## Related

- [ABN AMRO Developer Portal](https://developer.abnamro.com)
- [Berlin Group NextGenPSD2](https://www.berlin-group.org/nextgenpsd2)
