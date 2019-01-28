SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[DeleteQualifyingHoursReport]
	@QualifyingHoursReportIdentifier UNIQUEIDENTIFIER
AS
BEGIN
	-- Make history for the QualifyingHoursReportType.
	INSERT INTO [BenefitsAccount].[QualifyingHoursReportHistory] (
		[QualifyingHoursReportHistoryIdentifier],
		[QualifyingHoursReportIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
	    [DecisionDate],
	    [QualifyingHoursWithdrawalAmount],
	    [ExecutionMonth],
	    [QualifyingHoursPeriodNumber],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		[Operation]) 
	SELECT
		NEWID(),
		[QualifyingHoursReportIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
	    [DecisionDate],
	    [QualifyingHoursWithdrawalAmount],
	    [ExecutionMonth],
	    [QualifyingHoursPeriodNumber],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		3 -- Operation: Deleted
	FROM [BenefitsAccount].[QualifyingHoursReport]
	WHERE
		[QualifyingHoursReportIdentifier] = @QualifyingHoursReportIdentifier

	-- Delete the existing QualifyingHoursReportType.
	DELETE FROM [BenefitsAccount].[QualifyingHoursReport] 
	WHERE
		[QualifyingHoursReportIdentifier] = @QualifyingHoursReportIdentifier
END
GO