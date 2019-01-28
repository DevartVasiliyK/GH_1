SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[AddQualifyingHoursReport]
	@QualifyingHoursReportIdentifier UNIQUEIDENTIFIER,
	@CivilRegistrationIdentifier CHAR(10),
	@DecisionDate DATETIME2,
	@QualifyingHoursWithdrawalAmount NUMERIC (10,2),
	@ExecutionMonth CHAR(7),
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

	-- Solve the QualifyingHoursReportIdentifier for the given person if this exists.
	DECLARE @ExistingQualifyingHoursReportIdentifier AS UNIQUEIDENTIFIER = (SELECT [QualifyingHoursReportIdentifier] FROM [BenefitsAccount].[QualifyingHoursReport] WHERE [BenefitsGradingIdentifier] = @BenefitsGradingIdentifier)
	
	IF @ExistingQualifyingHoursReportIdentifier IS NOT NULL
	BEGIN
		-- Delete and make history for the existing QualifyingHoursReportType.
		EXEC [BenefitsAccount].[DeleteQualifyingHoursReport] @QualifyingHoursReportIdentifier = @ExistingQualifyingHoursReportIdentifier
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

	-- Create the QualifyingHoursReportType for a given person.
	INSERT INTO [BenefitsAccount].[QualifyingHoursReport] (
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
		[RecordingAuthorityId])
	VALUES (
		@QualifyingHoursReportIdentifier,
		@BenefitsGradingIdentifier,
		@CivilRegistrationIdentifier,
		@DecisionDate,
		@QualifyingHoursWithdrawalAmount,
		@ExecutionMonth,
		@QualifyingHoursPeriodNumber,
		@CalculationDate,
		@RegistrationDateTime,
		@CreatedDateTime,
		@CreatedDateTime,
		@RecordingAuthorityId)
END
GO