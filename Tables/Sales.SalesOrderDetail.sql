CREATE TABLE [Sales].[SalesOrderDetail] (
  [SalesOrderID] [int] NOT NULL,
  [SalesOrderDetailID] [int] IDENTITY,
  [CarrierTrackingNumber] [nvarchar](25) NULL,
  [OrderQty] [smallint] NOT NULL,
  [ProductID] [int] NOT NULL,
  [SpecialOfferID] [int] NOT NULL,
  [UnitPrice] [money] NOT NULL,
  [UnitPriceDiscount] [money] NOT NULL CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount] DEFAULT (0.0),
  [LineTotal] AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrderDetail_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderDetail_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY CLUSTERED ([SalesOrderID], [SalesOrderDetailID]),
  CONSTRAINT [CK_SalesOrderDetail_OrderQty] CHECK ([OrderQty]>(0)),
  CONSTRAINT [CK_SalesOrderDetail_UnitPrice] CHECK ([UnitPrice]>=(0.00)),
  CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount] CHECK ([UnitPriceDiscount]>=(0.00))
)
GO

CREATE UNIQUE INDEX [AK_SalesOrderDetail_rowguid]
  ON [Sales].[SalesOrderDetail] ([rowguid])
GO

CREATE INDEX [IX_SalesOrderDetail_ProductID]
  ON [Sales].[SalesOrderDetail] ([ProductID])
GO

ALTER TABLE [Sales].[SalesOrderDetail]
  ADD CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID]) ON DELETE CASCADE
GO

ALTER TABLE [Sales].[SalesOrderDetail]
  ADD CONSTRAINT [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID] FOREIGN KEY ([SpecialOfferID], [ProductID]) REFERENCES [Sales].[SpecialOfferProduct] ([SpecialOfferID], [ProductID])
GO