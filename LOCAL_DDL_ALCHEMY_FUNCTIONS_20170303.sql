USE [master]
GO
/****** Object:  Database [Alchemy_Functions]    Script Date: 03/03/2017 13:28:00 ******/
CREATE DATABASE [Alchemy_Functions]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Alchemy_Functions', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Functions.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Alchemy_Functions_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Functions_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Alchemy_Functions] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Alchemy_Functions].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Alchemy_Functions] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET ARITHABORT OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Alchemy_Functions] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Alchemy_Functions] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Alchemy_Functions] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Alchemy_Functions] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Alchemy_Functions] SET  MULTI_USER 
GO
ALTER DATABASE [Alchemy_Functions] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Alchemy_Functions] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Alchemy_Functions] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Alchemy_Functions] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Alchemy_Functions] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Alchemy_Functions] SET QUERY_STORE = OFF
GO
USE [Alchemy_Functions]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Alchemy_Functions]
GO
/****** Object:  User [sa_PowerBI]    Script Date: 03/03/2017 13:28:00 ******/
CREATE USER [sa_PowerBI] FOR LOGIN [sa_PowerBI] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa_PowerBI]
GO
/****** Object:  Schema [ARC]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [ARC]
GO
/****** Object:  Schema [BLD]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [BLD]
GO
/****** Object:  Schema [CFG]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [CFG]
GO
/****** Object:  Schema [DIM]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [DIM]
GO
/****** Object:  Schema [DQ]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [DQ]
GO
/****** Object:  Schema [FCT]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [FCT]
GO
/****** Object:  Schema [IMPORT]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [IMPORT]
GO
/****** Object:  Schema [MAP]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [MAP]
GO
/****** Object:  Schema [RPT]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [RPT]
GO
/****** Object:  Schema [STG]    Script Date: 03/03/2017 13:28:00 ******/
CREATE SCHEMA [STG]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CREATE_TIME_PERIOD_EXPORT_TABLE]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_CREATE_TIME_PERIOD_EXPORT_TABLE] (@TIME_PERIOD VARCHAR(50), @INVESTMENT_TYPE CHAR(3))
RETURNS DATE
AS
BEGIN
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	DECLARE @RetVal DATE, @DATEPART VARCHAR(10), @NUMBER INT, @INITIAL_DATE DATE -- @TIME_PERIOD VARCHAR(100),
	DECLARE @LatestClosureDate DATE

	SET @DATEPART = (SELECT [DATEPART] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[TIME_PERIOD] WHERE [TIME_PERIOD] = @TIME_PERIOD)
	SET @NUMBER =   (SELECT [NUMBER]   FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[TIME_PERIOD] WHERE [TIME_PERIOD] = @TIME_PERIOD)
	SET @INITIAL_DATE = GETDATE()

	SELECT @RetVal = CASE
	-- WHEN @DATEPART = 'DD' THEN CONVERT(DATE, DATEADD(DD, -@NUMBER, @INITIAL_DATE))
	WHEN @DATEPART = 'WK' THEN CONVERT(DATE, DATEADD(WK, -@NUMBER, @INITIAL_DATE))
	WHEN @DATEPART = 'MM' THEN CONVERT(DATE, DATEADD(MM, -@NUMBER, @INITIAL_DATE))
	WHEN @DATEPART = 'YY' THEN CONVERT(DATE, DATEADD(YY, -@NUMBER, @INITIAL_DATE))
	ELSE CONVERT(DATE, DATEADD(YY, -10, @INITIAL_DATE)) -- why -10????
	END

	IF @DATEPART = 'DD'
	BEGIN
		DECLARE @TRADING_DAYS TABLE ([ID] INT, [ClosureDate] DATE)
	
		INSERT INTO @TRADING_DAYS
		SELECT ROW_NUMBER() OVER (ORDER BY [ClosureDate] DESC), [ClosureDate]
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[FCT].[YAHOO_COMBINED_PRICES] A
		, [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] B
		, [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[INVESTMENT_TYPE] C
		WHERE [A].[ImportType] = '03_YAHOO_LATEST' AND [A].[ClosureDate]  > DATEADD(DD, -120, GETDATE())
			AND [A].[INVESTMENT_ID] = [B].[ID]
		AND [B].[INVESTMENT_TYPE] = [C].[ID]
		AND [C].INVESTMENT_TYPE_CODE = @INVESTMENT_TYPE
		GROUP BY [ClosureDate]
		HAVING COUNT(*) > 500 -- ensure there are not a few records trickled in - it is many prices for that day
		ORDER BY 2 DESC

		SET @RetVal = (SELECT [ClosureDate] FROM @TRADING_DAYS WHERE [ID] = @NUMBER)
	END

	RETURN @RetVal

/*
	IF DATEDIFF(DD, @INITIAL_DATE, @RetVal) <=7
	BEGIN
		IF DATENAME( DW, @INITIAL_DATE) = 'Monday' AND @NUMBER >=1 AND @DATEPART = 'DD'
		SET @RetVal = DATEADD(DD, -2, @RetVal) -- IGNORE THE WEEKEND !!

		IF DATENAME( DW, @INITIAL_DATE) = 'Tuesday' AND @NUMBER >=2 AND @DATEPART = 'DD'
		SET @RetVal = DATEADD(DD, -2, @RetVal) -- IGNORE THE WEEKEND !!

		IF DATENAME( DW, @INITIAL_DATE) = 'Wednesday' AND @NUMBER >=3 AND @DATEPART = 'DD'
		SET @RetVal = DATEADD(DD, -2, @RetVal) -- IGNORE THE WEEKEND !!

		IF DATENAME( DW, @INITIAL_DATE) = 'Thursday' AND @NUMBER >=4 AND @DATEPART = 'DD'
		SET @RetVal = DATEADD(DD, -2, @RetVal) -- IGNORE THE WEEKEND !!

		IF DATENAME( DW, @INITIAL_DATE) = 'Friday' AND @NUMBER >=5 AND @DATEPART = 'DD'
		SET @RetVal = DATEADD(DD, -2, @RetVal) -- IGNORE THE WEEKEND !!

		IF DATENAME( DW, @RetVal) = 'Saturday'
		SET @RetVal = DATEADD(DD, -1, @RetVal)
		
		IF DATENAME( DW, @RetVal) = 'Sunday'  
		SET @RetVal = DATEADD(DD, -2, @RetVal)
	END
*/
END






GO
/****** Object:  UserDefinedFunction [dbo].[fnHeaderAndFooterEmailCharacters]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUnction [dbo].[fnHeaderAndFooterEmailCharacters](@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	May 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

BEGIN

	SELECT @strText = REPLACE(@strText,'[], ','') + ']'		-- Get rid of report header
	SELECT @strText = REPLACE(@strText,'], ','')			-- Get rid of line header
	SELECT @strText = REPLACE(@strText,CHAR(10)+']','')		-- Get rid of footer

    RETURN @strText
END


GO
/****** Object:  UserDefinedFunction [dbo].[fnLeaveOnlyCharactersAZ09]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUnction [dbo].[fnLeaveOnlyCharactersAZ09](@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

BEGIN
-- http://stackoverflow.com/questions/106206/fastest-way-to-remove-non-numeric-characters-from-a-varchar-in-sql-server
    WHILE PATINDEX('%[^0-9A-Z]%', @strText) > 0
    BEGIN
        SET @strText = STUFF(@strText, PATINDEX('%[^0-9A-Z]%', @strText), 1, '')
    END
    RETURN @strText
END



GO
/****** Object:  UserDefinedFunction [dbo].[fnNVarcharToVarchar]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUnction [dbo].[fnNVarcharToVarchar](@strText VARCHAR(1000))
RETURNS VARCHAR(8000)
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	June 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

BEGIN
    -- WHILE PATINDEX('%[^0-9.]%', @strText) > 0
    -- BEGIN
    --     SET @strText = STUFF(@strText, PATINDEX('%[^0-9.]%', @strText), 1, '')
    -- END
    RETURN @strText
END



GO
/****** Object:  UserDefinedFunction [dbo].[fnRemoveNonNumericCharacters]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUnction [dbo].[fnRemoveNonNumericCharacters](@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

BEGIN
-- http://stackoverflow.com/questions/106206/fastest-way-to-remove-non-numeric-characters-from-a-varchar-in-sql-server
    WHILE PATINDEX('%[^0-9.-]%', @strText) > 0
    BEGIN
        SET @strText = STUFF(@strText, PATINDEX('%[^0-9.-]%', @strText), 1, '')
    END
    RETURN @strText
END


GO
/****** Object:  UserDefinedFunction [dbo].[fnRemoveNumericCharacters]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUnction [dbo].[fnRemoveNumericCharacters](@Temp VarChar(1000))
Returns VarChar(1000)
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

Begin

	-- http://stackoverflow.com/questions/13240298/remove-numbers-from-string-sql-server
    Declare @NumRange as varchar(50) = '%[0-9]%'
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp), 1, '')

    Return @Temp
End





GO
/****** Object:  StoredProcedure [BLD].[usp_SEND_AZURE_EMAILS]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [BLD].[usp_SEND_AZURE_EMAILS]
AS
BEGIN

	SET NOCOUNT ON

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0
	--
	-- EXEC [BLD].[usp_SEND_AZURE_EMAILS]
	-- ==================================================================================================================================

	DECLARE @i_msg VARCHAR(3000), @PARENT_USP VARCHAR(250)
	DECLARE @SQLMailProfile [varchar](255), @SendTo [varchar](255), @CC [varchar](255), @BCC [varchar](255), @Subject [varchar](255)
	,@Body [varchar](max), @Attachments [varchar](max), @SendAsHTML [bit], @SendAsCritical [bit]

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')

	-- SET @I_MSG = 'BEGIN'
	-- EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

	DECLARE db_cursor_email CURSOR FOR  

	SELECT [SQLMailProfile], [SendTo], [CC], [BCC], [Subject], [Body], [Attachments], [SendAsHTML], [SendAsCritical]
	FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[SQLMailLog]

	OPEN db_cursor_email   
	FETCH NEXT FROM db_cursor_email INTO @SQLMailProfile, @SendTo, @CC, @BCC, @Subject, @Body, @Attachments, @SendAsHTML, @SendAsCritical

	DECLARE @v_ERR INT, @REPORT_BATCH INT, @return_value int

	WHILE @@FETCH_STATUS = 0   
	BEGIN

		EXEC @return_Value =  [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @Subject, @Body

		IF @return_value <> 0
		BEGIN
			SET @i_msg = 'E: Error has occured ' + CONVERT(VARCHAR(10),@return_value)
			PRINT @i_msg 
			-- EXEC [ALCHEMY_DATA].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @i_msg, @vRE
			CLOSE db_cursor_email   
			DEALLOCATE db_cursor_email 
			RETURN 255
		END
		ELSE
		BEGIN
			DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[SQLMailLog]
			WHERE [SQLMailProfile] = @SQLMailProfile
			AND   [SendTo] = @SendTo
			AND   [CC] = @CC
			AND   [BCC] = @BCC
			AND   [Subject] = @Subject
			AND   [Body] = @Body
			AND   [Attachments] = @Attachments
			AND   [SendAsHTML] = @SendAsHTML
			AND   [SendAsCritical] = @SendAsCritical
		END

		FETCH NEXT FROM db_cursor_email INTO @SQLMailProfile, @SendTo, @CC, @BCC, @Subject, @Body, @Attachments, @SendAsHTML, @SendAsCritical
	END

	CLOSE db_cursor_email   
	DEALLOCATE db_cursor_email 

END


GO
/****** Object:  StoredProcedure [BLD].[usp_sendSMTPEmail]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_sendSMTPEmail] 
	@SQLMailProfile varchar(255) = 'Red7 Profile', 
	@SendTo varchar(255) = '', 
	@CC varchar(255) = '', 
	@BCC varchar(255) = '', 
	@Subject varchar(255) = '', 
	@Body varchar(max) = '', 
	@Attachments varchar(max) = '', 
	@SendAsHTML bit = 0, 
	@SendAsCritical bit = 0 

AS
	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	/*
	-- ALTER DATABASE MSDB SET ENABLE_BROKER
	EXEC [BLD].[usp_sendSMTPEmail] @SQLMailProfile='Red7 Profile', @SendTo='eahind@yahoo.co.uk', @CC='', @BCC=''
	, @Subject='TEST SUBJECT', @Body='Hello World', @Attachments='', @SendAsHTML=0, @SendAsCritical=1
	*/
	-- ==================================================================================================================================

	BEGIN 

	SET NOCOUNT ON 

	--Test: EXEC <DB name>.[dbo].sendSMTPEmail @SQLMailProfile='Default', @SendTo='?', @CC='?', @BCC='?', @Subject='?', @Body='?', @Attachments='?', @SendAsHTML=?, @SendAsCritical=? 

	DECLARE @BodyFormat varchar(20) 
	DECLARE @Importance varchar(6) 
	
	--Populate required variables 
	IF LEN(RTRIM(ISNULL(@SQLMailProfile, ''))) = 0 SELECT @SQLMailProfile = 'Default' 
	SELECT @BodyFormat = CASE WHEN @SendAsHTML = 1 THEN 'HTML' ELSE 'TEXT' END 
	SELECT @Importance = CASE WHEN @SendAsCritical = 1 THEN 'High' ELSE 'Normal' END 

	/*
	IF @@VERSION LIKE '%Azure%'
	BEGIN
		BEGIN TRY
			INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[SQLMailLog]
			(SQLMailProfile, SendTo, CC, BCC, Subject, Body, Attachments, SendAsHTML, SendAsCritical) 
			VALUES (@SQLMailProfile, @SendTo, @CC, @BCC, @Subject, @Body, @Attachments, @SendAsHTML, @SendAsCritical)
		END TRY

		BEGIN CATCH
			PRINT 'E: Error insertinto into [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[SQLMailLog])'
		END CATCH
	END
	ELSE
	*/
	DECLARE @RETVAL INT
	BEGIN TRY
		EXEC @RETVAL = [msdB].[dbo].sp_send_dbmail 
			@profile_name=@SQLMailProfile, 
			@recipients=@SendTo, 
			@copy_recipients=@CC, 
			@blind_copy_recipients=@BCC, 
			@subject=@Subject, 
			@body=@Body, 
			@body_format=@BodyFormat, 
			@importance=@Importance, 
			@file_attachments=@Attachments; 
	END TRY

	BEGIN CATCH
		-- EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] 1, '[msdB].[dbo].sp_send_dbmail ', 0 -- @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		-- EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] 1, '[msdB].[dbo].sp_send_dbmail ', 0 -- @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- Finish: 
	-- SET NOCOUNT OFF 

END

GO
/****** Object:  StoredProcedure [BLD].[usp_STANDARD_EMAIL]    Script Date: 03/03/2017 13:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [BLD].[usp_STANDARD_EMAIL] (@i_subject VARCHAR(100), @i_body VARCHAR(2500), @SendTo VARCHAR(100) = NULL)
AS

BEGIN
	
	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	March 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 
	-- EXEC[BLD].[usp_STANDARD_EMAIL] 'Test subject', 'Hello'
	-- EXEC[BLD].[usp_STANDARD_EMAIL] 'Test subject', 'Hello', 'ekahind@gmail.com'
	-- SELECT * FROM [BLD].[SQLMailLog]
	-- ==================================================================================================================================

	IF @SendTo IS NULL SET @SendTo = 'eahind@yahoo.co.uk'

	RAISERROR (@i_subject,10,1) 

	EXEC [BLD].[usp_sendSMTPEmail] @SQLMailProfile='Red7 Profile', @SendTo=@SendTo, @CC='', @BCC=''
	, @Subject=@i_subject, @Body=@i_body, @Attachments='', @SendAsHTML=0, @SendAsCritical=1

END




































GO
USE [master]
GO
ALTER DATABASE [Alchemy_Functions] SET  READ_WRITE 
GO
