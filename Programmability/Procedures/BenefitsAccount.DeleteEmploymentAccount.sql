SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[DeleteEmploymentAccount]
	@EmploymentAccountIdentifier UNIQUEIDENTIFIER
AS
BEGIN

INSERT INTO [BenefitsAccount].[EmploymentAccountHistory]
           ([EmploymentAccountHistoryIdentifier]
           ,[EmploymentAccountIdentifier]
           ,[BenefitsGradingIdentifier]
           ,[CivilRegistrationIdentifier]
           ,[EmploymentHours]
           ,[ExpectedObsoleteDate]
           ,[AccountOpeningDate]
           ,[PotentialProlongationBenefitHours]
           ,[LatentProlongedBenefitsPeriod]
           ,[HoursConsumed]
           ,[LatestEmployerReportUsed]
           ,[RegisterInformationTime]
           ,[CalculationDate]
           ,[RegistrationDateTime]
           ,[CreatedDateTime]
           ,[UpdatedDateTime]
           ,[RecordingAuthorityId]
           ,[Operation])
	SELECT NEWID()
		  ,[EmploymentAccountIdentifier]
		  ,[BenefitsGradingIdentifier]
		  ,[CivilRegistrationIdentifier]
		  ,[EmploymentHours]
		  ,[ExpectedObsoleteDate]
		  ,[AccountOpeningDate]
		  ,[PotentialProlongationBenefitHours]
		  ,[LatentProlongedBenefitsPeriod]
		  ,[HoursConsumed]
		  ,[LatestEmployerReportUsed]
		  ,[RegisterInformationTime]
		  ,[CalculationDate]
		  ,[RegistrationDateTime]
		  ,[CreatedDateTime]
		  ,[UpdatedDateTime]
		  ,[RecordingAuthorityId]
		  ,3 -- Operation: Deleted
     FROM [BrokerServices_T216527].[BenefitsAccount].[EmploymentAccount]
	WHERE [EmploymentAccountIdentifier] = @EmploymentAccountIdentifier


	-- Delete the existing EmploymentAccountType.
	DELETE FROM [BenefitsAccount].[EmploymentAccount]
	 WHERE [EmploymentAccountIdentifier] = @EmploymentAccountIdentifier

END
GO