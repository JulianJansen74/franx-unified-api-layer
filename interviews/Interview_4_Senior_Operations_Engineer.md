Interview 4 — Senior Operations Engineer
Topic: Commercial value of external banking connectivity, operational impact, client segments, PSD2 strategy.
Setting: Franx office

Q1: Are there client requests or complaints that keep coming back that you think could be solved by connecting to their external bank directly?

Yes, the most common friction point is the funding step. Clients have to manually transfer money to their Franx account before they can trade or make a payment. 
That takes time, and sometimes the funds arrive too late for a trade the client wanted to execute. 
If we could read their balance at an external bank in real time and initiate a payment directly from that account, that whole step disappears.


Q2: How do you currently verify that an external bank account belongs to a specific Franx client?

That is a manual process right now. The client tells us their IBAN and we do a verification step. It is not automated. 
If we were to connect via an external API, that verification would ideally happen as part of the consent flow, the client authenticates at their own bank and gives permission, 
which confirms the account belongs to them.


Q3: If a client could connect their ABN AMRO or ING account directly to Franx and trade from that balance, how commercially significant would that be?

Very significant, especially for ABN AMRO clients. Franx is a subsidiary of ABN AMRO, so there is already a relationship there. 
If an ABN AMRO business client could walk into the Franx portal and immediately connect their existing account, without opening a new account or pre-funding, 
that removes the biggest barrier to getting started. It also means we can reach a much larger segment of clients who currently do not bother because of the onboarding friction.


Q4: Which client segment do you think would benefit most from external bank connectivity?

ABN AMRO clients first, because of the existing relationship. But medium-sized businesses with accounts at multiple banks would also benefit a lot, 
they currently have to manage funding across multiple accounts manually. If Franx could be the single interface for all of that, it becomes much more valuable.


Q5: Do you see external banking connectivity as a competitive advantage for Franx in the next few years?

Yes. Reducing the onboarding friction and broadening the addressable client base without requiring new account infrastructure is a clear competitive advantage. 
It also makes Franx more relevant for clients who want to trade internationally but do not want to maintain a separate Franx account just for that.


6: What would need to change operationally if Franx started initiating payments at external banks on behalf of clients?

The biggest operational change would be around consent management. Right now consent for payments is implicit, the client logs into Franx and approves. 
If we are initiating payments at an external bank, we need a formal consent mechanism and a way to track and validate that consent over time, 
especially for forward contracts where the payment happens much later. The team would also need to handle failure scenarios — what happens if the external bank rejects the payment, 
or if the client has revoked consent by then.
