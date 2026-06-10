Interview 4 — Payment Specialist
Topic: Payment flow, PSD2 PIS/AIS use cases, advance consent, consent storage, non-PSD2 APIs.
Setting: Franx office

Q1: How does a payment move through the Franx system today, from the moment a client initiates it to settlement?

Franx is a subsidiary of ABN AMRO and has an independent BIC. Everything goes via ABN AMRO, Franx cannot reach the outside world directly. 
When a client makes a payment, Franx does a FIAT check first. If the balance is sufficient, Franx debits the client and credits a suspense account. 
Then Franx sends a PACS message to ABN AMRO. ABN AMRO receives that PACS and knows it needs to send to the target bank. 
ABN AMRO debits from the Franx nostro account and forwards the payment. At the end of the day there is an EOD statement and a reconciliation step to make sure everything matches.


Q2: When a client wants to pay from an account at an external bank, what does that look like today?

They need to fund their Franx account first. There is no direct connection to external bank accounts. 
The client has to move money manually to Franx before they can trade or make a payment through us.


Q3: If Franx were to use PSD2 or similar APIs to initiate payments directly from a client's external account, what would change?

For AIS, not much changes in the flow, it is just adding screens for the balance view. 
For PIS, we need to build a flow where the client sees their external balance, clicks to initiate, we call PIS, 
and then the client sees the external bank login and gives consent there. At that point there is no booking within Franx yet, 
only when we connect the PIS principles to trade and payment execution.


Q4: For payments, how should consent work, per payment or as a standing authorisation?

Per payment. Each payment should have its own consent.


Q5: Are there payment types at Franx where the client approves today but the actual payment happens much later?

Yes we have that. A consent can be given for a forward contract as well. The maximum is 365 days in the future.
The client gives consent today and the payment executes on the agreed execution date.


Q6: If a client revokes consent after a payment is approved but before the execution date, what should happen?

If you have PIS, there is a cancellation API which Franx can call to cancel that payment at the external bank. 
So if the client revokes consent, Franx calls the cancellation endpoint and the pending payment is cancelled. 
However, this applies to the formal PSD2 route. In the non-PSD2 route via ABN AMRO Access Online, the client cancels the payment directly in the Access Online portal. 
Franx detects this via periodic status polling using the payment ID.

Q7: Where should consent objects be stored, and how should ABFR use them?

We need to store consent in the Frontoffice, in the Frontend database. ABFR is a routing layer, it should not store state. 
The Frontend is the right place because that is where client data already lives. Whenever ABFR needs to call an external bank, it should first check consent validity in the Frontend DB. 
Only if the consent is valid should the call proceed.


Q8: Why do banks like ABN AMRO offer non-PSD2 APIs in addition to the formal PSD2 route?

When PSD2 was introduced, all the banks needed to set up the infrastructure for it. But for anyone who wants to connect, every caller needs to be a TPP, 
and getting a TPP licence means going through a process at the DNB. That is complicated and takes time. 
So banks introduced non-PSD2 APIs that do the same thing, you can read account data and initiate payments, but without the requirement to be a licensed TPP. 
The functionality is equivalent, just without the regulatory overhead.


Q9: Can you describe the concrete FX use case that external banking connectivity would enable?

A Franx client wants to make a payment in USD but his EUR balance at Franx is zero. Today he has to fund first. With PIS connectivity, 
he can trigger the ING PIS flow and ask ING to debit his ING EUR account and send money to Franx in EUR. As soon as that EUR arrives at Franx, 
Franx executes the FX trade and sends the payment in USD. The whole pre-funding step disappears.
