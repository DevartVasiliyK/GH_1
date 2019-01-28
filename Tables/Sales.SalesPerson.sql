CREATE TABLE [Sales].[SalesPerson] (
  [BusinessEntityID] [int] NOT NULL,
  [TerritoryID] [int] NULL,
  [SalesQuota] [money] NULL,
  [Bonus] [money] NOT NULL CONSTRAINT [DF_SalesPerson_Bonus] DEFAULT (0.00),
  [CommissionPct] [smallmoney] NOT NULL CONSTRAINT [DF_SalesPerson_CommissionPct] DEFAULT (0.00),
  [SalesYTD] [money] NOT NULL CONSTRAINT [DF_SalesPerson_SalesYTD] DEFAULT (0.00),
  [SalesLastYear] [money] NOT NULL CONSTRAINT [DF_SalesPerson_SalesLastYear] DEFAULT (0.00),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesPerson_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesPerson_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SalesPerson_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID]),
  CONSTRAINT [CK_SalesPerson_Bonus] CHECK ([Bonus]>=(0.00)),
  CONSTRAINT [CK_SalesPerson_CommissionPct] CHECK ([CommissionPct]>=(0.00)),
  CONSTRAINT [CK_SalesPerson_SalesLastYear] CHECK ([SalesLastYear]>=(0.00)),
  CONSTRAINT [CK_SalesPerson_SalesQuota] CHECK ([SalesQuota]>(0.00)),
  CONSTRAINT [CK_SalesPerson_SalesYTD] CHECK ([SalesYTD]>=(0.00))
)
GO

CREATE UNIQUE INDEX [AK_SalesPerson_rowguid]
  ON [Sales].[SalesPerson] ([rowguid])
GO

ALTER TABLE [Sales].[SalesPerson]
  ADD CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO

ALTER TABLE [Sales].[SalesPerson]
  ADD CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO