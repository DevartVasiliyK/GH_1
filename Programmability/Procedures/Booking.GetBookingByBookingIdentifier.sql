SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Booking].[GetBookingByBookingIdentifier]
	@BookingIdentifier uniqueidentifier
AS
BEGIN 
	--ClientInterview
	SELECT  
		a.BookingIdentifier, 
		a.CivilregistrationIdentifier[CivilRegistrationIdentifier],
		a.IsAcceptedBooking,
		a.IsRebookingPossible,
		a.RebookingDeadline,
		a.IsCancellationPossible,
		a.CancellationDeadline,
		a.BookingStartTime,
		a.BookingEndTime,
		a.MeetingTitle,
		a.MeetingDescription,
		a.InterviewType,
		a.InterviewContactType,
		a.InterviewFormType,
		a.SupervisorGivenName,
		a.SupervisorMiddleName,
		a.SupervisorSurname,
		a.SupervisorIdentifier,
		a.GroupBookingIdentifier,
        a.AcceptedBookingDate,
        a.RegistrationDate,
		b.LocationDescription,
		b.StreetName,
		b.StreetBuildingIdentifier,
		b.FloorIdentifier,
		b.SuiteIdentifier,
		b.PostCodeIdentifier,
		b.DistrictName,
		b.DistrictSubDivisionIdentifier,
		b.MailDeliverySublocationIdentifier,
		b.PostOfficeBoxIdentifier AS PostOfficeBoxIdentifierType,
		b.StreetNameForAddressingName,
		b.CountryIdentificationCode,
		c.TelephoneNumberIdentifier[PhoneNumber],
		c.ShouldCitizenCall,
		c.DigitalContactIdentifier,
		a.ShowCaseWorker,
		a.IsSelfBooked,
		a.LetterVariantTypeIdentifier,
		a.PrintComment,
		a.CorrectionComment,
		a.IsInterviewUnemploymentFundParticipation, 
		a.IsInterviewWithMoreAuthorities	
	FROM	
		Booking.tblBooking AS a 
		LEFT JOIN Booking.tblLocationDetail AS b ON
		(
			a.LocationDetailIdentifier = b.LocationDetailIdentifier 
		)
		LEFT JOIN Booking.tblContactDetail c ON
		(
			c.ContactDetailIdentifier = a.ContactDetailIdentifier
		)
	WHERE  
		a.BookingIdentifier = @BookingIdentifier
	
	IF (@@ROWCOUNT = 0)
	BEGIN
		-- 4768: The submitted BookingIdentifier is unknown to the system
		raiserror(54768,16,1)
	END	
END
GO