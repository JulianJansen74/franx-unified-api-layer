Interview 3 - QA Engineer
Topic: PSD2 API testing, consent validation, test environments.
Setting: Microsoft Teams

Q1: Can you walk me through how you currently test the PSD2 API flows at Franx?
We have a Postman environment set up for testing the PSD2 flow. It covers the full sequence: registering as a TPP, requesting an access token, creating a consent object, authenticating as a PSU, exchanging the authorisation code for a JWT, and then calling the actual account endpoints. I can set that up and show you the manual if you need it. Most of the flow follows the same steps the IT Architect described, we test each step in sequence and verify the responses.

Q2: How do you verify that a party calling the API is actually a valid TPP?
That validation happens in the TPP validation application. We test it by presenting valid and invalid certificates and checking that the system responds correctly, accepting valid certificates and rejecting invalid or expired ones. The certificate chain verification is the core check. We also test that the eIDAS role in the certificate matches what the TPP is claiming to do.

Q3: Have you ever found cases where permission checks were inconsistent between systems?
No, we have not. We do it the way the IT Architect described, consent is checked consistently in the same place. Each system handles its own checks and we have not had situations where two systems gave different answers for the same request. But that is also because currently everything is internal. We have not tested scenarios involving external systems.

Q4: How do you test whether a stored consent is still valid when an action is executed at a later time?
We check the consent status in our system before processing the request. The consent object has a validity period, and we verify that the status is still valid at the time of the call. We test this by deliberately using expired or revoked consent objects and confirming that the system rejects them correctly.

Q5: Have you ever tested external bank sandboxes, like ABN AMRO or ING?
No, I have not. I have only tested the things we have actually implemented at Franx. The outbound direction, Franx calling an external bank's API, has never been part of our test scope so far.

Q6: If Franx were to start calling external bank APIs, what would be the biggest testing challenge?
The biggest challenge would probably be the OAuth flow from the client's side, testing that the consent is correctly given at the external bank and that it comes back to Franx correctly. That is a different flow from what we test today, where Franx is the one validating consent. If we are the ones requesting consent from another bank, we need to test the redirect, the authorisation code exchange, and what happens when the client denies consent or when the consent expires.

Q7: What are the most common consent-related issues you see in practice?
Mostly timing issues, consent that has technically expired but the system has not caught up yet, or edge cases where the PSU abandons the authorisation flow halfway through and the consent stays in received state. We have also seen cases where the scope in the consent does not quite match the scope of the actual request, which causes unexpected rejections.

