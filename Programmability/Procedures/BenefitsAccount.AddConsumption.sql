SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[AddConsumption]
	@ConsumptionIdentifier UNIQUEIDENTIFIER,
	@CivilRegistrationIdentifier CHAR(10),
	@HoursConsumed NUMERIC(10,2),
    @HoursRemaining NUMERIC(10,2),
	@InventoryPaymentMonth CHAR(7),
	@CalculationDate DATETIME2,
	@RegistrationDateTime DATETIME2,
	@AuthorityTypeId SMALLINT,
	@AuthorityCode INT,
	@AuthorityName NVARCHAR(100),
	@CaseWorkerGivenName NVARCHAR(50),
	@CaseWorkerMiddleName NVARCHAR(40),
	@CaseWorkerSurname NVARCHAR(40),
	@CaseWorkerIdentifier NVARCHAR(64)
AS
BEGIN
	DECLARE @RecordingAuthorityId INT
	DECLARE @CreatedDateTime DATETIME2 = GETDATE()

	-- Solve the BenefitsGradingIdentifier for the given person.
	DECLARE @BenefitsGradingIdentifier AS UNIQUEIDENTIFIER = (SELECT [BenefitsGradingIdentifier] FROM [BenefitsAccount].[BenefitsGrading] WHERE [CivilRegistrationIdentifier] = @CivilRegistrationIdentifier)

	-- Solve the ConsumptionIdentifier for the given person if this exists.
	DECLARE @ExistingConsumptionIdentifier AS UNIQUEIDENTIFIER = (SELECT [ConsumptionIdentifier] FROM [BenefitsAccount].[Consumption] WHERE [BenefitsGradingIdentifier] = @BenefitsGradingIdentifier)
	
	IF @ExistingConsumptionIdentifier IS NOT NULL
	BEGIN
		-- Delete and make history for the existing ConsumptionType.
		EXEC [BenefitsAccount].[DeleteConsumption] @ConsumptionIdentifier = @ExistingConsumptionIdentifier
	END

	-- Solve the recording authority.
	DECLARE @RecordingAuthorityIds TABLE
	(
		Id INT
	)

	INSERT INTO @RecordingAuthorityIds (Id)
		EXEC dbo.DFDG_SaveResponsibleAuthority
			@AuthorityTypeId,
			@AuthorityCode,
			@AuthorityName,
			@CaseWorkerIdentifier,
			@CaseWorkerGivenName,
			@CaseWorkerMiddleName,
			@CaseWorkerSurname,
			NULL,
			NULL,
			@CreatedDateTime

	SET @RecordingAuthorityId = 
	(
		SELECT TOP(1) Id FROM @RecordingAuthorityIds
	)

	-- Create the ConsumptionType for a given person.
	INSERT INTO [BenefitsAccount].[Consumption] (
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
		[RecordingAuthorityId])
	VALUES (
		@ConsumptionIdentifier,
		@BenefitsGradingIdentifier,
		@CivilRegistrationIdentifier,
	    @HoursConsumed,
        @HoursRemaining,
	    @InventoryPaymentMonth,
		@CalculationDate,
		@RegistrationDateTime,
		@CreatedDateTime,
		@CreatedDateTime,
		@RecordingAuthorityId)
END
GO