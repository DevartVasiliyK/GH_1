CREATE TABLE [Person].[CountryRegion] (
  [CountryRegionCode] [nvarchar](3) NOT NULL,
  [Name] [dbo].[Name] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CountryRegion_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY CLUSTERED ([CountryRegionCode])
)
GO

CREATE UNIQUE INDEX [AK_CountryRegion_Name]
  ON [Person].[CountryRegion] ([Name])
GO