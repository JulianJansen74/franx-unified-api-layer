Architecture Validation 3 — Payment Specialist
Setting: Franx office
 
Architecture Validation

 
Q1: The proposed architecture separates payment initiation into a stateful domain outside ABFR.Account. Does this match how you would expect payment initiation to work in practice?

Yes, that makes sense. A payment is not a single action. You submit it, the client needs to sign it in Access Online, and then you need to confirm the result. 
That is a multi-step process that needs to track state. You cannot do that in a stateless routing layer. It needs its own component that knows where it is in the workflow.


Q2: The consent check happens at the ABN Business Account Gateway before any payment is submitted. Does this placement make sense from a payment operations perspective?

Yes. You want to know before you submit anything that the client has the right to use that account. If there is no consent record, the call should never leave Franx. 
It would be worse to submit a payment to ABN AMRO and then have it rejected because the consent is missing. Better to catch it early.
 

Q3: For future-dated payments, the payment is submitted and authorised today but executed up to 365 days in the future. Franx will pull in the meanwhile the payment status of the PaymentId, do you think that as well?
 
Yes indeed, it gives the client overview of their pending payments, whether managed internally at Franx or at ABN AMRO. In a next phase, the payments approval screen at Franx should
include external bank payments, with the payment status polled periodically so operations can monitor which payments are pending and flag any that have not arrived on time.

 
Q4: The payment initiation flow requires the client to be redirected to Access Online to authorise the payment. Franx cannot automate this step. Does this affect the commercial value of the feature?
 
It adds a step for the client, which is not ideal. But it is a one-time action per payment and the client is already used to signing payments in their banking portal. 
As long as the redirect is seamless and the client is brought back to Franx immediately after signing, it is acceptable. It is a different experience from a fully automated payment but still 
much better than the current pre-funding flow.

 
Q5: Looking at the overall payment initiation design, are there any components or decisions you would design differently?
 
The main thing I would add is a clearer status tracking on the Franx side. Once a payment is submitted and the client has signed, Franx should store the payment ID and the expected execution date. 
That way operations can monitor which payments are pending and flag any that have not arrived on time. That is not in scope for the proof of concept but it is important for production.
