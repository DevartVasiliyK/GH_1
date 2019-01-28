CREATE TABLE [Sales].[Currency] (
  [CurrencyCode] [nchar](3) NOT NULL,
  [Name] [dbo].[Name] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Currency_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Currency_CurrencyCode] PRIMARY KEY CLUSTERED ([CurrencyCode])
)
GO

CREATE UNIQUE INDEX [AK_Currency_Name]
  ON [Sales].[Currency] ([Name])
GO