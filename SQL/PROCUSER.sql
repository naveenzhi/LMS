SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [LMS_Triopod_User].[PROCUSER]
	-- Add the parameters for the stored procedure here
	@USERID INT = NULL,
	@CURRENTPASS NVARCHAR(15) = NULL,
	@NEWPASS NVARCHAR(15) = NULL,
	@OUTPUTMESSAGE VARCHAR(10)  = NULL OUT,
	@option int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	-- change password

	IF(@option = 1)
	BEGIN
	IF EXISTS(SELECT USERID FROM [LMS_Triopod_User].[Lab_Users] WHERE USERID = @USERID AND PASSWORD = @CURRENTPASS ) 
	BEGIN 
	UPDATE  [LMS_Triopod_User].[Lab_Users] SET PASSWORD = @NEWPASS WHERE USERID = @USERID;
	SET @OUTPUTMESSAGE = 'SUCCESS'
	END
	ELSE
	BEGIN
	SET @OUTPUTMESSAGE = 'INVALID'
	END
	END

END
