CREATE TABLE [Purchasing].[ShipMethod] (
  [ShipMethodID] [int] IDENTITY,
  [Name] [dbo].[Name] NOT NULL,
  [ShipBase] [money] NOT NULL CONSTRAINT [DF_ShipMethod_ShipBase] DEFAULT (0.00),
  [ShipRate] [money] NOT NULL CONSTRAINT [DF_ShipMethod_ShipRate] DEFAULT (0.00),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ShipMethod_rowguid] DEFAULT (newid()),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ShipMethod_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ShipMethod_ShipMethodID] PRIMARY KEY CLUSTERED ([ShipMethodID]),
  CONSTRAINT [CK_ShipMethod_ShipBase] CHECK ([ShipBase]>(0.00)),
  CONSTRAINT [CK_ShipMethod_ShipRate] CHECK ([ShipRate]>(0.00))
)
GO

CREATE UNIQUE INDEX [AK_ShipMethod_Name]
  ON [Purchasing].[ShipMethod] ([Name])
GO

CREATE UNIQUE INDEX [AK_ShipMethod_rowguid]
  ON [Purchasing].[ShipMethod] ([rowguid])
GO