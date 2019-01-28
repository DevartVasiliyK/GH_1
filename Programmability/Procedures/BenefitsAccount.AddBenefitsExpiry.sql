SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[AddBenefitsExpiry]
	@BenefitsExpiryIdentifier UNIQUEIDENTIFIER,
	@CivilRegistrationIdentifier CHAR(10),
	@BenefitsExpiryDate DATETIME2,
	@BenefitsExpiryCause TINYINT,
	@BenefitsExpiryActualOrExpected TINYINT,
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

	-- Solve the BenefitsExpiryIdentifier for the given person if this exists.
	DECLARE @ExistingBenefitsExpiryIdentifier AS UNIQUEIDENTIFIER = (SELECT [BenefitsExpiryIdentifier] FROM [BenefitsAccount].[BenefitsExpiry] WHERE [BenefitsGradingIdentifier] = @BenefitsGradingIdentifier)
	
	IF @ExistingBenefitsExpiryIdentifier IS NOT NULL
	BEGIN
		-- Delete and make history for the existing BenefitsExpiryType.
		EXEC [BenefitsAccount].[DeleteBenefitsExpiry] @BenefitsExpiryIdentifier = @ExistingBenefitsExpiryIdentifier
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

	-- Create the BenefitsExpiryType for a given person.
	INSERT INTO [BenefitsAccount].[BenefitsExpiry] (
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
		[RecordingAuthorityId])
	VALUES (
		@BenefitsExpiryIdentifier,
		@BenefitsGradingIdentifier,
		@CivilRegistrationIdentifier,
		@BenefitsExpiryDate,
		@BenefitsExpiryCause,
		@BenefitsExpiryActualOrExpected,
		@RegisterInformationTime,
		@CalculationDate,
		@RegistrationDateTime,
		@CreatedDateTime,
		@CreatedDateTime,
		@RecordingAuthorityId)
END
GO