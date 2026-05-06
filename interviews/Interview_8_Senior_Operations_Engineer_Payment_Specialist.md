Interview 8 — Senior Operations Engineer and Payment Specialist (Joint Session)
Topic: Architecture discussion on routing external ABN AMRO calls through ABFR, frontend impact, translation layer design.
Setting: Franx office
 
Q1: Why should the ABN AMRO API call go through ABFR rather than being called directly from the frontend?
 
Senior Operations Engineer: The whole point of ABFR is that the frontend does not need to know what is behind it. 
If we call ABN AMRO directly from the frontend, then the frontend suddenly needs to know about OAuth2 tokens, TLS certificates, and the specific API format of ABN AMRO. 
That is a completely different kind of complexity. The frontend should just ask for a balance on an account number and get a balance back. 
It should not care whether that balance comes from Backoffice 1, Backoffice 2, or ABN AMRO.
 
Payment Specialist: And from a payment perspective, the same applies. If a payment needs to go through ABN AMRO, 
the frontend sends an initiate payment request to ABFR just like it would for any internal backoffice. ABFR figures out where to route it. 
The frontend is completely isolated from that decision.

 
Q2: So the translation between the Franx internal format and the ABN AMRO API format happens inside ABFR?

Senior Operations Engineer: Yes. That is what the adapter does. ABFR receives a standardised request in our internal format and translates it to whatever ABN AMRO expects. 
For the balance call that is a GET request with an IBAN. For a payment that is an ISO20022 XML file. The frontend never sees that complexity.
 
Payment Specialist: And if ABN AMRO changes their API format next year, we only need to update the adapter. The frontend stays the same. That is the whole value of having a unified layer.


Q3: Is the translation complex? What does the ABN AMRO adapter actually need to do?
 
Payment Specialist: For AIS it is minimal. We send an IBAN and we get back a balance. The translation is basically just mapping our internal field names to the ABN AMRO field names and formatting the response.
 
Senior Operations Engineer: For PIS it is more involved. We need to build an ISO20022 PAIN.001 XML file, GZIP it, encode it in BASE64, and send it with the right headers. 
That is a bit more work but it is still contained within the adapter. ABFR handles the OAuth2 token, the TLS certificate, and the API call. The frontend just sends an amount and an IBAN.


Q4: Should be validated inside ABFR or somewhere else?
 
Payment Specialist: ABFR is the right place because ABFR is the gateway. If consent is checked at the frontend, 
there is a risk that a request slips through if the frontend logic is bypassed or misconfigured.
ABFR is the last point before the call goes to the external bank, so it is the safest place to enforce the check.
 
Senior Operations Engineer: It also keeps the frontend simple. The frontend does not need to know the difference between an internal call and an external call. 
ABFR makes that distinction and applies the consent check only when it is needed.

 
Q5: Where should we store the OAuth2 access token? Should ABFR cache it or request a new one every time?
 
Senior Operations Engineer: We talked about this. Requesting a new token for every call would add unnecessary latency. 
The token is valid for about two hours, so it makes sense to cache it and only refresh it when it expires. 
ABFR should handle this internally, the frontend should not be involved in token management at all.
 
Payment Specialist: From a security perspective, caching is fine as long as the token is stored securely within ABFR and not exposed to the frontend or logged anywhere. 

 
Q6: What happens if the ABN AMRO API is unavailable?
 
Senior Operations Engineer: If the ABN AMRO API is down, ABFR should return a clear error to the frontend rather than timing out silently.
The frontend can then show the client a message that the external balance is temporarily unavailable. We should not block the rest of the Franx platform because one external API is down.
 
Payment Specialist: For payments it is more serious. If ABN AMRO is unavailable after the client has initiated a payment, we need to be clear about the status. 
Was the payment submitted or not? ABFR should not confirm a payment to the frontend unless it has received a successful response from ABN AMRO. If the call fails, 
the payment stays in a pending state and the client is notified.

 
Q7: Any other points that came up in the discussion?
 
Senior Operations Engineer: If we route calls through ABFR, we get a central place to log all external API calls. 
That is useful for debugging and for audit purposes. If we called ABN AMRO directly from the frontend, that visibility would be lost.
 
Payment Specialist: And it makes it easier to add a second external bank later. If we want to connect ING as well, we just add another adapter to ABFR. 
The frontend does not change at all. That extensibility was one of the main reasons we decided to route everything through ABFR.
