SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [LMS_Triopod_User].[PROCSETTING]
	-- Add the parameters for the stored procedure here
	@LabID int = NULL,
	@Header nvarchar(max) = NULL,
	@Footer nvarchar(max) = NULL,
	@IsEnabeled bit = NULL,
	@OUTPUTMESSAGE VARCHAR(10)  = NULL OUT,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	-- Add
	IF(@option = 1)
	BEGIN
	IF NOT EXISTS(SELECT LabID FROM [LMS_Triopod_User].[Lab_Settings] WHERE LabID = @LabID)
	BEGIN
	INSERT [LMS_Triopod_User].[Lab_Settings] VALUES (@LabID,@Header,@Footer,@IsEnabeled,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
	END
	ELSE 
	BEGIN
	UPDATE [LMS_Triopod_User].[Lab_Settings] SET Header = @Header, Footer = @Footer, IsEnabeled = @IsEnabeled, DateUpdated = CURRENT_TIMESTAMP WHERE LABID = @LabID;
	END
	END

	--  Get Setting
	IF(@option = 2)
	BEGIN
	SELECT * FROM [LMS_Triopod_User].[Lab_Settings] WHERE LabID = @LabID;
	END
	
END
GO