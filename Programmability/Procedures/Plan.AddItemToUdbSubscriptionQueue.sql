SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Plan].[AddItemToUdbSubscriptionQueue]
    @Identifier uniqueidentifier,
	@CivilRegistrationIdentifier char(10),
	@Type nvarchar(50),
	@SubscriptionStartDate datetime2,
	@UnsubscriptionCause int
AS

	INSERT INTO [BrokerServices_T216527].[Plan].[UdbSubscriptionQueue]
           ([Identifier]
           ,[CivilRegistrationIdentifier]
           ,[Type]
           ,[SubscriptionStartDate]
           ,[UnsubscriptionCause]
		   ,[CreatedDate])
     VALUES
           (@Identifier
           ,@CivilRegistrationIdentifier
           ,@Type
           ,@SubscriptionStartDate
           ,@UnsubscriptionCause
		   ,GETDATE())
GO