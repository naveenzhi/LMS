SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [LMS_Triopod_User].[PROCORDER]
	-- Add the parameters for the stored procedure here
	@TableOrderTest TYPEORDEREDTEST ReadOnly,
	@TableOrderClubTest TYPEORDEREDCLUBTEST ReadOnly,
	@OrderID int = null,
	@PatientID int = null,
	@LabID int = null,
	@ReferredBy nvarchar(200) = null,
	@ReferredTo nvarchar(1200) = null,
	@Amount money = null,
	@Paid money = null,
	@dues money = null,
	@Status int = null,
	@Discount money = null,
	@IsReportGenerated bit = null,
	@OUTPUTMESSAGE NVARCHAR(1000)  = NULL OUT,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	

	-- New Order
	IF( @option = 2 ) 

    BEGIN 
		
	BEGIN TRAN 
	BEGIN TRY 

	INSERT [LMS_Triopod_User].[Lab_Patient_Test_Order] 
	VALUES (@PatientID,@LabID,@ReferredBy,@Amount,@Paid,@dues,0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,@ReferredTo,@Discount); 

	DECLARE @GENORDERID INT;
	SET @GENORDERID = scope_identity();

    INSERT INTO [LMS_Triopod_User].[Lab_Patient_Test_Mapping] 
	(orderid, testid, testname, testprice, IsReportGenerated, datecreated, dateupdated) 
		
	SELECT @GENORDERID, TestID, TestName, TestPrice, 0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP FROM @TableOrderTest; 

    INSERT INTO [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] 

    (orderid, clubtestid, clubtestname, clubtestprice, datecreated, dateupdated) 
		 
	SELECT @GENORDERID,ClubTestID, ClubTestName, ClubTestPrice, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP FROM @TableOrderClubTest;
	COMMIT TRAN
	SET @OUTPUTMESSAGE = 'SUCCESS,' + CAST(@GENORDERID AS NVARCHAR);
	END TRY 
		
	BEGIN CATCH
	ROLLBACK TRAN
	END catch 

    END 

	-- GET ORDER

	IF( @option = 3 ) 

    BEGIN 
	SELECT * FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] Orders
	INNER JOIN [LMS_Triopod_User].[Lab_Order_Status] OrderStatus on Orders.Status = OrderStatus.StatusId
	WHERE Orders.LabID = @LabID ORDER BY Orders.DateCreated DESC;
	END

	--  Report Not Generated ORDER

	IF( @option = 4 ) 

    BEGIN 
	SELECT Orders.OrderID, Patient.PatientID, Patient.Name as PatientName, Patient.Mobile, Orders.DateCreated FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] Orders
	INNER JOIN [LMS_Triopod_User].[Lab_Patient] Patient on Orders.PatientID = Patient.PatientID
	WHERE Orders.LabID = @LabID AND Orders.Status = 0 ORDER BY DateCreated desc;

	SELECT LPTM.orderid, LPTM.testprice, LPTM.testname, LPTM.IsReportGenerated, LPTO.DateCreated FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] LPTO
	
	INNER JOIN [LMS_Triopod_User].[lab_patient_test_mapping] LPTM ON LPTO.OrderID = LPTM.OrderID

    INNER JOIN [LMS_Triopod_User].[Lab_Test_Mapping] LTM  ON LPTM.testid = LTM.testid 

    WHERE  LPTO.LabID = @LabID and LPTM.testprice <> 0

    UNION 

    SELECT DISTINCT LPTM.orderid, OClubTestMap.clubtestprice AS TestPrice, 

    OClubTestMap.clubtestname  AS TestName,LPTM.IsReportGenerated, LPTO.DateCreated FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] LPTO
	
	INNER JOIN [LMS_Triopod_User].[lab_patient_test_mapping] LPTM ON LPTO.OrderID = LPTM.OrderID 

    INNER JOIN [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping]  OClubTestMap ON OClubTestMap.orderid = LPTM.orderid 

    WHERE  LPTO.LabID = @LabID  order by LPTO.DateCreated desc; 
	

	SELECT Orders.OrderID, Orders.DateCreated, OrderTest.TestID, OrderTest.IsReportGenerated, LabTest.TestName, LabTest.DefaultResult, LabTest.IsClubTest, LabTest.Normalrange FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] Orders
	INNER JOIN [LMS_Triopod_User].[Lab_Patient_Test_Mapping] OrderTest on Orders.OrderID = OrderTest.OrderID
	INNER JOIN [LMS_Triopod_User].[Lab_Test_Mapping] LabTest on OrderTest.TestID = LabTest.TestID
	WHERE Orders.LabID = @LabID AND Orders.Status = 0 ORDER BY Orders.DateCreated DESC;
	
	END 

	--  Generate Invoice

	IF( @option = 5 ) 

    BEGIN 

	SELECT Orders.OrderID, Orders.DateCreated, LabSetting.Header, LabSetting.Footer, LabSetting.IsEnabeled, (Orders.Amount - Orders.Discount) as Amount, Orders.Discount, Orders.ReferredBy, Orders.ReferredTo, CONCAT(Patient.Title, '. ', Patient.Name) as PatientName, Patient.Mobile, Patient.Email, CONCAT(Patient.Age, ' ', Patient.AgeType) AS AGE, CONCAT(Patient.Address, ', ', Patient.City, ', ', Patient.State,' - ', Patient.Pincode) AS ADDRESS FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] Orders
	INNER JOIN [LMS_Triopod_User].[Lab_Patient] Patient on Orders.PatientID = Patient.PatientID
	LEFT JOIN [LMS_Triopod_User].[Lab_Settings] LabSetting ON Orders.LabID = LabSetting.LabID
	WHERE Orders.LabID = @LabID AND Orders.OrderID = @OrderID;

	SELECT LPTM.testprice, LPTM.testname FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] LPTO
	
	INNER JOIN [LMS_Triopod_User].[lab_patient_test_mapping] LPTM ON LPTO.OrderID = LPTM.OrderID

    INNER JOIN [LMS_Triopod_User].[Lab_Test_Mapping] LTM  ON LPTM.testid = LTM.testid 

    WHERE  LPTO.LabID = @LabID and LPTM.testprice <> 0 and LPTO.OrderID = @OrderID

    UNION 

    SELECT DISTINCT OClubTestMap.clubtestprice AS TestPrice, OClubTestMap.clubtestname  AS TestName FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] LPTO
	
	INNER JOIN [LMS_Triopod_User].[lab_patient_test_mapping] LPTM ON LPTO.OrderID = LPTM.OrderID 

    INNER JOIN [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping]  OClubTestMap ON OClubTestMap.orderid = LPTM.orderid 

    WHERE  LPTO.LabID = @LabID and LPTO.OrderID = @OrderID ; 

	END

	--  Report Generated ORDER

	IF( @option = 6 ) 

    BEGIN 
	SELECT Orders.OrderID, Patient.PatientID, Patient.Name as PatientName, Patient.Mobile, Patient.Sex, Orders.DateCreated FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] Orders
	INNER JOIN [LMS_Triopod_User].[Lab_Patient] Patient on Orders.PatientID = Patient.PatientID
	WHERE Orders.LabID = @LabID AND Orders.Status = 1 ORDER BY DateCreated desc;
	
	END

	--   Generate Report

	IF( @option = 7 ) 

    BEGIN

	DECLARE @isClub AS INT = 0
	DECLARE @isClubofclub AS INT = 0
	DECLARE @isClubofclub1 AS INT = 0
   
	SELECT Orders.OrderID, Orders.DateCreated, ReportNotes.ReportNotes, LabSetting.Header, LabSetting.Footer, LabSetting.IsEnabeled, Orders.Amount, Orders.ReferredBy, Orders.ReferredTo, CONCAT(Patient.Title, '. ', Patient.Name) as PatientName, Patient.Mobile, Patient.Email, Patient.Sex, CONCAT(Patient.Age, ' ', Patient.AgeType) AS AGE, CONCAT(Patient.Address, ', ', Patient.City, ', ', Patient.State,' - ', Patient.Pincode) AS ADDRESS FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] Orders
	INNER JOIN [LMS_Triopod_User].[Lab_Patient] Patient on Orders.PatientID = Patient.PatientID
	LEFT JOIN [LMS_Triopod_User].[Lab_Settings] LabSetting ON Orders.LabID = LabSetting.LabID
	LEFT JOIN [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] ReportNotes ON Orders.OrderID = ReportNotes.OrderID
	WHERE Orders.LabID = @LabID AND Orders.OrderID = @OrderID;

