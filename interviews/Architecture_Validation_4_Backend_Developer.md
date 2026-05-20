Architecture Validation 4 — Backend Developer
Setting: Franx Office

Architecture Validation

Q1: The proposed architecture defines five standardised core endpoints and requires each backend to implement a single adapter. Does this design hold up from an implementation perspective?

Yes, the adapter pattern is a solid approach. Each adapter is responsible for translating between the unified internal format and whatever the backend expects. 
As long as the interface contract is clear and fixed, adding a new adapter is straightforward. The risk is if the five core endpoints are not expressive enough for all the operations a backend needs to support. 
But for the current scope it looks fine.


Q2: The CQRS separation means internal backoffices only expose write APIs and reads come from a readonly copy of Backoffice 2. What do you think of this?

I discussed this one with the IT Architect already as well. Good idea to not overload the backoffice with GET request, but only for POST request reach the backoffice and for GET request
use the readonly copy of the backoffice.


Q3: The ABN Business Account Gateway is a separate outbound application that handles OAuth2 tokens and TLS certificates. Does separating this from ABFR make sense from your perspective?

Yes. Keeping the authentication and external API logic in a separate component makes ABFR cleaner. ABFR stays focused on routing. The gateway handles all the external connectivity concerns. 
If ABN AMRO changes their authentication mechanism, you only need to update the gateway, not ABFR itself. It is a good separation.


Q4: The consent record is stored in the Frontend database and the gateway reads it before each external call. Is this the right place for it?

Yes at the frontend, at the corporate data, there is where the consent for ABN should be stored as well, because it's in the client domain.
Encryption of the client-id and API key in the database is something to look into in further stages, but that is out of scope for the current implementation.


Q5: Looking at the overall design, are there any components or decisions you would design differently?

No looks good like this.
