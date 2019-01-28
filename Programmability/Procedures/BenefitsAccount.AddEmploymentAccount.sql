SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [BenefitsAccount].[AddEmploymentAccount]
	@EmploymentAccountIdentifier UNIQUEIDENTIFIER,
	@CivilRegistrationIdentifier CHAR(10),
	@EmploymentHours NUMERIC(10,2),
	@ExpectedObsoleteDate DATETIME2,
	@AccountOpeningDate DATETIME2,
	@PotentialProlongationBenefitHours NUMERIC(10,2),
	@LatentProlongedBenefitsPeriod DATETIME2,
	@HoursConsumed NUMERIC(10,2),
	@LatestEmployerReportUsed DATETIME2,
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

	-- Solve the EmploymentAccountIdentifier for the given person if this exists.
	DECLARE @ExistingEmploymentAccountIdentifier AS UNIQUEIDENTIFIER = (SELECT [EmploymentAccountIdentifier] FROM [BenefitsAccount].[EmploymentAccount] WHERE [BenefitsGradingIdentifier] = @BenefitsGradingIdentifier)
	
	IF @ExistingEmploymentAccountIdentifier IS NOT NULL
	BEGIN
		-- Delete and make history for the existing EmploymentAccount.
		EXEC [BenefitsAccount].[DeleteEmploymentAccount] @EmploymentAccountIdentifier = @ExistingEmploymentAccountIdentifier
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
	
	INSERT INTO [BrokerServices_T216527].[BenefitsAccount].[EmploymentAccount]
           ([EmploymentAccountIdentifier]
           ,[BenefitsGradingIdentifier]
           ,[CivilRegistrationIdentifier]
           ,[EmploymentHours]
           ,[ExpectedObsoleteDate]
           ,[AccountOpeningDate]
           ,[PotentialProlongationBenefitHours]
           ,[LatentProlongedBenefitsPeriod]
           ,[HoursConsumed]
           ,[LatestEmployerReportUsed]
           ,[RegisterInformationTime]
           ,[CalculationDate]
           ,[RegistrationDateTime]
           ,[CreatedDateTime]
           ,[UpdatedDateTime]
           ,[RecordingAuthorityId])
     VALUES
           (@EmploymentAccountIdentifier,
            @BenefitsGradingIdentifier,
			@CivilRegistrationIdentifier,
			@EmploymentHours,
			@ExpectedObsoleteDate,
			@AccountOpeningDate,
			@PotentialProlongationBenefitHours,
			@LatentProlongedBenefitsPeriod,
			@HoursConsumed,
			@LatestEmployerReportUsed,
			@RegisterInformationTime,
			@CalculationDate,
			@RegistrationDateTime,
			@CreatedDateTime,
			@CreatedDateTime,
			@RecordingAuthorityId)
	
END
GO