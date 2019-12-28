CREATE SCHEMA [LMS_Triopod_User];

CREATE TABLE [LMS_Triopod_User].[Admin]
(
UserId int identity(1,1) PRIMARY KEY NOT NULL,
Username nvarchar(20) NOT NULL,
Password nvarchar(15) NOT NULL,
Name nvarchar(200),
Mobile nvarchar(10) NOT NULL,
Email nvarchar(320) NULL,
Status bit NOT NULL,
UserRole int NOT NULL,
UserImg nvarchar(100) NULL,
DateCreated datetime NULL,
DateUpdated datetime NULL,
)


CREATE TABLE [LMS_Triopod_User].[Doctors]
(
MapID int identity(1,1) PRIMARY KEY NOT NULL,
name nvarchar(600),
degree  nvarchar(200),
city nvarchar(200),
DateCreated datetime,
DateUpdated datetime
)

CREATE TABLE [LMS_Triopod_User].[TestCenter]
(
MapID int identity(1,1) PRIMARY KEY NOT NULL,
name nvarchar(600),
ccode nvarchar(200),
labid int,
DateCreated datetime,
DateUpdated datetime
)

CREATE TABLE [LMS_Triopod_User].[Labs]
(
LabID int identity(1000,1)  PRIMARY KEY NOT NULL,
LabName nvarchar(200) NOT NULL,
ParentLabID int NULL,
OwnerName nvarchar(200) NOT NULL,
Mobile nvarchar(10) NOT NULL,
Email nvarchar(320) NULL,
SecondaryPhone nvarchar(12) NULL,
State varchar(100) NOT NULL,
City nvarchar(100) NOT NULL,
PinCode nvarchar(6) NOT NULL,
Address nvarchar(1200) NOT NULL,
Timings nvarchar(200),
SubscriptionValidTo datetime NOT NULL,
LogoUrl nvarchar(1200) NULL,
Website nvarchar(1200) NULL,
Status bit NOT NULL,
DateCreated datetime NOT NULL,
DateUpdated datetime NOT NULL,
)

CREATE TABLE [LMS_Triopod_User].[Lab_Users]
(
UserId int identity(1,1) PRIMARY KEY NOT NULL,
Username nvarchar(20) NOT NULL,
Password nvarchar(15) NOT NULL,
Name nvarchar(200),
Mobile nvarchar(10) NOT NULL,
Email nvarchar(320) NULL,
Status bit NOT NULL,
UserRole int NOT NULL,
LabID int,
UserImg nvarchar(100) NULL,
DateCreated datetime NULL,
DateUpdated datetime NULL,
)

CREATE TABLE [LMS_Triopod_User].[Lab_Settings]
(
MAPID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
LabID int,
Header nvarchar(max) NULL,
Footer nvarchar(max) NULL,
IsEnabeled bit,
DateCreated datetime NULL,
DateUpdated datetime NULL,
)



CREATE TABLE [LMS_Triopod_User].[Lab_Patient]
(
PatientID int identity(1,1)  PRIMARY KEY NOT NULL,
Title nvarchar(20),
Name nvarchar(200),
Email nvarchar(255),
Mobile  nvarchar(10),
Aadhar  nvarchar(12),
Age int,
AgeType nvarchar(5),
Sex nvarchar(6),
State  nvarchar(100),
City  nvarchar(100),
Pincode  nvarchar(6),
Address  nvarchar(150),
LabID INT,
UserID int,
DateCreated datetime,
DateUpdated datetime
)


CREATE TABLE [LMS_Triopod_User].[Lab_Test_Group]
(
TestGroupId int identity(1,1) primary key,
Name nvarchar(700) NULL,
Parent_ID nvarchar (200),
Status bit,
DateCreated datetime,
DateUpdated datetime,
)

CREATE TABLE [LMS_Triopod_User].[Lab_Test_Mapping]
(
TestID int identity(1,1)  PRIMARY KEY NOT NULL,
TestName nvarchar(1200) NULL,
TestGroupId int NULL,
Price int NULL,
NormalRange nvarchar(1200),
DefaultResult nvarchar(1200) NULL,
IsClubTest bit,
Status bit NULL,
LabID int NULL,
DateCreated datetime NULL,
DateUpdated datetime NULL,
ParentGroup_id int ,
IsClubofClub int,
TestSortName nvarchar(100)
)

CREATE TABLE [LMS_Triopod_User].[Club_Test]
(
MapID int identity(1,1) PRIMARY KEY NOT NULL,
ClubID int ,
TestID int,
DisplayOrder NVARCHAR(10),
DateCreated datetime NULL,
DateUpdated datetime NULL,
subclubid int
)



create TABLE [LMS_Triopod_User].[Lab_Patient_Test_Order]
(
OrderID int identity(110,1)  PRIMARY KEY NOT NULL,
PatientID nvarchar(max),
LabID int,
ReferredBy nvarchar(200),
Amount money,
Paid money,
dues money,
Status int,
DateCreated datetime,
DateUpdated datetime,
ReferredTo nvarchar(1200),
Discount money
)

CREATE TABLE [LMS_Triopod_User].[Lab_Patient_Test_Mapping]
(
MapID int identity(1,1)  PRIMARY KEY NOT NULL ,
OrderID int,
TestID int,
TestName nvarchar(1200),
TestPrice money,
IsReportGenerated bit,
DateCreated datetime,
DateUpdated datetime
)

CREATE TABLE [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping]
(
MapId int identity(1,1)  PRIMARY KEY NOT NULL,
OrderID int ,
ClubTestID int,
ClubTestName nvarchar(2000),
ClubTestPrice money,
DateCreated datetime,
DateUpdated datetime
)

CREATE TABLE [LMS_Triopod_User].[Lab_Patient_Test_Report]
(
ReportID int identity(1,1) PRIMARY KEY NOT NULL,
OrderID int,
TestID int,
TestName nvarchar(2000),
Result nvarchar(3200),
DateCreated datetime,
DateUpdated datetime,
)

CREATE TABLE [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes]
(
MapID int identity(1,1)  PRIMARY KEY NOT NULL,
OrderID int,
ReportNotes nvarchar(max),
DateCreated datetime,
DateUpdated datetime,
)


CREATE TABLE [LMS_Triopod_User].[Lab_Order_Status]
(
StatusId int identity(0,1)  PRIMARY KEY NOT NULL,
StatusName nvarchar(200),
DateCreated datetime,
DateUpdated datetime,
)

insert [LMS_Triopod_User].[Lab_Order_Status] values ('Order Cancelled',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)

select * from [LMS_Triopod_User].[Labs]
select * from [LMS_Triopod_User].[Lab_Users]
select * from [LMS_Triopod_User].[Lab_Test_Group]
select * from [LMS_Triopod_User].[Lab_Test_Mapping] ORDER BY DATECREATED DESC
select * from [LMS_Triopod_User].[Club_Test]
select * from [LMS_Triopod_User].[Lab_Patient_Test_Order];
select * from [LMS_Triopod_User].[Lab_Patient_Test_Mapping];
select * from [LMS_Triopod_User].[Lab_Patient_ClubTest_Mapping]
select * from [LMS_Triopod_User].[Lab_Patient_Test_Report];
select * from [LMS_Triopod_User].[Lab_Patient_Test_Report_Notes];
select * from [LMS_Triopod_User].[Doctors];