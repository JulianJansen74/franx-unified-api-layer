# franx-unified-api-layer

Master's thesis research — University of Amsterdam 2026

**Title:** A Unified API Layer for B2B Fintech Platforms: Centralising Routing and Access Across Internal and External Banking Systems

**Author:** Julian Jansen (15998606)
**Programme:** Master Information Studies — Information Systems
**Supervisor:** Frank Nack (UvA) · Sander Oudejans (Franx)
**Submitted:** 26 June 2026

---

## Research Question

> How can a unified API layer be designed and evaluated to centralise and standardise routing and access across multiple internal backoffice systems and external banking APIs in B2B fintech?

---

## About This Research

This repository contains supporting materials for a master's thesis conducted as a case study at **Franx**, a Dutch B2B fintech company and subsidiary of ABN AMRO, active in international business finance.

The thesis designs and evaluates an extension of Franx's existing middleware layer — the Adaptive Banking Framework Router (ABFR), to support:

- Standardised routing across multiple internal backoffice systems
- Consent-aware access control for external banking API calls
- Integration of ABN AMRO's non-PSD2 APIs as an external backoffice
- Advance consent validation for forward contracts (up to 365 days)

The design draws on PSD2 architectural principles — structured consent objects, lifecycle management, and validation at request time — and applies them in a B2B fintech context using non-PSD2 APIs as a pragmatic alternative to the formal TPP licensing route.

---

## Repository Structure

```
franx-unified-api-layer/
├── README.md
├── interviews/
│   ├── Interview_1_IT_Architect_Session1.md
│   ├── Interview_2_IT_Architect_Session2.md
│   ├── Interview_3_QA_Engineer.md
│   ├── Interview_4_Senior_Operations_Engineer.md
│   ├── Interview_5_Payment_Specialist.md
│   └── Interview_6_Backend_Developer.md
└── src/
    └── (proof of concept implementation — C#, coming soon)
```

---

## Interviews

Six semi-structured interviews were conducted with Franx stakeholders across five roles. All participant names have been replaced by functional role titles to protect confidentiality. Interview records are available in the `interviews/` folder.

| File | Role | Topics |
|------|------|--------|
| Interview_1_IT_Architect_Session1 | IT Architect | Inbound PSD2 architecture, eIDAS, OAuth2, JWT, mTLS |
| Interview_2_IT_Architect_Session2 | IT Architect | Outbound connectivity, CQRS, API standardisation |
| Interview_3_QA_Engineer | QA Engineer | PSD2 flow testing, consent validation, edge cases |
| Interview_4_Senior_Operations_Engineer | Senior Operations Engineer | Commercial value, client segments, operational impact |
| Interview_5_Payment_Specialist | Payment Specialist | Payment flow, advance consent, non-PSD2 APIs |
| Interview_6_Backend_Developer | Backend Developer | API standardisation, read/write separation |

---

## Proof of Concept

The PoC is implemented in C# within the existing Franx environment. It demonstrates:

- ABFR routing across two internal backoffice systems and the ABN AMRO sandbox API
- Consent validation against a Frontend DB before each external call
- Advance consent storage and re-validation at execution time
- Consent revocation and cancellation API call

Source code will be added to the `src/` folder.

---

## Key Technologies

- **ABN AMRO Business Account Insight API** — account information retrieval (non-PSD2)
- **ABN AMRO Business Account Payment API** — payment initiation (non-PSD2)
- **OAuth2 client credentials flow** — authentication towards ABN AMRO APIs
- **C#** — proof of concept implementation
- **Frontend DB** — consent store simulation

---

## Related

- [ABN AMRO Developer Portal](https://developer.abnamro.com)
- [Berlin Group NextGenPSD2](https://www.berlin-group.org/nextgenpsd2)
