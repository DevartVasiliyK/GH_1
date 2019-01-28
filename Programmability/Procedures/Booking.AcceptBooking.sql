SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Booking].[AcceptBooking]
	@BookingIdentifier uniqueidentifier,
	@CivilRegistrationIdentifier char(10),
	@AcceptedBookingDate datetime,
	@EventDate datetime,
	@RequestUserID nvarchar(255),
	@RequestUserTypeID smallint,
	@RequestUserFullname nvarchar(140),
	@RequestUserEmail nvarchar(256),
	@RegistrationTime datetime,
	@ActiveAuthorityTypeId smallint,
	@ActiveAuthorityCode int,
	@AuthorityTypeId smallint,
	@AuthorityCode int
AS
BEGIN
	
	EXEC Booking.CopyBookingToHistory @BookingIdentifier, @CivilRegistrationIdentifier;
		
	-- Set the bookinginterview to accepted on behalf of the citizen via Jobnet.
	UPDATE Booking.tblBooking
		SET IsAcceptedBooking = 1,
		AcceptedBookingDate = @AcceptedBookingDate,
		EventDate = @EventDate,
		RequestUserID = @RequestUserID,
		RequestUserTypeID = @RequestUserTypeID,
		RequestUserFullname = @RequestUserFullname,
		RequestUserEmail = @RequestUserEmail,
		RegistrationDate = @RegistrationTime,
		ActiveAuthorityTypeId = @ActiveAuthorityTypeId,
		ActiveAuthorityCode = @ActiveAuthorityCode,
		AuthorityTypeId = @AuthorityTypeId,
		AuthorityCode = @AuthorityCode
	WHERE
		BookingIdentifier = @BookingIdentifier AND
		CivilRegistrationIdentifier = @CivilRegistrationIdentifier
		
	--Return the newly updated booing as result
	EXEC [Booking].[GetBookingByBookingIdentifier] @BookingIdentifier
	--SELECT  
	--	a.BookingIdentifier, 
	--	a.IsAcceptedBooking,
	--	a.IsRebookingPossible,
	--	a.RebookingDeadline,
	--	a.IsCancellationPossible,
	--	a.CancellationDeadline,
	--	a.BookingStartTime,
	--	a.BookingEndTime,
	--	a.MeetingTitle,
	--	a.MeetingDescription,
	--	a.InterviewType,
	--	a.InterviewContactType,
	--	a.InterviewFormType,
	--	a.SupervisorGivenName,
	--	a.SupervisorMiddleName,
	--	a.SupervisorSurname,
	--	a.SupervisorIdentifier,
	--	a.GroupBookingIdentifier,
 --       a.AcceptedBookingDate,
 --       a.RegistrationDate,
	--	a.CancellationCauseType,
	--	b.InterviewLocationDescription,
	--	b.StreetName,
	--	b.StreetBuildingIdentifier,
	--	b.FloorIdentifier,
	--	b.SuiteIdentifier,
	--	b.PostCodeIdentifier,
	--	b.DistrictName,
	--	b.DistrictSubDivisionIdentifier,
	--	b.CountryIdentificationCode,
	--	c.TelephoneNumberIdentifier[PhoneNumber],
	--	c.ShouldCitizenCall,
	--	c.DigitalContactIdentifier,
	--	a.ShowCaseWorker,
	--	a.IsSelfBooked,
	--	a.IsInterviewUnemploymentFundParticipation, 
	--	a.IsInterviewWithMoreAuthorities	
	--FROM	
	--	Booking.tblBooking AS a 
	--	LEFT JOIN Booking.tblLocationDetail AS b ON
	--	(
	--		a.InterviewLocationDetailIdentifier = b.InterviewLocationDetailIdentifier 
	--	)
	--	LEFT JOIN Booking.tblContactInformationDetail c ON
	--	(
	--		c.InterviewContactInformationDetailIdentifier = a.InterviewContactInformationDetailIdentifier
	--	)
	--WHERE  
	--	a.BookingIdentifier = @BookingIdentifier
	
END
GO