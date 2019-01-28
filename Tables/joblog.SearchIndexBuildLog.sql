CREATE TABLE [joblog].[SearchIndexBuildLog] (
  [Id] [int] IDENTITY,
  [CreatedDate] [datetime2] NOT NULL,
  [Count] [int] NOT NULL,
  [Duration] [int] NOT NULL,
  CONSTRAINT [PK_IndexBuildLog] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO