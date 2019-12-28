SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE [LMS_Triopod_User].[PROCTESTCENTER]
	-- Add the parameters for the stored procedure here
	@name nvarchar(600) = NULL,
	@ccode  nvarchar(200) = NULL,
	@labid int = null,
	@option int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	
	IF(@option = 1)
	BEGIN
	INSERT [LMS_Triopod_User].[TestCenter] VALUES (@name, @ccode, @labid, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
	END

END
GO
