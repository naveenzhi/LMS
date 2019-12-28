
CREATE TYPE [LMS_Triopod_User].[TypeClubTest] AS TABLE(

TestID int,
TestName nvarchar(1200),
DisplayOrder NVARCHAR(100),
ISClub bit,
subclubid int
)
GO