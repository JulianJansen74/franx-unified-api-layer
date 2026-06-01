SELECT TOP (1000) [Id]
      ,[CorporateSectorId]
      ,[SegmentId]
      ,[ClientFileId]
      ,[Name]
      ,[CountryOfIncorporation]
      ,[RegistrationNumber]
      ,[LeiCode]
      ,[LeiStatus]
      ,[LeiExpiryDate]
      ,[PhoneNumber]
      ,[Email]
      ,[Status]
      ,[Created]
      ,[CreatedBy]
      ,[Modified]
      ,[ModifiedBy]
      ,[BlancoPartyId]
      ,[BCNumber]
      ,[IncorporationDate]
      ,[MifidTestCompleted]
      ,[RiskClassification]
      ,[RiskClassifiedOn]
      ,[LegalFormId]
      ,[NominatedAccount]
      ,[Version]
      ,[AccountFee]
      ,[AccountFeeAmount]
  FROM [dbo].[Corporates]


  insert into [dbo].[Corporates] ([SegmentId]
      ,[Name]
      ,[CountryOfIncorporation]
      ,[RegistrationNumber]
      ,[PhoneNumber]
      ,[Email]
      ,[Status]
      ,[Created]
      ,[CreatedBy]
      ,[Modified]
      ,[ModifiedBy]
      ,[BCNumber]
      ,[IncorporationDate]
      ,[MifidTestCompleted]
      ,[RiskClassification]
      ,[RiskClassifiedOn]
      ,[LegalFormId]
      ,[AccountFee])
      values
      (1
      ,'Julian ABN Account'
      ,'NL'
      ,123
      ,'+31 620505402'
      ,'julian.jansen@franx.com'
      ,1	
      ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
      ,'julian.jansen@franx.com'	
      ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
      ,'julian.jansen@franx.com'	
      ,12574	
      ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))		
      ,1	
      ,2	
      ,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	
      ,2		
      ,1	)
