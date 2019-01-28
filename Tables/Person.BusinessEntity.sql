CREATE TABLE [Person].[BusinessEntity] (
  [BusinessEntityID] [int] IDENTITY,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_BusinessEntity_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_BusinessEntity_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_BusinessEntity_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID])
)
GO

CREATE UNIQUE INDEX [AK_BusinessEntity_rowguid]
  ON [Person].[BusinessEntity] ([rowguid])
GO