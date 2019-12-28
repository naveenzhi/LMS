SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE [LMS_Triopod_User].[PROCBINDPAGE]
	-- Add the parameters for the stored procedure here
	@LabID int = NULL,
	@PatientID int =NULL,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET DATEFIRST 1 -- Define beginning of week as Monday
    
	-- Insert statements for procedure here
	
	-- BIND LAB DASHBOARD

	IF(@option = 1)
	BEGIN
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Lab_Patient] where LabID = @LabID; --Registered Patients
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Lab_Patient_Test_Order]  where  LabID = @LabID  and cast(DateCreated as Date) = cast(getdate() as Date); --Today's Test
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Lab_Patient_Test_Order]  where  LabID = @LabID and cast(DateCreated as Date) > cast(getdate() as Date); --Today's Appointments
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Lab_Patient_Test_Order]  where  LabID = @LabID and DateCreated >= dateadd(day,datediff(day,1,GETDATE()),0) AND DateCreated < dateadd(day,datediff(day,0,GETDATE()),0) --Yesterday's Test
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Lab_Patient_Test_Order]  where  LabID= @LabID AND DateCreated >= dateadd(day, 1-datepart(dw, getdate()), CONVERT(date,getdate())) AND DateCreated <  dateadd(day, 8-datepart(dw, getdate()), CONVERT(date,getdate())) --Test this week from Mon to current day
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Lab_Patient_Test_Order]  where  LabID= @LabID AND datepart(mm,DateCreated) =month(getdate()) and datepart(yyyy,DateCreated) =year(getdate()) --Total test in the current month
	
	END

	-- BIND LAB NEW ORDER PAGE

	IF(@option = 2)
	BEGIN

	SELECT PatientID, CONCAT(Name, ' - ', Mobile) as PatientName FROM [LMS_Triopod_User].[Lab_Patient] WHERE LabID = @LabID;
	
	SELECT (name + ' - ' + degree) as name FROM [LMS_Triopod_User].[Doctors] doctor 
	inner join [LMS_Triopod_User].[Labs] lab on doctor.city = lab.City Where lab.LabID = @LabID;

	SELECT * from	[LMS_Triopod_User].[Lab_Test_Mapping] Where Price <> 0 AND LabID = @LabID AND Status = 1  ;

	SELECT (name + ' - ' + ccode) as name FROM [LMS_Triopod_User].[TestCenter] Where LabID = @LabID ;
	
	END

	-- BIND ADMIN DASHBOARD

	IF(@option = 3)
	BEGIN
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Labs];
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Labs]  where  status = 1;
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Labs]  where  status = 0;
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Labs] where cast(DateCreated as Date) = cast(getdate() as Date); --Today's Lab
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Labs]  where DateCreated >= dateadd(day,datediff(day,1,GETDATE()),0) AND DateCreated < dateadd(day,datediff(day,0,GETDATE()),0) --Yesterday's Lab
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Labs]  where  DateCreated >= dateadd(day, 1-datepart(dw, getdate()), CONVERT(date,getdate())) AND DateCreated <  dateadd(day, 8-datepart(dw, getdate()), CONVERT(date,getdate())) --Lab this week from Mon to current day
	SELECT COUNT(*) FROM [LMS_Triopod_User].[Labs]  where  datepart(mm,DateCreated) =month(getdate()) and datepart(yyyy,DateCreated) =year(getdate()) --Total Lab in the current month
	
	END

END
GO