CREATE TABLE [Sales].[SpecialOffer] (
  [SpecialOfferID] [int] IDENTITY,
  [Description] [nvarchar](255) NOT NULL,
  [DiscountPct] [smallmoney] NOT NULL CONSTRAINT [DF_SpecialOffer_DiscountPct] DEFAULT (0.00),
  [Type] [nvarchar](50) NOT NULL,
  [Category] [nvarchar](50) NOT NULL,
  [StartDate] [datetime] NOT NULL,
  [EndDate] [datetime] NOT NULL,
  [MinQty] [int] NOT NULL CONSTRAINT [DF_SpecialOffer_MinQty] DEFAULT (0),
  [MaxQty] [int] NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SpecialOffer_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SpecialOffer_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SpecialOffer_SpecialOfferID] PRIMARY KEY CLUSTERED ([SpecialOfferID]),
  CONSTRAINT [CK_SpecialOffer_DiscountPct] CHECK ([DiscountPct]>=(0.00)),
  CONSTRAINT [CK_SpecialOffer_EndDate] CHECK ([EndDate]>=[StartDate]),
  CONSTRAINT [CK_SpecialOffer_MaxQty] CHECK ([MaxQty]>=(0)),
  CONSTRAINT [CK_SpecialOffer_MinQty] CHECK ([MinQty]>=(0))
)
GO

CREATE UNIQUE INDEX [AK_SpecialOffer_rowguid]
  ON [Sales].[SpecialOffer] ([rowguid])
GO