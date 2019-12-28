SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [LMS_Triopod_User].[PROCLAB]
	-- Add the parameters for the stored procedure here
	@UserName nvarchar(20) = null,
	@Password nvarchar(15) = null,
	@LabName nvarchar(200) = null,
	@OwnerName nvarchar(200) = null,
	@Mobile  nvarchar(10) = null,
	@Phone  nvarchar(12) = null,
	@Email nvarchar(255) = null,
	@State  nvarchar(100) = null,
	@City  nvarchar(100) = null,
	@Pincode  nvarchar(6) = null,
	@Address  nvarchar(150) = null,
	@SubscriptionValidTo datetime = null,
	@LogoUrl nvarchar(1200) = NULL,
	@status bit = null,
    @Website nvarchar(1200) = NULL,
	@LabID int = null,
	@OUTPUTMESSAGE VARCHAR(100)  = NULL OUT,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	-- NEW LAB

	IF(@option = 1)
	BEGIN
	IF NOT EXISTS(SELECT Username FROM [LMS_Triopod_User].[Lab_Users] WHERE Username = @UserName) 
	BEGIN 

	BEGIN TRAN 
	BEGIN TRY 

	INSERT [LMS_Triopod_User].[Labs] VALUES (@LabName, NULL, @OwnerName, @Mobile, @Email, @Phone, @State, @City, @Pincode, @Address, null, @SubscriptionValidTo, @LogoUrl, @Website, 1, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
	
	DECLARE @GENLABID INT;
	SET @GENLABID = scope_identity();

	INSERT [LMS_Triopod_User].[Lab_Users] VALUES (@UserName, @Password, @OwnerName, @Mobile, @Email, 1, 2, @GENLABID, '/Uploaded/images/user/useravtar.png', CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
	COMMIT TRAN
	SET @OUTPUTMESSAGE = 'SUCCESS,' + CAST(@GENLABID AS NVARCHAR);
	
	END TRY 
		
	BEGIN CATCH
	SET @OUTPUTMESSAGE = 'ERROR'
	ROLLBACK TRAN
	END catch 

	END
	ELSE
	BEGIN
	SET @OUTPUTMESSAGE = 'DUPLICATE'
	END
	END

	-- LAB LIST

	IF(@option = 2)
	BEGIN
	SELECT * FROM [LMS_Triopod_User].[Labs] ORDER BY DateCreated DESC;
	END
	
	-- UPDATE LAB

	IF(@option = 3)
	BEGIN
	IF EXISTS(SELECT LabID FROM [LMS_Triopod_User].[Labs] WHERE LabID = @LabID ) 
	BEGIN 
	UPDATE [LMS_Triopod_User].[Labs] SET LabName = @LabName, OwnerName = @OwnerName, Mobile = @Mobile, Email = @Email, SecondaryPhone = @Phone, State = @State, City = @City, PinCode = @Pincode, Address = @Address, SubscriptionValidTo = @SubscriptionValidTo, LogoUrl = @LogoUrl, Website = @Website, Status = @status, DateUpdated = CURRENT_TIMESTAMP WHERE LabID = @LabID;
	SET @OUTPUTMESSAGE = 'SUCCESS'
	END
	ELSE
	BEGIN
	SET @OUTPUTMESSAGE = 'ERROR'
	END
	END

END
GO