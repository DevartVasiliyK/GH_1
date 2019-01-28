CREATE TABLE [Production].[BillOfMaterials] (
  [BillOfMaterialsID] [int] IDENTITY,
  [ProductAssemblyID] [int] NULL,
  [ComponentID] [int] NOT NULL,
  [StartDate] [datetime] NOT NULL CONSTRAINT [DF_BillOfMaterials_StartDate] DEFAULT (getdate()),
  [EndDate] [datetime] NULL,
  [UnitMeasureCode] [nchar](3) NOT NULL,
  [BOMLevel] [smallint] NOT NULL,
  [PerAssemblyQty] [decimal](8, 2) NOT NULL CONSTRAINT [DF_BillOfMaterials_PerAssemblyQty] DEFAULT (1.00),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_BillOfMaterials_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_BillOfMaterials_BillOfMaterialsID] PRIMARY KEY NONCLUSTERED ([BillOfMaterialsID])
)
GO

ALTER TABLE [Production].[BillOfMaterials] WITH NOCHECK
  ADD CONSTRAINT [CK_BillOfMaterials_BOMLevel] CHECK ([ProductAssemblyID] IS NULL AND [BOMLevel]=(0) AND [PerAssemblyQty]=(1.00) OR [ProductAssemblyID] IS NOT NULL AND [BOMLevel]>=(1))
GO

ALTER TABLE [Production].[BillOfMaterials] WITH NOCHECK
  ADD CONSTRAINT [CK_BillOfMaterials_EndDate] CHECK ([EndDate]>[StartDate] OR [EndDate] IS NULL)
GO

ALTER TABLE [Production].[BillOfMaterials] WITH NOCHECK
  ADD CONSTRAINT [CK_BillOfMaterials_PerAssemblyQty] CHECK ([PerAssemblyQty]>=(1.00))
GO

ALTER TABLE [Production].[BillOfMaterials] WITH NOCHECK
  ADD CONSTRAINT [CK_BillOfMaterials_ProductAssemblyID] CHECK ([ProductAssemblyID]<>[ComponentID])
GO

CREATE UNIQUE CLUSTERED INDEX [AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate]
  ON [Production].[BillOfMaterials] ([ProductAssemblyID], [ComponentID], [StartDate])
GO

CREATE INDEX [IX_BillOfMaterials_UnitMeasureCode]
  ON [Production].[BillOfMaterials] ([UnitMeasureCode])
GO

ALTER TABLE [Production].[BillOfMaterials] WITH NOCHECK
  ADD CONSTRAINT [FK_BillOfMaterials_Product_ComponentID] FOREIGN KEY ([ComponentID]) REFERENCES [Production].[Product] ([ProductID])
GO

ALTER TABLE [Production].[BillOfMaterials] WITH NOCHECK
  ADD CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID] FOREIGN KEY ([ProductAssemblyID]) REFERENCES [Production].[Product] ([ProductID])
GO

ALTER TABLE [Production].[BillOfMaterials] WITH NOCHECK
  ADD CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([UnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO