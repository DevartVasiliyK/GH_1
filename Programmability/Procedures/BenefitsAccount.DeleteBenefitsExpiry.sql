SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[DeleteBenefitsExpiry]
	@BenefitsExpiryIdentifier UNIQUEIDENTIFIER
AS
BEGIN
	-- Make history for the BenefitsExpiryType.
	INSERT INTO [BenefitsAccount].[BenefitsExpiryHistory] (
	    [BenefitsExpiryHistoryIdentifier],
		[BenefitsExpiryIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
		[BenefitsExpiryDate],
		[BenefitsExpiryCause],
		[BenefitsExpiryActualOrExpected],
		[RegisterInformationTime],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		[Operation]) 
	SELECT
		NEWID(),
		[BenefitsExpiryIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
		[BenefitsExpiryDate],
		[BenefitsExpiryCause],
		[BenefitsExpiryActualOrExpected],
		[RegisterInformationTime],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		3 -- Operation: Deleted
	FROM [BenefitsAccount].[BenefitsExpiry]
	WHERE
		[BenefitsExpiryIdentifier] = @BenefitsExpiryIdentifier

	-- Delete the existing BenefitsExpiryType.
	DELETE FROM [BenefitsAccount].[BenefitsExpiry]
	WHERE
		[BenefitsExpiryIdentifier] = @BenefitsExpiryIdentifier
END
GO