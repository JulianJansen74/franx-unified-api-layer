SELECT TOP (1000) [Id]
      ,[Name]
      ,[CreatedAt]
      ,[UpdatedAt]
  FROM [dbo].[Backoffices]


  insert into [dbo].[Backoffices] (name, createdat, updatedat)
  values ('AbnAmro', CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7))	,CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'Central European Standard Time' AS datetime2(7)))