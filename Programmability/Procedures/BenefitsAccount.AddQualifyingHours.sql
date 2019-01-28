SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[AddQualifyingHours]
	@QualifyingHoursIdentifier UNIQUEIDENTIFIER,
	@CivilRegistrationIdentifier CHAR(10),
	@QualifyingHoursMissing NUMERIC(10,2),
	@EmploymentHours NUMERIC(10,2),
	@PeriodStartDate DATETIME2,
	@PeriodEndDate DATETIME2,
	@QualifyingHoursPeriodNumber INT,
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

	-- Solve the QualifyingHoursIdentifier for the given person if this exists.
	DECLARE @ExistingQualifyingHoursIdentifier AS UNIQUEIDENTIFIER = (SELECT [QualifyingHoursIdentifier] FROM [BenefitsAccount].[QualifyingHours] WHERE [BenefitsGradingIdentifier] = @BenefitsGradingIdentifier)
	
	IF @ExistingQualifyingHoursIdentifier IS NOT NULL
	BEGIN
		-- Delete and make history for the existing QualifyingHoursType.
		EXEC [BenefitsAccount].[DeleteQualifyingHours] @QualifyingHoursIdentifier = @ExistingQualifyingHoursIdentifier
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

	-- Create the QualifyingHoursType for a given person.
	INSERT INTO [BenefitsAccount].[QualifyingHours] (
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
		[RecordingAuthorityId])
	VALUES (
		@QualifyingHoursIdentifier,
		@BenefitsGradingIdentifier,
		@CivilRegistrationIdentifier,
		@QualifyingHoursMissing,
		@EmploymentHours,
		@PeriodStartDate,
		@PeriodEndDate,
		@QualifyingHoursPeriodNumber,
		@CalculationDate,
		@RegistrationDateTime,
		@CreatedDateTime,
		@CreatedDateTime,
		@RecordingAuthorityId)
END
GO