Interview 2 - IT Architect (Session 2)
Topic: Outbound PSD2 connectivity, CQRS principle, core API standardisation, sandbox recommendation.
Setting: Microsoft Teams

Q1: Has Franx thought about acting as a TPP, calling other banks' PSD2 APIs on behalf of clients?
It has not been done yet and is still an exploratory idea. It is somewhat unconventional because Franx is itself a regulated financial institution rather than a typical fintech. PSD2 TPP connectivity was primarily designed for non-bank third parties that need a standardised way to access banking data. For institutions like Franx that already operate within the banking infrastructure, the formal TPP route introduces complexity that may not be necessary given the existing institutional relationships available.

Q2: What would Franx need legally and technically to act as a TPP?
At minimum you need a valid eIDAS certificate and a PSD2 licence obtained through a licensing process at the DNB. For a typical fintech that process is straightforward, but for Franx as a licensed financial institution the regulatory and administrative overhead is disproportionate to what the TPP licence would actually enable. The functionality we want — reading balances and initiating payments at external banks, is technically achievable via PSD2, but the licensing path introduces significant lead time and compliance requirements. Given the existing relationship with ABN AMRO, there are likely more direct routes to the same functionality.

Q3: Should Franx speak PSD2 language within ABFR?
Not per se PSD2 language, but simplified, four or five APIs. The accounting system should only provide those APIs. The backoffice system should only expose write APIs. Data should be accessed via a separate read API from another data storage. This is CQRS, Command Query Responsibility Segregation. The reason is the separation of front and backoffice and the support for multiple backoffice systems.

Q4: What are the possibilities for external connectivity?
Try sandbox environments. Try the PSD2 sandbox of ING, since Franx only has AIS and ING has a full sandbox. Mock the booking as incoming at Franx from that. For ABN AMRO, the connection through the internal ABN relationship might be more feasible than going through the formal PSD2 channel.

Q5: What happens when a client gives permission today but the action only executes later?
In PIS you can give the execution date when you initiate the payment. That date is passed along and the payment is only executed on that date.
