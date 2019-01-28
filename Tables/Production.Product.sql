CREATE TABLE [Production].[Product] (
  [ProductID] [int] IDENTITY,
  [Name] [dbo].[Name] NOT NULL,
  [ProductNumber] [nvarchar](25) NOT NULL,
  [MakeFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_Product_MakeFlag] DEFAULT (1),
  [FinishedGoodsFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_Product_FinishedGoodsFlag] DEFAULT (1),
  [Color] [nvarchar](15) NULL,
  [SafetyStockLevel] [smallint] NOT NULL,
  [ReorderPoint] [smallint] NOT NULL,
  [StandardCost] [money] NOT NULL,
  [ListPrice] [money] NOT NULL,
  [Size] [nvarchar](5) NULL,
  [SizeUnitMeasureCode] [nchar](3) NULL,
  [WeightUnitMeasureCode] [nchar](3) NULL,
  [Weight] [decimal](8, 2) NULL,
  [DaysToManufacture] [int] NOT NULL,
  [ProductLine] [nchar](2) NULL,
  [Class] [nchar](2) NULL,
  [Style] [nchar](2) NULL,
  [ProductSubcategoryID] [int] NULL,
  [ProductModelID] [int] NULL,
  [SellStartDate] [datetime] NOT NULL,
  [SellEndDate] [datetime] NULL,
  [DiscontinuedDate] [datetime] NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Product_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID])
)
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_Class] CHECK (upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL)
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_DaysToManufacture] CHECK ([DaysToManufacture]>=(0))
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_ListPrice] CHECK ([ListPrice]>=(0.00))
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_ProductLine] CHECK (upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL)
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_ReorderPoint] CHECK ([ReorderPoint]>(0))
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_SafetyStockLevel] CHECK ([SafetyStockLevel]>(0))
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_SellEndDate] CHECK ([SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL)
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_StandardCost] CHECK ([StandardCost]>=(0.00))
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_Style] CHECK (upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL)
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [CK_Product_Weight] CHECK ([Weight]>(0.00))
GO

CREATE UNIQUE INDEX [AK_Product_Name]
  ON [Production].[Product] ([Name])
GO

CREATE UNIQUE INDEX [AK_Product_ProductNumber]
  ON [Production].[Product] ([ProductNumber])
GO

CREATE UNIQUE INDEX [AK_Product_rowguid]
  ON [Production].[Product] ([rowguid])
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [Production].[ProductModel] ([ProductModelID])
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID] FOREIGN KEY ([ProductSubcategoryID]) REFERENCES [Production].[ProductSubcategory] ([ProductSubcategoryID])
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode] FOREIGN KEY ([SizeUnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO

ALTER TABLE [Production].[Product] WITH NOCHECK
  ADD CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode] FOREIGN KEY ([WeightUnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO