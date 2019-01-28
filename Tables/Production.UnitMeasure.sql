CREATE TABLE [Production].[UnitMeasure] (
  [UnitMeasureCode] [nchar](3) NOT NULL,
  [Name] [dbo].[Name] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_UnitMeasure_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_UnitMeasure_UnitMeasureCode] PRIMARY KEY CLUSTERED ([UnitMeasureCode])
)
GO

CREATE UNIQUE INDEX [AK_UnitMeasure_Name]
  ON [Production].[UnitMeasure] ([Name])
GO