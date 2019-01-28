CREATE TABLE [Sales].[TrackingEvent] (
  [TrackingEventID] [int] IDENTITY,
  [EventName] [nvarchar](255) NOT NULL,
  CONSTRAINT [PK_TrackingEvent_TrackingEventID] PRIMARY KEY CLUSTERED ([TrackingEventID])
)
GO