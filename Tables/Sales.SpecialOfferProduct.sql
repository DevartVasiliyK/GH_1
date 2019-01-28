CREATE TABLE [Sales].[SpecialOfferProduct] (
  [SpecialOfferID] [int] NOT NULL,
  [ProductID] [int] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SpecialOfferProduct_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SpecialOfferProduct_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SpecialOfferProduct_SpecialOfferID_ProductID] PRIMARY KEY CLUSTERED ([SpecialOfferID], [ProductID])
)
GO

CREATE UNIQUE INDEX [AK_SpecialOfferProduct_rowguid]
  ON [Sales].[SpecialOfferProduct] ([rowguid])
GO

CREATE INDEX [IX_SpecialOfferProduct_ProductID]
  ON [Sales].[SpecialOfferProduct] ([ProductID])
GO

ALTER TABLE [Sales].[SpecialOfferProduct]
  ADD CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
GO

ALTER TABLE [Sales].[SpecialOfferProduct]
  ADD CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID] FOREIGN KEY ([SpecialOfferID]) REFERENCES [Sales].[SpecialOffer] ([SpecialOfferID])
GO