CREATE TABLE [Production].[ProductModel] (
  [ProductModelID] [int] IDENTITY,
  [Name] [dbo].[Name] NOT NULL,
  [CatalogDescription] [xml] (CONTENT Production.ProductDescriptionSchemaCollection) NULL,
  [Instructions] [xml] (CONTENT Production.ManuInstructionsSchemaCollection) NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ProductModel_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductModel_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY CLUSTERED ([ProductModelID])
)
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PRIMARY XML INDEX [PXML_ProductModel_Instructions]
  ON [Production].[ProductModel] ([Instructions])
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PRIMARY XML INDEX [PXML_ProductModel_CatalogDescription]
  ON [Production].[ProductModel] ([CatalogDescription])
GO

CREATE UNIQUE INDEX [AK_ProductModel_Name]
  ON [Production].[ProductModel] ([Name])
GO

CREATE UNIQUE INDEX [AK_ProductModel_rowguid]
  ON [Production].[ProductModel] ([rowguid])
GO