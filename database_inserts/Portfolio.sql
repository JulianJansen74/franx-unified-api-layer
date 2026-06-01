SELECT TOP (1000) [Id]
      ,[CorporateId]
      ,[Name]
      ,[Type]
      ,[Status]
      ,[NominatedAccount]
      ,[Created]
      ,[CreatedBy]
      ,[Modified]
      ,[ModifiedBy]
      ,[Version]
      ,[BackofficeId]
  FROM [dbo].[Portfolios]

  insert into [dbo].[Portfolios] ([CorporateId]
      ,[Name]
      ,[Type]
      ,[NominatedAccount]
      ,[Status]
      ,[Created]
      ,[CreatedBy]
      ,[Modified]
      ,[ModifiedBy]
      ,[BackofficeId])
      values
      (900050
      ,'Julian ABN Account'
      ,1
      ,'NL12ABNA9999876523'
      ,1
      ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
      ,'julian.jansen@franx.com'	
      ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
      ,'julian.jansen@franx.com'	
      ,2
      )