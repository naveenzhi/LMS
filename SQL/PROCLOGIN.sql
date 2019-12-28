SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [LMS_Triopod_User].[PROCLOGIN]
	-- Add the parameters for the stored procedure here
	@Username nvarchar(20) = NULL,
	@Password nvarchar(15) = NULL,
	@UserRole int = NULL,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	-- Lab Login Validation

	IF(@option = 1)
		BEGIN
		SELECT Labs.LabID, Labs.LabName, Labs.SubscriptionValidTo, Labs.LogoUrl, LabUsr.UserId, LabUsr.Name, LabUsr.UserRole, LabUsr.UserImg from [LMS_Triopod_User].[Labs] Labs
		INNER JOIN [LMS_Triopod_User].[Lab_Users] LabUsr ON Labs.LabID = LabUsr.LabID
		WHERE LabUsr.Username = @Username AND LabUsr.Password = @Password AND LabUsr.UserRole = @UserRole AND LabUsr.Status = 1 AND  Labs.Status = 1;
	END

	-- Admin Login

	IF(@option = 2)
		BEGIN
		SELECT * FROM [LMS_Triopod_User].[Admin] WHERE Username = @Username AND Password = @Password;

	END

END
GO