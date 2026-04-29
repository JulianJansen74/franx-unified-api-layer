Interview 2 - IT Architect (Session 2)
Topic: Outbound PSD2 connectivity, CQRS principle, core API standardisation, sandbox recommendation.
Setting: Microsoft Teams

Q1: Has Franx thought about acting as a TPP, calling other banks' PSD2 APIs on behalf of clients?
Never done, and just an idea. Bit tricky because Franx is a bank. ABN AMRO has a connection called Multibank where they communicate through messages, same principle as PSD2. 
For them, connecting via PSD2 is not really feasible. I never heard of a bank connecting to another bank via the PSD2 TPP route.

Q2: Should Franx speak PSD2 language within ABFR?
Not per se PSD2 language, but simplified five APIs. The accounting system should only provide those five APIs. The backoffice system only exposes write APIs, 
the data is queried from another data storage with an API. This is CQRS, Command Query Responsibility Segregation.

Q3: What are the possibilities for external connectivity?
AIS: balance showing on Franx Portal. PIS: settle spot, later forward. Try the ING sandbox and mock the booking as incoming at Franx.

Q4: What happens when a client gives permission today but the action only executes later?
In PIS you can give the execution date.
