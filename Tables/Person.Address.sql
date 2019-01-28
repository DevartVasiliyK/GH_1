CREATE TABLE [Person].[Address] (
  [AddressID] [int] IDENTITY,
  [AddressLine1] [nvarchar](60) NOT NULL,
  [AddressLine2] [nvarchar](60) NULL,
  [City] [nvarchar](30) NOT NULL,
  [StateProvinceID] [int] NOT NULL,
  [PostalCode] [nvarchar](15) NOT NULL,
  [SpatialLocation] [geography] NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Address_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Address_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED ([AddressID])
)
GO

CREATE UNIQUE INDEX [AK_Address_rowguid]
  ON [Person].[Address] ([rowguid])
GO

CREATE UNIQUE INDEX [IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode]
  ON [Person].[Address] ([AddressLine1], [AddressLine2], [City], [StateProvinceID], [PostalCode])
GO

CREATE INDEX [IX_Address_StateProvinceID]
  ON [Person].[Address] ([StateProvinceID])
GO

ALTER TABLE [Person].[Address]
  ADD CONSTRAINT [FK_Address_StateProvince_StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [Person].[StateProvince] ([StateProvinceID])
GO