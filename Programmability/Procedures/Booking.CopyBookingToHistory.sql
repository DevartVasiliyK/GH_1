SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Booking].[CopyBookingToHistory]
	@BookingIdentifier uniqueidentifier,
	@CivilRegistrationIdentifier char(10)
AS
BEGIN
	
	-- Make historic entry to capture the as is view of data for the booking interview.
	INSERT INTO Booking.tblBookingHistory
	(
		BookingIdentifier, CivilRegistrationIdentifier, 
		BookingStartTime, InterviewContactType, InterviewType, 
		LocationDetailIdentifier, 
		ContactDetailIdentifier, 
		CorrectionComment, IsDeleted, RegistrationDate, EventDate, AuthorityTypeId, 
		AuthorityCode, GroupBookingIdentifier, RebookingDeadline, IsRebookingPossible, 
		BookingEndTime, InterviewFormType, SupervisorGivenName, SupervisorMiddleName, SupervisorSurname, 
		SupervisorIdentifier, PrintComment, AppendixIdentifier,
		CancellationCauseType, IsAcceptedBooking, IsCancellationPossible, CancellationDeadline, 
		MeetingTitle, ShowCaseWorker, MeetingDescription, AcceptedBookingDate, IsCompulsoryAttendance, 
		IsSelfBooked, IsInterviewUnemploymentFundParticipation, IsInterviewWithMoreAuthorities,
		RequestUserID, RequestUserTypeID, RequestUserFullname, RequestUserEmail, ActiveAuthorityTypeId, ActiveAuthorityCode	
	)
	SELECT
		BookingIdentifier, CivilRegistrationIdentifier, 
		BookingStartTime, InterviewContactType, InterviewType, 
		LocationDetailIdentifier, 
		ContactDetailIdentifier,
		CorrectionComment, 0, RegistrationDate, EventDate, AuthorityTypeId, 
		AuthorityCode, GroupBookingIdentifier, RebookingDeadline, IsRebookingPossible, 
		BookingEndTime, InterviewFormType, SupervisorGivenName, SupervisorMiddleName, SupervisorSurname, 
		SupervisorIdentifier, PrintComment, AppendixIdentifier, 
		CancellationCauseType, IsAcceptedBooking, IsCancellationPossible, CancellationDeadline, 
		MeetingTitle, ShowCaseWorker, MeetingDescription, AcceptedBookingDate, IsCompulsoryAttendance, 
		IsSelfBooked, IsInterviewUnemploymentFundParticipation, IsInterviewWithMoreAuthorities,
		RequestUserID, RequestUserTypeID, RequestUserFullname, RequestUserEmail, ActiveAuthorityTypeId, ActiveAuthorityCode
	FROM
		Booking.tblBooking
	WHERE
		BookingIdentifier = @BookingIdentifier AND
		CivilRegistrationIdentifier = @CivilRegistrationIdentifier
	
	IF (@@ROWCOUNT = 0)
	BEGIN
		-- 4768: The submitted BookingIdentifier is unknown to the system
		raiserror(54768,16,1)
	END	
END
GO