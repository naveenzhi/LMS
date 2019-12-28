SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [LMS_Triopod_User].[PROCPATIENT]
	-- Add the parameters for the stored procedure here
	@PatientID int = null,
	@Title nvarchar(20) = null,
	@Name nvarchar(200) = null,
	@Email nvarchar(255) = null,
	@Mobile  nvarchar(10) = null,
	@Aadhar  nvarchar(12) = null,
	@Age int = null,
	@AgeType nvarchar(5) = null,
	@Sex nvarchar(6) = null,
	@State  nvarchar(100) = null,
	@City  nvarchar(100) = null,
	@Pincode  nvarchar(6) = null,
	@Address  nvarchar(150) = null,
	@LabID INT = null,
	@UserID int = null,
	@OUTPUTMESSAGE VARCHAR(100)  = NULL OUT,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	-- NEW PATIENT

	IF(@option = 1)
	BEGIN
	IF NOT EXISTS(SELECT MOBILE FROM [LMS_Triopod_User].[Lab_Patient] WHERE MOBILE = @MOBILE AND LabID = @LabID) 
	BEGIN 

	INSERT [LMS_Triopod_User].[Lab_Patient] VALUES (@Title,@Name,@Email,@Mobile,@Aadhar,@Age,@AgeType,@Sex,@State,@City,@Pincode,@Address,@LabID,@UserID,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
	SET @OUTPUTMESSAGE = 'SUCCESS,' + CAST(SCOPE_IDENTITY() AS NVARCHAR);

	END
	ELSE
	BEGIN
	SET @OUTPUTMESSAGE = 'DUPLICATE'
	END
	
	END

	--  Patient List
	IF(@option = 2)
	BEGIN
	SELECT * FROM [LMS_Triopod_User].[Lab_Patient] WHERE LabID = @LabID;
	END

	--Patient details by id
	IF(@option = 3)
	BEGIN
	SELECT * FROM [LMS_Triopod_User].[Lab_Patient] WHERE PatientID = @PatientID;
	END

	

END
GO