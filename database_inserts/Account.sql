SELECT TOP (1000) [Id]
      ,[PortfolioId]
      ,[Number]
      ,[Type]
      ,[Status]
      ,[Created]
      ,[CreatedBy]
      ,[Modified]
      ,[ModifiedBy]
  FROM [dbo].[Accounts]


  insert into [dbo].[Accounts] (
  [PortfolioId]
      ,[Number]
      ,[Type]
      ,[Status]
      ,[Created]
      ,[CreatedBy]
      ,[Modified]
      ,[ModifiedBy])
      values (
      900040
      ,'NL12ABNA9999876523'
      ,0
      ,1
      ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
      ,'julian.jansen@franx.com'	
      ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
      ,'julian.jansen@franx.com')