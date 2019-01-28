SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[DeleteBenefitsRate]
	@BenefitsRateIdentifier UNIQUEIDENTIFIER
AS
BEGIN
	-- Make history for the BenefitsRateType.
	INSERT INTO [BenefitsAccount].[BenefitsRateHistory] (
	    [BenefitsRateHistoryIdentifier],
		[BenefitsRateIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
		[RatePerMonth],
		[RatePerHour],
		[RateValidFrom],
		[RateBasis],
		[RegisterInformationTime],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		[Operation]) 
	SELECT
		NEWID(),
		[BenefitsRateIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
		[RatePerMonth],
		[RatePerHour],
		[RateValidFrom],
		[RateBasis],
		[RegisterInformationTime],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		3 -- Operation: Deleted
	FROM [BenefitsAccount].[BenefitsRate]
	WHERE
		[BenefitsRateIdentifier] = @BenefitsRateIdentifier

	-- Delete the existing BenefitsRateType.
	DELETE FROM [BenefitsAccount].[BenefitsRate]
	WHERE
		[BenefitsRateIdentifier] = @BenefitsRateIdentifier
END
GO