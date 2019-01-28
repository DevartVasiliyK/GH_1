CREATE TABLE [Sales].[CreditCard] (
  [CreditCardID] [int] IDENTITY,
  [CardType] [nvarchar](50) NOT NULL,
  [CardNumber] [nvarchar](25) NOT NULL,
  [ExpMonth] [tinyint] NOT NULL,
  [ExpYear] [smallint] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CreditCard_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_CreditCard_CreditCardID] PRIMARY KEY CLUSTERED ([CreditCardID])
)
GO

CREATE UNIQUE INDEX [AK_CreditCard_CardNumber]
  ON [Sales].[CreditCard] ([CardNumber])
GO