---when isclubtest = 0

IF NOT Exists (select * from [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] where orderId = @OrderID)
BEGIN

		select distinct '' clubname,
		case when ltm.ParentGroup_id <> 0 then (ltg1.name +' - ' +ltg.name) else ltg.Name end TestGroup 
		 ,ltm.testname,lptr.result,  ltm.normalrange,lptrn.ReportNotes,'0' displayorder
		 into #FinalData
		from 
		[LMS_Triopod_User].[Lab_Patient_Test_Mapping]  lptm
		--inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lptm.orderid
		inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = lptm.testid
		inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lptm.orderid  and ltm.testid = lptr.testid
		inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
		left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
		left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lptm.orderid
		where ltm.isclubtest = 0 and lptm.orderid = @OrderID

		select clubname,TestGroup,testname,result,normalrange,ReportNotes,displayorder from #FinalData 
		group by clubname,TestGroup,testname,result,normalrange,ReportNotes,displayorder
END
ELSE
BEGIN
---when isclubtest = 1

	if Exists (select top 1 1 from 
	[LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
	inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid
	inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = ct.clubid
	where lpcm.orderid = @OrderID and ltm.isclubofclub= 0 
	)
		Begin 
			
			SET @isClub = 1
			
			select distinct ltm.testName as clubname,
			case when ltm.ParentGroup_id <> 0 then (ltg1.name +' - ' +ltg.name) else ltg.Name end TestGroup ,
			ltm1.testname,
			lptr.result, ltm1.normalrange,lptrn.ReportNotes,ct.displayorder into #data2
			from 
			[LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
			inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid
			inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = ct.clubid
			inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm1 on ct.testid = ltm1.testid
			inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lpcm.orderid  and ltm1.testid = lptr.testid
			inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
			left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
			left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lpcm.orderid
			where lpcm.orderid = @OrderID and ltm.isclubofclub= 0 

			
			select distinct '' clubname,
			case when ltm.ParentGroup_id <> 0 then (ltg1.name +' - ' +ltg.name) else ltg.Name end TestGroup 
			 ,ltm.testname,lptr.result, 
			  ltm.normalrange,lptrn.ReportNotes,'0' displayorder
			 into #data10
			from 
			[LMS_Triopod_User].[Lab_Patient_Test_Mapping]  lptm
			--inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lptm.orderid  and ltm1.testid = lptr.testid
			inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = lptm.testid
			inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lptm.orderid  and ltm.testid = lptr.testid
			inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
			left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
			left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lptm.orderid 
			where  lptm.orderid = @OrderID
			and lptm.testid not in (
									select distinct ct.testid
									from 
									[LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
									inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid
									inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = ct.clubid
									inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm1 on ct.testid = ltm1.testid
									inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lpcm.orderid  and ltm1.testid = lptr.testid
									inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
									left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
									left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lpcm.orderid
									where lpcm.orderid = @OrderID
									)
			SELECT * into #FinalData1 FROM (
			select clubname,TestGroup,testname,result,normalrange,ReportNotes,displayorder 
			from #data2 
			group by clubname,TestGroup,testname,result,normalrange,ReportNotes,displayorder
			UNION
			select clubname,TestGroup,testname,result,normalrange,ReportNotes,displayorder 
			from #data10
			group by clubname,TestGroup,testname,result,normalrange,ReportNotes,displayorder)v
			
			--SELECT * FROM #FinalData1
			
		END

---when isclubtest = 1 and iscluofclub=1

	if Exists (select top 1 1 from 
	[LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
	inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid
	inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = ct.clubid
	where lpcm.orderid = @OrderID and ltm.isclubofclub= 1
	)
		Begin 

			select distinct lpcm.orderid,ct.clubid,ct.subclubid into #tempsubclubid 
			from [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
			inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid where ct.subclubid <> 0 
			and lpcm.orderid = @OrderID

			--drop table #tempsubclubid
			
			

			select distinct ltm.testName as clubname,
			case when ltm.ParentGroup_id <> 0 then (ltg1.name +' - ' +ltg.name) else ltg.Name end TestGroup ,
			ltm1.testname,
			lptr.result, ltm1.normalrange,lptrn.ReportNotes
			,ct1.displayorder
			into #data3
			from 
			[LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
			inner join [LMS_Triopod_User].#tempsubclubid ct on ct.clubid = lpcm.clubtestid
			inner join [LMS_Triopod_User].[Club_Test] ct1 on ct1.clubid =  ct.subclubid
			inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = ct1.clubid
			inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm1 on ct1.testid = ltm1.testid
			inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lpcm.orderid and ltm1.testid = lptr.testid
			inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
			left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
			left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lpcm.orderid
			where lpcm.orderid = @OrderID

			

			IF EXISTS(select top 1 * 
			from [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
			inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid where ct.subclubid = 0 
			and lpcm.orderid = @OrderID)
			BEGIN

				select distinct lpcm.orderid,ct.clubid,ct.subclubid into #tempclubid 
				from [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
				inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid where ct.subclubid = 0 
				and lpcm.orderid = @OrderID
				
				SET @isClubofclub1= 1
				
				--drop table #tempclubid
				select distinct ltm.testName as clubname,
				case when ltm.ParentGroup_id <> 0 then (ltg1.name +' - ' +ltg.name) else ltg.Name end TestGroup ,
				ltm1.testname ,
				lptr.result, ltm1.normalrange,lptrn.ReportNotes
				,ct.displayorder
				into #data4
				from 
				[LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
				inner join [LMS_Triopod_User].#tempsubclubid ct1 on ct1.clubid = lpcm.clubtestid
				inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = ct1.clubid and ct.subclubid = 0
				inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = ct.clubid
				inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm1 on ct.testid = ltm1.testid
				inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lpcm.orderid and ltm1.testid = lptr.testid
				inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
				left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
				left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lpcm.orderid
				where lpcm.orderid = @OrderID
				
				
				SELECT * INTO #FinalData2 FROM (				
				select clubname,TestGroup,testname,result,normalrange,ReportNotes
				,displayorder 
				from #data3 
				group by clubname,TestGroup,testname,result,normalrange,ReportNotes
				,displayorder
				UNION
				SELECT clubname,TestGroup,testname,result,normalrange,ReportNotes
				,displayorder 
				FROM #data4
				group by clubname,TestGroup,testname,result,normalrange,ReportNotes
				,displayorder
				UNION
				select distinct '' clubname,
				case when ltm.ParentGroup_id <> 0 then (ltg1.name +' - ' +ltg.name) else ltg.Name end TestGroup 
				,ltm.testname,lptr.result, 
				 ltm.normalrange,lptrn.ReportNotes,'0' displayorder
				--into #data10
				from 
				[LMS_Triopod_User].[Lab_Patient_Test_Mapping]  lptm
				--inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lptm.orderid  and ltm1.testid = lptr.testid
				inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = lptm.testid
				inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lptm.orderid  and ltm.testid = lptr.testid
				inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
				left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
				left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lptm.orderid 
				where  lptm.orderid = @OrderID
				and lptm.testid not in (
										select distinct ct.testid
										from 
										[LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
										inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid
										inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = ct.clubid
										inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm1 on ct.testid = ltm1.testid
										inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lpcm.orderid  
																										and ltm1.testid = lptr.testid
										inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
										left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
										left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lpcm.orderid
										where lpcm.orderid = @OrderID
									   )
							)v
							
				--SELECT * FROM #FinalData2
			END
			
			ELSE
			BEGIN
			
				SET @isClubofclub = 1
				
				SELECT * INTO #FinalData3 FROM (
				select clubname,TestGroup,testname,result,normalrange,ReportNotes
				,displayorder  
				from #data3 group by clubname,TestGroup,testname,result,normalrange,ReportNotes
				,displayorder
				UNION
				select distinct '' clubname,
				case when ltm.ParentGroup_id <> 0 then (ltg1.name +' - ' +ltg.name) else ltg.Name end TestGroup 
				,ltm.testname,lptr.result, 
				 ltm.normalrange,lptrn.ReportNotes,'0' displayorder
				--into #data10
				from 
				[LMS_Triopod_User].[Lab_Patient_Test_Mapping]  lptm
				inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = lptm.testid
				inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lptm.orderid  and ltm.testid = lptr.testid
				inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
				left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
				left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lptm.orderid 
				where  lptm.orderid = @OrderID
				and lptm.testid not in (
									select distinct ct.testid
									from 
									[LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping] lpcm
									inner join [LMS_Triopod_User].[Club_Test] ct on ct.clubid = lpcm.clubtestid
									inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm on ltm.testid = ct.clubid
									inner join [LMS_Triopod_User].[Lab_Test_Mapping] ltm1 on ct.testid = ltm1.testid
									inner join [LMS_Triopod_User].[lab_patient_test_report] lptr on lptr.orderid = lpcm.orderid and ltm1.testid = lptr.testid
									inner join [LMS_Triopod_User].[Lab_Test_Group] ltg on ltg.testgroupid = ltm.testgroupid
									left join [LMS_Triopod_User].[Lab_Test_Group] ltg1 on ltg1.TestGroupId = ltm.ParentGroup_id
									left join [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes] lptrn on lptrn.orderid = lpcm.orderid
									where lpcm.orderid = @OrderID
									)
							)v
							
				 --SELECT * FROM #FinalData3
							
			END
		End
		
		
IF (@isClub = 1 AND @isClubofclub = 0 AND @isClubofclub1 = 0)
	BEGIN
		SELECT * FROM #FinalData1
	END

IF (@isClub = 0 AND @isClubofclub = 1 AND @isClubofclub1 = 0)
	BEGIN
		SELECT * FROM #FinalData3
	END
IF (@isClub = 0 AND @isClubofclub = 0 AND @isClubofclub1 = 1)
	BEGIN
		SELECT * FROM #FinalData2
	END

IF (@isClub = 1 AND @isClubofclub = 0 AND @isClubofclub1 = 1)
	BEGIN
		SELECT * FROM #FinalData1
		UNION
		SELECT * FROM #FinalData2 WHERE clubname NOT IN (SELECT clubname FROM #FinalData1)
	END	

IF (@isClub = 1 AND @isClubofclub = 1 AND @isClubofclub1 = 0)
	BEGIN
		SELECT * FROM #FinalData1
		UNION
		SELECT * FROM #FinalData3 WHERE clubname NOT IN (SELECT clubname FROM #FinalData1)
	END


END



END

	-- GET PATIENT ORDER

	IF( @option = 8 ) 

    BEGIN 
	SELECT * FROM [LMS_Triopod_User].[Lab_Patient_Test_Order] Orders
	INNER JOIN [LMS_Triopod_User].[Lab_Order_Status] OrderStatus on Orders.Status = OrderStatus.StatusId
	WHERE Orders.LabID = @LabID AND PatientID = @PatientID ORDER BY Orders.DateCreated DESC;
	END

END
