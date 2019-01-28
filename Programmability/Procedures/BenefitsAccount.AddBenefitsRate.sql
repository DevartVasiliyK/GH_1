SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[AddBenefitsRate]
	@BenefitsRateIdentifier UNIQUEIDENTIFIER,
	@CivilRegistrationIdentifier CHAR(10),
	@RatePerMonth NUMERIC(10,2),
	@RatePerHour NUMERIC(10,2),
	@RateValidFrom DATETIME2,
	@RateBasis TINYINT,
	@RegisterInformationTime DATETIME2,
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

	-- Solve the BenefitsRateIdentifier for the given person if this exists.
	DECLARE @ExistingBenefitsRateIdentifier AS UNIQUEIDENTIFIER = (SELECT [BenefitsRateIdentifier] FROM [BenefitsAccount].[BenefitsRate] WHERE [BenefitsGradingIdentifier] = @BenefitsGradingIdentifier)
	
	IF @ExistingBenefitsRateIdentifier IS NOT NULL
	BEGIN
		-- Delete and make history for the existing BenefitsRateType.
		EXEC [BenefitsAccount].[DeleteBenefitsRate] @BenefitsRateIdentifier = @ExistingBenefitsRateIdentifier
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

	-- Create the BenefitsRateType for a given person.
	INSERT INTO [BenefitsAccount].[BenefitsRate] (
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
		[RecordingAuthorityId])
	VALUES (
		@BenefitsRateIdentifier,
		@BenefitsGradingIdentifier,
		@CivilRegistrationIdentifier,
		@RatePerMonth,
		@RatePerHour,
		@RateValidFrom,
		@RateBasis,
		@RegisterInformationTime,
		@CalculationDate,
		@RegistrationDateTime,
		@CreatedDateTime,
		@CreatedDateTime,
		@RecordingAuthorityId)
END
GO