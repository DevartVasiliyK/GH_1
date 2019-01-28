SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[DeleteQualifyingHours]
	@QualifyingHoursIdentifier UNIQUEIDENTIFIER
AS
BEGIN
	-- Make history for the QualifyingHoursType.
	INSERT INTO [BenefitsAccount].[QualifyingHoursHistory]  (
		[QualifyingHoursHistoryIdentifier],
		[QualifyingHoursIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
		[QualifyingHoursMissing],
	    [EmploymentHours],
	    [PeriodStartDate],
	    [PeriodEndDate],
	    [QualifyingHoursPeriodNumber],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		[Operation]) 
	SELECT
		NEWID(),
		[QualifyingHoursIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
		[QualifyingHoursMissing],
	    [EmploymentHours],
	    [PeriodStartDate],
	    [PeriodEndDate],
	    [QualifyingHoursPeriodNumber],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		3 -- Operation: Deleted
	FROM [BenefitsAccount].[QualifyingHours]
	WHERE
		[QualifyingHoursIdentifier] = @QualifyingHoursIdentifier

	-- Delete the existing QualifyingHoursType.
	DELETE FROM [BenefitsAccount].[QualifyingHours]
	WHERE
		[QualifyingHoursIdentifier] = @QualifyingHoursIdentifier
END
GO