USE [master]
GO
/****** Object:  Database [Alchemy_Functions]    Script Date: 16/02/2021 10:29:29 ******/
CREATE DATABASE [Alchemy_Functions]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Alchemy_Functions', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Functions.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Alchemy_Functions_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Functions_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Alchemy_Functions] SET COMPATIBILITY_LEVEL = 130
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
ALTER DATABASE [Alchemy_Functions] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Alchemy_Functions] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Alchemy_Functions] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Alchemy_Functions', N'ON'
GO
ALTER DATABASE [Alchemy_Functions] SET QUERY_STORE = OFF
GO
USE [Alchemy_Functions]
GO
/****** Object:  User [ALEX_ADMIN]    Script Date: 16/02/2021 10:29:29 ******/
CREATE USER [ALEX_ADMIN] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ALEX_ADMIN]
GO
/****** Object:  Schema [BLD]    Script Date: 16/02/2021 10:29:29 ******/
CREATE SCHEMA [BLD]
GO
/****** Object:  UserDefinedTableType [dbo].[EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY]    Script Date: 16/02/2021 10:29:29 ******/
CREATE TYPE [dbo].[EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MESSAGE_CONTENT] [varchar](2500) NULL
)
GO
/****** Object:  UserDefinedFunction [BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  User [ALEX_ADMIN]    Script Date: 07/03/2019 11:36:40 ******/
CREATE FUNCTION [BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] (
@BUILD_ID INT = 957, @PARENT_USP VARCHAR(100) = 'Dunno', @PRE_HEADER VARCHAR(5) = 'W:', @HEADER VARCHAR(500) = 'Hello Joe', @BUILD_TYPE CHAR(1) = 'F', @KEY_STAGE BIT = 0 )
RETURNS VARCHAR(2000)
AS
BEGIN

	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release (1.1 2016110 Moved to Azure)
	-- 1.1		20190213 Added @KEY_STAGE
	--
	-- [BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] 957, 'Parent EAH','W:', 'Hello World', 'F', 0
	--
	-- Note: Unable to do TRY and CATCH as it is a FUNCTION
	-- ================================================================================================================================================================


	DECLARE @I_MSG VARCHAR(500), @v_dynDelete NVARCHAR(4000)
	SET @I_MSG = @PRE_HEADER + ' ' + CONVERT(VARCHAR(25),GETDATE(), 121)+ ' ' + @HEADER

	SET @v_dynDelete = 'UPDATE [Alchemy_Data].[BLD].[LOAD_STATUS] SET [END_DATETIME] = GETDATE() WHERE [END_DATETIME] IS NULL ' -- SHOULD BE ONLY ONE OF THESE ....
	SET @v_dynDelete = @v_dynDelete + 'AND [BUILD_ID] = ' + CONVERT(VARCHAR(100), @BUILD_ID) 
	-- SET @v_dynDelete = @v_dynDelete + 'AND [PARENT_USP] = ''' + @PARENT_USP  + ''''

	EXEC sp_executesql @v_dynDelete

	-- ================================================================================================================================================================

	SET @v_dynDelete = 'INSERT INTO [Alchemy_Data].[BLD].[LOAD_STATUS] ([BUILD_ID], [ENTRY_DATETIME], [PARENT_USP], [ENTRY_NOTES], [BUILD_TYPE], [KEY_STAGE])  VALUES ('
		 + CONVERT(VARCHAR(100), @BUILD_ID) + ',''' 
		+ CONVERT(VARCHAR(100), GETDATE()) + ''',''' -- "e.g. Apr 25 2017 10:56AM,"
		+ @PARENT_USP + ''','''
		+ @PRE_HEADER + @HEADER + '''' + ','
		+ '''' + @BUILD_TYPE + '''' + ',' + CONVERT(VARCHAR(10), @KEY_STAGE) + ')'

	EXEC sp_executesql @v_dynDelete

	-- ================================================================================================================================================================
	-- THE END
	-- ================================================================================================================================================================

	RETURN @v_dynDelete
END
GO
/****** Object:  UserDefinedFunction [BLD].[fnSetBuildID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [BLD].[fnSetBuildID] (@BUILD_ID INT = 0, @DEBUG INT = 0)
RETURNS INT
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	March 2019
	-- Version History:
	-- 1.0		Initial Release
	--
	-- ******************************************************************************************************************************************

BEGIN
	IF ISNULL(@BUILD_ID, 0) > (0)
	RETURN @BUILD_ID

	-- IF @DEBUG = (1) SELECT 'I: Search the table'

	DECLARE @i INT
	SET @i = (SELECT MAX([BUILD_ID]) FROM [Alchemy_Data].[BLD].[LOAD_STATUS])

    RETURN @i
END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_CREATE_TIME_PERIOD_EXPORT_TABLE]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_CREATE_TIME_PERIOD_EXPORT_TABLE] (@TIME_PERIOD VARCHAR(50), @INVESTMENT_TYPE VARCHAR(3) = '%')
RETURNS DATE
AS
BEGIN
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	February 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	/*
	DECLARE @D1 DATE
	SET @D1 = [dbo].[fn_CREATE_TIME_PERIOD_EXPORT_TABLE] ('03 days', '')
	SET @D1 = [dbo].[fn_CREATE_TIME_PERIOD_EXPORT_TABLE] ('01 week', '')
	PRINT @D1
	*/
	-- =====================================================================================================================

	DECLARE @RetVal DATE, @DATEPART VARCHAR(10), @NUMBER INT, @INITIAL_DATE DATE -- @TIME_PERIOD VARCHAR(100),
	DECLARE @LatestClosureDate DATE

	-- SELECT * FROM [Alchemy_Data].[DIM].[TIME_PERIOD] WHERE [TIME_PERIOD] = '14 days'
	SET @DATEPART = (SELECT [DATEPART] FROM [Alchemy_Data].[DIM].[TIME_PERIOD] WHERE [TIME_PERIOD] = @TIME_PERIOD)
	-- SET @NUMBER =   (SELECT [NUMBER]   FROM [Alchemy_Data].[DIM].[TIME_PERIOD] WHERE [TIME_PERIOD] = '14 days') -- 14
	SET @NUMBER =   (SELECT [NUMBER]   FROM [Alchemy_Data].[DIM].[TIME_PERIOD] WHERE [TIME_PERIOD] = @TIME_PERIOD)
	SET @INITIAL_DATE = GETDATE()

	SELECT @RetVal = CASE
	-- WHEN @DATEPART = 'DD' THEN CONVERT(DATE, DATEADD(DD, -@NUMBER, @INITIAL_DATE))
	WHEN @DATEPART = 'WK' THEN CONVERT(DATE, DATEADD(WK, -@NUMBER, @INITIAL_DATE))
	WHEN @DATEPART = 'MM' THEN CONVERT(DATE, DATEADD(MM, -@NUMBER, @INITIAL_DATE))
	WHEN @DATEPART = 'YY' THEN CONVERT(DATE, DATEADD(YY, -@NUMBER, @INITIAL_DATE))
	ELSE CONVERT(DATE, DATEADD(YY, -(10), @INITIAL_DATE)) -- why -10????
	END

	-- SELECT @RetVal 

	IF @DATEPART = 'DD'
	BEGIN
		DECLARE @TRADING_DAYS TABLE ([ID] INT, [ClosureDate] DATE)
	
		INSERT INTO @TRADING_DAYS
		SELECT ROW_NUMBER() OVER (ORDER BY [ClosureDate] DESC), [ClosureDate]
		FROM [Alchemy_Data].[FCT].[YAHOO_COMBINED_PRICES] A1
		, [Alchemy_Data].[DIM].[v_INVESTMENT] B1
		, [Alchemy_Data].[DIM].[INVESTMENT_TYPE] C1
		WHERE -- [A1].[ImportType] LIKE '%YAH%' -- '03_YAHOO_LATEST' = '03_YAHOO_LATEST' -- 20180103
		[A1].[ClosureDate]  > DATEADD(DD, -(120), GETDATE())
		AND [A1].[INVESTMENT_ID] = [B1].[ID]
		AND [B1].[INVESTMENT_TYPE] = [C1].[ID]
		-- IGNORE FOR NOW 20171031 AND [C1].INVESTMENT_TYPE_CODE LIKE @INVESTMENT_TYPE
		AND [ClosureDate] > DATEADD(DD, -(45), GETDATE()) -- 20170103 -- 14
		GROUP BY [ClosureDate]
		HAVING COUNT(*) > (250) -- ensure there are not a few records trickled in - it is many prices for that day
		ORDER BY 2 DESC

		SET @RetVal = (SELECT [ClosureDate] FROM @TRADING_DAYS WHERE [ID] = @NUMBER)
	END

	RETURN @RetVal

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnDATEADD_USING_WORKING_DAYS]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnDATEADD_USING_WORKING_DAYS](@Days INT)
RETURNS DATE
-- WITH SCHEMABINDING  
AS
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	/*
	DECLARE @D1 DATE
	SET @D1 = [dbo].[fn_DATEADD_USING_WORKING_DAYS] (2)
	PRINT @D1
	*/

BEGIN
	DECLARE @D1 DATE, @NOW DATE, @TmpDATE DATE, @I INT

	SET @NOW = CONVERT(DATE, GETDATE())
	SET @D1 = DATEADD(DD, -(@DAYS), GETDATE())
	SET @i = (0)

/*
	SET @TmpDATE = @NOW
	WHILE @TmpDATE >= @D1
	BEGIN
		IF DATENAME(DW, @TmpDATE) IN ('Sunday')
		BEGIN
			SET @i = @i + 2
			SET @TmpDATE = DATEADD(DD, -(1), @TmpDATE) -- No point in checking out next day as we know it is Saturday
		END
		SET @TmpDATE = DATEADD(DD, -(1), @TmpDATE)
	END
*/

	SET @TmpDATE = @NOW
	WHILE @TmpDATE >= @D1
	BEGIN
		IF DATENAME(DW, @TmpDATE) IN ('Sunday')
		BEGIN
			SET @i = @i + 2
			SET @TmpDATE = DATEADD(DD, -(1), @TmpDATE)
		END
		SET @TmpDATE = DATEADD(DD, -(1), @TmpDATE)
	END

	SET @TmpDATE = DATEADD(DD, -(@DAYS + @i), @NOW)

	-- ================================================================================================================================================================================================
	--
	-- ================================================================================================================================================================================================

	SET @TmpDATE = DATEADD(DD, -(@DAYS + @i), @NOW)

	-- ================================================================================================
	-- Final Check
	-- ================================================================================================
	IF DATENAME(DW, @TmpDATE) IN ('Sunday')
	SET @TmpDATE = DATEADD(DD, -(2), @TmpDate)

	IF DATENAME(DW, @TmpDATE) IN ('Saturday')
	SET @TmpDATE = DATEADD(DD, -(1), @TmpDate)


	RETURN @TmpDATE
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_ALC_ETFs]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_ALC_ETFs]() -- @Temp VarChar(2500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

BEGIN
	DECLARE @TEMP INT

	SELECT @TEMP = [ID] -- SELECT *
	FROM [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] = 'ALC (Exchange Traded Funds)'

    RETURN @Temp
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_ALC_Indices]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_ALC_Indices]() -- @Temp VarChar(2500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================


BEGIN
	DECLARE @TEMP INT

	SELECT @TEMP = [ID] -- SELECT *
	FROM [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] = 'ALC (Indices)'

    RETURN @Temp
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_ALC_Options]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_ALC_Options]() -- @Temp VarChar(2500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID] -- SELECT *
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'ALC (Options)'
	
	 RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE_AIM_100_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_FTSE_AIM_100_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE AIM 100 (Equities)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE_AIM_50_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_FTSE_AIM_50_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE AIM UK 50 (Equities)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE_AIM_AllShare_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_FTSE_AIM_AllShare_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE AIM All-Share (Equities)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE_AllShare_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGet_FTSE_AllShare_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	/*
	(SELECT 
	*/
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE All Share (Equities)'

	 RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE_Fledgling_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_FTSE_Fledgling_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE Fledgling (Equities)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE_SmallCap_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_FTSE_SmallCap_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE Small Cap (Equities)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE_TechMark_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_FTSE_TechMark_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE techMARK All-Share (Equities)'

	    RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE100_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGet_FTSE100_MARKET_ID]() -- @Temp VarChar(1000))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE100 (Equities)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE250_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_FTSE250_MARKET_ID]() -- @Temp VarChar(2500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	/*
	(SELECT 
	*/
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE250 (Equities)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_FTSE350_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_FTSE350_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'FTSE350 (Equities)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_IA_UNIT_TRUSTS_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_IA_UNIT_TRUSTS_MARKET_ID]() -- @Temp VarChar(2500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID] -- SELECT *
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] = 'IA (Unit Trusts & OEICS)'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_NotKnown_MARKET_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGet_NotKnown_MARKET_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID]
		FROM [Alchemy_Data].[DIM].[MARKET]
		WHERE [MARKET_NAME] LIKE '%Not Known%'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_NotKnown_SECTOR_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnGet_NotKnown_SECTOR_ID]() -- @Temp VarChar(3500))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2018
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT

		SELECT @TEMP = [ID] -- SELECT  *
		FROM [Alchemy_Data].[DIM].[SECTORS]
		WHERE [SECTOR] LIKE '%Not Known%'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGet_R7GBP_INVESTMENT_ID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnGet_R7GBP_INVESTMENT_ID]() -- @Temp VarChar(1000))
RETURNs INT
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	BEGIN
		DECLARE @TEMP INT
		SELECT @TEMP = 14698 -- [ID] FROM [Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [PRIMARY_LABEL] = 'R7GBP'

		RETURN @Temp
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetDatePeriodDays]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetDatePeriodDays] (@DATE AS DATE)
RETURNS VARCHAR(1000)
AS
BEGIN

	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	/*
	DECLARE @RET VARCHAR(100)
	EXEC @RET = [dbo].[fnGetDatePeriodDays] '1 Dec 2019'
	PRINT @RET
	*/
	-- ================================================================================================================================================================

	DECLARE @Ret VARCHAR(1000)

	SELECT @RET = CASE
	WHEN @DATE > DATEADD(DD, -005, GETDATE()) THEN '005 Days'
	WHEN @DATE > DATEADD(DD, -015, GETDATE()) THEN '015 Days'
	WHEN @DATE > DATEADD(DD, -030, GETDATE()) THEN '030 Days'
	WHEN @DATE > DATEADD(DD, -060, GETDATE()) THEN '060 Days'
	WHEN @DATE > DATEADD(DD, -090, GETDATE()) THEN '090 Days'
	WHEN @DATE > DATEADD(DD, -180, GETDATE()) THEN '180 Days'
	WHEN @DATE > DATEADD(DD, -360, GETDATE()) THEN '360 Days'
	WHEN @DATE > DATEADD(DD, -540, GETDATE()) THEN '540 Days'
	ELSE 'Other'
	END

	-- SELECT @RET = [INVESTMENT_NAME] FROM [Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [ID] = @ID
	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetINVESTMENTID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGetINVESTMENTID] (@INVESTMENT as VARCHAR(1000))
RETURNS INT
AS
BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @Ret INT

	SELECT @RET = [ID] FROM [Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [PRIMARY_LABEL] = @INVESTMENT
	-- select * FROM [Alchemy_Data].[DIM].[INVESTMENTS]  where INVESTMENT like '%other%'

	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetInvestmentName]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetInvestmentName] (@ID AS INT)
RETURNS VARCHAR(1000)
AS
BEGIN

	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @Ret VARCHAR(1000)

	SELECT @RET = [INVESTMENT_NAME] FROM [Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [ID] = @ID
	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetMARKETID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetMARKETID] (@MARKET as VARCHAR(1000))
RETURNS INT
AS
BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @Ret INT

	SELECT @RET = [ID] FROM [Alchemy_Data].[DIM].[MARKET] WHERE [MARKET_NAME] LIKE @MARKET
	-- select * FROM [Alchemy_Data].[DIM].[MARKETS]  where MARKET like '%other%'

	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetMARKETName]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetMARKETName] (@ID AS INT)
RETURNS VARCHAR(1000)
AS
BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @Ret VARCHAR(1000)

	SELECT @RET = [MARKET_NAME]  FROM [Alchemy_Data].[DIM].[MARKET] WHERE [ID] = @ID
	-- select * FROM [Alchemy_Data].[DIM].[MARKETS]  where MARKET like '%other%'

	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetSectorID]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetSectorID] (@SECTOR as VARCHAR(1000))
RETURNS INT
AS
BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @Ret INT

	SELECT @RET = [ID] FROM [Alchemy_Data].[DIM].[SECTORS] WHERE [SECTOR] = @SECTOR
	-- select * FROM [Alchemy_Data].[DIM].[SECTORS]  where sector like '%other%'

	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetSectorName]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fnGetSectorName] (@ID AS INT)
RETURNS VARCHAR(1000)
AS
BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @Ret VARCHAR(1000)

	SELECT @RET = [SECTOR] FROM [Alchemy_Data].[DIM].[SECTORS] WHERE [ID] = @ID
	-- select * FROM [Alchemy_Data].[DIM].[SECTORS]  where sector like '%other%'

	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnHeaderAndFooterEmailCharacters]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnHeaderAndFooterEmailCharacters](@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	May 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	SELECT @strText = REPLACE(@strText,'[], ','') + ']'		-- Get rid of report header
	SELECT @strText = REPLACE(@strText,'], ','')			-- Get rid of line header
	SELECT @strText = REPLACE(@strText,CHAR(10)+']','')		-- Get rid of footer

    RETURN @strText
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnHLCategorisePaymentType]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnHLCategorisePaymentType](@Text as VARCHAR(1000), @trUNITS FLOAT, @HLReference VARCHAR(25))
RETURNs VARCHAR(1000)
AS
BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @Ret VARCHAR(1000)

	SET @RET = CASE
	WHEN @Text LIKE 'HL:LOYALTY%' THEN 'HL:Payment (IN) Loyalty'
	WHEN @Text LIKE '% GROSS LOYALTY%' THEN 'HL:Payment (IN) Loyalty'
	WHEN @Text LIKE 'HL:UTC CR%' THEN 'HL:Payment (IN) Unit Trust Cash'
	WHEN @Text LIKE 'HL:%MANAGE FEE%' THEN 'HL:Payment (OUT) Manage Fee'
	WHEN @Text LIKE 'HL:%Income Re-Investment%' THEN 'HL:Re-Investment Income'
	WHEN @Text LIKE 'HL:URIB%' THEN 'HL:Re-Investment Income'
	WHEN @HLReference LIKE 'WHATIF%' THEN 'What if analogy ....'
	WHEN @Text LIKE 'WHATIF%' THEN 'What if analogy ....'
	WHEN @Text LIKE 'HL:UTO CR%' THEN 'HL:Dividend: Offshore'
	WHEN @Text LIKE 'HL:OVR CR%' THEN 'HL:Dividend: Overseas'
	WHEN @Text LIKE 'HL:PDG CR%' THEN 'HL:Dividend: Gross'
	WHEN @Text LIKE 'HL:UAG CR%' THEN 'HL:Tax Credit'
	WHEN @Text LIKE 'HL:ST DIV%' THEN 'HL:Dividend: Net'
	WHEN @Text LIKE 'HL:%Dividend Transfer%' THEN 'HL:Transfer Dividend'
	WHEN @Text LIKE 'HL:%Transfer from Income%' THEN 'HL:Transfer from Income'
	WHEN @Text LIKE 'HL:%Transfer To Capital Account%' THEN 'HL:Transfer to Capital Account'
	 
	WHEN @Text LIKE 'FULLY RECON%' AND @trUNITS > (0)THEN 'Buy\Sell: Reconciled (Buy)'
	WHEN @Text LIKE 'FULLY RECON%' AND @trUNITS < (0)THEN 'Buy\Sell: Reconciled (Sell)'

	WHEN @Text LIKE 'RECON%' AND @trUNITS > (0)THEN 'Buy\Sell: Reconciled (Buy)'
	WHEN @Text LIKE 'RECON%' AND @trUNITS < (0)THEN 'Buy\Sell: Reconciled (Sell)'

	WHEN @Text LIKE 'OEIC%' AND @trUNITS > (0)THEN 'Buy\Sell: Reconciled (Buy)'
	WHEN @Text LIKE 'OEIC%' AND @trUNITS < (0)THEN 'Buy\Sell: Reconciled (Sell)'

	WHEN @Text LIKE '%PROPERTY%' AND @trUNITS > (0)THEN 'Buy\Sell: Reconciled (Buy)'
	WHEN @Text LIKE '%PROPERTY%' AND @trUNITS < (0)THEN 'Buy\Sell: Reconciled (Sell)'

	WHEN @Text LIKE 'Red7 Cash for %' THEN 'Buy\Sell: Cash in\out'
	WHEN @Text LIKE 'Auto%payments%in%' THEN 'Contribution'
	WHEN @Text LIKE 'HL:REG. SAVER%' THEN 'Contribution'
	WHEN @Text LIKE '%TAX%Contribution%' THEN 'Contribution (Tax)'
	WHEN @Text LIKE '%Employer%Contribution%' THEN 'Contribution (Employer)'
	WHEN @Text LIKE '%Member%Contribution%' THEN 'Contribution (Member)'
	WHEN @Text LIKE '%Contribution%' THEN 'Contribution'
	WHEN @Text LIKE 'Sipp Transfer%' THEN 'Contribution (Transfer)'
	WHEN @Text LIKE '%Correction%' THEN '**** CORRECTION ****'
	WHEN @Text LIKE '%SIPP%Transfer%' THEN 'Contribution'
	WHEN @Text LIKE '%Card%Web%' THEN 'Contribution'

	WHEN @HLReference LIKE 'B[0-9]%' THEN 'Buy\Sell: Reconciled (Buy)'
	WHEN @HLReference LIKE 'S[0-9]%' THEN 'Buy\Sell: Reconciled (Sell)'

	WHEN @Text LIKE '%Share%Split%' THEN 'Buy\Sell: Share Split'

	WHEN @Text LIKE 'HL:%Interest%' THEN 'HL:Payment (IN) Interest' --20171212
	  ELSE ''
	END -- AS [Transaction_Desc]

	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnLeaveOnlyCharactersAZ09]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnLeaveOnlyCharactersAZ09](@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

-- http://stackoverflow.com/questions/106206/fastest-way-to-remove-non-numeric-characters-from-a-varchar-in-sql-server
    WHILE PATINDEX('%[^0-9A-Z]%', @strText) > 0
    BEGIN
        SET @strText = STUFF(@strText, PATINDEX('%[^0-9A-Z]%', @strText), 1, '')
    END
    RETURN @strText
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnNVarcharToVarchar]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnNVarcharToVarchar](@strText VARCHAR(1000))
RETURNS VARCHAR(8000)
AS
BEGIN
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	June 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================


    -- WHILE PATINDEX('%[^0-9.]%', @strText) > 0
    -- BEGIN
    --     SET @strText = STUFF(@strText, PATINDEX('%[^0-9.]%', @strText), 1, '')
    -- END
    RETURN @strText
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnRemoveNonNumericCharacters]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnRemoveNonNumericCharacters](@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

-- http://stackoverflow.com/questions/106206/fastest-way-to-remove-non-numeric-characters-from-a-varchar-in-sql-server
    WHILE PATINDEX('%[^0-9.-]%', @strText) > 0
    BEGIN
        SET @strText = STUFF(@strText, PATINDEX('%[^0-9.-]%', @strText), 1, '')
    END
    RETURN @strText
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnRemoveNumericCharacters]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnRemoveNumericCharacters](@Temp VarChar(1000))
RETURNs VarChar(1000)
AS
BEGIN
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	-- http://stackoverflow.com/questions/13240298/remove-numbers-from-string-sql-server
    DECLARE @NumRange as varchar(50) = '%[0-9]%'
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp), 1, '')

    RETURN @Temp
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetAlcSectorGroupFromSector]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[GetAlcSectorGroupFromSector](@Text as VARCHAR(1000), @DEFAULT_SECTOR AS VARCHAR(100) = 'Other')
RETURNS VARCHAR(1000)
AS
BEGIN

	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20200113 Added '(Alc) Metals' -- 
	-- ================================================================================================================================================================

/*
	*******************************************************************************************************************************************************
	IMPORTANT
	* 1.0
	* 1.1	20170626
	* 1.2	20170630
	* 1.3	20170703
	* 1.4	20170714
	* 1.5	20170726
	* 1.5	20170728
	* 1.6	20170731
	* 1.7	20170810
	* 1.8	20170812
	* 1.9	20170814
	* 2.0	20171004
	* 2.1	20171101
	* 2.2	20171116
	*******************************************************************************************************************************************************

	COMPLETELY DUPLICATED FUNCTION
	AS UNABLE TO CALL A FUNCTION ON A REMOTE SERVER

	*******************************************************************************************************************************************************
	ANY CHANGES HERE MUST BE MADE ON [ALCHEMY_DATA] AND [ALCHEMY_BUILD]
	*******************************************************************************************************************************************************
*/

	DECLARE @Ret VARCHAR(1000)

	SET @RET = CASE -- SOURCE : MSCI

	WHEN @Text LIKE '%Target%RETURN%' THEN '(Alc) Targeted RETURN'
	WHEN @Text LIKE '%Real%RETURN%' THEN '(Alc) Targeted RETURN'
	WHEN @Text LIKE '%Total%RETURN%' THEN '(Alc) Targeted RETURN'
	WHEN @Text LIKE '%Absolute%' THEN '(Alc) Targeted RETURN'

	WHEN @Text LIKE '% bank%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Financ%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Equity Investment Instruments%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Financial Services%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%insurance%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Banks%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Cash%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%RETURN%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%investment%instrument%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%hedge%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Financial' THEN '(Alc) Financial'

	WHEN @Text LIKE '%BOND%' THEN '(Alc) Bonds and Gilts'
	WHEN @Text LIKE '%GILT%' THEN '(Alc) Bonds and Gilts'
	WHEN @Text LIKE '%Treasuries%' THEN '(Alc) Bonds and Gilts'
	WHEN @Text LIKE '%IBOXX%' THEN '(Alc) Bonds and Gilts'

	WHEN @Text LIKE '%exc%Japan%' THEN '(Alc) Asia'
	WHEN @Text LIKE '%inc%Japan%' THEN '(Alc) Japan'
	WHEN @Text LIKE '%Japan%' THEN '(Alc) Japan'

	WHEN @Text LIKE '%Asia%' THEN '(Alc) Asia'
	WHEN @Text LIKE '%China%' THEN '(Alc) Asia'
	WHEN @Text LIKE '%Chinese%' THEN '(Alc) Asia'
	WHEN @Text LIKE '%Chindia%' THEN '(Alc) Asia' -- First Trust Ise Chindia Index Inc USD
	WHEN @Text LIKE '%Chimerica%' THEN '(Alc) Asia' -- Xie Shares FTSE Chimerica

	WHEN @Text LIKE '%NIKKEI%' THEN '(Alc) Japan'
	WHEN @Text LIKE '%Tokyo%' THEN '(Alc) Japan'
	WHEN @Text LIKE '%Nippon%' THEN '(Alc) Japan'

	WHEN @Text LIKE '%ROBO%' THEN '(Alc) Specialist and Technology' -- EUROBOND picked up further above
	WHEN @Text LIKE '%TELECOM%' THEN '(Alc) Specialist and Technology'
	WHEN @Text LIKE '%TECHNO%' THEN '(Alc) Specialist and Technology'
	WHEN @Text LIKE '%Technology%' THEN '(Alc) Specialist and Technology'
	WHEN @Text LIKE '%Software%' THEN '(Alc) Specialist and Technology'

	WHEN @Text LIKE '%Specialist%' THEN '(Alc) Specialist and Technology'

	WHEN @Text LIKE '% REIT %' THEN '(Alc) Property'
	WHEN @Text LIKE '%Property%' THEN '(Alc) Property'
	WHEN @Text LIKE '%Infrastructure%' THEN '(Alc) Property'
	WHEN @Text LIKE '%REAL ESTATE%' THEN '(Alc) Property'
	WHEN @Text LIKE '%Construction%' THEN '(Alc) Construction'

	WHEN @Text LIKE '%GAS%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%BRENT%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%GRAINS%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '% FOOD%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%LIVESTOCK%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%CRUDE%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%SOY%BEAN%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%CARBON%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%LEAD%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%COMMOD%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '% SOFTS%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%PETROL%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%MATERIALS%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%AGRIC%' THEN '(Alc) Commodity and Energy'

	WHEN @Text LIKE '%NICKEL%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%GOLD%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%alumin%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%palladium%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%COPPER%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%Lithium%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%SILVER%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%Rhodium%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%ZINC%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '% TIN %' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%metals%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%platinum%' THEN '(Alc) Metals' -- '(Alc) Commodity and Energy'

	WHEN @Text LIKE '%WHEAT%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%SUGAR%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%water%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%natural%resources%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%Solar%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%oil%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%energy%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%wind%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%timber%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%utilities%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%mining%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%cocoa%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%coffee%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%cotton%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%lumber%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%orange juice%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%hogs%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%cattle%' THEN '(Alc) Commodity and Energy'
	WHEN @Text LIKE '%forestry%' THEN '(Alc) Commodity and Energy'

	WHEN @Text LIKE '%Brazil%' THEN '(Alc) Americas (Emerging Markets)'
	WHEN @Text LIKE '%Chile%' THEN '(Alc) Americas (Emerging Markets)'
	WHEN @Text LIKE '%Columbia%' THEN '(Alc) Americas (Emerging Markets)'
	WHEN @Text LIKE '%Mexico%' THEN '(Alc) Americas (Emerging Markets)'
	WHEN @Text LIKE '%Peru%' THEN '(Alc) Americas (Emerging Markets)'
	WHEN @Text LIKE '%LATIN%' THEN '(Alc) Americas (Emerging Markets)'

	WHEN @Text LIKE '%Argentina%' THEN '(Alc) Americas (Frontier Markets)'

	WHEN @Text LIKE '%America%' THEN '(Alc) Americas'
	WHEN @Text LIKE '% US %' THEN '(Alc) Americas'
	WHEN @Text LIKE '%NASDAQ%' THEN '(Alc) Americas'
	WHEN @Text LIKE '% United States %' THEN '(Alc) Americas'
	WHEN @Text LIKE '% USA%' THEN '(Alc) Americas'
	WHEN @Text LIKE '%Canada%' THEN '(Alc) Americas'
	WHEN @Text LIKE '% Russell %' THEN '(Alc) Americas'

	WHEN @Text LIKE '%EuroZone%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Europe%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Austria%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Belgium%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Denmark%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Finland%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%France%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Deutsch%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Germany%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%STOXX%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Ireland%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Irish%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Euronext%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Italy%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Netherlands%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Norway%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Portugal%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Spain%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Nordic%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%IBEX%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '% UCITS %' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Sweden%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Switzerland%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%Swiss%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%United K%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%FTSE%' THEN '(Alc) Europe & Middle East'
	WHEN @Text LIKE '%MSCI EMU%' THEN '(Alc) Europe & Middle East'

	WHEN @Text LIKE '%UK%' THEN '(Alc) United Kingdom'

	WHEN @Text LIKE '%Czech%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Egypt%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Greece%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Hungary%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Poland%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Qatar%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Russia%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%South Africa%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Turkey%' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Arab%' THEN '(Alc) EMEA (Emerging Markets)'

	WHEN @Text LIKE '%Croatia%' THEN '(Alc) Europe and CIS (Frontier Markets)'
	WHEN @Text LIKE '%Estonia%' THEN '(Alc) Europe and CIS (Frontier Markets)'
	WHEN @Text LIKE '%Lithuania%' THEN '(Alc) Europe and CIS (Frontier Markets)'
	WHEN @Text LIKE '%Kazakhstan%' THEN '(Alc) Europe and CIS (Frontier Markets)'
	WHEN @Text LIKE '%Romania%' THEN '(Alc) Europe and CIS (Frontier Markets)'
	WHEN @Text LIKE '%Serbia%' THEN '(Alc) Europe and CIS (Frontier Markets)'
	WHEN @Text LIKE '%Slovenia%' THEN '(Alc) Europe and CIS (Frontier Markets)'

	WHEN @Text LIKE '%Kenya%' THEN '(Alc) Africa (Frontier Markets)'
	WHEN @Text LIKE '%Mauritius%' THEN '(Alc) Africa (Frontier Markets)'
	WHEN @Text LIKE '%Morocco%' THEN '(Alc) Africa (Frontier Markets)'
	WHEN @Text LIKE '%Nigeria%' THEN '(Alc) Africa (Frontier Markets)'
	WHEN @Text LIKE '%Tunisia%' THEN '(Alc) Africa (Frontier Markets)'

	WHEN @Text LIKE '%Bahrain%' THEN '(Alc) Middle East (Frontier Markets)'
	WHEN @Text LIKE '%Jordan%' THEN '(Alc) Middle East (Frontier Markets)'
	WHEN @Text LIKE '%Kuwait%' THEN '(Alc) Middle East (Frontier Markets)'
	WHEN @Text LIKE '%Lebanon%' THEN '(Alc) Middle East (Frontier Markets)'
	WHEN @Text LIKE '%Oman%' THEN '(Alc) Middle East (Frontier Markets)'

	WHEN @Text LIKE '%Australia%' THEN '(Alc) Pacific'
	-- WHEN @Text LIKE '%Japan%' THEN '(Alc) Pacific'
	WHEN @Text LIKE '%Hang Seng%' THEN '(Alc) Pacific'
	WHEN @Text LIKE '%Hong Kong%' THEN '(Alc) Pacific'
	WHEN @Text LIKE '%New Zealand%' THEN '(Alc) Pacific'
	WHEN @Text LIKE '%Singapore%' THEN '(Alc) Pacific'

	WHEN @Text LIKE '%SHORT%USD%EUR%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%LONG%USD%EUR%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%SHORT%CAD%EUR%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%LONG%CAD%EUR%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%SHORT%CNY%USD%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%LONG%CNY%USD%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%SHORT%CHF%USD%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%LONG%CHF%USD%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%SHORT%GBP%USD%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%LONG%GBP%USD%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%SHORT%USD%GBP%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%LONG%USD%GBP%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%SHORT%JPY%USD%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%LONG%JPY%USD%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%Protected%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%Currency Trading%' THEN '(Alc) Currency Trading'
	WHEN @Text LIKE '%Sterling%' THEN '(Alc) Currency Trading'
	-- WHEN @Text LIKE '%Income%' THEN '(Alc) Currency Trading'

	WHEN @Text LIKE '%UK%Income%' THEN '(Alc) Equity Income'
	WHEN @Text LIKE '%Global%Income%' THEN '(Alc) Equity Income'
	WHEN @Text LIKE '%Equity%Income%' THEN '(Alc) Equity Income'

	WHEN @Text LIKE '%Mixed%' THEN '(Alc) Mixed Investment'

	WHEN @Text LIKE '%Bangladesh%' THEN '(Alc) Asia (Frontier Markets)'
	WHEN @Text LIKE '%Sri Lanka%' THEN '(Alc) Asia (Frontier Markets)'
	WHEN @Text LIKE '%Vietnam%' THEN '(Alc) Asia (Frontier Markets)'

	WHEN @Text LIKE '%India%' THEN '(Alc) Asia (Emerging Markets)'
	WHEN @Text LIKE '%Indonesia%' THEN '(Alc) Asia (Emerging Markets)'
	WHEN @Text LIKE '%Korea%' THEN '(Alc) Asia (Emerging Markets)'
	WHEN @Text LIKE '%Malaysia%' THEN '(Alc) Asia (Emerging Markets)'
	WHEN @Text LIKE '%Pakistan%' THEN '(Alc) Asia (Emerging Markets)'
	WHEN @Text LIKE '%Philippines%' THEN '(Alc) Asia (Emerging Markets)'
	WHEN @Text LIKE '%Taiwan%' THEN '(Alc) Asia (Emerging Markets)'
	WHEN @Text LIKE '%Thailand%' THEN '(Alc) Asia (Emerging Markets)'

	WHEN @Text LIKE '%Currency%' THEN '(Alc) Currency'

	WHEN @Text LIKE '%Global%' THEN '(Alc) Global'
	WHEN @Text LIKE '%World%' THEN '(Alc) Global'
	WHEN @Text LIKE '%International%' THEN '(Alc) Global'
	WHEN @Text LIKE '%MSCI EAFE%' THEN '(Alc) Global'

	WHEN @Text LIKE '%Africa (Frontier Markets)' THEN '(Alc) Africa (Frontier Markets)'
	WHEN @Text LIKE '%EMEA (Emerging Markets)' THEN '(Alc) EMEA (Emerging Markets)'
	WHEN @Text LIKE '%Emerging Markets' THEN '(Alc) Emerging Markets'
	WHEN @Text LIKE '%Ethical' THEN '(Alc) Ethical'
	WHEN @Text LIKE '%Fixed Interest' THEN '(Alc) Fixed Interest'
	WHEN @Text LIKE '%Fixed Int%' THEN '(Alc) Fixed Interest'
	WHEN @Text LIKE '%Unclassified' THEN '(Alc) Unclassified'
	WHEN @Text LIKE '%World' THEN '(Alc) World'

	WHEN @Text LIKE '%Pacific%' THEN '(Alc) Pacific'

	WHEN @Text LIKE '%Retail%' THEN '(Alc) Retailer'
	WHEN @Text LIKE '%Beverages%' THEN '(Alc) Retailer'
	WHEN @Text LIKE '%Personal%' THEN '(Alc) Retailer'
	WHEN @Text LIKE '%Leisure%' THEN '(Alc) Retailer'

	WHEN @Text LIKE '%Travel%' THEN '(Alc) Travel and Leisure'

	WHEN @Text LIKE '%Industrial%' THEN '(Alc) Industrial'
	WHEN @Text LIKE '%Automobile%' THEN '(Alc) Industrial'
	WHEN @Text LIKE '%Aerospace%' THEN '(Alc) Industrial'
	WHEN @Text LIKE '%Chemicals%' THEN '(Alc) Industrial'
	WHEN @Text LIKE '%Electricity%' THEN '(Alc) Industrial'
	WHEN @Text LIKE '%Food%producer%' THEN '(Alc) Industrial'
	WHEN @Text LIKE '%elec%equipment%' THEN '(Alc) Industrial'
	WHEN @Text LIKE '%tobacco%' THEN '(Alc) Industrial'

	WHEN @Text LIKE '%Health%' THEN '(Alc) Health'
	WHEN @Text LIKE '% Media%' THEN '(Alc) Media'
	
	WHEN @Text LIKE '%EASTern%' THEN '(Alc) Pacific'
	WHEN @Text LIKE '%FAR%EAST%' THEN '(Alc) Pacific'
	WHEN @Text LIKE '%Oriental%' THEN '(Alc) Pacific'

	WHEN @Text LIKE '%Emerging%' THEN '(Alc) Emerging Markets'
	WHEN @Text LIKE '%Multi%Asset%' THEN '(Alc) Mixed Investment'
	WHEN @Text LIKE '%[%]%Shares%' THEN '(Alc) Mixed Investment'

	WHEN @Text LIKE '%S&P%ASX%' THEN '(Alc) Pacific'
	WHEN @Text LIKE '%S&P%500%' THEN '(Alc) Americas'

	WHEN @Text LIKE '%BIOTECH%' THEN '(Alc) Biotechnology'
	ELSE '(Alc) ' + @DEFAULT_SECTOR END 
	RETURN @Ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetAlcSectorGroupSummaryFromSector]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[GetAlcSectorGroupSummaryFromSector](@MARKET_NAME AS VARCHAR(250), @Text AS VARCHAR(1000), @DEFAULT_SECTOR AS VARCHAR(100) = 'Other')
RETURNS VARCHAR(1000)
AS
BEGIN

	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

/*
	*******************************************************************************************************************************************************
	IMPORTANT
	* 1.0	20171228
	-- SELECT [dbo].[GetAlcSectorGroupSummaryFromSector]('ALC (Exchange Traded Funds)', '(Alc) Asia (Emerging Markets)', 'Other')
	*******************************************************************************************************************************************************
*/

	DECLARE @Ret VARCHAR(1000)

	SET @RET = CASE

	WHEN @Text LIKE '%Banks%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Insurance%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Financ%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Equity Investment Instruments%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Currency Trading%' THEN '(Alc) Financial'
	WHEN @Text LIKE '%Money Market%' THEN '(Alc) Financial'

	WHEN @Text LIKE '% BOND%' THEN '(Alc) Bonds and Gilts'
	WHEN @Text LIKE '% TARGETED%RETURN%' THEN '(Alc) Financial' -- '(Alc) Bonds and Gilts'
	WHEN @Text LIKE '% GILTS%' THEN '(Alc) Bonds and Gilts'

	-- WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Money Market%' THEN '(Alc) Financial'
	-- WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Financial%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Income%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Sterling%' THEN '(Alc) Financial'

	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Mixed%' THEN '(Alc) Mixed Investment'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%China%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%India%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Japan%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Pacific%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Asia%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Europe%' THEN '(Alc) Europe'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%UK%' THEN '(Alc) Europe'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%America%' THEN '(Alc) Americas'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Global%' THEN '(Alc) Global'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Property%' THEN '(Alc) Property' -- , Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Specialist%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Technology%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Unclassified%' THEN '(Alc) Unclassified'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Not Yet%' THEN '(Alc) Various Other'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Not Known%' THEN '(Alc) Various Other'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Protected%' THEN '(Alc) Protected' -- 20181227
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Flexible%' THEN '(Alc) Various Other'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Personal Pensions%' THEN '(Alc) Personal Pensions'
	WHEN @MARKET_NAME LIKE 'IA%' AND @Text LIKE '%Volatility Managed%' THEN '(Alc) Various Other'
	WHEN @MARKET_NAME LIKE 'IA%' THEN @Text -- '(Alc) Various Other'

	-- WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Financial%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Frontier%' THEN '(Alc) Emerging Markets'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Emerging%' THEN '(Alc) Emerging Markets'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Money%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Income%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Sterling%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Currency%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Financial%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%absolute%RETURN%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%targeted%RETURN%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Fixed%Interest%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%BOND%' THEN '(Alc) Bonds and Gilts'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%GILTS%' THEN '(Alc) Bonds and Gilts'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Mixed%' THEN '(Alc) Mixed Investment'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%China%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Japan%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%India%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Asia%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Pacific%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Australia%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Europe%' THEN '(Alc) Europe'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%UK%' THEN '(Alc) Europe'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%America%' THEN '(Alc) Americas'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%USA%' THEN '(Alc) Americas'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Canada%' THEN '(Alc) Americas'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Global%' THEN '(Alc) Global'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%World%' THEN '(Alc) Global'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%International%' THEN '(Alc) Global'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Property%' THEN '(Alc) Property' -- 20180814 , Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Specialist%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%BIOTECH%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%HEALTH%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Technology%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Media%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Commodity%Energy%' THEN '(Alc) Commodity and Energy'
	WHEN @MARKET_NAME LIKE 'ALC%' AND @Text LIKE '%Metals%' THEN '(Alc) Commodity and Energy'
	WHEN @MARKET_NAME LIKE 'ALC%' THEN '(Alc) Various Other' -- @Text -- 20180226

	-- WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Financial%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Frontier%' THEN '(Alc) Emerging Markets'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Emerging%' THEN '(Alc) Emerging Markets'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Money%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Income%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Sterling%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Currency%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Financial%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%absolute%RETURN%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%targeted%RETURN%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Fixed%Interest%' THEN '(Alc) Financial'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%BOND%' THEN '(Alc) Bonds and Gilts'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%GILTS%' THEN '(Alc) Bonds and Gilts'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Mixed%' THEN '(Alc) Mixed Investment'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%China%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Japan%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%India%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Asia%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Pacific%' THEN '(Alc) Asia'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Australia%' THEN '(Alc) Asia'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Europe%' THEN '(Alc) Europe'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%UK%' THEN '(Alc) Europe'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%America%' THEN '(Alc) Americas'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%USA%' THEN '(Alc) Americas'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Canada%' THEN '(Alc) Americas'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Global%' THEN '(Alc) Global'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%World%' THEN '(Alc) Global'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%International%' THEN '(Alc) Global'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Property%' THEN '(Alc) Property' -- 201808, Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%BIOTECH%' THEN '(Alc) Biotechnology'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Specialist%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%HEALTH%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Techn%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Technology%' THEN '(Alc) Specialist and Technology'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Media%' THEN '(Alc) Specialist and Technology'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%travel%' THEN '(Alc) Travel and Leisure'

	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Commodity%Energy%' THEN '(Alc) Commodity and Energy'
	WHEN @MARKET_NAME LIKE 'FTSE%' AND @Text LIKE '%Metals%' THEN '(Alc) Commodity and Energy'
	WHEN @MARKET_NAME LIKE 'FTSE%' THEN dbo.GetAlcSectorGroupFromSector(@Text, 'Other')

	WHEN @MARKET_NAME LIKE '%Cash%' THEN @Text

	ELSE '(Alc) ' + @DEFAULT_SECTOR END 
	RETURN @Ret

/*
		CASE
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Money%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Income%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Sterling%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%BOND%' THEN '(Alc) Bonds and Gilts'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%TARGETED%RETURN%' THEN '(Alc) Bonds and Gilts'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%GILTS%' THEN '(Alc) Bonds and Gilts'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Mixed%' THEN '(Alc) Mixed Investment'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%China%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Japan%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Pacific%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Asia%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Europe%' THEN '(Alc) Europe'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%UK%' THEN '(Alc) Europe'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%America%' THEN '(Alc) Americas'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Global%' THEN '(Alc) Global'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Property%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Specialist%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' AND [D].[SECTOR] LIKE '%Technology%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'IA%' THEN '(Alc) Various Other'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Frontier%' THEN '(Alc) Emerging Markets'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Emerging%' THEN '(Alc) Emerging Markets'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Money%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Income%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Sterling%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Currency%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Financial%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%absolute%RETURN%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%targeted%RETURN%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Fixed%Interest%' THEN '(Alc) Financial'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%BOND%' THEN '(Alc) Bonds and Gilts'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%GILTS%' THEN '(Alc) Bonds and Gilts'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Mixed%' THEN '(Alc) Mixed Investment'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%China%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Japan%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%India%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Asia%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Pacific%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Australia%' THEN '(Alc) Asia'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Europe%' THEN '(Alc) Europe'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%UK%' THEN '(Alc) Europe'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%America%' THEN '(Alc) Americas'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%USA%' THEN '(Alc) Americas'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Canada%' THEN '(Alc) Americas'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Global%' THEN '(Alc) Global'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%World%' THEN '(Alc) Global'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%International%' THEN '(Alc) Global'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Property%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Specialist%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%BIOTECH%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%HEALTH%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Technology%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Media%' THEN '(Alc) Property, Specialist and Technology'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Commodity%Energy%' THEN '(Alc) Commodity and Energy'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' AND [D].[SECTOR] LIKE '%Metals%' THEN '(Alc) Commodity and Energy'
			WHEN [C].[MARKET_NAME] LIKE 'ALC%' THEN '(Alc) Various Other'
			ELSE [SECTOR_GROUP] END -- AS [SECTOR_GROUP]
*/

END
GO
/****** Object:  UserDefinedFunction [dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW]
(@BUILD_ID INT = 0
-- , @vRE INT
, @PARENT_USP VARCHAR(250), @D1 DATETIME
, @ALERT_IF_OVER_X_SECONDS INT = 30
, @I_MSG VARCHAR(2500)
, @BUILD_TYPE CHAR(1) = 'F')
RETURNS DATETIME
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	April 2017
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190226 Change I: to W:
	-- 1.2		20190306 Change W: to P:
	--
	/*
	DECLARE @STEP_START DATETIME, @NOW DATETIME;
	SET @NOW = GETDATE()
	EXEC @STEP_START = [dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] 1828, 1, 'PUSP', @NOW, 0, 'Yo'
	*/
	-- ******************************************************************************************************************************************

BEGIN

	DECLARE @DIFF_IN_SECS INT
	SET @DIFF_IN_SECS = DATEDIFF(SECOND, @D1, GETDATE())
	
	IF @DIFF_IN_SECS >= @ALERT_IF_OVER_X_SECONDS
	BEGIN
		SET @I_MSG = @I_MSG + ' (' + CONVERT(VARCHAR(25), @DIFF_IN_SECS) + ' seconds)'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID
		, @PARENT_USP = @PARENT_USP
		, @PRE_HEADER = 'P:' -- was W: - P for Performance
		, @HEADER = @I_MSG
		, @BUILD_TYPE = @BUILD_TYPE -- 20170811
		, @KEY_STAGE = 0			-- 20190213
	END

	SET @D1 = GETDATE()
    RETURN @D1
END
GO
/****** Object:  UserDefinedFunction [dbo].[usp_CheckPriceAgainstMedian]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[usp_CheckPriceAgainstMedian] 
(@INVESTMENT_ID INT, @ClosureDate DATE, @DAYS_IN_SET INT = 30)
RETURNs INT
AS
BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @RETURN_VALUE DECIMAL(13,8);

	WITH CTE_02 AS (
		SELECT [A1].[INVESTMENT_ID]
		, [A1].[ClosureDate]
		, [A1].[Price]
		,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [A1].[PRICE]) OVER (PARTITION BY [A1].[INVESTMENT_ID]) AS [MedianCont]
		,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [A1].[PRICE]) OVER (PARTITION BY [A1].[INVESTMENT_ID]) / NULLIF([A1].[Price],0) AS [FACTOR]
		FROM
		[Alchemy_Data].[FCT].[YAHOO_COMBINED_PRICES] A1
			WHERE [A1].[ClosureDate] BETWEEN DATEADD(DD, -(@DAYS_IN_SET), @ClosureDate) AND @ClosureDate -- GETDATE())
			AND [A1].[INVESTMENT_ID] = @INVESTMENT_ID
		)
	
		SELECT @RETURN_VALUE = -- [FACTOR]
		CASE
			WHEN [FACTOR] >= (0.00000025) AND [FACTOR] < (0.0000025) THEN (0.000001)
			WHEN [FACTOR] >= (0.0000025) AND [FACTOR] < (0.000025) THEN (0.00001)
			WHEN [FACTOR] >= (0.000025) AND [FACTOR] < (0.00025) THEN (0.0001)
			WHEN [FACTOR] >= (0.00025) AND [FACTOR] < (0.0025) THEN (0.001)
			WHEN [FACTOR] >= (0.0025) AND [FACTOR] < (0.025) THEN (0.01)
			WHEN [FACTOR] >= (0.025) AND [FACTOR] < (0.25) THEN (0.1)
			WHEN [FACTOR] >= (0.25) AND [FACTOR] < (6) THEN (1)
			WHEN [FACTOR] >= (6) AND [FACTOR] < (75) THEN (10)
			WHEN [FACTOR] >= (75)    AND [FACTOR] < (750)    THEN (100)
			WHEN [FACTOR] >= (750)   AND [FACTOR] < (7500)   THEN (1000)
			WHEN [FACTOR] >= (7500)  AND [FACTOR] < (75000)  THEN (10000)
			WHEN [FACTOR] >= (75000) AND [FACTOR] < (750000) THEN (100000)
			WHEN [FACTOR] >= (750000) AND [FACTOR] < (7500000) THEN (1000000)
			ELSE (1)
			END -- AS [MULTIPLY_BY]
		FROM CTE_02 A1
		WHERE [ClosureDate] = @ClosureDate

	RETURN @RETURN_VALUE
	END
GO
/****** Object:  UserDefinedFunction [dbo].[fnProperCase]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnProperCase](@Text as varchar(8000))
RETURNS VARCHAR(8000)
WITH SCHEMABINDING  
AS
-- v1.0 20170810

BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	DECLARE @ReSET bit;
	DECLARE @Ret varchar(8000);
	DECLARE @i int;
	DECLARE @c char(1);

	select @ReSET = 1, @i=1, @Ret = '';

	while (@i <= LEN(@Text))
		select @c= substring(@Text,@i,1),
               @Ret = @Ret + case when @Reset=1 then UPPER(@c) else LOWER(@c) END,
               @ReSET = case when @c like '[a-zA-Z]' then 0 else 1 END,
               @i = @i +1

	-- Crudely set 1st 8 chars upper case if no vowels ...
	IF (CHARINDEX ('A', @Ret) > (8) OR CHARINDEX ('A', @Ret) = (0))
	AND (CHARINDEX ('E', @Ret) > (8) OR CHARINDEX ('E', @Ret) = (0))
	AND (CHARINDEX ('I', @Ret) > (8) OR CHARINDEX ('I', @Ret) = (0))
	AND (CHARINDEX ('O', @Ret) > (8) OR CHARINDEX ('O', @Ret) = (0))
	AND (CHARINDEX ('U', @Ret) > (8) OR CHARINDEX ('U', @Ret) = (0))
	AND LEN(@Ret) > 8
	AND RIGHT(LEFT(@Ret,9),1) = ' ' -- 9th char is a space
	SET @Ret = UPPER(LEFT(@Ret,8)) + ' ' + RIGHT(@Ret, LEN(@Ret) - (9))

	-- Crudely set 1st 7 chars upper case if no vowels ...
	IF (CHARINDEX ('A', @Ret) > (7) OR CHARINDEX ('A', @Ret) = (0))
	AND (CHARINDEX ('E', @Ret) > (7) OR CHARINDEX ('E', @Ret) = (0))
	AND (CHARINDEX ('I', @Ret) > (7) OR CHARINDEX ('I', @Ret) = (0))
	AND (CHARINDEX ('O', @Ret) > (7) OR CHARINDEX ('O', @Ret) = (0))
	AND (CHARINDEX ('U', @Ret) > (7) OR CHARINDEX ('U', @Ret) = (0))
	AND LEN(@Ret) > 7
	AND RIGHT(LEFT(@Ret,8),1) = ' ' -- 8th char is a space
	SET @Ret = UPPER(LEFT(@Ret,7)) + ' ' + RIGHT(@Ret, LEN(@Ret) - (8))

	-- Crudely set 1st 6 chars upper case if no vowels ...
	IF (CHARINDEX ('A', @Ret) > (6) OR CHARINDEX ('A', @Ret) = (0))
	AND (CHARINDEX ('E', @Ret) > (6) OR CHARINDEX ('E', @Ret) = (0))
	AND (CHARINDEX ('I', @Ret) > (6) OR CHARINDEX ('I', @Ret) = (0))
	AND (CHARINDEX ('O', @Ret) > (6) OR CHARINDEX ('O', @Ret) = (0))
	AND (CHARINDEX ('U', @Ret) > (6) OR CHARINDEX ('U', @Ret) = (0))
	AND LEN(@Ret) > 6
	AND RIGHT(LEFT(@Ret,7),1) = ' ' -- 7th char is a space
	SET @Ret = UPPER(LEFT(@Ret,6)) + ' ' + RIGHT(@Ret, LEN(@Ret) - (7))

	-- Crudely set 1st 5 chars upper case if no vowels ...
	IF (CHARINDEX ('A', @Ret) > (5) OR CHARINDEX ('A', @Ret) = (0))
	AND (CHARINDEX ('E', @Ret) > (5) OR CHARINDEX ('E', @Ret) = (0))
	AND (CHARINDEX ('I', @Ret) > (5) OR CHARINDEX ('I', @Ret) = (0))
	AND (CHARINDEX ('O', @Ret) > (5) OR CHARINDEX ('O', @Ret) = (0))
	AND (CHARINDEX ('U', @Ret) > (5) OR CHARINDEX ('U', @Ret) = (0))
	AND LEN(@Ret) > 5
	AND RIGHT(LEFT(@Ret,6),1) = ' ' -- 6th char is a space
	SET @Ret = UPPER(LEFT(@Ret,5)) + ' ' + RIGHT(@Ret, LEN(@Ret) - (6))

	-- Crudely set 1st 4 chars upper case if no vowels ...
	IF (CHARINDEX ('A', @Ret) > (4) OR CHARINDEX ('A', @Ret) = (0))
	AND (CHARINDEX ('E', @Ret) > (4) OR CHARINDEX ('E', @Ret) = (0))
	AND (CHARINDEX ('I', @Ret) > (4) OR CHARINDEX ('I', @Ret) = (0))
	AND (CHARINDEX ('O', @Ret) > (4) OR CHARINDEX ('O', @Ret) = (0))
	AND (CHARINDEX ('U', @Ret) > (4) OR CHARINDEX ('U', @Ret) = (0))
	AND LEN(@Ret) > 4
	AND RIGHT(LEFT(@Ret,5),1) = ' ' -- 5th char is a space
	SET @Ret = UPPER(LEFT(@Ret,4)) + ' ' + RIGHT(@Ret, LEN(@Ret) - (5))

	-- Crudely set 1st 3 chars upper case if no vowels ...
	IF (CHARINDEX ('A', @Ret) > (3) OR CHARINDEX ('A', @Ret) = (0))
	AND (CHARINDEX ('E', @Ret) > (3) OR CHARINDEX ('E', @Ret) = (0))
	AND (CHARINDEX ('I', @Ret) > (3) OR CHARINDEX ('I', @Ret) = (0))
	AND (CHARINDEX ('O', @Ret) > (3) OR CHARINDEX ('O', @Ret) = (0))
	AND (CHARINDEX ('U', @Ret) > (3) OR CHARINDEX ('U', @Ret) = (0))
	AND LEN(@Ret) > 3
	AND RIGHT(LEFT(@Ret,4),1) = ' ' -- 4th char is a space
	SET @Ret = UPPER(LEFT(@Ret,3)) + ' ' + RIGHT(@Ret, LEN(@Ret) - (4))

	-- Crudely set 1st 2 chars upper case if no vowels ...
	IF (CHARINDEX ('A', @Ret) > (2) OR CHARINDEX ('A', @Ret) = (0))
	AND (CHARINDEX ('E', @Ret) > (2) OR CHARINDEX ('E', @Ret) = (0))
	AND (CHARINDEX ('I', @Ret) > (2) OR CHARINDEX ('I', @Ret) = (0))
	AND (CHARINDEX ('O', @Ret) > (2) OR CHARINDEX ('O', @Ret) = (0))
	AND (CHARINDEX ('U', @Ret) > (2) OR CHARINDEX ('U', @Ret) = (0))
	AND LEN(@Ret) > 2
	AND RIGHT(LEFT(@Ret,3),1) = ' ' -- 4th char is a space
	SET @Ret = UPPER(LEFT(@Ret,2)) + ' ' + RIGHT(@Ret, LEN(@Ret) - (3))

	-- Crudely set 1st 2 chars upper case if ONLY vowels ... WIP !!!!!! NOT QORKING FOR NOW but if 2 chars and then a space, OK with upper for now
	IF NOT ((CHARINDEX ('A', @Ret) > (2) OR CHARINDEX ('A', @Ret) = (0))
	AND (CHARINDEX ('E', @Ret) > (2) OR CHARINDEX ('E', @Ret) = (0))
	AND (CHARINDEX ('I', @Ret) > (2) OR CHARINDEX ('I', @Ret) = (0))
	AND (CHARINDEX ('O', @Ret) > (2) OR CHARINDEX ('O', @Ret) = (0))
	AND (CHARINDEX ('U', @Ret) > (2) OR CHARINDEX ('U', @Ret) = (0)))
	AND LEN(@Ret) > 2
	AND RIGHT(LEFT(@Ret,3),1) = ' ' -- 4th char is a space
	SET @Ret = UPPER(LEFT(@Ret,2)) + ' ' + RIGHT(@Ret, LEN(@Ret) - (3))

	-- Next ...
	SET @Ret = REPLACE(@Ret, 'Hl ', 'HL ')

	SET @Ret = REPLACE(@Ret, 'Ishares', 'iShares')
	SET @Ret = REPLACE(@Ret, 'Betashares', 'BetaShares')
	SET @Ret = REPLACE(@Ret, 'Blackrock', 'BlackRock')
	SET @Ret = REPLACE(@Ret, 'Comstage', 'ComStage')
	SET @Ret = REPLACE(@Ret, 'Etfmg', 'ETFMG')
	SET @Ret = REPLACE(@Ret, 'Uk', 'UK')
	SET @Ret = REPLACE(@Ret, 'Db ', 'DB ')
	SET @Ret = REPLACE(@Ret, 'Dnu', 'DNU')
	SET @Ret = REPLACE(@Ret, 'Mdax', 'MDAX')
	SET @Ret = REPLACE(@Ret, 'Ibex', 'IBEX')
	SET @Ret = REPLACE(@Ret, 'EPRA', 'EPRA')
	SET @Ret = REPLACE(@Ret, 'Topix', 'TOPIX')
	SET @Ret = REPLACE(@Ret, '(Em)', '(EM)')
	SET @Ret = REPLACE(@Ret, 'Aex', 'AEX')
	SET @Ret = REPLACE(@Ret, 'Vse', 'VSE')
	SET @Ret = REPLACE(@Ret, 'Atx', 'ATX')
	SET @Ret = REPLACE(@Ret, 'Bse', 'BSE')
	SET @Ret = REPLACE(@Ret, 'Iboxx', 'IBOXX')
	SET @Ret = REPLACE(@Ret, 'Rafi', 'RAFI')
	SET @Ret = REPLACE(@Ret, 'IntgRAFIn', 'Intgrafin')
	SET @Ret = REPLACE(@Ret, ' Imi', ' IMI')
	SET @Ret = REPLACE(@Ret, 'Acwi', 'ACWI')
	SET @Ret = REPLACE(@Ret, 'Hfrx', 'HFRX')
	SET @Ret = REPLACE(@Ret, 'Ebf', 'EBF')
	SET @Ret = REPLACE(@Ret, 'PSI', 'PSI')
	SET @Ret = REPLACE(@Ret, ' Cac ', ' CAC ')
	SET @Ret = REPLACE(@Ret, 'Nareit', 'NAREIT')
	SET @Ret = REPLACE(@Ret, ' Ac ', ' AC ')
	SET @Ret = REPLACE(@Ret, ' Eb ', ' EB ')
	SET @Ret = REPLACE(@Ret, ' Gl ', ' GL ')
	SET @Ret = REPLACE(@Ret, 'Dj ', 'DJ ')
	SET @Ret = REPLACE(@Ret, 'Cny', 'CNY')
	SET @Ret = REPLACE(@Ret, 'Mena', 'MENA')
	SET @Ret = REPLACE(@Ret, ' Usa', ' USA')
	SET @Ret = REPLACE(@Ret, 'Dax', 'DAX')
	SET @Ret = REPLACE(@Ret, 'Eaf', 'EAF')
	SET @Ret = REPLACE(@Ret, 'Eafe', 'EAFE')
	SET @Ret = REPLACE(@Ret, 'Emu', 'EMU')
	SET @Ret = REPLACE(@Ret, 'Crsp', 'CRSP')
	SET @Ret = REPLACE(@Ret, ' And ', ' and ')
	SET @Ret = REPLACE(@Ret, 'Csi ', 'CSI ')
	SET @Ret = REPLACE(@Ret, 'aCSI', 'acsi')
	SET @Ret = REPLACE(@Ret, 'Gbp', 'GBP')
	SET @Ret = REPLACE(@Ret, 'Eur', 'EUR')
	SET @Ret = REPLACE(@Ret, 'Usd', 'USD')
	SET @Ret = REPLACE(@Ret, 'Jpn', 'JPN')
	SET @Ret = REPLACE(@Ret, 'Mxn', 'MXN')
	SET @Ret = REPLACE(@Ret, 'Cad', 'CAD')
	SET @Ret = REPLACE(@Ret, 'Chf', 'CHF')
	SET @Ret = REPLACE(@Ret, 'Nb ', 'NB ')
	SET @Ret = REPLACE(@Ret, ' Ex ', ' ex ')
	SET @Ret = REPLACE(@Ret, ' Inc ', ' Inc ') -- inc
	SET @Ret = REPLACE(@Ret, ' Vt ', ' VT ')
	SET @Ret = REPLACE(@Ret, 'Invt', 'INVT')
	SET @Ret = REPLACE(@Ret, ' Lse', ' LSE') -- Beware, Chelsea
	SET @Ret = REPLACE(@Ret, 'Stoxx', 'STOXX')
	SET @Ret = REPLACE(@Ret, 'Bric ', 'BRIC ')
	SET @Ret = REPLACE(@Ret, 'Reit', 'REIT')
	SET @Ret = REPLACE(@Ret, 'Klci', 'KLCI')
	SET @Ret = REPLACE(@Ret, 'Emea', 'EMEA')
	SET @Ret = REPLACE(@Ret, 'Qvm', 'QVM')
	SET @Ret = REPLACE(@Ret, 'Abf', 'ABF')
	SET @Ret = REPLACE(@Ret, 'Ipox', 'IPOX')
	SET @Ret = REPLACE(@Ret, 'Ucits', 'UCITS')
	SET @Ret = REPLACE(@Ret, 'Msci', 'MSCI')
	SET @Ret = REPLACE(@Ret, 'Aj ', 'AJ ')
	SET @Ret = REPLACE(@Ret, 'Jb ', 'JB ')
	SET @Ret = REPLACE(@Ret, ' Ii', ' II')
	SET @Ret = REPLACE(@Ret, ' Iii', ' III')
	SET @Ret = REPLACE(@Ret, ' Iv ', ' IV ') -- Ives
	SET @Ret = REPLACE(@Ret, ' Vi', ' VI') -- Beware, dividEND
	SET @Ret = REPLACE(@Ret, ' Vii', ' VII')
	SET @Ret = REPLACE(@Ret, ' Wh1', ' WH1')
	SET @Ret = REPLACE(@Ret, ' Viii', ' VIII')
	SET @Ret = REPLACE(@Ret, ' (Ah) ', ' (AH) ')
	SET @Ret = REPLACE(@Ret, ' Xi ', ' XI ')
	SET @Ret = REPLACE(@Ret, ' VIetnam', ' Vietnam') -- Beware, dividEND
	SET @Ret = REPLACE(@Ret, ' Rq ', ' RQ ')
	SET @Ret = REPLACE(@Ret, ' Ax ', ' AX ')
	SET @Ret = REPLACE(@Ret, ' Ea ', ' EA ')
	SET @Ret = REPLACE(@Ret, ' Zx ', ' ZX ')
	SET @Ret = REPLACE(@Ret, ' Vix ', ' VIX ')
	SET @Ret = REPLACE(@Ret, ' Vlx ', ' VLX ')
	SET @Ret = REPLACE(@Ret, ' Csop ', ' CSOP ')
	SET @Ret = REPLACE(@Ret, ' Hsi ', ' HSI ')
	SET @Ret = REPLACE(@Ret, ' Hscei ', ' HSCEI ')
	SET @Ret = REPLACE(@Ret, ' Isf ', ' ISF ')
	SET @Ret = REPLACE(@Ret, ' Zh ', ' ZH ')
	SET @Ret = REPLACE(@Ret, ' Rt2 ', ' RT2 ')
	SET @Ret = REPLACE(@Ret, ' Tp3', ' TP3')
	SET @Ret = REPLACE(@Ret, ' Rm ', ' RM ')
	SET @Ret = REPLACE(@Ret, ' Xc ', ' XC ')
	SET @Ret = REPLACE(@Ret, ' Zd ', ' ZD ')
	SET @Ret = REPLACE(@Ret, ' Ad ', ' AD ')
	SET @Ret = REPLACE(@Ret, ' Ec ', ' EC ')
	SET @Ret = REPLACE(@Ret, ' Am ', ' AM ')
	SET @Ret = REPLACE(@Ret, ' Ic ', ' IC ')
	SET @Ret = REPLACE(@Ret, ' Nav ', ' NAV ')
	SET @Ret = REPLACE(@Ret, ' A4rf ', ' A4RF ')
	SET @Ret = REPLACE(@Ret, ' Iu ', ' IU ')
	SET @Ret = REPLACE(@Ret, ' Etf', ' ETF')
	SET @Ret = REPLACE(@Ret, 'Etfs', 'ETFS')
	SET @Ret = REPLACE(@Ret, ' Vct', ' VCT')
	SET @Ret = REPLACE(@Ret, 'Sjp ', 'SJP ')
	SET @Ret = REPLACE(@Ret, 'Ssga ', 'SSGA ')
	SET @Ret = REPLACE(@Ret, ' Glg ', ' GLG ')
	SET @Ret = REPLACE(@Ret, 'Spdr ', 'SPDR ')
	-- SET @Ret = REPLACE(@Ret, ' Grp', ' GRP')
	SET @Ret = REPLACE(@Ret, 'Cvs ', 'CVS ')
	SET @Ret = REPLACE(@Ret, 'Ncc ', 'NCC ')
	SET @Ret = REPLACE(@Ret, 'Svs ', 'SVS ')
	SET @Ret = REPLACE(@Ret, ' Tpi ', ' TPI ')
	SET @Ret = REPLACE(@Ret, 'EURo', 'Euro')
	-- SET @Ret = REPLACE(@Ret, 'Ao ', 'AO ') -- PEKAO
	SET @Ret = REPLACE(@Ret, 'Bp', 'BP')
	SET @Ret = REPLACE(@Ret, 'Bg ', 'BG ')
	SET @Ret = REPLACE(@Ret, 'Bgeo ', 'BGEO ')
	SET @Ret = REPLACE(@Ret, 'Cppg', 'CPPG')
	SET @Ret = REPLACE(@Ret, 'Ceps', 'CEPS')
	SET @Ret = REPLACE(@Ret, 'Lidco', 'LIDCO')
	SET @Ret = REPLACE(@Ret, 'Cf ', 'CF ')
	SET @Ret = REPLACE(@Ret, 'Ubs ', 'UBS ')
	SET @Ret = REPLACE(@Ret, 'Bhp', 'BHP')
	SET @Ret = REPLACE(@Ret, 'Hsbc ', 'HSBC ')
	SET @Ret = REPLACE(@Ret, 'Gam ', 'GAM ')
	SET @Ret = REPLACE(@Ret, 'Cfic ', 'CFIC ')
	SET @Ret = REPLACE(@Ret, 'Axa ', 'AXA ')
	SET @Ret = REPLACE(@Ret, 'Bae ', 'BAE ')
	SET @Ret = REPLACE(@Ret, 'Bba ', 'BBA ')
	SET @Ret = REPLACE(@Ret, 'Crh ', 'CRH ')
	SET @Ret = REPLACE(@Ret, 'Jpm', 'JPM')
	SET @Ret = REPLACE(@Ret, '7im', '7IM')
	SET @Ret = REPLACE(@Ret, 'Pfs', 'PFS')
	SET @Ret = REPLACE(@Ret, 'Fp ', 'FP ')
	SET @Ret = REPLACE(@Ret, ' Ip ', ' IP ')
	SET @Ret = REPLACE(@Ret, 'Tb ', 'TB ')
	SET @Ret = REPLACE(@Ret, 'Svm ', 'SVM ')
	SET @Ret = REPLACE(@Ret, 'Ftse', 'FTSE')
	SET @Ret = REPLACE(@Ret, 'Nasdaq', 'NASDAQ')
	SET @Ret = REPLACE(@Ret, 'Kbw', 'KBW')
	-- SET @Ret = REPLACE(@Ret, 'WS', 'ws')
	SET @Ret = REPLACE(@Ret, ' Ws ', ' WS ')
	SET @Ret = REPLACE(@Ret, ' Dis ', ' DIS ')
	SET @Ret = REPLACE(@Ret, 'Asx ', 'ASX ')
	SET @Ret = REPLACE(@Ret, ' Us ', ' US ')
	SET @Ret = REPLACE(@Ret, ' It2 ', ' IT2 ')
	SET @Ret = REPLACE(@Ret, ' And ', ' and ')
	SET @Ret = REPLACE(@Ret, ' Tm ', ' TM ')
	SET @Ret = REPLACE(@Ret, ' Trn ', ' TRN ')
	SET @Ret = REPLACE(@Ret, ' Iq ', ' IQ ')
	SET @Ret = REPLACE(@Ret, ' Msci ', ' MSCI ')
	SET @Ret = REPLACE(@Ret, ' Ucits ', ' UCITS ')
	SET @Ret = REPLACE(@Ret, ' Cmci ', ' CMCI ')
	SET @Ret = REPLACE(@Ret, 'Ifsl', 'IFSL')
	SET @Ret = REPLACE(@Ret, 'Mgts ', 'MGTS ')
	SET @Ret = REPLACE(@Ret, ' Ag ', ' AG ')
	SET @Ret = REPLACE(@Ret, ' Hbc ', ' HBC ')

	SET @Ret = REPLACE(@Ret, ' Mlp ', ' MLP ')
	SET @Ret = REPLACE(@Ret, ' Dwa ', ' DWA ')
	SET @Ret = REPLACE(@Ret, ' Vix ', ' VLX ')
	SET @Ret = REPLACE(@Ret, ' Ltn ', ' LTN ')
	SET @Ret = REPLACE(@Ret, ' Gif ', ' GIF ')
	SET @Ret = REPLACE(@Ret, ' Gis ', ' GIS ')
	SET @Ret = REPLACE(@Ret, 'Wssf ', 'WSSF ')
	SET @Ret = REPLACE(@Ret, '1ST', '1st')
	SET @Ret = REPLACE(@Ret, 'PLC', 'Plc')
	SET @Ret = REPLACE(@Ret, 'Jpy', 'JPY')
	SET @Ret = REPLACE(@Ret, 'Hkd', 'HKD')
	SET @Ret = REPLACE(@Ret, ' Sinc ', ' SInc ')
	SET @Ret = REPLACE(@Ret, ' It ', ' IT ')
	SET @Ret = REPLACE(@Ret, ' Ma ', ' MA ')
	SET @Ret = REPLACE(@Ret, ' Pq ', ' PQ ')
	SET @Ret = REPLACE(@Ret, ' Td ', ' TD ')
	SET @Ret = REPLACE(@Ret, ' Gf ', ' GF ')
	SET @Ret = REPLACE(@Ret, ' Rf ', ' RF ')
	SET @Ret = REPLACE(@Ret, ' Rt ', ' RT ')
	SET @Ret = REPLACE(@Ret, ' If ', ' IF ')
	SET @Ret = REPLACE(@Ret, 'Aap ', 'AAP ')
	SET @Ret = REPLACE(@Ret, 'Ahfm ', 'AHFM ')
	SET @Ret = REPLACE(@Ret, 'Caf ', 'CAF ')
	SET @Ret = REPLACE(@Ret, ' Pe ', ' PE ')
	SET @Ret = REPLACE(@Ret, ' Mf', '  MF')
	SET @Ret = REPLACE(@Ret, 'OCADo', 'Ocado')
	SET @Ret = REPLACE(@Ret, 'UKraine', 'Ukraine')
	SET @Ret = REPLACE(@Ret, 'Nyse', 'NYSE')
	SET @Ret = REPLACE(@Ret, 'Micex', 'MICEX')
	SET @Ret = REPLACE(@Ret, 'Klse', 'KLSE')
	SET @Ret = REPLACE(@Ret, 'Nikkei', 'NIKKEI')
	SET @Ret = REPLACE(@Ret, 'Jkse', 'JKSE')
	SET @Ret = REPLACE(@Ret, 'Ipsa', 'IPSA')
	SET @Ret = REPLACE(@Ret, ' Mib', ' MIB')
	SET @Ret = REPLACE(@Ret, 'Ipc ', 'IPC ')
	SET @Ret = REPLACE(@Ret, 'Xao', 'XAO')
	SET @Ret = REPLACE(@Ret, 'Jpx', 'JPX')
	SET @Ret = REPLACE(@Ret, 'Bmo ', 'BMO ')
	SET @Ret = REPLACE(@Ret, ' Etc', ' ETC')
	SET @Ret = REPLACE(@Ret, '''S', '''s')
	SET @Ret = REPLACE(@Ret, ' Cta ', ' CTA ')
	SET @Ret = REPLACE(@Ret, ' Bcc ', ' BCC ')
	SET @Ret = REPLACE(@Ret, ' Sicav ', ' SICAV ')
	SET @Ret = REPLACE(@Ret, 'Qqq', 'QQQ')
	SET @Ret = REPLACE(@Ret, 'Kcom', 'KCOM')
	SET @Ret = REPLACE(@Ret, ' Wti ', ' WTI ')
	SET @Ret = REPLACE(@Ret, ' Pm ', ' PM ')
	SET @Ret = REPLACE(@Ret, ' Wti ', ' WTI ')
	SET @Ret = REPLACE(@Ret, 'Asos ', 'ASOS ')
	SET @Ret = REPLACE(@Ret, 'Mti ', 'MTI ')
	SET @Ret = REPLACE(@Ret, 'Egx', 'EGX')
	SET @Ret = REPLACE(@Ret, 'Pphe', 'PPHE')
	SET @Ret = REPLACE(@Ret, 'Idox', 'IDOX')
	SET @Ret = REPLACE(@Ret, 'Hicl', 'HICL')
	SET @Ret = REPLACE(@Ret, ' Zna ', ' ZNA ')
	SET @Ret = REPLACE(@Ret, ' Llc', ' LLC')
	SET @Ret = REPLACE(@Ret, ' Llp', ' LLP')

	SET @Ret = REPLACE(@Ret, ' Bull ', ' BULL ')
	SET @Ret = REPLACE(@Ret, ' Bear ', ' BEAR ')
	SET @Ret = REPLACE(@Ret, 'Northern BEAR ', 'Northern Bear ')
	SET @Ret = REPLACE(@Ret, ' Long ', ' LONG ')
	SET @Ret = REPLACE(@Ret, ' Short ', ' SHORT ')
	SET @Ret = REPLACE(@Ret, ' Inverse ', ' INVERSE ')
	-- SET @Ret = REPLACE(@Ret, 'Emis', 'EMIS')

	-- select * FROM [Alchemy_Data].[DIM].currency

	IF LEFT (@Ret,2) = 'Ia'
	SET @Ret = 'IA' + RIGHT(@Ret, LEN(@Ret) - (2))

	IF LEFT (@Ret,2) = 'Tm'
	SET @Ret = 'TM' + RIGHT(@Ret, LEN(@Ret) - (2))

	IF LEFT (@Ret,2) = 'Mv'
	SET @Ret = 'MV' + RIGHT(@Ret, LEN(@Ret) - (2))

	IF LEFT (@Ret,2) = 'Ws'
	SET @Ret = 'WS' + RIGHT(@Ret, LEN(@Ret) - (2))

	IF LEFT (@Ret,3) = 'NSE'
	SET @Ret = 'NSE' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Irl'
	SET @Ret = 'IRL' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Sjp'
	SET @Ret = 'SJP' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Ps '
	SET @Ret = 'PS ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'ST '
	SET @Ret = 'St ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'TSE'
	SET @Ret = 'TSE' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,4) = 'TSEC'
	SET @Ret = 'TSEC' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,3) = 'Ssp'
	SET @Ret = 'SSP' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Lsl'
	SET @Ret = 'LSL' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Hs '
	SET @Ret = 'HS ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Ps '
	SET @Ret = 'PS ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Gs '
	SET @Ret = 'GS ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Bt '
	SET @Ret = 'BT ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Ao '
	SET @Ret = 'AO ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Jd '
	SET @Ret = 'JD ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Hgc'
	SET @Ret = 'HGC' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Rws'
	SET @Ret = 'RWS' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Jgf'
	SET @Ret = 'JGF' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Bh '
	SET @Ret = 'BH ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Mj '
	SET @Ret = 'MJ ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,4) = 'MFS '
	SET @Ret = 'MFS ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Cac '
	SET @Ret = 'CAC ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Bel '
	SET @Ret = 'BEL ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Asa '
	SET @Ret = 'ASA ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Smi '
	SET @Ret = 'SMI ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Egx '
	SET @Ret = 'EGX ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Sse '
	SET @Ret = 'SSE ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Lxi '
	SET @Ret = 'LXI ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,5) = 'Rbob '
	SET @Ret = 'RBOB ' + RIGHT(@Ret, LEN(@Ret) - (5))

	IF LEFT (@Ret,5) = 'Bbgi '
	SET @Ret = 'BBGI ' + RIGHT(@Ret, LEN(@Ret) - (5))

	IF LEFT (@Ret,5) = 'Bats '
	SET @Ret = 'BATS ' + RIGHT(@Ret, LEN(@Ret) - (5))

	IF LEFT (@Ret,5) = 'Emis '
	SET @Ret = 'EMIS ' + RIGHT(@Ret, LEN(@Ret) - (5))

	IF LEFT (@Ret,5) = 'Iota '
	SET @Ret = 'IOTA ' + RIGHT(@Ret, LEN(@Ret) - (5))

	IF LEFT (@Ret,4) = 'Bnpp'
	SET @Ret = 'BNPP' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Nem '
	SET @Ret = 'NEM ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Neo '
	SET @Ret = 'NEO ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Zcash'
	SET @Ret = 'ZCash' + RIGHT(@Ret, LEN(@Ret) - (5))

	IF LEFT (@Ret,3) = 'ST.'
	SET @Ret = 'St.' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Mcc'
	SET @Ret = 'McC' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Iwi'
	SET @Ret = 'IWI' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Nfu'
	SET @Ret = 'NFU' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,4) = 'Sig '
	SET @Ret = 'SIG ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Icg '
	SET @Ret = 'ICG ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Sli '
	SET @Ret = 'SLI ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,3) = 'Mcb'
	SET @Ret = 'McB' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,4) = 'McB '
	SET @Ret = 'MCB ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Batm'
	SET @Ret = 'BATM' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,3) = 'Mcd'
	SET @Ret = 'McD' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'ON '
	SET @Ret = 'On ' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Tui'
	SET @Ret = 'TUI' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Udg'
	SET @Ret = 'UDG' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Ubm'
	SET @Ret = 'UBM' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Tla'
	SET @Ret = 'TLA' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Tau'
	SET @Ret = 'TAU' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Rsa'
	SET @Ret = 'RSA' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Lpa'
	SET @Ret = 'LPA' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Itv'
	SET @Ret = 'ITV' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Ite'
	SET @Ret = 'ITE' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Iwg'
	SET @Ret = 'IWG' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Iqe'
	SET @Ret = 'IQE' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Irf'
	SET @Ret = 'IRF' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Ekf'
	SET @Ret = 'EKF' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Ecr'
	SET @Ret = 'ECR' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Bca'
	SET @Ret = 'BCA' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Apc'
	SET @Ret = 'APC' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Csr'
	SET @Ret = 'CSR' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Zca'
	SET @Ret = 'ZCa' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Rhi'
	SET @Ret = 'RHI' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,3) = 'Opg'
	SET @Ret = 'OPG' + RIGHT(@Ret, LEN(@Ret) - (3))

	IF LEFT (@Ret,4) = 'Igas'
	SET @Ret = 'IGas' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Eos '
	SET @Ret = 'EOS ' + RIGHT(@Ret, LEN(@Ret) - (4))

	IF LEFT (@Ret,4) = 'Aew '
	SET @Ret = 'AEW ' + RIGHT(@Ret, LEN(@Ret) - (4))

	-- IF LEFT (@Ret,3) = 'Db '
	-- SET @Ret = 'DB ' + RIGHT(@Ret, LEN(@Ret) - (3))

	SET @Ret = REPLACE(@Ret, 'EURAsia', 'EURASIA')

	RETURN @Ret

/*	Find NAME = LABEL
	select RIGHT(LEFT(investment_name, len(primary_label)-0), 1) , *
	from DIM.v_INVESTMENT
	where PRIMARY_LABEL = LEFT(investment_name, len(primary_label))
	and ' ' = RIGHT(LEFT(investment_name, len(primary_label)+1), 1)
	and RIGHT(LEFT(investment_name, len(primary_label)-0), 1) NOT LIKE '[AEIOU]'
*/
END


GO
/****** Object:  StoredProcedure [BLD].[DELME_usp_SEND_THINKPAD_EMAILS]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[DELME_usp_SEND_THINKPAD_EMAILS]
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
	-- EXEC [BLD].[usp_SEND_THINKPAD_EMAILS]
	-- ==================================================================================================================================

	DECLARE @INSTANCES_OF_THIS_SUBJECT_MSG VARCHAR(3000), @PARENT_USP VARCHAR(250)
	DECLARE @SQLMailProfile [varchar](255), @SendTo [varchar](255), @CC [varchar](255), @BCC [varchar](255), @SUBJECT [varchar](255)
	,@Body [varchar](max), @Attachments [varchar](max), @SendAsHTML [bit], @SendAsCritical [bit]

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')

	DECLARE db_cursor_email CURSOR FOR  

	SELECT [SQLMailProfile], [SendTo], [CC], [BCC], [Subject], [Body], [Attachments], [SendAsHTML], [SendAsCritical]
	FROM -- [THINKPAD_R7_ALCHEMY_DATA].
	[Alchemy_Data].[BLD].[SQLMailLog]
	WHERE ISNULL([PROCESSED], (0)) <> (1)
	ORDER BY [Subject]

	OPEN db_cursor_email   
	FETCH NEXT FROM db_cursor_email INTO @SQLMailProfile, @SendTo, @CC, @BCC, @SUBJECT, @Body, @Attachments, @SendAsHTML, @SendAsCritical

	DECLARE @v_ERR INT, @REPORT_BATCH INT, @RET_VALUE int, @INSTANCES_OF_THIS_SUBJECT INT, @OLD_SUBJECT VARCHAR(2500)

	SET @INSTANCES_OF_THIS_SUBJECT = (0)
	SET @OLD_SUBJECT = ''

	WHILE @@FETCH_STATUS = 0   
	BEGIN

		-- ==================================================================================================================================
		-- TRY TO MANAGE MULTIPLE ERROR MESSAGES e.g. 'FETCH NEXT FROM db_cursor_investment'
		-- ==================================================================================================================================
		IF LEFT(@SUBJECT,20) = LEFT(@OLD_SUBJECT,20) -- ignore trailing ingo in subject e.g. DATE\TIME
			SET @INSTANCES_OF_THIS_SUBJECT = @INSTANCES_OF_THIS_SUBJECT + (1)
		ELSE
			SET @INSTANCES_OF_THIS_SUBJECT = (1)

		IF @INSTANCES_OF_THIS_SUBJECT <= (3)
		BEGIN
			EXEC @RET_VALUE =  [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @SUBJECT, @Body
		END
		ELSE IF @INSTANCES_OF_THIS_SUBJECT = (4)
		BEGIN
			SET @SUBJECT = 'Warning - many - ' + @SUBJECT
			EXEC @RET_VALUE =  [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @SUBJECT, @Body
		END
		ELSE -- @INSTANCES_OF_THIS_SUBJECT > (4)
		BEGIN
			SET @RET_VALUE = (0)
		END

		IF @RET_VALUE <> 0
		BEGIN
			SET @INSTANCES_OF_THIS_SUBJECT_MSG = 'E: Error has occured ' + CONVERT(VARCHAR(10),@RET_VALUE)
			PRINT @INSTANCES_OF_THIS_SUBJECT_MSG 
			-- EXEC [ALCHEMY_DATA].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @INSTANCES_OF_THIS_SUBJECT_MSG, @vRE
			CLOSE db_cursor_email   
			DEALLOCATE db_cursor_email 
			RETURN 255
		END
		ELSE
		BEGIN
			UPDATE -- [THINKPAD_R7_ALCHEMY_DATA].
			[Alchemy_Data].[BLD].[SQLMailLog]
			SET [PROCESSED] = (1)
			WHERE [SQLMailProfile] = @SQLMailProfile
			AND   ISNULL([SendTo],'') = ISNULL(@SendTo,'')
			AND   ISNULL([Subject],'') = ISNULL(@SUBJECT,'')
		END

		SET @OLD_SUBJECT = @SUBJECT

		FETCH NEXT FROM db_cursor_email INTO @SQLMailProfile, @SendTo, @CC, @BCC, @SUBJECT, @Body, @Attachments, @SendAsHTML, @SendAsCritical
	END

	CLOSE db_cursor_email   
	DEALLOCATE db_cursor_email 

END
GO
/****** Object:  StoredProcedure [BLD].[DELME_usp_sendSMTPEmail_sp_send_dbmail]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[DELME_usp_sendSMTPEmail_sp_send_dbmail] 
	@SQLMailProfile varchar(255) = 'Red7 Profile', 
	@SendTo varchar(255) = '', 
	@CC varchar(255) = '', 
	@BCC varchar(255) = '', 
	@Subject varchar(255) = '', 
	@Body varchar(max) = '', 
	@Attachments varchar(max) = '', 
	@SendAsHTML bit = 0, 
	@SendAsCritical bit = 0,
	@Processed bit = 0
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
/****** Object:  StoredProcedure [BLD].[usp_AUDIT_USE_OF_USP]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_AUDIT_USE_OF_USP] (@PARENT_USP VARCHAR(500), @BUILD_ID INT = -1, @BUILD_TYPE CHAR(1) = 'U') AS
BEGIN
	-- =============================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP# (Note: All prices stored in GBP)
	-- Created:	July 2016
	-- Version History:
	-- 1.0		Initial Release (1.1 2016110 Moved to Azure)
	--
	-- [BLD].[usp_AUDIT_USE_OF_USP] 'ALEX'
	-- SELECT * FROM [BLD].[LOAD_STATUS] WHERE [BUILD_ID] = -(1)
	-- =============================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	--
	-- =============================================================================================================================================================================================

	BEGIN TRY
		IF NOT EXISTS (SELECT (1) FROM [Alchemy_Data].[BLD].[LOAD_STATUS] WHERE [PARENT_USP] = @PARENT_USP AND [BUILD_ID] = @BUILD_ID)
			INSERT INTO [Alchemy_Data].[BLD].[LOAD_STATUS]
			([BUILD_ID], [ENTRY_DATETIME], [PARENT_USP], [ENTRY_NOTES], [BUILD_TYPE], [KEY_STAGE])
			VALUES (@BUILD_ID, GETDATE() , @PARENT_USP, 'I: Audit use of USP', @BUILD_TYPE, (0))
		ELSE
			UPDATE [Alchemy_Data].[BLD].[LOAD_STATUS]
			SET [ENTRY_DATETIME] = GETDATE()
			WHERE [BUILD_ID] = @BUILD_ID
			AND [PARENT_USP] = @PARENT_USP
			AND [ENTRY_NOTES] = 'I: Audit use of USP'
	END TRY

	BEGIN CATCH
 		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] 'Audit use of USP'
		RETURN (255)
	END CATCH

	IF (1) = (0)
	SELECT * FROM [Alchemy_Data].[BLD].[LOAD_STATUS] WHERE [PARENT_USP] = @PARENT_USP
	AND [BUILD_ID] = -(1)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] (@BUILD_ID INT = 0
, @PARENT_USP VARCHAR(500) = 'NA'
, @PRE_HEADER VARCHAR(100) = 'M:'
, @HEADER VARCHAR(2500) = '<DEFAULT HEADER>'
, @BUILD_TYPE CHAR(1) = 'R'
, @KEY_STAGE INT = 0
, @DEBUG INT = 0
, @INITIALISE_END_DATETIME INT = 0)
AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Corrected EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @HEADER to include all variables and LABELLED !!!
	-- 1.2		20190213 Remove AZURE_R7_ALCHEMY_DATA
	-- 1.3		20190313 PRINT TO SCREEN !!
	-- 
	-- Note: We have a FN and USP for this as the FN is called from another FN - the USP can't be called from FN. The USP has error handling unlike the FN
	-- [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @HEADER = 'Hello'
	-- ===============================================================================================================================================================================================================

	SET DATEFORMAT DMY
	SET NOCOUNT ON

	-- ===============================================================================================================================================================================================================
	-- DECLARE VARIABLES
	-- ===============================================================================================================================================================================================================
	DECLARE @I_MSG_2500 VARCHAR(500), @ENTRY_DATETIME DATETIME, @END_DATETIME DATETIME

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	IF @DEBUG = (1) PRINT '[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] A1'

	SELECT @I_MSG_2500 = @PRE_HEADER + ' ' + CONVERT(VARCHAR(25),GETDATE(), 121)+ ' ' + @HEADER
	PRINT @I_MSG_2500 -- 20191303 added

	IF @DEBUG = (1) PRINT '[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] A1b'

	-- RAISERROR (@I_MSG_2500,10,1) WITH NOWAIT -- ELSE PRINT @I_MSG_2500
	/* DOES NOT LIKE;
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = 4112, @BUILD_TYPE ='F', @PARENT_USP = 'EAH TEST', @PRE_HEADER = 'M:'
	, @HEADER = '%.ARC.%:@TimeLimit:7200:@FragmentationLevel2:75', @KEY_STAGE = 0, @debug = 1
	*/

	IF @DEBUG = (1) PRINT '[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] A2'

	-- ===============================================================================================================================================================================================================
	-- UPDATE END DATE OF PREVIOUS STEP (IF THERE IS ONE)
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		UPDATE [Alchemy_Data].[BLD].[LOAD_STATUS] -- 20190213 [AZURE_R7_ALCHEMY_DATA].
		SET [END_DATETIME] = GETDATE()
		WHERE [BUILD_ID] = @BUILD_ID
		-- AND [PARENT_USP] = @PARENT_USP  -- SHOULD BE ONLY ONE OF THESE ....
		AND [END_DATETIME] IS NULL
	END TRY

	BEGIN CATCH
 		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @HEADER, @BUILD_TYPE = @BUILD_TYPE
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT '[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] A3'

	-- ===============================================================================================================================================================================================================
	-- ADD A ROW
	-- ===============================================================================================================================================================================================================

	SET @ENTRY_DATETIME = GETDATE()
	IF @INITIALISE_END_DATETIME = (1)
		SET @END_DATETIME = @ENTRY_DATETIME
	ELSE
		SET @END_DATETIME = NULL

	BEGIN TRY
		INSERT INTO [Alchemy_Data].[BLD].[LOAD_STATUS] -- 20190213 [AZURE_R7_ALCHEMY_DATA].
		([BUILD_ID], [ENTRY_DATETIME], [END_DATETIME], [PARENT_USP], [ENTRY_NOTES], [BUILD_TYPE], [KEY_STAGE])
		VALUES (@BUILD_ID, @ENTRY_DATETIME, @END_DATETIME, @PARENT_USP, LEFT(@PRE_HEADER + @HEADER,250), @BUILD_TYPE, @KEY_STAGE) -- 255 is size of the column !!!!!!!
	END TRY
	BEGIN CATCH
-- 		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @HEADER
 		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID  = @BUILD_ID, @HEADER = @HEADER, @BUILD_TYPE = @BUILD_TYPE
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_SENDSMTPEmail]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_SENDSMTPEmail]
	@SQLMailProfile varchar(255) = 'Email for Alchemy',  -- 'Red7 Profile', 
	@SENDTo varchar(255) = '', 
	@CC varchar(255) = '', 
	@BCC varchar(255) = '', 
	@Subject varchar(255) = '', 
	@Body varchar(max) = '', 
	@Attachments varchar(max) = '', 
	@SENDAsHTML bit = 0, 
	@SENDAsCritical bit = 0,
	@Processed bit = -1
AS
BEGIN 

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Remove [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190508 Process = -1 and SEND THE EMAIL
	-- ===============================================================================================================================================================================================================

	SET DATEFORMAT DMY
	SET NOCOUNT ON

	-- ===============================================================================================================================================================================================================
	-- FORCE THIS THROUGH AS CHANGES TO OTHER USPs needed to soak up the change in profile name
	-- ===============================================================================================================================================================================================================
	SET @SQLMailProfile = 'Email for Alchemy'

	-- ===============================================================================================================================================================================================================
	-- VARIABLE DECLARATIONS
	-- ===============================================================================================================================================================================================================
	DECLARE @BodyFormat varchar(20) 
	DECLARE @Importance varchar(6) 
	
	--Populate required variables 
	IF LEN(RTRIM(ISNULL(@SQLMailProfile, ''))) = 0 SELECT @SQLMailProfile = 'Default' 
	SELECT @BodyFormat = CASE WHEN @SENDAsHTML = (1) THEN 'HTML' ELSE 'TEXT' END 
	SELECT @Importance = CASE WHEN @SENDAsCritical = (1) THEN 'High' ELSE 'Normal' END 

	SET @Subject = '' + ISNULL(@Subject,'')

	BEGIN TRY
		INSERT INTO [ALCHEMY_DATA].[BLD].[SQLMailLog] -- [AZURE_R7_ALCHEMY_DATA].
		(SQLMailProfile, SENDTo, CC, BCC, Subject, Body, Attachments, SENDAsHTML, SENDAsCritical, Processed) 
		VALUES (@SQLMailProfile, @SENDTo, @CC, @BCC, @Subject, @Body, @Attachments, @SENDAsHTML, @SENDAsCritical, @Processed)
	END TRY

	BEGIN CATCH
		DECLARE @I_MSG_2500 VARCHAR(500), @v_ROWCOUNT INT, @PARENT_USP VARCHAR(250), @RETVAL INT
		SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP -- , @BUILD_ID = @BUILD_ID
	
		SET @I_MSG_2500= 'E: Error insert into [BLD].[SQLMailLog])'
		PRINT @I_MSG_2500

		DECLARE @BUILD_ID INT
		SET @BUILD_ID = (SELECT MAX([BUILD_ID]) FROM [ALCHEMY_DATA].[BLD].[v_MONITOR_BUILD_PROCESS]) -- [AZURE_R7_ALCHEMY_DATA].
		EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @HEADER = @I_MSG_2500 -- , @HEADER = 'HEADER' --, 1
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- SEND the email
	-- ===============================================================================================================================================================================================================
	-- SELECT @@VERSION
	IF @@VERSION NOT LIKE '%Azure%' -- IF (1) = (0)
	EXEC [msdB].[dbo].[sp_send_dbmail]
		@profile_name=@SQLMailProfile, 
		@recipients=@SENDTo, 
		@copy_recipients=@CC, 
		@blind_copy_recipients=@BCC, 
		@subject=@Subject, 
		@body=@Body, 
		@body_format=@BodyFormat, 
		@importance=@Importance, 
		@file_attachments=@Attachments; 

	Finish: 
	SET NOCOUNT OFF 

/*
	select * FROM msdb.dbo.sysmail_profile
	
	EXEC [msdB].[dbo].[sp_send_dbmail]
		@profile_name='Email for Alchemy', 
		@recipients='eahind@yahoo.co.uk',
		@subject='S1',
		@body='B1'
*/
END
GO
/****** Object:  StoredProcedure [BLD].[usp_STANDARD_EMAIL]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_STANDARD_EMAIL] (@i_subject VARCHAR(255), @i_body VARCHAR(2500), @SENDTo VARCHAR(255) = null)
AS

BEGIN
	
	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	March 2016
	-- Version History:
	-- 1.0		Initial Release (1.1 2016110 Moved to Azure)
	-- 
	-- EXEC[BLD].[usp_STANDARD_EMAIL] 'Test subject', 'Hello'
	-- SELECT * FROM [BLD].[SQLMailLog]
	-- ===============================================================================================================================================================================================================

	SET DATEFORMAT DMY
	SET NOCOUNT ON

	IF @SENDTo IS NULL SET @SENDTo = 'eahind@yahoo.co.uk'

	RAISERROR (@i_subject,10,1)

	EXEC [Alchemy_Functions].[BLD].[usp_SENDSMTPEmail] @SQLMailProfile='Red7 Profile', @SENDTo=@SENDTo, @CC='', @BCC=''
	, @Subject=@i_subject, @Body=@i_body, @Attachments='', @SENDAsHTML=0, @SENDAsCritical=1, @Processed=0

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] (@i_subject VARCHAR(250)
, @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY READONLY
, @NUMBER_OF_NEW_LINES INT = NULL, @SENDTo VARCHAR(250) = NULL, @SEND_EMAIL INT = 1, @DEBUG INT = 0)
AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2017
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190306 FIX duplication of last row
	-- 
	-- EXEC[BLD].[usp_STANDARD_EMAIL] 'Test subject', 'Hello'
	-- SELECT * FROM [BLD].[SQLMailLog]
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ===============================================================================================================================================================================================================
	-- 
	-- ===============================================================================================================================================================================================================

	IF @NUMBER_OF_NEW_LINES IS NULL SET @NUMBER_OF_NEW_LINES = 1

	DECLARE @NEWLINE CHAR(2), @MESSAGE_CONTENT VARCHAR(2500), @FULL_MESSAGE VARCHAR(2500), @i INT = 1, @rc INT = 1
	SET @NEWLINE = CHAR(13) + CHAR(10)
	SET @FULL_MESSAGE = ''
	
	-- ===============================================================================================================================================================================================================
	-- BUILD THE MESSAGE
	-- ===============================================================================================================================================================================================================

	DECLARE db_cursor_message CURSOR FOR  
	SELECT [MESSAGE_CONTENT] FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ORDER BY [ID]

	SELECT @RC = (SELECT COUNT(*) FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY)

	OPEN db_cursor_message   
	FETCH NEXT FROM db_cursor_message INTO @MESSAGE_CONTENT
	SELECT @FULL_MESSAGE = @MESSAGE_CONTENT

	IF @DEBUG = (1) PRINT @i
	IF @DEBUG = (1) PRINT @MESSAGE_CONTENT

	WHILE @@FETCH_STATUS = (0) AND @i < @rc -- Needed as couldnot get rid of last line .....
	BEGIN
		SET @i = @i + 1

		FETCH NEXT FROM db_cursor_message INTO @MESSAGE_CONTENT
		SELECT @FULL_MESSAGE = @FULL_MESSAGE + REPLICATE(@NEWLINE, @NUMBER_OF_NEW_LINES) + @MESSAGE_CONTENT
		
		IF @DEBUG = (1) PRINT @i
		IF @DEBUG = (1) PRINT @MESSAGE_CONTENT
	END

	CLOSE db_cursor_message   
	DEALLOCATE db_cursor_message 

	-- ===============================================================================================================================================================================================================
	-- SEND THE MESSAGE
	-- ===============================================================================================================================================================================================================

	IF @SENDTo IS NULL SET @SENDTo = 'eahind@yahoo.co.uk'
	IF @SEND_EMAIL = (1)
	BEGIN
		IF @DEBUG = (1) PRINT 'Output: EMAIL'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @i_subject, @i_body = @FULL_MESSAGE, @SENDTo = @SENDTo
	END
	ELSE
	BEGIN
		IF @DEBUG = (1) PRINT 'Output: SCREEN'
		PRINT @FULL_MESSAGE
	END
	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_STANDARD_ERROR_HANDLING]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_STANDARD_ERROR_HANDLING] (@BUILD_ID INT = 0, @HEADER VARCHAR(2500) = 'ABCHEAD', @BUILD_TYPE CHAR(1) = 'F')
AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20170919 WRITE TO LOG ....
	-- 1.2		20190213 Changed [usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] to [fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG]
	--					 Less chance of it looping if this fails as fn does NOT do error handling
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- ================================================================================================================================================================
	--
	-- ================================================================================================================================================================

	DECLARE @I_MSG_2500 VARCHAR(2500), @PARENT_USP VARCHAR(250)
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	IF @HEADER = NULL SET @HEADER = ''

	DECLARE @ErrorNumber INT = ERROR_NUMBER()
	DECLARE @ErrorLine INT = ERROR_LINE()
	DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); -- INITIALISE
	DECLARE @ErrorProcedure NVARCHAR(4000) = ERROR_PROCEDURE() -- INITIALISE
	DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
	DECLARE @ErrorState INT = ERROR_STATE()

	DECLARE @NEWLINE CHAR(2)
	-- SELECT @NEWLINE = '' -- don't use CR for now ... CHAR(13) + CHAR(10)
	SELECT @NEWLINE = CHAR(13) + CHAR(10)

	-- SELECT @I_MSG_2500 = 'E: ' + CONVERT(VARCHAR(25),GETDATE(), 121)+ ' ' + @HEADER

	SELECT @I_MSG_2500 = CONVERT(VARCHAR(25),GETDATE(), 121) -- + ' ' + @HEADER
	SELECT @I_MSG_2500 = @I_MSG_2500 + @NEWLINE + 'Msg:'    + ISNULL(CAST(@ErrorMessage AS VARCHAR(250)),'')
	SELECT @I_MSG_2500 = @I_MSG_2500 + @NEWLINE + 'Proc:'   + ISNULL(CAST(@ErrorProcedure AS VARCHAR(250)),'')
	SELECT @I_MSG_2500 = @I_MSG_2500 + @NEWLINE + 'LineNo:' + ISNULL(CAST(@ErrorLine AS VARCHAR(10)),'')
	SELECT @I_MSG_2500 = @I_MSG_2500 + @NEWLINE + 'Sev:'    + ISNULL(CAST(@ErrorSeverity AS VARCHAR(250)),'')
	SELECT @I_MSG_2500 = @I_MSG_2500 + @NEWLINE + 'State:'  + ISNULL(CAST(@ErrorState AS VARCHAR(250)),'')
	SELECT @I_MSG_2500 = @I_MSG_2500 + @NEWLINE + 'ErrNo.:' + ISNULL(CAST(@ErrorNumber AS VARCHAR(10)),'')
	SELECT @I_MSG_2500 = @I_MSG_2500 + @NEWLINE + @NEWLINE +'Red Seven Technologies Ltd. (c)'
	-- IF @vRE = (1) RAISERROR (@I_MSG_2500,18,1) WITH LOG -- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT @I_MSG_2500 = LEFT(@I_MSG_2500 + @NEWLINE + ISNULL(CAST(@ErrorMessage AS VARCHAR(50)),''), (2500))
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'E:', @HEADER = @I_MSG_2500
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ............
	END CATCH

	IF @BUILD_ID <> (0)
	BEGIN TRY
		EXEC [Alchemy_Functions].[BLD].[usp_sENDSMTPEmail] @SQLMailProfile='Red7 Profile', @SENDTo='eahind@yahoo.co.uk', @CC='', @BCC=''
 		, @Body=@I_MSG_2500, @Subject=@HEADER, @Attachments='', @SENDAsHTML=0, @SENDAsCritical=1
	END TRY
	BEGIN CATCH
		SET @I_MSG_2500 = 'Unable to [usp_sENDSMTPEmail]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_UPDATE_STATS]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_UPDATE_STATS] (@BUILD_ID INT = 0, @BUILD_TYPE CHAR(1) = 'T'
, @Databases VARCHAR(100) = 'Alchemy_Data', @Indexes VARCHAR(100) = '%', @FORCE_IT_IN INT = NULL, @FragmentationLevel2 INT = 75
, @SortInTempdb CHAR(1) = 'N', @TimeLimit INT = 7200, @DEBUG INT = 0) -- 2 hours
AS
BEGIN

	-- ======================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP# (Note: All prices stored in GBP)
	-- Created:	December 2016
	-- Version History:
	-- 1.0
	-- 1.1		20190211 Change I: to M:
	--
	-- [BLD].[usp_UPDATE_STATS] @BUILD_ID = 0, @FORCE_IT_IN = 1
	-- sp_depENDs [BLD.usp_UPDATE_STATS]
	-- ======================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ================================================================================================================================================================
	--
	-- ================================================================================================================================================================

	DECLARE @I_MSG_2500 VARCHAR(2500), @v_ROWCOUNT INT, @PARENT_USP VARCHAR(250)
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1) PRINT 'A'

	-- ======================================================================================================================================================================================================
	-- 20180626
	-- ======================================================================================================================================================================================================

	-- SET @I_MSG_2500 = 'RETURN (0)'
	-- EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @KEY_STAGE = 0
	-- RETURN (0)

	-- ======================================================================================================================================================================================================
	-- 
	-- ======================================================================================================================================================================================================

	-- SET @I_MSG_2500 = '[dbo].[IndexOptimize] @Databases = ''Alchemy_Data'''
	SET @I_MSG_2500 = '[Alchemy_Functions].[dbo].[IndexOptimize] @Databases:' + @Databases
	+ ':@Indexes:' + @Indexes 
	+ ':@TimeLimit:' + CONVERT(VARCHAR, @TimeLimit)
	+ ':@FragmentationLevel2:' + CONVERT(VARCHAR, @FragmentationLevel2)

	IF @DEBUG = (1) PRINT 'B1'

	 EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'M:', @HEADER = @I_MSG_2500, @KEY_STAGE = 0
	-- ELSE PRINT @I_MSG_2500

	IF @DEBUG = (1) PRINT 'B2'

	BEGIN TRY
		EXEC [Alchemy_Functions].[dbo].[IndexOptimize] @Databases = @Databases, @Indexes = @Indexes, @FragmentationLevel2 = @FragmentationLevel2, @SortInTempdb = @SortInTempdb
		, @TimeLimit = @TimeLimit -- '3600' -- 1 hour
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] 0, @I_MSG_2500 -- , 1
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT 'C'

	-- ======================================================================================================================================================================================================
	-- RETURN
	-- ======================================================================================================================================================================================================

	RETURN (0)

	-- ======================================================================================================================================================================================================
	--
	-- ======================================================================================================================================================================================================

	IF @FORCE_IT_IN IS NULL
	BEGIN
		SET @I_MSG_2500 = 'RETURN (0)'
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'M:', @HEADER = @I_MSG_2500, @KEY_STAGE = 0
		-- ELSE PRINT @I_MSG_2500

		RETURN (0)
	END

	-- ======================================================================================================================================================================================================

	SET @I_MSG_2500 = 'UPDATE STATS ON ALL USER TABLES'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'M:', @HEADER = @I_MSG_2500, @KEY_STAGE = 0
	-- ELSE PRINT @I_MSG_2500

	/*
	select '    update statistics '+schema_name(schema_id) + '.' + name
	from sys.objects
	WHERE type_Desc = 'user_table'
	*/

	DECLARE  @SQLcommand NVARCHAR(512), @Table      SYSNAME 
 
	DECLARE curAllTables CURSOR  FOR 
	SELECT [table_schema] + '.' + [table_name]
	FROM   information_schema.tables 
	WHERE  TABLE_TYPE = 'BASE TABLE'
	AND [table_name] NOT LIKE 'ZZ%'
	AND [table_name] NOT LIKE '%201[6789]%'
	ORDER BY 1 

	OPEN curAllTables 
 
	FETCH NEXT FROM curAllTables 
	INTO @Table 
 
	WHILE (@@FETCH_STATUS = 0) 
 	BEGIN 
   		PRINT N'UPDATING STATISTICS FOR TABLE: ' + @Table    
   		SET @SQLcommand = 'UPDATE STATISTICS ' + @Table + ' WITH FULLSCAN' 
     
   		EXEC sp_executesql @SQLcommand 
     
   		FETCH NEXT FROM curAllTables 
   		INTO @Table 
 	END 
 
	CLOSE curAllTables  
	DEALLOCATE curAllTables

	-- EXEC sp_UpdateStats -- TAD91

	-- ======================================================================================================================================================================================================
	-- THE END
	-- ======================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [dbo].[CommandExecute]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CommandExecute]

@Command nvarchar(max),
@CommandType nvarchar(max),
@Mode int,
@Comment nvarchar(max) = NULL,
@DatabaseName nvarchar(max) = NULL,
@SchemaName nvarchar(max) = NULL,
@ObjectName nvarchar(max) = NULL,
@ObjectType nvarchar(max) = NULL,
@IndexName nvarchar(max) = NULL,
@IndexType int = NULL,
@StatisticsName nvarchar(max) = NULL,
@PartitionNumber int = NULL,
@ExtENDedInfo xml = NULL,
@LockMessageSeverity int = 16,
@LogToTable nvarchar(max),
@Execute nvarchar(max)

AS

BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ================================================================================================================================================================
	--
	-- ================================================================================================================================================================

  ----------------------------------------------------------------------------------------------------
  --// Source:  https://ola.hallengren.com                                                        //--
  --// License: https://ola.hallengren.com/license.html                                           //--
  --// GitHub:  https://github.com/olahallengren/sql-server-maintenance-solution                  //--
  --// Version: 2018-07-16 18:32:21                                                               //--
  ----------------------------------------------------------------------------------------------------

  SET NOCOUNT ON

  DECLARE @StartMessage nvarchar(max)
  DECLARE @ENDMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)
  DECLARE @ErrorMessageOriginal nvarchar(max)
  DECLARE @Severity int

  DECLARE @StartTime datetime
  DECLARE @ENDTime datetime

  DECLARE @StartTimeSec datetime
  DECLARE @ENDTimeSec datetime

  DECLARE @ID int

  DECLARE @Error int
  DECLARE @RETURNCode int

  SET @Error = 0
  SET @RETURNCode = 0

  ----------------------------------------------------------------------------------------------------
  --// Check core requirements                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF NOT (SELECT [compatibility_level] FROM sys.databases WHERE database_id = DB_ID()) >= 90
  BEGIN
    SET @ErrorMessage = 'The database ' + QUOTENAME(DB_NAME(DB_ID())) + ' has to be in compatibility level 90 or higher.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_ansi_nulls FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'ANSI_NULLS has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_quoted_identifier FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'QUOTED_IDENTIFIER has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandLog')
  BEGIN
    SET @ErrorMessage = 'The table CommandLog is missing. Download https://ola.hallengren.com/scripts/CommandLog.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @RETURNCode = @Error
    GOTO RETURNCode
  END

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF @Command IS NULL OR @Command = ''
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Command is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CommandType IS NULL OR @CommandType = '' OR LEN(@CommandType) > 60
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CommandType is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Mode NOT IN(1,2) OR @Mode IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Mode is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LockMessageSeverity NOT IN(10,16) OR @LockMessageSeverity IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LockMessageSeverity is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable NOT IN('Y','N') OR @LogToTable IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogToTable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Execute is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @RETURNCode = @Error
    GOTO RETURNCode
  END

  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartTime = GETDATE()
  SET @StartTimeSec = CONVERT(datetime,CONVERT(nvarchar,@StartTime,120),120)

  SET @StartMessage = 'Date and time: ' + CONVERT(nvarchar,@StartTimeSec,120)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Command: ' + @Command
  SET @StartMessage = REPLACE(@StartMessage,'%','%%')
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  IF @Comment IS NOT NULL
  BEGIN
    SET @StartMessage = 'Comment: ' + @Comment
    SET @StartMessage = REPLACE(@StartMessage,'%','%%')
    RAISERROR(@StartMessage,10,1) WITH NOWAIT
  END

  IF @LogToTable = 'Y'
  BEGIN
    INSERT INTO dbo.CommandLog (DatabaseName, SchemaName, ObjectName, ObjectType, IndexName, IndexType, StatisticsName, PartitionNumber, ExtENDedInfo, CommandType, Command, StartTime)
    VALUES (@DatabaseName, @SchemaName, @ObjectName, @ObjectType, @IndexName, @IndexType, @StatisticsName, @PartitionNumber, @ExtENDedInfo, @CommandType, @Command, @StartTime)
  END

  SET @ID = SCOPE_IDENTITY()

  ----------------------------------------------------------------------------------------------------
  --// Execute command                                                                            //--
  ----------------------------------------------------------------------------------------------------

  IF @Mode = 1 AND @Execute = 'Y'
  BEGIN
    EXECUTE(@Command)
    SET @Error = @@ERROR
    SET @RETURNCode = @Error
  END

  IF @Mode = 2 AND @Execute = 'Y'
  BEGIN
    BEGIN TRY
      EXECUTE(@Command)
    END TRY
    BEGIN CATCH
      SET @Error = ERROR_NUMBER()
      SET @ErrorMessageOriginal = ERROR_MESSAGE()

      SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'')
      SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
      RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

      IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
      BEGIN
        SET @RETURNCode = ERROR_NUMBER()
      END
    END CATCH
  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  SET @ENDTime = GETDATE()
  SET @ENDTimeSec = CONVERT(datetime,CONVERT(varchar,@ENDTime,120),120)

  SET @ENDMessage = 'Outcome: ' + CASE WHEN @Execute = 'N' THEN 'Not Executed' WHEN @Error = 0 THEN 'Succeeded' ELSE 'Failed' END
  RAISERROR(@ENDMessage,10,1) WITH NOWAIT

  SET @ENDMessage = 'Duration: ' + CASE WHEN DATEDIFF(ss,@StartTimeSec, @ENDTimeSec)/(24*3600) > 0 THEN CAST(DATEDIFF(ss,@StartTimeSec, @ENDTimeSec)/(24*3600) AS nvarchar) + '.' ELSE '' END + CONVERT(nvarchar,@ENDTimeSec - @StartTimeSec,108)
  RAISERROR(@ENDMessage,10,1) WITH NOWAIT

  SET @ENDMessage = 'Date and time: ' + CONVERT(nvarchar,@ENDTimeSec,120) + CHAR(13) + CHAR(10) + ' '
  RAISERROR(@ENDMessage,10,1) WITH NOWAIT

  IF @LogToTable = 'Y'
  BEGIN
    UPDATE dbo.CommandLog
    SET ENDTime = @ENDTime,
        ErrorNumber = CASE WHEN @Execute = 'N' THEN NULL ELSE @Error END,
        ErrorMessage = @ErrorMessageOriginal
    WHERE ID = @ID
  END

  RETURNCode:
  IF @RETURNCode <> 0
  BEGIN
    RETURN @RETURNCode
  END

  ----------------------------------------------------------------------------------------------------

END













GO
/****** Object:  StoredProcedure [dbo].[DatabaseBackup]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DatabaseBackup]

@Databases nvarchar(max) = NULL,
@Directory nvarchar(max) = NULL,
@BackupType nvarchar(max),
@Verify nvarchar(max) = 'N',
@CleanupTime int = NULL,
@CleanupMode nvarchar(max) = 'AFTER_BACKUP',
@Compress nvarchar(max) = NULL,
@CopyOnly nvarchar(max) = 'N',
@ChangeBackupType nvarchar(max) = 'N',
@BackupSoftware nvarchar(max) = NULL,
@CheckSum nvarchar(max) = 'N',
@BlockSize int = NULL,
@BufferCount int = NULL,
@MaxTransferSize int = NULL,
@NumberOfFiles int = NULL,
@CompressionLevel int = NULL,
@Description nvarchar(max) = NULL,
@Threads int = NULL,
@Throttle int = NULL,
@Encrypt nvarchar(max) = 'N',
@EncryptionAlgorithm nvarchar(max) = NULL,
@ServerCertificate nvarchar(max) = NULL,
@ServerAsymmetricKey nvarchar(max) = NULL,
@EncryptionKey nvarchar(max) = NULL,
@ReadWriteFileGroups nvarchar(max) = 'N',
@OverrideBackupPreference nvarchar(max) = 'N',
@NoRecovery nvarchar(max) = 'N',
@URL nvarchar(max) = NULL,
@Credential nvarchar(max) = NULL,
@MirrorDirectory nvarchar(max) = NULL,
@MirrorCleanupTime int = NULL,
@MirrorCleanupMode nvarchar(max) = 'AFTER_BACKUP',
@MirrorURL nvarchar(max) = NULL,
@AvailabilityGroups nvarchar(max) = NULL,
@Updateability nvarchar(max) = 'ALL',
@AdaptiveCompression nvarchar(max) = NULL,
@ModificationLevel int = NULL,
@LogSizeSinceLastLogBackup int = NULL,
@TimeSinceLastLogBackup int = NULL,
@DataDomainBoostHost nvarchar(max) = NULL,
@DataDomainBoostUser nvarchar(max) = NULL,
@DataDomainBoostDevicePath nvarchar(max) = NULL,
@DataDomainBoostLockboxPath nvarchar(max) = NULL,
@DirectoryStructure nvarchar(max) = '{ServerName}${InstanceName}{DirectorySeparator}{DatabaseName}{DirectorySeparator}{BackupType}_{Partial}_{CopyOnly}',
@AvailabilityGroupDirectoryStructure nvarchar(max) = '{ClusterName}${AvailabilityGroupName}{DirectorySeparator}{DatabaseName}{DirectorySeparator}{BackupType}_{Partial}_{CopyOnly}',
@FileName nvarchar(max) = '{ServerName}${InstanceName}_{DatabaseName}_{BackupType}_{Partial}_{CopyOnly}_{Year}{Month}{Day}_{Hour}{Minute}{Second}_{FileNumber}.{FileExtension}',
@AvailabilityGroupFileName nvarchar(max) = '{ClusterName}${AvailabilityGroupName}_{DatabaseName}_{BackupType}_{Partial}_{CopyOnly}_{Year}{Month}{Day}_{Hour}{Minute}{Second}_{FileNumber}.{FileExtension}',
@FileExtensionFull nvarchar(max) = NULL,
@FileExtensionDiff nvarchar(max) = NULL,
@FileExtensionLog nvarchar(max) = NULL,
@Init nvarchar(max) = 'N',
@DatabaseOrder nvarchar(max) = NULL,
@DatabasesInParallel nvarchar(max) = 'N',
@LogToTable nvarchar(max) = 'N',
@Execute nvarchar(max) = 'Y'

AS

BEGIN

  ----------------------------------------------------------------------------------------------------
  --// Source:  https://ola.hallengren.com                                                        //--
  --// License: https://ola.hallengren.com/license.html                                           //--
  --// GitHub:  https://github.com/olahallengren/sql-server-maintenance-solution                  //--
  --// Version: 2018-07-16 18:32:21                                                               //--
  ----------------------------------------------------------------------------------------------------

  SET NOCOUNT ON

  DECLARE @StartMessage nvarchar(max)
  DECLARE @ENDMessage nvarchar(max)
  DECLARE @DatabaseMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)

  DECLARE @StartTime datetime
  DECLARE @SchemaName nvarchar(max)
  DECLARE @ObjectName nvarchar(max)
  DECLARE @VersionTimestamp nvarchar(max)
  DECLARE @Parameters nvarchar(max)

  DECLARE @Version numeric(18,10)
  DECLARE @HostPlatform nvarchar(max)
  DECLARE @DirectorySeparator nvarchar(max)
  DECLARE @AmazonRDS bit

  DECLARE @Updated bit

  DECLARE @Cluster nvarchar(max)

  DECLARE @DefaultDirectory nvarchar(4000)

  DECLARE @QueueID int
  DECLARE @QueueStartTime datetime

  DECLARE @CurrentRootDirectoryID int
  DECLARE @CurrentRootDirectoryPath nvarchar(4000)

  DECLARE @CurrentDBID int
  DECLARE @CurrentDatabaseID int
  DECLARE @CurrentDatabaseName nvarchar(max)
  DECLARE @CurrentBackupType nvarchar(max)
  DECLARE @CurrentFileExtension nvarchar(max)
  DECLARE @CurrentFileNumber int
  DECLARE @CurrentDifferentialBaseLSN numeric(25,0)
  DECLARE @CurrentDifferentialBaseIsSnapshot bit
  DECLARE @CurrentLogLSN numeric(25,0)
  DECLARE @CurrentLatestBackup datetime
  DECLARE @CurrentDatabaseNameFS nvarchar(max)
  DECLARE @CurrentDirectoryStructure nvarchar(max)
  DECLARE @CurrentDatabaseFileName nvarchar(max)
  DECLARE @CurrentMaxFilePathLength nvarchar(max)
  DECLARE @CurrentFileName nvarchar(max)
  DECLARE @CurrentDirectoryID int
  DECLARE @CurrentDirectoryPath nvarchar(max)
  DECLARE @CurrentFilePath nvarchar(max)
  DECLARE @CurrentDate datetime
  DECLARE @CurrentCleanupDate datetime
  DECLARE @CurrentIsDatabaseAccessible bit
  DECLARE @CurrentAvailabilityGroup nvarchar(max)
  DECLARE @CurrentAvailabilityGroupRole nvarchar(max)
  DECLARE @CurrentAvailabilityGroupBackupPreference nvarchar(max)
  DECLARE @CurrentIsPreferredBackupReplica bit
  DECLARE @CurrentDatabaseMirroringRole nvarchar(max)
  DECLARE @CurrentLogShippingRole nvarchar(max)
  DECLARE @CurrentIsEncrypted bit
  DECLARE @CurrentIsReadOnly bit
  DECLARE @CurrentBackupSetID int
  DECLARE @CurrentIsMirror bit
  DECLARE @CurrentLastLogBackup datetime
  DECLARE @CurrentLogSizeSinceLastLogBackup float
  DECLARE @CurrentAllocatedExtentPageCount bigint
  DECLARE @CurrentModifiedExtentPageCount bigint

  DECLARE @CurrentCommand01 nvarchar(max)
  DECLARE @CurrentCommand02 nvarchar(max)
  DECLARE @CurrentCommand03 nvarchar(max)
  DECLARE @CurrentCommand04 nvarchar(max)
  DECLARE @CurrentCommand05 nvarchar(max)
  DECLARE @CurrentCommand06 nvarchar(max)
  DECLARE @CurrentCommand07 nvarchar(max)

  DECLARE @CurrentCommandOutput01 int
  DECLARE @CurrentCommandOutput02 int
  DECLARE @CurrentCommandOutput03 int
  DECLARE @CurrentCommandOutput04 int
  DECLARE @CurrentCommandOutput05 int

  DECLARE @CurrentCommandType01 nvarchar(max)
  DECLARE @CurrentCommandType02 nvarchar(max)
  DECLARE @CurrentCommandType03 nvarchar(max)
  DECLARE @CurrentCommandType04 nvarchar(max)
  DECLARE @CurrentCommandType05 nvarchar(max)

  DECLARE @Directories TABLE (ID int PRIMARY KEY,
                              DirectoryPath nvarchar(max),
                              Mirror bit,
                              Completed bit)

  DECLARE @URLs TABLE (ID int IDENTITY PRIMARY KEY,
                       DirectoryPath nvarchar(max),
                       Mirror bit)

  DECLARE @DirectoryInfo TABLE (FileExists bit,
                                FileIsADirectory bit,
                                ParentDirectoryExists bit)

  DECLARE @tmpDatabases TABLE (ID int IDENTITY,
                               DatabaseName nvarchar(max),
                               DatabaseNameFS nvarchar(max),
                               DatabaseType nvarchar(max),
                               AvailabilityGroup bit,
                               StartPosition int,
                               DatabaseSize bigint,
                               LogSizeSinceLastLogBackup float,
                               [Order] int,
                               Selected bit,
                               Completed bit,
                               PRIMARY KEY(Selected, Completed, [Order], ID))

  DECLARE @tmpAvailabilityGroups TABLE (ID int IDENTITY PRIMARY KEY,
                                        AvailabilityGroupName nvarchar(max),
                                        StartPosition int,
                                        Selected bit)

  DECLARE @tmpDatabasesAvailabilityGroups TABLE (DatabaseName nvarchar(max),
                                                 AvailabilityGroupName nvarchar(max))

  DECLARE @SelectedDatabases TABLE (DatabaseName nvarchar(max),
                                    DatabaseType nvarchar(max),
                                    AvailabilityGroup nvarchar(max),
                                    StartPosition int,
                                    Selected bit)

  DECLARE @SelectedAvailabilityGroups TABLE (AvailabilityGroupName nvarchar(max),
                                             StartPosition int,
                                             Selected bit)

  DECLARE @CurrentBackupSet TABLE (ID int IDENTITY PRIMARY KEY,
                                   Mirror bit,
                                   VerifyCompleted bit,
                                   VerifyOutput int)

  DECLARE @CurrentDirectories TABLE (ID int PRIMARY KEY,
                                     DirectoryPath nvarchar(max),
                                     Mirror bit,
                                     DirectoryNumber int,
                                     CleanupDate datetime,
                                     CleanupMode nvarchar(max),
                                     CreateCompleted bit,
                                     CleanupCompleted bit,
                                     CreateOutput int,
                                     CleanupOutput int)

  DECLARE @CurrentURLs TABLE (ID int PRIMARY KEY,
                              DirectoryPath nvarchar(max),
                              Mirror bit)

  DECLARE @CurrentFiles TABLE ([Type] nvarchar(max),
                               FilePath nvarchar(max),
                               Mirror bit)

  DECLARE @CurrentCleanupDates TABLE (CleanupDate datetime, Mirror bit)

  DECLARE @DirectoryCheck bit

  DECLARE @Error int
  DECLARE @RETURNCode int

  SET @Error = 0
  SET @RETURNCode = 0

  SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

  IF @Version >= 14
  BEGIN
    SELECT @HostPlatform = host_platform
    FROM sys.dm_os_host_info
  END
  ELSE
  BEGIN
    SET @HostPlatform = 'Windows'
  END

  SET @AmazonRDS = CASE WHEN DB_ID('rdsadmin') IS NOT NULL AND SUSER_SNAME(0x01) = 'rdsa' THEN 1 ELSE 0 END

  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartTime = GETDATE()
  SET @SchemaName = (SELECT schemas.name FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID)
  SET @ObjectName = OBJECT_NAME(@@PROCID)
  SET @VersionTimestamp = SUBSTRING(OBJECT_DEFINITION(@@PROCID),CHARINDEX('--// Version: ',OBJECT_DEFINITION(@@PROCID)) + LEN('--// Version: ') + 1, 19)

  SET @Parameters = '@Databases = ' + ISNULL('''' + REPLACE(@Databases,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Directory = ' + ISNULL('''' + REPLACE(@Directory,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @BackupType = ' + ISNULL('''' + REPLACE(@BackupType,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Verify = ' + ISNULL('''' + REPLACE(@Verify,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @CleanupTime = ' + ISNULL(CAST(@CleanupTime AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @CleanupMode = ' + ISNULL('''' + REPLACE(@CleanupMode,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Compress = ' + ISNULL('''' + REPLACE(@Compress,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @CopyOnly = ' + ISNULL('''' + REPLACE(@CopyOnly,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @ChangeBackupType = ' + ISNULL('''' + REPLACE(@ChangeBackupType,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @BackupSoftware = ' + ISNULL('''' + REPLACE(@BackupSoftware,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @CheckSum = ' + ISNULL('''' + REPLACE(@CheckSum,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @BlockSize = ' + ISNULL(CAST(@BlockSize AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @BufferCount = ' + ISNULL(CAST(@BufferCount AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @MaxTransferSize = ' + ISNULL(CAST(@MaxTransferSize AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @NumberOfFiles = ' + ISNULL(CAST(@NumberOfFiles AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @CompressionLevel = ' + ISNULL(CAST(@CompressionLevel AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @Description = ' + ISNULL('''' + REPLACE(@Description,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Threads = ' + ISNULL(CAST(@Threads AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @Throttle = ' + ISNULL(CAST(@Throttle AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @Encrypt = ' + ISNULL('''' + REPLACE(@Encrypt,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @EncryptionAlgorithm = ' + ISNULL('''' + REPLACE(@EncryptionAlgorithm,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @ServerCertificate = ' + ISNULL('''' + REPLACE(@ServerCertificate,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @ServerAsymmetricKey = ' + ISNULL('''' + REPLACE(@ServerAsymmetricKey,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @EncryptionKey = ' + ISNULL('''' + REPLACE(@EncryptionKey,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @ReadWriteFileGroups = ' + ISNULL('''' + REPLACE(@ReadWriteFileGroups,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @OverrideBackupPreference = ' + ISNULL('''' + REPLACE(@OverrideBackupPreference,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @NoRecovery = ' + ISNULL('''' + REPLACE(@NoRecovery,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @URL = ' + ISNULL('''' + REPLACE(@URL,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Credential = ' + ISNULL('''' + REPLACE(@Credential,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @MirrorDirectory = ' + ISNULL('''' + REPLACE(@MirrorDirectory,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @MirrorCleanupTime = ' + ISNULL(CAST(@MirrorCleanupTime AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @MirrorCleanupMode = ' + ISNULL('''' + REPLACE(@MirrorCleanupMode,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @MirrorURL = ' + ISNULL('''' + REPLACE(@MirrorURL,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @AvailabilityGroups = ' + ISNULL('''' + REPLACE(@AvailabilityGroups,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Updateability = ' + ISNULL('''' + REPLACE(@Updateability,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @AdaptiveCompression = ' + ISNULL('''' + REPLACE(@AdaptiveCompression,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @ModificationLevel = ' + ISNULL(CAST(@ModificationLevel AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @LogSizeSinceLastLogBackup = ' + ISNULL(CAST(@LogSizeSinceLastLogBackup AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @TimeSinceLastLogBackup = ' + ISNULL(CAST(@TimeSinceLastLogBackup AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @DataDomainBoostHost = ' + ISNULL('''' + REPLACE(@DataDomainBoostHost,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DataDomainBoostUser = ' + ISNULL('''' + REPLACE(@DataDomainBoostUser,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DataDomainBoostDevicePath = ' + ISNULL('''' + REPLACE(@DataDomainBoostDevicePath,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DataDomainBoostLockboxPath = ' + ISNULL('''' + REPLACE(@DataDomainBoostLockboxPath,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DirectoryStructure = ' + ISNULL('''' + REPLACE(@DirectoryStructure,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @AvailabilityGroupDirectoryStructure = ' + ISNULL('''' + REPLACE(@AvailabilityGroupDirectoryStructure,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FileName = ' + ISNULL('''' + REPLACE(@FileName,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @AvailabilityGroupFileName = ' + ISNULL('''' + REPLACE(@AvailabilityGroupFileName,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FileExtensionFull = ' + ISNULL('''' + REPLACE(@FileExtensionFull,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FileExtensionDiff = ' + ISNULL('''' + REPLACE(@FileExtensionDiff,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FileExtensionLog = ' + ISNULL('''' + REPLACE(@FileExtensionLog,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Init = ' + ISNULL('''' + REPLACE(@Init,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DatabaseOrder = ' + ISNULL('''' + REPLACE(@DatabaseOrder,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DatabasesInParallel = ' + ISNULL('''' + REPLACE(@DatabasesInParallel,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @LogToTable = ' + ISNULL('''' + REPLACE(@LogToTable,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Execute = ' + ISNULL('''' + REPLACE(@Execute,'''','''''') + '''','NULL')

  SET @StartMessage = 'Date and time: ' + CONVERT(nvarchar,@StartTime,120)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Platform: ' + @HostPlatform
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Procedure: ' + QUOTENAME(DB_NAME(DB_ID())) + '.' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@ObjectName)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Parameters: ' + @Parameters
  SET @StartMessage = REPLACE(@StartMessage,'%','%%')
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Version: ' + @VersionTimestamp
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Source: https://ola.hallengren.com' + CHAR(13) + CHAR(10) + ' '
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  ----------------------------------------------------------------------------------------------------
  --// Check core requirements                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF NOT (SELECT [compatibility_level] FROM sys.databases WHERE database_id = DB_ID()) >= 90
  BEGIN
    SET @ErrorMessage = 'The database ' + QUOTENAME(DB_NAME(DB_ID())) + ' has to be in compatibility level 90 or higher.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_ansi_nulls FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'ANSI_NULLS has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_quoted_identifier FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'QUOTED_IDENTIFIER has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute is missing. Download https://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute' AND OBJECT_DEFINITION(objects.[object_id]) NOT LIKE '%@LockMessageSeverity%')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute needs to be updated. Download https://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandLog')
  BEGIN
    SET @ErrorMessage = 'The table CommandLog is missing. Download https://ola.hallengren.com/scripts/CommandLog.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'Queue')
  BEGIN
    SET @ErrorMessage = 'The table Queue is missing. Download https://ola.hallengren.com/scripts/Queue.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'QueueDatabase')
  BEGIN
    SET @ErrorMessage = 'The table QueueDatabase is missing. Download https://ola.hallengren.com/scripts/QueueDatabase.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @@TRANCOUNT <> 0
  BEGIN
    SET @ErrorMessage = 'The transaction count is not 0.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @AmazonRDS = 1
  BEGIN
    SET @ErrorMessage = 'The stored procedure DatabaseBackup is not supported on Amazon RDS.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @RETURNCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Select databases                                                                           //--
  ----------------------------------------------------------------------------------------------------

  SET @Databases = REPLACE(@Databases, CHAR(10), '')
  SET @Databases = REPLACE(@Databases, CHAR(13), '')

  WHILE CHARINDEX(', ',@Databases) > 0 SET @Databases = REPLACE(@Databases,', ',',')
  WHILE CHARINDEX(' ,',@Databases) > 0 SET @Databases = REPLACE(@Databases,' ,',',')

  SET @Databases = LTRIM(RTRIM(@Databases));

  WITH Databases1 (StartPosition, ENDPosition, DatabaseItem) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Databases, 1), 0), LEN(@Databases) + 1) AS ENDPosition,
         SUBSTRING(@Databases, 1, ISNULL(NULLIF(CHARINDEX(',', @Databases, 1), 0), LEN(@Databases) + 1) - 1) AS DatabaseItem
  WHERE @Databases IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Databases, ENDPosition + 1), 0), LEN(@Databases) + 1) AS ENDPosition,
         SUBSTRING(@Databases, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Databases, ENDPosition + 1), 0), LEN(@Databases) + 1) - ENDPosition - 1) AS DatabaseItem
  FROM Databases1
  WHERE ENDPosition < LEN(@Databases) + 1
  ),
  Databases2 (DatabaseItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem LIKE '-%' THEN RIGHT(DatabaseItem,LEN(DatabaseItem) - 1) ELSE DatabaseItem END AS DatabaseItem,
         StartPosition,
         CASE WHEN DatabaseItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM Databases1
  ),
  Databases3 (DatabaseItem, DatabaseType, AvailabilityGroup, StartPosition, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem IN('ALL_DATABASES','SYSTEM_DATABASES','USER_DATABASES','AVAILABILITY_GROUP_DATABASES') THEN '%' ELSE DatabaseItem END AS DatabaseItem,
         CASE WHEN DatabaseItem = 'SYSTEM_DATABASES' THEN 'S' WHEN DatabaseItem = 'USER_DATABASES' THEN 'U' ELSE NULL END AS DatabaseType,
         CASE WHEN DatabaseItem = 'AVAILABILITY_GROUP_DATABASES' THEN 1 ELSE NULL END AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases2
  ),
  Databases4 (DatabaseName, DatabaseType, AvailabilityGroup, StartPosition, Selected) AS
  (
  SELECT CASE WHEN LEFT(DatabaseItem,1) = '[' AND RIGHT(DatabaseItem,1) = ']' THEN PARSENAME(DatabaseItem,1) ELSE DatabaseItem END AS DatabaseItem,
         DatabaseType,
         AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases3
  )
  INSERT INTO @SelectedDatabases (DatabaseName, DatabaseType, AvailabilityGroup, StartPosition, Selected)
  SELECT DatabaseName,
         DatabaseType,
         AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases4
  OPTION (MAXRECURSION 0)

  IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN
    INSERT INTO @tmpAvailabilityGroups (AvailabilityGroupName, Selected)
    SELECT name AS AvailabilityGroupName,
           0 AS Selected
    FROM sys.availability_groups

    INSERT INTO @tmpDatabasesAvailabilityGroups (DatabaseName, AvailabilityGroupName)
    SELECT availability_databases_cluster.database_name, availability_groups.name
    FROM sys.availability_databases_cluster availability_databases_cluster
    INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
  END

  INSERT INTO @tmpDatabases (DatabaseName, DatabaseNameFS, DatabaseType, AvailabilityGroup, [Order], Selected, Completed)
  SELECT [name] AS DatabaseName,
         LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([name],'\',''),'/',''),':',''),'*',''),'?',''),'"',''),'<',''),'>',''),'|',''))) AS DatabaseNameFS,
         CASE WHEN name IN('master','msdb','model') THEN 'S' ELSE 'U' END AS DatabaseType,
         NULL AS AvailabilityGroup,
         0 AS [Order],
         0 AS Selected,
         0 AS Completed
  FROM sys.databases
  WHERE [name] <> 'tempdb'
  AND source_database_id IS NULL
  ORDER BY [name] ASC

  UPDATE tmpDatabases
  SET AvailabilityGroup = CASE WHEN EXISTS (SELECT * FROM @tmpDatabasesAvailabilityGroups WHERE DatabaseName = tmpDatabases.DatabaseName) THEN 1 ELSE 0 END
  FROM @tmpDatabases tmpDatabases

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
  WHERE SelectedDatabases.Selected = 1

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
  WHERE SelectedDatabases.Selected = 0

  UPDATE tmpDatabases
  SET tmpDatabases.StartPosition = SelectedDatabases2.StartPosition
  FROM @tmpDatabases tmpDatabases
  INNER JOIN (SELECT tmpDatabases.DatabaseName, MIN(SelectedDatabases.StartPosition) AS StartPosition
              FROM @tmpDatabases tmpDatabases
              INNER JOIN @SelectedDatabases SelectedDatabases
              ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
              AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
              AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
              WHERE SelectedDatabases.Selected = 1
              GROUP BY tmpDatabases.DatabaseName) SelectedDatabases2
  ON tmpDatabases.DatabaseName = SelectedDatabases2.DatabaseName

  IF @Databases IS NOT NULL AND (NOT EXISTS(SELECT * FROM @SelectedDatabases) OR EXISTS(SELECT * FROM @SelectedDatabases WHERE DatabaseName IS NULL OR DatabaseName = ''))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Databases is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select availability groups                                                                 //--
  ----------------------------------------------------------------------------------------------------

  IF @AvailabilityGroups IS NOT NULL AND @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN

    SET @AvailabilityGroups = REPLACE(@AvailabilityGroups, CHAR(10), '')
    SET @AvailabilityGroups = REPLACE(@AvailabilityGroups, CHAR(13), '')

    WHILE CHARINDEX(', ',@AvailabilityGroups) > 0 SET @AvailabilityGroups = REPLACE(@AvailabilityGroups,', ',',')
    WHILE CHARINDEX(' ,',@AvailabilityGroups) > 0 SET @AvailabilityGroups = REPLACE(@AvailabilityGroups,' ,',',')

    SET @AvailabilityGroups = LTRIM(RTRIM(@AvailabilityGroups));

    WITH AvailabilityGroups1 (StartPosition, ENDPosition, AvailabilityGroupItem) AS
    (
    SELECT 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, 1), 0), LEN(@AvailabilityGroups) + 1) AS ENDPosition,
           SUBSTRING(@AvailabilityGroups, 1, ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, 1), 0), LEN(@AvailabilityGroups) + 1) - 1) AS AvailabilityGroupItem
    WHERE @AvailabilityGroups IS NOT NULL
    UNION ALL
    SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, ENDPosition + 1), 0), LEN(@AvailabilityGroups) + 1) AS ENDPosition,
           SUBSTRING(@AvailabilityGroups, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, ENDPosition + 1), 0), LEN(@AvailabilityGroups) + 1) - ENDPosition - 1) AS AvailabilityGroupItem
    FROM AvailabilityGroups1
    WHERE ENDPosition < LEN(@AvailabilityGroups) + 1
    ),
    AvailabilityGroups2 (AvailabilityGroupItem, StartPosition, Selected) AS
    (
    SELECT CASE WHEN AvailabilityGroupItem LIKE '-%' THEN RIGHT(AvailabilityGroupItem,LEN(AvailabilityGroupItem) - 1) ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           CASE WHEN AvailabilityGroupItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
    FROM AvailabilityGroups1
    ),
    AvailabilityGroups3 (AvailabilityGroupItem, StartPosition, Selected) AS
    (
    SELECT CASE WHEN AvailabilityGroupItem = 'ALL_AVAILABILITY_GROUPS' THEN '%' ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           Selected
    FROM AvailabilityGroups2
    ),
    AvailabilityGroups4 (AvailabilityGroupName, StartPosition, Selected) AS
    (
    SELECT CASE WHEN LEFT(AvailabilityGroupItem,1) = '[' AND RIGHT(AvailabilityGroupItem,1) = ']' THEN PARSENAME(AvailabilityGroupItem,1) ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           Selected
    FROM AvailabilityGroups3
    )
    INSERT INTO @SelectedAvailabilityGroups (AvailabilityGroupName, StartPosition, Selected)
    SELECT AvailabilityGroupName, StartPosition, Selected
    FROM AvailabilityGroups4
    OPTION (MAXRECURSION 0)

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.Selected = SelectedAvailabilityGroups.Selected
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
    ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
    WHERE SelectedAvailabilityGroups.Selected = 1

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.Selected = SelectedAvailabilityGroups.Selected
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
    ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
    WHERE SelectedAvailabilityGroups.Selected = 0

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.StartPosition = SelectedAvailabilityGroups2.StartPosition
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN (SELECT tmpAvailabilityGroups.AvailabilityGroupName, MIN(SelectedAvailabilityGroups.StartPosition) AS StartPosition
                FROM @tmpAvailabilityGroups tmpAvailabilityGroups
                INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
                ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
                WHERE SelectedAvailabilityGroups.Selected = 1
                GROUP BY tmpAvailabilityGroups.AvailabilityGroupName) SelectedAvailabilityGroups2
    ON tmpAvailabilityGroups.AvailabilityGroupName = SelectedAvailabilityGroups2.AvailabilityGroupName

    UPDATE tmpDatabases
    SET tmpDatabases.StartPosition = tmpAvailabilityGroups.StartPosition,
        tmpDatabases.Selected = 1
    FROM @tmpDatabases tmpDatabases
    INNER JOIN @tmpDatabasesAvailabilityGroups tmpDatabasesAvailabilityGroups ON tmpDatabases.DatabaseName = tmpDatabasesAvailabilityGroups.DatabaseName
    INNER JOIN @tmpAvailabilityGroups tmpAvailabilityGroups ON tmpDatabasesAvailabilityGroups.AvailabilityGroupName = tmpAvailabilityGroups.AvailabilityGroupName
    WHERE tmpAvailabilityGroups.Selected = 1

  END

  IF @AvailabilityGroups IS NOT NULL AND (NOT EXISTS(SELECT * FROM @SelectedAvailabilityGroups) OR EXISTS(SELECT * FROM @SelectedAvailabilityGroups WHERE AvailabilityGroupName IS NULL OR AvailabilityGroupName = '') OR @Version < 11 OR SERVERPROPERTY('IsHadrEnabled') = 0)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @AvailabilityGroups is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Databases IS NULL AND @AvailabilityGroups IS NULL)
  BEGIN
    SET @ErrorMessage = 'You need to specify one of the parameters @Databases and @AvailabilityGroups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Databases IS NOT NULL AND @AvailabilityGroups IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'You can only specify one of the parameters @Databases and @AvailabilityGroups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Check database names                                                                       //--
  ----------------------------------------------------------------------------------------------------

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @tmpDatabases
  WHERE Selected = 1
  AND DatabaseNameFS = ''
  ORDER BY DatabaseName ASC
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The names of the following databases are not supported: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @tmpDatabases
  WHERE UPPER(DatabaseNameFS) IN(SELECT UPPER(DatabaseNameFS) FROM @tmpDatabases GROUP BY UPPER(DatabaseNameFS) HAVING COUNT(*) > 1)
  AND UPPER(DatabaseNameFS) IN(SELECT UPPER(DatabaseNameFS) FROM @tmpDatabases WHERE Selected = 1)
  AND DatabaseNameFS <> ''
  ORDER BY DatabaseName ASC
  OPTION (RECOMPILE)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The names of the following databases are not unique in the file system: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select directories                                                                         //--
  ----------------------------------------------------------------------------------------------------

  IF @Directory IS NULL AND @URL IS NULL AND @HostPlatform = 'Windows' AND (@BackupSoftware <> 'DATA_DOMAIN_BOOST' OR @BackupSoftware IS NULL)
  BEGIN
    EXECUTE [master].dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', N'BackupDirectory', @DefaultDirectory OUTPUT

    IF @DefaultDirectory LIKE 'http://%' OR @DefaultDirectory LIKE 'https://%'
    BEGIN
      SET @URL = @DefaultDirectory
    END
    ELSE
    BEGIN
      INSERT INTO @Directories (ID, DirectoryPath, Mirror, Completed)
      SELECT 1, @DefaultDirectory, 0, 0
    END
  END
  IF @Directory IS NULL AND @URL IS NULL AND @HostPlatform = 'Linux'
  BEGIN
    INSERT INTO @Directories (ID, DirectoryPath, Mirror, Completed)
    SELECT 1, '.', 0, 0
  END
  ELSE
  BEGIN
    SET @Directory = REPLACE(@Directory, CHAR(10), '')
    SET @Directory = REPLACE(@Directory, CHAR(13), '')

    WHILE CHARINDEX(', ',@Directory) > 0 SET @Directory = REPLACE(@Directory,', ',',')
    WHILE CHARINDEX(' ,',@Directory) > 0 SET @Directory = REPLACE(@Directory,' ,',',')

    SET @Directory = LTRIM(RTRIM(@Directory));

    WITH Directories (StartPosition, ENDPosition, Directory) AS
    (
    SELECT 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @Directory, 1), 0), LEN(@Directory) + 1) AS ENDPosition,
           SUBSTRING(@Directory, 1, ISNULL(NULLIF(CHARINDEX(',', @Directory, 1), 0), LEN(@Directory) + 1) - 1) AS Directory
    WHERE @Directory IS NOT NULL
    UNION ALL
    SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @Directory, ENDPosition + 1), 0), LEN(@Directory) + 1) AS ENDPosition,
           SUBSTRING(@Directory, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Directory, ENDPosition + 1), 0), LEN(@Directory) + 1) - ENDPosition - 1) AS Directory
    FROM Directories
    WHERE ENDPosition < LEN(@Directory) + 1
    )
    INSERT INTO @Directories (ID, DirectoryPath, Mirror, Completed)
    SELECT ROW_NUMBER() OVER(ORDER BY StartPosition ASC) AS ID,
           Directory,
           0,
           0
    FROM Directories
    OPTION (MAXRECURSION 0)
  END

  SET @MirrorDirectory = REPLACE(@MirrorDirectory, CHAR(10), '')
  SET @MirrorDirectory = REPLACE(@MirrorDirectory, CHAR(13), '')

  WHILE CHARINDEX(', ',@MirrorDirectory) > 0 SET @MirrorDirectory = REPLACE(@MirrorDirectory,', ',',')
  WHILE CHARINDEX(' ,',@MirrorDirectory) > 0 SET @MirrorDirectory = REPLACE(@MirrorDirectory,' ,',',')

  SET @MirrorDirectory = LTRIM(RTRIM(@MirrorDirectory));

  WITH Directories (StartPosition, ENDPosition, Directory) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @MirrorDirectory, 1), 0), LEN(@MirrorDirectory) + 1) AS ENDPosition,
         SUBSTRING(@MirrorDirectory, 1, ISNULL(NULLIF(CHARINDEX(',', @MirrorDirectory, 1), 0), LEN(@MirrorDirectory) + 1) - 1) AS Directory
  WHERE @MirrorDirectory IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @MirrorDirectory, ENDPosition + 1), 0), LEN(@MirrorDirectory) + 1) AS ENDPosition,
         SUBSTRING(@MirrorDirectory, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @MirrorDirectory, ENDPosition + 1), 0), LEN(@MirrorDirectory) + 1) - ENDPosition - 1) AS Directory
  FROM Directories
  WHERE ENDPosition < LEN(@MirrorDirectory) + 1
  )
  INSERT INTO @Directories (ID, DirectoryPath, Mirror, Completed)
  SELECT (SELECT COUNT(*) FROM @Directories) + ROW_NUMBER() OVER(ORDER BY StartPosition ASC) AS ID,
         Directory,
         1,
         0
  FROM Directories
  OPTION (MAXRECURSION 0)

  ----------------------------------------------------------------------------------------------------
  --// Check directories                                                                          //--
  ----------------------------------------------------------------------------------------------------

  SET @DirectoryCheck = 1

  IF EXISTS(SELECT * FROM @Directories WHERE Mirror = 0 AND (NOT (DirectoryPath LIKE '_:' OR DirectoryPath LIKE '_:\%' OR DirectoryPath LIKE '\\%\%' OR (DirectoryPath LIKE '/%/%' AND @HostPlatform = 'Linux') OR (DirectoryPath LIKE '.' AND @HostPlatform = 'Linux')) OR DirectoryPath IS NULL OR LEFT(DirectoryPath,1) = ' ' OR RIGHT(DirectoryPath,1) = ' ')) OR EXISTS (SELECT * FROM @Directories GROUP BY DirectoryPath HAVING COUNT(*) <> 1) OR ((SELECT COUNT(*) FROM @Directories WHERE Mirror = 0) <> (SELECT COUNT(*) FROM @Directories WHERE Mirror = 1) AND (SELECT COUNT(*) FROM @Directories WHERE Mirror = 1) > 0) OR (@Directory IS NOT NULL AND SERVERPROPERTY('EngineEdition') = 8) OR (@Directory IS NOT NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Directory is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
    SET @DirectoryCheck = 0
  END

  IF EXISTS(SELECT * FROM @Directories WHERE Mirror = 1 AND (NOT (DirectoryPath LIKE '_:' OR DirectoryPath LIKE '_:\%' OR DirectoryPath LIKE '\\%\%' OR (DirectoryPath LIKE '/%/%' AND @HostPlatform = 'Linux') OR (DirectoryPath LIKE '.' AND @HostPlatform = 'Linux')) OR DirectoryPath IS NULL OR LEFT(DirectoryPath,1) = ' ' OR RIGHT(DirectoryPath,1) = ' ')) OR EXISTS (SELECT * FROM @Directories GROUP BY DirectoryPath HAVING COUNT(*) <> 1) OR ((SELECT COUNT(*) FROM @Directories WHERE Mirror = 0) <> (SELECT COUNT(*) FROM @Directories WHERE Mirror = 1) AND (SELECT COUNT(*) FROM @Directories WHERE Mirror = 1) > 0) OR (@BackupSoftware IN('SQLBACKUP','SQLSAFE') AND (SELECT COUNT(*) FROM @Directories WHERE Mirror = 1) > 1) OR (@BackupSoftware IS NULL AND EXISTS(SELECT * FROM @Directories WHERE Mirror = 1) AND SERVERPROPERTY('EngineEdition') <> 3) OR (@MirrorDirectory IS NOT NULL AND SERVERPROPERTY('EngineEdition') = 8) OR (@MirrorDirectory IS NOT NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MirrorDirectory is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
    SET @DirectoryCheck = 0
  END

  IF @DirectoryCheck = 1
  BEGIN
    WHILE (1 = 1)
    BEGIN
      SELECT TOP 1 @CurrentRootDirectoryID = ID,
                   @CurrentRootDirectoryPath = DirectoryPath
      FROM @Directories
      WHERE Completed = 0
      ORDER BY ID ASC

      IF @@ROWCOUNT = 0
      BEGIN
        BREAK
      END

      INSERT INTO @DirectoryInfo (FileExists, FileIsADirectory, ParentDirectoryExists)
      EXECUTE [master].dbo.xp_fileexist @CurrentRootDirectoryPath

      IF NOT EXISTS (SELECT * FROM @DirectoryInfo WHERE FileExists = 0 AND FileIsADirectory = 1 AND ParentDirectoryExists = 1)
      BEGIN
        SET @ErrorMessage = 'The directory ' + @CurrentRootDirectoryPath + ' does not exist.' + CHAR(13) + CHAR(10) + ' '
        RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
        SET @Error = @@ERROR
      END

      UPDATE @Directories
      SET Completed = 1
      WHERE ID = @CurrentRootDirectoryID

      SET @CurrentRootDirectoryID = NULL
      SET @CurrentRootDirectoryPath = NULL

      DELETE FROM @DirectoryInfo
    END
  END

  ----------------------------------------------------------------------------------------------------
  --// Select URLs                                                                                //--
  ----------------------------------------------------------------------------------------------------

  INSERT INTO @URLs (DirectoryPath, Mirror)
  SELECT @URL, 0
  WHERE @URL IS NOT NULL

  INSERT INTO @URLs (DirectoryPath, Mirror)
  SELECT @MirrorURL, 1
  WHERE @MirrorURL IS NOT NULL

  ----------------------------------------------------------------------------------------------------
  --// Get directory separator                                                                   //--
  ----------------------------------------------------------------------------------------------------

  SELECT @DirectorySeparator = CASE
  WHEN @URL IS NOT NULL THEN '/'
  WHEN @HostPlatform = 'Windows' THEN '\'
  WHEN @HostPlatform = 'Linux' THEN '/'
  END

  UPDATE @Directories
  SET DirectoryPath = LEFT(DirectoryPath,LEN(DirectoryPath) - 1)
  WHERE RIGHT(DirectoryPath,1) = @DirectorySeparator

  UPDATE @URLs
  SET DirectoryPath = LEFT(DirectoryPath,LEN(DirectoryPath) - 1)
  WHERE RIGHT(DirectoryPath,1) = @DirectorySeparator

  ----------------------------------------------------------------------------------------------------
  --// Get file extension                                                                         //--
  ----------------------------------------------------------------------------------------------------

  IF @FileExtensionFull IS NULL
  BEGIN
    SELECT @FileExtensionFull = CASE
    WHEN @BackupSoftware IS NULL THEN 'bak'
    WHEN @BackupSoftware = 'LITESPEED' THEN 'bak'
    WHEN @BackupSoftware = 'SQLBACKUP' THEN 'sqb'
    WHEN @BackupSoftware = 'SQLSAFE' THEN 'safe'
    END
  END

  IF @FileExtensionDiff IS NULL
  BEGIN
    SELECT @FileExtensionDiff = CASE
    WHEN @BackupSoftware IS NULL THEN 'bak'
    WHEN @BackupSoftware = 'LITESPEED' THEN 'bak'
    WHEN @BackupSoftware = 'SQLBACKUP' THEN 'sqb'
    WHEN @BackupSoftware = 'SQLSAFE' THEN 'safe'
    END
  END

  IF @FileExtensionLog IS NULL
  BEGIN
    SELECT @FileExtensionLog = CASE
    WHEN @BackupSoftware IS NULL THEN 'trn'
    WHEN @BackupSoftware = 'LITESPEED' THEN 'trn'
    WHEN @BackupSoftware = 'SQLBACKUP' THEN 'sqb'
    WHEN @BackupSoftware = 'SQLSAFE' THEN 'safe'
    END
  END

  ----------------------------------------------------------------------------------------------------
  --// Get default compression                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF @Compress IS NULL
  BEGIN
    SELECT @Compress = CASE
    WHEN @BackupSoftware IS NULL AND EXISTS(SELECT * FROM sys.configurations WHERE name = 'backup compression default' AND value_in_use = 1) THEN 'Y'
    WHEN @BackupSoftware IS NULL AND NOT EXISTS(SELECT * FROM sys.configurations WHERE name = 'backup compression default' AND value_in_use = 1) THEN 'N'
    WHEN @BackupSoftware IS NOT NULL AND (@CompressionLevel IS NULL OR @CompressionLevel > 0)  THEN 'Y'
    WHEN @BackupSoftware IS NOT NULL AND @CompressionLevel = 0  THEN 'N'
    END
  END

  ----------------------------------------------------------------------------------------------------
  --// Get number of files                                                                        //--
  ----------------------------------------------------------------------------------------------------

  IF @NumberOfFiles IS NULL
  BEGIN
    SELECT @NumberOfFiles = CASE WHEN @URL IS NOT NULL THEN 1 WHEN @BackupSoftware = 'DATA_DOMAIN_BOOST' THEN 1 ELSE (SELECT COUNT(*) FROM @Directories WHERE Mirror = 0) END
  END

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF @BackupType NOT IN ('FULL','DIFF','LOG') OR @BackupType IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @BackupType is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF SERVERPROPERTY('EngineEdition') = 8 AND NOT (@BackupType = 'FULL' AND @CopyOnly = 'Y')
  BEGIN
    SET @ErrorMessage = 'SQL Database Managed Instance only supports COPY_ONLY full backups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Verify NOT IN ('Y','N') OR @Verify IS NULL OR (@BackupSoftware = 'SQLSAFE' AND @Encrypt = 'Y' AND @Verify = 'Y') OR (@Verify = 'Y' AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Verify is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CleanupTime < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CleanupTime is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CleanupTime IS NOT NULL AND @URL IS NOT NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CleanupTime is not supported. Cleanup is not supported on Azure Blob Storage.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CleanupTime IS NOT NULL AND @HostPlatform = 'Linux'
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CleanupTime is not supported. Cleanup is not supported on Linux.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CleanupTime IS NOT NULL AND ((@DirectoryStructure NOT LIKE '%{DatabaseName}%' OR @DirectoryStructure IS NULL) OR (SERVERPROPERTY('IsHadrEnabled') = 1 AND (@AvailabilityGroupDirectoryStructure NOT LIKE '%{DatabaseName}%' OR @AvailabilityGroupDirectoryStructure IS NULL)))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CleanupTime is not supported. Cleanup is not supported if the token {DatabaseName} is not part of the directory.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CleanupTime IS NOT NULL AND ((@DirectoryStructure NOT LIKE '%{BackupType}%' OR @DirectoryStructure IS NULL) OR (SERVERPROPERTY('IsHadrEnabled') = 1 AND (@AvailabilityGroupDirectoryStructure NOT LIKE '%{BackupType}%' OR @AvailabilityGroupDirectoryStructure IS NULL)))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CleanupTime is not supported. Cleanup is not supported if the token {BackupType} is not part of the directory.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CleanupTime IS NOT NULL AND @CopyOnly = 'Y' AND ((@DirectoryStructure NOT LIKE '%{CopyOnly}%' OR @DirectoryStructure IS NULL) OR (SERVERPROPERTY('IsHadrEnabled') = 1 AND (@AvailabilityGroupDirectoryStructure NOT LIKE '%{CopyOnly}%' OR @AvailabilityGroupDirectoryStructure IS NULL)))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CleanupTime is not supported. Cleanup is not supported if the token {CopyOnly} is not part of the directory.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CleanupMode NOT IN('BEFORE_BACKUP','AFTER_BACKUP') OR @CleanupMode IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CleanupMode is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Compress NOT IN ('Y','N') OR @Compress IS NULL OR (@Compress = 'Y' AND @BackupSoftware IS NULL AND NOT ((@Version >= 10 AND @Version < 10.5 AND SERVERPROPERTY('EngineEdition') = 3) OR (@Version >= 10.5 AND (SERVERPROPERTY('EngineEdition') IN (3, 8) OR SERVERPROPERTY('EditionID') IN (-1534726760, 284895786))))) OR (@Compress = 'N' AND @BackupSoftware IN ('LITESPEED','SQLBACKUP','SQLSAFE') AND (@CompressionLevel IS NULL OR @CompressionLevel >= 1)) OR (@Compress = 'Y' AND @BackupSoftware IN ('LITESPEED','SQLBACKUP','SQLSAFE') AND @CompressionLevel = 0)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Compress is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CopyOnly NOT IN ('Y','N') OR @CopyOnly IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CopyOnly is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @ChangeBackupType NOT IN ('Y','N') OR @ChangeBackupType IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @ChangeBackupType is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware NOT IN ('LITESPEED','SQLBACKUP','SQLSAFE','DATA_DOMAIN_BOOST') OR (@BackupSoftware IS NOT NULL AND @HostPlatform = 'Linux')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @BackupSoftware is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware = 'LITESPEED' AND NOT EXISTS (SELECT * FROM [master].sys.objects WHERE [type] = 'X' AND [name] = 'xp_backup_database')
  BEGIN
    SET @ErrorMessage = 'LiteSpeed for SQL Server is not installed. Download https://www.quest.com/products/litespeed-for-sql-server/.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware = 'SQLBACKUP' AND NOT EXISTS (SELECT * FROM [master].sys.objects WHERE [type] = 'X' AND [name] = 'sqlbackup')
  BEGIN
    SET @ErrorMessage = 'Red Gate SQL Backup Pro is not installed. Download https://www.red-gate.com/products/dba/sql-backup/.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware = 'SQLSAFE' AND NOT EXISTS (SELECT * FROM [master].sys.objects WHERE [type] = 'X' AND [name] = 'xp_ss_backup')
  BEGIN
    SET @ErrorMessage = 'Idera SQL Safe Backup is not installed. Download https://www.idera.com/productssolutions/sqlserver/sqlsafebackup.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BackupSoftware = 'DATA_DOMAIN_BOOST' AND NOT EXISTS (SELECT * FROM [master].sys.objects WHERE [type] = 'PC' AND [name] = 'emc_run_backup')
  BEGIN
    SET @ErrorMessage = 'EMC Data Domain Boost is not installed. Download https://www.emc.com/en-us/data-protection/data-domain.htm.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @CheckSum NOT IN ('Y','N') OR @CheckSum IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CheckSum is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BlockSize NOT IN (512,1024,2048,4096,8192,16384,32768,65536) OR (@BlockSize IS NOT NULL AND @BackupSoftware = 'SQLBACKUP') OR (@BlockSize IS NOT NULL AND @BackupSoftware = 'SQLSAFE') OR (@BlockSize IS NOT NULL AND @URL IS NOT NULL AND @Credential IS NOT NULL) OR (@BlockSize IS NOT NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @BlockSize is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @BufferCount <= 0 OR @BufferCount > 2147483647 OR (@BufferCount IS NOT NULL AND @BackupSoftware = 'SQLBACKUP') OR (@BufferCount IS NOT NULL AND @BackupSoftware = 'SQLSAFE')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @BufferCount is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxTransferSize < 65536 OR @MaxTransferSize > 4194304 OR (@MaxTransferSize > 1048576 AND @BackupSoftware = 'SQLBACKUP') OR (@MaxTransferSize IS NOT NULL AND @BackupSoftware = 'SQLSAFE') OR (@MaxTransferSize IS NOT NULL AND @URL IS NOT NULL AND @Credential IS NOT NULL) OR (@MaxTransferSize IS NOT NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MaxTransferSize is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @NumberOfFiles < 1 OR @NumberOfFiles > 64 OR (@NumberOfFiles > 32 AND @BackupSoftware = 'SQLBACKUP') OR @NumberOfFiles IS NULL OR @NumberOfFiles < (SELECT COUNT(*) FROM @Directories WHERE Mirror = 0) OR @NumberOfFiles % (SELECT NULLIF(COUNT(*),0) FROM @Directories WHERE Mirror = 0) > 0 OR (@URL IS NOT NULL AND @Credential IS NOT NULL AND @NumberOfFiles <> 1) OR (@NumberOfFiles > 1 AND @BackupSoftware IN('SQLBACKUP','SQLSAFE') AND EXISTS(SELECT * FROM @Directories WHERE Mirror = 1)) OR (@NumberOfFiles > 32 AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @NumberOfFiles is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@BackupSoftware IS NULL AND @CompressionLevel IS NOT NULL) OR (@BackupSoftware = 'LITESPEED' AND (@CompressionLevel < 0 OR @CompressionLevel > 8)) OR (@BackupSoftware = 'SQLBACKUP' AND (@CompressionLevel < 0 OR @CompressionLevel > 4)) OR (@BackupSoftware = 'SQLSAFE' AND (@CompressionLevel < 1 OR @CompressionLevel > 4)) OR (@CompressionLevel IS NOT NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CompressionLevel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF LEN(@Description) > 255 OR (@BackupSoftware = 'LITESPEED' AND LEN(@Description) > 128) OR (@BackupSoftware = 'DATA_DOMAIN_BOOST' AND LEN(@Description) > 254)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Description is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Threads IS NOT NULL AND (@BackupSoftware NOT IN('LITESPEED','SQLBACKUP','SQLSAFE') OR @BackupSoftware IS NULL) OR (@BackupSoftware = 'LITESPEED' AND (@Threads < 1 OR @Threads > 32)) OR (@BackupSoftware = 'SQLBACKUP' AND (@Threads < 2 OR @Threads > 32)) OR (@BackupSoftware = 'SQLSAFE' AND (@Threads < 1 OR @Threads > 64))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Threads is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Throttle IS NOT NULL AND (@BackupSoftware NOT IN('LITESPEED') OR @BackupSoftware IS NULL) OR @Throttle < 1 OR @Throttle > 100
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Throttle is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Encrypt NOT IN('Y','N') OR @Encrypt IS NULL OR (@Encrypt = 'Y' AND @BackupSoftware IS NULL AND NOT (@Version >= 12 AND (SERVERPROPERTY('EngineEdition') = 3) OR SERVERPROPERTY('EditionID') IN(-1534726760, 284895786))) OR (@Encrypt = 'Y' AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Encrypt is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@BackupSoftware IS NULL AND @Encrypt = 'Y' AND (@EncryptionAlgorithm NOT IN('AES_128','AES_192','AES_256','TRIPLE_DES_3KEY') OR @EncryptionAlgorithm IS NULL)) OR (@BackupSoftware = 'LITESPEED' AND @Encrypt = 'Y' AND (@EncryptionAlgorithm NOT IN('RC2_40','RC2_56','RC2_112','RC2_128','TRIPLE_DES_3KEY','RC4_128','AES_128','AES_192','AES_256') OR @EncryptionAlgorithm IS NULL)) OR (@BackupSoftware = 'SQLBACKUP' AND @Encrypt = 'Y' AND (@EncryptionAlgorithm NOT IN('AES_128','AES_256') OR @EncryptionAlgorithm IS NULL)) OR (@BackupSoftware = 'SQLSAFE' AND @Encrypt = 'Y' AND (@EncryptionAlgorithm NOT IN('AES_128','AES_256') OR @EncryptionAlgorithm IS NULL)) OR (@EncryptionAlgorithm IS NOT NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @EncryptionAlgorithm is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (NOT (@BackupSoftware IS NULL AND @Encrypt = 'Y') AND @ServerCertificate IS NOT NULL) OR (@BackupSoftware IS NULL AND @Encrypt = 'Y' AND @ServerCertificate IS NULL AND @ServerAsymmetricKey IS NULL) OR (@BackupSoftware IS NULL AND @Encrypt = 'Y' AND @ServerCertificate IS NOT NULL AND @ServerAsymmetricKey IS NOT NULL) OR (@ServerCertificate IS NOT NULL AND NOT EXISTS(SELECT * FROM master.sys.certificates WHERE name = @ServerCertificate))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @ServerCertificate is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (NOT (@BackupSoftware IS NULL AND @Encrypt = 'Y') AND @ServerAsymmetricKey IS NOT NULL) OR (@BackupSoftware IS NULL AND @Encrypt = 'Y' AND @ServerAsymmetricKey IS NULL AND @ServerCertificate IS NULL) OR (@BackupSoftware IS NULL AND @Encrypt = 'Y' AND @ServerAsymmetricKey IS NOT NULL AND @ServerCertificate IS NOT NULL) OR (@ServerAsymmetricKey IS NOT NULL AND NOT EXISTS(SELECT * FROM master.sys.asymmetric_keys WHERE name = @ServerAsymmetricKey))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @ServerAsymmetricKey is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@EncryptionKey IS NOT NULL AND @BackupSoftware IS NULL) OR (@EncryptionKey IS NOT NULL AND @Encrypt = 'N') OR (@EncryptionKey IS NULL AND @Encrypt = 'Y' AND @BackupSoftware IN('LITESPEED','SQLBACKUP','SQLSAFE')) OR (@EncryptionKey IS NOT NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @EncryptionKey is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @ReadWriteFileGroups NOT IN('Y','N') OR @ReadWriteFileGroups IS NULL OR (@ReadWriteFileGroups = 'Y' AND @BackupType = 'LOG')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @ReadWriteFileGroups is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @OverrideBackupPreference NOT IN('Y','N') OR @OverrideBackupPreference IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @OverrideBackupPreference is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @NoRecovery NOT IN('Y','N') OR @NoRecovery IS NULL OR (@NoRecovery = 'Y' AND @BackupType <> 'LOG') OR (@NoRecovery = 'Y' AND @BackupSoftware = 'SQLSAFE')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @NoRecovery is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@URL IS NOT NULL AND @Directory IS NOT NULL) OR (@URL IS NOT NULL AND @MirrorDirectory IS NOT NULL) OR (@URL IS NOT NULL AND @Version < 11.03339) OR (@URL IS NOT NULL AND @BackupSoftware IS NOT NULL) OR (@URL NOT LIKE 'https://%/%')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @URL is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Credential IS NULL AND @URL IS NOT NULL AND NOT (@Version >= 13 OR SERVERPROPERTY('EngineEdition') = 8)) OR (@Credential IS NOT NULL AND @URL IS NULL) OR (@URL IS NOT NULL AND @Credential IS NULL AND NOT EXISTS(SELECT * FROM sys.credentials WHERE credential_identity = 'SHARED ACCESS SIGNATURE')) OR (@Credential IS NOT NULL AND NOT EXISTS(SELECT * FROM sys.credentials WHERE name = @Credential))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Credential is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MirrorCleanupTime < 0 OR (@MirrorCleanupTime IS NOT NULL AND @MirrorDirectory IS NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MirrorCleanupTime is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MirrorCleanupMode NOT IN('BEFORE_BACKUP','AFTER_BACKUP') OR @MirrorCleanupMode IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MirrorCleanupMode is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@MirrorURL IS NOT NULL AND @Directory IS NOT NULL) OR (@MirrorURL IS NOT NULL AND @MirrorDirectory IS NOT NULL) OR (@MirrorURL IS NOT NULL AND @Version < 11.03339) OR (@MirrorURL IS NOT NULL AND @BackupSoftware IS NOT NULL) OR (@MirrorURL NOT LIKE 'https://%/%') OR (@MirrorURL IS NOT NULL AND @URL IS NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MirrorURL is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Updateability NOT IN('READ_ONLY','READ_WRITE','ALL') OR @Updateability IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Updateability is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @AdaptiveCompression NOT IN('SIZE','SPEED') OR (@AdaptiveCompression IS NOT NULL AND (@BackupSoftware NOT IN('LITESPEED') OR @BackupSoftware IS NULL))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @AdaptiveCompression is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@ModificationLevel IS NOT NULL AND NOT (@Version >= 13.05026)) OR (@ModificationLevel IS NOT NULL AND @ChangeBackupType = 'N') OR (@ModificationLevel IS NOT NULL AND @BackupType <> 'DIFF')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @ModificationLevel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@LogSizeSinceLastLogBackup IS NOT NULL AND NOT (@Version >= 13.05026)) OR (@LogSizeSinceLastLogBackup IS NOT NULL AND @TimeSinceLastLogBackup IS NULL) OR (@LogSizeSinceLastLogBackup IS NULL AND @TimeSinceLastLogBackup IS NOT NULL) OR (@LogSizeSinceLastLogBackup IS NOT NULL AND @BackupType <> 'LOG')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogSizeSinceLastLogBackup is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@TimeSinceLastLogBackup IS NOT NULL AND NOT (@Version >= 13.05026)) OR (@TimeSinceLastLogBackup IS NOT NULL AND @LogSizeSinceLastLogBackup IS NULL) OR (@TimeSinceLastLogBackup IS NULL AND @LogSizeSinceLastLogBackup IS NOT NULL) OR (@TimeSinceLastLogBackup IS NOT NULL AND @BackupType <> 'LOG')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @TimeSinceLastLogBackup is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@DataDomainBoostHost IS NOT NULL AND (@BackupSoftware <> 'DATA_DOMAIN_BOOST' OR @BackupSoftware IS NULL)) OR (@DataDomainBoostHost IS NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DataDomainBoostHost is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@DataDomainBoostUser IS NOT NULL AND (@BackupSoftware <> 'DATA_DOMAIN_BOOST' OR @BackupSoftware IS NULL)) OR (@DataDomainBoostUser IS NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DataDomainBoostUser is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@DataDomainBoostDevicePath IS NOT NULL AND (@BackupSoftware <> 'DATA_DOMAIN_BOOST' OR @BackupSoftware IS NULL)) OR (@DataDomainBoostDevicePath IS NULL AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DataDomainBoostDevicePath is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DataDomainBoostLockboxPath IS NOT NULL AND (@BackupSoftware <> 'DATA_DOMAIN_BOOST' OR @BackupSoftware IS NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DataDomainBoostLockboxPath is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DirectoryStructure = ''
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DirectoryStructure is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @AvailabilityGroupDirectoryStructure = ''
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @AvailabilityGroupDirectoryStructure is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FileName IS NULL OR @FileName = '' OR @FileName NOT LIKE '%.{FileExtension}' OR (@NumberOfFiles > 1 AND @FileName NOT LIKE '%{FileNumber}%') OR @FileName LIKE '%{DirectorySeperator}%' OR @FileName LIKE '%/%' OR @FileName LIKE '%\%'
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FileName is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (SERVERPROPERTY('IsHadrEnabled') = 1 AND @AvailabilityGroupFileName IS NULL) OR @AvailabilityGroupFileName = '' OR @AvailabilityGroupFileName NOT LIKE '%.{FileExtension}' OR (@NumberOfFiles > 1 AND @AvailabilityGroupFileName NOT LIKE '%{FileNumber}%') OR @AvailabilityGroupFileName LIKE '%{DirectorySeperator}%' OR @AvailabilityGroupFileName LIKE '%/%' OR @AvailabilityGroupFileName LIKE '%\%'
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @AvailabilityGroupFileName is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@DirectoryStructure,'{DirectorySeparator}',''),'{ServerName}',''),'{InstanceName}',''),'{ServiceName}',''),'{ClusterName}',''),'{AvailabilityGroupName}',''),'{DatabaseName}',''),'{BackupType}',''),'{Partial}',''),'{CopyOnly}',''),'{Description}',''),'{Year}',''),'{Month}',''),'{Day}',''),'{Hour}',''),'{Minute}',''),'{Second}','') LIKE '%{%'
  OR REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@DirectoryStructure,'{DirectorySeparator}',''),'{ServerName}',''),'{InstanceName}',''),'{ServiceName}',''),'{ClusterName}',''),'{AvailabilityGroupName}',''),'{DatabaseName}',''),'{BackupType}',''),'{Partial}',''),'{CopyOnly}',''),'{Description}',''),'{Year}',''),'{Month}',''),'{Day}',''),'{Hour}',''),'{Minute}',''),'{Second}','') LIKE '%}%'
  BEGIN
    SET @ErrorMessage = 'The parameter @DirectoryStructure contains one or more tokens that are not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@AvailabilityGroupDirectoryStructure,'{DirectorySeparator}',''),'{ServerName}',''),'{InstanceName}',''),'{ServiceName}',''),'{ClusterName}',''),'{AvailabilityGroupName}',''),'{DatabaseName}',''),'{BackupType}',''),'{Partial}',''),'{CopyOnly}',''),'{Description}',''),'{Year}',''),'{Month}',''),'{Day}',''),'{Hour}',''),'{Minute}',''),'{Second}','') LIKE '%{%'
  OR REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@AvailabilityGroupDirectoryStructure,'{DirectorySeparator}',''),'{ServerName}',''),'{InstanceName}',''),'{ServiceName}',''),'{ClusterName}',''),'{AvailabilityGroupName}',''),'{DatabaseName}',''),'{BackupType}',''),'{Partial}',''),'{CopyOnly}',''),'{Description}',''),'{Year}',''),'{Month}',''),'{Day}',''),'{Hour}',''),'{Minute}',''),'{Second}','') LIKE '%}%'
  BEGIN
    SET @ErrorMessage = 'The parameter @AvailabilityGroupDirectoryStructure contains one or more tokens that are not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@FileName,'{DirectorySeparator}',''),'{ServerName}',''),'{InstanceName}',''),'{ServiceName}',''),'{ClusterName}',''),'{AvailabilityGroupName}',''),'{DatabaseName}',''),'{BackupType}',''),'{Partial}',''),'{CopyOnly}',''),'{Description}',''),'{Year}',''),'{Month}',''),'{Day}',''),'{Hour}',''),'{Minute}',''),'{Second}',''),'{FileNumber}',''),'{FileExtension}','') LIKE '%{%'
  OR REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@FileName,'{DirectorySeparator}',''),'{ServerName}',''),'{InstanceName}',''),'{ServiceName}',''),'{ClusterName}',''),'{AvailabilityGroupName}',''),'{DatabaseName}',''),'{BackupType}',''),'{Partial}',''),'{CopyOnly}',''),'{Description}',''),'{Year}',''),'{Month}',''),'{Day}',''),'{Hour}',''),'{Minute}',''),'{Second}',''),'{FileNumber}',''),'{FileExtension}','') LIKE '%}%'
  BEGIN
    SET @ErrorMessage = 'The parameter @FileName contains one or more tokens that are not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@AvailabilityGroupFileName,'{DirectorySeparator}',''),'{ServerName}',''),'{InstanceName}',''),'{ServiceName}',''),'{ClusterName}',''),'{AvailabilityGroupName}',''),'{DatabaseName}',''),'{BackupType}',''),'{Partial}',''),'{CopyOnly}',''),'{Description}',''),'{Year}',''),'{Month}',''),'{Day}',''),'{Hour}',''),'{Minute}',''),'{Second}',''),'{FileNumber}',''),'{FileExtension}','') LIKE '%{%'
  OR REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@AvailabilityGroupFileName,'{DirectorySeparator}',''),'{ServerName}',''),'{InstanceName}',''),'{ServiceName}',''),'{ClusterName}',''),'{AvailabilityGroupName}',''),'{DatabaseName}',''),'{BackupType}',''),'{Partial}',''),'{CopyOnly}',''),'{Description}',''),'{Year}',''),'{Month}',''),'{Day}',''),'{Hour}',''),'{Minute}',''),'{Second}',''),'{FileNumber}',''),'{FileExtension}','') LIKE '%}%'
  BEGIN
    SET @ErrorMessage = 'The parameter @AvailabilityGroupFileName contains one or more tokens that are not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FileExtensionFull LIKE '%.%'
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FileExtensionFull is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FileExtensionDiff LIKE '%.%'
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FileExtensionDiff is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FileExtensionLog LIKE '%.%'
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FileExtensionLog is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Init NOT IN('Y','N') OR @Init IS NULL OR (@Init = 'Y' AND @BackupType = 'LOG') OR (@Init = 'Y' AND @BackupSoftware = 'DATA_DOMAIN_BOOST')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Init is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabaseOrder NOT IN('DATABASE_NAME_ASC','DATABASE_NAME_DESC','DATABASE_SIZE_ASC','DATABASE_SIZE_DESC','LOG_SIZE_SINCE_LAST_LOG_BACKUP_ASC','LOG_SIZE_SINCE_LAST_LOG_BACKUP_DESC') OR (@DatabaseOrder IN('LOG_SIZE_SINCE_LAST_LOG_BACKUP_ASC','LOG_SIZE_SINCE_LAST_LOG_BACKUP_DESC') AND NOT (@Version >= 13.05026 OR SERVERPROPERTY('EngineEdition') = 8)) OR (@DatabaseOrder IS NOT NULL AND SERVERPROPERTY('EngineEdition') = 5)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DatabaseOrder is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel NOT IN('Y','N') OR @DatabasesInParallel IS NULL OR (@DatabasesInParallel = 'Y' AND SERVERPROPERTY('EngineEdition') = 5)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DatabasesInParallel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable NOT IN('Y','N') OR @LogToTable IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogToTable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Execute is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ErrorMessage = 'The documentation is available at https://ola.hallengren.com/sql-server-backup.html.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @RETURNCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Check that selected databases and availability groups exist                                //--
  ----------------------------------------------------------------------------------------------------

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedDatabases
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases in the @Databases parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(AvailabilityGroupName) + ', '
  FROM @SelectedAvailabilityGroups
  WHERE AvailabilityGroupName NOT LIKE '%[%]%'
  AND AvailabilityGroupName NOT IN (SELECT AvailabilityGroupName FROM @tmpAvailabilityGroups)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following availability groups do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Check @@SERVERNAME                                                                         //--
  ----------------------------------------------------------------------------------------------------

  IF @@SERVERNAME <> CAST(SERVERPROPERTY('ServerName') AS nvarchar(max)) AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN
    SET @ErrorMessage = 'The @@SERVERNAME does not match SERVERPROPERTY(''ServerName''). See ' + CASE WHEN SERVERPROPERTY('IsClustered') = 0 THEN 'https://docs.microsoft.com/en-us/sql/database-engine/install-windows/rename-a-computer-that-hosts-a-stand-alone-instance-of-sql-server' WHEN SERVERPROPERTY('IsClustered') = 1 THEN 'https://docs.microsoft.com/en-us/sql/sql-server/failover-clusters/install/rename-a-sql-server-failover-cluster-instance' END + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Check Availability Group cluster name                                                      //--
  ----------------------------------------------------------------------------------------------------

  IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN
    SELECT @Cluster = NULLIF(cluster_name,'')
    FROM sys.dm_hadr_cluster
  END

  ----------------------------------------------------------------------------------------------------
  --// Update database order                                                                      //--
  ----------------------------------------------------------------------------------------------------

  IF @DatabaseOrder IN('DATABASE_SIZE_ASC','DATABASE_SIZE_DESC')
  BEGIN
    UPDATE tmpDatabases
    SET DatabaseSize = (SELECT SUM(size) FROM sys.master_files WHERE [type] = 0 AND database_id = DB_ID(tmpDatabases.DatabaseName))
    FROM @tmpDatabases tmpDatabases
  END

  IF @DatabaseOrder IN('LOG_SIZE_SINCE_LAST_LOG_BACKUP_ASC','LOG_SIZE_SINCE_LAST_LOG_BACKUP_DESC')
  BEGIN
    UPDATE tmpDatabases
    SET LogSizeSinceLastLogBackup = (SELECT log_since_last_log_backup_mb FROM sys.dm_db_log_stats(DB_ID(tmpDatabases.DatabaseName)))
    FROM @tmpDatabases tmpDatabases
  END

  IF @DatabaseOrder IS NULL
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY StartPosition ASC, DatabaseName ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_NAME_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseName ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_NAME_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseName DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_SIZE_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseSize ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_SIZE_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseSize DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'LOG_SIZE_SINCE_LAST_LOG_BACKUP_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY LogSizeSinceLastLogBackup ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'LOG_SIZE_SINCE_LAST_LOG_BACKUP_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY LogSizeSinceLastLogBackup DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END

  ----------------------------------------------------------------------------------------------------
  --// Update the queue                                                                           //--
  ----------------------------------------------------------------------------------------------------

  IF @DatabasesInParallel = 'Y'
  BEGIN

    BEGIN TRY

      SELECT @QueueID = QueueID
      FROM dbo.[Queue]
      WHERE SchemaName = @SchemaName
      AND ObjectName = @ObjectName
      AND [Parameters] = @Parameters

      IF @QueueID IS NULL
      BEGIN
        BEGIN TRANSACTION

        SELECT @QueueID = QueueID
        FROM dbo.[Queue] WITH (UPDLOCK, TABLOCK)
        WHERE SchemaName = @SchemaName
        AND ObjectName = @ObjectName
        AND [Parameters] = @Parameters

        IF @QueueID IS NULL
        BEGIN
          INSERT INTO dbo.[Queue] (SchemaName, ObjectName, [Parameters])
          SELECT @SchemaName, @ObjectName, @Parameters

          SET @QueueID = SCOPE_IDENTITY()
        END

        COMMIT TRANSACTION
      END

      BEGIN TRANSACTION

      UPDATE [Queue]
      SET QueueStartTime = GETDATE(),
          SessionID = @@SPID,
          RequestID = (SELECT request_id FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          RequestStartTime = (SELECT start_time FROM sys.dm_exec_requests WHERE session_id = @@SPID)
      FROM dbo.[Queue] [Queue]
      WHERE QueueID = @QueueID
      AND NOT EXISTS (SELECT *
                      FROM sys.dm_exec_requests
                      WHERE session_id = [Queue].SessionID
                      AND request_id = [Queue].RequestID
                      AND start_time = [Queue].RequestStartTime)
      AND NOT EXISTS (SELECT *
                      FROM dbo.QueueDatabase QueueDatabase
                      INNER JOIN sys.dm_exec_requests ON QueueDatabase.SessionID = session_id AND QueueDatabase.RequestID = request_id AND QueueDatabase.RequestStartTime = start_time
                      WHERE QueueDatabase.QueueID = @QueueID)

      IF @@ROWCOUNT = 1
      BEGIN
        INSERT INTO dbo.QueueDatabase (QueueID, DatabaseName)
        SELECT @QueueID AS QueueID,
               DatabaseName
        FROM @tmpDatabases tmpDatabases
        WHERE Selected = 1
        AND NOT EXISTS (SELECT * FROM dbo.QueueDatabase WHERE DatabaseName = tmpDatabases.DatabaseName AND QueueID = @QueueID)

        DELETE QueueDatabase
        FROM dbo.QueueDatabase QueueDatabase
        WHERE QueueID = @QueueID
        AND NOT EXISTS (SELECT * FROM @tmpDatabases tmpDatabases WHERE DatabaseName = QueueDatabase.DatabaseName AND Selected = 1)

        UPDATE QueueDatabase
        SET DatabaseOrder = tmpDatabases.[Order]
        FROM dbo.QueueDatabase QueueDatabase
        INNER JOIN @tmpDatabases tmpDatabases ON QueueDatabase.DatabaseName = tmpDatabases.DatabaseName
      END

      COMMIT TRANSACTION

      SELECT @QueueStartTime = QueueStartTime
      FROM dbo.[Queue]
      WHERE QueueID = @QueueID

    END TRY

    BEGIN CATCH
      IF XACT_STATE() <> 0
      BEGIN
        ROLLBACK TRANSACTION
      END
      SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CHAR(13) + CHAR(10) + ' '
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
      SET @RETURNCode = ERROR_NUMBER()
      GOTO Logging
    END CATCH

  END

  ----------------------------------------------------------------------------------------------------
  --// Execute backup commands                                                                    //--
  ----------------------------------------------------------------------------------------------------

  WHILE (1 = 1)
  BEGIN

    IF @DatabasesInParallel = 'Y'
    BEGIN
      UPDATE QueueDatabase
      SET DatabaseStartTime = NULL,
          SessionID = NULL,
          RequestID = NULL,
          RequestStartTime = NULL
      FROM dbo.QueueDatabase QueueDatabase
      WHERE QueueID = @QueueID
      AND DatabaseStartTime IS NOT NULL
      AND DatabaseENDTime IS NULL
      AND NOT EXISTS (SELECT * FROM sys.dm_exec_requests WHERE session_id = QueueDatabase.SessionID AND request_id = QueueDatabase.RequestID AND start_time = QueueDatabase.RequestStartTime)

      UPDATE QueueDatabase
      SET DatabaseStartTime = GETDATE(),
          DatabaseENDTime = NULL,
          SessionID = @@SPID,
          RequestID = (SELECT request_id FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          RequestStartTime = (SELECT start_time FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          @CurrentDatabaseName = DatabaseName,
          @CurrentDatabaseNameFS = (SELECT DatabaseNameFS FROM @tmpDatabases WHERE DatabaseName = QueueDatabase.DatabaseName)
      FROM (SELECT TOP 1 DatabaseStartTime,
                         DatabaseENDTime,
                         SessionID,
                         RequestID,
                         RequestStartTime,
                         DatabaseName
            FROM dbo.QueueDatabase
            WHERE QueueID = @QueueID
            AND (DatabaseStartTime < @QueueStartTime OR DatabaseStartTime IS NULL)
            AND NOT (DatabaseStartTime IS NOT NULL AND DatabaseENDTime IS NULL)
            ORDER BY DatabaseOrder ASC
            ) QueueDatabase
    END
    ELSE
    BEGIN
      SELECT TOP 1 @CurrentDBID = ID,
                   @CurrentDatabaseName = DatabaseName,
                   @CurrentDatabaseNameFS = DatabaseNameFS
      FROM @tmpDatabases
      WHERE Selected = 1
      AND Completed = 0
      ORDER BY [Order] ASC
    END

    IF @@ROWCOUNT = 0
    BEGIN
      BREAK
    END

    SET @CurrentDatabaseID = DB_ID(@CurrentDatabaseName)

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    BEGIN
      IF EXISTS (SELECT * FROM sys.database_recovery_status WHERE database_id = @CurrentDatabaseID AND database_guid IS NOT NULL)
      BEGIN
        SET @CurrentIsDatabaseAccessible = 1
      END
      ELSE
      BEGIN
        SET @CurrentIsDatabaseAccessible = 0
      END
    END

    IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
    BEGIN
      SELECT @CurrentAvailabilityGroup = availability_groups.name,
             @CurrentAvailabilityGroupRole = dm_hadr_availability_replica_states.role_desc,
             @CurrentAvailabilityGroupBackupPreference = UPPER(availability_groups.automated_backup_preference_desc)
      FROM sys.databases databases
      INNER JOIN sys.availability_databases_cluster availability_databases_cluster ON databases.group_database_id = availability_databases_cluster.group_database_id
      INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
      INNER JOIN sys.dm_hadr_availability_replica_states dm_hadr_availability_replica_states ON availability_groups.group_id = dm_hadr_availability_replica_states.group_id AND databases.replica_id = dm_hadr_availability_replica_states.replica_id
      WHERE databases.name = @CurrentDatabaseName
    END

    IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1 AND @CurrentAvailabilityGroup IS NOT NULL
    BEGIN
      SELECT @CurrentIsPreferredBackupReplica = sys.fn_hadr_backup_is_preferred_replica(@CurrentDatabaseName)
    END

    SELECT @CurrentDifferentialBaseLSN = differential_base_lsn
    FROM sys.master_files
    WHERE database_id = @CurrentDatabaseID
    AND [type] = 0
    AND [file_id] = 1

    -- Workaround for a bug in SQL Server 2005
    IF @Version >= 9 AND @Version < 10
    AND EXISTS(SELECT * FROM sys.master_files WHERE database_id = @CurrentDatabaseID AND [type] = 0 AND [file_id] = 1 AND differential_base_lsn IS NOT NULL AND differential_base_guid IS NOT NULL AND differential_base_time IS NULL)
    BEGIN
      SET @CurrentDifferentialBaseLSN = NULL
    END

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    BEGIN
      SELECT @CurrentLogLSN = last_log_backup_lsn
      FROM sys.database_recovery_status
      WHERE database_id = @CurrentDatabaseID
    END

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE' AND @Version >= 13.05026 AND (@CurrentAvailabilityGroupRole = 'PRIMARY' OR @CurrentAvailabilityGroupRole IS NULL)
    BEGIN
      SET @CurrentCommand07 = 'SELECT @ParamAllocatedExtentPageCount = SUM(allocated_extent_page_count), @ParamModifiedExtentPageCount = SUM(modified_extent_page_count) FROM ' + QUOTENAME(@CurrentDatabaseName) + '.sys.dm_db_file_space_usage'

      EXECUTE sp_executesql @statement = @CurrentCommand07, @params = N'@ParamAllocatedExtentPageCount bigint OUTPUT, @ParamModifiedExtentPageCount bigint OUTPUT', @ParamAllocatedExtentPageCount = @CurrentAllocatedExtentPageCount OUTPUT, @ParamModifiedExtentPageCount = @CurrentModifiedExtentPageCount OUTPUT
    END

    SET @CurrentBackupType = @BackupType

    IF @ChangeBackupType = 'Y'
    BEGIN
      IF @CurrentBackupType = 'LOG' AND DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') <> 'SIMPLE' AND @CurrentLogLSN IS NULL AND @CurrentDatabaseName <> 'master'
      BEGIN
        SET @CurrentBackupType = 'DIFF'
      END
      IF @CurrentBackupType = 'DIFF' AND @CurrentDatabaseName <> 'master' AND (@CurrentDifferentialBaseLSN IS NULL OR (@CurrentModifiedExtentPageCount * 1. / @CurrentAllocatedExtentPageCount * 100 >= @ModificationLevel))
      BEGIN
        SET @CurrentBackupType = 'FULL'
      END
    END

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE' AND @Version >= 13.05026
    BEGIN
      SELECT @CurrentLastLogBackup = log_backup_time,
             @CurrentLogSizeSinceLastLogBackup = log_since_last_log_backup_mb
      FROM sys.dm_db_log_stats (@CurrentDatabaseID)
    END

    IF @CurrentBackupType = 'DIFF'
    BEGIN
      SELECT @CurrentDifferentialBaseIsSnapshot = is_snapshot
      FROM msdb.dbo.backupset
      WHERE database_name = @CurrentDatabaseName
      AND [type] = 'D'
      AND checkpoint_lsn = @CurrentDifferentialBaseLSN
    END

    SELECT @CurrentDatabaseMirroringRole = UPPER(mirroring_role_desc)
    FROM sys.database_mirroring
    WHERE database_id = @CurrentDatabaseID

    IF EXISTS (SELECT * FROM msdb.dbo.log_shipping_primary_databases WHERE primary_database = @CurrentDatabaseName)
    BEGIN
      SET @CurrentLogShippingRole = 'PRIMARY'
    END
    ELSE
    IF EXISTS (SELECT * FROM msdb.dbo.log_shipping_secondary_databases WHERE secondary_database = @CurrentDatabaseName)
    BEGIN
      SET @CurrentLogShippingRole = 'SECONDARY'
    END

    SELECT @CurrentIsReadOnly = is_read_only
    FROM sys.databases
    WHERE name = @CurrentDatabaseName

    IF @Version >= 10
    BEGIN
      SET @CurrentCommand06 = 'SELECT @ParamIsEncrypted = is_encrypted FROM sys.databases WHERE name = @ParamDatabaseName'

      EXECUTE sp_executesql @statement = @CurrentCommand06, @params = N'@ParamDatabaseName nvarchar(max), @ParamIsEncrypted bit OUTPUT', @ParamDatabaseName = @CurrentDatabaseName, @ParamIsEncrypted = @CurrentIsEncrypted OUTPUT
    END

    SET @DatabaseMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Database: ' + QUOTENAME(@CurrentDatabaseName)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Status: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Standby: ' + CASE WHEN DATABASEPROPERTYEX(@CurrentDatabaseName,'IsInStandBy') = 1 THEN 'Yes' ELSE 'No' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage =  'Updateability: ' + CASE WHEN @CurrentIsReadOnly = 1 THEN 'READ_ONLY' WHEN  @CurrentIsReadOnly = 0 THEN 'READ_WRITE' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage =  'User access: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'UserAccess') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentIsDatabaseAccessible IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Is accessible: ' + CASE WHEN @CurrentIsDatabaseAccessible = 1 THEN 'Yes' ELSE 'No' END
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    SET @DatabaseMessage = 'Recovery model: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Encrypted: ' + CASE WHEN @CurrentIsEncrypted = 1 THEN 'Yes' WHEN @CurrentIsEncrypted = 0 THEN 'No' ELSE 'N/A' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentAvailabilityGroup IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Availability group: ' + @CurrentAvailabilityGroup
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      SET @DatabaseMessage = 'Availability group role: ' + @CurrentAvailabilityGroupRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      SET @DatabaseMessage = 'Availability group backup preference: ' + @CurrentAvailabilityGroupBackupPreference
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      SET @DatabaseMessage = 'Is preferred backup replica: ' + CASE WHEN @CurrentIsPreferredBackupReplica = 1 THEN 'Yes' WHEN @CurrentIsPreferredBackupReplica = 0 THEN 'No' ELSE 'N/A' END
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    IF @CurrentDatabaseMirroringRole IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Database mirroring role: ' + @CurrentDatabaseMirroringRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    IF @CurrentLogShippingRole IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Log shipping role: ' + @CurrentLogShippingRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    SET @DatabaseMessage = 'Differential base LSN: ' + ISNULL(CAST(@CurrentDifferentialBaseLSN AS nvarchar),'N/A')
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentBackupType = 'DIFF'
    BEGIN
      SET @DatabaseMessage = 'Differential base is snapshot: ' + CASE WHEN @CurrentDifferentialBaseIsSnapshot = 1 THEN 'Yes' WHEN @CurrentDifferentialBaseIsSnapshot = 0 THEN 'No' ELSE 'N/A' END
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    SET @DatabaseMessage = 'Last log backup LSN: ' + ISNULL(CAST(@CurrentLogLSN AS nvarchar),'N/A')
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentBackupType IN('DIFF','FULL') AND @Version >= 13.05026
    BEGIN
      SET @DatabaseMessage = 'Allocated extent page count: ' + ISNULL(CAST(@CurrentAllocatedExtentPageCount AS nvarchar),'N/A')
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      SET @DatabaseMessage = 'Modified extent page count: ' + ISNULL(CAST(@CurrentModifiedExtentPageCount AS nvarchar),'N/A')
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    IF @CurrentBackupType = 'LOG' AND @Version >= 13.05026
    BEGIN
      SET @DatabaseMessage = 'Last log backup: ' + ISNULL(CONVERT(nvarchar(19),@CurrentLastLogBackup,120),'N/A')
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      SET @DatabaseMessage = 'Log size since last log backup (MB): ' + ISNULL(CAST(@CurrentLogSizeSinceLastLogBackup AS nvarchar),'N/A')
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    RAISERROR('',10,1) WITH NOWAIT

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    AND (@CurrentIsDatabaseAccessible = 1 OR @CurrentIsDatabaseAccessible IS NULL)
    AND DATABASEPROPERTYEX(@CurrentDatabaseName,'IsInStandBy') = 0
    AND NOT (@CurrentBackupType = 'LOG' AND (DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') = 'SIMPLE' OR @CurrentLogLSN IS NULL))
    AND NOT (@CurrentBackupType = 'DIFF' AND @CurrentDifferentialBaseLSN IS NULL)
    AND NOT (@CurrentBackupType IN('DIFF','LOG') AND @CurrentDatabaseName = 'master')
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'FULL' AND @CopyOnly = 'N' AND (@CurrentAvailabilityGroupRole <> 'PRIMARY' OR @CurrentAvailabilityGroupRole IS NULL))
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'FULL' AND @CopyOnly = 'Y' AND (@CurrentIsPreferredBackupReplica <> 1 OR @CurrentIsPreferredBackupReplica IS NULL) AND @OverrideBackupPreference = 'N')
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'DIFF' AND (@CurrentAvailabilityGroupRole <> 'PRIMARY' OR @CurrentAvailabilityGroupRole IS NULL))
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'LOG' AND @CopyOnly = 'N' AND (@CurrentIsPreferredBackupReplica <> 1 OR @CurrentIsPreferredBackupReplica IS NULL) AND @OverrideBackupPreference = 'N')
    AND NOT (@CurrentAvailabilityGroup IS NOT NULL AND @CurrentBackupType = 'LOG' AND @CopyOnly = 'Y' AND (@CurrentAvailabilityGroupRole <> 'PRIMARY' OR @CurrentAvailabilityGroupRole IS NULL))
    AND NOT ((@CurrentLogShippingRole = 'PRIMARY' AND @CurrentLogShippingRole IS NOT NULL) AND @CurrentBackupType = 'LOG')
    AND NOT (@CurrentIsReadOnly = 1 AND @Updateability = 'READ_WRITE')
    AND NOT (@CurrentIsReadOnly = 0 AND @Updateability = 'READ_ONLY')
    AND NOT (@CurrentBackupType = 'LOG' AND @LogSizeSinceLastLogBackup IS NOT NULL AND @TimeSinceLastLogBackup IS NOT NULL AND NOT(@CurrentLogSizeSinceLastLogBackup >= @LogSizeSinceLastLogBackup OR @CurrentLogSizeSinceLastLogBackup IS NULL OR DATEDIFF(SECOND,@CurrentLastLogBackup,GETDATE()) >= @TimeSinceLastLogBackup OR @CurrentLastLogBackup IS NULL))
    BEGIN

      IF @CurrentBackupType = 'LOG' AND (@CleanupTime IS NOT NULL OR @MirrorCleanupTime IS NOT NULL)
      BEGIN
        SELECT @CurrentLatestBackup = MAX(backup_finish_date)
        FROM msdb.dbo.backupset
        WHERE ([type] IN('D','I')
        OR database_backup_lsn < @CurrentDifferentialBaseLSN)
        AND is_damaged = 0
        AND database_name = @CurrentDatabaseName
      END

      SET @CurrentDate = GETDATE()

      INSERT INTO @CurrentCleanupDates (CleanupDate)
      SELECT @CurrentDate

      IF @CurrentBackupType = 'LOG'
      BEGIN
        INSERT INTO @CurrentCleanupDates (CleanupDate)
        SELECT @CurrentLatestBackup
      END

      SELECT @CurrentDirectoryStructure = CASE
      WHEN @CurrentAvailabilityGroup IS NOT NULL THEN @AvailabilityGroupDirectoryStructure
      ELSE @DirectoryStructure
      END

      IF @CurrentDirectoryStructure IS NOT NULL
      BEGIN
      -- Directory structure - remove tokens that are not needed
        IF @ReadWriteFileGroups = 'N' SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Partial}','')
        IF @CopyOnly = 'N' SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{CopyOnly}','')
        IF @Cluster IS NULL SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{ClusterName}','')
        IF @CurrentAvailabilityGroup IS NULL SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{AvailabilityGroupName}','')
        IF SERVERPROPERTY('InstanceName') IS NULL SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{InstanceName}','')
        IF @@SERVICENAME IS NULL SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{ServiceName}','')
        IF @Description IS NULL SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Description}','')

        IF @Directory IS NULL AND @MirrorDirectory IS NULL AND @URL IS NULL AND @DefaultDirectory LIKE '%' + '.' + @@SERVICENAME + @DirectorySeparator + 'MSSQL' + @DirectorySeparator + 'Backup'
        BEGIN
          SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{ServerName}','')
          SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{InstanceName}','')
          SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{ClusterName}','')
          SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{AvailabilityGroupName}','')
        END

        WHILE (@Updated = 1 OR @Updated IS NULL)
        BEGIN
          SET @Updated = 0

          IF CHARINDEX('\',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'\','{DirectorySeparator}')
            SET @Updated = 1
          END

          IF CHARINDEX('/',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'/','{DirectorySeparator}')
            SET @Updated = 1
          END

          IF CHARINDEX('__',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'__','_')
            SET @Updated = 1
          END

          IF CHARINDEX('--',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'--','-')
            SET @Updated = 1
          END

          IF CHARINDEX('{DirectorySeparator}{DirectorySeparator}',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{DirectorySeparator}{DirectorySeparator}','{DirectorySeparator}')
            SET @Updated = 1
          END

          IF CHARINDEX('{DirectorySeparator}$',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{DirectorySeparator}$','{DirectorySeparator}')
            SET @Updated = 1
          END
          IF CHARINDEX('${DirectorySeparator}',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'${DirectorySeparator}','{DirectorySeparator}')
            SET @Updated = 1
          END

          IF CHARINDEX('{DirectorySeparator}_',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{DirectorySeparator}_','{DirectorySeparator}')
            SET @Updated = 1
          END
          IF CHARINDEX('_{DirectorySeparator}',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'_{DirectorySeparator}','{DirectorySeparator}')
            SET @Updated = 1
          END

          IF CHARINDEX('{DirectorySeparator}-',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{DirectorySeparator}-','{DirectorySeparator}')
            SET @Updated = 1
          END
          IF CHARINDEX('-{DirectorySeparator}',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'-{DirectorySeparator}','{DirectorySeparator}')
            SET @Updated = 1
          END

          IF CHARINDEX('_$',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'_$','_')
            SET @Updated = 1
          END
          IF CHARINDEX('$_',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'$_','_')
            SET @Updated = 1
          END

          IF CHARINDEX('-$',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'-$','-')
            SET @Updated = 1
          END
          IF CHARINDEX('$-',@CurrentDirectoryStructure) > 0
          BEGIN
            SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'$-','-')
            SET @Updated = 1
          END

          IF LEFT(@CurrentDirectoryStructure,1) = '_'
          BEGIN
            SET @CurrentDirectoryStructure = RIGHT(@CurrentDirectoryStructure,LEN(@CurrentDirectoryStructure) - 1)
            SET @Updated = 1
          END
          IF RIGHT(@CurrentDirectoryStructure,1) = '_'
          BEGIN
            SET @CurrentDirectoryStructure = LEFT(@CurrentDirectoryStructure,LEN(@CurrentDirectoryStructure) - 1)
            SET @Updated = 1
          END

          IF LEFT(@CurrentDirectoryStructure,1) = '-'
          BEGIN
            SET @CurrentDirectoryStructure = RIGHT(@CurrentDirectoryStructure,LEN(@CurrentDirectoryStructure) - 1)
            SET @Updated = 1
          END
          IF RIGHT(@CurrentDirectoryStructure,1) = '-'
          BEGIN
            SET @CurrentDirectoryStructure = LEFT(@CurrentDirectoryStructure,LEN(@CurrentDirectoryStructure) - 1)
            SET @Updated = 1
          END

          IF LEFT(@CurrentDirectoryStructure,1) = '$'
          BEGIN
            SET @CurrentDirectoryStructure = RIGHT(@CurrentDirectoryStructure,LEN(@CurrentDirectoryStructure) - 1)
            SET @Updated = 1
          END
          IF RIGHT(@CurrentDirectoryStructure,1) = '$'
          BEGIN
            SET @CurrentDirectoryStructure = LEFT(@CurrentDirectoryStructure,LEN(@CurrentDirectoryStructure) - 1)
            SET @Updated = 1
          END

          IF LEFT(@CurrentDirectoryStructure,20) = '{DirectorySeparator}'
          BEGIN
            SET @CurrentDirectoryStructure = RIGHT(@CurrentDirectoryStructure,LEN(@CurrentDirectoryStructure) - 20)
            SET @Updated = 1
          END
          IF RIGHT(@CurrentDirectoryStructure,20) = '{DirectorySeparator}'
          BEGIN
            SET @CurrentDirectoryStructure = LEFT(@CurrentDirectoryStructure,LEN(@CurrentDirectoryStructure) - 20)
            SET @Updated = 1
          END
        END

        SET @Updated = NULL

        -- Directory structure - replace tokens with real values
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{DirectorySeparator}',@DirectorySeparator)
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{ServerName}',CASE WHEN SERVERPROPERTY('EngineEdition') = 8 THEN LEFT(CAST(SERVERPROPERTY('ServerName') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ServerName') AS nvarchar(max))) - 1) ELSE CAST(SERVERPROPERTY('MachineName') AS nvarchar(max)) END)
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{InstanceName}',ISNULL(CAST(SERVERPROPERTY('InstanceName') AS nvarchar(max)),''))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{ServiceName}',ISNULL(@@SERVICENAME,''))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{ClusterName}',ISNULL(@Cluster,''))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{AvailabilityGroupName}',ISNULL(@CurrentAvailabilityGroup,''))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{DatabaseName}',@CurrentDatabaseNameFS)
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{BackupType}',@CurrentBackupType)
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Partial}','PARTIAL')
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{CopyOnly}','COPY_ONLY')
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Description}',LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ISNULL(@Description,''),'\',''),'/',''),':',''),'*',''),'?',''),'"',''),'<',''),'>',''),'|',''))))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Year}',CAST(DATEPART(YEAR,@CurrentDate) AS nvarchar))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Month}',RIGHT('0' + CAST(DATEPART(MONTH,@CurrentDate) AS nvarchar),2))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Day}',RIGHT('0' + CAST(DATEPART(DAY,@CurrentDate) AS nvarchar),2))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Hour}',RIGHT('0' + CAST(DATEPART(HOUR,@CurrentDate) AS nvarchar),2))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Minute}',RIGHT('0' + CAST(DATEPART(MINUTE,@CurrentDate) AS nvarchar),2))
        SET @CurrentDirectoryStructure = REPLACE(@CurrentDirectoryStructure,'{Second}',RIGHT('0' + CAST(DATEPART(SECOND,@CurrentDate) AS nvarchar),2))
      END

      INSERT INTO @CurrentDirectories (ID, DirectoryPath, Mirror, DirectoryNumber, CreateCompleted, CleanupCompleted)
      SELECT ROW_NUMBER() OVER (ORDER BY ID),
             DirectoryPath + CASE WHEN @CurrentDirectoryStructure IS NOT NULL THEN @DirectorySeparator + @CurrentDirectoryStructure ELSE '' END,
             Mirror,
             ROW_NUMBER() OVER (PARTITION BY Mirror ORDER BY ID ASC),
             0,
             0
      FROM @Directories
      ORDER BY ID ASC

      INSERT INTO @CurrentURLs (ID, DirectoryPath, Mirror)
      SELECT ROW_NUMBER() OVER (ORDER BY ID),
             DirectoryPath + CASE WHEN @CurrentDirectoryStructure IS NOT NULL THEN @DirectorySeparator + @CurrentDirectoryStructure ELSE '' END,
             Mirror
      FROM @URLs
      ORDER BY ID ASC

      SELECT @CurrentDatabaseFileName = CASE
      WHEN @CurrentAvailabilityGroup IS NOT NULL THEN @AvailabilityGroupFileName
      ELSE @FileName
      END

      -- File name - remove tokens that are not needed
      IF @ReadWriteFileGroups = 'N' SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Partial}','')
      IF @CopyOnly = 'N' SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{CopyOnly}','')
      IF @Cluster IS NULL SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{ClusterName}','')
      IF @CurrentAvailabilityGroup IS NULL SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{AvailabilityGroupName}','')
      IF SERVERPROPERTY('InstanceName') IS NULL SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{InstanceName}','')
      IF @@SERVICENAME IS NULL SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{ServiceName}','')
      IF @Description IS NULL SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Description}','')
      IF @NumberOfFiles = 1 SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{FileNumber}','')

      WHILE (@Updated = 1 OR @Updated IS NULL)
      BEGIN
        SET @Updated = 0

        IF CHARINDEX('__',@CurrentDatabaseFileName) > 0
        BEGIN
          SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'__','_')
          SET @Updated = 1
        END

        IF CHARINDEX('--',@CurrentDatabaseFileName) > 0
        BEGIN
          SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'--','-')
          SET @Updated = 1
        END

        IF CHARINDEX('_$',@CurrentDatabaseFileName) > 0
        BEGIN
          SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'_$','_')
          SET @Updated = 1
        END
        IF CHARINDEX('$_',@CurrentDatabaseFileName) > 0
        BEGIN
          SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'$_','_')
          SET @Updated = 1
        END

        IF CHARINDEX('-$',@CurrentDatabaseFileName) > 0
        BEGIN
          SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'-$','-')
          SET @Updated = 1
        END
        IF CHARINDEX('$-',@CurrentDatabaseFileName) > 0
        BEGIN
          SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'$-','-')
          SET @Updated = 1
        END

        IF CHARINDEX('_.',@CurrentDatabaseFileName) > 0
        BEGIN
          SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'_.','.')
          SET @Updated = 1
        END

        IF CHARINDEX('-.',@CurrentDatabaseFileName) > 0
        BEGIN
          SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'-.','.')
          SET @Updated = 1
        END

        IF LEFT(@CurrentDatabaseFileName,1) = '_'
        BEGIN
          SET @CurrentDatabaseFileName = RIGHT(@CurrentDatabaseFileName,LEN(@CurrentDatabaseFileName) - 1)
          SET @Updated = 1
        END
        IF RIGHT(@CurrentDatabaseFileName,1) = '_'
        BEGIN
          SET @CurrentDatabaseFileName = LEFT(@CurrentDatabaseFileName,LEN(@CurrentDatabaseFileName) - 1)
          SET @Updated = 1
        END

        IF LEFT(@CurrentDatabaseFileName,1) = '-'
        BEGIN
          SET @CurrentDatabaseFileName = RIGHT(@CurrentDatabaseFileName,LEN(@CurrentDatabaseFileName) - 1)
          SET @Updated = 1
        END
        IF RIGHT(@CurrentDatabaseFileName,1) = '-'
        BEGIN
          SET @CurrentDatabaseFileName = LEFT(@CurrentDatabaseFileName,LEN(@CurrentDatabaseFileName) - 1)
          SET @Updated = 1
        END

        IF LEFT(@CurrentDatabaseFileName,1) = '$'
        BEGIN
          SET @CurrentDatabaseFileName = RIGHT(@CurrentDatabaseFileName,LEN(@CurrentDatabaseFileName) - 1)
          SET @Updated = 1
        END
        IF RIGHT(@CurrentDatabaseFileName,1) = '$'
        BEGIN
          SET @CurrentDatabaseFileName = LEFT(@CurrentDatabaseFileName,LEN(@CurrentDatabaseFileName) - 1)
          SET @Updated = 1
        END
      END

      SET @Updated = NULL

      SELECT @CurrentFileExtension = CASE
      WHEN @CurrentBackupType = 'FULL' THEN @FileExtensionFull
      WHEN @CurrentBackupType = 'DIFF' THEN @FileExtensionDiff
      WHEN @CurrentBackupType = 'LOG' THEN @FileExtensionLog
      END

      -- File name - replace tokens with real values
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{ServerName}',CASE WHEN SERVERPROPERTY('EngineEdition') = 8 THEN LEFT(CAST(SERVERPROPERTY('ServerName') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ServerName') AS nvarchar(max))) - 1) ELSE CAST(SERVERPROPERTY('MachineName') AS nvarchar(max)) END)
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{InstanceName}',ISNULL(CAST(SERVERPROPERTY('InstanceName') AS nvarchar(max)),''))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{ServiceName}',ISNULL(@@SERVICENAME,''))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{ClusterName}',ISNULL(@Cluster,''))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{AvailabilityGroupName}',ISNULL(@CurrentAvailabilityGroup,''))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{BackupType}',@CurrentBackupType)
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Partial}','PARTIAL')
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{CopyOnly}','COPY_ONLY')
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Description}',LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ISNULL(@Description,''),'\',''),'/',''),':',''),'*',''),'?',''),'"',''),'<',''),'>',''),'|',''))))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Year}',CAST(DATEPART(YEAR,@CurrentDate) AS nvarchar))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Month}',RIGHT('0' + CAST(DATEPART(MONTH,@CurrentDate) AS nvarchar),2))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Day}',RIGHT('0' + CAST(DATEPART(DAY,@CurrentDate) AS nvarchar),2))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Hour}',RIGHT('0' + CAST(DATEPART(HOUR,@CurrentDate) AS nvarchar),2))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Minute}',RIGHT('0' + CAST(DATEPART(MINUTE,@CurrentDate) AS nvarchar),2))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{Second}',RIGHT('0' + CAST(DATEPART(SECOND,@CurrentDate) AS nvarchar),2))
      SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{FileExtension}',@CurrentFileExtension)

      SELECT @CurrentMaxFilePathLength = CASE
      WHEN EXISTS (SELECT * FROM @CurrentDirectories) THEN (SELECT MAX(LEN(DirectoryPath + @DirectorySeparator)) FROM @CurrentDirectories)
      WHEN EXISTS (SELECT * FROM @CurrentURLs) THEN (SELECT MAX(LEN(DirectoryPath + @DirectorySeparator)) FROM @CurrentURLs)
      END
      + LEN(REPLACE(REPLACE(@CurrentDatabaseFileName,'{DatabaseName}',@CurrentDatabaseNameFS), '{FileNumber}', CASE WHEN @NumberOfFiles > 1 AND @NumberOfFiles <= 9 THEN '1' WHEN @NumberOfFiles >= 10 THEN '01' ELSE '' END))

      -- The maximum length of a backup device is 259 characters
      IF @CurrentMaxFilePathLength > 259
      BEGIN
        SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{DatabaseName}',LEFT(@CurrentDatabaseNameFS,CASE WHEN (LEN(@CurrentDatabaseNameFS) + 259 - @CurrentMaxFilePathLength - 3) < 20 THEN 20 ELSE (LEN(@CurrentDatabaseNameFS) + 259 - @CurrentMaxFilePathLength - 3) END) + '...')
      END
      ELSE
      BEGIN
        SET @CurrentDatabaseFileName = REPLACE(@CurrentDatabaseFileName,'{DatabaseName}',@CurrentDatabaseNameFS)
      END

      IF EXISTS (SELECT * FROM @CurrentDirectories WHERE Mirror = 0)
      BEGIN
        SET @CurrentFileNumber = 0

        WHILE @CurrentFileNumber < @NumberOfFiles
        BEGIN
          SET @CurrentFileNumber = @CurrentFileNumber + 1

          SELECT @CurrentDirectoryPath = DirectoryPath
          FROM @CurrentDirectories
          WHERE @CurrentFileNumber >= (DirectoryNumber - 1) * (SELECT @NumberOfFiles / COUNT(*) FROM @CurrentDirectories WHERE Mirror = 0) + 1
          AND @CurrentFileNumber <= DirectoryNumber * (SELECT @NumberOfFiles / COUNT(*) FROM @CurrentDirectories WHERE Mirror = 0)
          AND Mirror = 0

          SET @CurrentFileName = REPLACE(@CurrentDatabaseFileName, '{FileNumber}', CASE WHEN @NumberOfFiles > 1 AND @NumberOfFiles <= 9 THEN CAST(@CurrentFileNumber AS nvarchar) WHEN @NumberOfFiles >= 10 THEN RIGHT('0' + CAST(@CurrentFileNumber AS nvarchar),2) ELSE '' END)

          SET @CurrentFilePath = @CurrentDirectoryPath + @DirectorySeparator + @CurrentFileName

          INSERT INTO @CurrentFiles ([Type], FilePath, Mirror)
          SELECT 'DISK', @CurrentFilePath, 0

          SET @CurrentDirectoryPath = NULL
          SET @CurrentFileName = NULL
          SET @CurrentFilePath = NULL
        END

        INSERT INTO @CurrentBackupSet (Mirror, VerifyCompleted)
        SELECT 0, 0
      END

      IF EXISTS (SELECT * FROM @CurrentDirectories WHERE Mirror = 1)
      BEGIN
        SET @CurrentFileNumber = 0

        WHILE @CurrentFileNumber < @NumberOfFiles
        BEGIN
          SET @CurrentFileNumber = @CurrentFileNumber + 1

          SELECT @CurrentDirectoryPath = DirectoryPath
          FROM @CurrentDirectories
          WHERE @CurrentFileNumber >= (DirectoryNumber - 1) * (SELECT @NumberOfFiles / COUNT(*) FROM @CurrentDirectories WHERE Mirror = 1) + 1
          AND @CurrentFileNumber <= DirectoryNumber * (SELECT @NumberOfFiles / COUNT(*) FROM @CurrentDirectories WHERE Mirror = 1)
          AND Mirror = 1

          SET @CurrentFileName = REPLACE(@CurrentDatabaseFileName, '{FileNumber}', CASE WHEN @NumberOfFiles > 1 AND @NumberOfFiles <= 9 THEN CAST(@CurrentFileNumber AS nvarchar) WHEN @NumberOfFiles >= 10 THEN RIGHT('0' + CAST(@CurrentFileNumber AS nvarchar),2) ELSE '' END)

          SET @CurrentFilePath = @CurrentDirectoryPath + @DirectorySeparator + @CurrentFileName

          INSERT INTO @CurrentFiles ([Type], FilePath, Mirror)
          SELECT 'DISK', @CurrentFilePath, 1

          SET @CurrentDirectoryPath = NULL
          SET @CurrentFileName = NULL
          SET @CurrentFilePath = NULL
        END

        INSERT INTO @CurrentBackupSet (Mirror, VerifyCompleted)
        SELECT 1, 0
      END

      IF EXISTS (SELECT * FROM @CurrentURLs WHERE Mirror = 0)
      BEGIN
        SET @CurrentFileNumber = 0

        WHILE @CurrentFileNumber < @NumberOfFiles
        BEGIN
          SET @CurrentFileNumber = @CurrentFileNumber + 1

          SELECT @CurrentDirectoryPath = DirectoryPath
          FROM @CurrentURLs
          WHERE Mirror = 0

          SET @CurrentFileName = REPLACE(@CurrentDatabaseFileName, '{FileNumber}', CASE WHEN @NumberOfFiles > 1 AND @NumberOfFiles <= 9 THEN CAST(@CurrentFileNumber AS nvarchar) WHEN @NumberOfFiles >= 10 THEN RIGHT('0' + CAST(@CurrentFileNumber AS nvarchar),2) ELSE '' END)

          SET @CurrentFilePath = @CurrentDirectoryPath + @DirectorySeparator + @CurrentFileName

          INSERT INTO @CurrentFiles ([Type], FilePath, Mirror)
          SELECT 'URL', @CurrentFilePath, 0

          SET @CurrentDirectoryPath = NULL
          SET @CurrentFileName = NULL
          SET @CurrentFilePath = NULL
        END

        INSERT INTO @CurrentBackupSet (Mirror, VerifyCompleted)
        SELECT 0, 0
      END

      IF EXISTS (SELECT * FROM @CurrentURLs WHERE Mirror = 1)
      BEGIN
        SET @CurrentFileNumber = 0

        WHILE @CurrentFileNumber < @NumberOfFiles
        BEGIN
          SET @CurrentFileNumber = @CurrentFileNumber + 1

          SELECT @CurrentDirectoryPath = DirectoryPath
          FROM @CurrentURLs
          WHERE Mirror = 1

          SET @CurrentFileName = REPLACE(@CurrentDatabaseFileName, '{FileNumber}', CASE WHEN @NumberOfFiles > 1 AND @NumberOfFiles <= 9 THEN CAST(@CurrentFileNumber AS nvarchar) WHEN @NumberOfFiles >= 10 THEN RIGHT('0' + CAST(@CurrentFileNumber AS nvarchar),2) ELSE '' END)

          SET @CurrentFilePath = @CurrentDirectoryPath + @DirectorySeparator + @CurrentFileName

          INSERT INTO @CurrentFiles ([Type], FilePath, Mirror)
          SELECT 'URL', @CurrentFilePath, 1

          SET @CurrentDirectoryPath = NULL
          SET @CurrentFileName = NULL
          SET @CurrentFilePath = NULL
        END

        INSERT INTO @CurrentBackupSet (Mirror, VerifyCompleted)
        SELECT 1, 0
      END

      -- Create directory
      IF @HostPlatform = 'Windows'
      AND (@BackupSoftware <> 'DATA_DOMAIN_BOOST' OR @BackupSoftware IS NULL)
      BEGIN
        WHILE (1 = 1)
        BEGIN
          SELECT TOP 1 @CurrentDirectoryID = ID,
                       @CurrentDirectoryPath = DirectoryPath
          FROM @CurrentDirectories
          WHERE CreateCompleted = 0
          ORDER BY ID ASC

          IF @@ROWCOUNT = 0
          BEGIN
            BREAK
          END

          SET @CurrentCommandType01 = 'xp_create_subdir'
          SET @CurrentCommand01 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_create_subdir N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''' IF @RETURNCode <> 0 RAISERROR(''Error creating directory.'', 16, 1)'
          EXECUTE @CurrentCommandOutput01 = [dbo].[CommandExecute] @Command = @CurrentCommand01, @CommandType = @CurrentCommandType01, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput01 = @Error
          IF @CurrentCommandOutput01 <> 0 SET @RETURNCode = @CurrentCommandOutput01

          UPDATE @CurrentDirectories
          SET CreateCompleted = 1,
              CreateOutput = @CurrentCommandOutput01
          WHERE ID = @CurrentDirectoryID

          SET @CurrentDirectoryID = NULL
          SET @CurrentDirectoryPath = NULL

          SET @CurrentCommand01 = NULL

          SET @CurrentCommandOutput01 = NULL

          SET @CurrentCommandType01 = NULL
        END
      END

      IF @CleanupMode = 'BEFORE_BACKUP'
      BEGIN
        INSERT INTO @CurrentCleanupDates (CleanupDate, Mirror)
        SELECT DATEADD(hh,-(@CleanupTime),GETDATE()), 0

        IF NOT EXISTS(SELECT * FROM @CurrentCleanupDates WHERE (Mirror = 0 OR Mirror IS NULL) AND CleanupDate IS NULL)
        BEGIN
          UPDATE @CurrentDirectories
          SET CleanupDate = (SELECT MIN(CleanupDate)
                             FROM @CurrentCleanupDates
                             WHERE (Mirror = 0 OR Mirror IS NULL)),
              CleanupMode = 'BEFORE_BACKUP'
          WHERE Mirror = 0
        END
      END

      IF @MirrorCleanupMode = 'BEFORE_BACKUP'
      BEGIN
        INSERT INTO @CurrentCleanupDates (CleanupDate, Mirror)
        SELECT DATEADD(hh,-(@MirrorCleanupTime),GETDATE()), 1

        IF NOT EXISTS(SELECT * FROM @CurrentCleanupDates WHERE (Mirror = 1 OR Mirror IS NULL) AND CleanupDate IS NULL)
        BEGIN
          UPDATE @CurrentDirectories
          SET CleanupDate = (SELECT MIN(CleanupDate)
                             FROM @CurrentCleanupDates
                             WHERE (Mirror = 1 OR Mirror IS NULL)),
              CleanupMode = 'BEFORE_BACKUP'
          WHERE Mirror = 1
        END
      END

      -- Delete old backup files, before backup
      IF NOT EXISTS (SELECT * FROM @CurrentDirectories WHERE CreateOutput <> 0 OR CreateOutput IS NULL)
      AND @HostPlatform = 'Windows'
      AND (@BackupSoftware <> 'DATA_DOMAIN_BOOST' OR @BackupSoftware IS NULL)
      AND @CurrentBackupType = @BackupType
      BEGIN
        WHILE (1 = 1)
        BEGIN
          SELECT TOP 1 @CurrentDirectoryID = ID,
                       @CurrentDirectoryPath = DirectoryPath,
                       @CurrentCleanupDate = CleanupDate
          FROM @CurrentDirectories
          WHERE CleanupDate IS NOT NULL
          AND CleanupMode = 'BEFORE_BACKUP'
          AND CleanupCompleted = 0
          ORDER BY ID ASC

          IF @@ROWCOUNT = 0
          BEGIN
            BREAK
          END

          IF @BackupSoftware IS NULL
          BEGIN
            SET @CurrentCommandType02 = 'xp_delete_file'

            SET @CurrentCommand02 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_delete_file 0, N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''', ''' + @CurrentFileExtension + ''', ''' + CONVERT(nvarchar(19),@CurrentCleanupDate,126) + ''' IF @RETURNCode <> 0 RAISERROR(''Error deleting files.'', 16, 1)'
          END

          IF @BackupSoftware = 'LITESPEED'
          BEGIN
            SET @CurrentCommandType02 = 'xp_slssqlmaint'

            SET @CurrentCommand02 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_slssqlmaint N''-MAINTDEL -DELFOLDER "' + REPLACE(@CurrentDirectoryPath,'''','''''') + '" -DELEXTENSION "' + @CurrentFileExtension + '" -DELUNIT "' + CAST(DATEDIFF(mi,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + '" -DELUNITTYPE "minutes" -DELUSEAGE'' IF @RETURNCode <> 0 RAISERROR(''Error deleting LiteSpeed backup files.'', 16, 1)'
          END

          IF @BackupSoftware = 'SQLBACKUP'
          BEGIN
            SET @CurrentCommandType02 = 'sqbutility'

            SET @CurrentCommand02 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.sqbutility 1032, N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''', N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''', ''' + CASE WHEN @CurrentBackupType = 'FULL' THEN 'D' WHEN @CurrentBackupType = 'DIFF' THEN 'I' WHEN @CurrentBackupType = 'LOG' THEN 'L' END + ''', ''' + CAST(DATEDIFF(hh,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + 'h'', ' + ISNULL('''' + REPLACE(@EncryptionKey,'''','''''') + '''','NULL') + ' IF @RETURNCode <> 0 RAISERROR(''Error deleting SQLBackup backup files.'', 16, 1)'
          END

          IF @BackupSoftware = 'SQLSAFE'
          BEGIN
            SET @CurrentCommandType02 = 'xp_ss_delete'

            SET @CurrentCommand02 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_ss_delete @filename = N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + '\*.' + @CurrentFileExtension + ''', @age = ''' + CAST(DATEDIFF(mi,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + 'Minutes'' IF @RETURNCode <> 0 RAISERROR(''Error deleting SQLsafe backup files.'', 16, 1)'
          END

          EXECUTE @CurrentCommandOutput02 = [dbo].[CommandExecute] @Command = @CurrentCommand02, @CommandType = @CurrentCommandType02, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput02 = @Error
          IF @CurrentCommandOutput02 <> 0 SET @RETURNCode = @CurrentCommandOutput02

          UPDATE @CurrentDirectories
          SET CleanupCompleted = 1,
              CleanupOutput = @CurrentCommandOutput02
          WHERE ID = @CurrentDirectoryID

          SET @CurrentDirectoryID = NULL
          SET @CurrentDirectoryPath = NULL
          SET @CurrentCleanupDate = NULL

          SET @CurrentCommand02 = NULL

          SET @CurrentCommandOutput02 = NULL

          SET @CurrentCommandType02 = NULL
        END
      END

      -- Perform a backup
      IF NOT EXISTS (SELECT * FROM @CurrentDirectories WHERE CreateOutput <> 0 OR CreateOutput IS NULL) OR @HostPlatform = 'Linux'
      BEGIN
        IF @BackupSoftware IS NULL
        BEGIN
          SELECT @CurrentCommandType03 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'BACKUP_DATABASE'
          WHEN @CurrentBackupType = 'LOG' THEN 'BACKUP_LOG'
          END

          SELECT @CurrentCommand03 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'BACKUP DATABASE ' + QUOTENAME(@CurrentDatabaseName)
          WHEN @CurrentBackupType = 'LOG' THEN 'BACKUP LOG ' + QUOTENAME(@CurrentDatabaseName)
          END

          IF @ReadWriteFileGroups = 'Y' AND @CurrentDatabaseName <> 'master' SET @CurrentCommand03 = @CurrentCommand03 + ' READ_WRITE_FILEGROUPS'

          SET @CurrentCommand03 = @CurrentCommand03 + ' TO'

          SELECT @CurrentCommand03 = @CurrentCommand03 + ' ' + [Type] + ' = N''' + REPLACE(FilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY FilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          WHERE Mirror = 0
          ORDER BY FilePath ASC

          IF EXISTS(SELECT * FROM @CurrentFiles WHERE Mirror = 1)
          BEGIN
            SET @CurrentCommand03 = @CurrentCommand03 + ' MIRROR TO'

            SELECT @CurrentCommand03 = @CurrentCommand03 + ' ' + [Type] + ' = N''' + REPLACE(FilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY FilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
            FROM @CurrentFiles
            WHERE Mirror = 1
            ORDER BY FilePath ASC
          END

          SET @CurrentCommand03 = @CurrentCommand03 + ' WITH '
          IF @CheckSum = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand03 = @CurrentCommand03 + 'NO_CHECKSUM'

          IF @Version >= 10
          BEGIN
            SET @CurrentCommand03 = @CurrentCommand03 + CASE WHEN @Compress = 'Y' AND (@CurrentIsEncrypted = 0 OR (@CurrentIsEncrypted = 1 AND @Version >= 13 AND @MaxTransferSize > 65536)) THEN ', COMPRESSION' ELSE ', NO_COMPRESSION' END
          END

          IF @CurrentBackupType = 'DIFF' SET @CurrentCommand03 = @CurrentCommand03 + ', DIFFERENTIAL'

          IF EXISTS(SELECT * FROM @CurrentFiles WHERE Mirror = 1)
          BEGIN
            SET @CurrentCommand03 = @CurrentCommand03 + ', FORMAT'
          END

          IF @CopyOnly = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ', COPY_ONLY'
          IF @NoRecovery = 'Y' AND @CurrentBackupType = 'LOG' SET @CurrentCommand03 = @CurrentCommand03 + ', NORECOVERY'
          IF @Init = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ', INIT'
          IF @BlockSize IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', BLOCKSIZE = ' + CAST(@BlockSize AS nvarchar)
          IF @BufferCount IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', BUFFERCOUNT = ' + CAST(@BufferCount AS nvarchar)
          IF @MaxTransferSize IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', MAXTRANSFERSIZE = ' + CAST(@MaxTransferSize AS nvarchar)
          IF @Description IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', DESCRIPTION = N''' + REPLACE(@Description,'''','''''') + ''''
          IF @Encrypt = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ', ENCRYPTION (ALGORITHM = ' + UPPER(@EncryptionAlgorithm) + ', '
          IF @Encrypt = 'Y' AND @ServerCertificate IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + 'SERVER CERTIFICATE = ' + QUOTENAME(@ServerCertificate)
          IF @Encrypt = 'Y' AND @ServerAsymmetricKey IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + 'SERVER ASYMMETRIC KEY = ' + QUOTENAME(@ServerAsymmetricKey)
          IF @Encrypt = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ')'
          IF @URL IS NOT NULL AND @Credential IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', CREDENTIAL = N''' + REPLACE(@Credential,'''','''''') + ''''
        END

        IF @BackupSoftware = 'LITESPEED'
        BEGIN
          SELECT @CurrentCommandType03 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'xp_backup_database'
          WHEN @CurrentBackupType = 'LOG' THEN 'xp_backup_log'
          END

          SELECT @CurrentCommand03 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_backup_database @database = N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''''
          WHEN @CurrentBackupType = 'LOG' THEN 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_backup_log @database = N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''''
          END

          SELECT @CurrentCommand03 = @CurrentCommand03 + ', @filename = N''' + REPLACE(FilePath,'''','''''') + ''''
          FROM @CurrentFiles
          WHERE Mirror = 0
          ORDER BY FilePath ASC

          IF EXISTS(SELECT * FROM @CurrentFiles WHERE Mirror = 1)
          BEGIN
            SELECT @CurrentCommand03 = @CurrentCommand03 + ', @mirror = N''' + REPLACE(FilePath,'''','''''') + ''''
            FROM @CurrentFiles
            WHERE Mirror = 1
            ORDER BY FilePath ASC
          END

          SET @CurrentCommand03 = @CurrentCommand03 + ', @with = '''
          IF @CheckSum = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand03 = @CurrentCommand03 + 'NO_CHECKSUM'
          IF @CurrentBackupType = 'DIFF' SET @CurrentCommand03 = @CurrentCommand03 + ', DIFFERENTIAL'
          IF @CopyOnly = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ', COPY_ONLY'
          IF @NoRecovery = 'Y' AND @CurrentBackupType = 'LOG' SET @CurrentCommand03 = @CurrentCommand03 + ', NORECOVERY'
          IF @BlockSize IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', BLOCKSIZE = ' + CAST(@BlockSize AS nvarchar)
          SET @CurrentCommand03 = @CurrentCommand03 + ''''
          IF @ReadWriteFileGroups = 'Y' AND @CurrentDatabaseName <> 'master' SET @CurrentCommand03 = @CurrentCommand03 + ', @read_write_filegroups = 1'
          IF @CompressionLevel IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @compressionlevel = ' + CAST(@CompressionLevel AS nvarchar)
          IF @AdaptiveCompression IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @adaptivecompression = ''' + CASE WHEN @AdaptiveCompression = 'SIZE' THEN 'Size' WHEN @AdaptiveCompression = 'SPEED' THEN 'Speed' END + ''''
          IF @BufferCount IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @buffercount = ' + CAST(@BufferCount AS nvarchar)
          IF @MaxTransferSize IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @maxtransfersize = ' + CAST(@MaxTransferSize AS nvarchar)
          IF @Threads IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @threads = ' + CAST(@Threads AS nvarchar)
          IF @Init = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ', @init = 1'
          IF @Throttle IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @throttle = ' + CAST(@Throttle AS nvarchar)
          IF @Description IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @desc = N''' + REPLACE(@Description,'''','''''') + ''''

          IF @EncryptionAlgorithm IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @cryptlevel = ' + CASE
          WHEN @EncryptionAlgorithm = 'RC2_40' THEN '0'
          WHEN @EncryptionAlgorithm = 'RC2_56' THEN '1'
          WHEN @EncryptionAlgorithm = 'RC2_112' THEN '2'
          WHEN @EncryptionAlgorithm = 'RC2_128' THEN '3'
          WHEN @EncryptionAlgorithm = 'TRIPLE_DES_3KEY' THEN '4'
          WHEN @EncryptionAlgorithm = 'RC4_128' THEN '5'
          WHEN @EncryptionAlgorithm = 'AES_128' THEN '6'
          WHEN @EncryptionAlgorithm = 'AES_192' THEN '7'
          WHEN @EncryptionAlgorithm = 'AES_256' THEN '8'
          END

          IF @EncryptionKey IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @encryptionkey = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''
          SET @CurrentCommand03 = @CurrentCommand03 + ' IF @RETURNCode <> 0 RAISERROR(''Error performing LiteSpeed backup.'', 16, 1)'
        END

        IF @BackupSoftware = 'SQLBACKUP'
        BEGIN
          SET @CurrentCommandType03 = 'sqlbackup'

          SELECT @CurrentCommand03 = CASE
          WHEN @CurrentBackupType IN('DIFF','FULL') THEN 'BACKUP DATABASE ' + QUOTENAME(@CurrentDatabaseName)
          WHEN @CurrentBackupType = 'LOG' THEN 'BACKUP LOG ' + QUOTENAME(@CurrentDatabaseName)
          END

          IF @ReadWriteFileGroups = 'Y' AND @CurrentDatabaseName <> 'master' SET @CurrentCommand03 = @CurrentCommand03 + ' READ_WRITE_FILEGROUPS'

          SET @CurrentCommand03 = @CurrentCommand03 + ' TO'

          SELECT @CurrentCommand03 = @CurrentCommand03 + ' DISK = N''' + REPLACE(FilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY FilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
          FROM @CurrentFiles
          WHERE Mirror = 0
          ORDER BY FilePath ASC

          SET @CurrentCommand03 = @CurrentCommand03 + ' WITH '

          IF EXISTS(SELECT * FROM @CurrentFiles WHERE Mirror = 1)
          BEGIN
            SET @CurrentCommand03 = @CurrentCommand03 + ' MIRRORFILE' + ' = N''' + REPLACE((SELECT FilePath FROM @CurrentFiles WHERE Mirror = 1),'''','''''') + ''', '
          END

          IF @CheckSum = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + 'CHECKSUM'
          IF @CheckSum = 'N' SET @CurrentCommand03 = @CurrentCommand03 + 'NO_CHECKSUM'
          IF @CurrentBackupType = 'DIFF' SET @CurrentCommand03 = @CurrentCommand03 + ', DIFFERENTIAL'
          IF @CopyOnly = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ', COPY_ONLY'
          IF @NoRecovery = 'Y' AND @CurrentBackupType = 'LOG' SET @CurrentCommand03 = @CurrentCommand03 + ', NORECOVERY'
          IF @Init = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ', INIT'
          IF @CompressionLevel IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', COMPRESSION = ' + CAST(@CompressionLevel AS nvarchar)
          IF @Threads IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', THREADCOUNT = ' + CAST(@Threads AS nvarchar)
          IF @MaxTransferSize IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', MAXTRANSFERSIZE = ' + CAST(@MaxTransferSize AS nvarchar)
          IF @Description IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', DESCRIPTION = N''' + REPLACE(@Description,'''','''''') + ''''

          IF @EncryptionAlgorithm IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', KEYSIZE = ' + CASE
          WHEN @EncryptionAlgorithm = 'AES_128' THEN '128'
          WHEN @EncryptionAlgorithm = 'AES_256' THEN '256'
          END

          IF @EncryptionKey IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', PASSWORD = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''
          SET @CurrentCommand03 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.sqlbackup N''-SQL "' + REPLACE(@CurrentCommand03,'''','''''') + '"''' + ' IF @RETURNCode <> 0 RAISERROR(''Error performing SQLBackup backup.'', 16, 1)'
        END

        IF @BackupSoftware = 'SQLSAFE'
        BEGIN
          SET @CurrentCommandType03 = 'xp_ss_backup'

          SET @CurrentCommand03 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_ss_backup @database = N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''''

          SELECT @CurrentCommand03 = @CurrentCommand03 + ', ' + CASE WHEN ROW_NUMBER() OVER (ORDER BY FilePath ASC) = 1 THEN '@filename' ELSE '@backupfile' END + ' = N''' + REPLACE(FilePath,'''','''''') + ''''
          FROM @CurrentFiles
          WHERE Mirror = 0
          ORDER BY FilePath ASC

          SELECT @CurrentCommand03 = @CurrentCommand03 + ', @mirrorfile = N''' + REPLACE(FilePath,'''','''''') + ''''
          FROM @CurrentFiles
          WHERE Mirror = 1
          ORDER BY FilePath ASC

          SET @CurrentCommand03 = @CurrentCommand03 + ', @backuptype = ' + CASE WHEN @CurrentBackupType = 'FULL' THEN '''Full''' WHEN @CurrentBackupType = 'DIFF' THEN '''Differential''' WHEN @CurrentBackupType = 'LOG' THEN '''Log''' END
          IF @ReadWriteFileGroups = 'Y' AND @CurrentDatabaseName <> 'master' SET @CurrentCommand03 = @CurrentCommand03 + ', @readwritefilegroups = 1'
          SET @CurrentCommand03 = @CurrentCommand03 + ', @checksum = ' + CASE WHEN @CheckSum = 'Y' THEN '1' WHEN @CheckSum = 'N' THEN '0' END
          SET @CurrentCommand03 = @CurrentCommand03 + ', @copyonly = ' + CASE WHEN @CopyOnly = 'Y' THEN '1' WHEN @CopyOnly = 'N' THEN '0' END
          IF @CompressionLevel IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @compressionlevel = ' + CAST(@CompressionLevel AS nvarchar)
          IF @Threads IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @threads = ' + CAST(@Threads AS nvarchar)
          IF @Init = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ', @overwrite = 1'
          IF @Description IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @desc = N''' + REPLACE(@Description,'''','''''') + ''''

          IF @EncryptionAlgorithm IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @encryptiontype = N''' + CASE
          WHEN @EncryptionAlgorithm = 'AES_128' THEN 'AES128'
          WHEN @EncryptionAlgorithm = 'AES_256' THEN 'AES256'
          END + ''''

          IF @EncryptionKey IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ', @encryptedbackuppassword = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''
          SET @CurrentCommand03 = @CurrentCommand03 + ' IF @RETURNCode <> 0 RAISERROR(''Error performing SQLsafe backup.'', 16, 1)'
        END

        IF @BackupSoftware = 'DATA_DOMAIN_BOOST'
        BEGIN
          SET @CurrentCommandType03 = 'emc_run_backup'

          SET @CurrentCommand03 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.emc_run_backup '''

          SET @CurrentCommand03 = @CurrentCommand03 + ' -c ' + CASE WHEN @CurrentAvailabilityGroup IS NOT NULL THEN @Cluster ELSE CAST(SERVERPROPERTY('MachineName') AS nvarchar) END

          SET @CurrentCommand03 = @CurrentCommand03 + ' -l ' + CASE
          WHEN @CurrentBackupType = 'FULL' THEN 'full'
          WHEN @CurrentBackupType = 'DIFF' THEN 'diff'
          WHEN @CurrentBackupType = 'LOG' THEN 'incr'
          END

          IF @NoRecovery = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ' -H'

          IF @CleanupTime IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ' -y +' + CAST(@CleanupTime/24 + CASE WHEN @CleanupTime%24 > 0 THEN 1 ELSE 0 END AS nvarchar) + 'd'

          IF @CheckSum = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ' -k'

          SET @CurrentCommand03 = @CurrentCommand03 + ' -S ' + CAST(@NumberOfFiles AS nvarchar)

          IF @Description IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ' -b "' + REPLACE(@Description,'''','''''') + '"'

          IF @BufferCount IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ' -O "BUFFERCOUNT=' + CAST(@BufferCount AS nvarchar) + '"'

          IF @ReadWriteFileGroups = 'Y' AND @CurrentDatabaseName <> 'master' SET @CurrentCommand03 = @CurrentCommand03 + ' -O "READ_WRITE_FILEGROUPS"'

          SET @CurrentCommand03 = @CurrentCommand03 + ' -a "NSR_DFA_SI=TRUE"'
          SET @CurrentCommand03 = @CurrentCommand03 + ' -a "NSR_DFA_SI_USE_DD=TRUE"'
          IF @DataDomainBoostHost IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ' -a "NSR_DFA_SI_DD_HOST=' + REPLACE(@DataDomainBoostHost,'''','''''') + '"'
          IF @DataDomainBoostUser IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ' -a "NSR_DFA_SI_DD_USER=' + REPLACE(@DataDomainBoostUser,'''','''''') + '"'
          IF @DataDomainBoostDevicePath IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ' -a "NSR_DFA_SI_DEVICE_PATH=' + REPLACE(@DataDomainBoostDevicePath,'''','''''') + '"'
          IF @DataDomainBoostLockboxPath IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ' -a "NSR_DFA_SI_DD_LOCKBOX_PATH=' + REPLACE(@DataDomainBoostLockboxPath,'''','''''') + '"'
          SET @CurrentCommand03 = @CurrentCommand03 + ' -a "NSR_SKIP_NON_BACKUPABLE_STATE_DB=TRUE"'
          IF @CopyOnly = 'Y' SET @CurrentCommand03 = @CurrentCommand03 + ' -a "NSR_COPY_ONLY=TRUE"'

          IF SERVERPROPERTY('InstanceName') IS NULL SET @CurrentCommand03 = @CurrentCommand03 + ' "MSSQL' + ':' + REPLACE(REPLACE(@CurrentDatabaseName,'''',''''''),'.','\.') + '"'
          IF SERVERPROPERTY('InstanceName') IS NOT NULL SET @CurrentCommand03 = @CurrentCommand03 + ' "MSSQL$' + CAST(SERVERPROPERTY('InstanceName') AS nvarchar) + ':' + REPLACE(REPLACE(@CurrentDatabaseName,'''',''''''),'.','\.') + '"'

          SET @CurrentCommand03 = @CurrentCommand03 + ''''

          SET @CurrentCommand03 = @CurrentCommand03 + ' IF @RETURNCode <> 0 RAISERROR(''Error performing Data Domain Boost backup.'', 16, 1)'
        END

        EXECUTE @CurrentCommandOutput03 = [dbo].[CommandExecute] @Command = @CurrentCommand03, @CommandType = @CurrentCommandType03, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
        SET @Error = @@ERROR
        IF @Error <> 0 SET @CurrentCommandOutput03 = @Error
        IF @CurrentCommandOutput03 <> 0 SET @RETURNCode = @CurrentCommandOutput03
      END

      -- Verify the backup
      IF @CurrentCommandOutput03 = 0 AND @Verify = 'Y'
      BEGIN
        WHILE (1 = 1)
        BEGIN
          SELECT TOP 1 @CurrentBackupSetID = ID,
                       @CurrentIsMirror = Mirror
          FROM @CurrentBackupSet
          WHERE VerifyCompleted = 0
          ORDER BY ID ASC

          IF @@ROWCOUNT = 0
          BEGIN
            BREAK
          END

          IF @BackupSoftware IS NULL
          BEGIN
            SET @CurrentCommandType04 = 'RESTORE_VERIFYONLY'

            SET @CurrentCommand04 = 'RESTORE VERIFYONLY FROM'

            SELECT @CurrentCommand04 = @CurrentCommand04 + ' ' + [Type] + ' = N''' + REPLACE(FilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY FilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
            FROM @CurrentFiles
            WHERE Mirror = @CurrentIsMirror
            ORDER BY FilePath ASC

            SET @CurrentCommand04 = @CurrentCommand04 + ' WITH '
            IF @CheckSum = 'Y' SET @CurrentCommand04 = @CurrentCommand04 + 'CHECKSUM'
            IF @CheckSum = 'N' SET @CurrentCommand04 = @CurrentCommand04 + 'NO_CHECKSUM'
            IF @URL IS NOT NULL AND @Credential IS NOT NULL SET @CurrentCommand04 = @CurrentCommand04 + ', CREDENTIAL = N''' + REPLACE(@Credential,'''','''''') + ''''
          END

          IF @BackupSoftware = 'LITESPEED'
          BEGIN
            SET @CurrentCommandType04 = 'xp_restore_verifyonly'

            SET @CurrentCommand04 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_restore_verifyonly'

            SELECT @CurrentCommand04 = @CurrentCommand04 + ' @filename = N''' + REPLACE(FilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY FilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
            FROM @CurrentFiles
            WHERE Mirror = @CurrentIsMirror
            ORDER BY FilePath ASC

            SET @CurrentCommand04 = @CurrentCommand04 + ', @with = '''
            IF @CheckSum = 'Y' SET @CurrentCommand04 = @CurrentCommand04 + 'CHECKSUM'
            IF @CheckSum = 'N' SET @CurrentCommand04 = @CurrentCommand04 + 'NO_CHECKSUM'
            SET @CurrentCommand04 = @CurrentCommand04 + ''''
            IF @EncryptionKey IS NOT NULL SET @CurrentCommand04 = @CurrentCommand04 + ', @encryptionkey = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''

            SET @CurrentCommand04 = @CurrentCommand04 + ' IF @RETURNCode <> 0 RAISERROR(''Error verifying LiteSpeed backup.'', 16, 1)'
          END

          IF @BackupSoftware = 'SQLBACKUP'
          BEGIN
            SET @CurrentCommandType04 = 'sqlbackup'

            SET @CurrentCommand04 = 'RESTORE VERIFYONLY FROM'

            SELECT @CurrentCommand04 = @CurrentCommand04 + ' DISK = N''' + REPLACE(FilePath,'''','''''') + '''' + CASE WHEN ROW_NUMBER() OVER (ORDER BY FilePath ASC) <> @NumberOfFiles THEN ',' ELSE '' END
            FROM @CurrentFiles
            WHERE Mirror = @CurrentIsMirror
            ORDER BY FilePath ASC

            SET @CurrentCommand04 = @CurrentCommand04 + ' WITH '
            IF @CheckSum = 'Y' SET @CurrentCommand04 = @CurrentCommand04 + 'CHECKSUM'
            IF @CheckSum = 'N' SET @CurrentCommand04 = @CurrentCommand04 + 'NO_CHECKSUM'
            IF @EncryptionKey IS NOT NULL SET @CurrentCommand04 = @CurrentCommand04 + ', PASSWORD = N''' + REPLACE(@EncryptionKey,'''','''''') + ''''

            SET @CurrentCommand04 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.sqlbackup N''-SQL "' + REPLACE(@CurrentCommand04,'''','''''') + '"''' + ' IF @RETURNCode <> 0 RAISERROR(''Error verifying SQLBackup backup.'', 16, 1)'
          END

          IF @BackupSoftware = 'SQLSAFE'
          BEGIN
            SET @CurrentCommandType04 = 'xp_ss_verify'

            SET @CurrentCommand04 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_ss_verify @database = N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''''

            SELECT @CurrentCommand04 = @CurrentCommand04 + ', ' + CASE WHEN ROW_NUMBER() OVER (ORDER BY FilePath ASC) = 1 THEN '@filename' ELSE '@backupfile' END + ' = N''' + REPLACE(FilePath,'''','''''') + ''''
            FROM @CurrentFiles
            WHERE Mirror = @CurrentIsMirror
            ORDER BY FilePath ASC

            SET @CurrentCommand04 = @CurrentCommand04 + ' IF @RETURNCode <> 0 RAISERROR(''Error verifying SQLsafe backup.'', 16, 1)'
          END

          EXECUTE @CurrentCommandOutput04 = [dbo].[CommandExecute] @Command = @CurrentCommand04, @CommandType = @CurrentCommandType04, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput04 = @Error
          IF @CurrentCommandOutput04 <> 0 SET @RETURNCode = @CurrentCommandOutput04

          UPDATE @CurrentBackupSet
          SET VerifyCompleted = 1,
              VerifyOutput = @CurrentCommandOutput04
          WHERE ID = @CurrentBackupSetID

          SET @CurrentBackupSetID = NULL
          SET @CurrentIsMirror = NULL

          SET @CurrentCommand04 = NULL

          SET @CurrentCommandOutput04 = NULL

          SET @CurrentCommandType04 = NULL
        END
      END

      IF @CleanupMode = 'AFTER_BACKUP'
      BEGIN
        INSERT INTO @CurrentCleanupDates (CleanupDate, Mirror)
        SELECT DATEADD(hh,-(@CleanupTime),GETDATE()), 0

        IF NOT EXISTS(SELECT * FROM @CurrentCleanupDates WHERE (Mirror = 0 OR Mirror IS NULL) AND CleanupDate IS NULL)
        BEGIN
          UPDATE @CurrentDirectories
          SET CleanupDate = (SELECT MIN(CleanupDate)
                             FROM @CurrentCleanupDates
                             WHERE (Mirror = 0 OR Mirror IS NULL)),
              CleanupMode = 'AFTER_BACKUP'
          WHERE Mirror = 0
        END
      END

      IF @MirrorCleanupMode = 'AFTER_BACKUP'
      BEGIN
        INSERT INTO @CurrentCleanupDates (CleanupDate, Mirror)
        SELECT DATEADD(hh,-(@MirrorCleanupTime),GETDATE()), 1

        IF NOT EXISTS(SELECT * FROM @CurrentCleanupDates WHERE (Mirror = 1 OR Mirror IS NULL) AND CleanupDate IS NULL)
        BEGIN
          UPDATE @CurrentDirectories
          SET CleanupDate = (SELECT MIN(CleanupDate)
                             FROM @CurrentCleanupDates
                             WHERE (Mirror = 1 OR Mirror IS NULL)),
              CleanupMode = 'AFTER_BACKUP'
          WHERE Mirror = 1
        END
      END

      -- Delete old backup files, after backup
      IF ((@CurrentCommandOutput03 = 0 AND @Verify = 'N')
      OR (@CurrentCommandOutput03 = 0 AND @Verify = 'Y' AND NOT EXISTS (SELECT * FROM @CurrentBackupSet WHERE VerifyOutput <> 0 OR VerifyOutput IS NULL)))
      AND @HostPlatform = 'Windows'
      AND (@BackupSoftware <> 'DATA_DOMAIN_BOOST' OR @BackupSoftware IS NULL)
      AND @CurrentBackupType = @BackupType
      BEGIN
        WHILE (1 = 1)
        BEGIN
          SELECT TOP 1 @CurrentDirectoryID = ID,
                       @CurrentDirectoryPath = DirectoryPath,
                       @CurrentCleanupDate = CleanupDate
          FROM @CurrentDirectories
          WHERE CleanupDate IS NOT NULL
          AND CleanupMode = 'AFTER_BACKUP'
          AND CleanupCompleted = 0
          ORDER BY ID ASC

          IF @@ROWCOUNT = 0
          BEGIN
            BREAK
          END

          IF @BackupSoftware IS NULL
          BEGIN
            SET @CurrentCommandType05 = 'xp_delete_file'

            SET @CurrentCommand05 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_delete_file 0, N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''', ''' + @CurrentFileExtension + ''', ''' + CONVERT(nvarchar(19),@CurrentCleanupDate,126) + ''' IF @RETURNCode <> 0 RAISERROR(''Error deleting files.'', 16, 1)'
          END

          IF @BackupSoftware = 'LITESPEED'
          BEGIN
            SET @CurrentCommandType05 = 'xp_slssqlmaint'

            SET @CurrentCommand05 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_slssqlmaint N''-MAINTDEL -DELFOLDER "' + REPLACE(@CurrentDirectoryPath,'''','''''') + '" -DELEXTENSION "' + @CurrentFileExtension + '" -DELUNIT "' + CAST(DATEDIFF(mi,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + '" -DELUNITTYPE "minutes" -DELUSEAGE'' IF @RETURNCode <> 0 RAISERROR(''Error deleting LiteSpeed backup files.'', 16, 1)'
          END

          IF @BackupSoftware = 'SQLBACKUP'
          BEGIN
            SET @CurrentCommandType05 = 'sqbutility'

            SET @CurrentCommand05 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.sqbutility 1032, N''' + REPLACE(@CurrentDatabaseName,'''','''''') + ''', N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + ''', ''' + CASE WHEN @CurrentBackupType = 'FULL' THEN 'D' WHEN @CurrentBackupType = 'DIFF' THEN 'I' WHEN @CurrentBackupType = 'LOG' THEN 'L' END + ''', ''' + CAST(DATEDIFF(hh,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + 'h'', ' + ISNULL('''' + REPLACE(@EncryptionKey,'''','''''') + '''','NULL') + ' IF @RETURNCode <> 0 RAISERROR(''Error deleting SQLBackup backup files.'', 16, 1)'
          END

          IF @BackupSoftware = 'SQLSAFE'
          BEGIN
            SET @CurrentCommandType05 = 'xp_ss_delete'

            SET @CurrentCommand05 = 'DECLARE @RETURNCode int EXECUTE @RETURNCode = [master].dbo.xp_ss_delete @filename = N''' + REPLACE(@CurrentDirectoryPath,'''','''''') + '\*.' + @CurrentFileExtension + ''', @age = ''' + CAST(DATEDIFF(mi,@CurrentCleanupDate,GETDATE()) + 1 AS nvarchar) + 'Minutes'' IF @RETURNCode <> 0 RAISERROR(''Error deleting SQLsafe backup files.'', 16, 1)'
          END

          EXECUTE @CurrentCommandOutput05 = [dbo].[CommandExecute] @Command = @CurrentCommand05, @CommandType = @CurrentCommandType05, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput05 = @Error
          IF @CurrentCommandOutput05 <> 0 SET @RETURNCode = @CurrentCommandOutput05

          UPDATE @CurrentDirectories
          SET CleanupCompleted = 1,
              CleanupOutput = @CurrentCommandOutput05
          WHERE ID = @CurrentDirectoryID

          SET @CurrentDirectoryID = NULL
          SET @CurrentDirectoryPath = NULL
          SET @CurrentCleanupDate = NULL

          SET @CurrentCommand05 = NULL

          SET @CurrentCommandOutput05 = NULL

          SET @CurrentCommandType05 = NULL
        END
      END
    END

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'SUSPECT'
    BEGIN
      SET @ErrorMessage = 'The database ' + QUOTENAME(@CurrentDatabaseName) + ' is in a SUSPECT state.' + CHAR(13) + CHAR(10) + ' '
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
      SET @Error = @@ERROR
    END

    -- Update that the database is completed
    IF @DatabasesInParallel = 'Y'
    BEGIN
      UPDATE dbo.QueueDatabase
      SET DatabaseENDTime = GETDATE()
      WHERE QueueID = @QueueID
      AND DatabaseName = @CurrentDatabaseName
    END
    ELSE
    BEGIN
      UPDATE @tmpDatabases
      SET Completed = 1
      WHERE Selected = 1
      AND Completed = 0
      AND ID = @CurrentDBID
    END

    -- Clear variables
    SET @CurrentDBID = NULL
    SET @CurrentDatabaseID = NULL
    SET @CurrentDatabaseName = NULL
    SET @CurrentBackupType = NULL
    SET @CurrentFileExtension = NULL
    SET @CurrentFileNumber = NULL
    SET @CurrentDifferentialBaseLSN = NULL
    SET @CurrentDifferentialBaseIsSnapshot = NULL
    SET @CurrentLogLSN = NULL
    SET @CurrentLatestBackup = NULL
    SET @CurrentDatabaseNameFS = NULL
    SET @CurrentDirectoryStructure = NULL
    SET @CurrentDatabaseFileName = NULL
    SET @CurrentMaxFilePathLength = NULL
    SET @CurrentDate = NULL
    SET @CurrentCleanupDate = NULL
    SET @CurrentIsDatabaseAccessible = NULL
    SET @CurrentAvailabilityGroup = NULL
    SET @CurrentAvailabilityGroupRole = NULL
    SET @CurrentAvailabilityGroupBackupPreference = NULL
    SET @CurrentIsPreferredBackupReplica = NULL
    SET @CurrentDatabaseMirroringRole = NULL
    SET @CurrentLogShippingRole = NULL
    SET @CurrentIsEncrypted = NULL
    SET @CurrentIsReadOnly = NULL
    SET @CurrentLastLogBackup = NULL
    SET @CurrentLogSizeSinceLastLogBackup = NULL
    SET @CurrentAllocatedExtentPageCount = NULL
    SET @CurrentModifiedExtentPageCount = NULL

    SET @CurrentCommand03 = NULL
    SET @CurrentCommand06 = NULL
    SET @CurrentCommand07 = NULL

    SET @CurrentCommandOutput03 = NULL

    SET @CurrentCommandType03 = NULL

    DELETE FROM @CurrentDirectories
    DELETE FROM @CurrentURLs
    DELETE FROM @CurrentFiles
    DELETE FROM @CurrentCleanupDates
    DELETE FROM @CurrentBackupSet

  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  Logging:
  SET @ENDMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
  SET @ENDMessage = REPLACE(@ENDMessage,'%','%%')
  RAISERROR(@ENDMessage,10,1) WITH NOWAIT

  IF @RETURNCode <> 0
  BEGIN
    RETURN @RETURNCode
  END

  ----------------------------------------------------------------------------------------------------

END













GO
/****** Object:  StoredProcedure [dbo].[DatabaseIntegrityCheck]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DatabaseIntegrityCheck]

@Databases nvarchar(max) = NULL,
@CheckCommands nvarchar(max) = 'CHECKDB',
@PhysicalOnly nvarchar(max) = 'N',
@NoIndex nvarchar(max) = 'N',
@ExtENDedLogicalChecks nvarchar(max) = 'N',
@TabLock nvarchar(max) = 'N',
@FileGroups nvarchar(max) = NULL,
@Objects nvarchar(max) = NULL,
@MaxDOP int = NULL,
@AvailabilityGroups nvarchar(max) = NULL,
@AvailabilityGroupReplicas nvarchar(max) = 'ALL',
@Updateability nvarchar(max) = 'ALL',
@TimeLimit int = NULL,
@LockTimeout int = NULL,
@LockMessageSeverity int = 16,
@DatabaseOrder nvarchar(max) = NULL,
@DatabasesInParallel nvarchar(max) = 'N',
@LogToTable nvarchar(max) = 'N',
@Execute nvarchar(max) = 'Y'

AS

BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ================================================================================================================================================================
	--
	-- ================================================================================================================================================================

  ----------------------------------------------------------------------------------------------------
  --// Source:  https://ola.hallengren.com                                                        //--
  --// License: https://ola.hallengren.com/license.html                                           //--
  --// GitHub:  https://github.com/olahallengren/sql-server-maintenance-solution                  //--
  --// Version: 2018-07-16 18:32:21                                                               //--
  ----------------------------------------------------------------------------------------------------

  SET NOCOUNT ON

  DECLARE @StartMessage nvarchar(max)
  DECLARE @ENDMessage nvarchar(max)
  DECLARE @DatabaseMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)
  DECLARE @Severity int

  DECLARE @StartTime datetime
  DECLARE @SchemaName nvarchar(max)
  DECLARE @ObjectName nvarchar(max)
  DECLARE @VersionTimestamp nvarchar(max)
  DECLARE @Parameters nvarchar(max)

  DECLARE @Version numeric(18,10)
  DECLARE @HostPlatform nvarchar(max)
  DECLARE @AmazonRDS bit

  DECLARE @QueueID int
  DECLARE @QueueStartTime datetime

  DECLARE @CurrentDBID int
  DECLARE @CurrentDatabaseID int
  DECLARE @CurrentDatabaseName nvarchar(max)
  DECLARE @CurrentIsDatabaseAccessible bit
  DECLARE @CurrentAvailabilityGroup nvarchar(max)
  DECLARE @CurrentAvailabilityGroupRole nvarchar(max)
  DECLARE @CurrentAvailabilityGroupBackupPreference nvarchar(max)
  DECLARE @CurrentIsPreferredBackupReplica bit
  DECLARE @CurrentDatabaseMirroringRole nvarchar(max)
  DECLARE @CurrentIsReadOnly bit

  DECLARE @CurrentFGID int
  DECLARE @CurrentFileGroupID int
  DECLARE @CurrentFileGroupName nvarchar(max)
  DECLARE @CurrentFileGroupExists bit

  DECLARE @CurrentOID int
  DECLARE @CurrentSchemaID int
  DECLARE @CurrentSchemaName nvarchar(max)
  DECLARE @CurrentObjectID int
  DECLARE @CurrentObjectName nvarchar(max)
  DECLARE @CurrentObjectType nvarchar(max)
  DECLARE @CurrentObjectExists bit

  DECLARE @CurrentCommand01 nvarchar(max)
  DECLARE @CurrentCommand02 nvarchar(max)
  DECLARE @CurrentCommand03 nvarchar(max)
  DECLARE @CurrentCommand04 nvarchar(max)
  DECLARE @CurrentCommand05 nvarchar(max)
  DECLARE @CurrentCommand06 nvarchar(max)
  DECLARE @CurrentCommand07 nvarchar(max)
  DECLARE @CurrentCommand08 nvarchar(max)
  DECLARE @CurrentCommand09 nvarchar(max)

  DECLARE @CurrentCommandOutput01 int
  DECLARE @CurrentCommandOutput04 int
  DECLARE @CurrentCommandOutput05 int
  DECLARE @CurrentCommandOutput08 int
  DECLARE @CurrentCommandOutput09 int

  DECLARE @CurrentCommandType01 nvarchar(max)
  DECLARE @CurrentCommandType04 nvarchar(max)
  DECLARE @CurrentCommandType05 nvarchar(max)
  DECLARE @CurrentCommandType08 nvarchar(max)
  DECLARE @CurrentCommandType09 nvarchar(max)

  DECLARE @tmpDatabases TABLE (ID int IDENTITY,
                               DatabaseName nvarchar(max),
                               DatabaseType nvarchar(max),
                               AvailabilityGroup bit,
                               [Snapshot] bit,
                               StartPosition int,
                               LastCommandTime datetime,
                               DatabaseSize bigint,
                               LastGoodCheckDbTime datetime,
                               [Order] int,
                               Selected bit,
                               Completed bit,
                               PRIMARY KEY(Selected, Completed, [Order], ID))

  DECLARE @tmpAvailabilityGroups TABLE (ID int IDENTITY PRIMARY KEY,
                                        AvailabilityGroupName nvarchar(max),
                                        StartPosition int,
                                        Selected bit)

  DECLARE @tmpDatabasesAvailabilityGroups TABLE (DatabaseName nvarchar(max),
                                                 AvailabilityGroupName nvarchar(max))

  DECLARE @tmpFileGroups TABLE (ID int IDENTITY,
                                FileGroupID int,
                                FileGroupName nvarchar(max),
                                StartPosition int,
                                [Order] int,
                                Selected bit,
                                Completed bit,
                                PRIMARY KEY(Selected, Completed, [Order], ID))

  DECLARE @tmpObjects TABLE (ID int IDENTITY,
                             SchemaID int,
                             SchemaName nvarchar(max),
                             ObjectID int,
                             ObjectName nvarchar(max),
                             ObjectType nvarchar(max),
                             StartPosition int,
                             [Order] int,
                             Selected bit,
                             Completed bit,
                             PRIMARY KEY(Selected, Completed, [Order], ID))

  DECLARE @SelectedDatabases TABLE (DatabaseName nvarchar(max),
                                    DatabaseType nvarchar(max),
                                    AvailabilityGroup nvarchar(max),
                                    StartPosition int,
                                    Selected bit)

  DECLARE @SelectedAvailabilityGroups TABLE (AvailabilityGroupName nvarchar(max),
                                             StartPosition int,
                                             Selected bit)

  DECLARE @SelectedFileGroups TABLE (DatabaseName nvarchar(max),
                                     FileGroupName nvarchar(max),
                                     StartPosition int,
                                     Selected bit)

  DECLARE @SelectedObjects TABLE (DatabaseName nvarchar(max),
                                  SchemaName nvarchar(max),
                                  ObjectName nvarchar(max),
                                  StartPosition int,
                                  Selected bit)

  DECLARE @SelectedCheckCommands TABLE (CheckCommand nvarchar(max))

  DECLARE @Error int
  DECLARE @RETURNCode int

  SET @Error = 0
  SET @RETURNCode = 0

  SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

  IF @Version >= 14
  BEGIN
    SELECT @HostPlatform = host_platform
    FROM sys.dm_os_host_info
  END
  ELSE
  BEGIN
    SET @HostPlatform = 'Windows'
  END

  SET @AmazonRDS = CASE WHEN DB_ID('rdsadmin') IS NOT NULL AND SUSER_SNAME(0x01) = 'rdsa' THEN 1 ELSE 0 END

  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartTime = GETDATE()
  SET @SchemaName = (SELECT schemas.name FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID)
  SET @ObjectName = OBJECT_NAME(@@PROCID)
  SET @VersionTimestamp = SUBSTRING(OBJECT_DEFINITION(@@PROCID),CHARINDEX('--// Version: ',OBJECT_DEFINITION(@@PROCID)) + LEN('--// Version: ') + 1, 19)

  SET @Parameters = '@Databases = ' + ISNULL('''' + REPLACE(@Databases,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @CheckCommands = ' + ISNULL('''' + REPLACE(@CheckCommands,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @PhysicalOnly = ' + ISNULL('''' + REPLACE(@PhysicalOnly,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @NoIndex = ' + ISNULL('''' + REPLACE(@NoIndex,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @ExtENDedLogicalChecks = ' + ISNULL('''' + REPLACE(@ExtENDedLogicalChecks,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @TabLock = ' + ISNULL('''' + REPLACE(@TabLock,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FileGroups = ' + ISNULL('''' + REPLACE(@FileGroups,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Objects = ' + ISNULL('''' + REPLACE(@Objects,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @MaxDOP = ' + ISNULL(CAST(@MaxDOP AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @AvailabilityGroups = ' + ISNULL('''' + REPLACE(@AvailabilityGroups,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @AvailabilityGroupReplicas = ' + ISNULL('''' + REPLACE(@AvailabilityGroupReplicas,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Updateability = ' + ISNULL('''' + REPLACE(@Updateability,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @TimeLimit = ' + ISNULL(CAST(@TimeLimit AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @LockTimeout = ' + ISNULL(CAST(@LockTimeout AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @LockMessageSeverity = ' + ISNULL(CAST(@LockMessageSeverity AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @DatabaseOrder = ' + ISNULL('''' + REPLACE(@DatabaseOrder,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DatabasesInParallel = ' + ISNULL('''' + REPLACE(@DatabasesInParallel,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @LogToTable = ' + ISNULL('''' + REPLACE(@LogToTable,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Execute = ' + ISNULL('''' + REPLACE(@Execute,'''','''''') + '''','NULL')

  SET @StartMessage = 'Date and time: ' + CONVERT(nvarchar,@StartTime,120)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Platform: ' + @HostPlatform
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Procedure: ' + QUOTENAME(DB_NAME(DB_ID())) + '.' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@ObjectName)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Parameters: ' + @Parameters
  SET @StartMessage = REPLACE(@StartMessage,'%','%%')
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Version: ' + @VersionTimestamp
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Source: https://ola.hallengren.com' + CHAR(13) + CHAR(10) + ' '
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  ----------------------------------------------------------------------------------------------------
  --// Check core requirements                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF NOT (SELECT [compatibility_level] FROM sys.databases WHERE database_id = DB_ID()) >= 90
  BEGIN
    SET @ErrorMessage = 'The database ' + QUOTENAME(DB_NAME(DB_ID())) + ' has to be in compatibility level 90 or higher.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_ansi_nulls FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'ANSI_NULLS has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_quoted_identifier FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'QUOTED_IDENTIFIER has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute is missing. Download https://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute' AND OBJECT_DEFINITION(objects.[object_id]) NOT LIKE '%@LockMessageSeverity%')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute needs to be updated. Download https://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandLog')
  BEGIN
    SET @ErrorMessage = 'The table CommandLog is missing. Download https://ola.hallengren.com/scripts/CommandLog.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'Queue')
  BEGIN
    SET @ErrorMessage = 'The table Queue is missing. Download https://ola.hallengren.com/scripts/Queue.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'QueueDatabase')
  BEGIN
    SET @ErrorMessage = 'The table QueueDatabase is missing. Download https://ola.hallengren.com/scripts/QueueDatabase.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @@TRANCOUNT <> 0
  BEGIN
    SET @ErrorMessage = 'The transaction count is not 0.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @RETURNCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Select databases                                                                           //--
  ----------------------------------------------------------------------------------------------------

  SET @Databases = REPLACE(@Databases, CHAR(10), '')
  SET @Databases = REPLACE(@Databases, CHAR(13), '')

  WHILE CHARINDEX(', ',@Databases) > 0 SET @Databases = REPLACE(@Databases,', ',',')
  WHILE CHARINDEX(' ,',@Databases) > 0 SET @Databases = REPLACE(@Databases,' ,',',')

  SET @Databases = LTRIM(RTRIM(@Databases));

  WITH Databases1 (StartPosition, ENDPosition, DatabaseItem) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Databases, 1), 0), LEN(@Databases) + 1) AS ENDPosition,
         SUBSTRING(@Databases, 1, ISNULL(NULLIF(CHARINDEX(',', @Databases, 1), 0), LEN(@Databases) + 1) - 1) AS DatabaseItem
  WHERE @Databases IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Databases, ENDPosition + 1), 0), LEN(@Databases) + 1) AS ENDPosition,
         SUBSTRING(@Databases, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Databases, ENDPosition + 1), 0), LEN(@Databases) + 1) - ENDPosition - 1) AS DatabaseItem
  FROM Databases1
  WHERE ENDPosition < LEN(@Databases) + 1
  ),
  Databases2 (DatabaseItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem LIKE '-%' THEN RIGHT(DatabaseItem,LEN(DatabaseItem) - 1) ELSE DatabaseItem END AS DatabaseItem,
         StartPosition,
         CASE WHEN DatabaseItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM Databases1
  ),
  Databases3 (DatabaseItem, DatabaseType, AvailabilityGroup, StartPosition, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem IN('ALL_DATABASES','SYSTEM_DATABASES','USER_DATABASES','AVAILABILITY_GROUP_DATABASES') THEN '%' ELSE DatabaseItem END AS DatabaseItem,
         CASE WHEN DatabaseItem = 'SYSTEM_DATABASES' THEN 'S' WHEN DatabaseItem = 'USER_DATABASES' THEN 'U' ELSE NULL END AS DatabaseType,
         CASE WHEN DatabaseItem = 'AVAILABILITY_GROUP_DATABASES' THEN 1 ELSE NULL END AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases2
  ),
  Databases4 (DatabaseName, DatabaseType, AvailabilityGroup, StartPosition, Selected) AS
  (
  SELECT CASE WHEN LEFT(DatabaseItem,1) = '[' AND RIGHT(DatabaseItem,1) = ']' THEN PARSENAME(DatabaseItem,1) ELSE DatabaseItem END AS DatabaseItem,
         DatabaseType,
         AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases3
  )
  INSERT INTO @SelectedDatabases (DatabaseName, DatabaseType, AvailabilityGroup, StartPosition, Selected)
  SELECT DatabaseName,
         DatabaseType,
         AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases4
  OPTION (MAXRECURSION 0)

  IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN
    INSERT INTO @tmpAvailabilityGroups (AvailabilityGroupName, Selected)
    SELECT name AS AvailabilityGroupName,
           0 AS Selected
    FROM sys.availability_groups

    INSERT INTO @tmpDatabasesAvailabilityGroups (DatabaseName, AvailabilityGroupName)
    SELECT availability_databases_cluster.database_name, availability_groups.name
    FROM sys.availability_databases_cluster availability_databases_cluster
    INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
  END

  INSERT INTO @tmpDatabases (DatabaseName, DatabaseType, AvailabilityGroup, [Snapshot], [Order], Selected, Completed)
  SELECT [name] AS DatabaseName,
         CASE WHEN name IN('master','msdb','model') THEN 'S' ELSE 'U' END AS DatabaseType,
         NULL AS AvailabilityGroup,
         CASE WHEN source_database_id IS NOT NULL THEN 1 ELSE 0 END AS [Snapshot],
         0 AS [Order],
         0 AS Selected,
         0 AS Completed
  FROM sys.databases
  ORDER BY [name] ASC

  UPDATE tmpDatabases
  SET AvailabilityGroup = CASE WHEN EXISTS (SELECT * FROM @tmpDatabasesAvailabilityGroups WHERE DatabaseName = tmpDatabases.DatabaseName) THEN 1 ELSE 0 END
  FROM @tmpDatabases tmpDatabases

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
  AND NOT ((tmpDatabases.DatabaseName = 'tempdb' OR tmpDatabases.[Snapshot] = 1) AND tmpDatabases.DatabaseName <> SelectedDatabases.DatabaseName)
  WHERE SelectedDatabases.Selected = 1

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
  AND NOT ((tmpDatabases.DatabaseName = 'tempdb' OR tmpDatabases.[Snapshot] = 1) AND tmpDatabases.DatabaseName <> SelectedDatabases.DatabaseName)
  WHERE SelectedDatabases.Selected = 0

  UPDATE tmpDatabases
  SET tmpDatabases.StartPosition = SelectedDatabases2.StartPosition
  FROM @tmpDatabases tmpDatabases
  INNER JOIN (SELECT tmpDatabases.DatabaseName, MIN(SelectedDatabases.StartPosition) AS StartPosition
              FROM @tmpDatabases tmpDatabases
              INNER JOIN @SelectedDatabases SelectedDatabases
              ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
              AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
              AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
              WHERE SelectedDatabases.Selected = 1
              GROUP BY tmpDatabases.DatabaseName) SelectedDatabases2
  ON tmpDatabases.DatabaseName = SelectedDatabases2.DatabaseName

  IF @Databases IS NOT NULL AND (NOT EXISTS(SELECT * FROM @SelectedDatabases) OR EXISTS(SELECT * FROM @SelectedDatabases WHERE DatabaseName IS NULL OR DatabaseName = ''))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Databases is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select availability groups                                                                 //--
  ----------------------------------------------------------------------------------------------------

  IF @AvailabilityGroups IS NOT NULL AND @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN

    SET @AvailabilityGroups = REPLACE(@AvailabilityGroups, CHAR(10), '')
    SET @AvailabilityGroups = REPLACE(@AvailabilityGroups, CHAR(13), '')

    WHILE CHARINDEX(', ',@AvailabilityGroups) > 0 SET @AvailabilityGroups = REPLACE(@AvailabilityGroups,', ',',')
    WHILE CHARINDEX(' ,',@AvailabilityGroups) > 0 SET @AvailabilityGroups = REPLACE(@AvailabilityGroups,' ,',',')

    SET @AvailabilityGroups = LTRIM(RTRIM(@AvailabilityGroups));

    WITH AvailabilityGroups1 (StartPosition, ENDPosition, AvailabilityGroupItem) AS
    (
    SELECT 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, 1), 0), LEN(@AvailabilityGroups) + 1) AS ENDPosition,
           SUBSTRING(@AvailabilityGroups, 1, ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, 1), 0), LEN(@AvailabilityGroups) + 1) - 1) AS AvailabilityGroupItem
    WHERE @AvailabilityGroups IS NOT NULL
    UNION ALL
    SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, ENDPosition + 1), 0), LEN(@AvailabilityGroups) + 1) AS ENDPosition,
           SUBSTRING(@AvailabilityGroups, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, ENDPosition + 1), 0), LEN(@AvailabilityGroups) + 1) - ENDPosition - 1) AS AvailabilityGroupItem
    FROM AvailabilityGroups1
    WHERE ENDPosition < LEN(@AvailabilityGroups) + 1
    ),
    AvailabilityGroups2 (AvailabilityGroupItem, StartPosition, Selected) AS
    (
    SELECT CASE WHEN AvailabilityGroupItem LIKE '-%' THEN RIGHT(AvailabilityGroupItem,LEN(AvailabilityGroupItem) - 1) ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           CASE WHEN AvailabilityGroupItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
    FROM AvailabilityGroups1
    ),
    AvailabilityGroups3 (AvailabilityGroupItem, StartPosition, Selected) AS
    (
    SELECT CASE WHEN AvailabilityGroupItem = 'ALL_AVAILABILITY_GROUPS' THEN '%' ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           Selected
    FROM AvailabilityGroups2
    ),
    AvailabilityGroups4 (AvailabilityGroupName, StartPosition, Selected) AS
    (
    SELECT CASE WHEN LEFT(AvailabilityGroupItem,1) = '[' AND RIGHT(AvailabilityGroupItem,1) = ']' THEN PARSENAME(AvailabilityGroupItem,1) ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           Selected
    FROM AvailabilityGroups3
    )
    INSERT INTO @SelectedAvailabilityGroups (AvailabilityGroupName, StartPosition, Selected)
    SELECT AvailabilityGroupName, StartPosition, Selected
    FROM AvailabilityGroups4
    OPTION (MAXRECURSION 0)

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.Selected = SelectedAvailabilityGroups.Selected
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
    ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
    WHERE SelectedAvailabilityGroups.Selected = 1

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.Selected = SelectedAvailabilityGroups.Selected
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
    ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
    WHERE SelectedAvailabilityGroups.Selected = 0

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.StartPosition = SelectedAvailabilityGroups2.StartPosition
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN (SELECT tmpAvailabilityGroups.AvailabilityGroupName, MIN(SelectedAvailabilityGroups.StartPosition) AS StartPosition
                FROM @tmpAvailabilityGroups tmpAvailabilityGroups
                INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
                ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
                WHERE SelectedAvailabilityGroups.Selected = 1
                GROUP BY tmpAvailabilityGroups.AvailabilityGroupName) SelectedAvailabilityGroups2
    ON tmpAvailabilityGroups.AvailabilityGroupName = SelectedAvailabilityGroups2.AvailabilityGroupName

    UPDATE tmpDatabases
    SET tmpDatabases.StartPosition = tmpAvailabilityGroups.StartPosition,
        tmpDatabases.Selected = 1
    FROM @tmpDatabases tmpDatabases
    INNER JOIN @tmpDatabasesAvailabilityGroups tmpDatabasesAvailabilityGroups ON tmpDatabases.DatabaseName = tmpDatabasesAvailabilityGroups.DatabaseName
    INNER JOIN @tmpAvailabilityGroups tmpAvailabilityGroups ON tmpDatabasesAvailabilityGroups.AvailabilityGroupName = tmpAvailabilityGroups.AvailabilityGroupName
    WHERE tmpAvailabilityGroups.Selected = 1

  END

  IF @AvailabilityGroups IS NOT NULL AND (NOT EXISTS(SELECT * FROM @SelectedAvailabilityGroups) OR EXISTS(SELECT * FROM @SelectedAvailabilityGroups WHERE AvailabilityGroupName IS NULL OR AvailabilityGroupName = '') OR @Version < 11 OR SERVERPROPERTY('IsHadrEnabled') = 0)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @AvailabilityGroups is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Databases IS NULL AND @AvailabilityGroups IS NULL)
  BEGIN
    SET @ErrorMessage = 'You need to specify one of the parameters @Databases and @AvailabilityGroups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Databases IS NOT NULL AND @AvailabilityGroups IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'You can only specify one of the parameters @Databases and @AvailabilityGroups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select filegroups                                                                          //--
  ----------------------------------------------------------------------------------------------------

  SET @FileGroups = REPLACE(@FileGroups, CHAR(10), '')
  SET @FileGroups = REPLACE(@FileGroups, CHAR(13), '')

  WHILE CHARINDEX(', ',@FileGroups) > 0 SET @FileGroups = REPLACE(@FileGroups,', ',',')
  WHILE CHARINDEX(' ,',@FileGroups) > 0 SET @FileGroups = REPLACE(@FileGroups,' ,',',')

  SET @FileGroups = LTRIM(RTRIM(@FileGroups));

  WITH FileGroups1 (StartPosition, ENDPosition, FileGroupItem) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FileGroups, 1), 0), LEN(@FileGroups) + 1) AS ENDPosition,
         SUBSTRING(@FileGroups, 1, ISNULL(NULLIF(CHARINDEX(',', @FileGroups, 1), 0), LEN(@FileGroups) + 1) - 1) AS FileGroupItem
  WHERE @FileGroups IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FileGroups, ENDPosition + 1), 0), LEN(@FileGroups) + 1) AS ENDPosition,
         SUBSTRING(@FileGroups, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @FileGroups, ENDPosition + 1), 0), LEN(@FileGroups) + 1) - ENDPosition - 1) AS FileGroupItem
  FROM FileGroups1
  WHERE ENDPosition < LEN(@FileGroups) + 1
  ),
  FileGroups2 (FileGroupItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN FileGroupItem LIKE '-%' THEN RIGHT(FileGroupItem,LEN(FileGroupItem) - 1) ELSE FileGroupItem END AS FileGroupItem,
         StartPosition,
         CASE WHEN FileGroupItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM FileGroups1
  ),
  FileGroups3 (FileGroupItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN FileGroupItem = 'ALL_FILEGROUPS' THEN '%.%' ELSE FileGroupItem END AS FileGroupItem,
         StartPosition,
         Selected
  FROM FileGroups2
  ),
  FileGroups4 (DatabaseName, FileGroupName, StartPosition, Selected) AS
  (
  SELECT CASE WHEN PARSENAME(FileGroupItem,4) IS NULL AND PARSENAME(FileGroupItem,3) IS NULL THEN PARSENAME(FileGroupItem,2) ELSE NULL END AS DatabaseName,
         CASE WHEN PARSENAME(FileGroupItem,4) IS NULL AND PARSENAME(FileGroupItem,3) IS NULL THEN PARSENAME(FileGroupItem,1) ELSE NULL END AS FileGroupName,
         StartPosition,
         Selected
  FROM FileGroups3
  )
  INSERT INTO @SelectedFileGroups (DatabaseName, FileGroupName, StartPosition, Selected)
  SELECT DatabaseName, FileGroupName, StartPosition, Selected
  FROM FileGroups4
  OPTION (MAXRECURSION 0)

  ----------------------------------------------------------------------------------------------------
  --// Select objects                                                                             //--
  ----------------------------------------------------------------------------------------------------

  SET @Objects = REPLACE(@Objects, CHAR(10), '')
  SET @Objects = REPLACE(@Objects, CHAR(13), '')

  WHILE CHARINDEX(', ',@Objects) > 0 SET @Objects = REPLACE(@Objects,', ',',')
  WHILE CHARINDEX(' ,',@Objects) > 0 SET @Objects = REPLACE(@Objects,' ,',',')

  SET @Objects = LTRIM(RTRIM(@Objects));

  WITH Objects1 (StartPosition, ENDPosition, ObjectItem) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Objects, 1), 0), LEN(@Objects) + 1) AS ENDPosition,
         SUBSTRING(@Objects, 1, ISNULL(NULLIF(CHARINDEX(',', @Objects, 1), 0), LEN(@Objects) + 1) - 1) AS ObjectItem
  WHERE @Objects IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Objects, ENDPosition + 1), 0), LEN(@Objects) + 1) AS ENDPosition,
         SUBSTRING(@Objects, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Objects, ENDPosition + 1), 0), LEN(@Objects) + 1) - ENDPosition - 1) AS ObjectItem
  FROM Objects1
  WHERE ENDPosition < LEN(@Objects) + 1
  ),
  Objects2 (ObjectItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN ObjectItem LIKE '-%' THEN RIGHT(ObjectItem,LEN(ObjectItem) - 1) ELSE ObjectItem END AS ObjectItem,
          StartPosition,
         CASE WHEN ObjectItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM Objects1
  ),
  Objects3 (ObjectItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN ObjectItem = 'ALL_OBJECTS' THEN '%.%.%' ELSE ObjectItem END AS ObjectItem,
         StartPosition,
         Selected
  FROM Objects2
  ),
  Objects4 (DatabaseName, SchemaName, ObjectName, StartPosition, Selected) AS
  (
  SELECT CASE WHEN PARSENAME(ObjectItem,4) IS NULL THEN PARSENAME(ObjectItem,3) ELSE NULL END AS DatabaseName,
         CASE WHEN PARSENAME(ObjectItem,4) IS NULL THEN PARSENAME(ObjectItem,2) ELSE NULL END AS SchemaName,
         CASE WHEN PARSENAME(ObjectItem,4) IS NULL THEN PARSENAME(ObjectItem,1) ELSE NULL END AS ObjectName,
         StartPosition,
         Selected
  FROM Objects3
  )
  INSERT INTO @SelectedObjects (DatabaseName, SchemaName, ObjectName, StartPosition, Selected)
  SELECT DatabaseName, SchemaName, ObjectName, StartPosition, Selected
  FROM Objects4
  OPTION (MAXRECURSION 0);

  ----------------------------------------------------------------------------------------------------
  --// Select check commands                                                                      //--
  ----------------------------------------------------------------------------------------------------

  WITH CheckCommands (StartPosition, ENDPosition, CheckCommand) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @CheckCommands, 1), 0), LEN(@CheckCommands) + 1) AS ENDPosition,
         SUBSTRING(@CheckCommands, 1, ISNULL(NULLIF(CHARINDEX(',', @CheckCommands, 1), 0), LEN(@CheckCommands) + 1) - 1) AS CheckCommand
  WHERE @CheckCommands IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @CheckCommands, ENDPosition + 1), 0), LEN(@CheckCommands) + 1) AS ENDPosition,
         SUBSTRING(@CheckCommands, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @CheckCommands, ENDPosition + 1), 0), LEN(@CheckCommands) + 1) - ENDPosition - 1) AS CheckCommand
  FROM CheckCommands
  WHERE ENDPosition < LEN(@CheckCommands) + 1
  )
  INSERT INTO @SelectedCheckCommands (CheckCommand)
  SELECT CheckCommand
  FROM CheckCommands
  OPTION (MAXRECURSION 0)

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF EXISTS (SELECT * FROM @SelectedCheckCommands WHERE CheckCommand NOT IN('CHECKDB','CHECKFILEGROUP','CHECKALLOC','CHECKTABLE','CHECKCATALOG')) OR EXISTS (SELECT * FROM @SelectedCheckCommands GROUP BY CheckCommand HAVING COUNT(*) > 1) OR NOT EXISTS (SELECT * FROM @SelectedCheckCommands) OR (EXISTS (SELECT * FROM @SelectedCheckCommands WHERE CheckCommand IN('CHECKDB')) AND EXISTS (SELECT CheckCommand FROM @SelectedCheckCommands WHERE CheckCommand IN('CHECKFILEGROUP','CHECKALLOC','CHECKTABLE','CHECKCATALOG'))) OR (EXISTS (SELECT * FROM @SelectedCheckCommands WHERE CheckCommand IN('CHECKFILEGROUP')) AND EXISTS (SELECT CheckCommand FROM @SelectedCheckCommands WHERE CheckCommand IN('CHECKALLOC','CHECKTABLE')))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @CheckCommands is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @PhysicalOnly NOT IN ('Y','N') OR @PhysicalOnly IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @PhysicalOnly is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @NoIndex NOT IN ('Y','N') OR @NoIndex IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @NoIndex is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @ExtENDedLogicalChecks NOT IN ('Y','N') OR @ExtENDedLogicalChecks IS NULL OR (@ExtENDedLogicalChecks = 'Y' AND NOT @Version >= 10) OR (@PhysicalOnly = 'Y' AND @ExtENDedLogicalChecks = 'Y')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @ExtENDedLogicalChecks is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @TabLock NOT IN ('Y','N') OR @TabLock IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @TabLock is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS(SELECT * FROM @SelectedFileGroups WHERE DatabaseName IS NULL OR FileGroupName IS NULL) OR (@FileGroups IS NOT NULL AND NOT EXISTS(SELECT * FROM @SelectedFileGroups)) OR (@FileGroups IS NOT NULL AND NOT EXISTS (SELECT * FROM @SelectedCheckCommands WHERE CheckCommand = 'CHECKFILEGROUP'))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FileGroups is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS(SELECT * FROM @SelectedObjects WHERE DatabaseName IS NULL OR SchemaName IS NULL OR ObjectName IS NULL) OR (@Objects IS NOT NULL AND NOT EXISTS(SELECT * FROM @SelectedObjects)) OR (@Objects IS NOT NULL AND NOT EXISTS (SELECT * FROM @SelectedCheckCommands WHERE CheckCommand = 'CHECKTABLE'))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Objects is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxDOP < 0 OR @MaxDOP > 64 OR (@MaxDOP IS NOT NULL AND NOT (@Version >= 12.050000 OR SERVERPROPERTY('EngineEdition') IN (5, 8)))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MaxDOP is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @AvailabilityGroupReplicas NOT IN('ALL','PRIMARY','SECONDARY','PREFERRED_BACKUP_REPLICA') OR @AvailabilityGroupReplicas IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @AvailabilityGroupReplicas is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Updateability NOT IN('READ_ONLY','READ_WRITE','ALL') OR @Updateability IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Updateability is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @TimeLimit < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @TimeLimit is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LockTimeout < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LockTimeout is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LockMessageSeverity NOT IN(10,16)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LockMessageSeverity is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabaseOrder NOT IN('DATABASE_NAME_ASC','DATABASE_NAME_DESC','DATABASE_SIZE_ASC','DATABASE_SIZE_DESC','DATABASE_LAST_GOOD_CHECK_ASC','DATABASE_LAST_GOOD_CHECK_DESC','REPLICA_LAST_GOOD_CHECK_ASC','REPLICA_LAST_GOOD_CHECK_DESC') OR (@DatabaseOrder IN('DATABASE_LAST_GOOD_CHECK_ASC','DATABASE_LAST_GOOD_CHECK_DESC') AND NOT ((@Version >= 13.05026 AND @Version < 14) OR @Version >= 14.0302916)) OR (@DatabaseOrder IN('REPLICA_LAST_GOOD_CHECK_ASC','REPLICA_LAST_GOOD_CHECK_DESC') AND @LogToTable = 'N') OR (@DatabaseOrder IN('DATABASE_LAST_GOOD_CHECK_ASC','DATABASE_LAST_GOOD_CHECK_DESC','REPLICA_LAST_GOOD_CHECK_ASC','REPLICA_LAST_GOOD_CHECK_DESC') AND @CheckCommands <> 'CHECKDB') OR (@DatabaseOrder IS NOT NULL AND SERVERPROPERTY('EngineEdition') = 5)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DatabaseOrder is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel NOT IN('Y','N') OR @DatabasesInParallel IS NULL OR (@DatabasesInParallel = 'Y' AND SERVERPROPERTY('EngineEdition') = 5)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DatabasesInParallel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable NOT IN('Y','N') OR @LogToTable IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogToTable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Execute is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ErrorMessage = 'The documentation is available at https://ola.hallengren.com/sql-server-integrity-check.html.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @RETURNCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Check that selected databases and availability groups exist                                //--
  ----------------------------------------------------------------------------------------------------

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedDatabases
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases in the @Databases parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedFileGroups
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases in the @FileGroups parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedObjects
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases in the @Objects parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(AvailabilityGroupName) + ', '
  FROM @SelectedAvailabilityGroups
  WHERE AvailabilityGroupName NOT LIKE '%[%]%'
  AND AvailabilityGroupName NOT IN (SELECT AvailabilityGroupName FROM @tmpAvailabilityGroups)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following availability groups do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedFileGroups
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName IN (SELECT DatabaseName FROM @tmpDatabases)
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases WHERE Selected = 1)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases have been selected in the @FileGroups parameter, but not in the @Databases or @AvailabilityGroups parameters: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedObjects
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName IN (SELECT DatabaseName FROM @tmpDatabases)
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases WHERE Selected = 1)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases have been selected in the @Objects parameter, but not in the @Databases or @AvailabilityGroups parameters: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Check @@SERVERNAME                                                                         //--
  ----------------------------------------------------------------------------------------------------

  IF @@SERVERNAME <> CAST(SERVERPROPERTY('ServerName') AS nvarchar(max)) AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN
    SET @ErrorMessage = 'The @@SERVERNAME does not match SERVERPROPERTY(''ServerName''). See ' + CASE WHEN SERVERPROPERTY('IsClustered') = 0 THEN 'https://docs.microsoft.com/en-us/sql/database-engine/install-windows/rename-a-computer-that-hosts-a-stand-alone-instance-of-sql-server' WHEN SERVERPROPERTY('IsClustered') = 1 THEN 'https://docs.microsoft.com/en-us/sql/sql-server/failover-clusters/install/rename-a-sql-server-failover-cluster-instance' END + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Update database order                                                                      //--
  ----------------------------------------------------------------------------------------------------

  IF @DatabaseOrder IN('DATABASE_SIZE_ASC','DATABASE_SIZE_DESC')
  BEGIN
    UPDATE tmpDatabases
    SET DatabaseSize = (SELECT SUM(size) FROM sys.master_files WHERE [type] = 0 AND database_id = DB_ID(tmpDatabases.DatabaseName))
    FROM @tmpDatabases tmpDatabases
  END

  IF @DatabaseOrder IN('DATABASE_LAST_GOOD_CHECK_ASC','DATABASE_LAST_GOOD_CHECK_DESC')
  BEGIN
    UPDATE tmpDatabases
    SET LastGoodCheckDbTime = NULLIF(CAST(DATABASEPROPERTYEX (DatabaseName,'LastGoodCheckDbTime') AS datetime),'1900-01-01 00:00:00.000')
    FROM @tmpDatabases tmpDatabases
  END

  IF @DatabaseOrder IN('REPLICA_LAST_GOOD_CHECK_ASC','REPLICA_LAST_GOOD_CHECK_DESC')
  BEGIN
    UPDATE tmpDatabases
    SET LastCommandTime = MaxStartTime
    FROM @tmpDatabases tmpDatabases
    INNER JOIN (SELECT DatabaseName, MAX(StartTime) AS MaxStartTime
                FROM dbo.CommandLog
                WHERE CommandType = 'DBCC_CHECKDB'
                AND ErrorNumber = 0
                GROUP BY DatabaseName) CommandLog
    ON tmpDatabases.DatabaseName = CommandLog.DatabaseName
  END

  IF @DatabaseOrder IS NULL
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY StartPosition ASC, DatabaseName ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_NAME_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseName ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_NAME_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseName DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_SIZE_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseSize ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_SIZE_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseSize DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_LAST_GOOD_CHECK_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY LastGoodCheckDbTime ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_LAST_GOOD_CHECK_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY LastGoodCheckDbTime DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'REPLICA_LAST_GOOD_CHECK_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY LastCommandTime ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'REPLICA_LAST_GOOD_CHECK_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY LastCommandTime DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END

  ----------------------------------------------------------------------------------------------------
  --// Update the queue                                                                           //--
  ----------------------------------------------------------------------------------------------------

  IF @DatabasesInParallel = 'Y'
  BEGIN

    BEGIN TRY

      SELECT @QueueID = QueueID
      FROM dbo.[Queue]
      WHERE SchemaName = @SchemaName
      AND ObjectName = @ObjectName
      AND [Parameters] = @Parameters

      IF @QueueID IS NULL
      BEGIN
        BEGIN TRANSACTION

        SELECT @QueueID = QueueID
        FROM dbo.[Queue] WITH (UPDLOCK, TABLOCK)
        WHERE SchemaName = @SchemaName
        AND ObjectName = @ObjectName
        AND [Parameters] = @Parameters

        IF @QueueID IS NULL
        BEGIN
          INSERT INTO dbo.[Queue] (SchemaName, ObjectName, [Parameters])
          SELECT @SchemaName, @ObjectName, @Parameters

          SET @QueueID = SCOPE_IDENTITY()
        END

        COMMIT TRANSACTION
      END

      BEGIN TRANSACTION

      UPDATE [Queue]
      SET QueueStartTime = GETDATE(),
          SessionID = @@SPID,
          RequestID = (SELECT request_id FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          RequestStartTime = (SELECT start_time FROM sys.dm_exec_requests WHERE session_id = @@SPID)
      FROM dbo.[Queue] [Queue]
      WHERE QueueID = @QueueID
      AND NOT EXISTS (SELECT *
                      FROM sys.dm_exec_requests
                      WHERE session_id = [Queue].SessionID
                      AND request_id = [Queue].RequestID
                      AND start_time = [Queue].RequestStartTime)
      AND NOT EXISTS (SELECT *
                      FROM dbo.QueueDatabase QueueDatabase
                      INNER JOIN sys.dm_exec_requests ON QueueDatabase.SessionID = session_id AND QueueDatabase.RequestID = request_id AND QueueDatabase.RequestStartTime = start_time
                      WHERE QueueDatabase.QueueID = @QueueID)

      IF @@ROWCOUNT = 1
      BEGIN
        INSERT INTO dbo.QueueDatabase (QueueID, DatabaseName)
        SELECT @QueueID AS QueueID,
               DatabaseName
        FROM @tmpDatabases tmpDatabases
        WHERE Selected = 1
        AND NOT EXISTS (SELECT * FROM dbo.QueueDatabase WHERE DatabaseName = tmpDatabases.DatabaseName AND QueueID = @QueueID)

        DELETE QueueDatabase
        FROM dbo.QueueDatabase QueueDatabase
        WHERE QueueID = @QueueID
        AND NOT EXISTS (SELECT * FROM @tmpDatabases tmpDatabases WHERE DatabaseName = QueueDatabase.DatabaseName AND Selected = 1)

        UPDATE QueueDatabase
        SET DatabaseOrder = tmpDatabases.[Order]
        FROM dbo.QueueDatabase QueueDatabase
        INNER JOIN @tmpDatabases tmpDatabases ON QueueDatabase.DatabaseName = tmpDatabases.DatabaseName
      END

      COMMIT TRANSACTION

      SELECT @QueueStartTime = QueueStartTime
      FROM dbo.[Queue]
      WHERE QueueID = @QueueID

    END TRY

    BEGIN CATCH
      IF XACT_STATE() <> 0
      BEGIN
        ROLLBACK TRANSACTION
      END
      SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CHAR(13) + CHAR(10) + ' '
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
      SET @RETURNCode = ERROR_NUMBER()
      GOTO Logging
    END CATCH

  END

  ----------------------------------------------------------------------------------------------------
  --// Execute commands                                                                           //--
  ----------------------------------------------------------------------------------------------------

  WHILE (1 = 1)
  BEGIN

    IF @DatabasesInParallel = 'Y'
    BEGIN
      UPDATE QueueDatabase
      SET DatabaseStartTime = NULL,
          SessionID = NULL,
          RequestID = NULL,
          RequestStartTime = NULL
      FROM dbo.QueueDatabase QueueDatabase
      WHERE QueueID = @QueueID
      AND DatabaseStartTime IS NOT NULL
      AND DatabaseENDTime IS NULL
      AND NOT EXISTS (SELECT * FROM sys.dm_exec_requests WHERE session_id = QueueDatabase.SessionID AND request_id = QueueDatabase.RequestID AND start_time = QueueDatabase.RequestStartTime)

      UPDATE QueueDatabase
      SET DatabaseStartTime = GETDATE(),
          DatabaseENDTime = NULL,
          SessionID = @@SPID,
          RequestID = (SELECT request_id FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          RequestStartTime = (SELECT start_time FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          @CurrentDatabaseName = DatabaseName
      FROM (SELECT TOP 1 DatabaseStartTime,
                         DatabaseENDTime,
                         SessionID,
                         RequestID,
                         RequestStartTime,
                         DatabaseName
            FROM dbo.QueueDatabase
            WHERE QueueID = @QueueID
            AND (DatabaseStartTime < @QueueStartTime OR DatabaseStartTime IS NULL)
            AND NOT (DatabaseStartTime IS NOT NULL AND DatabaseENDTime IS NULL)
            ORDER BY DatabaseOrder ASC
            ) QueueDatabase
    END
    ELSE
    BEGIN
      SELECT TOP 1 @CurrentDBID = ID,
                   @CurrentDatabaseName = DatabaseName
      FROM @tmpDatabases
      WHERE Selected = 1
      AND Completed = 0
      ORDER BY [Order] ASC
    END

    IF @@ROWCOUNT = 0
    BEGIN
     BREAK
    END

    SET @CurrentDatabaseID = DB_ID(@CurrentDatabaseName)

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE' AND SERVERPROPERTY('EngineEdition') <> 5
    BEGIN
      IF EXISTS (SELECT * FROM sys.database_recovery_status WHERE database_id = @CurrentDatabaseID AND database_guid IS NOT NULL)
      BEGIN
        SET @CurrentIsDatabaseAccessible = 1
      END
      ELSE
      BEGIN
        SET @CurrentIsDatabaseAccessible = 0
      END
    END

    IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
    BEGIN
      SELECT @CurrentAvailabilityGroup = availability_groups.name,
             @CurrentAvailabilityGroupRole = dm_hadr_availability_replica_states.role_desc,
             @CurrentAvailabilityGroupBackupPreference = UPPER(availability_groups.automated_backup_preference_desc)
      FROM sys.databases databases
      INNER JOIN sys.availability_databases_cluster availability_databases_cluster ON databases.group_database_id = availability_databases_cluster.group_database_id
      INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
      INNER JOIN sys.dm_hadr_availability_replica_states dm_hadr_availability_replica_states ON availability_groups.group_id = dm_hadr_availability_replica_states.group_id AND databases.replica_id = dm_hadr_availability_replica_states.replica_id
      WHERE databases.name = @CurrentDatabaseName
    END

    IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1 AND @CurrentAvailabilityGroup IS NOT NULL AND @AvailabilityGroupReplicas = 'PREFERRED_BACKUP_REPLICA'
    BEGIN
      SELECT @CurrentIsPreferredBackupReplica = sys.fn_hadr_backup_is_preferred_replica(@CurrentDatabaseName)
    END

    IF SERVERPROPERTY('EngineEdition') <> 5
    BEGIN
      SELECT @CurrentDatabaseMirroringRole = UPPER(mirroring_role_desc)
      FROM sys.database_mirroring
      WHERE database_id = @CurrentDatabaseID
    END

    SELECT @CurrentIsReadOnly = is_read_only
    FROM sys.databases
    WHERE name = @CurrentDatabaseName

    SET @DatabaseMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Database: ' + QUOTENAME(@CurrentDatabaseName)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Status: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Standby: ' + CASE WHEN DATABASEPROPERTYEX(@CurrentDatabaseName,'IsInStandBy') = 1 THEN 'Yes' ELSE 'No' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Updateability: ' + CASE WHEN @CurrentIsReadOnly = 1 THEN 'READ_ONLY' WHEN  @CurrentIsReadOnly = 0 THEN 'READ_WRITE' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'User access: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'UserAccess') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentIsDatabaseAccessible IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Is accessible: ' + CASE WHEN @CurrentIsDatabaseAccessible = 1 THEN 'Yes' ELSE 'No' END
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    SET @DatabaseMessage = 'Recovery model: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentAvailabilityGroup IS NOT NULL
    BEGIN
      SET @DatabaseMessage =  'Availability group: ' + @CurrentAvailabilityGroup
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      SET @DatabaseMessage = 'Availability group role: ' + @CurrentAvailabilityGroupRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      IF @AvailabilityGroupReplicas = 'PREFERRED_BACKUP_REPLICA'
      BEGIN
        SET @DatabaseMessage = 'Availability group backup preference: ' + @CurrentAvailabilityGroupBackupPreference
        RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

        SET @DatabaseMessage = 'Is preferred backup replica: ' + CASE WHEN @CurrentIsPreferredBackupReplica = 1 THEN 'Yes' WHEN @CurrentIsPreferredBackupReplica = 0 THEN 'No' ELSE 'N/A' END
        RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
      END
    END

    IF @CurrentDatabaseMirroringRole IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Database mirroring role: ' + @CurrentDatabaseMirroringRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    RAISERROR('',10,1) WITH NOWAIT

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    AND (@CurrentIsDatabaseAccessible = 1 OR @CurrentIsDatabaseAccessible IS NULL)
    AND (@CurrentAvailabilityGroupRole = 'PRIMARY' OR @CurrentAvailabilityGroupRole IS NULL OR SERVERPROPERTY('EngineEdition') = 3)
    AND ((@AvailabilityGroupReplicas = 'PRIMARY' AND @CurrentAvailabilityGroupRole = 'PRIMARY') OR (@AvailabilityGroupReplicas = 'SECONDARY' AND @CurrentAvailabilityGroupRole = 'SECONDARY') OR (@AvailabilityGroupReplicas = 'PREFERRED_BACKUP_REPLICA' AND @CurrentIsPreferredBackupReplica = 1) OR @AvailabilityGroupReplicas = 'ALL' OR @CurrentAvailabilityGroupRole IS NULL)
    AND NOT (@CurrentIsReadOnly = 1 AND @Updateability = 'READ_WRITE')
    AND NOT (@CurrentIsReadOnly = 0 AND @Updateability = 'READ_ONLY')
    BEGIN

      -- Check database
      IF EXISTS(SELECT * FROM @SelectedCheckCommands WHERE CheckCommand = 'CHECKDB') AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SET @CurrentCommandType01 = 'DBCC_CHECKDB'

        SET @CurrentCommand01 = ''
        IF @LockTimeout IS NOT NULL SET @CurrentCommand01 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
        SET @CurrentCommand01 = @CurrentCommand01 + 'DBCC CHECKDB (' + QUOTENAME(@CurrentDatabaseName)
        IF @NoIndex = 'Y' SET @CurrentCommand01 = @CurrentCommand01 + ', NOINDEX'
        SET @CurrentCommand01 = @CurrentCommand01 + ') WITH NO_INFOMSGS, ALL_ERRORMSGS'
        IF @PhysicalOnly = 'N' SET @CurrentCommand01 = @CurrentCommand01 + ', DATA_PURITY'
        IF @PhysicalOnly = 'Y' SET @CurrentCommand01 = @CurrentCommand01 + ', PHYSICAL_ONLY'
        IF @ExtENDedLogicalChecks = 'Y' SET @CurrentCommand01 = @CurrentCommand01 + ', EXTENDED_LOGICAL_CHECKS'
        IF @TabLock = 'Y' SET @CurrentCommand01 = @CurrentCommand01 + ', TABLOCK'
        IF @MaxDOP IS NOT NULL SET @CurrentCommand01 = @CurrentCommand01 + ', MAXDOP = ' + CAST(@MaxDOP AS nvarchar)

        EXECUTE @CurrentCommandOutput01 = [dbo].[CommandExecute] @Command = @CurrentCommand01, @CommandType = @CurrentCommandType01, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
        SET @Error = @@ERROR
        IF @Error <> 0 SET @CurrentCommandOutput01 = @Error
        IF @CurrentCommandOutput01 <> 0 SET @RETURNCode = @CurrentCommandOutput01
      END

      -- Check filegroups
      IF EXISTS(SELECT * FROM @SelectedCheckCommands WHERE CheckCommand = 'CHECKFILEGROUP') AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SET @CurrentCommand02 = 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; SELECT data_space_id AS FileGroupID, name AS FileGroupName, 0 AS [Order], 0 AS Selected, 0 AS Completed FROM ' + QUOTENAME(@CurrentDatabaseName) + '.sys.filegroups filegroups WHERE [type] <> ''FX'' ORDER BY CASE WHEN filegroups.name = ''PRIMARY'' THEN 1 ELSE 0 END DESC, filegroups.name ASC'

        INSERT INTO @tmpFileGroups (FileGroupID, FileGroupName, [Order], Selected, Completed)
        EXECUTE sp_executesql @statement = @CurrentCommand02
        SET @Error = @@ERROR
        IF @Error <> 0 SET @RETURNCode = @Error

        IF @FileGroups IS NULL
        BEGIN
          UPDATE tmpFileGroups
          SET tmpFileGroups.Selected = 1
          FROM @tmpFileGroups tmpFileGroups
        END
        ELSE
        BEGIN
          UPDATE tmpFileGroups
          SET tmpFileGroups.Selected = SelectedFileGroups.Selected
          FROM @tmpFileGroups tmpFileGroups
          INNER JOIN @SelectedFileGroups SelectedFileGroups
          ON @CurrentDatabaseName LIKE REPLACE(SelectedFileGroups.DatabaseName,'_','[_]') AND tmpFileGroups.FileGroupName LIKE REPLACE(SelectedFileGroups.FileGroupName,'_','[_]')
          WHERE SelectedFileGroups.Selected = 1

          UPDATE tmpFileGroups
          SET tmpFileGroups.Selected = SelectedFileGroups.Selected
          FROM @tmpFileGroups tmpFileGroups
          INNER JOIN @SelectedFileGroups SelectedFileGroups
          ON @CurrentDatabaseName LIKE REPLACE(SelectedFileGroups.DatabaseName,'_','[_]') AND tmpFileGroups.FileGroupName LIKE REPLACE(SelectedFileGroups.FileGroupName,'_','[_]')
          WHERE SelectedFileGroups.Selected = 0

          UPDATE tmpFileGroups
          SET tmpFileGroups.StartPosition = SelectedFileGroups2.StartPosition
          FROM @tmpFileGroups tmpFileGroups
          INNER JOIN (SELECT tmpFileGroups.FileGroupName, MIN(SelectedFileGroups.StartPosition) AS StartPosition
                      FROM @tmpFileGroups tmpFileGroups
                      INNER JOIN @SelectedFileGroups SelectedFileGroups
                      ON @CurrentDatabaseName LIKE REPLACE(SelectedFileGroups.DatabaseName,'_','[_]') AND tmpFileGroups.FileGroupName LIKE REPLACE(SelectedFileGroups.FileGroupName,'_','[_]')
                      WHERE SelectedFileGroups.Selected = 1
                      GROUP BY tmpFileGroups.FileGroupName) SelectedFileGroups2
          ON tmpFileGroups.FileGroupName = SelectedFileGroups2.FileGroupName
        END;

        WITH tmpFileGroups AS (
        SELECT FileGroupName, [Order], ROW_NUMBER() OVER (ORDER BY StartPosition ASC, FileGroupName ASC) AS RowNumber
        FROM @tmpFileGroups tmpFileGroups
        WHERE Selected = 1
        )
        UPDATE tmpFileGroups
        SET [Order] = RowNumber

        SET @ErrorMessage = ''
        SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + '.' + QUOTENAME(FileGroupName) + ', '
        FROM @SelectedFileGroups SelectedFileGroups
        WHERE DatabaseName = @CurrentDatabaseName
        AND FileGroupName NOT LIKE '%[%]%'
        AND NOT EXISTS (SELECT * FROM @tmpFileGroups WHERE FileGroupName = SelectedFileGroups.FileGroupName)
        IF @@ROWCOUNT > 0
        BEGIN
          SET @ErrorMessage = 'The following file groups do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
          RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
          SET @Error = @@ERROR
        END

        WHILE (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
        BEGIN
          SELECT TOP 1 @CurrentFGID = ID,
                       @CurrentFileGroupID = FileGroupID,
                       @CurrentFileGroupName = FileGroupName
          FROM @tmpFileGroups
          WHERE Selected = 1
          AND Completed = 0
          ORDER BY [Order] ASC

          IF @@ROWCOUNT = 0
          BEGIN
            BREAK
          END

          -- Does the filegroup exist?
          SET @CurrentCommand03 = ''
          IF @LockTimeout IS NOT NULL SET @CurrentCommand03 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand03 = @CurrentCommand03 + 'IF EXISTS(SELECT * FROM ' + QUOTENAME(@CurrentDatabaseName) + '.sys.filegroups filegroups WHERE [type] <> ''FX'' AND filegroups.data_space_id = @ParamFileGroupID AND filegroups.[name] = @ParamFileGroupName) BEGIN SET @ParamFileGroupExists = 1 END'

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand03, @params = N'@ParamFileGroupID int, @ParamFileGroupName sysname, @ParamFileGroupExists bit OUTPUT', @ParamFileGroupID = @CurrentFileGroupID, @ParamFileGroupName = @CurrentFileGroupName, @ParamFileGroupExists = @CurrentFileGroupExists OUTPUT

            IF @CurrentFileGroupExists IS NULL SET @CurrentFileGroupExists = 0
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ', ' + ' The file group ' + QUOTENAME(@CurrentFileGroupName) + ' in the database ' + QUOTENAME(@CurrentDatabaseName) + ' is locked. It could not be checked if the filegroup exists.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @RETURNCode = ERROR_NUMBER()
            END
          END CATCH

          IF @CurrentFileGroupExists = 1
          BEGIN
            SET @CurrentCommandType04 = 'DBCC_CHECKFILEGROUP'

            SET @CurrentCommand04 = ''
            IF @LockTimeout IS NOT NULL SET @CurrentCommand04 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
            SET @CurrentCommand04 = @CurrentCommand04 + 'USE ' + QUOTENAME(@CurrentDatabaseName) + '; DBCC CHECKFILEGROUP (' + QUOTENAME(@CurrentFileGroupName)
            IF @NoIndex = 'Y' SET @CurrentCommand04 = @CurrentCommand04 + ', NOINDEX'
            SET @CurrentCommand04 = @CurrentCommand04 + ') WITH NO_INFOMSGS, ALL_ERRORMSGS'
            IF @PhysicalOnly = 'Y' SET @CurrentCommand04 = @CurrentCommand04 + ', PHYSICAL_ONLY'
            IF @TabLock = 'Y' SET @CurrentCommand04 = @CurrentCommand04 + ', TABLOCK'
            IF @MaxDOP IS NOT NULL SET @CurrentCommand04 = @CurrentCommand04 + ', MAXDOP = ' + CAST(@MaxDOP AS nvarchar)

            EXECUTE @CurrentCommandOutput04 = [dbo].[CommandExecute] @Command = @CurrentCommand04, @CommandType = @CurrentCommandType04, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
            SET @Error = @@ERROR
            IF @Error <> 0 SET @CurrentCommandOutput04 = @Error
            IF @CurrentCommandOutput04 <> 0 SET @RETURNCode = @CurrentCommandOutput04
          END

          UPDATE @tmpFileGroups
          SET Completed = 1
          WHERE Selected = 1
          AND Completed = 0
          AND ID = @CurrentFGID

          SET @CurrentFGID = NULL
          SET @CurrentFileGroupID = NULL
          SET @CurrentFileGroupName = NULL
          SET @CurrentFileGroupExists = NULL

          SET @CurrentCommand03 = NULL
          SET @CurrentCommand04 = NULL

          SET @CurrentCommandOutput04 = NULL

          SET @CurrentCommandType04 = NULL
        END
      END

      -- Check disk space allocation structures
      IF EXISTS(SELECT * FROM @SelectedCheckCommands WHERE CheckCommand = 'CHECKALLOC') AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SET @CurrentCommandType05 = 'DBCC_CHECKALLOC'

        SET @CurrentCommand05 = ''
        IF @LockTimeout IS NOT NULL SET @CurrentCommand05 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
        SET @CurrentCommand05 = @CurrentCommand05 + 'DBCC CHECKALLOC (' + QUOTENAME(@CurrentDatabaseName)
        SET @CurrentCommand05 = @CurrentCommand05 + ') WITH NO_INFOMSGS, ALL_ERRORMSGS'
        IF @TabLock = 'Y' SET @CurrentCommand05 = @CurrentCommand05 + ', TABLOCK'

        EXECUTE @CurrentCommandOutput05 = [dbo].[CommandExecute] @Command = @CurrentCommand05, @CommandType = @CurrentCommandType05, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
        SET @Error = @@ERROR
        IF @Error <> 0 SET @CurrentCommandOutput05 = @Error
        IF @CurrentCommandOutput05 <> 0 SET @RETURNCode = @CurrentCommandOutput05
      END

      -- Check objects
      IF EXISTS(SELECT * FROM @SelectedCheckCommands WHERE CheckCommand = 'CHECKTABLE') AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SET @CurrentCommand06 = 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; SELECT schemas.[schema_id] AS SchemaID, schemas.[name] AS SchemaName, objects.[object_id] AS ObjectID, objects.[name] AS ObjectName, RTRIM(objects.[type]) AS ObjectType, 0 AS [Order], 0 AS Selected, 0 AS Completed FROM ' + QUOTENAME(@CurrentDatabaseName) + '.sys.objects objects INNER JOIN ' + QUOTENAME(@CurrentDatabaseName) + '.sys.schemas schemas ON objects.schema_id = schemas.schema_id LEFT OUTER JOIN ' + QUOTENAME(@CurrentDatabaseName) + '.sys.tables tables ON objects.object_id = tables.object_id WHERE objects.[type] IN(''U'',''V'') AND EXISTS(SELECT * FROM ' + QUOTENAME(@CurrentDatabaseName) + '.sys.indexes indexes WHERE indexes.object_id = objects.object_id)' + CASE WHEN @Version >= 12 THEN ' AND (tables.is_memory_optimized = 0 OR is_memory_optimized IS NULL)' ELSE '' END + ' ORDER BY schemas.name ASC, objects.name ASC'

        INSERT INTO @tmpObjects (SchemaID, SchemaName, ObjectID, ObjectName, ObjectType, [Order], Selected, Completed)
        EXECUTE sp_executesql @statement = @CurrentCommand06
        SET @Error = @@ERROR
        IF @Error <> 0 SET @RETURNCode = @Error

        IF @Objects IS NULL
        BEGIN
          UPDATE tmpObjects
          SET tmpObjects.Selected = 1
          FROM @tmpObjects tmpObjects
        END
        ELSE
        BEGIN
          UPDATE tmpObjects
          SET tmpObjects.Selected = SelectedObjects.Selected
          FROM @tmpObjects tmpObjects
          INNER JOIN @SelectedObjects SelectedObjects
          ON @CurrentDatabaseName LIKE REPLACE(SelectedObjects.DatabaseName,'_','[_]') AND tmpObjects.SchemaName LIKE REPLACE(SelectedObjects.SchemaName,'_','[_]') AND tmpObjects.ObjectName LIKE REPLACE(SelectedObjects.ObjectName,'_','[_]')
          WHERE SelectedObjects.Selected = 1

          UPDATE tmpObjects
          SET tmpObjects.Selected = SelectedObjects.Selected
          FROM @tmpObjects tmpObjects
          INNER JOIN @SelectedObjects SelectedObjects
          ON @CurrentDatabaseName LIKE REPLACE(SelectedObjects.DatabaseName,'_','[_]') AND tmpObjects.SchemaName LIKE REPLACE(SelectedObjects.SchemaName,'_','[_]') AND tmpObjects.ObjectName LIKE REPLACE(SelectedObjects.ObjectName,'_','[_]')
          WHERE SelectedObjects.Selected = 0

          UPDATE tmpObjects
          SET tmpObjects.StartPosition = SelectedObjects2.StartPosition
          FROM @tmpObjects tmpObjects
          INNER JOIN (SELECT tmpObjects.SchemaName, tmpObjects.ObjectName, MIN(SelectedObjects.StartPosition) AS StartPosition
                      FROM @tmpObjects tmpObjects
                      INNER JOIN @SelectedObjects SelectedObjects
                      ON @CurrentDatabaseName LIKE REPLACE(SelectedObjects.DatabaseName,'_','[_]') AND tmpObjects.SchemaName LIKE REPLACE(SelectedObjects.SchemaName,'_','[_]') AND tmpObjects.ObjectName LIKE REPLACE(SelectedObjects.ObjectName,'_','[_]')
                      WHERE SelectedObjects.Selected = 1
                      GROUP BY tmpObjects.SchemaName, tmpObjects.ObjectName) SelectedObjects2
          ON tmpObjects.SchemaName = SelectedObjects2.SchemaName AND tmpObjects.ObjectName = SelectedObjects2.ObjectName
        END;

        WITH tmpObjects AS (
        SELECT SchemaName, ObjectName, [Order], ROW_NUMBER() OVER (ORDER BY StartPosition ASC, SchemaName ASC, ObjectName ASC) AS RowNumber
        FROM @tmpObjects tmpObjects
        WHERE Selected = 1
        )
        UPDATE tmpObjects
        SET [Order] = RowNumber

        SET @ErrorMessage = ''
        SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + '.' + QUOTENAME(SchemaName) + '.' + QUOTENAME(ObjectName) + ', '
        FROM @SelectedObjects SelectedObjects
        WHERE DatabaseName = @CurrentDatabaseName
        AND SchemaName NOT LIKE '%[%]%'
        AND ObjectName NOT LIKE '%[%]%'
        AND NOT EXISTS (SELECT * FROM @tmpObjects WHERE SchemaName = SelectedObjects.SchemaName AND ObjectName = SelectedObjects.ObjectName)
        IF @@ROWCOUNT > 0
        BEGIN
          SET @ErrorMessage = 'The following objects do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
          RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
          SET @Error = @@ERROR
        END

        WHILE (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
        BEGIN
          SELECT TOP 1 @CurrentOID = ID,
                       @CurrentSchemaID = SchemaID,
                       @CurrentSchemaName = SchemaName,
                       @CurrentObjectID = ObjectID,
                       @CurrentObjectName = ObjectName,
                       @CurrentObjectType = ObjectType
          FROM @tmpObjects
          WHERE Selected = 1
          AND Completed = 0
          ORDER BY [Order] ASC

          IF @@ROWCOUNT = 0
          BEGIN
            BREAK
          END

          -- Does the object exist?
          SET @CurrentCommand07 = ''
          IF @LockTimeout IS NOT NULL SET @CurrentCommand07 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand07 = @CurrentCommand07 + 'IF EXISTS(SELECT * FROM ' + QUOTENAME(@CurrentDatabaseName) + '.sys.objects objects INNER JOIN ' + QUOTENAME(@CurrentDatabaseName) + '.sys.schemas schemas ON objects.schema_id = schemas.schema_id LEFT OUTER JOIN ' + QUOTENAME(@CurrentDatabaseName) + '.sys.tables tables ON objects.object_id = tables.object_id WHERE objects.[type] IN(''U'',''V'') AND EXISTS(SELECT * FROM ' + QUOTENAME(@CurrentDatabaseName) + '.sys.indexes indexes WHERE indexes.object_id = objects.object_id)' + CASE WHEN @Version >= 12 THEN ' AND (tables.is_memory_optimized = 0 OR is_memory_optimized IS NULL)' ELSE '' END + ' AND schemas.[schema_id] = @ParamSchemaID AND schemas.[name] = @ParamSchemaName AND objects.[object_id] = @ParamObjectID AND objects.[name] = @ParamObjectName AND objects.[type] = @ParamObjectType) BEGIN SET @ParamObjectExists = 1 END'

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand07, @params = N'@ParamSchemaID int, @ParamSchemaName sysname, @ParamObjectID int, @ParamObjectName sysname, @ParamObjectType sysname, @ParamObjectExists bit OUTPUT', @ParamSchemaID = @CurrentSchemaID, @ParamSchemaName = @CurrentSchemaName, @ParamObjectID = @CurrentObjectID, @ParamObjectName = @CurrentObjectName, @ParamObjectType = @CurrentObjectType, @ParamObjectExists = @CurrentObjectExists OUTPUT

            IF @CurrentObjectExists IS NULL SET @CurrentObjectExists = 0
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ', ' + 'The object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. It could not be checked if the object exists.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @RETURNCode = ERROR_NUMBER()
            END
          END CATCH

          IF @CurrentObjectExists = 1
          BEGIN
            SET @CurrentCommandType08 = 'DBCC_CHECKTABLE'

            SET @CurrentCommand08 = ''
            IF @LockTimeout IS NOT NULL SET @CurrentCommand08 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
            SET @CurrentCommand08 = @CurrentCommand08 + 'USE ' + QUOTENAME(@CurrentDatabaseName) + '; DBCC CHECKTABLE (''' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ''''
            IF @NoIndex = 'Y' SET @CurrentCommand08 = @CurrentCommand08 + ', NOINDEX'
            SET @CurrentCommand08 = @CurrentCommand08 + ') WITH NO_INFOMSGS, ALL_ERRORMSGS'
            IF @PhysicalOnly = 'N' SET @CurrentCommand08 = @CurrentCommand08 + ', DATA_PURITY'
            IF @PhysicalOnly = 'Y' SET @CurrentCommand08 = @CurrentCommand08 + ', PHYSICAL_ONLY'
            IF @ExtENDedLogicalChecks = 'Y' SET @CurrentCommand08 = @CurrentCommand08 + ', EXTENDED_LOGICAL_CHECKS'
            IF @TabLock = 'Y' SET @CurrentCommand08 = @CurrentCommand08 + ', TABLOCK'
            IF @MaxDOP IS NOT NULL SET @CurrentCommand08 = @CurrentCommand08 + ', MAXDOP = ' + CAST(@MaxDOP AS nvarchar)

            EXECUTE @CurrentCommandOutput08 = [dbo].[CommandExecute] @Command = @CurrentCommand08, @CommandType = @CurrentCommandType08, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @SchemaName = @CurrentSchemaName, @ObjectName = @CurrentObjectName, @ObjectType = @CurrentObjectType, @LogToTable = @LogToTable, @Execute = @Execute
            SET @Error = @@ERROR
            IF @Error <> 0 SET @CurrentCommandOutput08 = @Error
            IF @CurrentCommandOutput08 <> 0 SET @RETURNCode = @CurrentCommandOutput08
          END

          UPDATE @tmpObjects
          SET Completed = 1
          WHERE Selected = 1
          AND Completed = 0
          AND ID = @CurrentOID

          SET @CurrentOID = NULL
          SET @CurrentSchemaID = NULL
          SET @CurrentSchemaName = NULL
          SET @CurrentObjectID = NULL
          SET @CurrentObjectName = NULL
          SET @CurrentObjectType = NULL
          SET @CurrentObjectExists = NULL

          SET @CurrentCommand07 = NULL
          SET @CurrentCommand08 = NULL

          SET @CurrentCommandOutput08 = NULL

          SET @CurrentCommandType08 = NULL
        END
      END

      -- Check catalog
      IF EXISTS(SELECT * FROM @SelectedCheckCommands WHERE CheckCommand = 'CHECKCATALOG') AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SET @CurrentCommandType09 = 'DBCC_CHECKCATALOG'

        SET @CurrentCommand09 = ''
        IF @LockTimeout IS NOT NULL SET @CurrentCommand09 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
        SET @CurrentCommand09 = @CurrentCommand09 + 'DBCC CHECKCATALOG (' + QUOTENAME(@CurrentDatabaseName)
        SET @CurrentCommand09 = @CurrentCommand09 + ') WITH NO_INFOMSGS'

        EXECUTE @CurrentCommandOutput09 = [dbo].[CommandExecute] @Command = @CurrentCommand09, @CommandType = @CurrentCommandType09, @Mode = 1, @DatabaseName = @CurrentDatabaseName, @LogToTable = @LogToTable, @Execute = @Execute
        SET @Error = @@ERROR
        IF @Error <> 0 SET @CurrentCommandOutput09 = @Error
        IF @CurrentCommandOutput09 <> 0 SET @RETURNCode = @CurrentCommandOutput09
      END

    END

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'SUSPECT'
    BEGIN
      SET @ErrorMessage = 'The database ' + QUOTENAME(@CurrentDatabaseName) + ' is in a SUSPECT state.' + CHAR(13) + CHAR(10) + ' '
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
      SET @Error = @@ERROR
    END

    -- Update that the database is completed
    IF @DatabasesInParallel = 'Y'
    BEGIN
      UPDATE dbo.QueueDatabase
      SET DatabaseENDTime = GETDATE()
      WHERE QueueID = @QueueID
      AND DatabaseName = @CurrentDatabaseName
    END
    ELSE
    BEGIN
      UPDATE @tmpDatabases
      SET Completed = 1
      WHERE Selected = 1
      AND Completed = 0
      AND ID = @CurrentDBID
    END

    -- Clear variables
    SET @CurrentDBID = NULL
    SET @CurrentDatabaseID = NULL
    SET @CurrentDatabaseName = NULL
    SET @CurrentIsDatabaseAccessible = NULL
    SET @CurrentAvailabilityGroup = NULL
    SET @CurrentAvailabilityGroupRole = NULL
    SET @CurrentAvailabilityGroupBackupPreference = NULL
    SET @CurrentIsPreferredBackupReplica = NULL
    SET @CurrentDatabaseMirroringRole = NULL
    SET @CurrentIsReadOnly = NULL

    SET @CurrentCommand01 = NULL
    SET @CurrentCommand02 = NULL
    SET @CurrentCommand05 = NULL
    SET @CurrentCommand06 = NULL
    SET @CurrentCommand09 = NULL

    SET @CurrentCommandOutput01 = NULL
    SET @CurrentCommandOutput05 = NULL
    SET @CurrentCommandOutput09 = NULL

    SET @CurrentCommandType01 = NULL
    SET @CurrentCommandType05 = NULL
    SET @CurrentCommandType09 = NULL

    DELETE FROM @tmpFileGroups
    DELETE FROM @tmpObjects

  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  Logging:
  SET @ENDMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
  SET @ENDMessage = REPLACE(@ENDMessage,'%','%%')
  RAISERROR(@ENDMessage,10,1) WITH NOWAIT

  IF @RETURNCode <> 0
  BEGIN
    RETURN @RETURNCode
  END

  ----------------------------------------------------------------------------------------------------

END














GO
/****** Object:  StoredProcedure [dbo].[IndexOptimize]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IndexOptimize]

@Databases nvarchar(max) = NULL,
@FragmentationLow nvarchar(max) = NULL,
@FragmentationMedium nvarchar(max) = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh nvarchar(max) = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel1 int = 5,
@FragmentationLevel2 int = 30,
@MinNumberOfPages int = 1000,
@MaxNumberOfPages int = NULL,
@SortInTempdb nvarchar(max) = 'N',
@MaxDOP int = NULL,
@FillFactor int = NULL,
@PadIndex nvarchar(max) = NULL,
@LOBCompaction nvarchar(max) = 'Y',
@UpdateStatistics nvarchar(max) = NULL,
@OnlyModifiedStatistics nvarchar(max) = 'N',
@StatisticsModificationLevel int = NULL,
@StatisticsSample int = NULL,
@StatisticsResample nvarchar(max) = 'N',
@PartitionLevel nvarchar(max) = 'Y',
@MSShippedObjects nvarchar(max) = 'N',
@Indexes nvarchar(max) = NULL,
@TimeLimit int = NULL,
@Delay int = NULL,
@WaitAtLowPriorityMaxDuration int = NULL,
@WaitAtLowPriorityAbortAfterWait nvarchar(max) = NULL,
@Resumable nvarchar(max) = 'N',
@AvailabilityGroups nvarchar(max) = NULL,
@LockTimeout int = NULL,
@LockMessageSeverity int = 16,
@DatabaseOrder nvarchar(max) = NULL,
@DatabasesInParallel nvarchar(max) = 'N',
@LogToTable nvarchar(max) = 'N',
@Execute nvarchar(max) = 'Y'

AS

BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ================================================================================================================================================================
	--
	-- ================================================================================================================================================================

  ----------------------------------------------------------------------------------------------------
  --// Source:  https://ola.hallengren.com                                                        //--
  --// License: https://ola.hallengren.com/license.html                                           //--
  --// GitHub:  https://github.com/olahallengren/sql-server-maintenance-solution                  //--
  --// Version: 2018-07-16 18:32:21                                                               //--
  ----------------------------------------------------------------------------------------------------

  SET NOCOUNT ON

  SET ARITHABORT ON

  SET NUMERIC_ROUNDABORT OFF

  DECLARE @StartMessage nvarchar(max)
  DECLARE @ENDMessage nvarchar(max)
  DECLARE @DatabaseMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)
  DECLARE @Severity int

  DECLARE @StartTime datetime
  DECLARE @SchemaName nvarchar(max)
  DECLARE @ObjectName nvarchar(max)
  DECLARE @VersionTimestamp nvarchar(max)
  DECLARE @Parameters nvarchar(max)

  DECLARE @Version numeric(18,10)
  DECLARE @HostPlatform nvarchar(max)
  DECLARE @AmazonRDS bit

  DECLARE @PartitionLevelStatistics bit

  DECLARE @QueueID int
  DECLARE @QueueStartTime datetime

  DECLARE @CurrentDBID int
  DECLARE @CurrentDatabaseID int
  DECLARE @CurrentDatabaseName nvarchar(max)
  DECLARE @CurrentIsDatabaseAccessible bit
  DECLARE @CurrentAvailabilityGroup nvarchar(max)
  DECLARE @CurrentAvailabilityGroupRole nvarchar(max)
  DECLARE @CurrentDatabaseMirroringRole nvarchar(max)
  DECLARE @CurrentIsReadOnly bit

  DECLARE @CurrentCommand01 nvarchar(max)
  DECLARE @CurrentCommand02 nvarchar(max)
  DECLARE @CurrentCommand03 nvarchar(max)
  DECLARE @CurrentCommand04 nvarchar(max)
  DECLARE @CurrentCommand05 nvarchar(max)
  DECLARE @CurrentCommand06 nvarchar(max)
  DECLARE @CurrentCommand07 nvarchar(max)

  DECLARE @CurrentCommandOutput06 int
  DECLARE @CurrentCommandOutput07 int

  DECLARE @CurrentCommandType06 nvarchar(max)
  DECLARE @CurrentCommandType07 nvarchar(max)

  DECLARE @CurrentComment06 nvarchar(max)
  DECLARE @CurrentComment07 nvarchar(max)

  DECLARE @CurrentExtENDedInfo06 xml
  DECLARE @CurrentExtENDedInfo07 xml

  DECLARE @CurrentIxID int
  DECLARE @CurrentSchemaID int
  DECLARE @CurrentSchemaName nvarchar(max)
  DECLARE @CurrentObjectID int
  DECLARE @CurrentObjectName nvarchar(max)
  DECLARE @CurrentObjectType nvarchar(max)
  DECLARE @CurrentIsMemoryOptimized bit
  DECLARE @CurrentIndexID int
  DECLARE @CurrentIndexName nvarchar(max)
  DECLARE @CurrentIndexType int
  DECLARE @CurrentStatisticsID int
  DECLARE @CurrentStatisticsName nvarchar(max)
  DECLARE @CurrentPartitionID bigint
  DECLARE @CurrentPartitionNumber int
  DECLARE @CurrentPartitionCount int
  DECLARE @CurrentIsPartition bit
  DECLARE @CurrentIndexExists bit
  DECLARE @CurrentStatisticsExists bit
  DECLARE @CurrentIsImageText bit
  DECLARE @CurrentIsNewLOB bit
  DECLARE @CurrentIsFileStream bit
  DECLARE @CurrentIsColumnStore bit
  DECLARE @CurrentIsComputed bit
  DECLARE @CurrentIsTimestamp bit
  DECLARE @CurrentAllowPageLocks bit
  DECLARE @CurrentNoRecompute bit
  DECLARE @CurrentIsIncremental bit
  DECLARE @CurrentRowCount bigint
  DECLARE @CurrentModificationCounter bigint
  DECLARE @CurrentOnReadOnlyFileGroup bit
  DECLARE @CurrentResumableIndexOperation bit
  DECLARE @CurrentFragmentationLevel float
  DECLARE @CurrentPageCount bigint
  DECLARE @CurrentFragmentationGroup nvarchar(max)
  DECLARE @CurrentAction nvarchar(max)
  DECLARE @CurrentMaxDOP int
  DECLARE @CurrentUpdateStatistics nvarchar(max)
  DECLARE @CurrentStatisticsSample int
  DECLARE @CurrentStatisticsResample nvarchar(max)
  DECLARE @CurrentDelay datetime

  DECLARE @tmpDatabases TABLE (ID int IDENTITY,
                               DatabaseName nvarchar(max),
                               DatabaseType nvarchar(max),
                               AvailabilityGroup bit,
                               StartPosition int,
                               DatabaseSize bigint,
                               [Order] int,
                               Selected bit,
                               Completed bit,
                               PRIMARY KEY(Selected, Completed, [Order], ID))

  DECLARE @tmpAvailabilityGroups TABLE (ID int IDENTITY PRIMARY KEY,
                                        AvailabilityGroupName nvarchar(max),
                                        StartPosition int,
                                        Selected bit)

  DECLARE @tmpDatabasesAvailabilityGroups TABLE (DatabaseName nvarchar(max),
                                                 AvailabilityGroupName nvarchar(max))

  DECLARE @tmpIndexesStatistics TABLE (ID int IDENTITY,
                                       SchemaID int,
                                       SchemaName nvarchar(max),
                                       ObjectID int,
                                       ObjectName nvarchar(max),
                                       ObjectType nvarchar(max),
                                       IsMemoryOptimized bit,
                                       IndexID int,
                                       IndexName nvarchar(max),
                                       IndexType int,
                                       AllowPageLocks bit,
                                       IsImageText bit,
                                       IsNewLOB bit,
                                       IsFileStream bit,
                                       IsColumnStore bit,
                                       IsComputed bit,
                                       IsTimestamp bit,
                                       OnReadOnlyFileGroup bit,
                                       ResumableIndexOperation bit,
                                       StatisticsID int,
                                       StatisticsName nvarchar(max),
                                       [NoRecompute] bit,
                                       IsIncremental bit,
                                       PartitionID bigint,
                                       PartitionNumber int,
                                       PartitionCount int,
                                       StartPosition int,
                                       [Order] int,
                                       Selected bit,
                                       Completed bit,
                                       PRIMARY KEY(Selected, Completed, [Order], ID))

  DECLARE @SelectedDatabases TABLE (DatabaseName nvarchar(max),
                                    DatabaseType nvarchar(max),
                                    AvailabilityGroup nvarchar(max),
                                    StartPosition int,
                                    Selected bit)

  DECLARE @SelectedAvailabilityGroups TABLE (AvailabilityGroupName nvarchar(max),
                                             StartPosition int,
                                             Selected bit)

  DECLARE @SelectedIndexes TABLE (DatabaseName nvarchar(max),
                                  SchemaName nvarchar(max),
                                  ObjectName nvarchar(max),
                                  IndexName nvarchar(max),
                                  StartPosition int,
                                  Selected bit)

  DECLARE @Actions TABLE ([Action] nvarchar(max))

  INSERT INTO @Actions([Action]) VALUES('INDEX_REBUILD_ONLINE')
  INSERT INTO @Actions([Action]) VALUES('INDEX_REBUILD_OFFLINE')
  INSERT INTO @Actions([Action]) VALUES('INDEX_REORGANIZE')

  DECLARE @ActionsPreferred TABLE (FragmentationGroup nvarchar(max),
                                   [Priority] int,
                                   [Action] nvarchar(max))

  DECLARE @CurrentActionsAllowed TABLE ([Action] nvarchar(max))


  DECLARE @CurrentAlterIndexWithClauseArguments TABLE (ID int IDENTITY,
                                                       Argument nvarchar(max))

  DECLARE @CurrentAlterIndexWithClause nvarchar(max)

  DECLARE @CurrentUpdateStatisticsWithClauseArguments TABLE (ID int IDENTITY,
                                                             Argument nvarchar(max))

  DECLARE @CurrentUpdateStatisticsWithClause nvarchar(max)

  DECLARE @Error int
  DECLARE @RETURNCode int

  SET @Error = 0
  SET @RETURNCode = 0

  SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

  IF @Version >= 14
  BEGIN
    SELECT @HostPlatform = host_platform
    FROM sys.dm_os_host_info
  END
  ELSE
  BEGIN
    SET @HostPlatform = 'Windows'
  END

  SET @AmazonRDS = CASE WHEN DB_ID('rdsadmin') IS NOT NULL AND SUSER_SNAME(0x01) = 'rdsa' THEN 1 ELSE 0 END

  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartTime = GETDATE()
  SET @SchemaName = (SELECT schemas.name FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID)
  SET @ObjectName = OBJECT_NAME(@@PROCID)
  SET @VersionTimestamp = SUBSTRING(OBJECT_DEFINITION(@@PROCID),CHARINDEX('--// Version: ',OBJECT_DEFINITION(@@PROCID)) + LEN('--// Version: ') + 1, 19)

  SET @Parameters = '@Databases = ' + ISNULL('''' + REPLACE(@Databases,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FragmentationLow = ' + ISNULL('''' + REPLACE(@FragmentationLow,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FragmentationMedium = ' + ISNULL('''' + REPLACE(@FragmentationMedium,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FragmentationHigh = ' + ISNULL('''' + REPLACE(@FragmentationHigh,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @FragmentationLevel1 = ' + ISNULL(CAST(@FragmentationLevel1 AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @FragmentationLevel2 = ' + ISNULL(CAST(@FragmentationLevel2 AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @MinNumberOfPages = ' + ISNULL(CAST(@MinNumberOfPages AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @MaxNumberOfPages = ' + ISNULL(CAST(@MaxNumberOfPages AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @SortInTempdb = ' + ISNULL('''' + REPLACE(@SortInTempdb,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @MaxDOP = ' + ISNULL(CAST(@MaxDOP AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @FillFactor = ' + ISNULL(CAST(@FillFactor AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @PadIndex = ' + ISNULL('''' + REPLACE(@PadIndex,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @LOBCompaction = ' + ISNULL('''' + REPLACE(@LOBCompaction,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @UpdateStatistics = ' + ISNULL('''' + REPLACE(@UpdateStatistics,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @OnlyModifiedStatistics = ' + ISNULL('''' + REPLACE(@OnlyModifiedStatistics,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @StatisticsModificationLevel = ' + ISNULL(CAST(@StatisticsModificationLevel AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @StatisticsSample = ' + ISNULL(CAST(@StatisticsSample AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @StatisticsResample = ' + ISNULL('''' + REPLACE(@StatisticsResample,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @PartitionLevel = ' + ISNULL('''' + REPLACE(@PartitionLevel,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @MSShippedObjects = ' + ISNULL('''' + REPLACE(@MSShippedObjects,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Indexes = ' + ISNULL('''' + REPLACE(@Indexes,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @TimeLimit = ' + ISNULL(CAST(@TimeLimit AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @Delay = ' + ISNULL(CAST(@Delay AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @WaitAtLowPriorityMaxDuration = ' + ISNULL(CAST(@WaitAtLowPriorityMaxDuration AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @WaitAtLowPriorityAbortAfterWait = ' + ISNULL('''' + REPLACE(@WaitAtLowPriorityAbortAfterWait,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Resumable = ' + ISNULL('''' + REPLACE(@Resumable,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @AvailabilityGroups = ' + ISNULL('''' + REPLACE(@AvailabilityGroups,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @LockTimeout = ' + ISNULL(CAST(@LockTimeout AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @LockMessageSeverity = ' + ISNULL(CAST(@LockMessageSeverity AS nvarchar),'NULL')
  SET @Parameters = @Parameters + ', @DatabaseOrder = ' + ISNULL('''' + REPLACE(@DatabaseOrder,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @DatabasesInParallel = ' + ISNULL('''' + REPLACE(@DatabasesInParallel,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @LogToTable = ' + ISNULL('''' + REPLACE(@LogToTable,'''','''''') + '''','NULL')
  SET @Parameters = @Parameters + ', @Execute = ' + ISNULL('''' + REPLACE(@Execute,'''','''''') + '''','NULL')

  SET @StartMessage = 'Date and time: ' + CONVERT(nvarchar,@StartTime,120)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar(max))
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Platform: ' + @HostPlatform
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Procedure: ' + QUOTENAME(DB_NAME(DB_ID())) + '.' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@ObjectName)
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Parameters: ' + @Parameters
  SET @StartMessage = REPLACE(@StartMessage,'%','%%')
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Version: ' + @VersionTimestamp
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  SET @StartMessage = 'Source: https://ola.hallengren.com' + CHAR(13) + CHAR(10) + ' '
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  ----------------------------------------------------------------------------------------------------
  --// Check core requirements                                                                    //--
  ----------------------------------------------------------------------------------------------------

  IF NOT (SELECT [compatibility_level] FROM sys.databases WHERE database_id = DB_ID()) >= 90
  BEGIN
    SET @ErrorMessage = 'The database ' + QUOTENAME(DB_NAME(DB_ID())) + ' has to be in compatibility level 90 or higher.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_ansi_nulls FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'ANSI_NULLS has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT (SELECT uses_quoted_identifier FROM sys.sql_modules WHERE [object_id] = @@PROCID) = 1
  BEGIN
    SET @ErrorMessage = 'QUOTED_IDENTIFIER has to be set to ON for the stored procedure.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute is missing. Download https://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'P' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandExecute' AND OBJECT_DEFINITION(objects.[object_id]) NOT LIKE '%@LockMessageSeverity%')
  BEGIN
    SET @ErrorMessage = 'The stored procedure CommandExecute needs to be updated. Download https://ola.hallengren.com/scripts/CommandExecute.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'CommandLog')
  BEGIN
    SET @ErrorMessage = 'The table CommandLog is missing. Download https://ola.hallengren.com/scripts/CommandLog.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'Queue')
  BEGIN
    SET @ErrorMessage = 'The table Queue is missing. Download https://ola.hallengren.com/scripts/Queue.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel = 'Y' AND NOT EXISTS (SELECT * FROM sys.objects objects INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] = 'U' AND schemas.[name] = 'dbo' AND objects.[name] = 'QueueDatabase')
  BEGIN
    SET @ErrorMessage = 'The table QueueDatabase is missing. Download https://ola.hallengren.com/scripts/QueueDatabase.sql.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @@TRANCOUNT <> 0
  BEGIN
    SET @ErrorMessage = 'The transaction count is not 0.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @RETURNCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Select databases                                                                           //--
  ----------------------------------------------------------------------------------------------------

  SET @Databases = REPLACE(@Databases, CHAR(10), '')
  SET @Databases = REPLACE(@Databases, CHAR(13), '')

  WHILE CHARINDEX(', ',@Databases) > 0 SET @Databases = REPLACE(@Databases,', ',',')
  WHILE CHARINDEX(' ,',@Databases) > 0 SET @Databases = REPLACE(@Databases,' ,',',')

  SET @Databases = LTRIM(RTRIM(@Databases));

  WITH Databases1 (StartPosition, ENDPosition, DatabaseItem) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Databases, 1), 0), LEN(@Databases) + 1) AS ENDPosition,
         SUBSTRING(@Databases, 1, ISNULL(NULLIF(CHARINDEX(',', @Databases, 1), 0), LEN(@Databases) + 1) - 1) AS DatabaseItem
  WHERE @Databases IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Databases, ENDPosition + 1), 0), LEN(@Databases) + 1) AS ENDPosition,
         SUBSTRING(@Databases, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Databases, ENDPosition + 1), 0), LEN(@Databases) + 1) - ENDPosition - 1) AS DatabaseItem
  FROM Databases1
  WHERE ENDPosition < LEN(@Databases) + 1
  ),
  Databases2 (DatabaseItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem LIKE '-%' THEN RIGHT(DatabaseItem,LEN(DatabaseItem) - 1) ELSE DatabaseItem END AS DatabaseItem,
         StartPosition,
         CASE WHEN DatabaseItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM Databases1
  ),
  Databases3 (DatabaseItem, DatabaseType, AvailabilityGroup, StartPosition, Selected) AS
  (
  SELECT CASE WHEN DatabaseItem IN('ALL_DATABASES','SYSTEM_DATABASES','USER_DATABASES','AVAILABILITY_GROUP_DATABASES') THEN '%' ELSE DatabaseItem END AS DatabaseItem,
         CASE WHEN DatabaseItem = 'SYSTEM_DATABASES' THEN 'S' WHEN DatabaseItem = 'USER_DATABASES' THEN 'U' ELSE NULL END AS DatabaseType,
         CASE WHEN DatabaseItem = 'AVAILABILITY_GROUP_DATABASES' THEN 1 ELSE NULL END AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases2
  ),
  Databases4 (DatabaseName, DatabaseType, AvailabilityGroup, StartPosition, Selected) AS
  (
  SELECT CASE WHEN LEFT(DatabaseItem,1) = '[' AND RIGHT(DatabaseItem,1) = ']' THEN PARSENAME(DatabaseItem,1) ELSE DatabaseItem END AS DatabaseItem,
         DatabaseType,
         AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases3
  )
  INSERT INTO @SelectedDatabases (DatabaseName, DatabaseType, AvailabilityGroup, StartPosition, Selected)
  SELECT DatabaseName,
         DatabaseType,
         AvailabilityGroup,
         StartPosition,
         Selected
  FROM Databases4
  OPTION (MAXRECURSION 0)

  IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN
    INSERT INTO @tmpAvailabilityGroups (AvailabilityGroupName, Selected)
    SELECT name AS AvailabilityGroupName,
           0 AS Selected
    FROM sys.availability_groups

    INSERT INTO @tmpDatabasesAvailabilityGroups (DatabaseName, AvailabilityGroupName)
    SELECT availability_databases_cluster.database_name, availability_groups.name
    FROM sys.availability_databases_cluster availability_databases_cluster
    INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
  END

  INSERT INTO @tmpDatabases (DatabaseName, DatabaseType, AvailabilityGroup, [Order], Selected, Completed)
  SELECT [name] AS DatabaseName,
         CASE WHEN name IN('master','msdb','model') THEN 'S' ELSE 'U' END AS DatabaseType,
         NULL AS AvailabilityGroup,
         0 AS [Order],
         0 AS Selected,
         0 AS Completed
  FROM sys.databases
  WHERE [name] <> 'tempdb'
  AND source_database_id IS NULL
  ORDER BY [name] ASC

  UPDATE tmpDatabases
  SET AvailabilityGroup = CASE WHEN EXISTS (SELECT * FROM @tmpDatabasesAvailabilityGroups WHERE DatabaseName = tmpDatabases.DatabaseName) THEN 1 ELSE 0 END
  FROM @tmpDatabases tmpDatabases

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
  WHERE SelectedDatabases.Selected = 1

  UPDATE tmpDatabases
  SET tmpDatabases.Selected = SelectedDatabases.Selected
  FROM @tmpDatabases tmpDatabases
  INNER JOIN @SelectedDatabases SelectedDatabases
  ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
  AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
  AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
  WHERE SelectedDatabases.Selected = 0

  UPDATE tmpDatabases
  SET tmpDatabases.StartPosition = SelectedDatabases2.StartPosition
  FROM @tmpDatabases tmpDatabases
  INNER JOIN (SELECT tmpDatabases.DatabaseName, MIN(SelectedDatabases.StartPosition) AS StartPosition
              FROM @tmpDatabases tmpDatabases
              INNER JOIN @SelectedDatabases SelectedDatabases
              ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
              AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
              AND (tmpDatabases.AvailabilityGroup = SelectedDatabases.AvailabilityGroup OR SelectedDatabases.AvailabilityGroup IS NULL)
              WHERE SelectedDatabases.Selected = 1
              GROUP BY tmpDatabases.DatabaseName) SelectedDatabases2
  ON tmpDatabases.DatabaseName = SelectedDatabases2.DatabaseName

  IF @Databases IS NOT NULL AND (NOT EXISTS(SELECT * FROM @SelectedDatabases) OR EXISTS(SELECT * FROM @SelectedDatabases WHERE DatabaseName IS NULL OR DatabaseName = ''))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Databases is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select availability groups                                                                 //--
  ----------------------------------------------------------------------------------------------------

  IF @AvailabilityGroups IS NOT NULL AND @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
  BEGIN

    SET @AvailabilityGroups = REPLACE(@AvailabilityGroups, CHAR(10), '')
    SET @AvailabilityGroups = REPLACE(@AvailabilityGroups, CHAR(13), '')

    WHILE CHARINDEX(', ',@AvailabilityGroups) > 0 SET @AvailabilityGroups = REPLACE(@AvailabilityGroups,', ',',')
    WHILE CHARINDEX(' ,',@AvailabilityGroups) > 0 SET @AvailabilityGroups = REPLACE(@AvailabilityGroups,' ,',',')

    SET @AvailabilityGroups = LTRIM(RTRIM(@AvailabilityGroups));

    WITH AvailabilityGroups1 (StartPosition, ENDPosition, AvailabilityGroupItem) AS
    (
    SELECT 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, 1), 0), LEN(@AvailabilityGroups) + 1) AS ENDPosition,
           SUBSTRING(@AvailabilityGroups, 1, ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, 1), 0), LEN(@AvailabilityGroups) + 1) - 1) AS AvailabilityGroupItem
    WHERE @AvailabilityGroups IS NOT NULL
    UNION ALL
    SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
           ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, ENDPosition + 1), 0), LEN(@AvailabilityGroups) + 1) AS ENDPosition,
           SUBSTRING(@AvailabilityGroups, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @AvailabilityGroups, ENDPosition + 1), 0), LEN(@AvailabilityGroups) + 1) - ENDPosition - 1) AS AvailabilityGroupItem
    FROM AvailabilityGroups1
    WHERE ENDPosition < LEN(@AvailabilityGroups) + 1
    ),
    AvailabilityGroups2 (AvailabilityGroupItem, StartPosition, Selected) AS
    (
    SELECT CASE WHEN AvailabilityGroupItem LIKE '-%' THEN RIGHT(AvailabilityGroupItem,LEN(AvailabilityGroupItem) - 1) ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           CASE WHEN AvailabilityGroupItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
    FROM AvailabilityGroups1
    ),
    AvailabilityGroups3 (AvailabilityGroupItem, StartPosition, Selected) AS
    (
    SELECT CASE WHEN AvailabilityGroupItem = 'ALL_AVAILABILITY_GROUPS' THEN '%' ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           Selected
    FROM AvailabilityGroups2
    ),
    AvailabilityGroups4 (AvailabilityGroupName, StartPosition, Selected) AS
    (
    SELECT CASE WHEN LEFT(AvailabilityGroupItem,1) = '[' AND RIGHT(AvailabilityGroupItem,1) = ']' THEN PARSENAME(AvailabilityGroupItem,1) ELSE AvailabilityGroupItem END AS AvailabilityGroupItem,
           StartPosition,
           Selected
    FROM AvailabilityGroups3
    )
    INSERT INTO @SelectedAvailabilityGroups (AvailabilityGroupName, StartPosition, Selected)
    SELECT AvailabilityGroupName, StartPosition, Selected
    FROM AvailabilityGroups4
    OPTION (MAXRECURSION 0)

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.Selected = SelectedAvailabilityGroups.Selected
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
    ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
    WHERE SelectedAvailabilityGroups.Selected = 1

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.Selected = SelectedAvailabilityGroups.Selected
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
    ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
    WHERE SelectedAvailabilityGroups.Selected = 0

    UPDATE tmpAvailabilityGroups
    SET tmpAvailabilityGroups.StartPosition = SelectedAvailabilityGroups2.StartPosition
    FROM @tmpAvailabilityGroups tmpAvailabilityGroups
    INNER JOIN (SELECT tmpAvailabilityGroups.AvailabilityGroupName, MIN(SelectedAvailabilityGroups.StartPosition) AS StartPosition
                FROM @tmpAvailabilityGroups tmpAvailabilityGroups
                INNER JOIN @SelectedAvailabilityGroups SelectedAvailabilityGroups
                ON tmpAvailabilityGroups.AvailabilityGroupName LIKE REPLACE(SelectedAvailabilityGroups.AvailabilityGroupName,'_','[_]')
                WHERE SelectedAvailabilityGroups.Selected = 1
                GROUP BY tmpAvailabilityGroups.AvailabilityGroupName) SelectedAvailabilityGroups2
    ON tmpAvailabilityGroups.AvailabilityGroupName = SelectedAvailabilityGroups2.AvailabilityGroupName

    UPDATE tmpDatabases
    SET tmpDatabases.StartPosition = tmpAvailabilityGroups.StartPosition,
        tmpDatabases.Selected = 1
    FROM @tmpDatabases tmpDatabases
    INNER JOIN @tmpDatabasesAvailabilityGroups tmpDatabasesAvailabilityGroups ON tmpDatabases.DatabaseName = tmpDatabasesAvailabilityGroups.DatabaseName
    INNER JOIN @tmpAvailabilityGroups tmpAvailabilityGroups ON tmpDatabasesAvailabilityGroups.AvailabilityGroupName = tmpAvailabilityGroups.AvailabilityGroupName
    WHERE tmpAvailabilityGroups.Selected = 1

  END

  IF @AvailabilityGroups IS NOT NULL AND (NOT EXISTS(SELECT * FROM @SelectedAvailabilityGroups) OR EXISTS(SELECT * FROM @SelectedAvailabilityGroups WHERE AvailabilityGroupName IS NULL OR AvailabilityGroupName = '') OR @Version < 11 OR SERVERPROPERTY('IsHadrEnabled') = 0)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @AvailabilityGroups is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Databases IS NULL AND @AvailabilityGroups IS NULL)
  BEGIN
    SET @ErrorMessage = 'You need to specify one of the parameters @Databases and @AvailabilityGroups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF (@Databases IS NOT NULL AND @AvailabilityGroups IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'You can only specify one of the parameters @Databases and @AvailabilityGroups.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Select indexes                                                                             //--
  ----------------------------------------------------------------------------------------------------

  SET @Indexes = REPLACE(@Indexes, CHAR(10), '')
  SET @Indexes = REPLACE(@Indexes, CHAR(13), '')

  WHILE CHARINDEX(', ',@Indexes) > 0 SET @Indexes = REPLACE(@Indexes,', ',',')
  WHILE CHARINDEX(' ,',@Indexes) > 0 SET @Indexes = REPLACE(@Indexes,' ,',',')

  SET @Indexes = LTRIM(RTRIM(@Indexes));

  WITH Indexes1 (StartPosition, ENDPosition, IndexItem) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Indexes, 1), 0), LEN(@Indexes) + 1) AS ENDPosition,
         SUBSTRING(@Indexes, 1, ISNULL(NULLIF(CHARINDEX(',', @Indexes, 1), 0), LEN(@Indexes) + 1) - 1) AS IndexItem
  WHERE @Indexes IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @Indexes, ENDPosition + 1), 0), LEN(@Indexes) + 1) AS ENDPosition,
         SUBSTRING(@Indexes, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Indexes, ENDPosition + 1), 0), LEN(@Indexes) + 1) - ENDPosition - 1) AS IndexItem
  FROM Indexes1
  WHERE ENDPosition < LEN(@Indexes) + 1
  ),
  Indexes2 (IndexItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN IndexItem LIKE '-%' THEN RIGHT(IndexItem,LEN(IndexItem) - 1) ELSE IndexItem END AS IndexItem,
         StartPosition,
         CASE WHEN IndexItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
  FROM Indexes1
  ),
  Indexes3 (IndexItem, StartPosition, Selected) AS
  (
  SELECT CASE WHEN IndexItem = 'ALL_INDEXES' THEN '%.%.%.%' ELSE IndexItem END AS IndexItem,
         StartPosition,
         Selected
  FROM Indexes2
  ),
  Indexes4 (DatabaseName, SchemaName, ObjectName, IndexName, StartPosition, Selected) AS
  (
  SELECT CASE WHEN PARSENAME(IndexItem,4) IS NULL THEN PARSENAME(IndexItem,3) ELSE PARSENAME(IndexItem,4) END AS DatabaseName,
         CASE WHEN PARSENAME(IndexItem,4) IS NULL THEN PARSENAME(IndexItem,2) ELSE PARSENAME(IndexItem,3) END AS SchemaName,
         CASE WHEN PARSENAME(IndexItem,4) IS NULL THEN PARSENAME(IndexItem,1) ELSE PARSENAME(IndexItem,2) END AS ObjectName,
         CASE WHEN PARSENAME(IndexItem,4) IS NULL THEN '%' ELSE PARSENAME(IndexItem,1) END AS IndexName,
         StartPosition,
         Selected
  FROM Indexes3
  )
  INSERT INTO @SelectedIndexes (DatabaseName, SchemaName, ObjectName, IndexName, StartPosition, Selected)
  SELECT DatabaseName, SchemaName, ObjectName, IndexName, StartPosition, Selected
  FROM Indexes4
  OPTION (MAXRECURSION 0);

  ----------------------------------------------------------------------------------------------------
  --// Select actions                                                                             //--
  ----------------------------------------------------------------------------------------------------

  WITH FragmentationLow (StartPosition, ENDPosition, [Action]) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationLow, 1), 0), LEN(@FragmentationLow) + 1) AS ENDPosition,
         SUBSTRING(@FragmentationLow, 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationLow, 1), 0), LEN(@FragmentationLow) + 1) - 1) AS [Action]
  WHERE @FragmentationLow IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationLow, ENDPosition + 1), 0), LEN(@FragmentationLow) + 1) AS ENDPosition,
         SUBSTRING(@FragmentationLow, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationLow, ENDPosition + 1), 0), LEN(@FragmentationLow) + 1) - ENDPosition - 1) AS [Action]
  FROM FragmentationLow
  WHERE ENDPosition < LEN(@FragmentationLow) + 1
  )
  INSERT INTO @ActionsPreferred(FragmentationGroup, [Priority], [Action])
  SELECT 'Low' AS FragmentationGroup,
         ROW_NUMBER() OVER(ORDER BY StartPosition ASC) AS [Priority],
         [Action]
  FROM FragmentationLow
  OPTION (MAXRECURSION 0);

  WITH FragmentationMedium (StartPosition, ENDPosition, [Action]) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationMedium, 1), 0), LEN(@FragmentationMedium) + 1) AS ENDPosition,
         SUBSTRING(@FragmentationMedium, 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationMedium, 1), 0), LEN(@FragmentationMedium) + 1) - 1) AS [Action]
  WHERE @FragmentationMedium IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationMedium, ENDPosition + 1), 0), LEN(@FragmentationMedium) + 1) AS ENDPosition,
         SUBSTRING(@FragmentationMedium, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationMedium, ENDPosition + 1), 0), LEN(@FragmentationMedium) + 1) - ENDPosition - 1) AS [Action]
  FROM FragmentationMedium
  WHERE ENDPosition < LEN(@FragmentationMedium) + 1
  )
  INSERT INTO @ActionsPreferred(FragmentationGroup, [Priority], [Action])
  SELECT 'Medium' AS FragmentationGroup,
         ROW_NUMBER() OVER(ORDER BY StartPosition ASC) AS [Priority],
         [Action]
  FROM FragmentationMedium
  OPTION (MAXRECURSION 0);

  WITH FragmentationHigh (StartPosition, ENDPosition, [Action]) AS
  (
  SELECT 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationHigh, 1), 0), LEN(@FragmentationHigh) + 1) AS ENDPosition,
         SUBSTRING(@FragmentationHigh, 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationHigh, 1), 0), LEN(@FragmentationHigh) + 1) - 1) AS [Action]
  WHERE @FragmentationHigh IS NOT NULL
  UNION ALL
  SELECT CAST(ENDPosition AS int) + 1 AS StartPosition,
         ISNULL(NULLIF(CHARINDEX(',', @FragmentationHigh, ENDPosition + 1), 0), LEN(@FragmentationHigh) + 1) AS ENDPosition,
         SUBSTRING(@FragmentationHigh, ENDPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @FragmentationHigh, ENDPosition + 1), 0), LEN(@FragmentationHigh) + 1) - ENDPosition - 1) AS [Action]
  FROM FragmentationHigh
  WHERE ENDPosition < LEN(@FragmentationHigh) + 1
  )
  INSERT INTO @ActionsPreferred(FragmentationGroup, [Priority], [Action])
  SELECT 'High' AS FragmentationGroup,
         ROW_NUMBER() OVER(ORDER BY StartPosition ASC) AS [Priority],
         [Action]
  FROM FragmentationHigh
  OPTION (MAXRECURSION 0)

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF EXISTS (SELECT [Action] FROM @ActionsPreferred WHERE FragmentationGroup = 'Low' AND [Action] NOT IN(SELECT * FROM @Actions))
  OR EXISTS(SELECT * FROM @ActionsPreferred WHERE FragmentationGroup = 'Low' GROUP BY [Action] HAVING COUNT(*) > 1)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationLow is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT [Action] FROM @ActionsPreferred WHERE FragmentationGroup = 'Medium' AND [Action] NOT IN(SELECT * FROM @Actions))
  OR EXISTS(SELECT * FROM @ActionsPreferred WHERE FragmentationGroup = 'Medium' GROUP BY [Action] HAVING COUNT(*) > 1)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationMedium is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS (SELECT [Action] FROM @ActionsPreferred WHERE FragmentationGroup = 'High' AND [Action] NOT IN(SELECT * FROM @Actions))
  OR EXISTS(SELECT * FROM @ActionsPreferred WHERE FragmentationGroup = 'High' GROUP BY [Action] HAVING COUNT(*) > 1)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationHigh is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationLevel1 <= 0 OR @FragmentationLevel1 >= 100 OR @FragmentationLevel1 >= @FragmentationLevel2 OR @FragmentationLevel1 IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationLevel1 is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationLevel2 <= 0 OR @FragmentationLevel2 >= 100 OR @FragmentationLevel2 <= @FragmentationLevel1 OR @FragmentationLevel2 IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FragmentationLevel2 is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MinNumberOfPages < 0 OR @MinNumberOfPages IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MinNumberOfPages is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxNumberOfPages < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MaxNumberOfPages is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @SortInTempdb NOT IN('Y','N') OR @SortInTempdb IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @SortInTempdb is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxDOP < 0 OR @MaxDOP > 64
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MaxDOP is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FillFactor <= 0 OR @FillFactor > 100
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @FillFactor is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @PadIndex NOT IN('Y','N')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @PadIndex is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LOBCompaction NOT IN('Y','N') OR @LOBCompaction IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LOBCompaction is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @UpdateStatistics NOT IN('ALL','COLUMNS','INDEX')
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @UpdateStatistics is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @OnlyModifiedStatistics NOT IN('Y','N') OR @OnlyModifiedStatistics IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @OnlyModifiedStatistics is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @StatisticsModificationLevel <= 0 OR @StatisticsModificationLevel > 100
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @StatisticsModificationLevel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @OnlyModifiedStatistics = 'Y' AND @StatisticsModificationLevel IS NOT NULL
  BEGIN
    SET @ErrorMessage = 'You can only specify one of the parameters @OnlyModifiedStatistics and @StatisticsModificationLevel.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @StatisticsSample <= 0 OR @StatisticsSample  > 100
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @StatisticsSample is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @StatisticsResample NOT IN('Y','N') OR @StatisticsResample IS NULL OR (@StatisticsResample = 'Y' AND @StatisticsSample IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @StatisticsResample is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @PartitionLevel NOT IN('Y','N') OR @PartitionLevel IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @PartitionLevel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MSShippedObjects NOT IN('Y','N') OR @MSShippedObjects IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @MSShippedObjects is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF EXISTS(SELECT * FROM @SelectedIndexes WHERE DatabaseName IS NULL OR SchemaName IS NULL OR ObjectName IS NULL OR IndexName IS NULL) OR (@Indexes IS NOT NULL AND NOT EXISTS(SELECT * FROM @SelectedIndexes))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Indexes is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @TimeLimit < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @TimeLimit is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Delay < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Delay is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @WaitAtLowPriorityMaxDuration < 0 OR (@WaitAtLowPriorityMaxDuration IS NOT NULL AND @Version < 12) OR (@WaitAtLowPriorityMaxDuration IS NOT NULL AND @WaitAtLowPriorityAbortAfterWait IS NULL) OR (@WaitAtLowPriorityMaxDuration IS NULL AND @WaitAtLowPriorityAbortAfterWait IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @WaitAtLowPriorityMaxDuration is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @WaitAtLowPriorityAbortAfterWait NOT IN('NONE','SELF','BLOCKERS') OR (@WaitAtLowPriorityAbortAfterWait IS NOT NULL AND @Version < 12) OR (@WaitAtLowPriorityAbortAfterWait IS NOT NULL AND @WaitAtLowPriorityMaxDuration IS NULL) OR (@WaitAtLowPriorityAbortAfterWait IS NULL AND @WaitAtLowPriorityMaxDuration IS NOT NULL)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @WaitAtLowPriorityAbortAfterWait is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Resumable NOT IN('Y','N') OR @Resumable IS NULL OR (@Resumable = 'Y' AND NOT (@Version >= 14 OR SERVERPROPERTY('EngineEdition') IN (5,8)))
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Resumable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Resumable = 'Y' AND @SortInTempdb = 'Y'
  BEGIN
    SET @ErrorMessage = 'You can only specify one of the parameters @Resumable and @SortInTempdb.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LockTimeout < 0
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LockTimeout is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LockMessageSeverity NOT IN(10,16)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LockMessageSeverity is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabaseOrder NOT IN('DATABASE_NAME_ASC','DATABASE_NAME_DESC','DATABASE_SIZE_ASC','DATABASE_SIZE_DESC') OR (@DatabaseOrder IS NOT NULL AND SERVERPROPERTY('EngineEdition') = 5)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DatabaseOrder is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @DatabasesInParallel NOT IN('Y','N') OR @DatabasesInParallel IS NULL OR (@DatabasesInParallel = 'Y' AND SERVERPROPERTY('EngineEdition') = 5)
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @DatabasesInParallel is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LogToTable NOT IN('Y','N') OR @LogToTable IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @LogToTable is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for the parameter @Execute is not supported.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Error <> 0
  BEGIN
    SET @ErrorMessage = 'The documentation is available at https://ola.hallengren.com/sql-server-index-and-statistics-maintenance.html.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @RETURNCode = @Error
    GOTO Logging
  END

  ----------------------------------------------------------------------------------------------------
  --// Check that selected databases and availability groups exist                                //--
  ----------------------------------------------------------------------------------------------------

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedDatabases
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases in the @Databases parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedIndexes
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases in the @Indexes parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(AvailabilityGroupName) + ', '
  FROM @SelectedAvailabilityGroups
  WHERE AvailabilityGroupName NOT LIKE '%[%]%'
  AND AvailabilityGroupName NOT IN (SELECT AvailabilityGroupName FROM @tmpAvailabilityGroups)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following availability groups do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  SET @ErrorMessage = ''
  SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + ', '
  FROM @SelectedIndexes
  WHERE DatabaseName NOT LIKE '%[%]%'
  AND DatabaseName IN (SELECT DatabaseName FROM @tmpDatabases)
  AND DatabaseName NOT IN (SELECT DatabaseName FROM @tmpDatabases WHERE Selected = 1)
  IF @@ROWCOUNT > 0
  BEGIN
    SET @ErrorMessage = 'The following databases have been selected in the @Indexes parameter, but not in the @Databases or @AvailabilityGroups parameters: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Should statistics be updated on the partition level?                                       //--
  ----------------------------------------------------------------------------------------------------

  SET @PartitionLevelStatistics = CASE WHEN @PartitionLevel = 'Y' AND ((@Version >= 12.05 AND @Version < 13) OR @Version >= 13.04422 OR SERVERPROPERTY('EngineEdition') IN (5,8)) THEN 1 ELSE 0 END

  ----------------------------------------------------------------------------------------------------
  --// Update database order                                                                      //--
  ----------------------------------------------------------------------------------------------------

  IF @DatabaseOrder IN('DATABASE_SIZE_ASC','DATABASE_SIZE_DESC')
  BEGIN
    UPDATE tmpDatabases
    SET DatabaseSize = (SELECT SUM(size) FROM sys.master_files WHERE [type] = 0 AND database_id = DB_ID(tmpDatabases.DatabaseName))
    FROM @tmpDatabases tmpDatabases
  END

  IF @DatabaseOrder IS NULL
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY StartPosition ASC, DatabaseName ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_NAME_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseName ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_NAME_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseName DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_SIZE_ASC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseSize ASC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END
  ELSE
  IF @DatabaseOrder = 'DATABASE_SIZE_DESC'
  BEGIN
    WITH tmpDatabases AS (
    SELECT DatabaseName, [Order], ROW_NUMBER() OVER (ORDER BY DatabaseSize DESC) AS RowNumber
    FROM @tmpDatabases tmpDatabases
    WHERE Selected = 1
    )
    UPDATE tmpDatabases
    SET [Order] = RowNumber
  END

  ----------------------------------------------------------------------------------------------------
  --// Update the queue                                                                           //--
  ----------------------------------------------------------------------------------------------------

  IF @DatabasesInParallel = 'Y'
  BEGIN

    BEGIN TRY

      SELECT @QueueID = QueueID
      FROM dbo.[Queue]
      WHERE SchemaName = @SchemaName
      AND ObjectName = @ObjectName
      AND [Parameters] = @Parameters

      IF @QueueID IS NULL
      BEGIN
        BEGIN TRANSACTION

        SELECT @QueueID = QueueID
        FROM dbo.[Queue] WITH (UPDLOCK, TABLOCK)
        WHERE SchemaName = @SchemaName
        AND ObjectName = @ObjectName
        AND [Parameters] = @Parameters

        IF @QueueID IS NULL
        BEGIN
          INSERT INTO dbo.[Queue] (SchemaName, ObjectName, [Parameters])
          SELECT @SchemaName, @ObjectName, @Parameters

          SET @QueueID = SCOPE_IDENTITY()
        END

        COMMIT TRANSACTION
      END

      BEGIN TRANSACTION

      UPDATE [Queue]
      SET QueueStartTime = GETDATE(),
          SessionID = @@SPID,
          RequestID = (SELECT request_id FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          RequestStartTime = (SELECT start_time FROM sys.dm_exec_requests WHERE session_id = @@SPID)
      FROM dbo.[Queue] [Queue]
      WHERE QueueID = @QueueID
      AND NOT EXISTS (SELECT *
                      FROM sys.dm_exec_requests
                      WHERE session_id = [Queue].SessionID
                      AND request_id = [Queue].RequestID
                      AND start_time = [Queue].RequestStartTime)
      AND NOT EXISTS (SELECT *
                      FROM dbo.QueueDatabase QueueDatabase
                      INNER JOIN sys.dm_exec_requests ON QueueDatabase.SessionID = session_id AND QueueDatabase.RequestID = request_id AND QueueDatabase.RequestStartTime = start_time
                      WHERE QueueDatabase.QueueID = @QueueID)

      IF @@ROWCOUNT = 1
      BEGIN
        INSERT INTO dbo.QueueDatabase (QueueID, DatabaseName)
        SELECT @QueueID AS QueueID,
               DatabaseName
        FROM @tmpDatabases tmpDatabases
        WHERE Selected = 1
        AND NOT EXISTS (SELECT * FROM dbo.QueueDatabase WHERE DatabaseName = tmpDatabases.DatabaseName AND QueueID = @QueueID)

        DELETE QueueDatabase
        FROM dbo.QueueDatabase QueueDatabase
        WHERE QueueID = @QueueID
        AND NOT EXISTS (SELECT * FROM @tmpDatabases tmpDatabases WHERE DatabaseName = QueueDatabase.DatabaseName AND Selected = 1)

        UPDATE QueueDatabase
        SET DatabaseOrder = tmpDatabases.[Order]
        FROM dbo.QueueDatabase QueueDatabase
        INNER JOIN @tmpDatabases tmpDatabases ON QueueDatabase.DatabaseName = tmpDatabases.DatabaseName
      END

      COMMIT TRANSACTION

      SELECT @QueueStartTime = QueueStartTime
      FROM dbo.[Queue]
      WHERE QueueID = @QueueID

    END TRY

    BEGIN CATCH
      IF XACT_STATE() <> 0
      BEGIN
        ROLLBACK TRANSACTION
      END
      SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CHAR(13) + CHAR(10) + ' '
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
      SET @RETURNCode = ERROR_NUMBER()
      GOTO Logging
    END CATCH

  END

  ----------------------------------------------------------------------------------------------------
  --// Execute commands                                                                           //--
  ----------------------------------------------------------------------------------------------------

  WHILE (1 = 1)
  BEGIN

    IF @DatabasesInParallel = 'Y'
    BEGIN
      UPDATE QueueDatabase
      SET DatabaseStartTime = NULL,
          SessionID = NULL,
          RequestID = NULL,
          RequestStartTime = NULL
      FROM dbo.QueueDatabase QueueDatabase
      WHERE QueueID = @QueueID
      AND DatabaseStartTime IS NOT NULL
      AND DatabaseENDTime IS NULL
      AND NOT EXISTS (SELECT * FROM sys.dm_exec_requests WHERE session_id = QueueDatabase.SessionID AND request_id = QueueDatabase.RequestID AND start_time = QueueDatabase.RequestStartTime)

      UPDATE QueueDatabase
      SET DatabaseStartTime = GETDATE(),
          DatabaseENDTime = NULL,
          SessionID = @@SPID,
          RequestID = (SELECT request_id FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          RequestStartTime = (SELECT start_time FROM sys.dm_exec_requests WHERE session_id = @@SPID),
          @CurrentDatabaseName = DatabaseName
      FROM (SELECT TOP 1 DatabaseStartTime,
                         DatabaseENDTime,
                         SessionID,
                         RequestID,
                         RequestStartTime,
                         DatabaseName
            FROM dbo.QueueDatabase
            WHERE QueueID = @QueueID
            AND (DatabaseStartTime < @QueueStartTime OR DatabaseStartTime IS NULL)
            AND NOT (DatabaseStartTime IS NOT NULL AND DatabaseENDTime IS NULL)
            ORDER BY DatabaseOrder ASC
            ) QueueDatabase
    END
    ELSE
    BEGIN
      SELECT TOP 1 @CurrentDBID = ID,
                   @CurrentDatabaseName = DatabaseName
      FROM @tmpDatabases
      WHERE Selected = 1
      AND Completed = 0
      ORDER BY [Order] ASC
    END

    IF @@ROWCOUNT = 0
    BEGIN
      BREAK
    END

    SET @CurrentDatabaseID = DB_ID(@CurrentDatabaseName)

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE' AND SERVERPROPERTY('EngineEdition') <> 5
    BEGIN
      IF EXISTS (SELECT * FROM sys.database_recovery_status WHERE database_id = @CurrentDatabaseID AND database_guid IS NOT NULL)
      BEGIN
        SET @CurrentIsDatabaseAccessible = 1
      END
      ELSE
      BEGIN
        SET @CurrentIsDatabaseAccessible = 0
      END
    END

    IF @Version >= 11 AND SERVERPROPERTY('IsHadrEnabled') = 1
    BEGIN
      SELECT @CurrentAvailabilityGroup = availability_groups.name,
             @CurrentAvailabilityGroupRole = dm_hadr_availability_replica_states.role_desc
      FROM sys.databases databases
      INNER JOIN sys.availability_databases_cluster availability_databases_cluster ON databases.group_database_id = availability_databases_cluster.group_database_id
      INNER JOIN sys.availability_groups availability_groups ON availability_databases_cluster.group_id = availability_groups.group_id
      INNER JOIN sys.dm_hadr_availability_replica_states dm_hadr_availability_replica_states ON availability_groups.group_id = dm_hadr_availability_replica_states.group_id AND databases.replica_id = dm_hadr_availability_replica_states.replica_id
      WHERE databases.name = @CurrentDatabaseName
    END

    IF SERVERPROPERTY('EngineEdition') <> 5
    BEGIN
      SELECT @CurrentDatabaseMirroringRole = UPPER(mirroring_role_desc)
      FROM sys.database_mirroring
      WHERE database_id = @CurrentDatabaseID
    END

    SELECT @CurrentIsReadOnly = is_read_only
    FROM sys.databases
    WHERE name = @CurrentDatabaseName

    SET @DatabaseMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Database: ' + QUOTENAME(@CurrentDatabaseName)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Status: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Standby: ' + CASE WHEN DATABASEPROPERTYEX(@CurrentDatabaseName,'IsInStandBy') = 1 THEN 'Yes' ELSE 'No' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'Updateability: ' + CASE WHEN @CurrentIsReadOnly = 1 THEN 'READ_ONLY' WHEN  @CurrentIsReadOnly = 0 THEN 'READ_WRITE' END
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    SET @DatabaseMessage = 'User access: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'UserAccess') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentIsDatabaseAccessible IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Is accessible: ' + CASE WHEN @CurrentIsDatabaseAccessible = 1 THEN 'Yes' ELSE 'No' END
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    SET @DatabaseMessage = 'Recovery model: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabaseName,'Recovery') AS nvarchar)
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF @CurrentAvailabilityGroup IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Availability group: ' + @CurrentAvailabilityGroup
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

      SET @DatabaseMessage = 'Availability group role: ' + @CurrentAvailabilityGroupRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    IF @CurrentDatabaseMirroringRole IS NOT NULL
    BEGIN
      SET @DatabaseMessage = 'Database mirroring role: ' + @CurrentDatabaseMirroringRole
      RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT
    END

    RAISERROR('',10,1) WITH NOWAIT

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'ONLINE'
    AND (@CurrentIsDatabaseAccessible = 1 OR @CurrentIsDatabaseAccessible IS NULL)
    AND DATABASEPROPERTYEX(@CurrentDatabaseName,'Updateability') = 'READ_WRITE'
    BEGIN

      -- Select indexes in the current database
      IF (EXISTS(SELECT * FROM @ActionsPreferred) OR @UpdateStatistics IS NOT NULL) AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SET @CurrentCommand01 = 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;'
                              + 'USE ' + QUOTENAME(@CurrentDatabaseName) + ';'
                              + ' SELECT SchemaID, SchemaName, ObjectID, ObjectName, ObjectType, IsMemoryOptimized, IndexID, IndexName, IndexType, AllowPageLocks, IsImageText, IsNewLOB, IsFileStream, IsColumnStore, IsComputed, IsTimestamp, OnReadOnlyFileGroup, ResumableIndexOperation, StatisticsID, StatisticsName, NoRecompute, IsIncremental, PartitionID, PartitionNumber, PartitionCount, [Order], Selected, Completed'
                              + ' FROM ('

        IF EXISTS(SELECT * FROM @ActionsPreferred) OR @UpdateStatistics IN('ALL','INDEX')
        BEGIN
          SET @CurrentCommand01 = @CurrentCommand01 + 'SELECT schemas.[schema_id] AS SchemaID'
                                                    + ', schemas.[name] AS SchemaName'
                                                    + ', objects.[object_id] AS ObjectID'
                                                    + ', objects.[name] AS ObjectName'
                                                    + ', RTRIM(objects.[type]) AS ObjectType'
                                                    + ', ' + CASE WHEN @Version >= 12 THEN 'tables.is_memory_optimized' ELSE '0' END + ' AS IsMemoryOptimized'
                                                    + ', indexes.index_id AS IndexID'
                                                    + ', indexes.[name] AS IndexName'
                                                    + ', indexes.[type] AS IndexType'
                                                    + ', indexes.allow_page_locks AS AllowPageLocks'

                                                    + ', CASE WHEN indexes.[type] = 1 AND EXISTS(SELECT * FROM sys.columns columns INNER JOIN sys.types types ON columns.system_type_id = types.user_type_id WHERE columns.[object_id] = objects.object_id AND types.name IN(''image'',''text'',''ntext'')) THEN 1 ELSE 0 END AS IsImageText'

                                                    + ', CASE WHEN indexes.[type] = 1 AND EXISTS(SELECT * FROM sys.columns columns INNER JOIN sys.types types ON columns.system_type_id = types.user_type_id OR (columns.user_type_id = types.user_type_id AND types.is_assembly_type = 1) WHERE columns.[object_id] = objects.object_id AND (types.name IN(''xml'') OR (types.name IN(''varchar'',''nvarchar'',''varbinary'') AND columns.max_length = -1) OR (types.is_assembly_type = 1 AND columns.max_length = -1))) THEN 1'
                                                    + ' WHEN indexes.[type] = 2 AND EXISTS(SELECT * FROM sys.index_columns index_columns INNER JOIN sys.columns columns ON index_columns.[object_id] = columns.[object_id] AND index_columns.column_id = columns.column_id INNER JOIN sys.types types ON columns.system_type_id = types.user_type_id OR (columns.user_type_id = types.user_type_id AND types.is_assembly_type = 1) WHERE index_columns.[object_id] = objects.object_id AND index_columns.index_id = indexes.index_id AND (types.[name] IN(''xml'') OR (types.[name] IN(''varchar'',''nvarchar'',''varbinary'') AND columns.max_length = -1) OR (types.is_assembly_type = 1 AND columns.max_length = -1))) THEN 1 ELSE 0 END AS IsNewLOB'

                                                    + ', CASE WHEN indexes.[type] = 1 AND EXISTS(SELECT * FROM sys.columns columns WHERE columns.[object_id] = objects.object_id  AND columns.is_filestream = 1) THEN 1 ELSE 0 END AS IsFileStream'

                                                    + ', CASE WHEN EXISTS(SELECT * FROM sys.indexes indexes WHERE indexes.[object_id] = objects.object_id AND [type] IN(5,6)) THEN 1 ELSE 0 END AS IsColumnStore'

                                                    + ', CASE WHEN EXISTS(SELECT * FROM sys.index_columns index_columns INNER JOIN sys.columns columns ON index_columns.object_id = columns.object_id AND index_columns.column_id = columns.column_id WHERE (index_columns.key_ordinal > 0 OR index_columns.partition_ordinal > 0) AND columns.is_computed = 1 AND index_columns.object_id = indexes.object_id AND index_columns.index_id = indexes.index_id) THEN 1 ELSE 0 END AS IsComputed'

                                                    + ', CASE WHEN EXISTS(SELECT * FROM sys.index_columns index_columns INNER JOIN sys.columns columns ON index_columns.[object_id] = columns.[object_id] AND index_columns.column_id = columns.column_id INNER JOIN sys.types types ON columns.system_type_id = types.system_type_id WHERE index_columns.[object_id] = objects.object_id AND index_columns.index_id = indexes.index_id AND types.[name] = ''timestamp'') THEN 1 ELSE 0 END AS IsTimestamp'

                                                    + ', CASE WHEN EXISTS (SELECT * FROM sys.indexes indexes2 INNER JOIN sys.destination_data_spaces destination_data_spaces ON indexes.data_space_id = destination_data_spaces.partition_scheme_id INNER JOIN sys.filegroups filegroups ON destination_data_spaces.data_space_id = filegroups.data_space_id WHERE filegroups.is_read_only = 1 AND indexes2.[object_id] = indexes.[object_id] AND indexes2.[index_id] = indexes.index_id' + CASE WHEN @PartitionLevel = 'Y' THEN ' AND destination_data_spaces.destination_id = partitions.partition_number' ELSE '' END + ') THEN 1'
                                                    + ' WHEN EXISTS (SELECT * FROM sys.indexes indexes2 INNER JOIN sys.filegroups filegroups ON indexes.data_space_id = filegroups.data_space_id WHERE filegroups.is_read_only = 1 AND indexes.[object_id] = indexes2.[object_id] AND indexes.[index_id] = indexes2.index_id) THEN 1'
                                                    + ' WHEN indexes.[type] = 1 AND EXISTS (SELECT * FROM sys.tables tables INNER JOIN sys.filegroups filegroups ON tables.lob_data_space_id = filegroups.data_space_id WHERE filegroups.is_read_only = 1 AND tables.[object_id] = objects.[object_id]) THEN 1 ELSE 0 END AS OnReadOnlyFileGroup'

                                                    + ', ' + CASE WHEN @Version >= 14 THEN 'CASE WHEN EXISTS(SELECT * FROM sys.index_resumable_operations index_resumable_operations WHERE state_desc = ''PAUSED'' AND index_resumable_operations.object_id = indexes.object_id AND index_resumable_operations.index_id = indexes.index_id AND (index_resumable_operations.partition_number = partitions.partition_number OR index_resumable_operations.partition_number IS NULL)) THEN 1 ELSE 0 END' ELSE '0' END + ' AS ResumableIndexOperation'

                                                    + ', stats.stats_id AS StatisticsID'
                                                    + ', stats.name AS StatisticsName'
                                                    + ', stats.no_recompute AS NoRecompute'
                                                    + ', ' + CASE WHEN @Version >= 12 THEN 'stats.is_incremental' ELSE '0' END + ' AS IsIncremental'
                                                    + ', ' + CASE WHEN @PartitionLevel = 'Y' THEN 'partitions.partition_id AS PartitionID' WHEN @PartitionLevel = 'N' THEN 'NULL AS PartitionID' END
                                                    + ', ' + CASE WHEN @PartitionLevel = 'Y' THEN 'partitions.partition_number AS PartitionNumber' WHEN @PartitionLevel = 'N' THEN 'NULL AS PartitionNumber' END
                                                    + ', ' + CASE WHEN @PartitionLevel = 'Y' THEN 'IndexPartitions.partition_count AS PartitionCount' WHEN @PartitionLevel = 'N' THEN 'NULL AS PartitionCount' END
                                                    + ', 0 AS [Order]'
                                                    + ', 0 AS Selected'
                                                    + ', 0 AS Completed'
                                                    + ' FROM sys.indexes indexes'
                                                    + ' INNER JOIN sys.objects objects ON indexes.[object_id] = objects.[object_id]'
                                                    + ' INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id]'
                                                    + ' LEFT OUTER JOIN sys.tables tables ON objects.[object_id] = tables.[object_id]'
                                                    + ' LEFT OUTER JOIN sys.stats stats ON indexes.[object_id] = stats.[object_id] AND indexes.[index_id] = stats.[stats_id]'
          IF @PartitionLevel = 'Y'
          BEGIN
            SET @CurrentCommand01 = @CurrentCommand01 + ' LEFT OUTER JOIN sys.partitions partitions ON indexes.[object_id] = partitions.[object_id] AND indexes.index_id = partitions.index_id'
                                                      + ' LEFT OUTER JOIN (SELECT partitions.[object_id], partitions.index_id, COUNT(DISTINCT partitions.partition_number) AS partition_count FROM sys.partitions partitions GROUP BY partitions.[object_id], partitions.index_id) IndexPartitions ON partitions.[object_id] = IndexPartitions.[object_id] AND partitions.[index_id] = IndexPartitions.[index_id]'
          END

          SET @CurrentCommand01 = @CurrentCommand01 + ' WHERE objects.[type] IN(''U'',''V'')'
                                                    + CASE WHEN @MSShippedObjects = 'N' THEN ' AND objects.is_ms_shipped = 0' ELSE '' END
                                                    + ' AND indexes.[type] IN(1,2,3,4,5,6,7)'
                                                    + ' AND indexes.is_disabled = 0 AND indexes.is_hypothetical = 0'
        END

        IF (EXISTS(SELECT * FROM @ActionsPreferred) AND @UpdateStatistics = 'COLUMNS') OR @UpdateStatistics = 'ALL'
        BEGIN
          SET @CurrentCommand01 = @CurrentCommand01 + ' UNION '
        END

        IF @UpdateStatistics IN('ALL','COLUMNS')
        BEGIN
          SET @CurrentCommand01 = @CurrentCommand01 + 'SELECT schemas.[schema_id] AS SchemaID'
                                                    + ', schemas.[name] AS SchemaName'
                                                    + ', objects.[object_id] AS ObjectID'
                                                    + ', objects.[name] AS ObjectName'
                                                    + ', RTRIM(objects.[type]) AS ObjectType'
                                                    + ', ' + CASE WHEN @Version >= 12 THEN 'tables.is_memory_optimized' ELSE '0' END + ' AS IsMemoryOptimized'
                                                    + ', NULL AS IndexID, NULL AS IndexName'
                                                    + ', NULL AS IndexType'
                                                    + ', NULL AS AllowPageLocks'
                                                    + ', NULL AS IsImageText'
                                                    + ', NULL AS IsNewLOB'
                                                    + ', NULL AS IsFileStream'
                                                    + ', NULL AS IsColumnStore'
                                                    + ', NULL AS IsComputed'
                                                    + ', NULL AS IsTimestamp'
                                                    + ', NULL AS OnReadOnlyFileGroup'
                                                    + ', NULL AS ResumableIndexOperation'
                                                    + ', stats.stats_id AS StatisticsID'
                                                    + ', stats.name AS StatisticsName'
                                                    + ', stats.no_recompute AS NoRecompute'
                                                    + ', ' + CASE WHEN @Version >= 12 THEN 'stats.is_incremental' ELSE '0' END + ' AS IsIncremental'
                                                    + ', NULL AS PartitionID'
                                                    + ', ' + CASE WHEN @PartitionLevelStatistics = 1 THEN 'dm_db_incremental_stats_properties.partition_number' ELSE 'NULL' END + ' AS PartitionNumber'
                                                    + ', NULL AS PartitionCount'
                                                    + ', 0 AS [Order]'
                                                    + ', 0 AS Selected'
                                                    + ', 0 AS Completed'
                                                    + ' FROM sys.stats stats'
                                                    + ' INNER JOIN sys.objects objects ON stats.[object_id] = objects.[object_id]'
                                                    + ' INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id]'
                                                    + ' LEFT OUTER JOIN sys.tables tables ON objects.[object_id] = tables.[object_id]'

          IF @PartitionLevelStatistics = 1
          BEGIN
            SET @CurrentCommand01 = @CurrentCommand01 + ' OUTER APPLY sys.dm_db_incremental_stats_properties(stats.object_id, stats.stats_id) dm_db_incremental_stats_properties'
          END

          SET @CurrentCommand01 = @CurrentCommand01 + ' WHERE objects.[type] IN(''U'',''V'')'
                                                    + CASE WHEN @MSShippedObjects = 'N' THEN ' AND objects.is_ms_shipped = 0' ELSE '' END
                                                    + ' AND NOT EXISTS(SELECT * FROM sys.indexes indexes WHERE indexes.[object_id] = stats.[object_id] AND indexes.index_id = stats.stats_id)'
        END

        SET @CurrentCommand01 = @CurrentCommand01 + ') IndexesStatistics'

        INSERT INTO @tmpIndexesStatistics (SchemaID, SchemaName, ObjectID, ObjectName, ObjectType, IsMemoryOptimized, IndexID, IndexName, IndexType, AllowPageLocks, IsImageText, IsNewLOB, IsFileStream, IsColumnStore, IsComputed, IsTimestamp, OnReadOnlyFileGroup, ResumableIndexOperation, StatisticsID, StatisticsName, [NoRecompute], IsIncremental, PartitionID, PartitionNumber, PartitionCount, [Order], Selected, Completed)
        EXECUTE sp_executesql @statement = @CurrentCommand01
        SET @Error = @@ERROR
        IF @Error <> 0
        BEGIN
          SET @RETURNCode = @Error
        END
      END

      IF @Indexes IS NULL
      BEGIN
        UPDATE tmpIndexesStatistics
        SET tmpIndexesStatistics.Selected = 1
        FROM @tmpIndexesStatistics tmpIndexesStatistics
      END
      ELSE
      BEGIN
        UPDATE tmpIndexesStatistics
        SET tmpIndexesStatistics.Selected = SelectedIndexes.Selected
        FROM @tmpIndexesStatistics tmpIndexesStatistics
        INNER JOIN @SelectedIndexes SelectedIndexes
        ON @CurrentDatabaseName LIKE REPLACE(SelectedIndexes.DatabaseName,'_','[_]') AND tmpIndexesStatistics.SchemaName LIKE REPLACE(SelectedIndexes.SchemaName,'_','[_]') AND tmpIndexesStatistics.ObjectName LIKE REPLACE(SelectedIndexes.ObjectName,'_','[_]') AND COALESCE(tmpIndexesStatistics.IndexName,tmpIndexesStatistics.StatisticsName) LIKE REPLACE(SelectedIndexes.IndexName,'_','[_]')
        WHERE SelectedIndexes.Selected = 1

        UPDATE tmpIndexesStatistics
        SET tmpIndexesStatistics.Selected = SelectedIndexes.Selected
        FROM @tmpIndexesStatistics tmpIndexesStatistics
        INNER JOIN @SelectedIndexes SelectedIndexes
        ON @CurrentDatabaseName LIKE REPLACE(SelectedIndexes.DatabaseName,'_','[_]') AND tmpIndexesStatistics.SchemaName LIKE REPLACE(SelectedIndexes.SchemaName,'_','[_]') AND tmpIndexesStatistics.ObjectName LIKE REPLACE(SelectedIndexes.ObjectName,'_','[_]') AND COALESCE(tmpIndexesStatistics.IndexName,tmpIndexesStatistics.StatisticsName) LIKE REPLACE(SelectedIndexes.IndexName,'_','[_]')
        WHERE SelectedIndexes.Selected = 0

        UPDATE tmpIndexesStatistics
        SET tmpIndexesStatistics.StartPosition = SelectedIndexes2.StartPosition
        FROM @tmpIndexesStatistics tmpIndexesStatistics
        INNER JOIN (SELECT tmpIndexesStatistics.SchemaName, tmpIndexesStatistics.ObjectName, tmpIndexesStatistics.IndexName, tmpIndexesStatistics.StatisticsName, MIN(SelectedIndexes.StartPosition) AS StartPosition
                    FROM @tmpIndexesStatistics tmpIndexesStatistics
                    INNER JOIN @SelectedIndexes SelectedIndexes
                    ON @CurrentDatabaseName LIKE REPLACE(SelectedIndexes.DatabaseName,'_','[_]') AND tmpIndexesStatistics.SchemaName LIKE REPLACE(SelectedIndexes.SchemaName,'_','[_]') AND tmpIndexesStatistics.ObjectName LIKE REPLACE(SelectedIndexes.ObjectName,'_','[_]') AND COALESCE(tmpIndexesStatistics.IndexName,tmpIndexesStatistics.StatisticsName) LIKE REPLACE(SelectedIndexes.IndexName,'_','[_]')
                    WHERE SelectedIndexes.Selected = 1
                    GROUP BY tmpIndexesStatistics.SchemaName, tmpIndexesStatistics.ObjectName, tmpIndexesStatistics.IndexName, tmpIndexesStatistics.StatisticsName) SelectedIndexes2
        ON tmpIndexesStatistics.SchemaName = SelectedIndexes2.SchemaName
        AND tmpIndexesStatistics.ObjectName = SelectedIndexes2.ObjectName
        AND (tmpIndexesStatistics.IndexName = SelectedIndexes2.IndexName OR tmpIndexesStatistics.IndexName IS NULL)
        AND (tmpIndexesStatistics.StatisticsName = SelectedIndexes2.StatisticsName OR tmpIndexesStatistics.StatisticsName IS NULL)
      END;

      WITH tmpIndexesStatistics AS (
      SELECT SchemaName, ObjectName, [Order], ROW_NUMBER() OVER (ORDER BY ISNULL(ResumableIndexOperation,0) DESC, StartPosition ASC, SchemaName ASC, ObjectName ASC, CASE WHEN IndexType IS NULL THEN 1 ELSE 0 END ASC, IndexType ASC, IndexName ASC, StatisticsName ASC, PartitionNumber ASC) AS RowNumber
      FROM @tmpIndexesStatistics tmpIndexesStatistics
      WHERE Selected = 1
      )
      UPDATE tmpIndexesStatistics
      SET [Order] = RowNumber

      SET @ErrorMessage = ''
      SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + '.' + QUOTENAME(SchemaName) + '.' + QUOTENAME(ObjectName) + ', '
      FROM @SelectedIndexes SelectedIndexes
      WHERE DatabaseName = @CurrentDatabaseName
      AND SchemaName NOT LIKE '%[%]%'
      AND ObjectName NOT LIKE '%[%]%'
      AND IndexName LIKE '%[%]%'
      AND NOT EXISTS (SELECT * FROM @tmpIndexesStatistics WHERE SchemaName = SelectedIndexes.SchemaName AND ObjectName = SelectedIndexes.ObjectName)
      IF @@ROWCOUNT > 0
      BEGIN
        SET @ErrorMessage = 'The following objects in the @Indexes parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
        RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
        SET @Error = @@ERROR
      END

      SET @ErrorMessage = ''
      SELECT @ErrorMessage = @ErrorMessage + QUOTENAME(DatabaseName) + QUOTENAME(SchemaName) + '.' + QUOTENAME(ObjectName) + '.' + QUOTENAME(IndexName) + ', '
      FROM @SelectedIndexes SelectedIndexes
      WHERE DatabaseName = @CurrentDatabaseName
      AND SchemaName NOT LIKE '%[%]%'
      AND ObjectName NOT LIKE '%[%]%'
      AND IndexName NOT LIKE '%[%]%'
      AND NOT EXISTS (SELECT * FROM @tmpIndexesStatistics WHERE SchemaName = SelectedIndexes.SchemaName AND ObjectName = SelectedIndexes.ObjectName AND IndexName = SelectedIndexes.IndexName)
      IF @@ROWCOUNT > 0
      BEGIN
        SET @ErrorMessage = 'The following indexes in the @Indexes parameter do not exist: ' + LEFT(@ErrorMessage,LEN(@ErrorMessage)-1) + '.' + CHAR(13) + CHAR(10) + ' '
        RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
        SET @Error = @@ERROR
      END

      WHILE (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
      BEGIN
        SELECT TOP 1 @CurrentIxID = ID,
                     @CurrentSchemaID = SchemaID,
                     @CurrentSchemaName = SchemaName,
                     @CurrentObjectID = ObjectID,
                     @CurrentObjectName = ObjectName,
                     @CurrentObjectType = ObjectType,
                     @CurrentIsMemoryOptimized = IsMemoryOptimized,
                     @CurrentIndexID = IndexID,
                     @CurrentIndexName = IndexName,
                     @CurrentIndexType = IndexType,
                     @CurrentAllowPageLocks = AllowPageLocks,
                     @CurrentIsImageText = IsImageText,
                     @CurrentIsNewLOB = IsNewLOB,
                     @CurrentIsFileStream = IsFileStream,
                     @CurrentIsColumnStore = IsColumnStore,
                     @CurrentIsComputed = IsComputed,
                     @CurrentIsTimestamp = IsTimestamp,
                     @CurrentOnReadOnlyFileGroup = OnReadOnlyFileGroup,
                     @CurrentResumableIndexOperation = ResumableIndexOperation,
                     @CurrentStatisticsID = StatisticsID,
                     @CurrentStatisticsName = StatisticsName,
                     @CurrentNoRecompute = [NoRecompute],
                     @CurrentIsIncremental = IsIncremental,
                     @CurrentPartitionID = PartitionID,
                     @CurrentPartitionNumber = PartitionNumber,
                     @CurrentPartitionCount = PartitionCount
        FROM @tmpIndexesStatistics
        WHERE Selected = 1
        AND Completed = 0
        ORDER BY [Order] ASC

        IF @@ROWCOUNT = 0
        BEGIN
          BREAK
        END

        -- Is the index a partition?
        IF @CurrentPartitionNumber IS NULL OR @CurrentPartitionCount = 1 BEGIN SET @CurrentIsPartition = 0 END ELSE BEGIN SET @CurrentIsPartition = 1 END

        -- Does the index exist?
        IF @CurrentIndexID IS NOT NULL AND EXISTS(SELECT * FROM @ActionsPreferred)
        BEGIN
          SET @CurrentCommand02 = ''

          IF @LockTimeout IS NOT NULL SET @CurrentCommand02 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand02 = @CurrentCommand02 + 'USE ' + QUOTENAME(@CurrentDatabaseName) + '; '

          IF @CurrentIsPartition = 0 SET @CurrentCommand02 = @CurrentCommand02 + 'IF EXISTS(SELECT * FROM sys.indexes indexes INNER JOIN sys.objects objects ON indexes.[object_id] = objects.[object_id] INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] IN(''U'',''V'') AND indexes.[type] IN(1,2,3,4,5,6,7) AND indexes.is_disabled = 0 AND indexes.is_hypothetical = 0 AND schemas.[schema_id] = @ParamSchemaID AND schemas.[name] = @ParamSchemaName AND objects.[object_id] = @ParamObjectID AND objects.[name] = @ParamObjectName AND objects.[type] = @ParamObjectType AND indexes.index_id = @ParamIndexID AND indexes.[name] = @ParamIndexName AND indexes.[type] = @ParamIndexType) BEGIN SET @ParamIndexExists = 1 END'
          IF @CurrentIsPartition = 1 SET @CurrentCommand02 = @CurrentCommand02 + 'IF EXISTS(SELECT * FROM sys.indexes indexes INNER JOIN sys.objects objects ON indexes.[object_id] = objects.[object_id] INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] INNER JOIN sys.partitions partitions ON indexes.[object_id] = partitions.[object_id] AND indexes.index_id = partitions.index_id WHERE objects.[type] IN(''U'',''V'') AND indexes.[type] IN(1,2,3,4,5,6,7) AND indexes.is_disabled = 0 AND indexes.is_hypothetical = 0 AND schemas.[schema_id] = @ParamSchemaID AND schemas.[name] = @ParamSchemaName AND objects.[object_id] = @ParamObjectID AND objects.[name] = @ParamObjectName AND objects.[type] = @ParamObjectType AND indexes.index_id = @ParamIndexID AND indexes.[name] = @ParamIndexName AND indexes.[type] = @ParamIndexType AND partitions.partition_id = @ParamPartitionID AND partitions.partition_number = @ParamPartitionNumber) BEGIN SET @ParamIndexExists = 1 END'

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand02, @params = N'@ParamSchemaID int, @ParamSchemaName sysname, @ParamObjectID int, @ParamObjectName sysname, @ParamObjectType sysname, @ParamIndexID int, @ParamIndexName sysname, @ParamIndexType int, @ParamPartitionID bigint, @ParamPartitionNumber int, @ParamIndexExists bit OUTPUT', @ParamSchemaID = @CurrentSchemaID, @ParamSchemaName = @CurrentSchemaName, @ParamObjectID = @CurrentObjectID, @ParamObjectName = @CurrentObjectName, @ParamObjectType = @CurrentObjectType, @ParamIndexID = @CurrentIndexID, @ParamIndexName = @CurrentIndexName, @ParamIndexType = @CurrentIndexType, @ParamPartitionID = @CurrentPartitionID, @ParamPartitionNumber = @CurrentPartitionNumber, @ParamIndexExists = @CurrentIndexExists OUTPUT

            IF @CurrentIndexExists IS NULL
            BEGIN
              SET @CurrentIndexExists = 0
              GOTO NoAction
            END
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ' The index ' + QUOTENAME(@CurrentIndexName) + ' on the object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. It could not be checked if the index exists.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @RETURNCode = ERROR_NUMBER()
            END

            GOTO NoAction
          END CATCH
        END

        -- Does the statistics exist?
        IF @CurrentStatisticsID IS NOT NULL AND @UpdateStatistics IS NOT NULL
        BEGIN
          SET @CurrentCommand03 = ''

          IF @LockTimeout IS NOT NULL SET @CurrentCommand03 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand03 = @CurrentCommand03 + 'USE ' + QUOTENAME(@CurrentDatabaseName) + '; '

          SET @CurrentCommand03 = @CurrentCommand03 + 'IF EXISTS(SELECT * FROM sys.stats stats INNER JOIN sys.objects objects ON stats.[object_id] = objects.[object_id] INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id] WHERE objects.[type] IN(''U'',''V'')' + CASE WHEN @MSShippedObjects = 'N' THEN ' AND objects.is_ms_shipped = 0' ELSE '' END + ' AND schemas.[schema_id] = @ParamSchemaID AND schemas.[name] = @ParamSchemaName AND objects.[object_id] = @ParamObjectID AND objects.[name] = @ParamObjectName AND objects.[type] = @ParamObjectType AND stats.stats_id = @ParamStatisticsID AND stats.[name] = @ParamStatisticsName) BEGIN SET @ParamStatisticsExists = 1 END'

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand03, @params = N'@ParamSchemaID int, @ParamSchemaName sysname, @ParamObjectID int, @ParamObjectName sysname, @ParamObjectType sysname, @ParamStatisticsID int, @ParamStatisticsName sysname, @ParamStatisticsExists bit OUTPUT', @ParamSchemaID = @CurrentSchemaID, @ParamSchemaName = @CurrentSchemaName, @ParamObjectID = @CurrentObjectID, @ParamObjectName = @CurrentObjectName, @ParamObjectType = @CurrentObjectType, @ParamStatisticsID = @CurrentStatisticsID, @ParamStatisticsName = @CurrentStatisticsName, @ParamStatisticsExists = @CurrentStatisticsExists OUTPUT

            IF @CurrentStatisticsExists IS NULL
            BEGIN
              SET @CurrentStatisticsExists = 0
              GOTO NoAction
            END
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ' The statistics ' + QUOTENAME(@CurrentStatisticsName) + ' on the object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. It could not be checked if the statistics exists.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @RETURNCode = ERROR_NUMBER()
            END

            GOTO NoAction
          END CATCH
        END

        -- Has the data in the statistics been modified since the statistics was last updated?
        IF @CurrentStatisticsID IS NOT NULL AND @UpdateStatistics IS NOT NULL
        BEGIN
          SET @CurrentCommand04 = ''

          IF @LockTimeout IS NOT NULL SET @CurrentCommand04 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand04 = @CurrentCommand04 + 'USE ' + QUOTENAME(@CurrentDatabaseName) + '; '

          IF @PartitionLevelStatistics = 1 AND @CurrentIsIncremental = 1
          BEGIN
            SET @CurrentCommand04 = @CurrentCommand04 + 'SELECT @ParamRowCount = [rows], @ParamModificationCounter = modification_counter FROM sys.dm_db_incremental_stats_properties (@ParamObjectID, @ParamStatisticsID) WHERE partition_number = @ParamPartitionNumber'
          END
          ELSE
          IF (@Version >= 10.504000 AND @Version < 11) OR @Version >= 11.03000
          BEGIN
            SET @CurrentCommand04 = @CurrentCommand04 + 'SELECT @ParamRowCount = [rows], @ParamModificationCounter = modification_counter FROM sys.dm_db_stats_properties (@ParamObjectID, @ParamStatisticsID)'
          END
          ELSE
          BEGIN
            SET @CurrentCommand04 = @CurrentCommand04 + 'SELECT @ParamRowCount = rowcnt, @ParamModificationCounter = rowmodctr FROM sys.sysindexes sysindexes WHERE sysindexes.[id] = @ParamObjectID AND sysindexes.[indid] = @ParamStatisticsID'
          END

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand04, @params = N'@ParamObjectID int, @ParamStatisticsID int, @ParamPartitionNumber int, @ParamRowCount bigint OUTPUT, @ParamModificationCounter bigint OUTPUT', @ParamObjectID = @CurrentObjectID, @ParamStatisticsID = @CurrentStatisticsID, @ParamPartitionNumber = @CurrentPartitionNumber, @ParamRowCount = @CurrentRowCount OUTPUT, @ParamModificationCounter = @CurrentModificationCounter OUTPUT

            IF @CurrentRowCount IS NULL SET @CurrentRowCount = 0
            IF @CurrentModificationCounter IS NULL SET @CurrentModificationCounter = 0
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ' The statistics ' + QUOTENAME(@CurrentStatisticsName) + ' on the object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. The rows and modification_counter could not be checked.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @RETURNCode = ERROR_NUMBER()
            END

            GOTO NoAction
          END CATCH
        END

        -- Is the index fragmented?
        IF @CurrentIndexID IS NOT NULL
        AND @CurrentOnReadOnlyFileGroup = 0
        AND EXISTS(SELECT * FROM @ActionsPreferred)
        AND (EXISTS(SELECT [Priority], [Action], COUNT(*) FROM @ActionsPreferred GROUP BY [Priority], [Action] HAVING COUNT(*) <> 3) OR @MinNumberOfPages > 0 OR @MaxNumberOfPages IS NOT NULL)
        BEGIN
          SET @CurrentCommand05 = ''

          IF @LockTimeout IS NOT NULL SET @CurrentCommand05 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '

          SET @CurrentCommand05 = @CurrentCommand05 + 'SELECT @ParamFragmentationLevel = MAX(avg_fragmentation_in_percent), @ParamPageCount = SUM(page_count) FROM sys.dm_db_index_physical_stats(@ParamDatabaseID, @ParamObjectID, @ParamIndexID, @ParamPartitionNumber, ''LIMITED'') WHERE alloc_unit_type_desc = ''IN_ROW_DATA'' AND index_level = 0'

          BEGIN TRY
            EXECUTE sp_executesql @statement = @CurrentCommand05, @params = N'@ParamDatabaseID int, @ParamObjectID int, @ParamIndexID int, @ParamPartitionNumber int, @ParamFragmentationLevel float OUTPUT, @ParamPageCount bigint OUTPUT', @ParamDatabaseID = @CurrentDatabaseID, @ParamObjectID = @CurrentObjectID, @ParamIndexID = @CurrentIndexID, @ParamPartitionNumber = @CurrentPartitionNumber, @ParamFragmentationLevel = @CurrentFragmentationLevel OUTPUT, @ParamPageCount = @CurrentPageCount OUTPUT
          END TRY
          BEGIN CATCH
            SET @ErrorMessage = 'Msg ' + CAST(ERROR_NUMBER() AS nvarchar) + ', ' + ISNULL(ERROR_MESSAGE(),'') + CASE WHEN ERROR_NUMBER() = 1222 THEN ' The index ' + QUOTENAME(@CurrentIndexName) + ' on the object ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' is locked. The page_count and avg_fragmentation_in_percent could not be checked.' ELSE '' END + CHAR(13) + CHAR(10) + ' '
            SET @Severity = CASE WHEN ERROR_NUMBER() IN(1205,1222) THEN @LockMessageSeverity ELSE 16 END
            RAISERROR(@ErrorMessage,@Severity,1) WITH NOWAIT

            IF NOT (ERROR_NUMBER() IN(1205,1222) AND @LockMessageSeverity = 10)
            BEGIN
              SET @RETURNCode = ERROR_NUMBER()
            END

            GOTO NoAction
          END CATCH
        END

        -- Select fragmentation group
        IF @CurrentIndexID IS NOT NULL AND @CurrentOnReadOnlyFileGroup = 0 AND EXISTS(SELECT * FROM @ActionsPreferred)
        BEGIN
          SET @CurrentFragmentationGroup = CASE
          WHEN @CurrentFragmentationLevel >= @FragmentationLevel2 THEN 'High'
          WHEN @CurrentFragmentationLevel >= @FragmentationLevel1 AND @CurrentFragmentationLevel < @FragmentationLevel2 THEN 'Medium'
          WHEN @CurrentFragmentationLevel < @FragmentationLevel1 THEN 'Low'
          END
        END

        -- Which actions are allowed?
        IF @CurrentIndexID IS NOT NULL AND EXISTS(SELECT * FROM @ActionsPreferred)
        BEGIN
          IF @CurrentOnReadOnlyFileGroup = 0 AND @CurrentIndexType IN (1,2,3,4,5) AND (@CurrentIsMemoryOptimized = 0 OR @CurrentIsMemoryOptimized IS NULL) AND (@CurrentAllowPageLocks = 1 OR @CurrentIndexType = 5)
          BEGIN
            INSERT INTO @CurrentActionsAllowed ([Action])
            VALUES ('INDEX_REORGANIZE')
          END
          IF @CurrentOnReadOnlyFileGroup = 0 AND @CurrentIndexType IN (1,2,3,4,5) AND (@CurrentIsMemoryOptimized = 0 OR @CurrentIsMemoryOptimized IS NULL)
          BEGIN
            INSERT INTO @CurrentActionsAllowed ([Action])
            VALUES ('INDEX_REBUILD_OFFLINE')
          END
          IF @CurrentOnReadOnlyFileGroup = 0
          AND (@CurrentIsMemoryOptimized = 0 OR @CurrentIsMemoryOptimized IS NULL)
          AND (@CurrentIsPartition = 0 OR @Version >= 12)
          AND ((@CurrentIndexType = 1 AND @CurrentIsImageText = 0 AND @CurrentIsNewLOB = 0)
          OR (@CurrentIndexType = 2 AND @CurrentIsNewLOB = 0)
          OR (@CurrentIndexType = 1 AND @CurrentIsImageText = 0 AND @CurrentIsFileStream = 0 AND @Version >= 11)
          OR (@CurrentIndexType = 2 AND @Version >= 11))
          AND (@CurrentIsColumnStore = 0 OR @Version < 11)
          AND SERVERPROPERTY('EngineEdition') IN (3,5,8)
          BEGIN
            INSERT INTO @CurrentActionsAllowed ([Action])
            VALUES ('INDEX_REBUILD_ONLINE')
          END
        END

        -- Decide action
        IF @CurrentIndexID IS NOT NULL
        AND EXISTS(SELECT * FROM @ActionsPreferred)
        AND (@CurrentPageCount >= @MinNumberOfPages OR @MinNumberOfPages = 0)
        AND (@CurrentPageCount <= @MaxNumberOfPages OR @MaxNumberOfPages IS NULL)
        AND @CurrentResumableIndexOperation = 0
        BEGIN
          IF EXISTS(SELECT [Priority], [Action], COUNT(*) FROM @ActionsPreferred GROUP BY [Priority], [Action] HAVING COUNT(*) <> 3)
          BEGIN
            SELECT @CurrentAction = [Action]
            FROM @ActionsPreferred
            WHERE FragmentationGroup = @CurrentFragmentationGroup
            AND [Priority] = (SELECT MIN([Priority])
                              FROM @ActionsPreferred
                              WHERE FragmentationGroup = @CurrentFragmentationGroup
                              AND [Action] IN (SELECT [Action] FROM @CurrentActionsAllowed))
          END
          ELSE
          BEGIN
            SELECT @CurrentAction = [Action]
            FROM @ActionsPreferred
            WHERE [Priority] = (SELECT MIN([Priority])
                                FROM @ActionsPreferred
                                WHERE [Action] IN (SELECT [Action] FROM @CurrentActionsAllowed))
          END
        END

        IF @CurrentResumableIndexOperation = 1
        BEGIN
          SET @CurrentAction = 'INDEX_REBUILD_ONLINE'
        END

        -- Workaround for limitation in SQL Server, http://support.microsoft.com/kb/2292737
        IF @CurrentIndexID IS NOT NULL
        BEGIN
          SET @CurrentMaxDOP = @MaxDOP

          IF @CurrentAction = 'INDEX_REBUILD_ONLINE' AND @CurrentAllowPageLocks = 0
          BEGIN
            SET @CurrentMaxDOP = 1
          END
        END

        -- Update statistics?
        IF @CurrentStatisticsID IS NOT NULL
        AND ((@UpdateStatistics = 'ALL' AND (@CurrentIndexType IN (1,2,3,4,7) OR @CurrentIndexID IS NULL)) OR (@UpdateStatistics = 'INDEX' AND @CurrentIndexID IS NOT NULL AND @CurrentIndexType IN (1,2,3,4,7)) OR (@UpdateStatistics = 'COLUMNS' AND @CurrentIndexID IS NULL))
        AND ((@OnlyModifiedStatistics = 'N' AND @StatisticsModificationLevel IS NULL) OR (@OnlyModifiedStatistics = 'Y' AND @CurrentModificationCounter > 0) OR ((@CurrentModificationCounter * 1. / NULLIF(@CurrentRowCount,0)) * 100 >= @StatisticsModificationLevel) OR (@StatisticsModificationLevel IS NOT NULL AND @CurrentModificationCounter > 0 AND (@CurrentModificationCounter >= SQRT(@CurrentRowCount * 1000))) OR (@CurrentIsMemoryOptimized = 1 AND NOT (@Version >= 13 OR SERVERPROPERTY('EngineEdition') IN (5,8))))
        AND ((@CurrentIsPartition = 0 AND (@CurrentAction NOT IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') OR @CurrentAction IS NULL)) OR (@CurrentIsPartition = 1 AND (@CurrentPartitionNumber = @CurrentPartitionCount OR (@PartitionLevelStatistics = 1 AND @CurrentIsIncremental = 1))))
        BEGIN
          SET @CurrentUpdateStatistics = 'Y'
        END
        ELSE
        BEGIN
          SET @CurrentUpdateStatistics = 'N'
        END

        SET @CurrentStatisticsSample = @StatisticsSample
        SET @CurrentStatisticsResample = @StatisticsResample

        -- Memory-optimized tables only supports FULLSCAN and RESAMPLE in SQL Server 2014
        IF @CurrentIsMemoryOptimized = 1 AND NOT (@Version >= 13 OR SERVERPROPERTY('EngineEdition') IN (5,8)) AND (@CurrentStatisticsSample <> 100 OR @CurrentStatisticsSample IS NULL)
        BEGIN
          SET @CurrentStatisticsSample = NULL
          SET @CurrentStatisticsResample = 'Y'
        END

        -- Incremental statistics only supports RESAMPLE
        IF @PartitionLevelStatistics = 1 AND @CurrentIsIncremental = 1
        BEGIN
          SET @CurrentStatisticsSample = NULL
          SET @CurrentStatisticsResample = 'Y'
        END

        -- Create index comment
        IF @CurrentIndexID IS NOT NULL
        BEGIN
          SET @CurrentComment06 = 'ObjectType: ' + CASE WHEN @CurrentObjectType = 'U' THEN 'Table' WHEN @CurrentObjectType = 'V' THEN 'View' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'IndexType: ' + CASE WHEN @CurrentIndexType = 1 THEN 'Clustered' WHEN @CurrentIndexType = 2 THEN 'NonClustered' WHEN @CurrentIndexType = 3 THEN 'XML' WHEN @CurrentIndexType = 4 THEN 'Spatial' WHEN @CurrentIndexType = 5 THEN 'Clustered Columnstore' WHEN @CurrentIndexType = 6 THEN 'NonClustered Columnstore' WHEN @CurrentIndexType = 7 THEN 'NonClustered Hash' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'ImageText: ' + CASE WHEN @CurrentIsImageText = 1 THEN 'Yes' WHEN @CurrentIsImageText = 0 THEN 'No' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'NewLOB: ' + CASE WHEN @CurrentIsNewLOB = 1 THEN 'Yes' WHEN @CurrentIsNewLOB = 0 THEN 'No' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'FileStream: ' + CASE WHEN @CurrentIsFileStream = 1 THEN 'Yes' WHEN @CurrentIsFileStream = 0 THEN 'No' ELSE 'N/A' END + ', '
          IF @Version >= 11 SET @CurrentComment06 = @CurrentComment06 + 'ColumnStore: ' + CASE WHEN @CurrentIsColumnStore = 1 THEN 'Yes' WHEN @CurrentIsColumnStore = 0 THEN 'No' ELSE 'N/A' END + ', '
          IF @Version >= 14 AND @Resumable = 'Y' SET @CurrentComment06 = @CurrentComment06 + 'Computed: ' + CASE WHEN @CurrentIsComputed = 1 THEN 'Yes' WHEN @CurrentIsComputed = 0 THEN 'No' ELSE 'N/A' END + ', '
          IF @Version >= 14 AND @Resumable = 'Y' SET @CurrentComment06 = @CurrentComment06 + 'Timestamp: ' + CASE WHEN @CurrentIsTimestamp = 1 THEN 'Yes' WHEN @CurrentIsTimestamp = 0 THEN 'No' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'AllowPageLocks: ' + CASE WHEN @CurrentAllowPageLocks = 1 THEN 'Yes' WHEN @CurrentAllowPageLocks = 0 THEN 'No' ELSE 'N/A' END + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'PageCount: ' + ISNULL(CAST(@CurrentPageCount AS nvarchar),'N/A') + ', '
          SET @CurrentComment06 = @CurrentComment06 + 'Fragmentation: ' + ISNULL(CAST(@CurrentFragmentationLevel AS nvarchar),'N/A')
        END

        IF @CurrentIndexID IS NOT NULL AND (@CurrentPageCount IS NOT NULL OR @CurrentFragmentationLevel IS NOT NULL)
        BEGIN
        SET @CurrentExtENDedInfo06 = (SELECT *
                                      FROM (SELECT CAST(@CurrentPageCount AS nvarchar) AS [PageCount],
                                                   CAST(@CurrentFragmentationLevel AS nvarchar) AS Fragmentation
                                      ) ExtENDedInfo FOR XML AUTO, ELEMENTS)
        END

        -- Create statistics comment
        IF @CurrentStatisticsID IS NOT NULL
        BEGIN
          SET @CurrentComment07 = 'ObjectType: ' + CASE WHEN @CurrentObjectType = 'U' THEN 'Table' WHEN @CurrentObjectType = 'V' THEN 'View' ELSE 'N/A' END + ', '
          SET @CurrentComment07 = @CurrentComment07 + 'IndexType: ' + CASE WHEN @CurrentIndexID IS NOT NULL THEN 'Index' ELSE 'Column' END + ', '
          IF @CurrentIndexID IS NOT NULL SET @CurrentComment07 = @CurrentComment07 + 'IndexType: ' + CASE WHEN @CurrentIndexType = 1 THEN 'Clustered' WHEN @CurrentIndexType = 2 THEN 'NonClustered' WHEN @CurrentIndexType = 3 THEN 'XML' WHEN @CurrentIndexType = 4 THEN 'Spatial' WHEN @CurrentIndexType = 5 THEN 'Clustered Columnstore' WHEN @CurrentIndexType = 6 THEN 'NonClustered Columnstore' WHEN @CurrentIndexType = 7 THEN 'NonClustered Hash' ELSE 'N/A' END + ', '
          SET @CurrentComment07 = @CurrentComment07 + 'Incremental: ' + CASE WHEN @CurrentIsIncremental = 1 THEN 'Y' WHEN @CurrentIsIncremental = 0 THEN 'N' ELSE 'N/A' END + ', '
          SET @CurrentComment07 = @CurrentComment07 + 'RowCount: ' + ISNULL(CAST(@CurrentRowCount AS nvarchar),'N/A') + ', '
          SET @CurrentComment07 = @CurrentComment07 + 'ModificationCounter: ' + ISNULL(CAST(@CurrentModificationCounter AS nvarchar),'N/A')
        END

        IF @CurrentStatisticsID IS NOT NULL AND (@CurrentRowCount IS NOT NULL OR @CurrentModificationCounter IS NOT NULL)
        BEGIN
        SET @CurrentExtENDedInfo07 = (SELECT *
                                      FROM (SELECT CAST(@CurrentRowCount AS nvarchar) AS [RowCount],
                                                   CAST(@CurrentModificationCounter AS nvarchar) AS ModificationCounter
                                      ) ExtENDedInfo FOR XML AUTO, ELEMENTS)
        END

        IF @CurrentIndexID IS NOT NULL AND @CurrentAction IS NOT NULL AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
        BEGIN
          SET @CurrentCommandType06 = 'ALTER_INDEX'

          SET @CurrentCommand06 = ''
          IF @LockTimeout IS NOT NULL SET @CurrentCommand06 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand06 = @CurrentCommand06 + 'ALTER INDEX ' + QUOTENAME(@CurrentIndexName) + ' ON ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName)
          IF @CurrentResumableIndexOperation = 1 SET @CurrentCommand06 = @CurrentCommand06 + ' RESUME'
          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @CurrentResumableIndexOperation = 0 SET @CurrentCommand06 = @CurrentCommand06 + ' REBUILD'
          IF @CurrentAction IN('INDEX_REORGANIZE') AND @CurrentResumableIndexOperation = 0 SET @CurrentCommand06 = @CurrentCommand06 + ' REORGANIZE'
          IF @CurrentIsPartition = 1 AND @CurrentResumableIndexOperation = 0 SET @CurrentCommand06 = @CurrentCommand06 + ' PARTITION = ' + CAST(@CurrentPartitionNumber AS nvarchar)

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @SortInTempdb = 'Y' AND @CurrentIndexType IN(1,2,3,4) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'SORT_IN_TEMPDB = ON'
          END

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @SortInTempdb = 'N' AND @CurrentIndexType IN(1,2,3,4) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'SORT_IN_TEMPDB = OFF'
          END

          IF @CurrentAction = 'INDEX_REBUILD_ONLINE' AND (@CurrentIsPartition = 0 OR @Version >= 12) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'ONLINE = ON' + CASE WHEN @WaitAtLowPriorityMaxDuration IS NOT NULL THEN ' (WAIT_AT_LOW_PRIORITY (MAX_DURATION = ' + CAST(@WaitAtLowPriorityMaxDuration AS nvarchar) + ', ABORT_AFTER_WAIT = ' + UPPER(@WaitAtLowPriorityAbortAfterWait) + '))' ELSE '' END
          END

          IF @CurrentAction = 'INDEX_REBUILD_OFFLINE' AND (@CurrentIsPartition = 0 OR @Version >= 12) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'ONLINE = OFF'
          END

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @CurrentMaxDOP IS NOT NULL
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'MAXDOP = ' + CAST(@CurrentMaxDOP AS nvarchar)
          END

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @FillFactor IS NOT NULL AND @CurrentIsPartition = 0 AND @CurrentIndexType IN(1,2,3,4) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'FILLFACTOR = ' + CAST(@FillFactor AS nvarchar)
          END

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE') AND @PadIndex = 'Y' AND @CurrentIsPartition = 0 AND @CurrentIndexType IN(1,2,3,4) AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'PAD_INDEX = ON'
          END

          IF (@Version >= 14 OR SERVERPROPERTY('EngineEdition') IN (5,8)) AND @CurrentAction = 'INDEX_REBUILD_ONLINE' AND @CurrentResumableIndexOperation = 0
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT CASE WHEN @Resumable = 'Y' AND @CurrentIndexType IN(1,2) AND @CurrentIsComputed = 0 AND @CurrentIsTimestamp = 0 THEN 'RESUMABLE = ON' ELSE 'RESUMABLE = OFF' END
          END

          IF (@Version >= 14 OR SERVERPROPERTY('EngineEdition') IN (5,8)) AND @CurrentAction = 'INDEX_REBUILD_ONLINE' AND @CurrentResumableIndexOperation = 0 AND @Resumable = 'Y'  AND @CurrentIndexType IN(1,2) AND @CurrentIsComputed = 0 AND @CurrentIsTimestamp = 0 AND @TimeLimit IS NOT NULL
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'MAX_DURATION = ' + CAST(DATEDIFF(MINUTE,GETDATE(),DATEADD(ss,@TimeLimit,@StartTime)) AS nvarchar(max))
          END

          IF @CurrentAction IN('INDEX_REORGANIZE') AND @LOBCompaction = 'Y'
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'LOB_COMPACTION = ON'
          END

          IF @CurrentAction IN('INDEX_REORGANIZE') AND @LOBCompaction = 'N'
          BEGIN
            INSERT INTO @CurrentAlterIndexWithClauseArguments (Argument)
            SELECT 'LOB_COMPACTION = OFF'
          END

          IF EXISTS (SELECT * FROM @CurrentAlterIndexWithClauseArguments)
          BEGIN
            SET @CurrentAlterIndexWithClause = ' WITH ('
          END

          SELECT @CurrentAlterIndexWithClause = @CurrentAlterIndexWithClause + Argument + ', '
          FROM @CurrentAlterIndexWithClauseArguments
          ORDER BY ID ASC

          SET @CurrentAlterIndexWithClause = LEFT(@CurrentAlterIndexWithClause,LEN(@CurrentAlterIndexWithClause) - 1)

          IF EXISTS (SELECT * FROM @CurrentAlterIndexWithClauseArguments)
          BEGIN
            SET @CurrentAlterIndexWithClause = @CurrentAlterIndexWithClause + ')'
          END

          IF @CurrentAlterIndexWithClause IS NOT NULL SET @CurrentCommand06 = @CurrentCommand06 + @CurrentAlterIndexWithClause

          EXECUTE @CurrentCommandOutput06 = [dbo].[CommandExecute] @Command = @CurrentCommand06, @CommandType = @CurrentCommandType06, @Mode = 2, @Comment = @CurrentComment06, @DatabaseName = @CurrentDatabaseName, @SchemaName = @CurrentSchemaName, @ObjectName = @CurrentObjectName, @ObjectType = @CurrentObjectType, @IndexName = @CurrentIndexName, @IndexType = @CurrentIndexType, @PartitionNumber = @CurrentPartitionNumber, @ExtENDedInfo = @CurrentExtENDedInfo06, @LockMessageSeverity = @LockMessageSeverity, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput06 = @Error
          IF @CurrentCommandOutput06 <> 0 SET @RETURNCode = @CurrentCommandOutput06

          IF @Delay > 0
          BEGIN
            SET @CurrentDelay = DATEADD(ss,@Delay,'1900-01-01')
            WAITFOR DELAY @CurrentDelay
          END
        END

        SET @CurrentMaxDOP = @MaxDOP

        IF @CurrentStatisticsID IS NOT NULL AND @CurrentUpdateStatistics = 'Y' AND (GETDATE() < DATEADD(ss,@TimeLimit,@StartTime) OR @TimeLimit IS NULL)
        BEGIN
          SET @CurrentCommandType07 = 'UPDATE_STATISTICS'

          SET @CurrentCommand07 = ''
          IF @LockTimeout IS NOT NULL SET @CurrentCommand07 = 'SET LOCK_TIMEOUT ' + CAST(@LockTimeout * 1000 AS nvarchar) + '; '
          SET @CurrentCommand07 = @CurrentCommand07 + 'UPDATE STATISTICS ' + QUOTENAME(@CurrentDatabaseName) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' ' + QUOTENAME(@CurrentStatisticsName)

          IF @CurrentMaxDOP IS NOT NULL AND ((@Version >= 13.05026 AND @Version < 14) OR @Version >= 14.030154)
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'MAXDOP = ' + CAST(@CurrentMaxDOP AS nvarchar)
          END

          IF @CurrentStatisticsSample = 100
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'FULLSCAN'
          END

          IF @CurrentStatisticsSample IS NOT NULL AND @CurrentStatisticsSample <> 100
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'SAMPLE ' + CAST(@CurrentStatisticsSample AS nvarchar) + ' PERCENT'
          END

          IF @CurrentStatisticsResample = 'Y'
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'RESAMPLE'
          END

          IF @CurrentNoRecompute = 1
          BEGIN
            INSERT INTO @CurrentUpdateStatisticsWithClauseArguments (Argument)
            SELECT 'NORECOMPUTE'
          END

          IF EXISTS (SELECT * FROM @CurrentUpdateStatisticsWithClauseArguments)
          BEGIN
            SET @CurrentUpdateStatisticsWithClause = ' WITH'

            SELECT @CurrentUpdateStatisticsWithClause = @CurrentUpdateStatisticsWithClause + ' ' + Argument + ','
            FROM @CurrentUpdateStatisticsWithClauseArguments
            ORDER BY ID ASC

            SET @CurrentUpdateStatisticsWithClause = LEFT(@CurrentUpdateStatisticsWithClause,LEN(@CurrentUpdateStatisticsWithClause) - 1)
          END

          IF @CurrentUpdateStatisticsWithClause IS NOT NULL SET @CurrentCommand07 = @CurrentCommand07 + @CurrentUpdateStatisticsWithClause

          IF @PartitionLevelStatistics = 1 AND @CurrentIsIncremental = 1 AND @CurrentPartitionNumber IS NOT NULL SET @CurrentCommand07 = @CurrentCommand07 + ' ON PARTITIONS(' + CAST(@CurrentPartitionNumber AS nvarchar(max)) + ')'

          EXECUTE @CurrentCommandOutput07 = [dbo].[CommandExecute] @Command = @CurrentCommand07, @CommandType = @CurrentCommandType07, @Mode = 2, @Comment = @CurrentComment07, @DatabaseName = @CurrentDatabaseName, @SchemaName = @CurrentSchemaName, @ObjectName = @CurrentObjectName, @ObjectType = @CurrentObjectType, @IndexName = @CurrentIndexName, @IndexType = @CurrentIndexType, @StatisticsName = @CurrentStatisticsName, @ExtENDedInfo = @CurrentExtENDedInfo07, @LockMessageSeverity = @LockMessageSeverity, @LogToTable = @LogToTable, @Execute = @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput07 = @Error
          IF @CurrentCommandOutput07 <> 0 SET @RETURNCode = @CurrentCommandOutput07
        END

        NoAction:

        -- Update that the index or statistics is completed
        UPDATE @tmpIndexesStatistics
        SET Completed = 1
        WHERE Selected = 1
        AND Completed = 0
        AND ID = @CurrentIxID

        -- Clear variables
        SET @CurrentCommand02 = NULL
        SET @CurrentCommand03 = NULL
        SET @CurrentCommand04 = NULL
        SET @CurrentCommand05 = NULL
        SET @CurrentCommand06 = NULL
        SET @CurrentCommand07 = NULL

        SET @CurrentCommandOutput06 = NULL
        SET @CurrentCommandOutput07 = NULL

        SET @CurrentCommandType06 = NULL
        SET @CurrentCommandType07 = NULL

        SET @CurrentComment06 = NULL
        SET @CurrentComment07 = NULL

        SET @CurrentExtENDedInfo06 = NULL
        SET @CurrentExtENDedInfo07 = NULL

        SET @CurrentIxID = NULL
        SET @CurrentSchemaID = NULL
        SET @CurrentSchemaName = NULL
        SET @CurrentObjectID = NULL
        SET @CurrentObjectName = NULL
        SET @CurrentObjectType = NULL
        SET @CurrentIsMemoryOptimized = NULL
        SET @CurrentIndexID = NULL
        SET @CurrentIndexName = NULL
        SET @CurrentIndexType = NULL
        SET @CurrentStatisticsID = NULL
        SET @CurrentStatisticsName = NULL
        SET @CurrentPartitionID = NULL
        SET @CurrentPartitionNumber = NULL
        SET @CurrentPartitionCount = NULL
        SET @CurrentIsPartition = NULL
        SET @CurrentIndexExists = NULL
        SET @CurrentStatisticsExists = NULL
        SET @CurrentIsImageText = NULL
        SET @CurrentIsNewLOB = NULL
        SET @CurrentIsFileStream = NULL
        SET @CurrentIsColumnStore = NULL
        SET @CurrentIsComputed = NULL
        SET @CurrentIsTimestamp = NULL
        SET @CurrentAllowPageLocks = NULL
        SET @CurrentNoRecompute = NULL
        SET @CurrentIsIncremental = NULL
        SET @CurrentRowCount = NULL
        SET @CurrentModificationCounter = NULL
        SET @CurrentOnReadOnlyFileGroup = NULL
        SET @CurrentResumableIndexOperation = NULL
        SET @CurrentFragmentationLevel = NULL
        SET @CurrentPageCount = NULL
        SET @CurrentFragmentationGroup = NULL
        SET @CurrentAction = NULL
        SET @CurrentMaxDOP = NULL
        SET @CurrentUpdateStatistics = NULL
        SET @CurrentStatisticsSample = NULL
        SET @CurrentStatisticsResample = NULL
        SET @CurrentAlterIndexWithClause = NULL
        SET @CurrentUpdateStatisticsWithClause = NULL

        DELETE FROM @CurrentActionsAllowed
        DELETE FROM @CurrentAlterIndexWithClauseArguments
        DELETE FROM @CurrentUpdateStatisticsWithClauseArguments

      END

    END

    IF DATABASEPROPERTYEX(@CurrentDatabaseName,'Status') = 'SUSPECT'
    BEGIN
      SET @ErrorMessage = 'The database ' + QUOTENAME(@CurrentDatabaseName) + ' is in a SUSPECT state.' + CHAR(13) + CHAR(10) + ' '
      RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
      SET @Error = @@ERROR
    END

    -- Update that the database is completed
    IF @DatabasesInParallel = 'Y'
    BEGIN
      UPDATE dbo.QueueDatabase
      SET DatabaseENDTime = GETDATE()
      WHERE QueueID = @QueueID
      AND DatabaseName = @CurrentDatabaseName
    END
    ELSE
    BEGIN
      UPDATE @tmpDatabases
      SET Completed = 1
      WHERE Selected = 1
      AND Completed = 0
      AND ID = @CurrentDBID
    END

    -- Clear variables
    SET @CurrentDBID = NULL
    SET @CurrentDatabaseID = NULL
    SET @CurrentDatabaseName = NULL
    SET @CurrentIsDatabaseAccessible = NULL
    SET @CurrentAvailabilityGroup = NULL
    SET @CurrentAvailabilityGroupRole = NULL
    SET @CurrentDatabaseMirroringRole = NULL
    SET @CurrentIsReadOnly = NULL

    SET @CurrentCommand01 = NULL

    DELETE FROM @tmpIndexesStatistics

  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  Logging:
  SET @ENDMessage = 'Date and time: ' + CONVERT(nvarchar,GETDATE(),120)
  SET @ENDMessage = REPLACE(@ENDMessage,'%','%%')
  RAISERROR(@ENDMessage,10,1) WITH NOWAIT

  IF @RETURNCode <> 0
  BEGIN
    RETURN @RETURNCode
  END

  ----------------------------------------------------------------------------------------------------

END














GO
/****** Object:  StoredProcedure [dbo].[usp_FIND_OBJECTNAME]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_FIND_OBJECTNAME] (@C VARCHAR(200))
AS
BEGIN
	SELECT DISTINCT SCHEMA_NAME([SO].[schema_id]), OBJECT_NAME([SC].[ID]), [SO].[type_desc]
	FROM syscomments SC
	JOIN sys.objects SO ON [SC].[id] = [SO].[object_id]
	WHERE [text] LIKE @C
END
GO
/****** Object:  StoredProcedure [dbo].[v_PARSE_ERRORLOG]    Script Date: 16/02/2021 10:29:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[v_PARSE_ERRORLOG]
AS
BEGIN
	-- ================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- ================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ================================================================================================================================================================
	--
	-- ================================================================================================================================================================

	--v 1.0

	DECLARE @HOURS INT
	SET @HOURS = 24

	CREATE TABLE #ErrorLog
	(LogDate DATETIME,
	ProcessInfo Varchar(1000),
	vText Varchar(1000))

	INSERT INTO #ErrorLog
	EXEC sp_readerrorlog
	-- EXEC xp_readerrorlog

	SELECT * FROM #ErrorLog 
	WHERE ([vTEXT] LIKE '%ERR%' OR [vTEXT] LIKE '%FAIL%' OR [vTEXT] LIKE '%PAGE%')
	AND [vTEXT] NOT LIKE '%found 0 errors and repaired 0 errors%'
	AND [vTEXT] NOT LIKE '%finished without errors%'
	ORDER BY 1 DESC

	DROP TABLE #ErrorLog

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
USE [master]
GO
ALTER DATABASE [Alchemy_Functions] SET  READ_WRITE 
GO
