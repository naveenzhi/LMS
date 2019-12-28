SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [LMS_Triopod_User].[PRORESULT]
	-- Add the parameters for the stored procedure here
	@TableResult TYPERESULT ReadOnly,
	@TableUpdateResult TYPEUPDATERESULT ReadOnly,
	@LabID int = null ,
	@ReportID int = null ,
	@OrderID int = null ,
	@TestID int = null,
	@TestName nvarchar(2000) = null ,
	@Result nvarchar(3200) = null ,
	@ReportNotes nvarchar(max) = NULL,
	@OUTPUTMESSAGE NVARCHAR(1000)  = NULL OUT,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	
	IF( @option = 1) 

    BEGIN 
		
	BEGIN TRAN 
	BEGIN TRY 

    INSERT INTO [LMS_Triopod_User].[Lab_Patient_Test_Report]

    (OrderID, TestID, TestName, Result, DateCreated, DateUpdated) 
		 
	SELECT OrderID,TestID, TestName, Result, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP FROM @TableResult;

	UPDATE [LMS_Triopod_User].[Lab_Patient_Test_Order] SET Status = 1, DateUpdated = CURRENT_TIMESTAMP WHERE OrderID = @OrderID;


	UPDATE [LMS_Triopod_User].[Lab_Patient_Test_Mapping] 
	SET IsReportGenerated = 1, DateUpdated = CURRENT_TIMESTAMP  
    FROM [LMS_Triopod_User].[Lab_Patient_Test_Mapping] INNER JOIN @TableResult AS TestResult
    ON [LMS_Triopod_User].[Lab_Patient_Test_Mapping].TestID = TestResult.TestID and [LMS_Triopod_User].[Lab_Patient_Test_Mapping].OrderID = TestResult.OrderID;

	INSERT [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] VALUES (@OrderID, @ReportNotes, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
	
	COMMIT TRAN
	SET @OUTPUTMESSAGE = 'SUCCESS';
	END TRY 
		
	BEGIN CATCH
	ROLLBACK TRAN
	SET @OUTPUTMESSAGE = 'ERROR';
	END catch 

    END 

	-- Get Test Result By OrderId

	IF(@option = 2)
	BEGIN 

	SELECT TESTREPORT.reportid, TESTREPORT.orderid, TESTREPORT.testname, TESTREPORT.result FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] ORDERTEST
    INNER JOIN [LMS_Triopod_User].[Lab_Patient_Test_Report] TESTREPORT ON ORDERTEST.orderid = TESTREPORT.orderid 
    WHERE ORDERTEST.orderid = @OrderID AND ORDERTEST.labid = @LabID;
	
	END

	-- UPdate Test Result

	IF(@option = 3)
	BEGIN 

	
	UPDATE [LMS_Triopod_User].[Lab_Patient_Test_Report]
    SET [Lab_Patient_Test_Report].Result = NewResult.Result,
	DateUpdated = CURRENT_TIMESTAMP
    FROM [LMS_Triopod_User].[Lab_Patient_Test_Report] INNER JOIN @TableUpdateResult AS NewResult
    ON [LMS_Triopod_User].[Lab_Patient_Test_Report].ReportID = NewResult.ReportID;  

	END

END
GO