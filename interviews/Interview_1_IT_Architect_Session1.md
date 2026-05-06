Interview 1 - IT Architect (Session 1)
Topic: Inbound PSD2 architecture, eIDAS certificate validation, OAuth2, JWT, Proof of Possession, mTLS, Outbound PSD2 connectivity, CQRS principle, core API standardisation, sandbox recommendation.
Setting: Microsoft Teams

Q1: What is PSD2 and how does Franx use it?

PSD2 is a European regulation, abstract on its own. Franx uses the Berlin Group NextGenPSD2 standard to make it technically workable. Key roles: PSU is the end user, AISP is the party reading account info, ASPSP is Franx as the bank-like provider, TPP is the third party connecting to Franx. Franx does not have PIS yet, only AIS. A third party like Exact gets redirected to Franx, logs in via OAuth, gives consent, and then gets access to balance and transactions, nothing more than agreed.


Q2: How do you verify that a party is a registered TPP? Do you check the certificates yourselves?

That is the difficult part. TPPs need an eIDAS certificate. It is a special certificate, it works a bit like a chain. We need to validate the signature and build up the chain. There is a route: you have the certificate, signed by an issuer, and then you find out who that issuer is. If I know the root issuer and trust it, I trust your certificate. Like proving that your great-grandfather is someone I know, if I know him, I trust the whole family line. Franx has its own TPP validation application for this. When a TPP connects, we build up that certificate chain and verify it against our list of trusted issuers.


Q3: How do OAuth and access tokens work in this context?

OAuth has multiple grant types, authorisation code, client credentials, refresh token. The access token is a JWT, a JSON Web Token. It has a header, a decoded payload, and a signature. When you sign something, everyone can read it, but you need to verify the signing to make sure you trust it. We give the TPP an access token that is valid until a certain date and we sign it. To validate the token we read the OAuth server's public keys and decrypt the access token to verify the signature. That is how we know the token is legitimate.


Q4: What happens if an access token gets stolen?

Then someone else could use it to access data. To prevent this, we use Proof of Possession. The idea is that as a TPP you give your thumbprint, a hash of your public key from your certificate. We embed that thumbprint inside the access token. So even if someone intercepts the token, they cannot use it because they cannot prove they own the corresponding certificate. We expect both the certificate and the access token to match on every request.


Q5: How is the actual connection between TPP and Franx secured at the transport level?

Via Mutual TLS. Both sides prove who they are before any data is shared. The TPP presents its certificate, Franx presents its certificate, and only when both are verified does the connection get established.


Q6: Where does consent live today and how does the consent lifecycle work?

Consent is created as a structured object when the TPP posts to our consent endpoint. It gets a consent ID, an auth ID, and a status of received. After the PSU authenticates and confirms, the status moves to valid. It can also expire or be revoked. The TPP can check the consent status at any time or revoke it via a DELETE call.


Q7: Has Franx thought about acting as a TPP, calling other banks' PSD2 APIs on behalf of clients?

It has not been done yet and is still an exploratory idea. It is somewhat unconventional because Franx is itself a regulated financial institution rather than a typical fintech. PSD2 TPP connectivity was primarily designed for non-bank third parties that need a standardised way to access banking data. For institutions like Franx that already operate within the banking infrastructure, the formal TPP route introduces complexity that may not be necessary given the existing institutional relationships available.


Q8: What would Franx need legally and technically to act as a TPP?

At minimum you need a valid eIDAS certificate and a PSD2 licence obtained through a licensing process at the DNB. For a typical fintech that process is straightforward, but for Franx as a licensed financial institution the regulatory and administrative overhead is disproportionate to what the TPP licence would actually enable. The functionality we want — reading balances and initiating payments at external banks, is technically achievable via PSD2, but the licensing path introduces significant lead time and compliance requirements. Given the existing relationship with ABN AMRO, there are likely more direct routes to the same functionality.


Q9: Should Franx speak PSD2 language within ABFR?

Not per se PSD2 language, but simplified, four or five APIs. The accounting system should only provide those APIs. The backoffice system should only expose write APIs. Data should be accessed via a separate read API from another data storage. This is CQRS, Command Query Responsibility Segregation. The reason is the separation of front and backoffice and the support for multiple backoffice systems.


Q10: What are the possibilities for external connectivity?

Try sandbox environments. Try the PSD2 sandbox of ING, since Franx only has AIS and ING has a full sandbox. Mock the booking as incoming at Franx from that. For ABN AMRO, the connection through the internal ABN relationship might be more feasible than going through the formal PSD2 channel.


Q11: What happens when a client gives permission today but the action only executes later?

In PIS you can give the execution date when you initiate the payment. That date is passed along and the payment is only executed on that date.

