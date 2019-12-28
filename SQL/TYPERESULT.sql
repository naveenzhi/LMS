
CREATE TYPE [LMS_Triopod_User].[TYPERESULT] AS TABLE(
OrderID int,
TestID int,
TestName nvarchar(2000),
Result nvarchar(3200)
)
GO