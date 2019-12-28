SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [LMS_Triopod_User].[PROCTEST]
	-- Add the parameters for the stored procedure here
	@TableClubTest TypeClubTest ReadOnly,
	@TestGroupId int = null,
	@TestGroupName nvarchar(700) = null,
	@SubGroupId nvarchar (200) = null,
	@TestID int = null,
	@TestName nvarchar(1200)= null,
	@Price int = null,
	@NormalRange nvarchar(1200) = null,
	@DefaultResult nvarchar(1200) = null,
	@IsClubTest bit = null,
	@Status bit NULL = null,
	@LabID int NULL = null,
	@IsClubofClub int = null,
	@ParentGroup_id int = null,
	@TestSortName nvarchar(100) = null,
	@OUTPUTMESSAGE VARCHAR(10)  = NULL OUT,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	-- Add TestGroup
	IF(@option = 1)
	BEGIN
	IF NOT EXISTS(SELECT NAME FROM [LMS_Triopod_User].[Lab_Test_Group] WHERE Name = @TestGroupName)
	BEGIN
	INSERT [LMS_Triopod_User].[Lab_Test_Group] VALUES (@TestGroupName,@SubGroupId,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
	END
	END

	--  Get TestGroup
	IF(@option = 2)
	BEGIN
	SELECT Name, TestGroupID FROM [LMS_Triopod_User].[Lab_Test_Group] WHERE STATUS = 1 AND Parent_ID = 0 ORDER BY Name ASC;
	END

	--  Get Test SubGroup
	IF(@option = 3)
	BEGIN
	SELECT Name, TestGroupID, Parent_ID FROM [LMS_Triopod_User].[Lab_Test_Group] WHERE STATUS = 1 AND Parent_ID = @TestGroupId ORDER BY Name ASC;
	END

	-- Add Test
	IF(@option = 4)
	BEGIN
	INSERT [LMS_Triopod_User].[Lab_Test_Mapping] VALUES (@TestName,@TestGroupId,@Price,@NormalRange,@DefaultResult,0,1,@LabID,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,@ParentGroup_id,@IsClubofClub,@TestSortName);
	END

	-- Add Club Test
	IF(@option = 5)
	BEGIN
	BEGIN TRAN

	BEGIN TRY
	INSERT [LMS_Triopod_User].[Lab_Test_Mapping] VALUES (@TestName,@TestGroupId,@Price,@NormalRange,null,1,1,@LabID,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,@ParentGroup_id,@IsClubofClub,@TestSortName);
	DECLARE @CLUBID INT;
	SET @CLUBID = scope_identity();
	INSERT INTO [LMS_Triopod_User].[Club_Test](ClubID,TestID,DisplayOrder, DateCreated, DateUpdated,subclubid) SELECT  @CLUBID, TestID,DisplayOrder,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,subclubid FROM @TableClubTest;
	
	COMMIT TRAN

	END TRY

	BEGIN CATCH

	ROLLBACK TRAN

	END CATCH
	END

	-- Get Test
	IF(@option = 6)
	BEGIN
	SELECT * from	[LMS_Triopod_User].[Lab_Test_Mapping] ltm
	INNER JOIN [LMS_Triopod_User].[Lab_Test_Group] ltg on ltm.testgroupid = ltg.TestGroupId
	Where LabID = @LabID ;
	END

	--Get Club TestID

	IF(@option = 7)
	BEGIN
	
	SELECT Test.TestID, Test.TestName,ClubTest.SubClubId,ClubTest.DisplayOrder from [LMS_Triopod_User].[Club_Test] ClubTest
	INNER JOIN [LMS_Triopod_User].[Lab_Test_Mapping]  Test on ClubTest.TestID = Test.TestID
	where ClubTest.ClubID = @TestID ;
	
	END

	-- UPDATE TEST

	IF(@option = 8)
	BEGIN
	UPDATE [LMS_Triopod_User].[Lab_Test_Mapping] SET TestName = @TestName, Price = @Price, NormalRange = @NormalRange, Status = @Status, DateUpdated = CURRENT_TIMESTAMP WHERE TestID = @TestID;
	END

	-- DELETE TEST

	IF(@option = 9)
	BEGIN
	DELETE FROM [LMS_Triopod_User].[Lab_Test_Mapping]  WHERE TestID = @TestID;
	DELETE FROM [LMS_Triopod_User].[Club_Test]  WHERE ClubID = @TestID;
	
	END
	
END
GO