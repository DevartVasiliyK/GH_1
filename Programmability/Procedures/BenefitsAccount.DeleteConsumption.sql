SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[DeleteConsumption]
	@ConsumptionIdentifier UNIQUEIDENTIFIER
AS
BEGIN
	-- Make history for the ConsumptionType.
	INSERT INTO [BenefitsAccount].[ConsumptionHistory] (
		[ConsumptionHistoryIdentifier],
		[ConsumptionIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
	    [HoursConsumed],
        [HoursRemaining],
	    [InventoryPaymentMonth],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		[Operation]) 
	SELECT
		NEWID(),
		[ConsumptionIdentifier],
		[BenefitsGradingIdentifier],
		[CivilRegistrationIdentifier],
	    [HoursConsumed],
        [HoursRemaining],
	    [InventoryPaymentMonth],
		[CalculationDate],
		[RegistrationDateTime],
		[CreatedDateTime],
		[UpdatedDateTime],
		[RecordingAuthorityId],
		3 -- Operation: Deleted
	FROM [BenefitsAccount].[Consumption]
	WHERE
		[ConsumptionIdentifier] = @ConsumptionIdentifier

	-- Delete the existing ConsumptionType.
	DELETE FROM [BenefitsAccount].[Consumption]
	WHERE
		[ConsumptionIdentifier] = @ConsumptionIdentifier
END
GO