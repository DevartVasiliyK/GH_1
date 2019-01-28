SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [joblog].[AddEntryToSearchIndexBuildLog]	
	@CreatedDate datetime2(7),
	@Count int,
	@Duration int
AS BEGIN	
	INSERT INTO [joblog].[SearchIndexBuildLog]([CreatedDate], [Count], [Duration])
    SELECT @CreatedDate, @Count, @Duration	
END
GO