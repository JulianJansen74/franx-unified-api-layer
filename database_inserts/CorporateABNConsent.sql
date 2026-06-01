/****** Object:  Table [dbo].[Portfolios]    Script Date: 7-5-2026 10:45:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CorporateABNConsent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CorporateId] [int] NOT NULL,
	[Client-Id] [nvarchar](200) NOT NULL,
	[API-Key] [nvarchar](200) NOT NULL,
	[Status] [nvarchar](200) NOT NULL,
	[Created] [datetime2](7) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[Modified] [datetime2](7) NOT NULL,
	[ModifiedBy] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CorporateABNConsent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CorporateABNConsent] ADD  DEFAULT (getdate()) FOR [Created]
GO

ALTER TABLE [dbo].[CorporateABNConsent] ADD  DEFAULT (getdate()) FOR [Modified]
GO

ALTER TABLE [dbo].[CorporateABNConsent]  WITH CHECK ADD  CONSTRAINT [FK_CorporateABNConsent_Corporates_CorporateId] FOREIGN KEY([CorporateId])
REFERENCES [dbo].[Corporates] ([Id])
GO

ALTER TABLE [dbo].[CorporateABNConsent] CHECK CONSTRAINT [FK_CorporateABNConsent_Corporates_CorporateId]
GO


