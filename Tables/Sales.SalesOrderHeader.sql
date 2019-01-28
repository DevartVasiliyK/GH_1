CREATE TABLE [Sales].[SalesOrderHeader] (
  [SalesOrderID] [int] IDENTITY,
  [RevisionNumber] [tinyint] NOT NULL CONSTRAINT [DF_SalesOrderHeader_RevisionNumber] DEFAULT (0),
  [OrderDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderHeader_OrderDate] DEFAULT (getdate()),
  [DueDate] [datetime] NOT NULL,
  [ShipDate] [datetime] NULL,
  [Status] [tinyint] NOT NULL CONSTRAINT [DF_SalesOrderHeader_Status] DEFAULT (1),
  [OnlineOrderFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag] DEFAULT (1),
  [SalesOrderNumber] AS (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID]),N'*** ERROR ***')),
  [PurchaseOrderNumber] [dbo].[OrderNumber] NULL,
  [AccountNumber] [dbo].[AccountNumber] NULL,
  [CustomerID] [int] NOT NULL,
  [SalesPersonID] [int] NULL,
  [TerritoryID] [int] NULL,
  [BillToAddressID] [int] NOT NULL,
  [ShipToAddressID] [int] NOT NULL,
  [ShipMethodID] [int] NOT NULL,
  [CreditCardID] [int] NULL,
  [CreditCardApprovalCode] [varchar](15) NULL,
  [CurrencyRateID] [int] NULL,
  [SubTotal] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_SubTotal] DEFAULT (0.00),
  [TaxAmt] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_TaxAmt] DEFAULT (0.00),
  [Freight] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_Freight] DEFAULT (0.00),
  [TotalDue] AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))),
  [Comment] [nvarchar](128) NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrderHeader_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderHeader_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SalesOrderHeader_SalesOrderID] PRIMARY KEY CLUSTERED ([SalesOrderID]),
  CONSTRAINT [CK_SalesOrderHeader_DueDate] CHECK ([DueDate]>=[OrderDate]),
  CONSTRAINT [CK_SalesOrderHeader_Freight] CHECK ([Freight]>=(0.00)),
  CONSTRAINT [CK_SalesOrderHeader_ShipDate] CHECK ([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL),
  CONSTRAINT [CK_SalesOrderHeader_Status] CHECK ([Status]>=(0) AND [Status]<=(8)),
  CONSTRAINT [CK_SalesOrderHeader_SubTotal] CHECK ([SubTotal]>=(0.00)),
  CONSTRAINT [CK_SalesOrderHeader_TaxAmt] CHECK ([TaxAmt]>=(0.00))
)
GO

CREATE UNIQUE INDEX [AK_SalesOrderHeader_rowguid]
  ON [Sales].[SalesOrderHeader] ([rowguid])
GO

CREATE UNIQUE INDEX [AK_SalesOrderHeader_SalesOrderNumber]
  ON [Sales].[SalesOrderHeader] ([SalesOrderNumber])
GO

CREATE INDEX [IX_SalesOrderHeader_CustomerID]
  ON [Sales].[SalesOrderHeader] ([CustomerID])
GO

CREATE INDEX [IX_SalesOrderHeader_SalesPersonID]
  ON [Sales].[SalesOrderHeader] ([SalesPersonID])
GO

ALTER TABLE [Sales].[SalesOrderHeader]
  ADD CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID] FOREIGN KEY ([BillToAddressID]) REFERENCES [Person].[Address] ([AddressID])
GO

ALTER TABLE [Sales].[SalesOrderHeader]
  ADD CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID] FOREIGN KEY ([ShipToAddressID]) REFERENCES [Person].[Address] ([AddressID])
GO

ALTER TABLE [Sales].[SalesOrderHeader]
  ADD CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID] FOREIGN KEY ([CreditCardID]) REFERENCES [Sales].[CreditCard] ([CreditCardID])
GO

ALTER TABLE [Sales].[SalesOrderHeader]
  ADD CONSTRAINT [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID] FOREIGN KEY ([CurrencyRateID]) REFERENCES [Sales].[CurrencyRate] ([CurrencyRateID])
GO

ALTER TABLE [Sales].[SalesOrderHeader]
  ADD CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customer] ([CustomerID])
GO

ALTER TABLE [Sales].[SalesOrderHeader]
  ADD CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
GO

ALTER TABLE [Sales].[SalesOrderHeader]
  ADD CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO

ALTER TABLE [Sales].[SalesOrderHeader]
  ADD CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([ShipMethodID]) REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID])
GO