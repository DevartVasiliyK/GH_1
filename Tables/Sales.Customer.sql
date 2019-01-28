CREATE TABLE [Sales].[Customer] (
  [CustomerID] [int] IDENTITY,
  [PersonID] [int] NULL,
  [StoreID] [int] NULL,
  [TerritoryID] [int] NULL,
  [AccountNumber] AS (isnull('AW'+[dbo].[ufnLeadingZeros]([CustomerID]),'')),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Customer_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID])
)
GO

CREATE UNIQUE INDEX [AK_Customer_AccountNumber]
  ON [Sales].[Customer] ([AccountNumber])
GO

CREATE UNIQUE INDEX [AK_Customer_rowguid]
  ON [Sales].[Customer] ([rowguid])
GO

CREATE INDEX [IX_Customer_TerritoryID]
  ON [Sales].[Customer] ([TerritoryID])
GO

ALTER TABLE [Sales].[Customer]
  ADD CONSTRAINT [FK_Customer_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person].[Person] ([BusinessEntityID])
GO

ALTER TABLE [Sales].[Customer]
  ADD CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO

ALTER TABLE [Sales].[Customer]
  ADD CONSTRAINT [FK_Customer_Store_StoreID] FOREIGN KEY ([StoreID]) REFERENCES [Sales].[Store] ([BusinessEntityID])
GO