CREATE TABLE [Sales].[Store] (
  [BusinessEntityID] [int] NOT NULL,
  [Name] [dbo].[Name] NOT NULL,
  [SalesPersonID] [int] NULL,
  [Demographics] [xml] (CONTENT Sales.StoreSurveySchemaCollection) NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Store_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Store_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Store_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID])
)
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PRIMARY XML INDEX [PXML_Store_Demographics]
  ON [Sales].[Store] ([Demographics])
GO

CREATE UNIQUE INDEX [AK_Store_rowguid]
  ON [Sales].[Store] ([rowguid])
GO

CREATE INDEX [IX_Store_SalesPersonID]
  ON [Sales].[Store] ([SalesPersonID])
GO

ALTER TABLE [Sales].[Store]
  ADD CONSTRAINT [FK_Store_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
GO

ALTER TABLE [Sales].[Store]
  ADD CONSTRAINT [FK_Store_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
GO