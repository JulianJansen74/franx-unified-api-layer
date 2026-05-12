Interview 10 — Senior Operations Engineer (Session 2)
Topic: Architecture validation, domain-based routing, separation of stateful and stateless concerns.
Setting: Franx office


Architecture Validation

Q1: Looking at the proposed architecture, does the domain structure make sense to you from an operational perspective?


Yes. The separation into domains makes it clearer which part of the system is responsible for what. Each domain should have its own routing logic because the criteria for routing can differ between domains.


Thesis note: Confirms that routing is not centralised in a single routing table but is domain-specific. Each domain routes based on criteria relevant to its own operations.


Q2: You mentioned that the account routing logic sits in each domain rather than only in ABFR centrally. Can you explain that further?


The Account Routing Table can still be used as a reference, but other domains may route on different criteria. For example, payment initiation may route based on the corporate and the type of payment, not just the account number. The routing principle is the same but the implementation per domain can differ.

Thesis note: Account Routing Table is a shared reference but routing logic is domain-specific. This is an important architectural nuance — the unified layer standardises the interface but each domain decides how to route internally.


Q3: Get balance and get transactions go through ABFR to the ABN Gateway. But payment initiation is stateful and does not go through ABFR.Account. Is that the right separation?


Yes. Get balance and get transactions are simple read operations, stateless, no workflow, just route and return. Payment initiation is different because it has multiple steps: submit the payment, wait for the client to authorise in Access Online, then check the status. That cannot be handled by a stateless routing layer. It needs its own stateful component.

Thesis note: Confirms the separation between ABFR.Account (stateless, read operations) and ABFR.PaymentInitiation (stateful, multi-step workflow). This directly shapes the proposed architecture.



Q4: From an operations perspective, what is the most important thing the unified layer needs to get right?


Consistency. The frontoffice should not notice a difference between calling an internal backoffice and calling an external bank. The response format, the error handling, the latency, all of it should feel the same. If the external bank is slow or unavailable, ABFR should handle that gracefully and return a clear error rather than leaving the frontoffice waiting.

Thesis note: Confirms the consistent interface requirement. Error handling and response normalisation across backends are operationally critical.



Q5: Are there other scenarios you can think of where the stateful vs stateless separation would matter?


Forward contracts are a good example. The forward contract is agreed today but the payment happens later. That whole lifecycle, from agreement to execution, needs to be tracked somewhere. That is not something ABFR.Account can manage. It belongs in a separate domain that understands the payment lifecycle.

Thesis note: Forward contracts as a stateful use case are confirmed. This supports the separation of Payment Initiation as a distinct stateful domain and relates directly to SQ4.
