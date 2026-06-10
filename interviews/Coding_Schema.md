# Coding Schema — Thematic Analysis
## Thesis: A Unified API Layer for B2B Fintech Platforms
### Method: Thematic Analysis following Braun and Clarke (2006)

---

## How the Analysis Was Done

Interview records were read in full. Relevant fragments were labelled with an initial code. Related codes were grouped into themes. A theme was confirmed when multiple participants raised the same issue independently.

---

## Theme 1: Distributed Access Control as an Architectural Challenge

**Raised by:** IT Architect, QA Engineer, Senior Operations Engineer, Joint Session

| Code | Fragment | Source |
|------|----------|--------|
| Access control per backend | "Each system handles its own checks and we have not had situations where two systems gave different answers for the same request. But that is also because currently everything is internal." | QA Engineer, Q3 |
| No shared enforcement point | "If consent is checked at the frontend, there is a risk that a request slips through if the frontend logic is bypassed or misconfigured. ABFR is the last point before the call goes to the external bank, so it is the safest place to enforce the check." | Payment Specialist, Joint Session Q4 |
| Gateway as enforcement point | "ABFR is the gateway. It also keeps the frontend simple. The frontend does not need to know the difference between an internal call and an external call. ABFR makes that distinction and applies the consent check only when it is needed." | Senior Operations Engineer, Joint Session Q4 |
| Consent check before external call | "Whenever ABFR needs to call an external bank, it should first check consent validity in the Frontend DB. Only if the consent is valid should the call proceed." | Payment Specialist, Interview 4 Q7 |

---

## Theme 2: API Standardisation via a Unified Layer

**Raised by:** IT Architect, Senior Operations Engineer, Backend Developer, Joint Session

| Code | Fragment | Source |
|------|----------|--------|
| Frontend isolation from backend | "The frontend should just ask for a balance on an account number and get a balance back. It should not care whether that balance comes from Backoffice 1, Backoffice 2, or ABN AMRO." | Senior Operations Engineer, Joint Session Q1 |
| Single adapter per backend | "If the API surface is standardised to a small set of endpoints, adding a new backend means writing one adapter. The routing table tells ABFR which adapter to use for a given account." | Backend Developer, Interview 5 Q3 |
| CQRS read/write separation | "The accounting system should only provide those APIs. The backoffice system should only expose write APIs. Data should be accessed via a separate read API from another data storage. This is CQRS." | IT Architect, Interview 1 Q9 |
| Central logging via unified layer | "If we route calls through ABFR, we get a central place to log all external API calls. That is useful for debugging and for audit purposes." | Senior Operations Engineer, Joint Session Q7 |
| Extensibility | "If we want to connect ING as well, we just add another adapter to ABFR. The frontend does not change at all." | Payment Specialist, Joint Session Q7 |

---

## Theme 3: External Banking APIs as an Additional Backoffice

**Raised by:** IT Architect, Payment Specialist, Senior Operations Engineer, Business Stakeholder, Joint Session

| Code | Fragment | Source |
|------|----------|--------|
| PSD2 TPP route disproportionate | "For Franx as a licensed financial institution the regulatory and administrative overhead is disproportionate to what the TPP licence would actually enable." | IT Architect, Interview 1 Q8 |
| Non-PSD2 APIs as practical alternative | "Banks introduced non-PSD2 APIs that do the same thing, you can read account data and initiate payments, but without the requirement to be a licensed TPP. The functionality is equivalent, just without the regulatory overhead." | Payment Specialist, Interview 4 Q8 |
| External bank as third backoffice | "From a payment perspective, the same applies. If a payment needs to go through ABN AMRO, the frontend sends an initiate payment request to ABFR just like it would for any internal backoffice. ABFR figures out where to route it." | Payment Specialist, Joint Session Q1 |
| Commercial case for connectivity | "If an ABN AMRO business client could walk into the Franx portal and immediately connect their existing account, without opening a new account or pre-funding, that removes the biggest barrier to getting started." | Senior Operations Engineer, Interview 3 Q3 |
| FX use case enabled | "With PIS connectivity, the whole pre-funding step disappears. The client triggers the ING PIS flow, EUR arrives at Franx, Franx executes the FX trade." | Payment Specialist, Interview 4 Q9 |

---

## Theme 4: Consent Lifecycle and Advance Consent Validation

**Raised by:** Payment Specialist, IT Architect, QA Engineer, Joint Session

| Code | Fragment | Source |
|------|----------|--------|
| Consent store in Frontend DB | "We need to store consent in the Frontoffice, in the Frontend database. ABFR is a routing layer, it should not store state." | Payment Specialist, Interview 4 Q7 |
| Routing layer must stay stateless | Implied by: "ABFR is a routing layer, it should not store state." | Payment Specialist, Interview 4 Q7 |
| Consent status checked at request time | "We check the consent status in our system before processing the request. We test this by deliberately using expired or revoked consent objects and confirming that the system rejects them correctly." | QA Engineer, Interview 2 Q4 |
| Token caching to avoid latency | "Requesting a new token for every call would add unnecessary latency. The token is valid for about two hours, so it makes sense to cache it and only refresh it when it expires." | Senior Operations Engineer, Joint Session Q5 |
| Advance consent for future-dated payments | "A consent can be given for a forward contract as well. The maximum is 365 days in the future. The client gives consent today and the payment executes on the agreed execution date." | Payment Specialist, Interview 4 Q5 |
| Cancellation after authorisation | "ABFR polls the payment status periodically via the payment status endpoint using the payment ID received at submission." | Payment Specialist, Interview 4 Q6 |

---

## Theme 5: Commercial Value of External Banking Connectivity

**Raised by:** Payment Specialist, Senior Operations Engineer, Business Stakeholder

| Code | Fragment | Source |
|------|----------|--------|
| Funding friction as main barrier | "The most common friction point is the funding step. Clients have to manually transfer money to their Franx account before they can trade." | Senior Operations Engineer, Interview 3 Q1 |
| Removing pre-funding step | "The client does not need to pre-fund anything. They see a rate they like, they click trade, and we initiate the payment from their ABN AMRO account in the background." | Business Stakeholder, Interview 6 Q2 |
| FX and margin stay within Franx | "We are not bypassing Franx for the actual trade. The rate, the conversion, the settlement, all of that still happens at Franx. So we keep the margin and the relationship." | Business Stakeholder, Interview 6 Q3 |
| ABN AMRO clients as primary target | "ABN AMRO business clients are the obvious target. They already have a relationship with ABN AMRO and all of them have EUR accounts there." | Business Stakeholder, Interview 6 Q4 |
| Competitive advantage | "Reducing the onboarding friction and broadening the addressable client base without requiring new account infrastructure is a clear competitive advantage." | Senior Operations Engineer, Interview 3 Q5 |

---

## Validation of Themes

A theme was included only when raised by multiple participants independently. Where only one participant raised a point, this is noted in the thesis text. The table below summarises coverage per theme.

| Theme | Participants |
|-------|-------------|
| T1: Distributed Access Control | IT Architect, QA Engineer, Senior Ops Engineer, Joint Session |
| T2: API Standardisation | IT Architect, Senior Ops Engineer, Backend Developer, Joint Session |
| T3: External Banking as Backoffice | IT Architect, Payment Specialist, Senior Ops Engineer, Business Stakeholder, Joint Session |
| T4: Consent Lifecycle | Payment Specialist, IT Architect, QA Engineer, Joint Session |
| T5: Commercial Value | Payment Specialist, Senior Ops Engineer, Business Stakeholder |
