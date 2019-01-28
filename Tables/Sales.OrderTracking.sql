CREATE TABLE [Sales].[OrderTracking] (
  [OrderTrackingID] [int] IDENTITY,
  [SalesOrderID] [int] NOT NULL,
  [CarrierTrackingNumber] [nvarchar](25) NULL,
  [TrackingEventID] [int] NOT NULL,
  [EventDetails] [nvarchar](2000) NOT NULL,
  [EventDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_OrderTracking] PRIMARY KEY CLUSTERED ([OrderTrackingID])
)
GO

CREATE INDEX [IX_OrderTracking_CarrierTrackingNumber]
  ON [Sales].[OrderTracking] ([CarrierTrackingNumber])
GO

CREATE INDEX [IX_OrderTracking_SalesOrderID]
  ON [Sales].[OrderTracking] ([SalesOrderID])
GO