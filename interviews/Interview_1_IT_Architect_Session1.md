Interview 1 - IT Architect (Session 1)
Topic: Inbound PSD2 architecture, eIDAS certificate validation, OAuth2, JWT, Proof of Possession, mTLS.
Setting: Microsoft Teams

Q1: What is PSD2 and how does Franx use it?
PSD2 is a European regulation abstract on its own. Franx uses the Berlin Group NextGenPSD2 standard to make it technically workable. 
Key roles: PSU is the end user, AISP is the party reading account info, ASPSP is Franx (the bank-like provider), TPP is the third party connecting to Franx. 
Franx does not have PIS (payment initiation) yet.

Q2: How is the current PSD2 API layer set up for inbound traffic, and how do we decide who gets access?
A third party like Exact gets redirected to Franx, logs in via OAuth, gives consent, and then gets access to balance and transactions, nothing more than agreed.

Q3: How do you verify that a party is a registered TPP? Do you check certificates yourself?
TPPs need an eIDAS certificate. Franx checks this by following the certificate chain, like checking if you trust someone's great-grandfather. 
If I know the root issuer, I trust the certificate. Franx has its own TPP validation application for this.

Q4: How do access tokens work and what happens if one gets stolen?
The access token is a JWT, a small readable file with a signature.
The signature proves the token came from a trusted source. Franx verifies this using the OAuth server's public key. 
For stolen tokens, Franx uses Proof of Possession: a fingerprint of the TPP's public key is embedded in the token. 
If someone steals the token, they still cannot prove they own it.

Q5: How is the connection secured?
Via Mutual TLS, both sides prove who they are before any data is shared.

