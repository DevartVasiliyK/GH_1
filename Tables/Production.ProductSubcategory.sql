CREATE TABLE [Production].[ProductSubcategory] (
  [ProductSubcategoryID] [int] IDENTITY,
  [ProductCategoryID] [int] NOT NULL,
  [Name] [dbo].[Name] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ProductSubcategory_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductSubcategory_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID] PRIMARY KEY CLUSTERED ([ProductSubcategoryID])
)
GO

CREATE UNIQUE INDEX [AK_ProductSubcategory_Name]
  ON [Production].[ProductSubcategory] ([Name])
GO

CREATE UNIQUE INDEX [AK_ProductSubcategory_rowguid]
  ON [Production].[ProductSubcategory] ([rowguid])
GO

ALTER TABLE [Production].[ProductSubcategory]
  ADD CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [Production].[ProductCategory] ([ProductCategoryID])
GO