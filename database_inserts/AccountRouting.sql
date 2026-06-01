SELECT TOP (1000) [AccountNumber]
      ,[BackofficeId]
      ,[CreatedAt]
      ,[UpdatedAt]
      ,[Status]
  FROM [dbo].[BackofficeAccounts]
  order by createdat desc

  insert into [dbo].[BackofficeAccounts] (AccountNumber,BackofficeId, CreatedAt, [UpdatedAt], Status)
  values (
  'NL12ABNA9999876523'
  ,3
  ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
  ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
  ,'Active')