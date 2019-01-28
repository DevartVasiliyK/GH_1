CREATE TABLE [Sales].[CurrencyRate] (
  [CurrencyRateID] [int] IDENTITY,
  [CurrencyRateDate] [datetime] NOT NULL,
  [FromCurrencyCode] [nchar](3) NOT NULL,
  [ToCurrencyCode] [nchar](3) NOT NULL,
  [AverageRate] [money] NOT NULL,
  [EndOfDayRate] [money] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CurrencyRate_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_CurrencyRate_CurrencyRateID] PRIMARY KEY CLUSTERED ([CurrencyRateID])
)
GO

CREATE UNIQUE INDEX [AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode]
  ON [Sales].[CurrencyRate] ([CurrencyRateDate], [FromCurrencyCode], [ToCurrencyCode])
GO

ALTER TABLE [Sales].[CurrencyRate]
  ADD CONSTRAINT [FK_CurrencyRate_Currency_FromCurrencyCode] FOREIGN KEY ([FromCurrencyCode]) REFERENCES [Sales].[Currency] ([CurrencyCode])
GO

ALTER TABLE [Sales].[CurrencyRate]
  ADD CONSTRAINT [FK_CurrencyRate_Currency_ToCurrencyCode] FOREIGN KEY ([ToCurrencyCode]) REFERENCES [Sales].[Currency] ([CurrencyCode])
GO