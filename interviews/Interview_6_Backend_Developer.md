Interview 6 — Backend Developer
Topic: API standardisation, read/write database separation, ISO language, ABN AMRO connectivity.
Setting: Franx office

Q1: Do you think we should simplify the ABFR layer with a standardised set of APIs?

Yes, standard APIs definitely, and standardise the language to ISO language. That makes it much cleaner to connect to different backends. 
Connect to APIs from ABN AMRO bank would be nice as well. Using ABN AMRO clients more often in the Franx portal would be a real opportunity.


Q2: We are thinking about splitting up the databases for POST and GET requests so the backoffice does not get overloaded with reads. How do you think that should work?

Yes, we definitely need to do that. You have a setting called master/slave or active-active set-up, which splits POST and GET requests across separate database instances. 
The write operations go to the master and the reads go to the replica. That prevents read-heavy workloads from affecting the write performance. 
It is a standard pattern and it works well for this kind of system.


Q3: If Franx were to add a new backend, say an external bank API, what would that look like from a development perspective?

If the API surface is standardised to a small set of endpoints, adding a new backend means writing one adapter. 
You map the standardised Franx request to whatever format the external bank expects. The routing table tells ABFR which adapter to use for a given account. 
That is clean and maintainable. The alternative, where each new backend gets custom logic all the way through, quickly becomes unmanageable.
