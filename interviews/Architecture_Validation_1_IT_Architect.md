Architecture Validation 1 — IT Architect 
Topic: Architecture validation, consent storage, table design, runtime behaviour.
Setting: Microsoft Teams

Architecture Validation

Q1: I have designed a unified API layer that routes all requests, including external ABN AMRO calls, through ABFR. Does this match how you would approach it, or do you see reasons to route external calls differently?


Looks nice. CQRS as well and the standardised APIs. The only thing that should be different is the calls to ABN to initiate a payment. The point when something reaches ABFR is stateless and should just do it. So payment initiation should happen outside ABFR.Account. It could be another part of ABFR, but it needs to be a stateful solution.

Thesis note: This is a key architectural decision. ABFR.Account remains stateless for get_balance and get_trx. Payment initiation must be a separate stateful component, outside the ABFR.Account layer.



Q2: The consent check happens inside ABFR before each external call. ABFR reads the consent status from the Frontend database and only proceeds if the status is valid. Does this design make sense to you, or would you place the consent check somewhere else?


Consent is good, indeed credentials stored in the Frontend database. How we could encrypt that is not for this stage. For now it is good to implement it this way.

Thesis note: Consent placement in the Frontend database is confirmed as correct. Encryption of credentials is deferred to a later stage.



Q3: For the CQRS separation, internal backoffices expose only write APIs and reads come from a readonly copy of Backoffice 2. Is this the right approach for the Franx context?


Yes indeed, just as I said last time.

Thesis note: CQRS confirmed. Readonly copy of Backoffice 2 for GET requests is the right approach.



Q4: ABFR remains stateless, no consent objects, tokens, or session data are stored in ABFR itself. Does this match your expectations for the routing layer?


Yes, for balances and transactions to ABN for GET calls it is good. For initiating a payment where a user needs to be redirected to Access Online, it should work differently.

Thesis note: Statelessness is confirmed for ABFR.Account. Payment initiation with Access Online redirect requires a stateful component outside ABFR.Account.



Q5: The OAuth2 access token for ABN AMRO is cached within ABFR and only refreshed when it expires. Is this the right place to cache it, or should this happen elsewhere?


No it is good the way you implemented it. 

Thesis note: Token caching in a single application is fine.



Q6: Looking at the proposed architecture as a whole, are there any components or decisions you would design differently?


Besides the things I mentioned, no. Looks good.



Consent Storage


Q7: I created a table called CorporateABNConsent in the Frontend database with the client-id and API key per corporate. Is this the right place to store credentials, or should we keep them somewhere else?


Yes good place, looks good.

Thesis note: Client-id and API key can stay in the Frontend database.



Q8: For the TLS certificate, how do we obtain it for production and where should we store it?


It is not ABFR who needs to load it. It will be the extra Outbound API application in your diagram. Regarding issuance and storage: we as Franx get a certificate, the DevOps team will handle that. They store it in the Key Vault. Then we load it in the App Service and the application can load it from there.

Thesis note: TLS certificate is stored in Azure Key Vault and loaded by the Outbound API application via the App Service. ABFR itself does not handle certificate loading.



Q9: Should the client-id and API key be encrypted in the database, or is the current database security sufficient?


We will discuss this later.

Thesis note: Encryption of credentials is deferred. Noted as an open point for the production implementation.



Table Design



Q10: If we add a second external bank later, should we extend this table with a bank identifier, or create a separate table?


Maybe a separate table, or one generic table with a bank identifier. It is not important right now. We can change the logic later on as well.

Thesis note: Table design for multi-bank extensibility is deferred. Both options are valid and can be decided when a second bank is added.



Q11: How should records be inserted, from a workflow in the frontend when a client signs the offline contract?


Offline contract indeed. After that we can create a screen for services to insert consent, or an automated workflow.

Thesis note: Record insertion is triggered by the offline bank connectivity contract. A manual screen for operations staff or an automated workflow are both valid approaches.
