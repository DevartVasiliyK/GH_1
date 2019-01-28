CREATE TABLE [Sales].[SalesTerritory] (
  [TerritoryID] [int] IDENTITY,
  [Name] [dbo].[Name] NOT NULL,
  [CountryRegionCode] [nvarchar](3) NOT NULL,
  [Group] [nvarchar](50) NOT NULL,
  [SalesYTD] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_SalesYTD] DEFAULT (0.00),
  [SalesLastYear] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_SalesLastYear] DEFAULT (0.00),
  [CostYTD] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_CostYTD] DEFAULT (0.00),
  [CostLastYear] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_CostLastYear] DEFAULT (0.00),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesTerritory_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesTerritory_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED ([TerritoryID]),
  CONSTRAINT [CK_SalesTerritory_CostLastYear] CHECK ([CostLastYear]>=(0.00)),
  CONSTRAINT [CK_SalesTerritory_CostYTD] CHECK ([CostYTD]>=(0.00)),
  CONSTRAINT [CK_SalesTerritory_SalesLastYear] CHECK ([SalesLastYear]>=(0.00)),
  CONSTRAINT [CK_SalesTerritory_SalesYTD] CHECK ([SalesYTD]>=(0.00))
)
GO

CREATE UNIQUE INDEX [AK_SalesTerritory_Name]
  ON [Sales].[SalesTerritory] ([Name])
GO

CREATE UNIQUE INDEX [AK_SalesTerritory_rowguid]
  ON [Sales].[SalesTerritory] ([rowguid])
GO

ALTER TABLE [Sales].[SalesTerritory]
  ADD CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [Person].[CountryRegion] ([CountryRegionCode])
GO