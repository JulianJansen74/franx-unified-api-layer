# database_inserts

This folder contains SQL scripts to set up the test data used in the proof of concept. Run the scripts in the order listed below, as each step depends on the previous one.

---

## Execution Order

### Step 1 — Backoffice.sql

Creates a backoffice record for ABN AMRO (BackofficeId 3). This is the external backoffice that the ABN Business Account Gateway routes to.

### Step 2 — Corporate.sql

Creates a corporate record representing the test client. The CorporateId (900050) is referenced by the consent record and the portfolio.

> Note: The insert statement is commented out by default. Uncomment it before running if no corporate with Id 900050 exists in your environment.

### Step 3 — Portfolio.sql

Creates a portfolio linked to the corporate (CorporateId 900050) with BackofficeId 3, connecting the client to the ABN AMRO backoffice.

### Step 4 — Account.sql

Creates an account record with the ABN AMRO IBAN (NL12ABNA9999876523) linked to the portfolio (PortfolioId 900040).

### Step 5 — AccountRouting.sql

Inserts the ABN AMRO IBAN into the Account Routing Table with BackofficeId 3. This is the entry that tells ABFR.Account to route requests for this account to the ABN Business Account Gateway.

### Step 6 — CorporateABNConsent.sql

Creates the CorporateABNConsent table and inserts a test consent record with Status = Valid for CorporateId 900050. This record is checked by the ABN Business Account Gateway before each external call.

To test the four consent states, update the Status field manually:

```sql
-- Test Valid (default)
UPDATE [dbo].[CorporateABNConsent] SET [Status] = 'Valid' WHERE [CorporateId] = 900050

-- Test Invalid
UPDATE [dbo].[CorporateABNConsent] SET [Status] = 'Invalid' WHERE [CorporateId] = 900050

-- Test Expired
UPDATE [dbo].[CorporateABNConsent] SET [Status] = 'Expired' WHERE [CorporateId] = 900050

-- Test Revoked
UPDATE [dbo].[CorporateABNConsent] SET [Status] = 'Revoked' WHERE [CorporateId] = 900050
```

Each status produces a different error response from the gateway, for example:

```
CDM consent request failed: AbnConsentInvalidStatus - ABN consent status is Expired.
```

---

## Notes

- All scripts are written for SQL Server.
- The ABN AMRO IBAN used in the test data (NL12ABNA9999876523) is a sandbox test account and does not represent a real account.
- The API key in the consent insert is a sandbox key for the ABN AMRO Developer Portal test environment.
