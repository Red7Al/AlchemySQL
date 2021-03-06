USE [master]
GO
/****** Object:  Database [Alchemy_Build]    Script Date: 16/02/2021 10:27:30 ******/
CREATE DATABASE [Alchemy_Build]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Alchemy_Build', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Build.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Alchemy_Build_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Build_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Alchemy_Build] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Alchemy_Build].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Alchemy_Build] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Alchemy_Build] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Alchemy_Build] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Alchemy_Build] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Alchemy_Build] SET ARITHABORT OFF 
GO
ALTER DATABASE [Alchemy_Build] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Alchemy_Build] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Alchemy_Build] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Alchemy_Build] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Alchemy_Build] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Alchemy_Build] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Alchemy_Build] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Alchemy_Build] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Alchemy_Build] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Alchemy_Build] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Alchemy_Build] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Alchemy_Build] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Alchemy_Build] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Alchemy_Build] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Alchemy_Build] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Alchemy_Build] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Alchemy_Build] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Alchemy_Build] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Alchemy_Build] SET  MULTI_USER 
GO
ALTER DATABASE [Alchemy_Build] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Alchemy_Build] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Alchemy_Build] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Alchemy_Build] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Alchemy_Build] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Alchemy_Build] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Alchemy_Build', N'ON'
GO
ALTER DATABASE [Alchemy_Build] SET QUERY_STORE = OFF
GO
USE [Alchemy_Build]
GO
/****** Object:  User [WORDPRESS_PHP]    Script Date: 16/02/2021 10:27:30 ******/
CREATE USER [WORDPRESS_PHP] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [sa_PowerBI]    Script Date: 16/02/2021 10:27:30 ******/
CREATE USER [sa_PowerBI] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ALEX_ADMIN]    Script Date: 16/02/2021 10:27:30 ******/
CREATE USER [ALEX_ADMIN] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [WORDPRESS_PHP]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa_PowerBI]
GO
ALTER ROLE [db_owner] ADD MEMBER [ALEX_ADMIN]
GO
/****** Object:  Schema [ARC]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [ARC]
GO
/****** Object:  Schema [BLD]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [BLD]
GO
/****** Object:  Schema [CFG]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [CFG]
GO
/****** Object:  Schema [CSV]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [CSV]
GO
/****** Object:  Schema [DEBUG]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [DEBUG]
GO
/****** Object:  Schema [DIM]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [DIM]
GO
/****** Object:  Schema [DQ]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [DQ]
GO
/****** Object:  Schema [FCT]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [FCT]
GO
/****** Object:  Schema [IMPORT]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [IMPORT]
GO
/****** Object:  Schema [STG]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [STG]
GO
/****** Object:  Schema [XLS]    Script Date: 16/02/2021 10:27:30 ******/
CREATE SCHEMA [XLS]
GO
/****** Object:  UserDefinedTableType [dbo].[EMAIL_TABLE_OF_MESSAGES]    Script Date: 16/02/2021 10:27:30 ******/
CREATE TYPE [dbo].[EMAIL_TABLE_OF_MESSAGES] AS TABLE(
	[MESSAGE_CONTENT] [varchar](2500) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY]    Script Date: 16/02/2021 10:27:30 ******/
CREATE TYPE [dbo].[EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MESSAGE_CONTENT] [varchar](2500) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[InvestmentsToAdd]    Script Date: 16/02/2021 10:27:30 ******/
CREATE TYPE [dbo].[InvestmentsToAdd] AS TABLE(
	[SYMBOL] [varchar](250) NULL,
	[INVESTMENT_NAME] [varchar](250) NULL,
	[INVESTMENT_TYPE] [varchar](250) NULL,
	[SECTOR] [varchar](250) NULL,
	[MARKET] [varchar](250) NULL,
	[LABEL_02] [varchar](50) NULL,
	[LABEL_03] [varchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[InvestmentsToAdd_With_3_Tickers]    Script Date: 16/02/2021 10:27:30 ******/
CREATE TYPE [dbo].[InvestmentsToAdd_With_3_Tickers] AS TABLE(
	[INVESTMENT_NAME] [varchar](250) NULL,
	[INVESTMENT_TYPE] [varchar](250) NULL,
	[SECTOR] [varchar](250) NULL,
	[MARKET] [varchar](250) NULL,
	[ISINCODE] [varchar](50) NULL,
	[CITICODE] [varchar](50) NULL,
	[SEDOL] [varchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SymbolsToProcess]    Script Date: 16/02/2021 10:27:30 ******/
CREATE TYPE [dbo].[SymbolsToProcess] AS TABLE(
	[tColumn01] [varchar](250) NULL,
	[tColumn02] [varchar](250) NULL,
	[tDate] [date] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CREATE_TIME_PERIOD_EXPORT_TABLE]    Script Date: 16/02/2021 10:27:30 ******/
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

	-- DECLARE @TIME_PERIOD VARCHAR(50); SET @TIME_PERIOD = '03 days'
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
/****** Object:  View [CSV].[v_INVESTING_EQ_Technical]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [CSV].[v_INVESTING_EQ_Technical]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2021
	-- 1.0		Initial Release
	--
	-- SELECT * FROM [CSV].[v_EQ_Technical]
	-- EXEC sp_help [CSV].[v_EQ_Technical]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT [Name] -- [ï»¿Name] AS [Name] 
		, [PAIRID]
		, [URL] -- SELECT *
		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive;HDR=YES')...[eq-technical#csv] B
	)

	SELECT * FROM CTE_01_CVS_FILE_IN
GO
/****** Object:  View [CSV].[v_INVESTING_EQ_Technical_MA-WK]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [CSV].[v_INVESTING_EQ_Technical_MA-WK]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2021
	-- 1.0		Initial Release
	-- 1.1		20210208 Simplify and get INVESTMENT_ID in other USP ...
	--
	-- SELECT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-WK]
	-- 20200802 2110 rows = 45 seconds
	-- EXEC sp_help [CSV].[v_INVESTING_EQ_Technical_MA-WK]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT [ï»¿Name] AS [Name] 
		, [Symbol], [PairId], [date time] AS [Export DateTime], [Period]
		, [MA5_Simple_Price],   [MA5_Simple_Summary],   [MA5_Expo_Price],   [MA5_Expo_Summary]
		, [MA10_Simple_Price],  [MA10_Simple_Summary],  [MA10_Expo_Price],  [MA10_Expo_Summary]
		, [MA20_Simple_Price],  [MA20_Simple_Summary],  [MA20_Expo_Price],  [MA20_Expo_Summary]
		, [MA50_Simple_Price],  [MA50_Simple_Summary],  [MA50_Expo_Price],  [MA50_Expo_Summary]
		, [MA100_Simple_Price], [MA100_Simple_Summary], [MA100_Expo_Price], [MA100_Expo_Summary]
		, [MA200_Simple_Price], [MA200_Simple_Summary], [MA200_Expo_Price], [MA200_Expo_Summary]
		-- , [F30]

		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive;HDR=YES')...[WK-eq-technical-MA#csv] B
	)

	-- ******************************************************************************************************************************************
	-- Get URL
	-- ******************************************************************************************************************************************

	, CTE_INVESTING_EQ_Technical AS (SELECT * FROM [CSV].[v_INVESTING_EQ_Technical]) -- 15 seconds -- 2194 rows

	-- ******************************************************************************************************************************************
	-- MATCH ON Symbol
	-- ******************************************************************************************************************************************
	, CTE_FINAL AS (
		SELECT [A1].[Name] 
		, [A1].[Symbol], [A1].[PairId], [A1].[Export DateTime], [A1].[Period]
		, [A1].[MA5_Simple_Price],   [A1].[MA5_Simple_Summary],   [A1].[MA5_Expo_Price],   [A1].[MA5_Expo_Summary]
		, [A1].[MA10_Simple_Price],  [A1].[MA10_Simple_Summary],  [A1].[MA10_Expo_Price],  [A1].[MA10_Expo_Summary]
		, [A1].[MA20_Simple_Price],  [A1].[MA20_Simple_Summary],  [A1].[MA20_Expo_Price],  [A1].[MA20_Expo_Summary]
		, [A1].[MA50_Simple_Price],  [A1].[MA50_Simple_Summary],  [A1].[MA50_Expo_Price],  [A1].[MA50_Expo_Summary]
		, [A1].[MA100_Simple_Price], [A1].[MA100_Simple_Summary], [A1].[MA100_Expo_Price], [A1].[MA100_Expo_Summary]
		, [A1].[MA200_Simple_Price], [A1].[MA200_Simple_Summary], [A1].[MA200_Expo_Price], [A1].[MA200_Expo_Summary]
		-- , [A1].[F30]
		, [B1].[URL]
		, CASE WHEN [URL] LIKE '%etfs%' THEN 'ETF' ELSE 'EQUITY' END AS [Investment Type]
	FROM CTE_01_CVS_FILE_IN A1
	LEFT JOIN [CTE_INVESTING_EQ_Technical] B1 ON [A1].[PairID] = [B1].[PairID])

	-- ******************************************************************************************************************************************
	-- REPORT
	-- ******************************************************************************************************************************************
	SELECT * FROM CTE_FINAL
GO
/****** Object:  View [CSV].[v_INVESTING_EQ_Technical_MA-HR]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [CSV].[v_INVESTING_EQ_Technical_MA-HR]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2021
	-- 1.0		Initial Release
	-- 1.1		20210208 Simplify and get INVESTMENT_ID in other USP ...
	--
	-- SELECT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-HR]
	-- 20200802 2110 rows = 45 seconds
	-- EXEC sp_help [CSV].[v_INVESTING_EQ_Technical_MA-HR]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT [ï»¿Name] AS [Name] 
		, [Symbol], [PairId], [date time] AS [Export DateTime], [Period]
		, [MA5_Simple_Price],   [MA5_Simple_Summary],   [MA5_Expo_Price],   [MA5_Expo_Summary]
		, [MA10_Simple_Price],  [MA10_Simple_Summary],  [MA10_Expo_Price],  [MA10_Expo_Summary]
		, [MA20_Simple_Price],  [MA20_Simple_Summary],  [MA20_Expo_Price],  [MA20_Expo_Summary]
		, [MA50_Simple_Price],  [MA50_Simple_Summary],  [MA50_Expo_Price],  [MA50_Expo_Summary]
		, [MA100_Simple_Price], [MA100_Simple_Summary], [MA100_Expo_Price], [MA100_Expo_Summary]
		, [MA200_Simple_Price], [MA200_Simple_Summary], [MA200_Expo_Price], [MA200_Expo_Summary]
		-- , [F30]

		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive;HDR=YES')...[HR-eq-technical-MA#csv] B
	)

	-- ******************************************************************************************************************************************
	-- Get URL
	-- ******************************************************************************************************************************************

	, CTE_INVESTING_EQ_Technical AS (SELECT * FROM [CSV].[v_INVESTING_EQ_Technical]) -- 15 seconds -- 2194 rows

	-- ******************************************************************************************************************************************
	-- MATCH ON Symbol
	-- ******************************************************************************************************************************************
	, CTE_FINAL AS (
		SELECT [A1].[Name] 
		, [A1].[Symbol], [A1].[PairId], [A1].[Export DateTime], [A1].[Period]
		, [A1].[MA5_Simple_Price],   [A1].[MA5_Simple_Summary],   [A1].[MA5_Expo_Price],   [A1].[MA5_Expo_Summary]
		, [A1].[MA10_Simple_Price],  [A1].[MA10_Simple_Summary],  [A1].[MA10_Expo_Price],  [A1].[MA10_Expo_Summary]
		, [A1].[MA20_Simple_Price],  [A1].[MA20_Simple_Summary],  [A1].[MA20_Expo_Price],  [A1].[MA20_Expo_Summary]
		, [A1].[MA50_Simple_Price],  [A1].[MA50_Simple_Summary],  [A1].[MA50_Expo_Price],  [A1].[MA50_Expo_Summary]
		, [A1].[MA100_Simple_Price], [A1].[MA100_Simple_Summary], [A1].[MA100_Expo_Price], [A1].[MA100_Expo_Summary]
		, [A1].[MA200_Simple_Price], [A1].[MA200_Simple_Summary], [A1].[MA200_Expo_Price], [A1].[MA200_Expo_Summary]
		-- , [A1].[F30]
		, [B1].[URL]
		, CASE WHEN [URL] LIKE '%etfs%' THEN 'ETF' ELSE 'EQUITY' END AS [Investment Type]
	FROM CTE_01_CVS_FILE_IN A1
	LEFT JOIN [CTE_INVESTING_EQ_Technical] B1 ON [A1].[PairID] = [B1].[PairID])

	-- ******************************************************************************************************************************************
	-- REPORT
	-- ******************************************************************************************************************************************
	SELECT * FROM CTE_FINAL
GO
/****** Object:  View [CSV].[v_INVESTING_EQ_Technical_MA-HR5]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [CSV].[v_INVESTING_EQ_Technical_MA-HR5]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2021
	-- 1.0		Initial Release
	-- 1.1		20210208 Simplify and get INVESTMENT_ID in other USP ...
	--
	-- SELECT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-HR5]
	-- 20200802 2110 rows = 45 seconds
	-- EXEC sp_help [CSV].[v_INVESTING_EQ_Technical_MA-HR5]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT [ï»¿Name] AS [Name] 
		, [Symbol], [PairId], [date time] AS [Export DateTime], [Period]
		, [MA5_Simple_Price],   [MA5_Simple_Summary],   [MA5_Expo_Price],   [MA5_Expo_Summary]
		, [MA10_Simple_Price],  [MA10_Simple_Summary],  [MA10_Expo_Price],  [MA10_Expo_Summary]
		, [MA20_Simple_Price],  [MA20_Simple_Summary],  [MA20_Expo_Price],  [MA20_Expo_Summary]
		, [MA50_Simple_Price],  [MA50_Simple_Summary],  [MA50_Expo_Price],  [MA50_Expo_Summary]
		, [MA100_Simple_Price], [MA100_Simple_Summary], [MA100_Expo_Price], [MA100_Expo_Summary]
		, [MA200_Simple_Price], [MA200_Simple_Summary], [MA200_Expo_Price], [MA200_Expo_Summary]
		-- , [F30]

		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive;HDR=YES')...[HR5-eq-technical-MA#csv] B
	)

	-- ******************************************************************************************************************************************
	-- Get URL
	-- ******************************************************************************************************************************************

	, CTE_INVESTING_EQ_Technical AS (SELECT * FROM [CSV].[v_INVESTING_EQ_Technical]) -- 15 seconds -- 2194 rows

	-- ******************************************************************************************************************************************
	-- MATCH ON Symbol
	-- ******************************************************************************************************************************************
	, CTE_FINAL AS (
		SELECT [A1].[Name] 
		, [A1].[Symbol], [A1].[PairId], [A1].[Export DateTime], [A1].[Period]
		, [A1].[MA5_Simple_Price],   [A1].[MA5_Simple_Summary],   [A1].[MA5_Expo_Price],   [A1].[MA5_Expo_Summary]
		, [A1].[MA10_Simple_Price],  [A1].[MA10_Simple_Summary],  [A1].[MA10_Expo_Price],  [A1].[MA10_Expo_Summary]
		, [A1].[MA20_Simple_Price],  [A1].[MA20_Simple_Summary],  [A1].[MA20_Expo_Price],  [A1].[MA20_Expo_Summary]
		, [A1].[MA50_Simple_Price],  [A1].[MA50_Simple_Summary],  [A1].[MA50_Expo_Price],  [A1].[MA50_Expo_Summary]
		, [A1].[MA100_Simple_Price], [A1].[MA100_Simple_Summary], [A1].[MA100_Expo_Price], [A1].[MA100_Expo_Summary]
		, [A1].[MA200_Simple_Price], [A1].[MA200_Simple_Summary], [A1].[MA200_Expo_Price], [A1].[MA200_Expo_Summary]
		-- , [A1].[F30]
		, [B1].[URL]
		, CASE WHEN [URL] LIKE '%etfs%' THEN 'ETF' ELSE 'EQUITY' END AS [Investment Type]
	FROM CTE_01_CVS_FILE_IN A1
	LEFT JOIN [CTE_INVESTING_EQ_Technical] B1 ON [A1].[PairID] = [B1].[PairID])

	-- ******************************************************************************************************************************************
	-- REPORT
	-- ******************************************************************************************************************************************
	SELECT * FROM CTE_FINAL
GO
/****** Object:  View [CSV].[v_INVESTING_EQ_Technical_MA-DY]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [CSV].[v_INVESTING_EQ_Technical_MA-DY]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2021
	-- 1.0		Initial Release
	-- 1.1		20210208 Simplify and get INVESTMENT_ID in other USP ...
	--
	-- SELECT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-DY]
	-- 20200802 2110 rows = 45 seconds
	-- EXEC sp_help [CSV].[v_INVESTING_EQ_Technical_MA-DY]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT [ï»¿Name] AS [Name] 
		, [Symbol], [PairId], [date time] AS [Export DateTime], [Period]
		, [MA5_Simple_Price],   [MA5_Simple_Summary],   [MA5_Expo_Price],   [MA5_Expo_Summary]
		, [MA10_Simple_Price],  [MA10_Simple_Summary],  [MA10_Expo_Price],  [MA10_Expo_Summary]
		, [MA20_Simple_Price],  [MA20_Simple_Summary],  [MA20_Expo_Price],  [MA20_Expo_Summary]
		, [MA50_Simple_Price],  [MA50_Simple_Summary],  [MA50_Expo_Price],  [MA50_Expo_Summary]
		, [MA100_Simple_Price], [MA100_Simple_Summary], [MA100_Expo_Price], [MA100_Expo_Summary]
		, [MA200_Simple_Price], [MA200_Simple_Summary], [MA200_Expo_Price], [MA200_Expo_Summary]
		-- , [F30]

		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive;HDR=YES')...[DY-eq-technical-MA#csv] B
	)

	-- ******************************************************************************************************************************************
	-- Get URL
	-- ******************************************************************************************************************************************

	, CTE_INVESTING_EQ_Technical AS (SELECT * FROM [CSV].[v_INVESTING_EQ_Technical]) -- 15 seconds -- 2194 rows

	-- ******************************************************************************************************************************************
	-- MATCH ON Symbol
	-- ******************************************************************************************************************************************
	, CTE_FINAL AS (
		SELECT [A1].[Name] 
		, [A1].[Symbol], [A1].[PairId], [A1].[Export DateTime], [A1].[Period]
		, [A1].[MA5_Simple_Price],   [A1].[MA5_Simple_Summary],   [A1].[MA5_Expo_Price],   [A1].[MA5_Expo_Summary]
		, [A1].[MA10_Simple_Price],  [A1].[MA10_Simple_Summary],  [A1].[MA10_Expo_Price],  [A1].[MA10_Expo_Summary]
		, [A1].[MA20_Simple_Price],  [A1].[MA20_Simple_Summary],  [A1].[MA20_Expo_Price],  [A1].[MA20_Expo_Summary]
		, [A1].[MA50_Simple_Price],  [A1].[MA50_Simple_Summary],  [A1].[MA50_Expo_Price],  [A1].[MA50_Expo_Summary]
		, [A1].[MA100_Simple_Price], [A1].[MA100_Simple_Summary], [A1].[MA100_Expo_Price], [A1].[MA100_Expo_Summary]
		, [A1].[MA200_Simple_Price], [A1].[MA200_Simple_Summary], [A1].[MA200_Expo_Price], [A1].[MA200_Expo_Summary]
		-- , [A1].[F30]
		, [B1].[URL]
		, CASE WHEN [URL] LIKE '%etfs%' THEN 'ETF' ELSE 'EQUITY' END AS [Investment Type]
	FROM CTE_01_CVS_FILE_IN A1
	LEFT JOIN [CTE_INVESTING_EQ_Technical] B1 ON [A1].[PairID] = [B1].[PairID])

	-- ******************************************************************************************************************************************
	-- REPORT
	-- ******************************************************************************************************************************************
	SELECT * FROM CTE_FINAL
GO
/****** Object:  View [CSV].[v_INVESTING_EQ_Technical_MA-MN]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [CSV].[v_INVESTING_EQ_Technical_MA-MN]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2021
	-- 1.0		Initial Release
	-- 1.1		20210208 Simplify and get INVESTMENT_ID in other USP ...
	--
	-- SELECT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-MN]
	-- 20200802 2110 rows = 45 seconds
	-- EXEC sp_help [CSV].[v_INVESTING_EQ_Technical_MA-MN]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT [ï»¿Name] AS [Name] 
		, [Symbol], [PairId], [date time] AS [Export DateTime], [Period]
		, [MA5_Simple_Price],   [MA5_Simple_Summary],   [MA5_Expo_Price],   [MA5_Expo_Summary]
		, [MA10_Simple_Price],  [MA10_Simple_Summary],  [MA10_Expo_Price],  [MA10_Expo_Summary]
		, [MA20_Simple_Price],  [MA20_Simple_Summary],  [MA20_Expo_Price],  [MA20_Expo_Summary]
		, [MA50_Simple_Price],  [MA50_Simple_Summary],  [MA50_Expo_Price],  [MA50_Expo_Summary]
		, [MA100_Simple_Price], [MA100_Simple_Summary], [MA100_Expo_Price], [MA100_Expo_Summary]
		, [MA200_Simple_Price], [MA200_Simple_Summary], [MA200_Expo_Price], [MA200_Expo_Summary]
		-- , [F30]

		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive;HDR=YES')...[MN-eq-technical-MA#csv] B
	)

	-- ******************************************************************************************************************************************
	-- Get URL
	-- ******************************************************************************************************************************************

	, CTE_INVESTING_EQ_Technical AS (SELECT * FROM [CSV].[v_INVESTING_EQ_Technical]) -- 15 seconds -- 2194 rows

	-- ******************************************************************************************************************************************
	-- MATCH ON Symbol
	-- ******************************************************************************************************************************************
	, CTE_FINAL AS (
		SELECT [A1].[Name] 
		, [A1].[Symbol], [A1].[PairId], [A1].[Export DateTime], [A1].[Period]
		, [A1].[MA5_Simple_Price],   [A1].[MA5_Simple_Summary],   [A1].[MA5_Expo_Price],   [A1].[MA5_Expo_Summary]
		, [A1].[MA10_Simple_Price],  [A1].[MA10_Simple_Summary],  [A1].[MA10_Expo_Price],  [A1].[MA10_Expo_Summary]
		, [A1].[MA20_Simple_Price],  [A1].[MA20_Simple_Summary],  [A1].[MA20_Expo_Price],  [A1].[MA20_Expo_Summary]
		, [A1].[MA50_Simple_Price],  [A1].[MA50_Simple_Summary],  [A1].[MA50_Expo_Price],  [A1].[MA50_Expo_Summary]
		, [A1].[MA100_Simple_Price], [A1].[MA100_Simple_Summary], [A1].[MA100_Expo_Price], [A1].[MA100_Expo_Summary]
		, [A1].[MA200_Simple_Price], [A1].[MA200_Simple_Summary], [A1].[MA200_Expo_Price], [A1].[MA200_Expo_Summary]
		-- , [A1].[F30]
		, [B1].[URL]
		, CASE WHEN [URL] LIKE '%etfs%' THEN 'ETF' ELSE 'EQUITY' END AS [Investment Type]
	FROM CTE_01_CVS_FILE_IN A1
	LEFT JOIN [CTE_INVESTING_EQ_Technical] B1 ON [A1].[PairID] = [B1].[PairID])

	-- ******************************************************************************************************************************************
	-- REPORT
	-- ******************************************************************************************************************************************
	SELECT * FROM CTE_FINAL
GO
/****** Object:  View [CSV].[v_INVESTING_EQ_Technical_MA-ALL]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [CSV].[v_INVESTING_EQ_Technical_MA-ALL]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2021
	-- 1.0		Initial Release
	-- 1.1		20210210 Manage BOO* and IDE* getting BOO INVESTMENT_ID
	-- 1.2		20210211 Add CTE-SIMILAR
	-- 1.3		20210211 Add SYMBOL_ALTERNATIVE
	--
	-- SELECT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-ALL] WHERE ISNULL([SYMBOL_ALTERNATIVE], '') <> ''
	-- 20200702 1401 rows = Between 30 seconds and 150 seconds
	-- EXEC sp_help [CSV].[v_INVESTING_EQ_Technical_MA-ALL]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		-- https://stackoverflow.com/questions/3995958/adding-an-index-to-a-Bte

		SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-WK]
		UNION
		SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-MN]
		UNION
		SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-DY]
		UNION
		SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-HR]
		UNION
		SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-HR5]

		/*
		[Name], [Symbol], [PairId], [Export DateTime], [Period]
		, [MA5_Simple_Price],   [MA5_Simple_Summary],   [MA5_Expo_Price],   [MA5_Expo_Summary]
		, [MA10_Simple_Price],  [MA10_Simple_Summary],  [MA10_Expo_Price],  [MA10_Expo_Summary]
		, [MA20_Simple_Price],  [MA20_Simple_Summary],  [MA20_Expo_Price],  [MA20_Expo_Summary]
		, [MA50_Simple_Price],  [MA50_Simple_Summary],  [MA50_Expo_Price],  [MA50_Expo_Summary]
		, [MA100_Simple_Price], [MA100_Simple_Summary], [MA100_Expo_Price], [MA100_Expo_Summary]
		, [MA200_Simple_Price], [MA200_Simple_Summary], [MA200_Expo_Price], [MA200_Expo_Summary]
		, [F30], [Investment Type], [URL]
		*/
	)

	-- ******************************************************************************************************************************************
	-- SIMPLIFY INVESTMENT_NAME e.g. REMOVE Limited to make name match more likely
	-- ******************************************************************************************************************************************
	,
	CTE_INVESTMENT_ALIAS_NAMES_TMP AS (
	SELECT TOP 100 PERCENT -- https://stackoverflow.com/questions/3995958/adding-an-index-to-a-Bte
	[A01].[INVESTMENT_ID] -- AS [ID]
	, [A01].[INVESTMENT_NAME] AS [INVESTMENT_NAME_ORIGINAL] -- 1 second
	, CASE
		WHEN CHARINDEX(' Ord', [A01].[INVESTMENT_NAME]) <> (0)
		THEN LEFT([A01].[INVESTMENT_NAME], CHARINDEX(' Ord', [A01].[INVESTMENT_NAME]))
		ELSE [A01].[INVESTMENT_NAME]
		END AS [INVESTMENT_NAME_SHORT]
	FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_NAMES] A01)

	, CTE_INVESTMENT_ALIAS_NAMES_SHORT AS (
	SELECT TOP 100 PERCENT -- https://stackoverflow.com/questions/3995958/adding-an-index-to-a-Bte
	[A01].[INVESTMENT_ID], [A01].[INVESTMENT_NAME_ORIGINAL] -- 1 second
	, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	[A01].[INVESTMENT_NAME_SHORT], ' Co ', ''), ' Ord', ''), 'Sys.', 'Systems'), 'Limited', ''), 'Ltd', ''), 'Grp', ''), 'Investment', '')
	, ' Plc', '') 
	, ' ETF', '') 
	, ' GBP', '') 
	, ' Index', '') 
	AS [INVESTMENT_NAME_SHORT]
	FROM CTE_INVESTMENT_ALIAS_NAMES_TMP A01)
	
	-- ******************************************************************************************************************************************
	-- Match on SYMBOL - EXACT
	-- ******************************************************************************************************************************************
	/*
	, CTE_MATCHED_ON_SYMBOL AS (
	SELECT TOP 100 PERCENT -- https://stackoverflow.com/questions/3995958/adding-an-index-to-a-Bte
	[B01].[INVESTMENT_ID]
	, [A01].[PairID]
	FROM CTE_01_CVS_FILE_IN A01
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] B01 ON [A01].[Symbol] = [B01].[LABEL])
	*/ -- SLOW IF THIS STEP IS ADDED 15s --> > 50s

	, CTE_FINAL_MATCHED_ON_SYMBOL AS (
	SELECT TOP 100 PERCENT -- https://stackoverflow.com/questions/3995958/adding-an-index-to-a-Bte
	[B01].[INVESTMENT_ID]
	, [A01].*
	FROM CTE_01_CVS_FILE_IN A01
	-- JOIN CTE_MATCHED_ON_SYMBOL B01 ON [A01].[PairId] = [B01].[PairId])
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] B01 ON [A01].[Symbol] = [B01].[LABEL])

	-- ******************************************************************************************************************************************
	-- Match on SYMBOL - ALTERNATIVE (and name)
	-- ******************************************************************************************************************************************

/*
	, CTE_MATCHED_ON_SYMBOL_ALTERNATIVE AS (
	SELECT TOP 20 -- PERCENT -- https://stackoverflow.com/questions/3995958/adding-an-index-to-a-Bte - PERFORMANCE ISSUES HERE !!!!
	[B01].[INVESTMENT_ID] AS [INVESTMENT_ID]
	, [B01].[LABEL] AS [B_LABEL]
	, [A01].[Name] -- AS [INVESTMENT_NAME]
	, [A01].[Symbol]
	, [C01].[INVESTMENT_NAME]
	, [A01].[PairId]
	FROM CTE_01_CVS_FILE_IN A01
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] B01 ON [B01].[LABEL] = LEFT([A01].[Symbol], LEN([A01].[Symbol]) - (1))
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] C01 ON [B01].[INVESTMENT_ID] = [C01].[ID]
	LEFT JOIN CTE_FINAL_MATCHED_ON_SYMBOL D01 ON [A01].[PairId] = [D01].[PairId] AND [D01].[PairId] IS NULL
	WHERE SOUNDEX([C01].[INVESTMENT_NAME]) = SOUNDEX([A01].[Name])
	AND NOT ([C01].[INVESTMENT_NAME] = 'AVIVA' AND [A01].[Name] = 'Aveva')
	)
*/

	-- ******************************************************************************************************************************************
	-- FINAL REPORT
	-- ******************************************************************************************************************************************
	, CTE_FINAL AS (
		SELECT TOP 100 PERCENT -- https://stackoverflow.com/questions/3995958/adding-an-index-to-a-Bte
		-- 'Match-A' AS [Source],
		[A01].[INVESTMENT_ID], [A01].[Name] 
		, [A01].[Symbol], [A01].[PairId], [A01].[Export DateTime], [A01].[Period]
		, [A01].[MA5_Simple_Price],   [A01].[MA5_Simple_Summary],   [A01].[MA5_Expo_Price],   [A01].[MA5_Expo_Summary]
		, [A01].[MA10_Simple_Price],  [A01].[MA10_Simple_Summary],  [A01].[MA10_Expo_Price],  [A01].[MA10_Expo_Summary]
		, [A01].[MA20_Simple_Price],  [A01].[MA20_Simple_Summary],  [A01].[MA20_Expo_Price],  [A01].[MA20_Expo_Summary]
		, [A01].[MA50_Simple_Price],  [A01].[MA50_Simple_Summary],  [A01].[MA50_Expo_Price],  [A01].[MA50_Expo_Summary]
		, [A01].[MA100_Simple_Price], [A01].[MA100_Simple_Summary], [A01].[MA100_Expo_Price], [A01].[MA100_Expo_Summary]
		, [A01].[MA200_Simple_Price], [A01].[MA200_Simple_Summary], [A01].[MA200_Expo_Price], [A01].[MA200_Expo_Summary]
		-- , [A01].[F30]
		, [A01].[Investment Type], [A01].[URL]
		-- , '' AS [SYMBOL_ALTERNATIVE]
	FROM CTE_FINAL_MATCHED_ON_SYMBOL A01
	
	UNION

	-- ******************************************************************************************************************************************
	-- MATCH ON NAME
	-- ******************************************************************************************************************************************
	SELECT
		-- 'Match-B' AS [Source],
		[B01].[INVESTMENT_ID] -- [B01].[ID]
		, [A01].[Name] 
		, [A01].[Symbol], [A01].[PairId], [A01].[Export DateTime], [A01].[Period]
		, [A01].[MA5_Simple_Price],   [A01].[MA5_Simple_Summary],   [A01].[MA5_Expo_Price],   [A01].[MA5_Expo_Summary]
		, [A01].[MA10_Simple_Price],  [A01].[MA10_Simple_Summary],  [A01].[MA10_Expo_Price],  [A01].[MA10_Expo_Summary]
		, [A01].[MA20_Simple_Price],  [A01].[MA20_Simple_Summary],  [A01].[MA20_Expo_Price],  [A01].[MA20_Expo_Summary]
		, [A01].[MA50_Simple_Price],  [A01].[MA50_Simple_Summary],  [A01].[MA50_Expo_Price],  [A01].[MA50_Expo_Summary]
		, [A01].[MA100_Simple_Price], [A01].[MA100_Simple_Summary], [A01].[MA100_Expo_Price], [A01].[MA100_Expo_Summary]
		, [A01].[MA200_Simple_Price], [A01].[MA200_Simple_Summary], [A01].[MA200_Expo_Price], [A01].[MA200_Expo_Summary]
		-- , [A01].[F30]
		, [A01].[Investment Type], [A01].[URL]
		-- , NULL
	FROM CTE_01_CVS_FILE_IN A01 -- CTE_FINAL_ALTERNATIVE_SYMBOL A01
	JOIN CTE_INVESTMENT_ALIAS_NAMES_SHORT B01 ON [B01].[INVESTMENT_NAME_SHORT] = [A01].[Name]
	-- Check it has not already in the RESULT SET ....
	LEFT JOIN CTE_FINAL_MATCHED_ON_SYMBOL C01 ON [C01].[PairId] = [A01].[PairId] WHERE [C01].[PairId] IS NULL

	-- ******************************************************************************************************************************************
	-- UNION
	-- ******************************************************************************************************************************************
	/*
	UNION

	-- ******************************************************************************************************************************************
	-- MATCH ON ALTERNATIVE SYMBOL
	-- ******************************************************************************************************************************************
	SELECT -- 20210211 TOO SLOW SO MOVED TO [BLD].[usp_BUILD_IMPORT_XLS_FILE_INVESTING_TI_MA]
		'Match-C' AS [Source],
		[B01].[INVESTMENT_ID] -- [B01].[ID]
		, [A01].[Name] 
		, [A01].[Symbol], [A01].[PairId], [A01].[Export DateTime], [A01].[Period]
		, [A01].[MA5_Simple_Price],   [A01].[MA5_Simple_Summary],   [A01].[MA5_Expo_Price],   [A01].[MA5_Expo_Summary]
		, [A01].[MA10_Simple_Price],  [A01].[MA10_Simple_Summary],  [A01].[MA10_Expo_Price],  [A01].[MA10_Expo_Summary]
		, [A01].[MA20_Simple_Price],  [A01].[MA20_Simple_Summary],  [A01].[MA20_Expo_Price],  [A01].[MA20_Expo_Summary]
		, [A01].[MA50_Simple_Price],  [A01].[MA50_Simple_Summary],  [A01].[MA50_Expo_Price],  [A01].[MA50_Expo_Summary]
		, [A01].[MA100_Simple_Price], [A01].[MA100_Simple_Summary], [A01].[MA100_Expo_Price], [A01].[MA100_Expo_Summary]
		, [A01].[MA200_Simple_Price], [A01].[MA200_Simple_Summary], [A01].[MA200_Expo_Price], [A01].[MA200_Expo_Summary]
		, [A01].[F30], [A01].[Investment Type], [A01].[URL]
		, NULL
	FROM CTE_01_CVS_FILE_IN A01 -- CTE_FINAL_ALTERNATIVE_SYMBOL A01
	JOIN CTE_MATCHED_ON_SYMBOL_ALTERNATIVE B01 ON [B01].[PairID] = [A01].[PairId]
	-- Check it has not already in the RESULT SET ....
	LEFT JOIN CTE_FINAL_MATCHED_ON_SYMBOL C01 ON [C01].[PairId] = [A01].[PairId] WHERE [C01].[PairId] IS NULL
	-- LEFT JOIN CTE_INVESTMENT_ALIAS_NAMES_SHORT
	*/
	)

	SELECT * FROM CTE_FINAL
	-- CTE_MATCHED_ON_SYMBOL_ALTERNATIVE
	-- CTE_MATCHED_ON_SYMBOL_ALTERNATIVE_TMP -- CTE_FINAL -- CTE_MATCHED_ON_SYMBOL_ALTERNATIVE
GO
/****** Object:  View [CSV].[v_DIRECTOR_DEALS]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [CSV].[v_DIRECTOR_DEALS]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2019
	-- 1.0		Initial Release
	-- 1.1		20191003 Force call of [fnRemoveNonNumericCharacters] function for [Current ratio (mrq)]
	--
	-- SELECT * FROM [CSV].[v_DIRECTOR_DEALS] -- where ticker in ('TPOS')
	-- SELECT TICKER FROM [CSV].[v_DIRECTOR_DEALS] GROUP BY TICKER HAVING COUNT(*) > 1
	-- EXEC sp_help [CSV.v_DIRECTOR_DEALS]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT DISTINCT
		[ï»¿Declared] AS [Declared]
		, CONVERT(DATE, [Dealt]) AS [Dealt]
		, CONVERT(VARCHAR(10), [Type]) AS [TransactionType]
		, CONVERT(VARCHAR(10), [Epic]) AS [Epic]
		, CONVERT(VARCHAR(75), [Company]) AS [Company]
		, CONVERT(VARCHAR(50), [Director]) AS [Director]
		, [Pos] AS [Position]
		, [Shares]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Price])) / (100) AS [Price_GBP]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value])) AS [Value_GBP]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Current Price])) / (100) AS [CurrentPrice_GBP]
		, CONVERT(FLOAT, [% Gain]) / (100) AS [% Gain]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Gain])) AS [Gain_GBP]
		-- , [NoName]

		-- SELECT * 
		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive\;HDR=YES')...[DIRECTOR_DEALS#csv] B1
		WHERE [Dealt] IS NOT NULL
	)

	SELECT * FROM CTE_01_CVS_FILE_IN
GO
/****** Object:  View [CSV].[v_HLWealth50]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [CSV].[v_HLWealth50]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2019
	--
	-- 1.0
	-- 1.1		20191129 Added [INVESTMENT_ID]
	--
	-- SELECT * FROM [CSV].[v_HLWealth50]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT 
		[ï»¿ACC SEDOL] AS [SEDOL_ACC]
		, [INC SEDOL] AS [SEDOL_INC]
		, [ACC ISIN] AS [ISIN_ACC]
		, [INC ISIN] AS [ISIN_INC]
		, [stock_title] AS [StockTitle]
		, [Class] AS [Class]

		-- SELECT * 
		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive\;HDR=YES')...[HLWealth50#csv] B1
		-- WHERE [Dealt] IS NOT NULL
	)

	SELECT DISTINCT [A1].*, [B1].[INVESTMENT_ID]
	FROM CTE_01_CVS_FILE_IN A1 JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] B1
	ON [A1].[ISIN_ACC] = [B1].[LABEL] OR [A1].[ISIN_INC] = [B1].[LABEL] OR [A1].[SEDOL_ACC] = [B1].[LABEL] OR [A1].[SEDOL_INC] = [B1].[LABEL]	
GO
/****** Object:  View [CSV].[v_SHORT_TRACKER_DETAIL]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [CSV].[v_SHORT_TRACKER_DETAIL]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	July 2019
	-- 1.0		Initial Release
	-- 1.1		20190729 Remove limit on 6 months of data
	-- 1.2		20191022 - Handle dodgy data "Connor" until EXE sorted
	--
	/*
	SELECT *
	INTO #v_SHORT_TRACKER_DETAIL -- DROP TABLE #v_SHORT_TRACKER_DETAIL
	FROM [Alchemy_Build].[CSV].[v_SHORT_TRACKER_DETAIL]

	SELECT DISTINCT [DateOfExport]
	FROM #v_SHORT_TRACKER_DETAIL

	SELECT TOP 250 *
	FROM #v_SHORT_TRACKER_DETAIL
	WHERE LEN([Ticker]) > (4) -- OR [Company] LIKE 'Sains%' OR [Company] LIKE 'Wood Group%'

	SELECT DISTINCT [Ticker], [Company]
	INTO #A -- DROP TABLE #A
	FROM #v_SHORT_TRACKER_DETAIL
	WHERE [Ticker] IS NOT NULL
	-- 541 without date restriction
	-- 299 with date restriction

	SELECT * FROM #A
	WHERE [Ticker] IN (SELECT [Ticker] FROM #A GROUP BY [Ticker] HAVING COUNT(*) > (1))

	/*
	MRO	MELROSE INDUSTRIES PLC
	MRO	MELROSE INDUSTRIES PLC - Old
	*/

	SELECT *
	INTO #A_OK -- DROP TABLE #A_OK
	FROM #A
	WHERE [Ticker] NOT IN (SELECT [Ticker] FROM #A GROUP BY [Ticker] HAVING COUNT(*) > (1))
	-- 297 rows

	-- Ticker Matches with [DIM].[v_INVESTMENT]
	SELECT -- TOP 2000 *
	[B1].[Primary_Label], [B1].[Investment_Name]
	FROM #A_OK A1
	JOIN [ALCHEMY_DATA].[DIM].[v_INVESTMENT] B1 ON [A1].[Ticker] = [B1].[PRIMARY_LABEL]
	GROUP BY [B1].[Primary_Label], [B1].[Investment_Name]
	-- 281 rows on 26 July 2019

	-- MISSING Tickers in [DIM].[v_INVESTMENT] ???
	SELECT DISTINCT [C1].[Company], [C1].[Ticker] -- ROWS IN SHORT BUT NOT INVESTMENT TABLE
	FROM #A_OK A1
	JOIN [CSV].[v_SHORT_TRACKER_DETAIL] C1 ON [A1].[Ticker] = [C1].[Ticker]
	LEFT JOIN [ALCHEMY_DATA].[DIM].[v_INVESTMENT] B1 ON [A1].[Ticker] = [B1].[PRIMARY_LABEL]
	WHERE [B1].[Primary_Label] IS NULL
	-- 16 rows on 27 July 2019

	/*
	AFRICAN MINERALS LTD	AMI
	AGA RANGEMASTER GROUP PLC	AGA
	ALENT PLC	ALNT
	CAIRN HOMES PLC	CRN
	EURASIAN NATURAL RESOURCES	ENRC
	EVR HOLDINGS PLC	EVRH
	FLOWTECH FLUIDPOWER PLC	FLO
	GW PHARMACEUTICALS PLC	GWP
	HOME RETAIL GROUP	HOME
	IMAGINATION TECH GROUP PLC	IMG
	LIVANOVA PLC	LIVN
	Non-Standard Finance plc	NSF
	NOVAE GROUP	NVA
	OLD MUTUAL PLC	OML
	PROSPEX OIL AND GAS PLC	PXOG
	SUPERGROUP PLC	SGP
	*/

	DROP TABLE #A
	DROP TABLE #A_OK

	SELECT TOP 250 [A1].*, [B1].[INVESTMENT_NAME]
	FROM #v_SHORT_TRACKER_DETAIL A1
	LEFT JOIN [ALCHEMY_DATA].[DIM].[v_INVESTMENT] B1 ON [A1].[Ticker] = [B1].[PRIMARY_LABEL]
	WHERE [Date Changed] > DATEADD(DD, -14, GETDATE())
	AND [Current_YN] = (1)
	ORDER BY [DATE CHANGED] DESC, ABS([Change_Pct]) DESC

	select * from #v_SHORT_TRACKER_DETAIL
	where Company = 'CAIRN ENERGY PLC'
	and [fund] = 'Marshall Wace LLP' --'WorldQuant LLC'
	order by [Current_YN], 
	[Date Changed] DESC

	-- Reconcile with WEB PAGE
	SELECT [Company], COUNT(*)
	FROM #v_SHORT_TRACKER_DETAIL
	WHERE [Current_YN] = (1)
	GROUP BY [Company]
	ORDER BY 2 DESC

	-- Reconcile with WEB PAGE
	SELECT [Company], SUM([% short])
	FROM #v_SHORT_TRACKER_DETAIL
	WHERE [Current_YN] = (1)
	GROUP BY [Company]
	ORDER BY 2 DESC

	SELECT * FROM #v_SHORT_TRACKER_DETAIL
	WHERE [Ticker] = 'DEB'
	ORDER BY [Current_YN] DESC, [Date Changed] DESC

	DROP TABLE #v_SHORT_TRACKER_DETAIL
	*/
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT
		[B1].[ï»¿Company] AS [Company]
		, [B1].[Ticker]
		, [alchemy_functions].[dbo].[fnpropercase]([B1].[Fund]) AS [Fund]
		, REPLACE([B1].[% short], '%', '') AS [% short]
		, REPLACE([B1].[change], '%', '') AS [Change_Pct]
		, LEFT([B1].[Date Changed], 11) AS [Date Changed] -- CONVERT(DATE, [Date Changed]) AS [Date Changed]
		, CONVERT(DATETIME, [B1].[DateOfExport]) AS [DateOfExport]
		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive\;HDR=YES')...[ShortTrackerDetail#csv] B1
		/* NEEDED DURING DEVELOPMENT
		WHERE LEFT([B1].[Date Changed],11) LIKE '[0-9][0-9] [A-Z][A-Z][A-Z] 20[0-9][0-9]'
		OR LEFT([B1].[Date Changed],10) LIKE '[0-9] [A-Z][A-Z][A-Z] 20[0-9][0-9]'
		*/
		WHERE [DateOfExport] IS NOT NULL -- 1 row ...
		AND [% short] LIKE '[0-9]%' -- "Connor"
	)
	
	, CTE_02_CURRENT AS (
		SELECT [A1].[Company], [A1].[Ticker], [A1].[Fund]
		, CONVERT(FLOAT, [A1].[% short]) AS [% short]
		, CONVERT(FLOAT, [A1].[Change_Pct]) AS [Change_Pct]
		, CONVERT(DATE, [A1].[Date Changed]) AS [Date Changed]
		, [A1].[DateOfExport]
		-- , (1) AS [Current_YN]
		FROM CTE_01_CVS_FILE_IN A1
		WHERE [A1].[Change_Pct] IS NOT NULL
	)

	, CTE_03_PREVIOUS AS (
		SELECT [A1].[Company], [A1].[Ticker], [A1].[Fund]
		, CONVERT(FLOAT, [A1].[% short]) AS [% short]
		, CONVERT(FLOAT, [A1].[Change_Pct]) AS [Change_Pct]
		, CONVERT(DATE, [A1].[Date Changed]) AS [Date Changed]
		, [A1].[DateOfExport]
		FROM CTE_01_CVS_FILE_IN A1
		WHERE [Change_Pct] IS NULL
		AND NOT EXISTS (SELECT 1 FROM CTE_02_CURRENT B1 WHERE [A1].[Ticker] = [B1].[Ticker] AND [A1].[Fund] = [B1].[Fund] AND [A1].[Date Changed] = [B1].[Date Changed])
		-- AND ISNULL([A1].[Date Changed], GETDATE()) > DATEADD(DD, -180, GETDATE()) -- 6 months only changes to look - change higher if needed
	)

	, CTE_04_GET_SORTID AS (
		SELECT (0) AS [SortId]
		, [A1].[Company], [A1].[Ticker], [A1].[Fund], [A1].[% short], [A1].[Change_Pct], [A1].[Date Changed], [A1].[DateOfExport]
		, (1) AS [Current_YN]
		FROM CTE_02_CURRENT A1
		UNION
		SELECT ROW_NUMBER() OVER (ORDER BY [A1].[Ticker], [A1].[Fund], [A1].[Date Changed]) AS [SortID]
		, [A1].[Company], [A1].[Ticker], [A1].[Fund], [A1].[% short], [A1].[Change_Pct], [A1].[Date Changed], [A1].[DateOfExport]
		, (0) AS [Current_YN]
		FROM CTE_03_PREVIOUS A1
	)

	SELECT [A1].[SortID]
	, [A1].[Company]
	, [A1].[Ticker]
	, [A1].[Fund]
	, [A1].[% short]
	, [A1].[Change_Pct]
	, CASE WHEN [A1].[Change_Pct] IS NULL
		THEN
			CASE WHEN [B1].[% short] IS NOT NULL
				THEN ([A1].[% short] - [B1].[% short])
				ELSE [A1].[% short] -- NULL -- IT MAY BE LIMIT OF 6 MONTHS DATA THAT MAKES THIS LOOK LIKE FIRST SHORT [A1].[% short]
				END
		ELSE [A1].[Change_Pct]
		END AS [CALC_CHANGE_PCT]
	, [A1].[Date Changed]
	, [A1].[DateOfExport]
	, [A1].[Current_YN]
	FROM CTE_04_GET_SORTID A1
	LEFT JOIN CTE_04_GET_SORTID B1 ON [A1].[TICKER] = [B1].[TICKER] AND [A1].[Fund] = [B1].[Fund] AND [A1].[SortID] = [B1].[SortID] + (1)
	-- WHERE [A1].[Current_YN] = (1) OR ([A1].[Current_YN] = (0) AND ISNULL([A1].[Date Changed], GETDATE()) > DATEADD(DD, -180, GETDATE())) -- 6 months only changes to look - change higher if needed
GO
/****** Object:  View [CSV].[v_STOCK_EXCHANGE_INVESTMENT_INDICES]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [CSV].[v_STOCK_EXCHANGE_INVESTMENT_INDICES]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190507 Read file from C:\Users\Alex\OneDrive\
	--
	-- SET DATEFORMAT DMY -- !!
	--
	-- SELECT * FROM [STG].[v_STOCK_EXCHANGE_INVESTMENT_INDICES] WHERE [IndexName] = 'FTSE AIM 50'
	-- SELECT [IndexName], COUNT(*) FROM [STG].[v_STOCK_EXCHANGE_INVESTMENT_INDICES] GROUP BY [IndexName]
	--
	-- NEEDED FOR [usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES]
	-- ******************************************************************************************************************************************

	SELECT DISTINCT -- e.g. multi rows for WIZZ
	CONVERT(DATETIME, [B].[ï»¿DATE & TIME]) AS [ExportDate]
	, (SELECT TOP (1) [ID] FROM [Alchemy_Data].[DIM].[v_INVESTMENT] A -- [AZURE_R7_ALCHEMY_DATA].
		WHERE REPLACE([A].[PRIMARY_LABEL],'.L','') = REPLACE([B].[Code],'.L','')) AS [EST_INVESTMENT_ID]
	, (SELECT COUNT(*) FROM [Alchemy_Data].[DIM].[v_INVESTMENT] A -- [AZURE_R7_ALCHEMY_DATA].
		WHERE REPLACE([A].[PRIMARY_LABEL],'.L','') = REPLACE([B].[Code],'.L','')) AS [EST_INVESTMENT_ID_COUNT]
	, [B].[INDEX NAME] AS [IndexNameShort]
	, CASE [B].[INDEX NAME]
		WHEN 'ASX'  THEN 'FTSE All-Share'
		WHEN 'UKX'  THEN 'FTSE 100'
		WHEN 'MCX'  THEN 'FTSE 250'
		WHEN 'SMX'  THEN 'FTSE Small Cap'
		WHEN 'NMX'  THEN 'FTSE 350'
		WHEN 'AIM1' THEN 'FTSE AIM 100'
		WHEN 'AIM5' THEN 'FTSE AIM 50'
		ELSE 'Dunno'
	END AS [IndexName]
	, [B].[CODE] AS [Ticker]
	, [B].[NAME] AS [Investment Name]
	, [B].[Currency]
	, [B].[Price]
	, [B].[+/-] AS [ABS_Change]
	, [B].[%+/-] AS [PCT_Change]

	-- SELECT * 
	-- FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\;HDR=YES')...[STOCK_EXCHANGE_INVESTMENT_SECTOR#csv] B
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive\;HDR=YES')...[STOCK_EXCHANGE_INVESTMENT_SECTOR#csv] B
	WHERE [ï»¿DATE & TIME] IS NOT NULL
GO
/****** Object:  View [CSV].[v_TELEGRAPH_INDICES]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [CSV].[v_TELEGRAPH_INDICES]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	-- 1.1		20190213 Remove call to [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190507 Read file from C:\Users\Alex\OneDrive\
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT TOP (100) * FROM [STG].[v_TELEGRAPH_SECTOR]
	--
	-- SELECT DISTINCT [EPIC], [NAME] FROM [STG].[v_TELEGRAPH_INDICES] WHERE [EST_INVESTMENT_ID] IS NULL
	-- SELECT TOP (100) * FROM [STG].[v_TELEGRAPH_INDICES] ORDER BY EPIC
	-- SELECT [INDICES], COUNT(*) FROM [STG].[v_TELEGRAPH_INDICES] GROUP BY [INDICES]
	-- ******************************************************************************************************************************************

	WITH CTE AS (SELECT [LABEL], [INVESTMENT_ID], [crDate] FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS]  -- [AZURE_R7_ALCHEMY_DATA].
	)

	SELECT [ï»¿Indice] AS [Indices]
	, [EPIC]
	, (SELECT TOP (1) [INVESTMENT_ID] FROM CTE A WHERE REPLACE([A].[LABEL],'.L','') = REPLACE([B].[EPIC],'.L','') ORDER BY [crDate] DESC) AS [EST_INVESTMENT_ID]
	, (SELECT COUNT(*) FROM CTE A WHERE REPLACE([A].[LABEL],'.L','') = REPLACE([B].[EPIC],'.L','')) AS [EST_INVESTMENT_ID_CNT]
/*
	, (SELECT DISTINCT [ID] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] A
		WHERE REPLACE([A].[PRIMARY_LABEL],'.L','') = REPLACE([B].[EPIC],'.L','')) AS [EST_INVESTMENT_ID]
*/	-- , MIN([Name]) AS [NAME]
	, [NAME]
	-- , MIN([DateOfExport]) AS [DateOfExport]
	, [DateOfExport]
	-- SELECT *
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive\;HDR=YES')...[TELEGRAPH_INDICES#csv] B
	-- ORDER BY 4 DESC
GO
/****** Object:  View [CSV].[v_TELEGRAPH_SECTOR]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [CSV].[v_TELEGRAPH_SECTOR]
AS

	-- ****************************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	-- 1.1		20190212 Stop call to [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190218 Rename STG to dbo (due to proper use of STG in ALCHEMY_DATA)
	-- 1.3		20190507 Read file from C:\Users\Alex\OneDrive\
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT TOP (250) * FROM [dbo].[v_TELEGRAPH_SECTOR] WHERE [EST_INVESTMENT_ID] IS NOT NULL ORDER BY [EPIC]
	-- SELECT TOP (250) * FROM [dbo].[v_TELEGRAPH_SECTOR] WHERE [EST_INVESTMENT_ID_COUNT] <> (1)
	-- SELECT TOP (250) * FROM [dbo].[v_TELEGRAPH_SECTOR] ORDER BY [EST_SECTOR_ID_COUNT]
	-- SELECT * FROM [dbo].[v_TELEGRAPH_SECTOR]
	-- ****************************************************************************************************************************************************

	WITH CTE_INVESTMENT AS
	(SELECT REPLACE([A].[PRIMARY_LABEL],'.L','') AS [PRIMARY_LABEL]
	, [A].[ID]
	FROM [Alchemy_Data].[DIM].[v_INVESTMENT] A) -- [AZURE_R7_ALCHEMY_DATA].

	, CTE_SECTOR AS
	(SELECT REPLACE(
			REPLACE(
			REPLACE(
			REPLACE([SECTOR]
			-- Stock Exchange (DIM.SECTOR), Telegraph
			, 'Oil Equipment & Services','Oil Equipment; Services & Distribution')
			, 'Household Goods & Construction','Household Goods & Home Construction')
			, 'Industrial Metals & Mining', 'Industrial Metals')
			, ' &', '')
	AS [SECTOR] -- Get 'Stock Exchange' sectors translated to 'Telegraph'
	, [ID]
	FROM [Alchemy_Data].[DIM].[SECTORS]) -- [AZURE_R7_ALCHEMY_DATA].

	/*
	DIM.SECTORS
	Industrial Metals & Mining
	Household Goods & Construction
	Oil Equipment & Services

	TELEGRAPH CSV
	Industrial Metals
	Household Goods & Home Construction
	Oil Equipment; Services & Distribution
	*/

	, CTE_CSV AS
	( SELECT [B].[ï»¿Sector] AS [Sector]
	, REPLACE([B].[EPIC],'.L','') AS [EPIC]
	, [B].[Name]
	, [B].[Price] / (100) AS [PRICE_GBP] -- GBX TO GBP
	, [B].[Market Cap]
	, [B].[DateOfExport] -- SELECT * 
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive\;HDR=YES')...[TELEGRAPH#csv] B
	)

	SELECT [Sector]
	, REPLACE([B].[Sector], ' &','') AS [DUMMY]
	, (SELECT TOP (1) [ID] FROM CTE_INVESTMENT A WHERE [A].[PRIMARY_LABEL] = [B].[EPIC]) AS [EST_INVESTMENT_ID]
	, (SELECT COUNT(*)  FROM CTE_INVESTMENT A WHERE [A].[PRIMARY_LABEL] = [B].[EPIC]) AS [EST_INVESTMENT_ID_COUNT]
	, (SELECT TOP (1) [ID] FROM CTE_SECTOR A WHERE [A].[Sector] = REPLACE([B].[Sector], ' &','')) AS [EST_SECTOR_ID]
	, (SELECT COUNT(*)  FROM CTE_SECTOR A WHERE [A].[Sector] = REPLACE([B].[Sector], ' &','')) AS [EST_SECTOR_ID_COUNT]
	, [EPIC]
	, [Name]
	, [PRICE_GBP]
	, CASE WHEN [Market Cap] LIKE '%[A-Z]%' THEN (0) ELSE CONVERT(FLOAT, [Market Cap]) END AS [Market Cap]
	, [DateOfExport]
	FROM CTE_CSV B
GO
/****** Object:  View [CSV].[v_VectortVest]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [CSV].[v_VectortVest]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2019
	-- 1.0		Initial Release
	-- 1.1		20191003 Force call of [fnRemoveNonNumericCharacters] function for [Current ratio (mrq)]
	--
	-- SELECT * FROM [CSV].[v_DIRECTOR_DEALS] -- where ticker in ('TPOS')
	-- SELECT TICKER FROM [CSV].[v_DIRECTOR_DEALS] GROUP BY TICKER HAVING COUNT(*) > 1
	-- EXEC sp_help [CSV.v_DIRECTOR_DEALS]

	/*
	SELECT * FROM [ALCHEmy_data].[DIM].[v_INVESTMENT]
	WHERE INVESTMENT_TYPE_NAME = 'Equity'
	and [ceased trading confirmed] <> 1
	and problematic <> 1
	AND [PRIMARY_LABEL] + '.L' NOT IN (SELECT Symbol FROM [CSV].[v_VectortVest])
	ORDER BY 1

	SELECT * FROM [CSV].[v_VectortVest] ORDER BY 1

	SELECT 'EXEC [dbo].[usp_ADD_INVESTMENT] @INVESTMENT_NAME = ''' + [CompanyName] +''', @LABEL = '''+REPLACE(Symbol,'.L', '') + ''', @INVESTMENT_TYPE = N''Equity'', @SECTOR = '
	+ '''%' + SectorName + '%'', @MARKET = N''%fledg%'''
	FROM [CSV].[v_VectortVest]
	WHERE REPLACE(SYMBOL,'.L','') NOT IN (SELECT REPLACE([PRIMARY_LABEL], '.','') FROM [ALCHEmy_data].[DIM].[v_INVESTMENT] )
	AND IndName NOT LIKE 'Market%'
	AND SYMBOL NOT LIKE '%[-]%'
	AND SYMBOL NOT LIKE '%[/]%'
	-- and sectorName <> 'Business Svc'
	ORDER BY 1

	-- Real Estate Management
	-- Auto & Truck -- > Automobiles

	select 'YAHOO_FINANCE_EQUITIES_02.csv,' + [Primary_label] + '.L', crdate
	, 'YAHOO_FINANCE_STATISTICS.csv,' + [Primary_label] + '.L'
	from alchemy_data.dim.v_investment where crdate > '22 nov 2019 12pm' order by primary_label

	*/

	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT 
		CompanyName, Symbol, IndName, SectorName
		-- SELECT * 
		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive\;HDR=YES')...[VectorVestExport#csv] B1
		-- WHERE [Dealt] IS NOT NULL
	)

	SELECT * FROM CTE_01_CVS_FILE_IN
GO
/****** Object:  View [CSV].[v_YAHOO_FINANCE_STATISTICS]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [CSV].[v_YAHOO_FINANCE_STATISTICS] AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	September 2019
	-- 1.0		Initial Release
	-- 1.1		20191003 Force call of [fnRemoveNonNumericCharacters] function for [Current ratio (mrq)]
	-- 1.2		20191014 Force call of [fnRemoveNonNumericCharacters] function for multiple ..
	-- 1.3		20191015 Look for unique TICKER eg FERG
	-- 1.4		20191027 [ForwardAnnualDividendYieldPCT] DIV 100
	--
	-- SELECT * FROM [CSV].[v_YAHOO_FINANCE_STATISTICS] WHERE [INVESTMENT_ID] IS NULL
	/*
	INSERT INTO DIM.INVESTMENT_ALIAS (INVESTMENT_ID, LABEL, ALIAS_TYPE, ENABLED, crNotes, PRIMARY_ALIAS)
	SELECT INVESTMENT_ID, REPLACE(LABEL, '.',''), 'ISIN', 1, 'Added for YAHOO STATISTICS match', (0)
	FROM DIM.INVESTMENT_ALIASwhere LABEL in ('0UJGG.','AV.','BA.','BP.','HL.','ICON.','JD.','NG.','QQ.','RB.','RE.','RM.','RR.','SN.','TW.','UU.','VP.','WG.')
	*/
	-- SELECT * FROM [CSV].[v_YAHOO_FINANCE_STATISTICS] WHERE [TICKER] LIKE 'AV%'
	-- SELECT * FROM [CSV].[v_YAHOO_FINANCE_STATISTICS] WHERE [TICKER] IN ('FERG')
	-- SELECT TICKER FROM [CSV].[v_YAHOO_FINANCE_STATISTICS] GROUP BY TICKER HAVING COUNT(*) > 1
	-- EXEC sp_help [CSV.v_YAHOO_FINANCE_STATISTICS]
	-- ******************************************************************************************************************************************

	WITH CTE_01_CVS_FILE_IN AS (
		SELECT DISTINCT
		LEFT(REPLACE([ï»¿TICKER],'.L',''),(6)) AS [TICKER]
		, LEFT([Name], (50)) AS [Name]
		, CASE WHEN CHARINDEX([ï»¿TICKER], [Name]) - (3) > 3 THEN LEFT([Name], CHARINDEX([﻿ï»¿TICKER], [Name]) - (3)) ELSE [Name] END AS [Name2]
		, CONVERT(DATE, [Date Of Export]) AS [Date Of Export]
		
		, CASE WHEN [Market cap (intra-day)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Market cap (intra-day)], 'M', '')) 
		WHEN [Market cap (intra-day)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Market cap (intra-day)], 'T', '')) * (1000) * (1000)
		WHEN [Market cap (intra-day)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Market cap (intra-day)], 'B', '')) * (1000)
		WHEN [Market cap (intra-day)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Market cap (intra-day)], 'K', '')) / (1000)
		WHEN [Market cap (intra-day)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Market cap (intra-day)], 'k', '')) / (1000)
		WHEN [Market cap (intra-day)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Market cap (intra-day)])
		END AS [MarketCapMillion]

		, CASE WHEN [Enterprise value] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Enterprise value], 'M', '')) 
		WHEN [Enterprise value] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Enterprise value], 'T', '')) * (1000) * (1000)
		WHEN [Enterprise value] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Enterprise value], 'B', '')) * (1000)
		WHEN [Enterprise value] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Enterprise value], 'K', '')) / (1000)
		WHEN [Enterprise value] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Enterprise value], 'k', '')) / (1000)
		WHEN [Enterprise value] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Enterprise value])
		END AS [EnterpriseValueMillion]

		-- , CASE WHEN [Trailing P/E] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Trailing P/E]) END AS [TrailingPE]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Trailing P/E])) AS [TrailingPE]
		, CASE WHEN [Forward P/E] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Forward P/E]) END AS [ForwardPE]

		, CASE WHEN [PEG ratio (5-yr expected)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [PEG ratio (5-yr expected)]) END AS [PEGRatio5YrExpected]

		-- , CASE WHEN [Price/sales (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Price/sales (ttm)]) END AS [PriceOverSale]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Price/sales (ttm)])) AS [PriceOverSale]

		-- , CASE WHEN [Price/book (mrq)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Price/book (mrq)]) END AS [PriceOverBook]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Price/book (mrq)])) AS [PriceOverBook]

		-- , CASE WHEN [Enterprise value/revenue] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Enterprise value/revenue]) END AS [EnterpriseValueOverRevenue]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Enterprise value/revenue])) AS [EnterpriseValueOverRevenue]

		, CASE WHEN [Enterprise value/EBITDA] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Enterprise value/EBITDA]) END AS [EnterpriseValueOverEBITDA]
		, CASE WHEN [Fiscal year ends] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(DATE,[Fiscal year ends]) END AS [FiscalYearEnds]
		, CASE WHEN [Most-recent quarter (mrq)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(DATE, [Most-recent quarter (mrq)]) END AS [MostRecentQuarter]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [Profit margin] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Profit margin] END, '%','')) / (100)
			AS [ProfitMarginPCT]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [Operating margin (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Operating margin (ttm)] END, '%','')) / (100)
			AS [OperatingMarginPCT]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [Return on assets (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Return on assets (ttm)] END, '%','')) / (100)
			AS [ReturnOnAssetsPCT]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [Return on equity (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Return on equity (ttm)] END, '%','')) / (100)
			AS [ReturnOnEquityPCT]

		, CASE WHEN [Revenue (ttm)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Revenue (ttm)], 'M', '')) 
 		WHEN [Revenue (ttm)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Revenue (ttm)], 'T', '')) * (1000) * (1000)
		WHEN [Revenue (ttm)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Revenue (ttm)], 'B', '')) * (1000)
		WHEN [Revenue (ttm)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Revenue (ttm)], 'K', '')) / (1000)
		WHEN [Revenue (ttm)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Revenue (ttm)], 'k', '')) / (1000)
		WHEN [Revenue (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Revenue (ttm)])
		END AS [RevenueMillion]

		-- , CASE WHEN [Revenue per share (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Revenue per share (ttm)]) END AS [RevenuePerShare]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Revenue per share (ttm)])) AS [RevenuePerShare]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [Quarterly revenue growth (yoy)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Quarterly revenue growth (yoy)] END, '%','')) / (100)
			AS [QuarterlyRevenueGrowthPCT_Yoy]

		, CASE WHEN [Gross profit (ttm)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Gross profit (ttm)], 'M', '')) 
		WHEN [Gross profit (ttm)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Gross profit (ttm)], 'T', '')) * (1000) * (1000)
		WHEN [Gross profit (ttm)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Gross profit (ttm)], 'B', '')) * (1000)
		WHEN [Gross profit (ttm)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Gross profit (ttm)], 'K', '')) / (1000)
		WHEN [Gross profit (ttm)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Gross profit (ttm)], 'k', '')) / (1000)
		WHEN [Gross profit (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Gross profit (ttm)])
		END AS [GrossProfitMillion]

		, CASE WHEN [EBITDA] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([EBITDA], 'M', '')) 
		WHEN [EBITDA] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([EBITDA], 'T', '')) * (1000) * (1000)
		WHEN [EBITDA] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([EBITDA], 'B', '')) * (1000)
		WHEN [EBITDA] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([EBITDA], 'K', '')) / (1000)
		WHEN [EBITDA] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([EBITDA], 'k', '')) / (1000)
		WHEN [EBITDA] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [EBITDA])
		END AS [EBITDAMillion]
		
		, CASE WHEN [Net income avi to common (ttm)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Net income avi to common (ttm)], 'M', '')) 
		WHEN [Net income avi to common (ttm)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Net income avi to common (ttm)], 'T', '')) * (1000) * (1000)
		WHEN [Net income avi to common (ttm)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Net income avi to common (ttm)], 'B', '')) * (1000)
		WHEN [Net income avi to common (ttm)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Net income avi to common (ttm)], 'K', '')) / (1000)
		WHEN [Net income avi to common (ttm)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Net income avi to common (ttm)], 'k', '')) / (1000)
		WHEN [Net income avi to common (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Net income avi to common (ttm)])
		END AS [NetIncomeAviToCommonMillion]

		-- , CASE WHEN [Diluted EPS (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Diluted EPS (ttm)]) END AS [DilutedEPS]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Diluted EPS (ttm)])) AS [DilutedEPS]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [Quarterly earnings growth (yoy)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Quarterly earnings growth (yoy)] END, '%','')) / (100)
			AS [QuarterlyEarningsGrowthPCT_Yoy]

		, CASE WHEN [Total cash (mrq)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Total cash (mrq)], 'M', '')) 
		WHEN [Total cash (mrq)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Total cash (mrq)], 'T', '')) * (1000) * (1000)
		WHEN [Total cash (mrq)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Total cash (mrq)], 'B', '')) * (1000)
		WHEN [Total cash (mrq)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Total cash (mrq)], 'K', '')) / (1000)
		WHEN [Total cash (mrq)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Total cash (mrq)], 'k', '')) / (1000)
		WHEN [Total cash (mrq)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Total cash (mrq)])
		END AS [TotalCashMillion]
		 
		-- , CASE WHEN [Total cash per share (mrq)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Total cash per share (mrq)]) END AS [TotalCashPerShare]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Total cash per share (mrq)])) AS [TotalCashPerShare]

		, CASE WHEN [Total debt (mrq)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Total debt (mrq)], 'M', '')) 
		WHEN [Total debt (mrq)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Total debt (mrq)], 'T', '')) * (1000) * (1000)
		WHEN [Total debt (mrq)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Total debt (mrq)], 'B', '')) * (1000)
		WHEN [Total debt (mrq)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Total debt (mrq)], 'K', '')) / (1000)
		WHEN [Total debt (mrq)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Total debt (mrq)], 'k', '')) / (1000)
		WHEN [Total debt (mrq)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Total debt (mrq)])
		END AS [TotalDebtMillion]

		, CASE WHEN [Total debt/equity (mrq)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Total debt/equity (mrq)]) END AS [TotalDebtOverEquity]
		-- CHAR ERROR? , CASE WHEN [Current ratio (mrq)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Current ratio (mrq)])
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Current ratio (mrq)])) AS [CurrentRatio]

		-- , CASE WHEN [Book value per share (mrq)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Book value per share (mrq)]) END AS [BookValuePerShare]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Book value per share (mrq)])) AS [BookValuePerShare]

		, CASE WHEN [Operating cash flow (ttm)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Operating cash flow (ttm)], 'M', '')) 
		WHEN [Operating cash flow (ttm)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Operating cash flow (ttm)], 'T', '')) * (1000) * (1000)
		WHEN [Operating cash flow (ttm)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Operating cash flow (ttm)], 'B', '')) * (1000)
		WHEN [Operating cash flow (ttm)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Operating cash flow (ttm)], 'K', '')) / (1000)
		WHEN [Operating cash flow (ttm)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Operating cash flow (ttm)], 'k', '')) / (1000)
		WHEN [Operating cash flow (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Operating cash flow (ttm)])
		END AS [OperatingCashFlowMillion]

		, CASE WHEN [Levered free cash flow (ttm)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Levered free cash flow (ttm)], 'M', '')) 
		WHEN [Levered free cash flow (ttm)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Levered free cash flow (ttm)], 'T', '')) * (1000) * (1000)
		WHEN [Levered free cash flow (ttm)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Levered free cash flow (ttm)], 'B', '')) * (1000)
		WHEN [Levered free cash flow (ttm)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Levered free cash flow (ttm)], 'K', '')) / (1000)
		WHEN [Levered free cash flow (ttm)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Levered free cash flow (ttm)], 'k', '')) / (1000)
		WHEN [Levered free cash flow (ttm)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Levered free cash flow (ttm)])
		END AS [LeveredFreeCashFlowMillion]

		-- , CASE WHEN [Beta (3Y monthly)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [Beta (3Y monthly)]) END AS [Beta3YMonthly]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Beta (3Y monthly)])) AS [Beta3YMonthly]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [52-week change] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [52-week change] END, '%','')) / (100)
			AS [52WeekChange]
		-- , [52-week change]
		-- , [52-week change] AS [52-week change FIX ME]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [S&P500 52-week change] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [S&P500 52-week change] END, '%','')) / (100)
			AS [SandP52WeekChange]

		, [52-week high] / (100) AS [52WeekHigh]
		, [52-week low] / (100) AS [52WeekLow]
		, [50-day moving average] / (100) AS [50DayMovingAverage]
		, [200-day moving average] / (100) AS [200DayMovingAverage]

		, CASE WHEN [Avg vol (3-month)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Avg vol (3-month)], 'M', '')) 
		WHEN [Avg vol (3-month)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Avg vol (3-month)], 'T', '')) * (1000) * (1000)
		WHEN [Avg vol (3-month)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Avg vol (3-month)], 'B', '')) * (1000)
		WHEN [Avg vol (3-month)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Avg vol (3-month)], 'K', '')) / (1000)
		WHEN [Avg vol (3-month)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Avg vol (3-month)], 'k', '')) / (1000)
		WHEN [Avg vol (3-month)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Avg vol (3-month)])
		END AS [AvgVol3MonthMillion]

		, CASE WHEN [Avg vol (10-day)] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Avg vol (10-day)], 'M', '')) 
		WHEN [Avg vol (10-day)] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Avg vol (10-day)], 'T', '')) * (1000) * (1000)
		WHEN [Avg vol (10-day)] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Avg vol (10-day)], 'B', '')) * (1000)
		WHEN [Avg vol (10-day)] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Avg vol (10-day)], 'K', '')) / (1000)
		WHEN [Avg vol (10-day)] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Avg vol (10-day)], 'k', '')) / (1000)
		WHEN [Avg vol (10-day)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Avg vol (10-day)])
		END AS [AvgVol10dayMillion]

		, CASE WHEN [Shares outstanding] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Shares outstanding], 'M', '')) 
		WHEN [Shares outstanding] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Shares outstanding], 'T', '')) * (1000) * (1000)
		WHEN [Shares outstanding] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Shares outstanding], 'B', '')) * (1000)
		WHEN [Shares outstanding] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Shares outstanding], 'K', '')) / (1000)
		WHEN [Shares outstanding] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Shares outstanding], 'k', '')) / (1000)
		WHEN [Shares outstanding] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Shares outstanding])
		END AS [SharesOutstandingMillion]

		, CASE WHEN [Float] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Float], 'M', '')) 
		WHEN [Float] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Float], 'T', '')) * (1000) * (1000)
		WHEN [Float] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Float], 'B', '')) * (1000)
		WHEN [Float] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Float], 'K', '')) / (1000)
		WHEN [Float] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Float], 'k', '')) / (1000)
		WHEN [Float] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Float])
		END AS [SharesFloat]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [% held by insiders] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [% held by insiders] END, '%','')) / (100)
			AS [PCTHeldByInsiders]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [% held by institutions] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [% held by institutions] END, '%','')) / (100)
			AS [PCTHeldByInstitutions]

		, CASE WHEN [Shares short] LIKE '%M' THEN CONVERT(FLOAT, REPLACE([Shares short], 'M', '')) 
		WHEN [Shares short] LIKE '%T' THEN CONVERT(FLOAT, REPLACE([Shares short], 'T', '')) * (1000) * (1000)
		WHEN [Shares short] LIKE '%B' THEN CONVERT(FLOAT, REPLACE([Shares short], 'B', '')) * (1000)
		WHEN [Shares short] LIKE '%K' THEN CONVERT(FLOAT, REPLACE([Shares short], 'K', '')) / (1000)
		WHEN [Shares short] LIKE '%k' THEN CONVERT(FLOAT, REPLACE([Shares short], 'k', '')) / (1000)
		WHEN [Shares short] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL
		ELSE CONVERT(FLOAT, [Shares short])
		END AS [SharesShort]

		-- , [Short ratio]						-- all N/A ??
		-- , [Short % of float]					-- all N/A ??
		-- , [Short % of shares outstanding]	-- all N/A ??
		-- , [Shares short (prior month )]		-- all N/A ??

		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Forward annual dividend rate])) AS [ForwardAnnualDividendRate]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Forward annual dividend yield]))  / (100) AS [ForwardAnnualDividendYieldPCT]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Trailing annual dividend rate])) AS [TrailingAnnualDividendRate]
		, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters] ([Trailing annual dividend yield])) / (100) AS [TrailingAnnualDividendYieldPCT]
		-- , CONVERT(FLOAT, REPLACE(CASE WHEN [Trailing annual dividend yield] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Trailing annual dividend yield] END, '%','')) / (100)
		-- 	AS [TrailingAnnualDividendYieldPCT]

		, CASE WHEN [5-year average dividend yield] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(FLOAT, [5-year average dividend yield]) END AS [5YearAverageDividendYield]

		, CONVERT(FLOAT, REPLACE(CASE WHEN [Payout ratio] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Payout ratio] END, '%','')) / (100)
			AS [PayoutRatio]

		, CASE WHEN [Dividend date] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(DATE, [Dividend date]) END AS [DividendDate]
		, CASE WHEN [Ex-Dividend date] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(DATE, [Ex-Dividend date]) END AS [ExDividendDate]
		, CASE WHEN [Last split factor (new per old)] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE [Last split factor (new per old)] END AS [LastSplitFactorNewPerOld]
		, CASE WHEN [Last split date] IN ('N/A', 'âˆž', 'âˆž%') THEN NULL ELSE CONVERT(DATE, [Last split date]) END AS [LastSplitDate]
		-- SELECT * 
		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Users\Alex\OneDrive\;HDR=YES')...[YAHOO_FINANCE_STATISTICS#csv] B1
		WHERE [Price/sales (ttm)] IS NOT NULL
	)

	, CTE_02_DATA AS (SELECT [B1].[INVESTMENT_ID]
	, [A1].[TICKER]
	, [A1].[Name]
	, [A1].[Name2]
	, [A1].[Date Of Export]
	, [A1].[MarketCapMillion]
	, [A1].[EnterpriseValueMillion]
	, [A1].[TrailingPE]
	, [A1].[ForwardPE]
	, [A1].[PEGRatio5YrExpected]
	, [A1].[PriceOverSale]
	, [A1].[PriceOverBook]
	, [A1].[EnterpriseValueOverRevenue]
	, [A1].[EnterpriseValueOverEBITDA]
	, [A1].[FiscalYearEnds]
	, [A1].[MostRecentQuarter]
	, [A1].[ProfitMarginPCT]
	, [A1].[OperatingMarginPCT]
	, [A1].[ReturnOnAssetsPCT]
	, [A1].[ReturnOnEquityPCT]
	, [A1].[RevenueMillion]
	, [A1].[RevenuePerShare]
	, [A1].[QuarterlyRevenueGrowthPCT_Yoy]
	, [A1].[GrossProfitMillion]
	, [A1].[EBITDAMillion]
	, [A1].[NetIncomeAviToCommonMillion]
	, [A1].[DilutedEPS]
	, [A1].[QuarterlyEarningsGrowthPCT_Yoy]
	, [A1].[TotalCashMillion]
	, [A1].[TotalCashPerShare]
	, [A1].[TotalDebtMillion]
	, [A1].[TotalDebtOverEquity]
	, [A1].[CurrentRatio]
	, [A1].[BookValuePerShare]
	, [A1].[OperatingCashFlowMillion]
	, [A1].[LeveredFreeCashFlowMillion]
	, [A1].[Beta3YMonthly]
	, [A1].[52WeekChange]
	, [A1].[SandP52WeekChange]
	, [A1].[52WeekHigh]
	, [A1].[52WeekLow]
	, [A1].[50DayMovingAverage]
	, [A1].[200DayMovingAverage]
	, [A1].[AvgVol3MonthMillion]
	, [A1].[AvgVol10dayMillion]
	, [A1].[SharesOutstandingMillion]
	, [A1].[SharesFloat]
	, [A1].[PCTHeldByInsiders]
	, [A1].[PCTHeldByInstitutions]
	, [A1].[SharesShort]
	, [A1].[ForwardAnnualDividendRate]
	, [A1].[ForwardAnnualDividendYieldPCT]
	, [A1].[TrailingAnnualDividendRate]
	, [A1].[TrailingAnnualDividendYieldPCT]
	, [A1].[5YearAverageDividendYield]
	, [A1].[PayoutRatio]
	, [A1].[DividendDate]
	, [A1].[ExDividendDate]
	, [A1].[LastSplitFactorNewPerOld]
	, [A1].[LastSplitDate]

	FROM CTE_01_CVS_FILE_IN A1
	-- LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[TICKER] = [B1].[PRIMARY_LABEL]
	LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] B1 ON [A1].[TICKER] = [B1].[LABEL]
	)
	
	, CTE_FINAL AS (SELECT [A1].[INVESTMENT_ID]
	, [A1].[TICKER]
	, MAX([A1].[Name]) AS [Name]
	, MAX([A1].[Name2]) AS [Name2]
	, [A1].[Date Of Export]
	, MAX([A1].[MarketCapMillion]) AS [MarketCapMillion]
	, MAX([A1].[EnterpriseValueMillion]) AS [EnterpriseValueMillion]
	, MAX([A1].[TrailingPE]) AS [TrailingPE]
	, MAX([A1].[ForwardPE]) AS [ForwardPE]
	, MAX([A1].[PEGRatio5YrExpected]) AS [PEGRatio5YrExpected]
	, MAX([A1].[PriceOverSale]) AS [PriceOverSale]
	, MAX([A1].[PriceOverBook]) AS [PriceOverBook]
	, MAX([A1].[EnterpriseValueOverRevenue]) AS [EnterpriseValueOverRevenue]
	, MAX([A1].[EnterpriseValueOverEBITDA]) AS [EnterpriseValueOverEBITDA]
	, MAX([A1].[FiscalYearEnds]) AS [FiscalYearEnds]
	, MAX([A1].[MostRecentQuarter]) AS [MostRecentQuarter]
	, MAX([A1].[ProfitMarginPCT]) AS [ProfitMarginPCT]
	, MAX([A1].[OperatingMarginPCT]) AS [OperatingMarginPCT]
	, MAX([A1].[ReturnOnAssetsPCT]) AS [ReturnOnAssetsPCT]
	, MAX([A1].[ReturnOnEquityPCT]) AS [ReturnOnEquityPCT]
	, MAX([A1].[RevenueMillion]) AS [RevenueMillion]
	, MAX([A1].[RevenuePerShare]) AS [RevenuePerShare]
	, MAX([A1].[QuarterlyRevenueGrowthPCT_Yoy]) AS [QuarterlyRevenueGrowthPCT_Yoy]
	, MAX([A1].[GrossProfitMillion]) AS [GrossProfitMillion]
	, MAX([A1].[EBITDAMillion]) AS [EBITDAMillion]
	, MAX([A1].[NetIncomeAviToCommonMillion]) AS [NetIncomeAviToCommonMillion]
	, MAX([A1].[DilutedEPS]) AS [DilutedEPS]
	, MAX([A1].[QuarterlyEarningsGrowthPCT_Yoy]) AS [QuarterlyEarningsGrowthPCT_Yoy]
	, MAX([A1].[TotalCashMillion]) AS [TotalCashMillion]
	, MAX([A1].[TotalCashPerShare]) AS [TotalCashPerShare]
	, MAX([A1].[TotalDebtMillion]) AS [TotalDebtMillion]
	, MAX([A1].[TotalDebtOverEquity]) AS [TotalDebtOverEquity]
	, MAX([A1].[CurrentRatio]) AS [CurrentRatio]
	, MAX([A1].[BookValuePerShare]) AS [BookValuePerShare]
	, MAX([A1].[OperatingCashFlowMillion]) AS[OperatingCashFlowMillion] 
	, MAX([A1].[LeveredFreeCashFlowMillion]) AS [LeveredFreeCashFlowMillion]
	, MAX([A1].[Beta3YMonthly]) AS [Beta3YMonthly]
	, MAX([A1].[52WeekChange]) AS [52WeekChange]
	, MAX([A1].[SandP52WeekChange]) AS[SandP52WeekChange] 
	, MAX([A1].[52WeekHigh]) AS [52WeekHigh]
	, MAX([A1].[52WeekLow]) AS [52WeekLow]
	, MAX([A1].[50DayMovingAverage]) AS [50DayMovingAverage]
	, MAX([A1].[200DayMovingAverage]) AS [200DayMovingAverage]
	, MAX([A1].[AvgVol3MonthMillion]) AS [AvgVol3MonthMillion]
	, MAX([A1].[AvgVol10dayMillion]) AS [AvgVol10dayMillion]
	, MAX([A1].[SharesOutstandingMillion]) AS [SharesOutstandingMillion]
	, MAX([A1].[SharesFloat]) AS [SharesFloat]
	, MAX([A1].[PCTHeldByInsiders]) AS [PCTHeldByInsiders]
	, MAX([A1].[PCTHeldByInstitutions]) AS [PCTHeldByInstitutions]
	, MAX([A1].[SharesShort]) AS [SharesShort]
	, MAX([A1].[ForwardAnnualDividendRate]) AS [ForwardAnnualDividendRate]
	, MAX([A1].[ForwardAnnualDividendYieldPCT]) AS [ForwardAnnualDividendYieldPCT]
	, MAX([A1].[TrailingAnnualDividendRate]) AS [TrailingAnnualDividendRate]
	, MAX([A1].[TrailingAnnualDividendYieldPCT]) AS [TrailingAnnualDividendYieldPCT]
	, MAX([A1].[5YearAverageDividendYield]) AS [5YearAverageDividendYield]
	, MAX([A1].[PayoutRatio]) AS [PayoutRatio]
	, MAX([A1].[DividendDate]) AS [DividendDate]
	, MAX([A1].[ExDividendDate]) AS [ExDividendDate]
	, MAX([A1].[LastSplitFactorNewPerOld]) AS[LastSplitFactorNewPerOld] 
	, MAX([A1].[LastSplitDate]) AS [LastSplitDate]

	FROM CTE_02_DATA A1
	GROUP BY [A1].[INVESTMENT_ID]
	, [A1].[TICKER]
	, [A1].[Date Of Export])

	SELECT [A1].* FROM CTE_FINAL A1
	WHERE [TICKER] IN (SELECT [TICKER] FROM CTE_FINAL GROUP BY [TICKER] HAVING COUNT(*) = 1)
UNION
	SELECT [A1].* FROM CTE_FINAL A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[INVESTMENT_ID] = [B1].[ID] AND [B1].[INVESTMENT_TYPE_NAME] = 'Equity' -- EG FERG is in both FUND and EQUITY
	WHERE [TICKER] NOT IN (SELECT [TICKER] FROM CTE_FINAL GROUP BY [TICKER] HAVING COUNT(*) = 1)
GO
/****** Object:  View [FCT].[v_YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [FCT].[v_YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD]
AS
	/*
	SELECT -- DISTINCT 'YAHOO_FINANCE_EQUITIES_HISTORY.csv,'+RTRIM(A.SYMBOL)+'.L'
	[B].[LAST_TRADE_DATE], [A].*, 'NEXT' AS CL0, [B].*
	FROM [FCT].[v_YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD] A
	LEFT JOIN [STG].[v_YAHOO_FINANCE_EQUITIES] B
	ON [A].[SYMBOL] = [B].[SYMBOL]
	WHERE [A].[IMPORTTYPE] NOT LIKE '%EQT%'
	AND [A].[IMPORTTYPE] NOT IN ('07_TRUSTNET_ETF','0QTNTGRK','02_MANUAL_ENTRY')
	AND [A].[IMPORTTYPE] IN ('06_YAHOO_HISTORY')
	-- AND [A].[SYMBOL] NOT IN (SELECT [SYMBOL] FROM [STG].[v_YAHOO_FINANCE_EQUITIES])
	AND ISNULL([A].[CURRENCY],'') NOT IN ('USD','EUR','JPY')
	ORDER BY 1 DESC, [A].[DateLoaded] DESC, [A].[ClosureDate] DESC, [A].[IMPORTTYPE] DESC
	*/
	SELECT *
	FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[FCT].[v_YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD]









GO
/****** Object:  View [XLS].[v_HL_EAH_ISA]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [XLS].[v_HL_EAH_ISA]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	-- 1.1		20190507 Read file from C:\Users\Alex\OneDrive\
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT * FROM [XLS].[v_HL_EAH_ISA]
	-- ******************************************************************************************************************************************

		SELECT (8) AS [ISA_ACCOUNT_ID]
		, [Trade date], [Settle date], [Reference], [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))	AS [UnitCost_GBX]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))		AS [Quantity]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))		AS [Value_GBP]
		FROM -- OPENQUERY(HL_PORTFOLIO_SUMMARY, 'SELECT * FROM [KAH Porfolio Summary$]')
		-- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_ISA_Capital_account$] B
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\Users\Alex\OneDrive\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_ISA_Capital_account$] B
		WHERE [Trade date] IS NOT NULL
		-- 20180919 AND [REFERENCE] <> 'MANAGE FEE'
		UNION
		SELECT (8), [Trade date], [Settle date], [Reference], [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))
		FROM -- OPENQUERY(HL_PORTFOLIO_SUMMARY, 'SELECT * FROM [KAH Loyalty$]')
		-- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_ISA_Loyalty$] B
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\Users\Alex\OneDrive\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_ISA_Loyalty$] B
		WHERE [Trade date] IS NOT NULL
		-- 20180919 AND [REFERENCE] <> 'MANAGE FEE'

GO
/****** Object:  View [XLS].[v_HL_EAH_SIPP]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [XLS].[v_HL_EAH_SIPP]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	-- 1.1		20190507 Read file from C:\Users\Alex\OneDrive\
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT * FROM [XLS].[v_HL_EAH_SIPP]
	-- ******************************************************************************************************************************************

		SELECT (1) AS [SIPP_ACCOUNT_ID]
		, [Trade date]
		, [Settle date]
		, [Reference]
		, [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))	AS [UnitCost_GBX]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))		AS [Quantity]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))		AS [Value_GBP]
		FROM -- OPENQUERY(HL_PORTFOLIO_SUMMARY, 'SELECT * FROM [EAH Porfolio Summary$]')
		-- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_Porfolio_Summary$] B
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\Users\Alex\OneDrive\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_Porfolio_Summary$] B
		WHERE [Trade date] IS NOT NULL
		-- 20180919 AND [REFERENCE] <> 'MANAGE FEE'
		UNION
		SELECT (1), [Trade date], [Settle date], [Reference], [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))
		FROM
		-- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_Loyalty$] B
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\Users\Alex\OneDrive\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_Loyalty$] B
		WHERE [Trade date] IS NOT NULL
		-- 20180919 AND [REFERENCE] <> 'MANAGE FEE'

GO
/****** Object:  View [XLS].[v_HL_KAH_ISA]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [XLS].[v_HL_KAH_ISA]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	-- 1.1		20190507 Read file from C:\Users\Alex\OneDrive\
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT * FROM [XLS].[v_HL_KAH_ISA]
	-- ******************************************************************************************************************************************

		SELECT (10) AS [ISA_ACCOUNT_ID]
		, [Trade date], [Settle date], [Reference], [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))	AS [UnitCost_GBX]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))		AS [Quantity]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))		AS [Value_GBP]
		FROM -- OPENQUERY(HL_PORTFOLIO_SUMMARY, 'SELECT * FROM [KAH Porfolio Summary$]')
		-- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_ISA_Capital_account$] B
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\Users\Alex\OneDrive\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_ISA_Capital_account$] B
		WHERE [Trade date] IS NOT NULL
		-- 20180919 AND [REFERENCE] <> 'MANAGE FEE'
		/*
		UNION
		SELECT (10), [Trade date], [Settle date], [Reference], [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))
		FROM -- OPENQUERY(HL_PORTFOLIO_SUMMARY, 'SELECT * FROM [KAH Loyalty$]')
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_ISA_Loyalty$] B
		WHERE [Trade date] IS NOT NULL
		AND [REFERENCE] <> 'MANAGE FEE'
		*/

GO
/****** Object:  View [XLS].[v_HL_KAH_SIPP]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [XLS].[v_HL_KAH_SIPP]
AS

	-- ******************************************************************************************************************************************
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	-- 1.1		20190507 Read file from C:\Users\Alex\OneDrive\
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT * FROM [XLS].[v_HL_KAH_SIPP]
	-- ******************************************************************************************************************************************

	SELECT (2) AS [SIPP_ACCOUNT_ID]
	, [Trade date]
	, [Settle date]
	, [Reference]
	, [Description]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))	AS [UnitCost_GBX]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))		AS [Quantity]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))		AS [Value_GBP]
	FROM
	-- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_Porfolio_Summary$] B
	OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\Users\Alex\OneDrive\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_Porfolio_Summary$] B
	WHERE [Trade date] IS NOT NULL
	-- 20180919 AND [REFERENCE] <> 'MANAGE FEE'
	UNION
	SELECT (2), [Trade date], [Settle date], [Reference], [Description]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))
	FROM
	-- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_Loyalty$] B
	OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\Users\Alex\OneDrive\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_Loyalty$] B
	WHERE [Trade date] IS NOT NULL
	-- 20180919 AND [REFERENCE] <> 'MANAGE FEE'

GO
/****** Object:  Table [dbo].[ADD_INVESTMENTS_EST_INVESTMENT_ID_plus_SECTOR_ID_FINAL]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADD_INVESTMENTS_EST_INVESTMENT_ID_plus_SECTOR_ID_FINAL](
	[EST_INVESTMENT_ID] [int] NULL,
	[SECTOR_ID] [int] NULL,
	[MARKET_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [DEBUG].[NEW_INVESTMENTS]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DEBUG].[NEW_INVESTMENTS](
	[Symbol] [varchar](50) NULL,
	[Name] [varchar](250) NULL,
	[INVESTMENT_TYPE] [varchar](50) NULL,
	[SECTOR] [varchar](100) NULL,
	[MARKET] [varchar](100) NULL,
	[LABEL_02] [varchar](50) NULL,
	[LABEL_03] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_GET_DATA_FROM_XLS_and_PROCESS_IMPORT_ONLY]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_GET_DATA_FROM_XLS_and_PROCESS_IMPORT_ONLY]
( 
  @IMPORT_YAHOO_EQUITIES INT = 0	-- 20171129
, @IMPORT_YAHOO_OEIC INT = 0		-- 20171129
, @IMPORT_YAHOO_CURRENCY INT = 0	-- 20171129
, @IMPORT_YAHOO_INDICES INT = 0	-- 20171129
, @IMPORT_YAHOO_FUTURES INT = 0	-- 20171129
, @IMPORT_HL_EAH INT = 1
, @IMPORT_HL_KAH INT = 1
, @IMPORT_HL_EAH_ISA INT = 1
, @IMPORT_HL_KAH_ISA INT = 1
, @IMPORT_TRUSTNET_ETF INT = 1
, @IMPORT_TRUSTNET_OEIC INT = 1
, @IMPORT_TELEGRAPH_SECTOR INT = 0
, @IMPORT_TELEGRAPH_INDICES INT = 0
, @IMPORT_STOCK_EXCHANGE INT = 0
, @IMPORT_YAHOO_STATISTICS INT = 1
, @IMPORT_DIRECTOR_DEALS INT = 1
, @FINAL_CHECKS INT = 0
, @BUILD_TYPE CHAR(1) = 'F'
-- , @IMPORT_YAHOO_HISTORY INT = 1
, @GLOBAL_SEND_EMAIL INT = 0 -- 1 20200313
, @UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV INT = 1
)
WITH RECOMPILE
AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Remove [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190509 @IMPORT_TELEGRAPH_SECTOR = 0 as CSV is now empty
	-- 1.3		20190509 @IMPORT_TELEGRAPH_INDICES = 0 as CSV is now empty
	-- 1.4		20190528 Added [usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES] (taken out of usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES)
	-- 1.5		20190529 Add load of EQ01-04 as an adhoc load again - possible delay of files coming over via OneDrive to M:\
	--
	-- EXEC [BLD].[usp_BUILD_GET_DATA_FROM_XLS_and_PROCESS_IMPORT_ONLY]
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	
	DECLARE @ErrorNumber INT, @ErrorLine INT,  @ErrorMessage NVARCHAR(4000), @RETVAL INT
	DECLARE @ErrorProc NVARCHAR(4000), @ErrorSev INT,  @ErrorState INT

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255)
	DECLARE @WAIT_FOR_DELAY INT, @BUILD_ID INT, @PARENT_USP VARCHAR(250)

	SET @BUILD_ID = ISNULL((SELECT MAX(BUILD_ID) FROM [Alchemy_Data].[BLD].[LOAD_STATUS]),0) + 1 -- [AZURE_R7_ALCHEMY_DATA].

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
	SET @DEBUG = (1)
	SET @WAIT_FOR_DELAY = (1)

	IF (1) = (SELECT CHARINDEX(HOST_NAME(), @@servername))
	BEGIN
		RAISERROR ('I: OUTPUT = RAISERROR style',10,1) WITH NOWAIT 
		-- SET @VRE = (1)
	END
	ELSE
	BEGIN
		RAISERROR ('I: OUTPUT = PRINT style',10,1) WITH NOWAIT 
		-- SET @vRE = (0) -- IF LOCAL THEN RAISERROR ELSE PRINT
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = 'START BUILD', @BUILD_TYPE = @BUILD_TYPE -- , @KEY_STAGE = 1
	-- ELSE PRINT @I_MSG

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG = 'EXEC sp_cycle_errorlog'
	BEGIN TRY
		EXEC sp_cycle_errorlog
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
		-- RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ADDED 20190528
	-- ===============================================================================================================================================================================================================
	
	IF @IMPORT_STOCK_EXCHANGE = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES] 0, 1'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG
		, @BUILD_TYPE = @BUILD_TYPE, @KEY_STAGE = 1

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @SEND_EMAIL = @GLOBAL_SEND_EMAIL
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG, @BUILD_TYPE = @BUILD_TYPE, @KEY_STAGE = 1
	-- ELSE PRINT @I_MSG

	BEGIN TRY
		EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES]
		@IMPORT_TRUSTNET_ETF = @IMPORT_TRUSTNET_ETF
		, @IMPORT_TRUSTNET_OEIC = @IMPORT_TRUSTNET_OEIC
		-- , @IMPORT_YAHOO_HISTORY = @IMPORT_YAHOO_HISTORY
		, @IMPORT_YAHOO_EQUITIES = @IMPORT_YAHOO_EQUITIES
		, @IMPORT_YAHOO_OEIC = @IMPORT_YAHOO_OEIC
		, @IMPORT_YAHOO_CURRENCY = @IMPORT_YAHOO_CURRENCY
		, @IMPORT_YAHOO_INDICES = @IMPORT_YAHOO_INDICES
		, @IMPORT_YAHOO_FUTURES = @IMPORT_YAHOO_FUTURES
		, @IMPORT_HL_EAH = @IMPORT_HL_EAH
		, @IMPORT_HL_KAH = @IMPORT_HL_KAH
		, @IMPORT_HL_EAH_ISA = @IMPORT_HL_EAH_ISA
		, @IMPORT_HL_KAH_ISA = @IMPORT_HL_KAH_ISA
		, @IMPORT_TELEGRAPH_SECTOR = @IMPORT_TELEGRAPH_SECTOR
		, @IMPORT_TELEGRAPH_INDICES = @IMPORT_TELEGRAPH_INDICES
		, @IMPORT_STOCK_EXCHANGE = @IMPORT_STOCK_EXCHANGE
		, @BUILD_ID = @BUILD_ID
		, @BUILD_TYPE = @BUILD_TYPE
		, @SEND_EMAIL = @GLOBAL_SEND_EMAIL
		-- , @LOAD_ONE_EPIC_DATA = @LOAD_ONE_EPIC_DATA
		-- , @IMPORT_TRUSTNET = @IMPORT_TRUSTNET
		-- , @IMPORT_TRUSTNET_SEDOL = @IMPORT_TRUSTNET_SEDOL
		-- , @IMPORT_TRUSTNET_EXTRA =  @IMPORT_TRUSTNET_EXTRA
		-- , @IMPORT_TRUSTNET_ADHOC = @IMPORT_TRUSTNET_ADHOC
		-- , @IMPORT_BROKER = @IMPORT_BROKER
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- 2090529 Added as these files are NOT loading as NORMAL
	-- ===============================================================================================================================================================================================================

	SET @I_MSG = 'LOAD EQUITIES 01-05'
	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_05', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_04', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_03', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_02', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_01', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_INDICES_01', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID, @FACTOR_DOWN_PRICES = 1
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_CRYPTO_01',  @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID, @FACTOR_DOWN_PRICES = 1
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_USD_CURRENCY_01', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID, @FACTOR_DOWN_PRICES = 1
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_FUTURES_01', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID, @FACTOR_DOWN_PRICES = 100
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_01', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_02', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_03', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_04', @SEND_EMAIL = 0, @BUILD_ID = @BUILD_ID
	END TRY
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ADDED 20170225
	-- ===============================================================================================================================================================================================================
	
	IF @IMPORT_TELEGRAPH_SECTOR = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES] 0, 1'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG
		, @BUILD_TYPE = @BUILD_TYPE, @KEY_STAGE = 1
		-- ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- 20180626 -- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- 20180626 -- RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	-- ADDED 20170213
	-- ===============================================================================================================================================================================================================

	IF @FINAL_CHECKS = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS] 0, 1'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG, @BUILD_TYPE = @BUILD_TYPE, @KEY_STAGE = 1
		-- ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS]  @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	-- ADDED 20191003
	-- ===============================================================================================================================================================================================================

	IF @UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV = (1)
	BEGIN
		SET @I_MSG = '[BLD].[usp_UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG, @BUILD_TYPE = @BUILD_TYPE, @KEY_STAGE = 1
		-- ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [BLD].[usp_UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	-- ADDED 20191003
	-- ===============================================================================================================================================================================================================

	IF @IMPORT_YAHOO_STATISTICS = (1)
	BEGIN
		SET @I_MSG = '[BLD].[usp_BUILD_IMPORT_XLS_YAHOO_STATISTICS]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG, @BUILD_TYPE = @BUILD_TYPE, @KEY_STAGE = 1
		-- ELSE PRINT @I_MSG

		BEGIN TRY
			-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_YAHOO_STATISTICS] @BUILD_ID = 0, @BUILD_TYPE ='F'
			EXEC @RETVAL = [BLD].[usp_BUILD_IMPORT_XLS_YAHOO_STATISTICS] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	-- ADDED 20191005
	-- ===============================================================================================================================================================================================================

	IF @IMPORT_DIRECTOR_DEALS = (1)
	BEGIN
		SET @I_MSG = '[BLD].[usp_BUILD_IMPORT_XLS_DIRECTOR_DEALS]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG, @BUILD_TYPE = @BUILD_TYPE, @KEY_STAGE = 1
		-- ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [BLD].[usp_BUILD_IMPORT_XLS_DIRECTOR_DEALS] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG
			-- RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = 'END BUILD (Import)', @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES]
(
  @IMPORT_YAHOO_HISTORY INT = 1
, @IMPORT_YAHOO_EQUITIES INT = 1
, @IMPORT_YAHOO_OEIC INT = 1
, @IMPORT_YAHOO_CURRENCY INT = 1
, @IMPORT_YAHOO_INDICES INT = 1
, @IMPORT_YAHOO_FUTURES INT = 1
, @IMPORT_HL_EAH INT = 1
, @IMPORT_HL_KAH INT = 1
, @IMPORT_HL_EAH_ISA INT = 1
, @IMPORT_HL_KAH_ISA INT = 1
, @IMPORT_TRUSTNET_ETF INT = 1
, @IMPORT_TRUSTNET_OEIC INT = 1
, @IMPORT_TELEGRAPH_SECTOR INT = 0
, @IMPORT_TELEGRAPH_INDICES INT = 0
, @IMPORT_STOCK_EXCHANGE INT = 0 -- <----> format errors
, @IMPORT_SHORT_TRACKER INT = 1
, @BUILD_ID INT = 0
, @BUILD_TYPE CHAR(1) = 'F'
, @SEND_EMAIL INT = 0
)
WITH RECOMPILE
AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	July 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Removed call to usp_SET_LARGE_CHANGEPCT_COMBINED_PRICES_FROM_TELEGRAPH_SECTOR
	-- 1.2		20190509 @IMPORT_TELEGRAPH_SECTOR = 0 as CSV is now empty
	-- 1.3		20190509 @IMPORT_TELEGRAPH_INDICES = 0 as CSV is now empty
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES] @BUILD_ID =3749
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================
	
	DECLARE @I_MSG_2500 VARCHAR(2500), @PARENT_USP VARCHAR(250), @v_ROWCOUNT INT, @RETVAL INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SELECT @I_MSG_2500 = 'I: ' + CONVERT(VARCHAR(25),GETDATE(), 121)+ ' IF you get an error with LINKED SERVER - check file is NOT OPEN!!!!'
	-- IF @vRE = (1) 
	RAISERROR (@I_MSG_2500,10,1) WITH NOWAIT -- ELSE PRINT @I_MSG_2500
	
	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_TRUSTNET_ETF = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF] @BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE
			, @ROWS_IN_BATCH_EXPECTED = 0 -- 1250
			, @ADD_PRICE_ROWS = 1
			, @ADD_MISSING_INVESTMENTS = 1
			, @CONFIGURE_SECTOR_AND_MARKET = 1
			, @DEBUG = 0
			, @SEND_EMAIL = @SEND_EMAIL
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] TRUSTNET_ETF NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_TRUSTNET_ETF),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_HL_EAH_ISA = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA]
			@BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE, @ROWS_IN_BATCH_EXPECTED = 2
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_HL_EAH_ISA),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_HL_EAH = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]
			@BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE, @ROWS_IN_BATCH_EXPECTED = 300
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] HL_PORTFOLIO_EAH NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_HL_EAH),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_HL_KAH = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]
			@BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE, @ROWS_IN_BATCH_EXPECTED = 100
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] HL_PORTFOLIO_KAH NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_HL_KAH),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_HL_KAH_ISA = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_ISA]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_ISA]
			@BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE, @ROWS_IN_BATCH_EXPECTED = 2
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_ISA] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_HL_KAH_ISA),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_YAHOO_HISTORY = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_ALL]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_ALL]
			  @BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE
			, @IMPORT_YAHOO_EQUITIES = @IMPORT_YAHOO_EQUITIES
			, @IMPORT_YAHOO_OEIC = @IMPORT_YAHOO_OEIC
			, @IMPORT_YAHOO_INDICES = @IMPORT_YAHOO_INDICES
			, @IMPORT_YAHOO_FUTURES = @IMPORT_YAHOO_FUTURES
			, @IMPORT_YAHOO_CURRENCY = @IMPORT_YAHOO_CURRENCY
			, @ROWS_IN_BATCH_EXPECTED = 25
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_ALL] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_YAHOO_HISTORY),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_TRUSTNET_OEIC = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] @BUILD_ID = @BUILD_ID
			, @ROWS_IN_BATCH_EXPECTED = 1250
			, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = 1
			, @ADD_MISSING_INVESTMENTS = 1
			, @CONFIGURE_SECTOR_AND_MARKET = 0 -- NEEDS ATTENTION !!!
			, @SEND_EMAIL = @SEND_EMAIL
			, @DEBUG = 0
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_TRUSTNET_OEIC),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- ICHART (EQUITIES)
	-- ===============================================================================================================================================================================================================
/*
	IF @IMPORT_YAHOO_EQUITIES = (1) AND (1) = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART] @BUILD_ID = @BUILD_ID 1
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_YAHOO_EQUITIES),'WTF')
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END
*/

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_TELEGRAPH_INDICES = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_INDICES]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_INDICES]
			@BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @ROWS_IN_BATCH_EXPECTED = 1400
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] TELEGRAPH_INDICES NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_TELEGRAPH_INDICES),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_TELEGRAPH_SECTOR = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR]
			@BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE, @ROWS_IN_BATCH_EXPECTED = 1256 -- 20190402 -- 1344 -- 20180813 1400
			-- @BUILD_ID = @BUILD_ID 1500
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] TELEGRAPH_SECTOR NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_TELEGRAPH_SECTOR),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	/* 20190213 Removed
	IF @IMPORT_TELEGRAPH_SECTOR = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[DQ].[usp_SET_LARGE_CHANGEPCT_COMBINED_PRICES_FROM_TELEGRAPH_SECTOR]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[DQ].[usp_SET_LARGE_CHANGEPCT_COMBINED_PRICES_FROM_TELEGRAPH_SECTOR] @BUILD_ID = @BUILD_ID
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	*/

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_STOCK_EXCHANGE = (1) AND (1) = (2) -- 20210211 FORCE due to '<!----><!----><!----><!----><!----><!----><!----><!----><!---->'
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_v_STOCK_EXCHANGE_TICKER_PLUS_INDICES]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_v_STOCK_EXCHANGE_TICKER_PLUS_INDICES]
			@BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE, @ROWS_IN_BATCH_EXPECTED = 0
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_v_STOCK_EXCHANGE_TICKER_PLUS_INDICES] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_STOCK_EXCHANGE),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_SHORT_TRACKER = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_SHORT_TRACKER]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500,  @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_SHORT_TRACKER] @ROWS_IN_BATCH_EXPECTED = 4000
			, @BUILD_ID = @BUILD_ID
			, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] SHORT_TRACKER NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@IMPORT_SHORT_TRACKER),'WTF')
		IF @BUILD_TYPE = 'F'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_DIRECTOR_DEALS]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_DIRECTOR_DEALS] (@BUILD_ID INT = 0, @ROWS_IN_BATCH_EXPECTED INT = 0, @BUILD_TYPE CHAR(1) = 'F', @DEBUG INT = 0) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2019
	-- Version History:
	-- 1.0		Initial Release
	
	/*
	EXEC [BLD].[usp_BUILD_IMPORT_XLS_DIRECTOR_DEALS]  @DEBUG = 1
	SELECT TOP (2000) * FROM [Alchemy_Stage_Data].[STG].[DIRECTOR_DEALS]
	*/
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE


	-- ===============================================================================================================================================================================================================
	-- MAINTAIN LIST OF DIRECTORS
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'MAINTAIN LIST OF DIRECTORS'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		INSERT INTO [Alchemy_Stage_Data].[STG].[DIRECTOR] ([EPIC], [DIRECTOR])
		SELECT DISTINCT [EPIC], [DIRECTOR]
		FROM [CSV].[v_DIRECTOR_DEALS] A1
		WHERE NOT EXISTS (SELECT 1 FROM [Alchemy_Stage_Data].[STG].[DIRECTOR] B1 WHERE [A1].[Epic] = [B1].[EPIC] AND [A1].[Director] = [B1].[DIRECTOR])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT -- CONVERT(DATE, CONVERT(VARCHAR, GETDATE(), 103)) AS [DateOfImport],
		[A1].[Declared]
		, [A1].[Dealt]
		, [A1].[TransactionType]
		, [A1].[Epic]
		, [A1].[Company]
		-- , [A1].[Director]
		, [B1].[ID] AS [DIRECTOR_ID]
		, [A1].[Position]
		, [A1].[Shares]
		, [A1].[Price_GBP]
		, [A1].[Value_GBP]
		, [A1].[CurrentPrice_GBP]
		, [A1].[% Gain]
		, [A1].[Gain_GBP]
		INTO #ACTIVE -- SELECT REPLACE([Market Cap], 'N/A',0), *
		FROM [CSV].[v_DIRECTOR_DEALS] A1
		JOIN [Alchemy_Stage_Data].[STG].[DIRECTOR] B1 ON [A1].[Epic] = [B1].[Epic] AND [A1].[Director] = [B1].[Director]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- STG
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'DELETE [STG].[DIRECTOR_DEALS_DETAIL]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DELETE [Alchemy_Stage_Data].[STG].[DIRECTOR_DEALS]
		FROM [Alchemy_Stage_Data].[STG].[DIRECTOR_DEALS] B1
		WHERE EXISTS (SELECT 1 FROM #ACTIVE A1 WHERE [A1].[Declared] = [B1].[Declared] AND [A1].[EPIC] = [B1].[EPIC])

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS DELETED (DIRECTOR_DEALS)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	IF @DEBUG = (1) SELECT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[DIRECTOR_DEALS]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		IF @DEBUG = (1)
		BEGIN
			SELECT *
			FROM #ACTIVE A1
			-- WHERE [TICKER] = 'ARBB'
		END

		INSERT INTO [Alchemy_Stage_Data].[STG].[DIRECTOR_DEALS]
		SELECT *
		FROM #ACTIVE A1

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED (DIRECTOR_DEALS) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (DIRECTOR_DEALS)' --  1 email!!
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	-- MANAGE RUNNING TOTALS
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'TRUNCATE TABLE [ALCHEMY_STAGE_DATA].[STG].[DIRECTOR_DEALS_RUNNING_TOTAL]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		TRUNCATE TABLE [ALCHEMY_STAGE_DATA].[STG].[DIRECTOR_DEALS_RUNNING_TOTAL]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- =====================================================================================================================================================================================================
	-- DETERMINE CURRENT HOLDING
	-- =====================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [ALCHEMY_STAGE_DATA].[STG].[DIRECTOR_DEALS_RUNNING_TOTAL]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	; WITH CTE_01_ROOT AS (SELECT
	[A1].[Dealt]
	, [A1].[DIRECTOR_ID]
	, CONVERT(BIGINT, [A1].[Shares]) AS [Shares]
	, CASE [A1].[TransactionType]
	WHEN 'Buy' THEN (1)
	WHEN 'Sell' THEN -(1)
	WHEN 'EXR' THEN (1) -- or -(1) ?
	WHEN 'SEXR' THEN -(1)
	WHEN 'DRI' THEN (1)
	WHEN 'DRIP' THEN (1)
	WHEN 'AWD' THEN (1)
	WHEN 'TIN' THEN (1)
	WHEN 'TOUT' THEN -(1)
	WHEN 'LOF' THEN (1)
	WHEN 'SI' THEN (1)
	WHEN 'PLAC' THEN (1)
	WHEN 'RIS' THEN (1)
	WHEN 'RIIS' THEN (1) -- was (0) dunno
	ELSE [TransactionType]
	END AS [TransactionDirection]
	FROM [Alchemy_Stage_Data].[STG].[DIRECTOR_DEALS] A1
	-- WHERE Director_ID = 96 -- 3 -- 9866
	)

	SELECT [DIRECTOR_ID], [DEALT], ([Shares] * [TransactionDirection]) AS [SHARES_IN_THIS_TRANSACTION], (0) AS [DUMMY_RECORD]
	INTO #CTE_02_ROOT -- DROP TABLE CTE_ROW_NUMBER
	FROM CTE_01_ROOT

	SELECT [DIRECTOR_ID], [DEALT], SUM([SHARES_IN_THIS_TRANSACTION]) AS [SHARES_IN_THIS_TRANSACTION]
	INTO #CTE_02_ROOT_SUM
	FROM #CTE_02_ROOT
	GROUP BY [DIRECTOR_ID], [DEALT]

	CREATE INDEX IDX_001 ON #CTE_02_ROOT ([DIRECTOR_ID])
	CREATE INDEX IDX_001 ON #CTE_02_ROOT_SUM ([DIRECTOR_ID])

	-- ===============================================================================================================================================================================================================
	-- CURSOR THROUGH TRANSACTIONS TO SEE WHERE A DUMMY IS NEEDED TO BRING BALANCE BACK ABOVE ZERO
	-- ===============================================================================================================================================================================================================

	DECLARE @v_DIRECTOR_ID INT, @v_DEALT DATE, @v_SHARES_IN_THIS_TRANSACTION BIGINT, @v_DIRECTOR_ID_OLD INT
	DECLARE @HoldingCurrent BIGINT, @FIRST_TRANSACTION DATE, @i INT

	CREATE TABLE #DUMMY_ROWS_TO_ADD ([DIRECTOR_ID] INT, [DEALT] DATE, [SHARES_IN_THIS_TRANSACTION] BIGINT)

	DECLARE db_cursor_DIRECTOR_DEALS CURSOR FOR
 	SELECT [DIRECTOR_ID], [DEALT], [SHARES_IN_THIS_TRANSACTION]
	FROM #CTE_02_ROOT_SUM -- #CTE_02_ROOT -- WHERE DIRECTOR_ID = 9866
	ORDER BY [DIRECTOR_ID], [DEALT], [SHARES_IN_THIS_TRANSACTION] DESC

	OPEN db_cursor_DIRECTOR_DEALS   
	FETCH NEXT FROM db_cursor_DIRECTOR_DEALS INTO @v_DIRECTOR_ID, @v_DEALT, @v_SHARES_IN_THIS_TRANSACTION

	WHILE @@FETCH_STATUS = (0)  
	BEGIN
		IF @v_DIRECTOR_ID <> ISNULL(@v_DIRECTOR_ID_OLD, (0))
		BEGIN
			SET @HoldingCurrent = @v_SHARES_IN_THIS_TRANSACTION
			SET @FIRST_TRANSACTION = @v_DEALT
			SET @i = 0
		END
		ELSE
			SET @HoldingCurrent = ISNULL(@HoldingCurrent, (0)) + @v_SHARES_IN_THIS_TRANSACTION

		IF @HoldingCurrent < (0)
		BEGIN
			SET @i = @i + 1
			INSERT INTO #DUMMY_ROWS_TO_ADD VALUES (@v_DIRECTOR_ID, DATEADD(DD, -(@i), @FIRST_TRANSACTION), @HoldingCurrent * -(1))
			SET @HoldingCurrent = (0)
		END

		SET @v_DIRECTOR_ID_OLD = @v_DIRECTOR_ID
		FETCH NEXT FROM db_cursor_DIRECTOR_DEALS INTO @v_DIRECTOR_ID, @v_DEALT, @v_SHARES_IN_THIS_TRANSACTION
	END   

	CLOSE db_cursor_DIRECTOR_DEALS   
	DEALLOCATE db_cursor_DIRECTOR_DEALS 

	-- ===============================================================================================================================================================================================================
	-- INSERT DUMMY ROWS
	-- ===============================================================================================================================================================================================================

	INSERT INTO #CTE_02_ROOT ([DIRECTOR_ID], [DEALT], [SHARES_IN_THIS_TRANSACTION], [DUMMY_RECORD])
	SELECT [DIRECTOR_ID], [DEALT], [SHARES_IN_THIS_TRANSACTION], (1)
	FROM #DUMMY_ROWS_TO_ADD

	-- ===============================================================================================================================================================================================================
	-- NOW WE HAVE ALL THE ROWS - GET THE ROW_ID
	-- ===============================================================================================================================================================================================================

	SELECT [DIRECTOR_ID], [DEALT], [SHARES_IN_THIS_TRANSACTION]
	, ROW_NUMBER() OVER(ORDER BY [DIRECTOR_ID] ASC, [DEALT] ASC, [SHARES_IN_THIS_TRANSACTION] DESC) AS [RowID]
	, [DUMMY_RECORD]
	INTO #CTE_03_SHARE_HOLDING_AND_ROWID
	FROM #CTE_02_ROOT A1

	-- ===============================================================================================================================================================================================================
	-- NOW WE HAVE ALL THE ROWS AND ROW_ID - GET THE CURRENT HOLDING
	-- ===============================================================================================================================================================================================================
	SELECT [DIRECTOR_ID], [DEALT], [SHARES_IN_THIS_TRANSACTION]
	, (SELECT SUM([SHARES_IN_THIS_TRANSACTION]) FROM #CTE_03_SHARE_HOLDING_AND_ROWID B1 WHERE [A1].[DIRECTOR_ID] = [B1].[DIRECTOR_ID]
		-- AND [A1].[Dealt] <= [B1].[Dealt] -- 
		AND [A1].[RowID] >= [B1].[RowID]
		) AS [HoldingCurrent]
	, [DUMMY_RECORD]
	INTO #CTE_04_HOLDING_CURRENT
	FROM #CTE_03_SHARE_HOLDING_AND_ROWID A1

	-- ===============================================================================================================================================================================================================
	-- STORE FINAL RESULTS
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		INSERT INTO [ALCHEMY_STAGE_DATA].[STG].[DIRECTOR_DEALS_RUNNING_TOTAL] ([DIRECTOR_ID], [DEALT], [SHARES_IN_THIS_TRANSACTION], [HoldingCurrent], [DUMMY_RECORD])
		SELECT [DIRECTOR_ID], [DEALT], [SHARES_IN_THIS_TRANSACTION], [HoldingCurrent], [DUMMY_RECORD]
		FROM #CTE_04_HOLDING_CURRENT
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================
	DROP TABLE #CTE_02_ROOT
	DROP TABLE #CTE_02_ROOT_SUM
	DROP TABLE #CTE_03_SHARE_HOLDING_AND_ROWID
	DROP TABLE #CTE_04_HOLDING_CURRENT
	DROP TABLE #DUMMY_ROWS_TO_ADD

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]
 (@BUILD_ID INT = 0
, @InvestmentsToAdd dbo.InvestmentsToAdd READONLY
, @ONLY_CONFIGURE_SECTOR_AND_MARKET INT = 0
, @PRINT_ONLY_IF_ERROR INT = 0
, @BUILD_TYPE CHAR(1) = 'F'
, @DEBUG INT = 0)
AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Remove use of [AZURE_R7_ALCHEMY_DATA]
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd -- , '%Futures%', '%KNOWN%', 'ALC%Futures%'
	-- ===============================================================================================================================================================================================================

	-- SET DATEFORMAT DMY
	SET NOCOUNT ON
	SET DATEFORMAT MDY -- SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- SELECT 'ABC @InvestmentsToAdd', * FROM @InvestmentsToAdd -- LBL2,3 are empty ..

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250), @RETURN_VALUE INT
	DECLARE @I_MSG_2500_fn VARCHAR(2500), @NEWLINE CHAR(2)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
	SET @NEWLINE = CHAR(13) + CHAR(10)
	
	SET @I_MSG_2500 = 'START [usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS
	-- ===============================================================================================================================================================================================================

	CREATE TABLE #NEW_INVESTMENTS ([Symbol] VARCHAR(50), [Name] VARCHAR(250), [INVESTMENT_TYPE] VARCHAR(50)
	, [SECTOR]  VARCHAR(100), [MARKET] VARCHAR(100), [LABEL_02] VARCHAR(50), [LABEL_03] VARCHAR(50))

	SET @I_MSG_2500 = 'INSERT INTO #NEW_INVESTMENTS'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	BEGIN TRY
		INSERT INTO #NEW_INVESTMENTS ([Symbol], [Name], [INVESTMENT_TYPE], [SECTOR] , [MARKET], [LABEL_02], [LABEL_03])
		SELECT * FROM @InvestmentsToAdd
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- SELECT '#NEW_INVESTMENTS', * FROM #NEW_INVESTMENTS

	-- ===============================================================================================================================================================================================================
	-- MANAGE BLANK EXTRA LABELS ie CITICODE, SEOL
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'MANAGE BLANK EXTRA LABELS'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	BEGIN TRY
		UPDATE #NEW_INVESTMENTS 
		SET [LABEL_02] = [LABEL_03], [LABEL_03] = ''
		WHERE ISNULL([LABEL_02],'') = ''
		AND ISNULL([LABEL_03],'') <> ''
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'AUTO ADD INVESTMENTS via [Alchemy_Data].[dbo].[usp_ADD_INVESTMENT]:' -- [AZURE_R7_ALCHEMY_DATA].
	+ (SELECT CONVERT(VARCHAR, COUNT(*)) FROM #NEW_INVESTMENTS) + ' rows.'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500
	-- ELSE IF @PRINT_ONLY_IF_ERROR <> 1 PRINT @I_MSG_2500

	IF 0 <> (SELECT COUNT(*) FROM #NEW_INVESTMENTS)
	BEGIN
		BEGIN TRY
			SET @I_MSG_2500 = '['
			SELECT @I_MSG_2500 = COALESCE(@I_MSG_2500+ '], [','[')
			+ [SYMBOL] + ':'
			+ [NAME] + ':'
			+ [INVESTMENT_TYPE] + ':'
			+ [SECTOR] + ':'
			+ [MARKET] + ':'
			+ [LABEL_02] + ':'
			+ [LABEL_03] + ':'
			+ ']' + @NEWLINE
			FROM #NEW_INVESTMENTS
			ORDER BY [NAME]
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		IF @ONLY_CONFIGURE_SECTOR_AND_MARKET = (0)
		BEGIN
			BEGIN TRY
				SET @I_MSG_2500 = CONVERT(VARCHAR(2500), @I_MSG_2500)

				EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG]
				@BUILD_ID = @BUILD_ID
				, @PARENT_USP = @PARENT_USP
				, @PRE_HEADER = 'I:'
				, @BUILD_TYPE = @BUILD_TYPE

				EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL]
				@i_subject = '[BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] INVESTMENTS to add',
				@i_body= @I_MSG_2500 -- , @HEADER = @I_MSG_2500_fn
			END TRY

			BEGIN CATCH
				EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = '[Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL]' -- = @vRE
				RETURN (255)
			END CATCH
		END
	END

	-- ===============================================================================================================================================================================================================
	-- CURSOR THROUGH AND ADD THE INVESTMENT
	-- ===============================================================================================================================================================================================================

	DECLARE @SYMBOL VARCHAR(25), @NAME VARCHAR(250), @INVESTMENT_TYPE VARCHAR(50), @SECTOR VARCHAR(100), @MARKET VARCHAR(100), @LABEL_02 VARCHAR(50), @LABEL_03 VARCHAR(50)

	SET @I_MSG_2500 = 'DECLARE AMI_db_cursor_investment_05 CURSOR'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	DECLARE AMI_db_cursor_investment_05 CURSOR FOR
	SELECT [Symbol], [Name], [INVESTMENT_TYPE], [SECTOR], [MARKET], [LABEL_02], [LABEL_03]
	FROM #NEW_INVESTMENTS

	SET @I_MSG_2500 = 'OPEN AMI_db_cursor_investment_05'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		OPEN AMI_db_cursor_investment_05
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'FETCH NEXT FROM AMI_db_cursor_investment_05 (INITIAL)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	FETCH NEXT FROM AMI_db_cursor_investment_05 INTO @Symbol, @NAME, @INVESTMENT_TYPE, @SECTOR, @MARKET, @LABEL_02, @LABEL_03

	WHILE @@FETCH_STATUS = 0   
	BEGIN
		IF @DEBUG = (1) PRINT 'ZZ1'
		
		SET @I_MSG_2500 = 'START EXEC @RETURN_VALUE = [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[dbo].[usp_ADD_INVESTMENT]:' + @NAME + ':' + @SYMBOL + ':' + @INVESTMENT_TYPE + ':' + @SECTOR + ':' + @MARKET + ':' + @BUILD_TYPE
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

/*
		BEGIN TRY
			EXEC @RETURN_VALUE = [Alchemy_Data].[dbo].[usp_ADD_INVESTMENT] -- [AZURE_R7_ALCHEMY_DATA].
			@BUILD_ID = @BUILD_ID
			, @INVESTMENT_NAME = @NAME
			, @LABEL = @SYMBOL
			, @INVESTMENT_TYPE = @INVESTMENT_TYPE
			, @SECTOR = @SECTOR
			, @MARKET = @MARKET
			, @SHOW_ROWS_IF_INVESTMENT_EXISTS = 1
			, @ONLY_CONFIGURE_SECTOR_AND_MARKET = @ONLY_CONFIGURE_SECTOR_AND_MARKET
			, @PRINT_ONLY_IF_ERROR = @PRINT_ONLY_IF_ERROR
			, @BUILD_TYPE = @BUILD_TYPE
			, @LABEL_02 = @LABEL_02
			, @LABEL_03 = @LABEL_03
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			PRINT 'Error returned from [Alchemy_Data].[dbo].[usp_ADD_INVESTMENT]' -- [AZURE_R7_ALCHEMY_DATA].
		END CATCH
*/

		IF @DEBUG = (1) PRINT 'ZZ2'

		SET @I_MSG_2500 = 'END EXEC @RETURN_VALUE = [Alchemy_Data].[dbo].[usp_ADD_INVESTMENT]' -- [AZURE_R7_ALCHEMY_DATA].
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		SET @I_MSG_2500 = 'FETCH NEXT FROM AMI_db_cursor_investment_05 (loop)'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		IF @DEBUG = (1) PRINT 'ZZ2B'

		SET @I_MSG_2500 = 'FETCH NEXT FROM AMI_db_cursor_investment_05 INTO @Symbol, @NAME, @INVESTMENT_TYPE, @SECTOR, @MARKET, @LABEL_02, @LABEL_03'
		BEGIN TRY
			FETCH NEXT FROM AMI_db_cursor_investment_05 INTO @Symbol, @NAME, @INVESTMENT_TYPE, @SECTOR, @MARKET, @LABEL_02, @LABEL_03
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			PRINT 'Error returned from FETCH'
		END CATCH

		IF @RETURN_VALUE <> 0
		BEGIN
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		END
		IF @DEBUG = (1) PRINT 'ZZ3'
	END

	CLOSE AMI_db_cursor_investment_05   
	DEALLOCATE AMI_db_cursor_investment_05 

	IF @DEBUG = (1) PRINT 'ZZ4'

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1)
	BEGIN
		IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME = 'NEW_INVESTMENTS') DROP TABLE DEBUG.NEW_INVESTMENTS -- CREATE SCHEMA DEBUG
		SELECT *
		INTO DEBUG.NEW_INVESTMENTS
		FROM #NEW_INVESTMENTS
	END

	DROP TABLE #NEW_INVESTMENTS

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA] (@BUILD_ID INT = 0 , @ROWS_IN_BATCH_EXPECTED INT = 1, @BUILD_TYPE CHAR(1) = 'F', @DEBUG INT = 1) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY _DATA].
	-- 1.2		20190218 Change STG to XLS
	-- 1.3		20190307 Move to [Alchemy_Stage_Data]
	--
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA] 0, 1, 1
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		
	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT *
		INTO #ACTIVE
		FROM [XLS].[v_HL_EAH_ISA]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- SHOULD REALLY BE A MERGE .....
	-- ===============================================================================================================================================================================================================
	
	BEGIN TRY
		BEGIN
			SET @I_MSG_2500 = 'DELETE [STG].[HL_PORTFOLIO_SUMMARY]'
			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			PRINT @I_MSG_2500

			DELETE [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY] -- [AZURE_R7_ALCHEMY _DATA].
			WHERE [SIPP_ACCOUNT_ID] = (8)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE ' + 'HL_EAH_ISA]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG_2500 = 'ROWS DELETED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY]' -- [AZURE_R7_ALCHEMY _DATA].
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	BEGIN
		BEGIN TRY
			INSERT INTO [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY] -- [AZURE_R7_ALCHEMY _DATA].
			([SIPP_ACCOUNT_ID], [TradeDate], [SettleDate], [Reference],	[Description], [UnitCost_GBX],[Quantity], [Value_GBP])
			SELECT (8), [Trade date], [Settle date], [Reference], [Description]
			, [UnitCost_GBX]
			, [Quantity]
			, [Value_GBP]
			FROM #ACTIVE B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH
	END

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT HL_EAH_ISA]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ROWS INSERTED (HL_PORTFOLIO_SUMMARY) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (HL_EAH_ISA)'
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP] (@BUILD_ID INT = 0, @ROWS_IN_BATCH_EXPECTED INT = 0, @BUILD_TYPE CHAR(1) = 'F') AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1.		20190213 Stop call to [AZURE_R7_ALCHEMY_ DATA].
	-- 1.2		20190218 Change STG to XLS
	-- 1.3		20190307 Move to [Alchemy_Stage_Data]
	--
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
	SET @DEBUG = (1)
		
	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	BEGIN TRY
		SELECT *
		INTO #ACTIVE
		FROM [XLS].[v_HL_EAH_SIPP]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- GET INVESTMENT DATA
	-- ===============================================================================================================================================================================================================

/*
	SET @I_MSG_2500 = 'CREATE #INVESTMENT table'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	BEGIN TRY
		SELECT *
		INTO #INVESTMENT
		FROM [AZURE_R7_ALCHEMY_ DATA].[Alchemy_Stage_Data].[DIM].[v_INVESTMENT]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH
*/

	-- ===============================================================================================================================================================================================================
	-- SHOULD REALLY BE A MERGE .....
	-- ===============================================================================================================================================================================================================
	BEGIN TRY
		SET @I_MSG_2500 = 'DELETE data FROM [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY]' -- [AZURE_R7_ALCHEMY_ DATA].
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		PRINT @I_MSG_2500

		DELETE [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY]
		WHERE [SIPP_ACCOUNT_ID] = (1)

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG_2500 = 'ROWS DELETED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY]' -- [AZURE_R7_ALCHEMY_ DATA].
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	BEGIN
		BEGIN TRY
			INSERT INTO [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY] -- [AZURE_R7_ALCHEMY_ DATA].
			([SIPP_ACCOUNT_ID], [TradeDate], [SettleDate], [Reference],	[Description], [UnitCost_GBX],[Quantity], [Value_GBP])
			SELECT 1, [Trade date], [Settle date], [Reference], [Description]
			, [UnitCost_GBX]
			, [Quantity]
			, [Value_GBP]
			FROM #ACTIVE B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = 'INSERT INTO [AZURE_R7_ALCHEMY_ DATA].[Alchemy_Stage_Data].[STG].[HL_PORTFOLIO] EAH'
			RETURN (255)
		END CATCH
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ROWS INSERTED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP)'
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_ISA]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_ISA] (@BUILD_ID INT = 0, @ROWS_IN_BATCH_EXPECTED INT = 1, @BUILD_TYPE CHAR(1) = 'F') AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_ DATA].
	-- 1.2		20190218 Change STG to XLS
	-- 1.3		20190307 Move to [Alchemy_Stage_Data]
	--
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_ISA] 0, 1, 1
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
	SET @DEBUG = (1)
		
	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	BEGIN TRY
		SELECT *
		INTO #ACTIVE
		FROM [XLS].[v_HL_KAH_ISA]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- SHOULD REALLY BE A MERGE .....
	-- ===============================================================================================================================================================================================================
	
	BEGIN TRY
		BEGIN
			SET @I_MSG_2500 = 'DELETE [STG].[HL_PORTFOLIO_SUMMARY]'
			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			PRINT @I_MSG_2500

			DELETE [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY] -- [AZURE_R7_ALCHEMY_ DATA].
			WHERE [SIPP_ACCOUNT_ID] = (10)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE ' + 'HL_KAH_ISA]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG_2500 = 'ROWS DELETED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY]' -- [AZURE_R7_ALCHEMY_ DATA].
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	BEGIN
		BEGIN TRY
			INSERT INTO [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY] -- [AZURE_R7_ALCHEMY_ DATA].
			([SIPP_ACCOUNT_ID], [TradeDate], [SettleDate], [Reference],	[Description], [UnitCost_GBX],[Quantity], [Value_GBP])
			SELECT (10), [Trade date], [Settle date], [Reference], [Description]
			, [UnitCost_GBX]
			, [Quantity]
			, [Value_GBP]
			FROM #ACTIVE B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH
	END

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT HL_KAH_ISA]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ROWS INSERTED (HL_PORTFOLIO_SUMMARY) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (HL_KAH_ISA)'
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP] (@BUILD_ID INT =  0, @ROWS_IN_BATCH_EXPECTED INT = 1, @BUILD_TYPE CHAR(1) = 'F') AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_ DATA]
	-- 1.2		20190218 Change STG to XLS
	-- 1.3		20190307 Move to [Alchemy_Stage_Data]
	--
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP] 0, 1, 1
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
	SET @DEBUG = (1)
		
	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	BEGIN TRY
		SELECT * 
		INTO #ACTIVE
		FROM [XLS].[v_HL_KAH_SIPP]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- SHOULD REALLY BE A MERGE
	-- ===============================================================================================================================================================================================================
	
	BEGIN TRY
		BEGIN
			SET @I_MSG_2500 = 'DELETE data FROM [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY]' --- [AZURE_R7_ALCHEMY_ DATA].
			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			PRINT @I_MSG_2500

			DELETE [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY] -- [AZURE_R7_ALCHEMY_ DATA].
			WHERE SIPP_ACCOUNT_ID = (2)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE ' + 'usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG_2500 = 'ROWS DELETED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY]' -- [AZURE_R7_ALCHEMY_ DATA].
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	BEGIN
		BEGIN TRY
			INSERT INTO [Alchemy_Stage_Data].[STG].[HL_PORTFOLIO_SUMMARY] -- [AZURE_R7_ALCHEMY_ DATA].
			([SIPP_ACCOUNT_ID], [TradeDate], [SettleDate], [Reference],	[Description], [UnitCost_GBX],[Quantity], [Value_GBP])
			SELECT 2, [Trade date], [Settle date], [Reference], [Description]
			, [UnitCost_GBX]
			, [Quantity]
			, [Value_GBP]
			FROM #ACTIVE B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH
	END

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT ' + 'usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ROWS INSERTED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (' + 'usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP)'
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_INVESTING_TI_MA]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_INVESTING_TI_MA]
(@BUILD_ID INT = 0
, @DEBUG INT = 0
, @REPORT_SYMBOLS_TO_ADD INT = 0
, @IMPORT_DATA_SUMMARY INT = 1
, @IMPORT_DATA_TI INT = 1
, @CSV_FILE_IN_01 VARCHAR(100) = 'dy-eq-technical-SUMMARY#csv'
, @CSV_FILE_IN_02 VARCHAR(100) = 'dy-eq-technical-TI#csv'
, @SET_INVESTMENT_ID INT = 1
)
WITH RECOMPILE AS
BEGIN

	-- =============================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP# (Note: EQUITY_TECHNICAL_SUMMARY prices stored IN GBP)
	-- Created:	January 2021
	-- Version History:
	-- 1.0		20210107 Initial Release
	-- 1.01		20210109 Add using [Symbol] initially
	-- 1.02		20210113 Add 5Hr01 into calculations
	-- 1.03		20210114 CSV name is a variable now
	-- 1.04		20219115 Add [Alchemy Points]
	-- 1.05		20210118 Adjust [Alchemy Points] weighting to redure focus on PCT GAIN\LOSS
	-- 1.06		20210119 Split points-01 to 01 and 02
	-- 1.07		20210119 Add Oversold and overbought metrics [AlcPoints-06]
	-- 1.08		20210119 Add Volatility metrics [AlcPoints-07]
	-- 1.09		20210208 Add INVESTMENT_ID to [STG].[INVESTING_TECHNICAL]
	-- 1.10		20210209 Add NULL for INVESTMENT_ID during INSERT

	/*
	EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_INVESTING_TI_MA]
	@DEBUG = 1, @IMPORT_DATA_SUMMARY = 1
	-- , @CSV_FILE_IN_01 = 'MN-eq-technical-SUMMARY#csv'
	-- , @CSV_FILE_IN_01 = 'WK-eq-technical-SUMMARY#csv'
	-- , @CSV_FILE_IN_01 = 'DY-eq-technical-SUMMARY#csv'
	-- , @CSV_FILE_IN_01 = 'Hr-eq-technical-SUMMARY#csv'
	-- , @CSV_FILE_IN_01 = 'Hr5-eq-technical-SUMMARY#csv'
	, @CSV_FILE_IN_01 = 'mn-eq-technical-SUMMARY#csv'
	*/
	-- =============================================================================================================================================================================================

	-- =========================================================================================================
	-- SET OPTIONS
	-- =========================================================================================================

	SET DATEFORMAT DMY
	SET NOCOUNT ON
	
	-- =========================================================================================================
	-- TIDY UP
	-- =========================================================================================================

	-- IF EXISTS (SELECT * FROM [tempdb]..[sysobjects] WHERE NAME LIKE '%EQUITY_TECHNICAL_SUMMARY%')
	IF @IMPORT_DATA_SUMMARY = (1)
	BEGIN TRY
		DROP TABLE ##EQUITY_TECHNICAL_SUMMARY
	END TRY
	BEGIN CATCH
		PRINT 'W: DROP TABLE ##EQUITY_TECHNICAL_SUMMARY'
	END CATCH

	IF @IMPORT_DATA_TI = (1)
	BEGIN TRY
		DROP TABLE ##EQUITY_TECHNICAL_TI
	END TRY
	BEGIN CATCH
		PRINT 'W: DROP TABLE ##EQUITY_TECHNICAL_TI'
	END CATCH

	-- =========================================================================================================
	-- READ CSV	& IMPORT DATA (SUMMARY)
	-- =========================================================================================================

	DECLARE @SQL_CSV VARCHAR(4000)
	IF @IMPORT_DATA_SUMMARY = (1)
	BEGIN
		IF @DEBUG = (1) PRINT 'I: Create ##EQUITY_TECHNICAL_SUMMARY (from OpenQuery)'

		SET @SQL_CSV = 'SELECT [ï»¿name] AS [Name] -- [﻿ï»¿name] AS [Name]
		, [Symbol], [PairId], CONVERT(DATETIME, [date time]) AS [ExportDate], [period], [summary]
		, CASE
			WHEN [ma_summary] = ''STRONG BUY'' THEN ''Buy (S)''
			WHEN [ma_summary] = ''BUY'' THEN ''Buy''
			WHEN [ma_summary] = ''NEUTRAL'' THEN ''Neutral''
			WHEN [ma_summary] = ''SELL'' THEN ''Sell''
			WHEN [ma_summary] = ''STRONG SELL'' THEN ''Sell (S)''
			ELSE [ma_summary]
			END AS [ma_summary]
		, [ma_buy], [ma_sell]
		, CASE
			WHEN [ti_summary] = ''STRONG BUY'' THEN ''Buy (S)''
			WHEN [ti_summary] = ''BUY'' THEN ''Buy''
			WHEN [ti_summary] = ''NEUTRAL'' THEN ''Neutral''
			WHEN [ti_summary] = ''SELL'' THEN ''Sell''
			WHEN [ti_summary] = ''STRONG SELL'' THEN ''Sell (S)''
			ELSE [ti_summary]
			END AS [ti_summary]
		, [ti_buy], [ti_sell]
		INTO ##EQUITY_TECHNICAL_SUMMARY
		FROM OPENDATASOURCE(''Microsoft.ACE.OLEDB.12.0'',''Text;Database=C:\Users\Alex\OneDrive;HDR=YES'')...['
		+ @CSV_FILE_IN_01 + '] B
		WHERE [Symbol] IS NOT NULL'

		IF @DEBUG = (1)
		PRINT @SQL_CSV
		
		BEGIN TRY
			EXECUTE (@SQL_CSV)
		END TRY

		BEGIN CATCH
			PRINT 'E: CREATE ##EQUITY_TECHNICAL_SUMMARY'
		END CATCH
	
		BEGIN TRY
			CREATE INDEX IDX01 ON ##EQUITY_TECHNICAL_SUMMARY ([Symbol])
			CREATE INDEX IDX02 ON ##EQUITY_TECHNICAL_SUMMARY ([PAIRID])
		END TRY

		BEGIN CATCH
			PRINT 'E: CREATE INDEXES ON ##EQUITY_TECHNICAL_SUMMARY'
		END CATCH

		-- =====================================================================================================
		-- INSERT DATA
		-- =====================================================================================================

		BEGIN TRY
			INSERT
			INTO [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL]
			SELECT *, NULL -- INVESTMENT_ID
			FROM ##EQUITY_TECHNICAL_SUMMARY A1
			WHERE NOT EXISTS (SELECT 1 FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] B1
							WHERE [A1].[Symbol] = [B1].[Symbol] AND [A1].[ExportDate] = [B1].[ExportDate])
		END TRY

		BEGIN CATCH
			PRINT 'E: INSERT [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL]'
		END CATCH
		
		-- IF @DEBUG = (1)
		SELECT 'INSERTED', @@ROWCOUNT

		DROP TABLE ##EQUITY_TECHNICAL_SUMMARY
		PRINT 'I: Import Only'

		IF @SET_INVESTMENT_ID = (1)
		BEGIN
			BEGIN TRY
				SELECT * -- DROP TABLE #ALL
				INTO #ALL
				FROM [Alchemy_Build].[CSV].[v_INVESTING_EQ_Technical_MA-ALL]
			END TRY

			BEGIN CATCH
				PRINT 'E: CREATE TABLE #ALL'
			END CATCH

			BEGIN TRY
				CREATE INDEX IDX_01 ON #ALL (Symbol)
			END TRY

			BEGIN CATCH
				PRINT 'E: CREATE INDEX ON #ALL'
			END CATCH

				-- SET ROWCOUNT 0

			BEGIN TRY
				UPDATE [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL]
				SET [INVESTMENT_ID] = [B1].[INVESTMENT_ID]
				FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] A1 JOIN #ALL B1
				ON [A1].[Symbol] = [B1].[Symbol] -- OR [A1].[Symbol] = [B1].[Symbol_ALTERNATIVE]
				WHERE [A1].[INVESTMENT_ID] IS NULL
				AND [B1].[INVESTMENT_ID] IS NOT NULL

				DROP TABLE #ALL
			END TRY

			BEGIN CATCH
				PRINT 'E: UPDATE #ALL'
			END CATCH
		END
		
		IF @SET_INVESTMENT_ID = (1)
		BEGIN
			BEGIN TRY
				WITH CTE_HISTORY AS (SELECT DISTINCT [A1].[PairId], [A1].[INVESTMENT_ID] AS [NEW_INVESTMENT_ID] -- , [B1].[PairId], [B1].[INVESTMENT_ID]
				FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] A1
				JOIN [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] B1 ON [A1].[PairId] = [B1].[PairId]
				AND [A1].[INVESTMENT_ID] IS NOT NULL AND [B1].[INVESTMENT_ID] IS NULL
				)
								
				UPDATE [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL]
				SET [INVESTMENT_ID] = [A1].[NEW_INVESTMENT_ID]
				FROM CTE_HISTORY A1
				WHERE [A1].[PairId] = [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL].[PairId]
				AND [INVESTMENT_ID] IS NULL;

				WITH CTE_01_CVS_FILE_IN AS (
					SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-WK]
					UNION
					SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-MN]
					UNION
					SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-DY]
					UNION
					SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-HR]
					UNION
					SELECT TOP 100 PERCENT * FROM [CSV].[v_INVESTING_EQ_Technical_MA-HR5]
				)

				, CTE_MATCHED_ON_SYMBOL_ALTERNATIVE AS (
					SELECT TOP 500 -- 0 PERCENT -- https://stackoverflow.com/questions/3995958/adding-an-index-to-a-Bte - PERFORMANCE ISSUES HERE !!!!
					[B01].[INVESTMENT_ID] AS [INVESTMENT_ID]
					, [B01].[LABEL] AS [B_LABEL]
					, [A01].[Name] -- AS [INVESTMENT_NAME]
					, [A01].[Symbol]
					, [C01].[INVESTMENT_NAME]
					, [A01].[PairId]
					FROM CTE_01_CVS_FILE_IN A01
					JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] B01 ON [B01].[LABEL] = LEFT([A01].[Symbol], LEN([A01].[Symbol]) - (1))
					JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] C01 ON [B01].[INVESTMENT_ID] = [C01].[ID]
					WHERE SOUNDEX([C01].[INVESTMENT_NAME]) = SOUNDEX([A01].[Name])
					AND NOT ([C01].[INVESTMENT_NAME] = 'AVIVA' AND [A01].[Name] = 'Aveva')
					)

				-- SELECT * FROM CTE_MATCHED_ON_SYMBOL_ALTERNATIVE

				UPDATE [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL]
				SET [INVESTMENT_ID] = [B1].[INVESTMENT_ID]
				FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] A1 JOIN [CTE_MATCHED_ON_SYMBOL_ALTERNATIVE] B1
				ON [A1].[PairID] = [B1].[PairID]
				WHERE [A1].[INVESTMENT_ID] IS NULL
				AND [B1].[INVESTMENT_ID] IS NOT NULL

				/*
				IF (1) = (2)
				BEGIN
					DECLARE @j INT = 13

					SELECT DISTINCT [A01].[Symbol], [A01].[pairid], [A01].[name], [A01].[INVESTMENT_ID], [B01].[INVESTMENT_NAME], [B01].[ID]
					INTO #MAYBE
					FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] A01
					JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B01
					ON LEFT([A01].[Name], (@j)) = LEFT([B01].[INVESTMENT_NAME], (@j))
					AND LEFT([A01].[Name], (@j+1)) <> LEFT([B01].[INVESTMENT_NAME], (@j+1))
					AND LEFT([A01].[Name], (@j+2)) <> LEFT([B01].[INVESTMENT_NAME], (@j+2))
					AND LEFT([A01].[Name], (@j+3)) <> LEFT([B01].[INVESTMENT_NAME], (@j+3))
					AND LEFT([A01].[Name], (@j+4)) <> LEFT([B01].[INVESTMENT_NAME], (@j+4))
					WHERE [A01].[INVESTMENT_ID] IS NULL
					AND [A01].[Name] NOT LIKE '%Bon%' -- don't care ...
					/*
					AND [A01].[Name] NOT LIKE '[A-R]%'
					AND [A01].[Name] NOT LIKE 'SPDR Bloomberg Barclays Emerging Markets Local Bon%'
					AND [A01].[Name] NOT LIKE 'SSgA SPDR Barclays Capital UK Gilt%'
					AND [A01].[Name] NOT LIKE 'Standard Life Invest%'
					AND [A01].[Name] NOT LIKE '%Bond%' -- don't care ...
					*/

					SELECT * FROM #MAYBE -- DROP TABLE #MAYBE
					ORDER BY [Name], [INVESTMENT_NAME]

					INSERT INTO #MATCH
					SELECT [Symbol],[ID] FROM #MAYBE WHERE [name] = [INvestment_name]

					INSERT INTO #MATCH
					SELECT [Symbol],[ID] FROM #MAYBE WHERE [Symbol] IN (
						SELECT [Symbol] -- ,  COUNT(*)
						FROM #MAYBE
					GROUP BY [Symbol] -- , [ID]
						HAVING COUNT(*) = (1))

					DROP TABLE #MAYBE

					CREATE TABLE #MATCH (Symbol_SEARCH VARCHAR(25), NEW_INVESTMENT_ID INT) -- DROP TABLE #MATCH
					CREATE UNIQUE INDEX IDX_01 ON #MATCH ([Symbol_SEARCH])

					INSERT INTO #MATCH VALUES ('ANEA', 10565)
					INSERT INTO #MATCH VALUES ('XDBG', 61403)
					INSERT INTO #MATCH VALUES ('MLPI', 60464)
					INSERT INTO #MATCH VALUES ('HPROP', 52193)
					INSERT INTO #MATCH VALUES ('HMEF', 62829)
					INSERT INTO #MATCH VALUES ('ISEMCR', 60453)
					INSERT INTO #MATCH VALUES ('ISAG', 60444)
					INSERT INTO #MATCH VALUES ('FXC', 60441)
					INSERT INTO #MATCH VALUES ('IGLT', 60434)
					INSERT INTO #MATCH VALUES ('CIND', 43347)
					INSERT INTO #MATCH VALUES ('IEDY', 60428)
					INSERT INTO #MATCH VALUES ('SEML', 60427)
					INSERT INTO #MATCH VALUES ('EIMI', 60440)
					INSERT INTO #MATCH VALUES ('ISIJPA', 60439)
					INSERT INTO #MATCH VALUES ('IGSG', 60432)
					INSERT INTO #MATCH VALUES ('IUMO', 41330)
					INSERT INTO #MATCH VALUES ('IDVY', 60419)
					INSERT INTO #MATCH VALUES ('DJMC', 60411)
					INSERT INTO #MATCH VALUES ('DJSC', 60410)
					INSERT INTO #MATCH VALUES ('IDJG', 60409)
					INSERT INTO #MATCH VALUES ('IDJV', 60408)
					INSERT INTO #MATCH VALUES ('IPRP', 60406)
					INSERT INTO #MATCH VALUES ('CEMA', 51550)
					INSERT INTO #MATCH VALUES ('ISFE', 60392)
					INSERT INTO #MATCH VALUES ('IFFF', 60391)
					
					INSERT INTO #MATCH VALUES ('EUE', 41131)
					INSERT INTO #MATCH VALUES ('INRG', 41165)
					INSERT INTO #MATCH VALUES ('INFR', 60395)
					INSERT INTO #MATCH VALUES ('WOODT', 41176)
					INSERT INTO #MATCH VALUES ('IH2O', 41177)
					INSERT INTO #MATCH VALUES ('IEER', 60389)

					-- INSERT INTO #MATCH VALUES ('IEMS', 60388)
					INSERT INTO #MATCH VALUES ('EMUM', 60385)
					INSERT INTO #MATCH VALUES ('ISEUMD', 62476)
					-- INSERT INTO #MATCH VALUES ('ISEUMD', 62448)
					INSERT INTO #MATCH VALUES ('IJPE', 41289)
					INSERT INTO #MATCH VALUES ('IJPH', 62476)
					INSERT INTO #MATCH VALUES ('CMXC0', 43425)
					INSERT INTO #MATCH VALUES ('IPXJ', 60379)
					INSERT INTO #MATCH VALUES ('IPLD', 60378)
					INSERT INTO #MATCH VALUES ('ITWN', 60376)
					INSERT INTO #MATCH VALUES ('UKRE', 62414)

					INSERT INTO #MATCH VALUES ('IGWD', 41334)
					INSERT INTO #MATCH VALUES ('BTEC', 55133)
					INSERT INTO #MATCH VALUES ('CNKY', 43447)
					INSERT INTO #MATCH VALUES ('OMXS', 62371)
					INSERT INTO #MATCH VALUES ('IPDM', 60367)
					INSERT INTO #MATCH VALUES ('SPLTI', 60366)

					INSERT INTO #MATCH VALUES ('IEMS', 43398)
					INSERT INTO #MATCH VALUES ('IEEM', 60387)
					INSERT INTO #MATCH VALUES ('IUCS', 46183)
					INSERT INTO #MATCH VALUES ('IMBA', 62268)

					INSERT INTO #MATCH VALUES ('CMOP', 50845)
					INSERT INTO #MATCH VALUES ('UCAP', 52071)
					INSERT INTO #MATCH VALUES ('GIN', 62163)
					INSERT INTO #MATCH VALUES ('EUSV', 43598)
					INSERT INTO #MATCH VALUES ('VERG', 60336)
					INSERT INTO #MATCH VALUES ('VEVE', 60335)
					INSERT INTO #MATCH VALUES ('VFEM', 60334)
					INSERT INTO #MATCH VALUES ('BRNT', 67132)
					INSERT INTO #MATCH VALUES ('PBRT', 67133)

					INSERT INTO #MATCH VALUES ('SBRT', 67135)
					INSERT INTO #MATCH VALUES ('LBRT', 67137)
					INSERT INTO #MATCH VALUES ('FBRT', 67141)
					INSERT INTO #MATCH VALUES ('SALL', 67146)
					INSERT INTO #MATCH VALUES ('FAIG', 67148)
					INSERT INTO #MATCH VALUES ('WTDGSE', 54790)
					INSERT INTO #MATCH VALUES ('3UKL', 67174)
					INSERT INTO #MATCH VALUES ('3UKS', 67175)
					INSERT INTO #MATCH VALUES ('3GIS', 67306)
					INSERT INTO #MATCH VALUES ('AIGI', 67189)
					INSERT INTO #MATCH VALUES ('PIMT', 67190)

					INSERT INTO #MATCH VALUES ('AIGC', 67144)
					INSERT INTO #MATCH VALUES ('GBCH', 67199)
					INSERT INTO #MATCH VALUES ('GBUR', 67203)
					INSERT INTO #MATCH VALUES ('LEU3', 67208)
					INSERT INTO #MATCH VALUES ('LERO', 67206)
					INSERT INTO #MATCH VALUES ('NGAS', 67227)
					INSERT INTO #MATCH VALUES ('XMEU', 60310)
					INSERT INTO #MATCH VALUES ('VDJP', 43705)
					INSERT INTO #MATCH VALUES ('XUTD', 61807)

					INSERT INTO #MATCH VALUES ('FEQP', 59760)
					INSERT INTO #MATCH VALUES ('UINC', 40783)
					INSERT INTO #MATCH VALUES ('GBSx', 40841)
					INSERT INTO #MATCH VALUES ('CSPX', 41034)
					INSERT INTO #MATCH VALUES ('IE15', 60425)
					INSERT INTO #MATCH VALUES ('IEBB', 62668)
					INSERT INTO #MATCH VALUES ('IEX5', 60424)
					INSERT INTO #MATCH VALUES ('IRCP', 60422)
					INSERT INTO #MATCH VALUES ('IBCX', 62657)
					INSERT INTO #MATCH VALUES ('AGGU', 59721)
					INSERT INTO #MATCH VALUES ('HYLA', 60397)
					INSERT INTO #MATCH VALUES ('GHYS', 41171)
					INSERT INTO #MATCH VALUES ('JPEA', 62544)
					-- INSERT INTO #MATCH VALUES ('IBZL', 65549)

					INSERT INTO #MATCH VALUES ('MSEU', 41568)
					INSERT INTO #MATCH VALUES ('YIEL', 43503)
					INSERT INTO #MATCH VALUES ('MSEX', 41568) -- doo

					INSERT INTO #MATCH VALUES ('CSUK', 65563)
					INSERT INTO #MATCH VALUES ('FEM', 60461)
					INSERT INTO #MATCH VALUES ('IEAM', 41250)
					INSERT INTO #MATCH VALUES ('HRGV', 60148)
					INSERT INTO #MATCH VALUES ('CEUS', 60388)
					INSERT INTO #MATCH VALUES ('BULL', 67182)
					INSERT INTO #MATCH VALUES ('HUKX', 40928)
					INSERT INTO #MATCH VALUES ('HMCX', 40929)
					-- INSERT INTO #MATCH VALUES ('FIFUSA', 40929)

					INSERT INTO #MATCH VALUES ('EUXS', 65549)
					INSERT INTO #MATCH VALUES ('ITKY', 65550)
					INSERT INTO #MATCH VALUES ('IBZL', 65549)
					INSERT INTO #MATCH VALUES ('SDHA', 62793)
					INSERT INTO #MATCH VALUES ('SDIA', 60450)
					INSERT INTO #MATCH VALUES ('FIFUSD', 51861)

					INSERT INTO #MATCH VALUES ('IWDA', 60438)
					INSERT INTO #MATCH VALUES ('IWDG', 60437)
					INSERT INTO #MATCH VALUES ('WMVG', 60430)

					INSERT INTO #MATCH VALUES ('FEQD', 59003)
					INSERT INTO #MATCH VALUES ('FGQI', 51862)
					INSERT INTO #MATCH VALUES ('SUJA', 60381)
					INSERT INTO #MATCH VALUES ('CEU0', 43330)
					INSERT INTO #MATCH VALUES ('CHA', 39594)
					INSERT INTO #MATCH VALUES ('CNDX', 54866)
					INSERT INTO #MATCH VALUES ('H50E', 40927)
					INSERT INTO #MATCH VALUES ('IJPD', 41289)
					INSERT INTO #MATCH VALUES ('IWDE', 41334)
					INSERT INTO #MATCH VALUES ('MXJP', 42610)
					INSERT INTO #MATCH VALUES ('SCEU', 12001)
					INSERT INTO #MATCH VALUES ('SMLP', 66757)
					INSERT INTO #MATCH VALUES ('TIP5', 60449)
					INSERT INTO #MATCH VALUES ('TRG', 10376)
					INSERT INTO #MATCH VALUES ('TRIN', 12604)
					INSERT INTO #MATCH VALUES ('UKMV', 43548)
					INSERT INTO #MATCH VALUES ('WATRI', 12667)
					INSERT INTO #MATCH VALUES ('VEILV', 50353)
					INSERT INTO #MATCH VALUES ('VOD', 4030)
					INSERT INTO #MATCH VALUES ('WHRW', 65714)
					INSERT INTO #MATCH VALUES ('ZPHR', 66790)

					INSERT INTO #MATCH VALUES ('DVRG', 65645)
					INSERT INTO #MATCH VALUES ('FXTGY', 2496)
					INSERT INTO #MATCH VALUES ('MXWO', 42612)
					INSERT INTO #MATCH VALUES ('PETA', 12821)
					INSERT INTO #MATCH VALUES ('ULE', 4735)
					INSERT INTO #MATCH VALUES ('VELA', 67094)
					INSERT INTO #MATCH VALUES ('VMID', 43012)
					INSERT INTO #MATCH VALUES ('XPD', 66805)

					-- INSERT INTO #MATCH VALUES ('ULE', 4735)
					INSERT INTO #MATCH VALUES ('CSUS', 41327)
					INSERT INTO #MATCH VALUES ('VHYL', 59675)
					INSERT INTO #MATCH VALUES ('VERX', 3678)

					UPDATE [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL]
					SET [INVESTMENT_ID] = [NEW_INVESTMENT_ID]
					FROM #MATCH WHERE [Symbol] = [Symbol_SEARCH]
					AND [INVESTMENT_ID]  IS NULL -- AND [Symbol] = 'ANEA'

					DROP TABLE #MATCH 
				END
			*/
			END TRY

			BEGIN CATCH
				PRINT 'I: Never mind ....'
			END CATCH
		END

		IF @IMPORT_DATA_TI <> (1)
		RETURN (0)
	END

	-- =========================================================================================================
	-- READ CSV	& IMPORT DATA (TI)
	-- =========================================================================================================

	IF @IMPORT_DATA_TI = (1)
	BEGIN
		IF @DEBUG = (1) PRINT 'I: Create ##EQUITY_TECHNICAL_TI (from OpenQuery)'

		SET @SQL_CSV = 'SELECT [ï»¿name] AS [Name], [symbol], [pairId], [date time] AS [ExportDate], [period], [rsi_14_value], [rsi_14_action], [stoch_9_6_value], [stoch_9_6_action]
		, [stoch_rsi_14_value], [stoch_rsi_14_action], [macd_12_26_value], [macd_12_26_action], [adx_14_value], [adx_14_action], [williams_r_value], [williams_r_actuin] AS [williams_r_action]
		, [cci_14_value], [cci_14_action], [atr_14_value], [atr_14_action], [highs_lows_14_value], [highs_lows_14_action], [ultimate_oscillator_value]
		, [ultimate_oscillator_action], [roc_value], [roc_action], [bull_bear_power_13_value], [bull_bear_power_13_action]
		-- INTO [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL-TI]
		INTO ##EQUITY_TECHNICAL_TI
		FROM OPENDATASOURCE(''Microsoft.ACE.OLEDB.12.0'',''Text;Database=C:\Users\Alex\OneDrive;HDR=YES'')...['
		+ @CSV_FILE_IN_02 + '] B
		WHERE [Symbol] IS NOT NULL'

		IF @DEBUG = (1)
		PRINT @SQL_CSV
		
		EXECUTE (@SQL_CSV)
	
		CREATE INDEX IDX01 ON ##EQUITY_TECHNICAL_TI ([Symbol])
		CREATE INDEX IDX02 ON ##EQUITY_TECHNICAL_TI ([PAIRID])

		-- =====================================================================================================
		-- INSERT DATA
		-- =====================================================================================================

		INSERT
		INTO [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL-TI]
		SELECT *
		FROM ##EQUITY_TECHNICAL_TI A1
		WHERE NOT EXISTS (SELECT 1 FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL-TI] B1
						WHERE [A1].[Symbol] = [B1].[Symbol] AND [A1].[ExportDate] = [B1].[ExportDate])

		SELECT 'INSERTED', @@ROWCOUNT

		PRINT 'I: Import Only'
		DROP TABLE ##EQUITY_TECHNICAL_TI
		RETURN (0)
	END

	-- =========================================================================================================
	-- MATCH ON SYMBOL
	-- =========================================================================================================

	SELECT [ID], [INVESTMENT_NAME], [INVESTMENT_TYPE_NAME], [PRIMARY_LABEL], [PRIMARY_MARKET]
	INTO #INVESTMENTS
	FROM [Alchemy_Data].[DIM].[v_INVESTMENT]

	CREATE INDEX IDX01 ON #INVESTMENTS ([ID])
	CREATE INDEX IDX02 ON #INVESTMENTS ([PRIMARY_LABEL])

	IF @DEBUG = (1) PRINT 'I: Create #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID'
	SELECT [I].[ID], [H01].[PAIRID]
	INTO #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID -- DROP TABLE #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID
	FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] [H01]
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] I
	ON [I].[PRIMARY_LABEL] = [H01].[SYMBOL]
	GROUP BY [I].[ID], [H01].[PAIRID]

	IF @DEBUG = (1) AND (1) = (2)
	SELECT DISTINCT 'REPORT - MATCH ON SYMBOL', [B].[name], [B].[Symbol], [B].[PairId]
	FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID A
	JOIN [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] B ON [A].[PAIRID] = [B].[PAIRID]

	-- =========================================================================================================
	-- REPORT - MATCH ON SYMBOL (MISSING)
	-- =========================================================================================================

	IF @DEBUG = (1) AND @REPORT_SYMBOLS_TO_ADD = (1)
	SELECT DISTINCT 'REPORT - Missing', [H01].[Name], [H01].[Symbol], [H01].[PAIRID]
	FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] [H01]
	LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] I
	ON [I].[PRIMARY_LABEL] = [H01].[SYMBOL]
	WHERE [I].[ID] IS NULL AND [H01].[Symbol] IS NOT NULL
	AND [Name] NOT LIKE 'Wisdomtree%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE '%X%tracker%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'iShares%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'Lyxor%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'Fundlogic%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'First Trust%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'Fidelity%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'Granite%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE '%UCITS%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'Source%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'UBS%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'Invesco%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'Ossiam%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'PowerShares%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'VanEck%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'PIMCO%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'Vanguard%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE 'DB %' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE '%SPDR%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE '%ETF%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE '%Tracker%' -- expected to be missing at start of exercise
	AND [Name] NOT LIKE '%Sector%' -- expected to be missing at start of exercise

	-- =========================================================================================================
	-- MATCH ON NAME (A)
	-- =========================================================================================================

	DECLARE @SQL VARCHAR(4000), @I INT

	SET @i = 75
	WHILE @i > (1)
	BEGIN
		SET @SQL = 'SELECT [I].[ID], [H01].[PAIRID] FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] H01
		JOIN #INVESTMENTS I -- [Alchemy_Data].[DIM].[v_INVESTMENT] I
		ON LEFT([I].[INVESTMENT_NAME], (' + CONVERT(VARCHAR, @i) + ')) = LEFT([H01].[Name], (' + CONVERT(VARCHAR, @i) + '))
		WHERE NOT EXISTS (SELECT 1 FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID I2 WHERE [I2].[PAIRID] = [H01].[PAIRID])
		AND [I].[INVESTMENT_TYPE_NAME] = ''Equity''
		AND [I].[PRIMARY_MARKET] NOT IN (''FTSE Fledgling (Equities)''
		, ''FTSE AIM 100 (Equities)'', ''FTSE Small Cap (Equities)'', ''FTSE AIM UK 50 (Equities)'')
		GROUP BY [I].[ID], [H01].[PAIRID] -- HAVING COUNT(*) = (5) -- 5 different periods'
		INSERT INTO #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID EXEC (@SQL)

		IF @DEBUG = (1) PRINT @SQL
		SET @i = @i - (1)
	END

	-- =========================================================================================================
	-- MATCH ON NAME (B)
	-- =========================================================================================================
	SET @i = 70
	WHILE @i > (1)
	BEGIN
		SET @SQL = 'SELECT [I].[ID], [H01].[PAIRID] FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] H01
		JOIN #INVESTMENTS I -- [Alchemy_Data].[DIM].[v_INVESTMENT] I
		ON LEFT([I].[INVESTMENT_NAME], (' + CONVERT(VARCHAR, @i) + ')) = LEFT([H01].[Name], (' + CONVERT(VARCHAR, @i) + '))
		WHERE NOT EXISTS (SELECT 1 FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID I2 WHERE [I2].[PAIRID] = [H01].[PAIRID])
		AND [I].[INVESTMENT_TYPE_NAME] = ''Equity''
		AND [I].[PRIMARY_MARKET] NOT IN (''FTSE Fledgling (Equities)''
		, ''FTSE Small Cap (Equities)'', ''FTSE AIM UK 50 (Equities)'')
		GROUP BY [I].[ID], [H01].[PAIRID] -- HAVING COUNT(*) = (5) -- 5 different periods'
		INSERT INTO #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID EXEC (@SQL)

		IF @DEBUG = (1) PRINT @SQL
		SET @i = @i - (1)
	END

	-- =========================================================================================================
	-- MATCH ON NAME (C)
	-- =========================================================================================================
	SET @i = 70
	WHILE @i > (1)
	BEGIN
		SET @SQL = 'SELECT [I].[ID], [H01].[PAIRID] FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] H01
		JOIN #INVESTMENTS I -- [Alchemy_Data].[DIM].[v_INVESTMENT] I
		ON LEFT([I].[INVESTMENT_NAME], (' + CONVERT(VARCHAR, @i) + ')) = LEFT([H01].[Name], (' + CONVERT(VARCHAR, @i) + '))
		WHERE NOT EXISTS (SELECT 1 FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID I2 WHERE [I2].[PAIRID] = [H01].[PAIRID])
		AND [I].[INVESTMENT_TYPE_NAME] = ''Equity''
		AND [I].[PRIMARY_MARKET] NOT IN (''FTSE Small Cap (Equities)'', ''FTSE AIM UK 50 (Equities)'')
		GROUP BY [I].[ID], [H01].[PAIRID] -- HAVING COUNT(*) = (5) -- 5 different periods'
		INSERT INTO #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID EXEC (@SQL)

		IF @DEBUG = (1) PRINT @SQL
		SET @i = @i - (1)
	END

	-- =========================================================================================================
	-- MATCH ON NAME (D)
	-- =========================================================================================================
	SET @i = 70
	WHILE @i > (1)
	BEGIN
		SET @SQL = 'SELECT [I].[ID], [H01].[PAIRID] FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] H01
		JOIN #INVESTMENTS I -- [Alchemy_Data].[DIM].[v_INVESTMENT] I
		ON LEFT([I].[INVESTMENT_NAME], (' + CONVERT(VARCHAR, @i) + ')) = LEFT([H01].[Name], (' + CONVERT(VARCHAR, @i) + '))
		WHERE NOT EXISTS (SELECT 1 FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID I2 WHERE [I2].[PAIRID] = [H01].[PAIRID])
		AND [I].[INVESTMENT_TYPE_NAME] = ''Equity''
		GROUP BY [I].[ID], [H01].[PAIRID] -- HAVING COUNT(*) = (5) -- 5 different periods'
		INSERT INTO #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID EXEC (@SQL)

		IF @DEBUG = (1) PRINT @SQL
		SET @i = @i - (1)
	END

	-- =========================================================================================================
	-- MATCH ON NAME (E)
	-- =========================================================================================================
	SET @i = 70
	WHILE @i > (1)
	BEGIN
		SET @SQL = 'SELECT [I].[ID], [H01].[PAIRID] FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] H01
		JOIN #INVESTMENTS I -- [Alchemy_Data].[DIM].[v_INVESTMENT] I
		ON LEFT([I].[INVESTMENT_NAME], (' + CONVERT(VARCHAR, @i) + ')) = LEFT([H01].[Name], (' + CONVERT(VARCHAR, @i) + '))
		WHERE NOT EXISTS (SELECT 1 FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID I2 WHERE [I2].[PAIRID] = [H01].[PAIRID])
		GROUP BY [I].[ID], [H01].[PAIRID] -- HAVING COUNT(*) = (5) -- 5 different periods'
		INSERT INTO #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID EXEC (@SQL)

		IF @DEBUG = (1) PRINT @SQL
		SET @i = @i - (1)
	END

	-- =========================================================================================================
	-- REPORT DUPLICATES e.g. M&S
	-- =========================================================================================================

	IF @DEBUG = (1) AND EXISTS(SELECT [PAIRID] FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID GROUP BY [PAIRID] HAVING COUNT(*) > (1))
	SELECT 'REPORT - Duplicates', * FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID A 
	JOIN #INVESTMENTS B ON [A].[ID] = [B].[ID]
	WHERE [PAIRID] IN (SELECT [PAIRID] FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID GROUP BY [PAIRID] HAVING COUNT(*) > (1))
	ORDER BY [PAIRID]

	-- =========================================================================================================
	-- REMOVE DUPLICATES (A)
	-- =========================================================================================================

	DELETE #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID
	WHERE [PAIRID] IN (SELECT [PAIRID] FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID GROUP BY [PAIRID] HAVING COUNT(*) > (1))

	IF @DEBUG = (1) AND @@ROWCOUNT > (0)
	SELECT 'DELETE (1)', @@ROWCOUNT

	-- =========================================================================================================
	-- REMOVE DUPLICATES (B)
	-- =========================================================================================================

	DELETE #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID
	WHERE [ID] IN (SELECT [ID] FROM #EQUITY_TECHNICAL_SUMMARY_INVESTMENT_ID GROUP BY [ID] HAVING COUNT(*) > (1))

	IF @DEBUG = (1) AND @@ROWCOUNT > (0)
	SELECT 'DELETE (2)', @@ROWCOUNT

	-- =========================================================================================================
	-- 
	-- =========================================================================================================

	/*
	Hourly
	5 Hours
	Daily
	Weekly
	Monthly
	*/

	IF @IMPORT_DATA_SUMMARY = (1)
		DROP TABLE ##EQUITY_TECHNICAL_SUMMARY

	IF @IMPORT_DATA_TI = (1)
		DROP TABLE ##EQUITY_TECHNICAL_TI

	-- =========================================================================================================
	-- THE END
	-- =========================================================================================================
	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_SHORT_TRACKER]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_SHORT_TRACKER] (@BUILD_ID INT = 0, @ROWS_IN_BATCH_EXPECTED INT = 0, @BUILD_TYPE CHAR(1) = 'F', @DEBUG INT = 0) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	July 2019
	-- Version History:
	-- 1.0		Initial Release
	
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_SHORT_TRACKER]
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT [A1].[Company]
		, [A1].[Ticker]
		, [A1].[Fund]
		, [A1].[% short]
		, [A1].[Change_Pct]
		, [A1].[CALC_CHANGE_PCT]
		, [A1].[Date Changed]
		, [A1].[DateOfExport]
		, [A1].[Current_YN]
		INTO #ACTIVE -- SELECT REPLACE([Market Cap], 'N/A',0), *
		FROM [CSV].[v_SHORT_TRACKER_DETAIL] A1

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- STG
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'DELETE [STG].[SHORT_TRACKER_DETAIL]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DELETE [Alchemy_Stage_Data].[STG].[SHORT_TRACKER_DETAIL]
		-- FROM [Alchemy_Stage_Data].[STG].[SHORT_TRACKER_DETAIL] B -- [AZURE_R7_ALCHEMY_DATA].
		-- WHERE EXISTS (SELECT 1 FROM #ACTIVE A WHERE [A].[DateOfExport] = [B].[DateOfExport] AND [A].EPIC = [B].[EPIC]) -- 20171130

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS DELETED (SHORT_TRACKER)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[SHORT_TRACKER_DETAIL]' -- [AZURE_R7_ALCHEMY_DATA].
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		IF @DEBUG = (1)
		BEGIN
			SELECT [A1].[Company]
			, [A1].[Ticker]
			, [A1].[Fund]
			, [A1].[% short]
			, [A1].[Change_Pct]
			, [A1].[CALC_CHANGE_PCT]
			, [A1].[Date Changed]
			, [A1].[DateOfExport]
			, [A1].[Current_YN]
			FROM #ACTIVE A1
		END

		INSERT INTO [Alchemy_Stage_Data].[STG].[SHORT_TRACKER_DETAIL] ([Company]
		, [Ticker]
		, [Fund]
		, [% short]
		, [Change_Pct]
		, [CALC_CHANGE_PCT]
		, [Date Changed]
		, [DateOfExport]
		, [Current_YN]
		)
		SELECT [A1].[Company]
		, [A1].[Ticker]
		, [A1].[Fund]
		, [A1].[% short]
		, [A1].[Change_Pct]
		, [A1].[CALC_CHANGE_PCT]
		, [A1].[Date Changed]
		, [A1].[DateOfExport]
		, [A1].[Current_YN]
		FROM #ACTIVE A1 -- DROP TABLE ALEX_ACTIVE_B B -- 
		-- WHERE [Ticker] IS NULL

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED (SHORT_TRACKER) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (SHORT_TRACKER)' --  1 email!!
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_INDICES]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_INDICES] (@BUILD_ID INT = 0, @ROWS_IN_BATCH_EXPECTED INT = 0, @BUILD_TYPE CHAR(1) = 'F', @DEBUG INT = 1) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	April 2018
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190218 Change [STG].[v_STOCK_EXCHANGE_INVESTMENT_INDICES] to [CSV].[v_STOCK_EXCHANGE_INVESTMENT_INDICES]
	-- 1.3		20190319 Change [Alchemy_Data].[STG].[TELEGRAPH_ INDICES]
	--
	-- [BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_INDICES]
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1) PRINT 'A'

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		SELECT [EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [ExportDate] AS [DateOfExport], [IndexNameShort], [IndexName], [Ticker] AS [EPIC], [Investment Name], [Currency]
		, MAX([Price]) AS [Price]
		, MAX([ABS_CHange]) AS [ABS_CHange]
		, MAX([PCT_Change]) AS [PCT_Change]
		INTO #ACTIVE -- SELECT *
		FROM [CSV].[v_STOCK_EXCHANGE_INVESTMENT_INDICES]
		GROUP BY [EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [ExportDate], [IndexNameShort], [IndexName], [Ticker], [Investment Name], [Currency]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT 'B'

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- STG
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'DELETE [STG].[TELEGRAPH_INDICES]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1) PRINT 'C'

	BEGIN TRY
		DELETE [Alchemy_Stage_Data].[STG].[TELEGRAPH_INDICES] -- SELECT *  -- [AZURE_R7_ALCHEMY_DATA].
		FROM [Alchemy_Stage_Data].[STG].[TELEGRAPH_INDICES] B -- [AZURE_R7_ALCHEMY_DATA].
		WHERE EXISTS (SELECT 1 FROM #ACTIVE A WHERE [A].[DateOfExport] = [B].[DateOfExport] AND [A].EPIC = [B].[EPIC]) -- 20171130

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT 'D'

	SET @I_MSG_2500 = 'ROWS DELETED (TELEGRAPH_INDICES)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1) PRINT 'E'

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[TELEGRAPH_INDICES]' -- [AZURE_R7_ALCHEMY_DATA].
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		INSERT INTO [Alchemy_Stage_Data].[STG].[TELEGRAPH_INDICES] ([EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [DateOfExport], [IndexNameShort], [IndexName], [EPIC] -- [AZURE_R7_ALCHEMY_DATA].
		, [Investment Name], [Currency], [Price], [ABS_CHange], [PCT_Change] )
		SELECT [EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [DateOfExport], [IndexNameShort], [IndexName], [EPIC], [Investment Name], [Currency], [Price], [ABS_CHange], [PCT_Change]
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT 'F'

	SET @I_MSG_2500 = 'ROWS INSERTED (TELEGRAPH_INDICES) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (TELEGRAPH_INDICES)' --  1 email!!'
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	IF @DEBUG = (1) PRINT 'G'

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END

GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR] (@BUILD_ID INT = 0, @ROWS_IN_BATCH_EXPECTED INT = 0, @BUILD_TYPE CHAR(1) = 'F', @DEBUG INT = 1) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190218 [STG].[v_TELEGRAPH_SECTOR] becomes [CSV].[v_TELEGRAPH_SECTOR]
	-- 1.3		20190218 Change [Alchemy_Data].[STG].[TELEGRAPH_SECTOR] to [Alchemy_Stage_Data].[STG].[TELEGRAPH_SECTOR]
	--
	-- import data FROM Excel
	-- https://support.microsoft.com/en-gb/kb/321686#bookmark-4c
	-- http://www.excel-sql-server.com/excel-import-to-sql-server-using-linked-servers.htm

	-- exec [BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR]
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT [Sector], [EPIC], [Name], [PRICE_GBP]
		, REPLACE([Market Cap], 'N/A',0) AS [Market Cap]
		, [DateOfExport], [EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [EST_SECTOR_ID], [EST_SECTOR_ID_COUNT] 
		INTO #ACTIVE -- SELECT REPLACE([Market Cap], 'N/A',0), *
		FROM [CSV].[v_TELEGRAPH_SECTOR] -- [STG].[v_TELEGRAPH_SECTOR]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- STG
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'DELETE [STG].[TELEGRAPH_SECTOR]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DELETE [Alchemy_Stage_Data].[STG].[TELEGRAPH_SECTOR] -- [AZURE_R7_ALCHEMY_DATA].
		FROM [Alchemy_Stage_Data].[STG].[TELEGRAPH_SECTOR] B -- [AZURE_R7_ALCHEMY_DATA].
		WHERE EXISTS (SELECT 1 FROM #ACTIVE A WHERE [A].[DateOfExport] = [B].[DateOfExport] AND [A].EPIC = [B].[EPIC]) -- 20171130

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS DELETED (TELEGRAPH_SECTOR)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[TELEGRAPH_SECTOR]' -- [AZURE_R7_ALCHEMY_DATA].
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		IF @DEBUG = (1)
		BEGIN
			SELECT [Sector], [EPIC], [Name], [PRICE_GBP], [Market Cap], [DateOfExport], [EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [EST_SECTOR_ID], [EST_SECTOR_ID_COUNT]
			-- INTO ALEX_ACTIVE_B
			FROM #ACTIVE B
		END

		INSERT INTO [Alchemy_Stage_Data].[STG].[TELEGRAPH_SECTOR] ([Sector], [EPIC], [Name], [Price] -- [AZURE_R7_ALCHEMY_DATA].
		, [Market Cap]
		/* .. can cause
		Msg 8114, Level 16, State 5, Line 89
		Error converting data type nvarchar to float.
		*/
		, [DateOfExport]
		, [EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [EST_SECTOR_ID], [EST_SECTOR_ID_COUNT] )
		SELECT [Sector], [EPIC], [Name], [PRICE_GBP]
		, [Market Cap]
		, [DateOfExport], [EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [EST_SECTOR_ID], [EST_SECTOR_ID_COUNT] 
		FROM #ACTIVE B -- DROP TABLE ALEX_ACTIVE_B B -- 

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED (TELEGRAPH_SECTOR) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (TELEGRAPH_SECTOR)' --  1 email!!
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END


GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ADD_MISSING_INVESTMENTS]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ADD_MISSING_INVESTMENTS]
(@BUILD_ID INT = 0
, @ACTIVE_MAIN_SET_IN [dbo].[InvestmentsToAdd_With_3_Tickers] READONLY
, @MARKET VARCHAR(50)
, @DEBUG INT = 0
, @BUILD_TYPE CHAR(1) = 'F'
) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2017
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_DATA].
	--
	-- EXEC sp_depends [BLD.usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ADD_MISSING_INVESTMENTS]
	-- BLD.usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS is one of them ... 
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)
	DECLARE @ALERT_OVER_X_SECS INT, @STEP_START DATETIME, @INVESTMENT_TYPE VARCHAR(50)

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	SET @ALERT_OVER_X_SECS = (30)
	SET @STEP_START = GETDATE()

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- 20180103 -- INVESTMENTS ARE UNQIUE BY COMBINATION OF ISINCODE, CITICODE and SEDOL
	-- THIS MEANS THE LOGIC BELOW NEEDS TO BE RECODED !!!
	-- ===============================================================================================================================================================================================================

	RETURN (0)

	-- ===============================================================================================================================================================================================================
	-- PARAMETER CHECK
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = '@MARKET NOT IN (''ALC (Exchange Traded Funds)'', ''IA (Unit Trusts & OEICS)'')'
	IF @MARKET NOT IN ('ALC (Exchange Traded Funds)', 'IA (Unit Trusts & OEICS)')
	BEGIN
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- SET VALUES
	-- ===============================================================================================================================================================================================================

	IF @MARKET = 'ALC (Exchange Traded Funds)'
	BEGIN
		SET @INVESTMENT_TYPE = 'Exchange Traded Fund'
	END

	IF @MARKET = 'IA (Unit Trusts & OEICS)'
	BEGIN
		SET @INVESTMENT_TYPE = 'Fund'
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

		-- ===============================================================================================================================================================================================================
		-- 
		-- ===============================================================================================================================================================================================================
		SET @I_MSG_2500 = 'CREATE #ISINCODE_NOT_IN_INVESTMENT_ALIAS'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			SELECT DISTINCT [ISINCODE], [INVESTMENT_Name], @INVESTMENT_TYPE AS [INVESTMENT_TYPE]

			, CASE WHEN @MARKET = 'ALC (Exchange Traded Funds)' THEN
				CASE WHEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other') NOT LIKE '%OTHER%' 
				THEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other')
				ELSE '%' + ISNULL([SECTOR], 'SECTOR_NOT_CALCULATED') +'%' END
			  ELSE [SECTOR]
			  END AS [SECTOR]
			-- GetAlcSectorGroupFromSector already run in [usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF]
			-- , [SECTOR] AS [SECTOR]

			, @MARKET AS [MARKET]
			INTO #ISINCODE_NOT_IN_INVESTMENT_ALIAS
			FROM @ACTIVE_MAIN_SET_IN B
			WHERE [INVESTMENT_Name] LIKE '[%A-Za-z]%'
			AND ISNULL([ISINCODE],'') NOT IN ('N/A', '') -- ADDED 20170913
			-- AND [Fund_Counter] = (1) -- 20171005 -- 20170630
			AND [ISINCODE] NOT IN (SELECT [LABEL] FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS]) -- [AZURE_R7_ALCHEMY_DATA].
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		-- ===============================================================================================================================================================================================================
		-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
		-- ===============================================================================================================================================================================================================

		SET @I_MSG_2500 = 'CREATE #CITICODE_NOT_IN_INVESTMENT_ALIAS - CITICODE'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			SELECT DISTINCT [CITICODE], [INVESTMENT_Name], @INVESTMENT_TYPE AS [NVESTMENT_TYPE]

			, CASE WHEN @MARKET = 'ALC (Exchange Traded Funds)' THEN
				CASE WHEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other') NOT LIKE '%OTHER%' 
				THEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other')
				ELSE '%' + ISNULL([SECTOR], 'SECTOR_NOT_CALCULATED') +'%' END
			  ELSE [SECTOR]
			  END
			AS [SECTOR]

			, @MARKET AS [MARKET]
			INTO #CITICODE_NOT_IN_INVESTMENT_ALIAS
			FROM @ACTIVE_MAIN_SET_IN B
			WHERE [INVESTMENT_Name] LIKE '[%A-Za-z]%'
			-- AND [Fund_Counter] = (1) -- 20171005 -- 20170630
			AND ISNULL([CITICODE],'') NOT IN ('N/A', '') -- ADDED 20170913
			AND [CITICODE] NOT IN (SELECT [LABEL] FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS]) -- [AZURE_R7_ALCHEMY_DATA].
			-- 20171004 AND [ISINCODE] NOT IN (SELECT [SYMBOL] FROM @InvestmentsToAdd) -- ensure we do not add what we have above

			IF @DEBUG = (1)
			SELECT TOP (250) '#CITICODE_NOT_IN_INVESTMENT_ALIAS', * FROM #CITICODE_NOT_IN_INVESTMENT_ALIAS
			WHERE [SECTOR] NOT LIKE '%SECTOR_NOT_CALCULATED%' AND [SECTOR] LIKE '(Alc)%'
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		-- ===============================================================================================================================================================================================================
		-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
		-- 20171004 ADDED
		-- ===============================================================================================================================================================================================================

		SET @I_MSG_2500 = 'CREATE #SEDOL_NOT_IN_INVESTMENT_ALIAS - SEDOL'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			SELECT DISTINCT [SEDOL], [INVESTMENT_Name], @INVESTMENT_TYPE AS [INVESTMENT_TYPE]

			, CASE WHEN @MARKET = 'ALC (Exchange Traded Funds)' THEN
				CASE WHEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other') NOT LIKE '%OTHER%' 
				THEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other')
				ELSE '%' + ISNULL([SECTOR], 'SECTOR_NOT_CALCULATED') +'%' END
			  ELSE [SECTOR]
			  END
			AS [SECTOR]

			, @MARKET AS [MARKET]
			INTO #SEDOL_NOT_IN_INVESTMENT_ALIAS
			FROM @ACTIVE_MAIN_SET_IN B
			WHERE [INVESTMENT_Name] LIKE '[%A-Za-z]%'
			-- AND [Fund_Counter] = (1) -- 20171005 -- 20170630
			AND ISNULL([SEDOL],'') NOT IN ('N/A', '') -- ADDED 20170913
			AND [SEDOL] NOT IN (SELECT [LABEL] FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS]) -- [AZURE_R7_ALCHEMY_DATA].
			IF @DEBUG = (1)
			SELECT TOP (250) '#SEDOL_NOT_IN_INVESTMENT_ALIAS', * FROM #SEDOL_NOT_IN_INVESTMENT_ALIAS
			WHERE [SECTOR] NOT LIKE '%SECTOR_NOT_CALCULATED%' AND [SECTOR] LIKE '(Alc)%'
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		-- ===============================================================================================================================================================================================================
		--
		-- ===============================================================================================================================================================================================================

		SELECT [A].[ISINCODE] -- [A].[SYMBOL] -- [ISINCODE] -- [SYMBOL] 20171005
		, ISNULL([C].[SEDOL],'') AS [SEDOL]			-- 20171101
		, ISNULL([B].[CitiCode],'')	AS [CitiCode]	-- 20171101
		, [A].[INVESTMENT_NAME]
		, [A].[INVESTMENT_TYPE]
		, [A].[SECTOR] -- GetAlcSectorGroupFromSector already run in [usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF]
		/*
		, CASE WHEN [dbo].[GetAlcSectorGroupFromSector] ([A].[INVESTMENT_NAME], 'Other') LIKE '%Other%'
		THEN [dbo].[GetAlcSectorGroupFromSector] ([A].[Sector], 'SECTOR_NOT_CALCULATED')
		ELSE 'FAIL GetAlcSectorGroupFromSector' END AS [SECTOR]
		*/ -- THIS IS NOT CHEKCING IF THIS IS OEIC OR ETF ....
		, [A].[Market]
		INTO #PERFECT_MATCH_ON_ISIN_CODE
		FROM #ISINCODE_NOT_IN_INVESTMENT_ALIAS A
		LEFT JOIN #CITICODE_NOT_IN_INVESTMENT_ALIAS B ON [A].[INVESTMENT_NAME] = [B].[INVESTMENT_NAME]	-- 20171101 -- worked for 'iShares Automation & Robotics UCITS ETF Inc USD', ID:54963
		LEFT JOIN #SEDOL_NOT_IN_INVESTMENT_ALIAS    C ON [A].[INVESTMENT_NAME] = [C].[INVESTMENT_NAME]	-- 20171101

		-- .. Next stage  of development is where ISIN is blank but sedol\citicode isn't

		SELECT '#PERFECT_MATCH_ON_ISIN_CODE', * FROM #PERFECT_MATCH_ON_ISIN_CODE

		INSERT INTO @InvestmentsToAdd ([SYMBOL], [LABEL_02], [LABEL_03], [INVESTMENT_NAME], [INVESTMENT_TYPE], [SECTOR], [MARKET]) -- Added 2017041
		SELECT [ISINCODE], [SEDOL], [CitiCode], [INVESTMENT_NAME], [INVESTMENT_TYPE], [SECTOR], [Market]
		FROM #PERFECT_MATCH_ON_ISIN_CODE
		WHERE [SECTOR] NOT LIKE '%SECTOR_NOT_CALCULATED%'
		AND [SECTOR] NOT LIKE '%FAIL GetAlcSectorGroupFromSector%'

		IF @DEBUG = (1)
		SELECT '@InvestmentsToAdd', * FROM @InvestmentsToAdd
		
		IF @DEBUG = (1)
		SELECT * FROM #PERFECT_MATCH_ON_ISIN_CODE
		WHERE [SECTOR] NOT LIKE '%SECTOR_NOT_CALCULATED%'

		DROP TABLE #PERFECT_MATCH_ON_ISIN_CODE

		-- ===============================================================================================================================================================================================================
		-- SPECIAL CONSIDERATION FOR BAD DATA (IA)
		-- ===============================================================================================================================================================================================================

		IF @MARKET = 'IA (Unit Trusts & OEICS)' AND (1) = (2) -- IGNORE FOR NOW 20171102
		BEGIN
			UPDATE @InvestmentsToAdd SET [SECTOR] = 'IA ' + [SECTOR] WHERE [SECTOR] NOT LIKE 'IA %'
		END

		-- ===============================================================================================================================================================================================================
		-- WE NEED A STEP ALSO TO ADD CODES AS ALIAS TO EXISTING INVESTMENTS !!!!
		-- ===============================================================================================================================================================================================================

		-- ===============================================================================================================================================================================================================
		-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
		-- ===============================================================================================================================================================================================================

		IF (SELECT COUNT(*) FROM @InvestmentsToAdd) > 0
		BEGIN TRY
			SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] - ADD INVESTMENTS'
			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

			IF @DEBUG = (1)
			BEGIN
				SET @I_MSG_2500 = 'START - SELECT * FROM @InvestmentsToAdd'
				EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	
				SELECT 'usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS @InvestmentsToAdd', * FROM @InvestmentsToAdd

				SET @I_MSG_2500 = 'END - SELECT * FROM @InvestmentsToAdd'
				EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			END

			SET @I_MSG_2500 = ISNULL(LEFT('START - EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]'
			+ ':@BUILD_ID =' + ISNULL(CONVERT(VARCHAR, @BUILD_ID),'')
			+ ':@ONLY_CONFIGURE_SECTOR_AND_MARKET=1'
			+ ':@PRINT_ONLY_IF_ERROR=1'
			+ ':@BUILD_TYPE=' + CONVERT(VARCHAR, @BUILD_TYPE), 2500), 'WTF am I null?')
		 
			IF @DEBUG = (1)
			PRINT @I_MSG_2500

			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

			EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] @BUILD_ID = @BUILD_ID -- = @vRE
			, @InvestmentsToAdd = @InvestmentsToAdd
			, @ONLY_CONFIGURE_SECTOR_AND_MARKET = 0
			, @PRINT_ONLY_IF_ERROR = 1
			, @BUILD_TYPE = @BUILD_TYPE

			SET @I_MSG_2500 = 'END - EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]'
			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH
	
		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] - SET [SECTOR] AND MARKET:'
	+ CONVERT(VARCHAR(10), (SELECT COUNT(*) FROM @InvestmentsToAdd)) + ' rows.'

	BEGIN TRY
		DROP TABLE #CITICODE_NOT_IN_INVESTMENT_ALIAS
		DROP TABLE #SEDOL_NOT_IN_INVESTMENT_ALIAS
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END









GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_INVESTMENT_NAME]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_INVESTMENT_NAME] (@BUILD_ID INT = 0
, @ACTIVE_MAIN_SET_IN [dbo].[InvestmentsToAdd_With_3_Tickers] READONLY
, @DEBUG INT = 0, @BUILD_TYPE CHAR(1) = 'F'
) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2017
	-- Version History:
	-- 1.0		Initial Release
	--
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)
	DECLARE @ALERT_OVER_X_SECS INT, @STEP_START DATETIME

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	SET @ALERT_OVER_X_SECS = (30)
	SET @STEP_START = GETDATE()

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
		
	-- ===============================================================================================================================================================================================================
	-- Get a list of all investments so that we can now set the [SECTOR] correctly
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO @InvestmentsToAdd (To set [SECTOR] and [MARKET])'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500
	, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY -- 20180130 WIP !!!!!!!!!!!!!!!!!!!!!
		SELECT [ISINCODE], [INVESTMENT_NAME] -- [PriceName]
		INTO #SET_INVESTMENT_NAME
		FROM @ACTIVE_MAIN_SET_IN B -- #ACTIVE B
		LEFT JOIN [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[ETF_SECTOR_TO_ALCHEMY_SECTOR] M ON [B].[SECTOR] = [SECTOR_ETF]
		WHERE [B].[INVESTMENT_NAME] LIKE '[%A-Za-z]%' -- PriceName
		AND [B].[ISINCODE] NOT IN ('N/A', '') -- ADDED 20170913
		-- ORDER BY 4 DESC
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500
	, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] - SET [SECTOR] AND [MARKET]:'
	+ CONVERT(VARCHAR(10), (SELECT COUNT(*) FROM @InvestmentsToAdd)) + ' rows.'

	IF (SELECT COUNT(*) FROM @InvestmentsToAdd) > 0 AND (1) = (2) -- WIP - NOTHING REALLY DONE HERE YET TO MANAGE INVESTMENT NAME - this is from usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET
	BEGIN TRY

		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		SET @I_MSG_2500 = 'START - EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]'
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] @BUILD_ID = @BUILD_ID -- = @vRE
		, @InvestmentsToAdd = @InvestmentsToAdd
		, @ONLY_CONFIGURE_SECTOR_AND_MARKET = 1
		, @PRINT_ONLY_IF_ERROR = 1
		, @BUILD_TYPE = @BUILD_TYPE

		SET @I_MSG_2500 = 'END - EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]'
			EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500
	, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	-- SELECT * INTO _EAH_SET_INVESTMENT_NAME FROM #SET_INVESTMENT_NAME
	DROP TABLE #SET_INVESTMENT_NAME

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END




GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET] (@BUILD_ID INT = 0
, @ACTIVE_MAIN_SET_IN [dbo].[InvestmentsToAdd_With_3_Tickers] READONLY
, @MARKET VARCHAR(50)
, @DEBUG INT = 0, @BUILD_TYPE CHAR(1) = 'F'
) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2017
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_DATA].

	-- exec [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET] @market = 'IA (Unit Trusts & OEICS)', @DEBUG = 1
	--
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)
	DECLARE @ALERT_OVER_X_SECS INT, @STEP_START DATETIME, @INVESTMENT_TYPE VARCHAR(50)

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	SET @ALERT_OVER_X_SECS = (30)
	SET @STEP_START = GETDATE()

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		
	-- ===============================================================================================================================================================================================================
	-- PARAMETER CHECK
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = '@MARKET NOT IN (''ALC (Exchange Traded Funds)'', ''IA (Unit Trusts & OEICS)'')'
	IF @MARKET NOT IN ('ALC (Exchange Traded Funds)', 'IA (Unit Trusts & OEICS)')
	BEGIN
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- SET VALUES
	-- ===============================================================================================================================================================================================================

	IF @MARKET = 'ALC (Exchange Traded Funds)'
	BEGIN
		SET @INVESTMENT_TYPE = 'Exchange Traded Fund'
	END

	IF @MARKET = 'IA (Unit Trusts & OEICS)'
	BEGIN
		SET @INVESTMENT_TYPE = 'Fund'
	END

	-- ===============================================================================================================================================================================================================
	-- Get a list of all investments so that we can now set the [SECTOR] correctly
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO #SET_SECTOR_AND_MARKET_DETAILS (To set [SECTOR] and [MARKET])'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		SELECT [ISINCODE] AS [SYMBOL]
		, [INVESTMENT_NAME] -- [PriceName]
		, @INVESTMENT_TYPE AS [INVESTMENT_TYPE]

		, CASE WHEN @MARKET = 'ALC (Exchange Traded Funds)' THEN
			CASE WHEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other') NOT LIKE '%OTHER%' 
			THEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other')
			ELSE '%' + ISNULL([SECTOR], 'SECTOR_NOT_CALCULATED') +'%' END
		  ELSE [SECTOR]
		  END
		AS [SECTOR]

		, @MARKET AS [MARKET]
		INTO #SET_SECTOR_AND_MARKET_DETAILS
		FROM @ACTIVE_MAIN_SET_IN B -- #ACTIVE B
		LEFT JOIN [Alchemy_Data].[MAP].[ETF_SECTOR_TO_ALCHEMY_SECTOR] M ON [B].[SECTOR] = [SECTOR_ETF] -- [AZURE_R7_ALCHEMY_DATA].
		WHERE [B].[INVESTMENT_NAME] LIKE '[%A-Za-z]%' -- PriceName
		AND [B].[ISINCODE] NOT IN ('N/A', '') -- ADDED 20170913
		-- AND [Fund_Counter] = (1) -- 20170630
		ORDER BY 4 DESC
		
		IF @DEBUG = (1) AND (1) = (0)
		SELECT TOP (250) '#SET_SECTOR_AND_MARKET_DETAILS', * FROM #SET_SECTOR_AND_MARKET_DETAILS
		WHERE [SECTOR] NOT LIKE '%SECTOR_NOT_CALCULATED%' AND [SECTOR] LIKE '(Alc)%'
	
		INSERT INTO #SET_SECTOR_AND_MARKET_DETAILS
		SELECT [CITICODE], [INVESTMENT_Name], @INVESTMENT_TYPE AS [INVESTMENT_TYPE] -- [PriceName]

		, CASE WHEN @MARKET = 'ALC (Exchange Traded Funds)' THEN
			CASE WHEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other') NOT LIKE '%OTHER%' 
			THEN [Alchemy_Functions].[dbo].[GetAlcSectorGroupFromSector] ([INVESTMENT_Name], 'Other')
			ELSE '%' + ISNULL([SECTOR], 'SECTOR_NOT_CALCULATED') +'%' END
		  ELSE [SECTOR]
		  END
		AS [SECTOR]

		, @MARKET AS [MARKET]
		FROM @ACTIVE_MAIN_SET_IN B -- #ACTIVE B
		LEFT JOIN [Alchemy_Data].[MAP].[ETF_SECTOR_TO_ALCHEMY_SECTOR] M ON [B].[SECTOR] = [SECTOR_ETF] -- [AZURE_R7_ALCHEMY_DATA].
		WHERE [B].[INVESTMENT_Name] LIKE '[%A-Za-z]%' -- [PriceName]
		AND [B].[CITICODE] NOT IN ('N/A', '') -- ADDED 20170913
		-- AND [Fund_Counter] = (1) -- 20170630
		ORDER BY 4 DESC
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO @InvestmentsToAdd (To set [SECTOR] and [MARKET])'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		INSERT INTO @InvestmentsToAdd ([SYMBOL], [INVESTMENT_NAME], [INVESTMENT_TYPE], [SECTOR], [MARKET]) -- , [LABEL_02], [LABEL_03])
		SELECT [SYMBOL], [INVESTMENT_NAME], [INVESTMENT_TYPE], [SECTOR], [MARKET] -- , [LABEL_02], [LABEL_03]
		FROM #SET_SECTOR_AND_MARKET_DETAILS
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- GET REMOTE DATA
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT * INTO #v_INVESTMENT_ALIAS'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT *
		INTO #v_INVESTMENT_ALIAS -- SELECT TOP (10) * FROM #v_INVESTMENT_SECTOR_REPORT_FILTER
		FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] -- [AZURE_R7_ALCHEMY_DATA].
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'SELECT * INTO #v_INVESTMENT_SECTOR_REPORT_FILTER'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT *
		INTO #v_INVESTMENT_SECTOR_REPORT_FILTER -- SELECT TOP (10) * FROM #v_INVESTMENT_SECTOR_REPORT_FILTER
		FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] -- [AZURE_R7_ALCHEMY_DATA].
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- GET A LIST OF DATA THAT NEEDS TO CHANGE (STEP 1)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DELETE @InvestmentsToAdd (i)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DELETE @InvestmentsToAdd
		FROM @InvestmentsToAdd A
		WHERE EXISTS (SELECT 1 FROM #v_INVESTMENT_SECTOR_REPORT_FILTER B JOIN #v_INVESTMENT_ALIAS C ON [B].[INVESTMENT_ID] = [C].[INVESTMENT_ID]
		WHERE [A].[SYMBOL] = [C].[LABEL] AND [A].[SECTOR] = [B].[SECTOR] AND [A].[MARKET] = [B].[MARKET_NAME])

		SET @I_MSG_2500 = 'DELETED (i):' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- GET A LIST OF DATA THAT NEEDS TO CHANGE (STEP 2)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DELETE @InvestmentsToAdd (ii)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DELETE @InvestmentsToAdd
		FROM @InvestmentsToAdd A
		WHERE [SYMBOL] NOT IN(SELECT [SYMBOL] FROM #v_INVESTMENT_ALIAS B)

		SET @I_MSG_2500 = 'DELETED (ii):' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- GET A LIST OF DATA THAT NEEDS TO CHANGE (STEP 3)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DELETE @InvestmentsToAdd (iii)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DELETE @InvestmentsToAdd
		WHERE [SECTOR] LIKE '%SECTOR_NOT_CALCULATED%'

		SET @I_MSG_2500 = 'DELETED (iii):' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- Summary ....
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1)
	SELECT '@InvestmentsToAdd', * FROM @InvestmentsToAdd

	IF (0) <> (SELECT COUNT(*) FROM @InvestmentsToAdd)
	BEGIN
		SET @I_MSG_2500 = 'HOW MANY ROWS TO CHANGE:' + CONVERT(VARCHAR(10), (SELECT COUNT(*) FROM @InvestmentsToAdd)) + ' rows.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = '[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET]', @i_body = @i_msg_2500
		PRINT @I_MSG_2500
	END

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] - SET [SECTOR] AND [MARKET]:'
	+ CONVERT(VARCHAR(10), (SELECT COUNT(*) FROM @InvestmentsToAdd)) + ' rows.'

	IF (SELECT COUNT(*) FROM @InvestmentsToAdd) > 0
	BEGIN TRY

		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		SET @I_MSG_2500 = 'START - EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] @BUILD_ID = @BUILD_ID -- = @vRE
		, @InvestmentsToAdd = @InvestmentsToAdd
		, @ONLY_CONFIGURE_SECTOR_AND_MARKET = 1
		, @PRINT_ONLY_IF_ERROR = 1
		, @BUILD_TYPE = @BUILD_TYPE

		SET @I_MSG_2500 = 'END - EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]'
			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	DROP TABLE #SET_SECTOR_AND_MARKET_DETAILS
	DROP TABLE #v_INVESTMENT_SECTOR_REPORT_FILTER
	DROP TABLE #v_INVESTMENT_ALIAS

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END








GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF] (@BUILD_ID INT = 0
, @ROWS_IN_BATCH_EXPECTED INT = 5000
, @ADD_PRICE_ROWS INT = 1
, @ADD_MISSING_INVESTMENTS INT = 1
, @CONFIGURE_SECTOR_AND_MARKET INT = 1
, @CONFIGURE_INVESTMENT_NAME INT = 0 -- WIP
, @DEBUG INT = 0
, @BUILD_TYPE CHAR(1) = 'F'
, @CSV_DIRECTORY VARCHAR(250) = 'C:\Users\Alex\OneDrive\' -- 'C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\'
, @CSV_FILENAME VARCHAR(250) = 'TRUSTNET_ETF'
, @CSV_FILE_EXTENSION VARCHAR(25) = 'CSV'
, @SEND_EMAIL INT = 1
) AS
BEGIN

	SET LANGUAGE BRITISH

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_ DATA].
	-- 1.2		20190319 [Alchemy_Stage_Data].[STG].[TRUSTNET_ETF]
	-- 1.3		20190507 Read file from C:\Users\Alex\OneDrive\
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF] @BUILD_ID = 3218, @ROWS_IN_BATCH_EXPECTED = 2500, @ADD_PRICE_ROWS = 1, @DEBUG = 1, @BUILD_TYPE = 'I' 
	/*
	   DECLARE @i INT; SET @i = (1) + (SELECT MAX([BUILD_ID]) FROM [Alchemy_Data].[BLD].[v_MONITOR_BUILD_PROCESS_LATEST_F_or_I])

		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF] @BUILD_ID = @i
		, @ROWS_IN_BATCH_EXPECTED = 100, @BUILD_TYPE = 'I'
		, @ADD_PRICE_ROWS = 0
		, @ADD_MISSING_INVESTMENTS = 0
		, @CONFIGURE_SECTOR_AND_MARKET = 1
		, @CONFIGURE_INVESTMENT_NAME = 0 -- WIP
		, @DEBUG = 1
		-- , @ADD_PRICE_ROWS = 1
		-- , @CONFIGURE_SECTOR_AND_MARKET = 1
		-- , @ADD_MISSING_INVESTMENTS = 1
		-- , @DEBUG = 1
	*/
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)
	DECLARE @ALERT_OVER_X_SECS INT, @STEP_START DATETIME, @MARKET VARCHAR(50), @INVESTMENT_TYPE VARCHAR(50), @SQL NVARCHAR(2500)

	-- DECLARE @InvestmentsToAdd ASInvestmentsToAdd

	SET @ALERT_OVER_X_SECS = (30)
	SET @STEP_START = GETDATE()

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		
	-- ===============================================================================================================================================================================================================
	-- CHECK PARAMETERS
	-- ===============================================================================================================================================================================================================
	IF @ADD_PRICE_ROWS = 0 AND @ADD_MISSING_INVESTMENTS = 0 AND @CONFIGURE_SECTOR_AND_MARKET = 0
	BEGIN
		SET @I_MSG_2500 = 'No work to do .... '
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		PRINT @I_MSG_2500
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- SET VALUES
	-- ===============================================================================================================================================================================================================

	SET @MARKET = 'ALC (Exchange Traded Funds)'
	SET @INVESTMENT_TYPE = '%Exchange Traded Fund%' -- 'Exchange Traded Fund'

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- SET GET DETAILS OF CSV FILE PASSED IN
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1)
	BEGIN
		DECLARE @DIR_CMD VARCHAR(250), @LINE VARCHAR(250)
		CREATE TABLE #CommandShell ( Line VARCHAR(512)) 
 
		EXEC sp_configure 'show advanced options', 1
		RECONFIGURE
		EXEC sp_configure 'xp_cmdshell', 1
		RECONFIGURE

		SET @DIR_CMD = 'dir ' + @CSV_DIRECTORY + @CSV_FILENAME + '.' + @CSV_FILE_EXTENSION
		PRINT @DIR_CMD
		INSERT INTO #CommandShell
		EXEC XP_CMDSHELL @DIR_CMD
		
		-- SELECT * FROM #CommandShell WHERE [Line] LIKE '%201%'

		SET @LINE = (SELECT * FROM #CommandShell WHERE [Line] LIKE '%201%csv%')
		SET @I_MSG_2500 = 'File In (CSV):'+ISNULL(@Line,'')
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
		DROP TABLE #CommandShell
		
		EXEC sp_configure 'xp_cmdshell', 0
		RECONFIGURE
		EXEC sp_configure 'show advanced options', 0
		RECONFIGURE
	END

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_ETF - exists from previous run'
		DROP TABLE ##ACTIVE_RAW_ETF

		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END TRY

	BEGIN CATCH
		SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_ETF - did not exist from previous run'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END CATCH

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- CREATE ##ACTIVE_RAW_ETF
	-- IT IS GLOBAL TEMP AS THIS IS NEEDED FOR sp_executesql
	-- 
	-- sp_executesql is needed for variable CSV name
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE ##ACTIVE_RAW_ETF'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		CREATE TABLE ##ACTIVE_RAW_ETF( -- DROP TABLE ##ACTIVE_RAW_ETF
		[ï»¿FundCode] [nvarchar](255) NULL,
		[FundName] [nvarchar](255) NULL,
		[PriceName] [nvarchar](255) NULL,
		[Bid] [float] NULL,
		[Offer] [float] NULL,
		[Date] [date] NULL,
		[Yield] VARCHAR(250) NULL, -- FLOAT NULL
		[Type] [nvarchar](255) NULL,
		[Currency] [nvarchar](255) NULL,
		[ISINCode] [nvarchar](255) NULL,
		[Citicode] [nvarchar](255) NULL,
		[SEDOL] [nvarchar](255) NULL,
		[FeCrownFundRating] [int] NULL,
		[FeRiskScore] [int] NULL,
		[ReplicationMethod] [nvarchar](255) NULL,
		[OCF] VARCHAR(250) NULL, -- FLOAT NULL
		[Benchmark] [nvarchar](255) NULL,
		[1y] VARCHAR(250) NULL, -- FLOAT NULL
		[3y] VARCHAR(250) NULL, -- FLOAT NULL
		[5y] VARCHAR(250) NULL, -- FLOAT NULL
		[FundType] [nvarchar](255) NULL,
		[Sector] [nvarchar](255) NULL,
		[AssetClass] [nvarchar](255) NULL,
		[Fundsize] [float] NULL,
		[Launch date] VARCHAR(250) NULL, -- [datetime] NULL,
		[fund_counter] [int] NULL,
		[table_counter] [int] NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'LOAD ##ACTIVE_RAW_ETF'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
/*
		BULK INSERT ##ACTIVE_RAW_ETF FROM 'C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\2017Q3_IMPORT_MANY_OLD_TRUSTNET_ETF_FILES\TRUSTNET_ETF_TMP.CSV'
		WITH (DATAFILETYPE = 'char', 
				FIELDTERMINATOR = ',', 
				ROWTERMINATOR = '\n', 
				FIRSTROW = 2) 
*/

		-- FROM ''C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\2017Q3_IMPORT_MANY_OLD_TRUSTNET_ETF_FILES\TRUSTNET_ETF_TMP.CSV''

		SET @SQL = 'BULK INSERT ##ACTIVE_RAW_ETF FROM ''' + @CSV_DIRECTORY + @CSV_FILENAME + '.' + @CSV_FILE_EXTENSION + ''''
		+ 'WITH (DATAFILETYPE = ''char'', 
				FIELDTERMINATOR = '','', 
				ROWTERMINATOR = ''\n'', 
				FIRSTROW = 2)'

		IF @DEBUG = (1)
		PRINT @SQL

	    EXEC sp_executesql @sql

		-- SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to ##ACTIVE_RAW_ETF = ' + CONVERT(VARCHAR(10), (SELECT COUNT(*) FROM ##ACTIVE_RAW_ETF))
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DATA FUDGE ##ACTIVE_RAW_ETF'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		UPDATE ##ACTIVE_RAW_ETF SET [Yield]  = '' WHERE [Yield]  = '-'
		UPDATE ##ACTIVE_RAW_ETF SET [1y]  = '' WHERE [1y]  = '-'
		UPDATE ##ACTIVE_RAW_ETF SET [3y]  = '' WHERE [3y]  = '-'
		UPDATE ##ACTIVE_RAW_ETF SET [5y]  = '' WHERE [5y]  = '-'
		UPDATE ##ACTIVE_RAW_ETF SET [OCF]  = '' WHERE [OCF]  = '-'
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH
	
	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- Look for BAD DATES coming in:
	-- e.g. B.DATE > GETDATE()
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'Check dates coming in from CSV: Dates greater than today'
	IF EXISTS (SELECT 1 FROM ##ACTIVE_RAW_ETF B WHERE [B].[DATE] > GETDATE())
	BEGIN
		SELECT @I_MSG_2500 = @I_MSG_2500 + ':' + CONVERT(VARCHAR, (SELECT COUNT(*) FROM ##ACTIVE_RAW_ETF B WHERE [B].[DATE] > GETDATE())) + ' row(s)'
		PRINT @I_MSG_2500
		-- EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- RETURN (255)
	END

	SET @I_MSG_2500 = 'Check dates coming in from CSV: No. months vs No. days'
	IF (SELECT COUNT(DISTINCT DATEPART(MM, [B].[DATE])) FROM ##ACTIVE_RAW_ETF B) > (SELECT COUNT(DISTINCT DATEPART(DD, [B].[DATE])) FROM ##ACTIVE_RAW_ETF B)
	BEGIN
		PRINT @@LANGUAGE
		SELECT DISTINCT [B].[DATE], CONVERT(VARCHAR(11), [B].[DATE], 113) FROM ##ACTIVE_RAW_ETF B
		SELECT 'MM', COUNT(DISTINCT DATEPART(MM, [B].[DATE])) FROM ##ACTIVE_RAW_ETF B
		SELECT 'DD', COUNT(DISTINCT DATEPART(DD, [B].[DATE])) FROM ##ACTIVE_RAW_ETF B
		PRINT @I_MSG_2500
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE_MAIN table'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT REPLACE(REPLACE([B].[ï»¿FundCode], 'fundCode=',''),'&univ=E','') AS [TRUSTNET_UNIQUE]
		, [B].[ï»¿FundCode] AS [FundCode]
		, (SELECT TOP (1) [INVESTMENT_ID]
			FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A -- [AZURE_R7_ALCHEMY_DATA].
			WHERE [A].[LABEL] = [B].[ISINCode] OR [A].[LABEL] = [B].[SEDOL] OR [A].[LABEL] = [B].[CITICODE]) AS [EST_INVESTMENT_ID]

		, (SELECT COUNT(DISTINCT [INVESTMENT_ID])
			FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A -- [AZURE_R7_ALCHEMY_DATA].
			WHERE [A].[LABEL] = [B].[ISINCode] OR [A].[LABEL] = [B].[SEDOL] OR [A].[LABEL] = [B].[CITICODE]) AS [EST_INVESTMENT_ID_COUNT]
	
		, [B].[FundName]
		, [B].[PriceName]
		, [B].[Bid]
		, [B].[Offer]
		, [B].[Currency]
		, CONVERT(DATE, [B].[Date]) AS [ClosureDate]
		, ISNULL([B].[ISINCode],'') AS [ISINCode]
		, ISNULL([B].[Citicode],'') AS [CitiCode]
		, ISNULL([B].[SEDOL],'') AS [SEDOL]
		, [Sector]
		, [B].[AssetClass]
		, [B].[FundSize]
		, [B].[Launch date] AS [LaunchDate]
		, CONVERT(FLOAT, [B].[Yield]) AS [Yield]
		, [B].[Type]
		, [B].[FeRiskScore] AS [FE Risk Score]
		, [B].[FeCrownFundRating]
		, [B].[ReplicationMethod]
		, CONVERT(FLOAT, [B].[1y]) AS [1y]
		, CONVERT(FLOAT, [B].[3y]) AS [3y]
		, CONVERT(FLOAT, [B].[5y]) AS [5y]
		, CONVERT(FLOAT, [B].[OCF]) AS [OngoingChargeFigure]
		, [B].[Fund_Counter]
		, [B].[Table_Counter]
	
		INTO #ACTIVE_MAIN
		FROM ##ACTIVE_RAW_ETF B
		WHERE [B].[Date] IS NOT NULL	-- 20180306

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE_MAIN = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_ETF'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DROP TABLE ##ACTIVE_RAW_ETF
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #DUPLICATES'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT * INTO #TRUSTNET_ETF
		FROM #ACTIVE_MAIN
	
		SELECT [ClosureDate], [ISINCode], [CitiCode]
		INTO #DUPLICATES
		FROM #TRUSTNET_ETF
		WHERE [ClosureDate] IS NOT NULL -- 20170306
		GROUP BY [ClosureDate], [ISINCode], [CitiCode]
		HAVING COUNT(*) > 1
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE_MAIN_FINAL_INSERT'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT DISTINCT [TRUSTNET_UNIQUE], [FundCode], [FundName], [PriceName], [Bid], [Offer], [Currency]
		-- , [YearHigh], [YearLow] -- REMOVED 20170913 (WEB SITE CHANGED AND PROVIDED DIFF COLUMNS)
		, [ClosureDate]
		-- , [EPICCode] -- REMOVED 20170913 (WEB SITE CHANGED AND PROVIDED DIFF COLUMNS)
		, [ISINCode], [CitiCode], [SEDOL]
		-- , [Indice] -- REMOVED 20170913 (WEB SITE CHANGED AND PROVIDED DIFF COLUMNS)
		, [Sector]
		, [AssetClass], [FundSize], [LaunchDate]
		-- , [DividendsPA] -- REMOVED 20170913 (WEB SITE CHANGED AND PROVIDED DIFF COLUMNS)
		, [Fund_Counter], [Table_Counter]
		INTO #ACTIVE_MAIN_FINAL_INSERT
		FROM #TRUSTNET_ETF A
		WHERE NOT EXISTS (SELECT (1) FROM #DUPLICATES B WHERE [A].[ClosureDate] = [B].[ClosureDate]
							AND [A].[ISINCode] = [B].[ISINCode] AND [A].[CitiCode] = [B].[CitiCode])
		OR 	(EXISTS (SELECT (1) FROM #DUPLICATES B WHERE [A].[ClosureDate] = [B].[ClosureDate]
							AND [A].[ISINCode] = [B].[ISINCode] AND [A].[CitiCode] = [B].[CitiCode]) AND [Fund_Counter] = (1))
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- We override the sector passes in (so many of them) and generate our own .....
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO @ACTIVE_MAIN_SET_IN'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DECLARE @ACTIVE_MAIN_SET_IN [dbo].[InvestmentsToAdd_With_3_Tickers]

		INSERT INTO @ACTIVE_MAIN_SET_IN ([INVESTMENT_NAME], [INVESTMENT_TYPE], [SECTOR]
		, [MARKET] ,[ISINCODE], [CITICODE], [SEDOL])
		SELECT [PriceName], @INVESTMENT_TYPE AS [INVESTMENT_TYPE]
		, [SECTOR]
		, @MARKET AS [MARKET]
		, [ISINCODE], [CITICODE], [SEDOL]
		FROM #ACTIVE_MAIN A
		WHERE EXISTS (SELECT (1) FROM #ACTIVE_MAIN_FINAL_INSERT B WHERE [A].[SECTOR] = [B].[SECTOR] AND [A].[PriceName] = [B].[PriceName]) -- 20180207
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- 
	-- ===============================================================================================================================================================================================================

	EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @ADD_PRICE_ROWS = (1)
	BEGIN
		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================
		IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
			DROP TABLE #SymbolsToProcess

		BEGIN TRY
			CREATE TABLE #SymbolsToProcess ([t_ISINCODE] VARCHAR(250), [t_CITICODE] VARCHAR(250), [t_SEDOL] VARCHAR(250), [t_ClosureDate] DATE NULL)
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = 'Error CREATE TABLE #SymbolsToProcess'
			RETURN (255)
		END CATCH

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		SET @I_MSG_2500 = 'INSERT INTO #SymbolsToProcess (TRUSTNET_ETF)'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			SET @sqlCommand = 'INSERT INTO #SymbolsToProcess ' +@sqlCommand
			IF @BUILD_ID = 0 PRINT @sqlCommand

			INSERT INTO #SymbolsToProcess
			SELECT DISTINCT [ISINCODE], [CITICODE], [SEDOL], CONVERT(DATE, [B].[ClosureDate]) -- [Date])
			FROM #ACTIVE_MAIN B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH
	
		SET @I_MSG_2500 = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		-- ===============================================================================================================================================================================================================
		--
		-- ===============================================================================================================================================================================================================

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		IF @SEND_EMAIL = (1)
		BEGIN
			DECLARE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT CONVERT(VARCHAR(11), [t_ClosureDate], 113) + ':' + CONVERT(VARCHAR, COUNT(*))
			FROM #SymbolsToProcess GROUP BY CONVERT(VARCHAR(11), [t_ClosureDate], 113) -- ORDER BY 1 DESC
			ORDER BY CONVERT(DATE, LEFT(CONVERT(VARCHAR(11), [t_ClosureDate], 113)+ ':' + CONVERT(VARCHAR, COUNT(*)),11)) DESC
			
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] 'DATA Coming in for ETF', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END

		IF @DEBUG = (1)
		SELECT * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		ORDER BY CONVERT(DATE, LEFT([MESSAGE_CONTENT], 11)) DESC

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	
		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================
	
		SET @I_MSG_2500 = 'DELETE [STG].[TRUSTNET_ETF]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			DELETE [Alchemy_Stage_Data].[STG].[TRUSTNET_ETF] -- [AZURE_R7_ALCHEMY_DATA].
			FROM #SymbolsToProcess A
			WHERE [A].[t_ClosureDate] = [ClosureDate]
			AND ([A].[t_ISINCODE] = [ISINCODE] OR [A].[t_CITICODE] = [CITICODE] OR [A].[t_SEDOL] = [SEDOL])

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS DELETED (TRUSTNET_ETF) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		IF @DEBUG = (1)
			SELECT 'C',* FROM #ACTIVE_MAIN_FINAL_INSERT
			WHERE ClosureDate IS NULL

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[TRUSTNET_ETF]' -- [AZURE_R7_ALCHEMY_DATA].
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			INSERT INTO [Alchemy_Stage_Data].[STG].[TRUSTNET_ETF] ([TRUSTNET_UNIQUE], [FundCode] -- [AZURE_R7_ALCHEMY_DATA].
			, [FundName], [PriceName], [Bid], [Offer], [Currency]
			-- , [YearHigh], [YearLow] -- REMOVED 20170913 (WEB SITE CHANGED AND PROVIDED DIFF COLUMNS)
			, [ClosureDate]
			-- , [EPICCode] -- REMOVED 20170913 (WEB SITE CHANGED AND PROVIDED DIFF COLUMNS)
			, [ISINCode], [CitiCode], [SEDOL]
			-- , [Indice] -- REMOVED 20170913 (WEB SITE CHANGED AND PROVIDED DIFF COLUMNS)
			, [Sector], [AssetClass], [FundSize], [LaunchDate]
			-- , [DividendsPA] -- REMOVED 20170913 (WEB SITE CHANGED AND PROVIDED DIFF COLUMNS)
			, [Fund_Counter], [Table_Counter])
	
			SELECT * FROM #ACTIVE_MAIN_FINAL_INSERT

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS INSERTED (TRUSTNET_ETF)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		DROP TABLE #ACTIVE_MAIN

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
		BEGIN
			DECLARE @tSUBJ VARCHAR(250)
			SET @tSUBJ = 'Data loaded low? (TRUSTNET_ETF)'
			SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
		END

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		-- ===============================================================================================================================================================================================================
		-- TIDY UP
		-- ===============================================================================================================================================================================================================

		DROP TABLE #SymbolsToProcess
		DROP TABLE #TRUSTNET_ETF
		DROP TABLE #DUPLICATES

		-- ===============================================================================================================================================================================================================
		--
		-- ===============================================================================================================================================================================================================
		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	END -- @ADD_PRICE_ROWS 
	ELSE
	BEGIN
		SET @I_MSG_2500 = '@ADD_PRICE_ROWS IS ZERO'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END

	-- ===============================================================================================================================================================================================================
	-- @ACTIVE_MAIN_SET_IN
	-- ===============================================================================================================================================================================================================

	IF @ADD_MISSING_INVESTMENTS = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ADD_MISSING_INVESTMENTS]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ADD_MISSING_INVESTMENTS]
			@BUILD_ID = @BUILD_ID
			, @ACTIVE_MAIN_SET_IN = @ACTIVE_MAIN_SET_IN
			, @MARKET = @MARKET
			, @DEBUG = @DEBUG
			, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH
	
		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS
		, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END -- 20170918
	ELSE
	BEGIN
		SET @I_MSG_2500 = '@ADD_MISSING_INVESTMENTS IS ZERO'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END

	-- ===============================================================================================================================================================================================================
	-- WE GET MANY DISTINCT SECTORS THOURGH
	-- TO TRY ANDMAKE MORE SENSE OF IT IN REPORTS WE HAVE EMALGUMATED SECTORS USING [Get AlcSectorGroupFromSector]
	-- ===============================================================================================================================================================================================================

	IF @CONFIGURE_SECTOR_AND_MARKET = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET]
			@BUILD_ID = @BUILD_ID
			, @ACTIVE_MAIN_SET_IN = @ACTIVE_MAIN_SET_IN
			, @MARKET = @MARKET
			, @DEBUG = @DEBUG
			, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH
	
		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500
		, @BUILD_TYPE = @BUILD_TYPE
	END -- 20170918

	-- ===============================================================================================================================================================================================================
	-- Get a list of all investments so that we can now set the [NAME] correctly
	-- ===============================================================================================================================================================================================================

	IF @CONFIGURE_INVESTMENT_NAME = (1)
	BEGIN 
		SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_INVESTMENT_NAME]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_INVESTMENT_NAME]
			@BUILD_ID = @BUILD_ID -- = @vRE
			, @ACTIVE_MAIN_SET_IN = @ACTIVE_MAIN_SET_IN
			, @DEBUG = @DEBUG
			, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH
	
		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE_MAIN_FINAL_INSERT

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END

GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] (@BUILD_ID INT = 0 
, @ROWS_IN_BATCH_EXPECTED INT = 100
, @BUILD_TYPE CHAR(1) = 'F'
, @ADD_PRICE_ROWS INT = 1
, @ADD_MISSING_INVESTMENTS INT = 1
, @CONFIGURE_SECTOR_AND_MARKET INT = 1
, @CONFIGURE_INVESTMENT_NAME INT = 0 -- WIP
, @DEBUG INT = 0
, @CSV_DIRECTORY VARCHAR(250) = 'C:\Users\Alex\OneDrive\' -- 'C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\'
, @CSV_FILENAME VARCHAR(250) = 'TRUSTNET_OEIC'
, @CSV_FILE_EXTENSION VARCHAR(25) = 'CSV'
, @SEND_EMAIL INT = 1
, @DROP_ACTIVE_RAW_OEIC INT = 1
) AS
BEGIN

	SET LANGUAGE BRITISH

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20170919 Added @ADD_PRICE_ROWS, @ADD_MISSING_INVESTMENTS and @CONFIGURE_SECTOR_AND_MARKET to be consistent with ETF usp
	-- 1.2		20190507 Read file from C:\Users\Alex\OneDrive\
	-- 1.3		20190812 Move TRUSTNET OEIC to STG
	-- 1.4		20191121 Added FundSize

	/*
		DECLARE @i INT; SET @i = (1) + (SELECT MAX([BUILD_ID]) FROM [Alchemy_Data].[BLD].[v_MONITOR_BUILD_PROCESS])

		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] @BUILD_ID = @i
		, @ROWS_IN_BATCH_EXPECTED = 100, @BUILD_TYPE = 'F', @ADD_MISSING_INVESTMENTS = 0

		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] @BUILD_ID = @i
		, @ROWS_IN_BATCH_EXPECTED = 100, @BUILD_TYPE = 'I'
		, @ADD_PRICE_ROWS = 0
		, @ADD_MISSING_INVESTMENTS = 0
		, @CONFIGURE_SECTOR_AND_MARKET = 1
		, @CONFIGURE_INVESTMENT_NAME = 0 -- WIP
		, @DEBUG = 1
		-- , @CSV_FILENAME = 'TRUSTNET_OEIC_TMP'
		-- , @CSV_DIRECTORY = 'C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\2017Q3_IMPORT_MANY_OLD_TRUSTNET_OEIC_FILES\'
	*/
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] @DROP_ACTIVE_RAW_OEIC = 0
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	-- DECLARE @sqlCommand VARCHAR(2500), 
	DECLARE @PARENT_USP VARCHAR(250), @RETURN_VALUE INT
	DECLARE @ALERT_OVER_X_SECS INT, @STEP_START DATETIME, @MARKET VARCHAR(50), @INVESTMENT_TYPE VARCHAR(50), @SQL NVARCHAR(2500)

	-- DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	SET @ALERT_OVER_X_SECS = (30)
	SET @STEP_START = GETDATE()

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		
	-- ===============================================================================================================================================================================================================
	-- CHECK PARAMETERS
	-- ===============================================================================================================================================================================================================

	IF @ADD_PRICE_ROWS = (0) AND @ADD_MISSING_INVESTMENTS = (0) AND @CONFIGURE_SECTOR_AND_MARKET = (0)
	BEGIN
		SET @I_MSG_2500 = 'No work to do .... '
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		PRINT @I_MSG_2500
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- SET VALUES
	-- ===============================================================================================================================================================================================================

	SET @MARKET = 'IA (Unit Trusts & OEICS)' -- 'ALC (Exchange Traded Funds)'
	SET @INVESTMENT_TYPE = 'Fund' -- 'Exchange Traded Fund'

	-- ===============================================================================================================================================================================================================
	-- SET GET DETAILS OF CSV FILE PASSED IN
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1)
	BEGIN
		DECLARE @DIR_CMD VARCHAR(250), @LINE VARCHAR(250)
		CREATE TABLE #CommandShell ( Line VARCHAR(512)) 
 
		EXEC sp_configure 'show advanced options', 1
		RECONFIGURE
		EXEC sp_configure 'xp_cmdshell', 1
		RECONFIGURE

		SET @DIR_CMD = 'dir ' + @CSV_DIRECTORY + @CSV_FILENAME + '.' + @CSV_FILE_EXTENSION
		PRINT @DIR_CMD
		INSERT INTO #CommandShell
		EXEC XP_CMDSHELL @DIR_CMD
		
		-- SELECT * FROM #CommandShell WHERE [Line] LIKE '%201%'

		SET @LINE = (SELECT * FROM #CommandShell WHERE [Line] LIKE '%201%csv%')
		SET @I_MSG_2500 = 'File In (CSV):'+ISNULL(@Line,'')
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
		DROP TABLE #CommandShell
		
		EXEC sp_configure 'xp_cmdshell', 0
		RECONFIGURE
		EXEC sp_configure 'show advanced options', 0
		RECONFIGURE
	END

	-- ===============================================================================================================================================================================================================
	-- GET ALIAS DATA
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #INVESTMENT_ALIAS'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT *
		INTO #INVESTMENT_ALIAS -- select top 1 *
		FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] -- 20180626 [AZURE_R7_ALCHEMY_DATA].

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ADD INDEXES
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ADD INDEXES (#INVESTMENT_ALIAS) '
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		CREATE INDEX IDX_001 ON #INVESTMENT_ALIAS ([LABEL])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_OEIC - exists from previous run'
		DROP TABLE ##ACTIVE_RAW_OEIC

		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END TRY

	BEGIN CATCH
		SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_OEIC - did not exist from previous run'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- CREATE ##ACTIVE_RAW_OEIC
	-- IT IS GLOBAL TEMP AS THIS IS NEEDED FOR sp_executesql
	-- 
	-- sp_executesql is needed for variable CSV name
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE ##ACTIVE_RAW_OEIC'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		CREATE TABLE ##ACTIVE_RAW_OEIC(
		[ï»¿FundCode] [nvarchar](255) NULL,
		[FundName] [nvarchar](255) NULL,
		[PriceName] [nvarchar](255) NULL,
		[Bid] [float] NULL,
		[Offer] [float] NULL,
		[Date] [datetime] NULL,
		[Yield] VARCHAR(250) NULL, -- FLOAT NULL
		[Type] [nvarchar](255) NULL,
		[Currency] [nvarchar](255) NULL,
		[ISINCode] [nvarchar](255) NULL,
		[Citicode] [nvarchar](255) NULL,
		[SEDOL] [nvarchar](255) NULL,
		[FeCrownFundRating] [int] NULL,
		[FeRiskScore] [int] NULL,
		[1y] VARCHAR(250) NULL, -- FLOAT NULL
		[3y] VARCHAR(250) NULL, -- FLOAT NULL
		[5y] VARCHAR(250) NULL, -- FLOAT NULL
		[FundType] [nvarchar](255) NULL,
		[Sector] [nvarchar](255) NULL,
		[AssetClass] [nvarchar](255) NULL,
		[Fundsize] [float] NULL,
		[Launch date] [datetime] NULL,
		[fund_counter] [int] NULL,
		[table_counter] [int] NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'LOAD ##ACTIVE_RAW_OEIC'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SET @SQL = 'SELECT * INTO ##ACTIVE_RAW_OEIC
		FROM OPEN DATA SOURCE(''Microsoft.ACE.OLEDB.12.0'', ''Text;Database='+@CSV_DIRECTORY+';HDR=YES'')...['+ @CSV_FILENAME + '#' + @CSV_FILE_EXTENSION + '] B
		WHERE [Date] IS NOT NULL
		AND [CURRENCY] IN (''GBP'',''GBX'',''p'')'

		SET @SQL = 'BULK INSERT ##ACTIVE_RAW_OEIC FROM ''' + @CSV_DIRECTORY + @CSV_FILENAME + '.' + @CSV_FILE_EXTENSION + ''''
		+ 'WITH (DATAFILETYPE = ''char'', 
				FIELDTERMINATOR = '','', 
				ROWTERMINATOR = ''\n'', 
				FIRSTROW = 2)'

		IF @DEBUG = (1)
		PRINT @SQL

/*
		BULK INSERT ##ACTIVE_RAW_OEIC FROM 'C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\TRUSTNET_OEIC.CSV'WITH (DATAFILETYPE = 'char', 
				FIELDTERMINATOR = ',', 
				ROWTERMINATOR = '\n', 
				FIRSTROW = 2)
*/

	  EXEC sp_executesql @sql

		-- SELECT TOP (10) * FROM ##ACTIVE_RAW_OEIC

/*		20171013
		SELECT *
		INTO ##ACTIVE_RAW_OEIC
		FROM OPEN DATA SOURCE('Microsoft.ACE.OLEDB.12.0', 'Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\;HDR=YES')...[TRUSTNET_OEIC#csv] B
		WHERE [Date] IS NOT NULL
		AND [CURRENCY] IN ('GBP','GBX','p')
*/
		-- SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to ##ACTIVE_RAW_OEIC = ' + CONVERT(VARCHAR(10), (SELECT COUNT(*) FROM ##ACTIVE_RAW_OEIC))
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DATA FUDGE ##ACTIVE_RAW_OEIC'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		UPDATE ##ACTIVE_RAW_OEIC SET [Yield] = '' WHERE [Yield] = '-'
		UPDATE ##ACTIVE_RAW_OEIC SET [1y] = '' WHERE [1y] = '-'
		UPDATE ##ACTIVE_RAW_OEIC SET [3y] = '' WHERE [3y] = '-'
		UPDATE ##ACTIVE_RAW_OEIC SET [5y] = '' WHERE [5y] = '-'
		-- UPDATE ##ACTIVE_RAW_OEIC SET [OCF] = '' WHERE [OCF] = '-'
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH
	
	-- ===============================================================================================================================================================================================================
	-- Look for BAD DATES coming in:
	-- e.g. B.DATE > GETDATE()
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'Check dates coming in from CSV: Dates greater than today'
	IF EXISTS (SELECT 1 FROM ##ACTIVE_RAW_OEIC B WHERE [B].[DATE] > GETDATE())
	BEGIN
		SELECT @I_MSG_2500 = @I_MSG_2500 + ':' + CONVERT(VARCHAR, (SELECT COUNT(*) FROM ##ACTIVE_RAW_OEIC B WHERE [B].[DATE] > GETDATE())) + ' row(s)'
		PRINT @I_MSG_2500
		-- EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- RETURN (255)
	END

	SET @I_MSG_2500 = 'Check dates coming in from CSV: No. months vs No. days'
	IF (SELECT COUNT(DISTINCT DATEPART(MM, [B].[DATE])) FROM ##ACTIVE_RAW_OEIC B ) > (SELECT COUNT(DISTINCT DATEPART(DD, [B].[DATE])) FROM ##ACTIVE_RAW_OEIC B )
	BEGIN
		SELECT DISTINCT [B].[DATE], CONVERT(VARCHAR(11), [B].[DATE], 113) FROM ##ACTIVE_RAW_OEIC B 
		SELECT 'MM', COUNT(DISTINCT DATEPART(MM, [B].[DATE])) FROM ##ACTIVE_RAW_OEIC B 
		SELECT 'DD', COUNT(DISTINCT DATEPART(DD, [B].[DATE])) FROM ##ACTIVE_RAW_OEIC B 
		PRINT @I_MSG_2500
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END

	-- ===============================================================================================================================================================================================================
	-- CREATE #ACTIVE_MAIN_PREP (#ACTIVE_MAIN has a WHERE clause on it = f(csv) i.e. MIN
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE_MAIN_PREP table from OPEN DATASOURCE (NO LONGER VIEW) TRUSTNET_OEIC'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT DISTINCT REPLACE(REPLACE([B].[ï»¿FundCode], 'fundCode=',''),'&univ=E','') AS [TRUSTNET_UNIQUE]
		, CONVERT(INT, (0)) AS [EST_INVESTMENT_ID]			-- Calculated later .. it is too slow in here (due to OR)
		, CONVERT(INT, (0)) AS [EST_INVESTMENT_ID_COUNT]	-- Calculated later .. it is too slow in here (due to OR)
		, [B].[ï»¿FundCode] AS [FundCode]
		, [B].[FundName]
		, [B].[PriceName]
		, [B].[FeRiskScore] AS [FE Risk Score]
		, [B].[FeCrownFundRating] AS [Fe Crown Fund Rating]
		, CONVERT(FLOAT, [B].[1y]) AS [1y]
		, CONVERT(FLOAT, [B].[3y]) AS [3y]
		, CONVERT(FLOAT, [B].[5y]) AS [5y]
		, [B].[fund_counter]
		, CONVERT(INT, (0)) AS [MIN_fund_Counter]			-- Calculated later .. it is too slow in here
		, [B].[table_counter]
		, [B].[FundType] AS [Unit Type]
		, [B].[Type] AS [Type]
		, [B].[Currency]
		, [B].[Bid]
		, [B].[Offer]
		, CONVERT(DATE, [B].[Date])	AS [ClosureDate]
		, CONVERT(FLOAT, [B].[Yield]) AS [Yield]
		, [B].[Citicode]
		, [B].[SEDOL]
		, [B].[ISINCode]
		, [B].[AssetClass] AS [Asset Class]
		, [B].[Sector]
		, [B].[FundSize]
		INTO #ACTIVE_MAIN_PREP
		FROM ##ACTIVE_RAW_OEIC B 

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE_MAIN_PREP = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_OEIC'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DROP TABLE ##ACTIVE_RAW_OEIC
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ADD INDEXES
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ADD INDEXES (#ACTIVE_MAIN_PREP) '
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		CREATE INDEX IDX_001 ON #ACTIVE_MAIN_PREP ([ISINCode])
		CREATE INDEX IDX_002 ON #ACTIVE_MAIN_PREP ([SEDOL])
		CREATE INDEX IDX_003 ON #ACTIVE_MAIN_PREP ([CITICODE])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- UPDATE EST_INVESTMENT_ID
	-- SPLIT INTO 3 AS "OR" IS TOO SLOW 20170921
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'UPDATE #ACTIVE_MAIN_PREP (UPDATE EST_INVESTMENT_ID)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		UPDATE #ACTIVE_MAIN_PREP
		SET [EST_INVESTMENT_ID] = [INVESTMENT_ID]
		FROM #ACTIVE_MAIN_PREP B , #INVESTMENT_ALIAS A
		WHERE [A].[LABEL] = [B].[ISINCode]
		AND ISNULL([EST_INVESTMENT_ID], 0) = 0

		SELECT @v_ROWCOUNT = @@rowcount

		UPDATE #ACTIVE_MAIN_PREP
		SET [EST_INVESTMENT_ID] = [INVESTMENT_ID]
		FROM #ACTIVE_MAIN_PREP B , #INVESTMENT_ALIAS A
		WHERE [A].[LABEL] = [B].[SEDOL]
		AND ISNULL([EST_INVESTMENT_ID], 0) = 0

		SELECT @v_ROWCOUNT = @@rowcount + @v_ROWCOUNT

		UPDATE #ACTIVE_MAIN_PREP
		SET [EST_INVESTMENT_ID] = [INVESTMENT_ID]
		FROM #ACTIVE_MAIN_PREP B , #INVESTMENT_ALIAS A
		WHERE [A].[LABEL] = [B].[CITICODE]
		AND ISNULL([EST_INVESTMENT_ID], 0) = 0

		SELECT @v_ROWCOUNT = @@rowcount + @v_ROWCOUNT
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS UPDATED to #ACTIVE_MAIN_PREP [EST_INVESTMENT_ID] = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- UPDATE MIN_COUNTER
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'UPDATE #ACTIVE_MAIN_PREP (UPDATE MIN_COUNTER)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		UPDATE #ACTIVE_MAIN_PREP
		SET [EST_INVESTMENT_ID_COUNT] = (SELECT COUNT(DISTINCT [A].[INVESTMENT_ID]) FROM #INVESTMENT_ALIAS A
											WHERE [A].[LABEL] = [B].[ISINCode] OR [A].[LABEL] = [B].[CITICODE] OR [A].[LABEL] = [B].[SEDOL])
		FROM #ACTIVE_MAIN_PREP B 

		SELECT @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS UPDATED to #ACTIVE_MAIN_PREP [EST_INVESTMENT_ID_COUNT] = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- Finally build a data set to INSERT
	-- CREATE #ACTIVE_MAIN
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE_MAIN table from #ACTIVE_MAIN_PREP' -- OPEN DATASOURCE (VIEW) TRUSTNET_OEIC'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT *
		INTO #ACTIVE_MAIN
		FROM #ACTIVE_MAIN_PREP
		WHERE [fund_Counter] = [MIN_fund_Counter]
		OR ISNULL([EST_INVESTMENT_ID],0) <> (0) -- 20170811 FAILED TO PICK UP "OLD DATA" e.g. '7IM AAP ADVENTUROUS D ACC'
		-- WHAT HAPPENS IF WE REMOVE THIS ... too much data ?

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE_MAIN = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #DUPLICATES'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT * INTO #TRUSTNET_OEIC
		FROM #ACTIVE_MAIN
	
		SELECT [ClosureDate], [ISINCode], [CitiCode]
		INTO #DUPLICATES
		FROM #TRUSTNET_OEIC
		GROUP BY [ClosureDate], [ISINCode], [CitiCode]
		HAVING COUNT(*) > 1
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH
		
	DROP TABLE #TRUSTNET_OEIC

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE_MAIN_FINAL_INSERT'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
		SELECT DISTINCT [TRUSTNET_UNIQUE]
		, [FundCode], [FundName], [PriceName] -- , [Group] -- REMOVED 20170913 -- , [Focus] -- REMOVED 20170913
		, [FE Risk Score], [fund_counter], [table_counter] -- , [ShareClass] -- REMOVED 20170913
		, [Unit Type], [Currency], [Bid], [Offer], [ClosureDate], [Yield]
		, [Citicode], [SEDOL], [ISINCode] -- , [Region] -- REMOVED 20170913
		, [Asset Class] -- , [Investment Focus] -- REMOVED 20170913
		, [Sector]
		, [Fe Crown Fund Rating] -- Added 20190802
		, [FundSize]

		INTO #ACTIVE_MAIN_FINAL_INSERT
		FROM #ACTIVE_MAIN A
		WHERE NOT EXISTS (SELECT (1) FROM #DUPLICATES B WHERE [A].[ClosureDate] = [B].[ClosureDate]
							AND [A].[ISINCode] = [B].[ISINCode] AND [A].[CitiCode] = [B].[CitiCode]) -- 20171011
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	DROP TABLE #DUPLICATES

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO @ACTIVE_MAIN_SET_IN'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DECLARE @ACTIVE_MAIN_SET_IN [dbo].[InvestmentsToAdd_With_3_Tickers]

		INSERT INTO @ACTIVE_MAIN_SET_IN ([INVESTMENT_NAME], [INVESTMENT_TYPE], [SECTOR]
		, [MARKET] ,[ISINCODE], [CITICODE], [SEDOL])
		SELECT [PriceName]
		, @INVESTMENT_TYPE AS [INVESTMENT_TYPE]
		, [SECTOR]
		, @MARKET AS [MARKET]
		, [ISINCODE], [CITICODE], [SEDOL]
		FROM #ACTIVE_MAIN A
		WHERE EXISTS (SELECT (1) FROM #ACTIVE_MAIN_FINAL_INSERT B WHERE [A].[SECTOR] = [B].[SECTOR] AND [A].[PriceName] = [B].[PriceName]) -- 20180207
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	IF @ADD_PRICE_ROWS = (1)
	BEGIN
		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		BEGIN TRY
			CREATE TABLE #SymbolsToProcess ([t_ISINCode] VARCHAR(250), [t_CITICODE] VARCHAR(250), [t_SEDOL] VARCHAR(250), [t_ClosureDate] DATE NULL)
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = 'Error CREATE TABLE #SymbolsToProcess'
			RETURN (255)
		END CATCH
	
		SET @I_MSG_2500 = 'INSERT INTO #SymbolsToProcess (TRUSTNET_OEIC)'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			INSERT INTO #SymbolsToProcess ([t_ISINCode], [t_CITICODE], [t_SEDOL], [t_CLosureDate])
			SELECT DISTINCT [ISINCode], [CITICODE], [SEDOL], CONVERT(DATE, [B].[ClosureDate])
			FROM #ACTIVE_MAIN B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			IF @I_MSG_2500 IS NULL SET @I_MSG_2500 = 'NULL MESSAGE: '+ISNULL(@PARENT_USP,'UNKNOWN USP(1)')
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		IF @SEND_EMAIL = (1)
		BEGIN
			DECLARE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT CONVERT(VARCHAR(11), [t_ClosureDate], 113)+ ':' + CONVERT(VARCHAR, COUNT(*))
			FROM #SymbolsToProcess
			GROUP BY CONVERT(VARCHAR(11), [t_ClosureDate], 113) -- ORDER BY 1 DESC
			-- ORDER BY CONVERT(DATE, LEFT([MESSAGE_CONTENT], 11)) DESC
			ORDER BY CONVERT(DATE, LEFT(CONVERT(VARCHAR(11), [t_ClosureDate], 113)+ ':' + CONVERT(VARCHAR, COUNT(*)),11)) DESC
			
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] 'DATA Coming in for OEIC', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY -- 20180813 (1 email!!)
		END

		IF @DEBUG = (1)
		SELECT * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		ORDER BY CONVERT(DATE, LEFT([MESSAGE_CONTENT], 11)) DESC

		-- ===============================================================================================================================================================================================================
		-- TRUSTNET_OEIC - match on SEDOL (IF DATA HAS BEEN LOADED ALREADY, REMOVE IT AS DATA MAY HAVE CHANGED)
		-- ADDED 20170921
		-- ===============================================================================================================================================================================================================
	
		-- SET @I_MSG_2500 = 'DELETE [STG].[TRUSTNET_OEIC] - match on SEDOL'
		SET @I_MSG_2500 = 'DELETE [STG].[TRUSTNET_OEIC] - match on SEDOL\ISIN\CITICODE'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			DELETE [Alchemy_Stage_Data].[STG].[TRUSTNET_OEIC] -- 20180626 [AZURE_R7_ALCHEMY_DATA].
			FROM #SymbolsToProcess A
			, [Alchemy_Stage_Data].[STG].[TRUSTNET_OEIC] B -- 20180626 [AZURE_R7_ALCHEMY_DATA].
			WHERE [A].[t_ClosureDate] = [B].[ClosureDate]
			AND ([A].[t_SEDOL] = [B].[SEDOL] OR [A].[t_ISINCode] = [B].[ISIN] OR [A].[t_CITICODE] = [B].[CITICODE])

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			IF @I_MSG_2500 IS NULL SET @I_MSG_2500 = 'NULL MESSAGE: '+ISNULL(@PARENT_USP,'UNKNOWN USP(2)')
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS DELETED (TRUSTNET_OEIC) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		IF @v_ERR <> (0)
		BEGIN
			SET @I_MSG_2500 = 'Error had occured [TRUSTNET_OEIC]' + ISNULL(CONVERT(VARCHAR(10),@v_ERR),'')
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
			RETURN (255)
		END

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		SET @I_MSG_2500 = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Stage_Data].[STG].[TRUSTNET_OEIC]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
		BEGIN TRY
			INSERT INTO [Alchemy_Stage_Data].[STG].[TRUSTNET_OEIC] ([TRUSTNET_UNIQUE] -- 20180626 [AZURE_R7_ALCHEMY_DATA].
			, [FundCode], [FundName], [PriceName]-- , [Group] -- REMOVED 20170913 -- , [Focus] -- REMOVED 20170913
			, [FE Risk Score], [fund_counter], [table_counter] 	-- , [ShareClass] -- REMOVED 20170913
			, [Unit Type], [Currency], [Bid], [Offer], [ClosureDate], [Yield]
			, [Citicode], [SEDOL], [ISIN] -- , [Region] -- REMOVED 20170913
			, [Asset Class] -- , [Investment Focus] -- REMOVED 20170913
			, [Sector]
			, [Fe Crown Fund Rating]
			, [Fundsize])
			SELECT * FROM #ACTIVE_MAIN_FINAL_INSERT
			WHERE [ClosureDate] IS NOT NULL

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS INSERTED (TRUSTNET_OEIC) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		IF @v_ERR <> (0)
		BEGIN
			SET @I_MSG_2500 = 'Error has occured [INSERT TRUSTNET_OEIC]' + CONVERT(VARCHAR(10),@v_ERR)
				EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
			RETURN (255)
		END

		IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
		BEGIN
			DECLARE @tSUBJ VARCHAR(250)
			SET @tSUBJ = 'Data loaded low? (TRUSTNET_OEIC)'
			SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
		END

/*
		-- Msg 5315, Level 16, State 1, Procedure usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC, Line 377 [Batch Start Line 20]
		-- The target of a MERGE statement cannot be a remote table, a remote view, or a view over remote tables.
*/
		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		DROP TABLE #SymbolsToProcess
	END
	ELSE
	BEGIN
		SET @I_MSG_2500 = '@ADD_PRICE_ROWS IS ZERO'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END

	-- ===============================================================================================================================================================================================================
	-- 
	-- ===============================================================================================================================================================================================================

	SELECT 'ADD INVESTMENTS (usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC):', * FROM @ACTIVE_MAIN_SET_IN
	WHERE ISNULL([ISINCode],'') NOT IN (SELECT [LABEL] FROM #INVESTMENT_ALIAS)
	AND ISNULL([CITICODE],'') NOT IN (SELECT [LABEL] FROM #INVESTMENT_ALIAS)
	AND ISNULL([SEDOL],'') NOT IN (SELECT [LABEL] FROM #INVESTMENT_ALIAS)

	IF @ADD_MISSING_INVESTMENTS = (1)
	BEGIN
		SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ADD_MISSING_INVESTMENTS]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ADD_MISSING_INVESTMENTS]
			@BUILD_ID = @BUILD_ID -- = @vRE
			, @ACTIVE_MAIN_SET_IN = @ACTIVE_MAIN_SET_IN
			, @MARKET = @MARKET
			, @DEBUG = @DEBUG
			, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH
	
		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END
	ELSE
	BEGIN
		SET @I_MSG_2500 = '@ADD_MISSING_INVESTMENTS IS ZERO'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END

	-- ===============================================================================================================================================================================================================
	-- Get a list of all investments so that we can now set the [SECTOR] correctly
	-- ===============================================================================================================================================================================================================

	IF @CONFIGURE_SECTOR_AND_MARKET = (1)
	BEGIN 
		SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_SECTOR_AND_MARKET]
			@BUILD_ID = @BUILD_ID -- = @vRE
			, @ACTIVE_MAIN_SET_IN = @ACTIVE_MAIN_SET_IN
			, @MARKET = @MARKET
			, @DEBUG = @DEBUG
			, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH
	
		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- Get a list of all investments so that we can now set the [NAME] correctly
	-- ===============================================================================================================================================================================================================

	IF @CONFIGURE_INVESTMENT_NAME = (1)
	BEGIN 
		SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_INVESTMENT_NAME]'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_CONFIGURE_INVESTMENT_NAME]
			@BUILD_ID = @BUILD_ID -- = @vRE
			, @ACTIVE_MAIN_SET_IN = @ACTIVE_MAIN_SET_IN
			, @DEBUG = @DEBUG
			, @BUILD_TYPE = @BUILD_TYPE
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
			-- RETURN (255)
		END CATCH
	
		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		DROP TABLE #ACTIVE_MAIN_PREP
		DROP TABLE #ACTIVE_MAIN
		DROP TABLE #INVESTMENT_ALIAS
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	IF @DROP_ACTIVE_RAW_OEIC = (1) DROP TABLE #ACTIVE_MAIN_FINAL_INSERT

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_v_STOCK_EXCHANGE_TICKER_PLUS_INDICES]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_v_STOCK_EXCHANGE_TICKER_PLUS_INDICES] (@BUILD_ID INT = 0 , @ROWS_IN_BATCH_EXPECTED INT = 0
, @DEBUG INT = 0
, @CSV_DIRECTORY VARCHAR(250) = 'C:\Users\Alex\OneDrive\' -- 'C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\'
, @CSV_FILENAME VARCHAR(250) = 'STOCK_EXCHANGE_INVESTMENT_SECTOR'
, @CSV_FILE_EXTENSION VARCHAR(25) = 'CSV'
, @BUILD_TYPE CHAR(1) = 'F') AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	September 2017
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190213	Stop call to [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190218	Change STG to XLS
	-- 1.3		20190507	Read file from C:\Users\Alex\OneDrive\
	-- 1.4		20190819	Moved [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
	--
	-- EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_v_STOCK_EXCHANGE_TICKER_PLUS_INDICES] @BUILD_ID = 0, @DEBUG = 1
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250), @SQL NVARCHAR(2500)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		
	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_SEKR - exists from previous run'
		DROP TABLE ##ACTIVE_RAW_SEKR

		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END TRY

	BEGIN CATCH
		SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_SEKR - did not exist from previous run'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- CREATE ##ACTIVE_RAW_SEKR
	-- IT IS GLOBAL TEMP AS THIS IS NEEDED FOR sp_executesql
	-- 
	-- sp_executesql is needed for variable CSV name
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE ##ACTIVE_RAW_SEKR'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		CREATE TABLE ##ACTIVE_RAW_SEKR( -- DROP TABLE ##ACTIVE_RAW_SEKR
		[ExportDate] [date] NULL,
		-- [EST_INVESTMENT_ID] [nvarchar](255) NULL, -- [int] NULL,
		-- [IndexNameShort] [nvarchar](255) NULL,
		[IndexName] [varchar](14) NOT NULL,
		[Ticker] [nvarchar](4000) NULL,
		[Investment Name] [nvarchar](255) NULL,
		[Currency] [nvarchar](255) NULL,
		[Price] [nvarchar](255) NULL, -- [float] NULL,
		[ABS_Change] [nvarchar](255) NULL, -- [float] NULL,
		[PCT_Change] [nvarchar](255) NULL -- [float] NULL
		) ON [PRIMARY]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'LOAD DATA INTO ##ACTIVE_RAW_SEKR table'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	SET @SQL = 'BULK INSERT ##ACTIVE_RAW_SEKR FROM ''' + @CSV_DIRECTORY + @CSV_FILENAME + '.' + @CSV_FILE_EXTENSION + ''''
	+ 'WITH (DATAFILETYPE = ''char'', 
			FIELDTERMINATOR = '','', 
			-- FIELDTERMINATOR = ''<'', 
			ROWTERMINATOR = ''\n'', 
			FIRSTROW = 2)'

	BEGIN TRY
		IF @DEBUG = (1)
		PRINT @SQL

	    EXEC sp_executesql @sql

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to ##ACTIVE_RAW_SEKR = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- UPDATE SUN\SAT to FRIDAY DATE
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'UPDATE SUN\SAT to FRIDAY DATE'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		UPDATE ##ACTIVE_RAW_SEKR
		SET [ExportDate] = DATEADD(DD, -(2), [ExportDate])
		WHERE DATEPART(DW, [ExportDate]) IN (1) -- Sun

		UPDATE ##ACTIVE_RAW_SEKR
		SET [ExportDate] = DATEADD(DD, -(1), [ExportDate])
		WHERE DATEPART(DW, [ExportDate]) IN (7) -- Sat

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT]' -- [AZURE_R7_ALCHEMY_DATA].
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- SHOULD THIS REALLY GO TO ITS OWN TABLE !!!!
	-- NO - FOR NOW IT IS ONLY TO GET MISSING DAILY FTSE PRICES, THAT'S ALL -- 20170910
	-- ENDS UP AS 0AYAHEQT !!!!!!!
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		INSERT INTO
		-- SELECT TOP (10) * FROM
		[Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] ([Symbol], [Name], [Price] -- [AZURE_R7_ALCHEMY_DATA].
		-- , [Days_Low], [Days_High]
		-- , [Change]
		, [Currency]
		-- , [P/E_Ratio], [PEG_Ratio], [52wk_low], [52wk_high], [50 day_moving avg]
		-- , [%age change FROM 50day avg], [Dividend_Yield]
		, [Stock Exchange]
		, [ClosureDate]
		-- , [OPEN_PRICE], [PREVIOUS_CLOSE], [Volume], [AverageDailyVolume], [DividendPerShare], [MarketCapitalization]
		-- , [EPS_Estimate_Current_Year_GBX], [EPS_Estimate_Next_Year_GBX], [EPS_Estimate_Current_Quarter_GBX]
		-- , [Price_per_EPS_Estimate_Current_Year_GBX], [Price_per_EPS_Estimate_Next_Year_GBX], [MCAP_Realtime]
		--, [Revenue_GBP], [One_Year_Target_Price_GBP], [Shares_Outstanding]
		)

		SELECT [Ticker]
		, [Investment Name]
		-- , CASE WHEN [Currency] = 'GBX' THEN MAX([Price]) / (100) ELSE MAX([Price]) END
		, MIN([Price]) -- e.g. we have 'AA PLC','1.672','GBX' when actually this is 1.672 GBP .....
		-- , [ABS_Change]
		, [Currency]
		, 'R7LSE'
		, [ExportDate]
		-- , [EST_INVESTMENT_ID]
		-- , [IndexNameShort]
		-- , [IndexName]
		-- , [PCT_Change]
		FROM ##ACTIVE_RAW_SEKR B
		WHERE NOT EXISTS (SELECT (1) FROM [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] C -- [AZURE_R7_ALCHEMY_DATA].
							WHERE REPLACE([B].[Ticker],'.','') = REPLACE([C].[Symbol], '.', '') -- MANAE WG. and WG UU. and UU etc
							AND [B].[ExportDate] = [C].[ClosureDate])
		-- AND (1) = (0) -- 2018014 - we have issue with 2018-03-01 and 2018-01-03 - we must use BULK COPY
		GROUP BY [Ticker], [Investment Name], [Currency], [ExportDate]
	
		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		PRINT 'E: Balls!'
		SELECT TOP (10) [Ticker]
		, [Investment Name]
		, MIN([Price]) -- e.g. we have 'AA PLC','1.672','GBX' when actually this is 1.672 GBP .....
		, [Currency]
		, 'R7LSE'
		, [ExportDate]
		FROM ##ACTIVE_RAW_SEKR B
		WHERE NOT EXISTS (SELECT (1) FROM [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] C -- [AZURE_R7_ALCHEMY_DATA].
							WHERE REPLACE([B].[Ticker],'.','') = REPLACE([C].[Symbol], '.', '') -- MANAE WG. and WG UU. and UU etc
							AND [B].[ExportDate] = [C].[ClosureDate])
		GROUP BY [Ticker], [Investment Name], [Currency], [ExportDate]
		ORDER BY 3 DESC

		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ROWS INSERTED (YAHOO_ONE_DAY_EXPORT)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT STOCK_EXCHANGE]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END
	
	PRINT @I_MSG_2500

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (STOCK_EXCHANGE)'
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
	-- ===============================================================================================================================================================================================================

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	INSERT INTO @InvestmentsToAdd ([SYMBOL], [INVESTMENT_NAME], [INVESTMENT_TYPE], [SECTOR], [MARKET])
	SELECT DISTINCT [Ticker], [Investment Name], '%EQU%', '%KNOWN%', '%EQU%'
	FROM ##ACTIVE_RAW_SEKR B
	WHERE [Investment Name] LIKE '[%A-Za-z]%'
	AND [Ticker] NOT IN (SELECT [PRIMARY_LABEL] FROM [Alchemy_Data].[DIM].[v_INVESTMENT]) -- [AZURE_R7_ALCHEMY_DATA].

	-- ===============================================================================================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] - ADD INVESTMENTS'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] @BUILD_ID = @BUILD_ID -- = @vRE
		, @InvestmentsToAdd = @InvestmentsToAdd, @ONLY_CONFIGURE_SECTOR_AND_MARKET = 0, @PRINT_ONLY_IF_ERROR = 1
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	DROP TABLE ##ACTIVE_RAW_SEKR

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END

GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_ALL]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_ALL] (
  @BUILD_ID INT = 0 
, @UPDATE_PRICE_ROWS INT = 1 -- 20171215
, @IMPORT_YAHOO_EQUITIES INT = 1
, @IMPORT_YAHOO_OEIC INT = 1
, @IMPORT_YAHOO_INDICES INT = 1
, @IMPORT_YAHOO_FUTURES INT = 1
, @IMPORT_YAHOO_CURRENCY INT = 1
, @IMPORT_YAHOO_CRYPTO INT = 1
, @ROWS_IN_BATCH_EXPECTED INT = 100
, @ADD_PRICE_ROWS INT = 1
, @BUILD_TYPE CHAR(1) = 'F'
, @DEBUG INT = 0
-- , @ADD_MISSING_INVESTMENTS INT = 1
-- , @CONFIGURE_SECTOR_AND_MARKET INT = 1
) AS
BEGIN

	SET LANGUAGE BRITISH

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2017
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190211 Stopped processing of @IMPORT_YAHOO_OEIC as to many price conflicts with trustnet
	-- 1.2		20190513 @MIN_NO_OF_PRODUCTS_EXPECTED added to SUB USP
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_ALL] @UPDATE_PRICE_ROWS = 1, @ROWS_IN_BATCH_EXPECTED = 0
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_ALL] @UPDATE_PRICE_ROWS = 1, @ROWS_IN_BATCH_EXPECTED = 0, @IMPORT_YAHOO_OEIC = 0
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_ALL] @UPDATE_PRICE_ROWS = 0, @ROWS_IN_BATCH_EXPECTED = 0, @IMPORT_YAHOO_EQUITIES = 0, @IMPORT_YAHOO_OEIC = 0
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @PARENT_USP VARCHAR(250), @RETURN_VALUE INT
	DECLARE @ALERT_OVER_X_SECS INT, @STEP_START DATETIME, @SQL NVARCHAR(2500)

	SET @ALERT_OVER_X_SECS = (30)
	SET @STEP_START = GETDATE()

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		
	-- ===============================================================================================================================================================================================================
	-- IF we are on a full build then the rows will have already been loaded on the INTRADAY LOAD and now we are just on updates !!!!
	-- ===============================================================================================================================================================================================================

	IF @BUILD_TYPE = 'F'
	SET @ROWS_IN_BATCH_EXPECTED = (0)

	-- DECLARE @i INT
	-- SET @i = (1) + (SELECT MAX([BUILD_ID]) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[v_MONITOR_BUILD_PROCESS_LATEST_F_or_I])

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_YAHOO_EQUITIES = (1)
	BEGIN
		SET @I_MSG_2500 = 'YAHOO_FINANCE_EQUITIES_01'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_01', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_01', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100, @MIN_NO_OF_PRODUCTS_EXPECTED = 133 -- 177
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END

		SET @I_MSG_2500 = 'YAHOO_FINANCE_EQUITIES_02'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_02', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_02', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100, @MIN_NO_OF_PRODUCTS_EXPECTED = 471 -- 524
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END

		SET @I_MSG_2500 = 'YAHOO_FINANCE_EQUITIES_03'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_03', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_03', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100, @MIN_NO_OF_PRODUCTS_EXPECTED = 427 -- 478
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END

		SET @I_MSG_2500 = 'YAHOO_FINANCE_EQUITIES_04'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_04', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_04', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100, @MIN_NO_OF_PRODUCTS_EXPECTED = 415 -- 473
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END

		SET @I_MSG_2500 = 'YAHOO_FINANCE_EQUITIES_05'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_05', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_EQUITIES_05', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100, @MIN_NO_OF_PRODUCTS_EXPECTED = 415 -- 473
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_YAHOO_INDICES = (1)
	BEGIN
		SET @I_MSG_2500 = 'YAHOO_FINANCE_INDICES_01'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_INDICES_01', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_INDICES_01', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 1, @MIN_NO_OF_PRODUCTS_EXPECTED = 114 -- 134
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_YAHOO_FUTURES = (1)
	BEGIN
		SET @I_MSG_2500 = 'YAHOO_FINANCE_FUTURES_01'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_FUTURES_01', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_FUTURES_01', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100, @MIN_NO_OF_PRODUCTS_EXPECTED = 28 -- 29
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_YAHOO_OEIC = (1) AND (1) = (0) -- 20190211 too many price conflistcs with TRUSTNET FEED
	BEGIN
		SET @I_MSG_2500 = 'YAHOO_FINANCE_OEIC_01'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_01', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_01', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			,@ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END

		SET @I_MSG_2500 = 'YAHOO_FINANCE_OEIC_02'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_02', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_02', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			,@ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END

		SET @I_MSG_2500 = 'YAHOO_FINANCE_OEIC_03'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_03', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_03', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			,@ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END

		SET @I_MSG_2500 = 'YAHOO_FINANCE_OEIC_04'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_04', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_OEIC_04', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			,@ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 100
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_YAHOO_CURRENCY = (1)
	BEGIN
		SET @I_MSG_2500 = 'YAHOO_FINANCE_USD_CURRENCY_01'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_USD_CURRENCY_01', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_USD_CURRENCY_01', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 1, @MIN_NO_OF_PRODUCTS_EXPECTED = 148 -- 158
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================
	IF @IMPORT_YAHOO_CRYPTO = (1)
	BEGIN
		SET @I_MSG_2500 = 'YAHOO_FINANCE_CRYPTO_01'
		BEGIN TRY
		-- [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_CRYPTO_01', @DEBUG = 1
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @CSV_FILENAME = 'YAHOO_FINANCE_CRYPTO_01', @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
			, @ADD_PRICE_ROWS = @ADD_PRICE_ROWS, @UPDATE_PRICE_ROWS = @UPDATE_PRICE_ROWS, @ROWS_IN_BATCH_EXPECTED = @ROWS_IN_BATCH_EXPECTED
			, @FACTOR_DOWN_PRICES = 1, @MIN_NO_OF_PRODUCTS_EXPECTED = 22
		END TRY

		BEGIN CATCH
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500
			-- 20181122 RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC @RETVAL = [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
			-- 20181122 RETURN (255)
		END
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] (@BUILD_ID INT = 0 
, @ROWS_IN_BATCH_EXPECTED INT = 25
, @ADD_PRICE_ROWS INT = 1
, @UPDATE_PRICE_ROWS INT = 1 -- 20171214
-- , @ADD_MISSING_INVESTMENTS INT = 1
-- , @CONFIGURE_SECTOR_AND_MARKET INT = 1
, @DEBUG INT = 0
, @CSV_DIRECTORY VARCHAR(250) = 'C:\Users\Alex\OneDrive\' -- 'C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\'
, @CSV_FILENAME VARCHAR(250) = 'YAHOO_FINANCE_EQUITIES_01' -- 'YAHOO_FINANCE_SUB_01'
, @CSV_FILE_EXTENSION VARCHAR(25) = 'CSV'
, @SYMBOL VARCHAR(50) = '%'
, @FACTOR_DOWN_PRICES INT = 100
, @SEND_EMAIL INT = 1
, @FIRSTROW INT = 2
, @LASTROW INT = 39843000
, @BUILD_TYPE CHAR(1) = 'F'
, @MIN_NO_OF_PRODUCTS_EXPECTED INT = 0
) AS
BEGIN

	SET LANGUAGE BRITISH

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2017
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20170919 Added @ADD_PRICE_ROWS, @ADD_MISSING_INVESTMENTS and @CONFIGURE_SECTOR_AND_MARKET to be consistent with ETF usp
	-- 1.2		20190111 IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED AND @SEND_EMAIL = (1) AND @BUILD_TYPE = 'F' ... SET @tSUBJ = 'Data loaded low ... 
	-- 1.3		20190212 Add "BODGE" for non GBP/GBX
	-- 1.4		20190213 Stop call to [AZURE_R7_ALCHEMY_DATA].
	-- 1.5		20190227 Change population of #INVESTMENT_ALIAS
	-- 1.6		20190227 [SYMBOL] SARG now incorporates removal of ".L"
	-- 1.7		20190227 Remove [EST_INVESTMENT_ID_COUNT]
	-- 1.8		20190227 Change population of #MISSING_FROM_DIM_INVESTMENT
	-- 1.9		20190507 Read file from C:\Users\Alex\OneDrive\
	-- 1.10		20190819 Moved [Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
	-- 1.11		20200331 Add 'DELETE [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] (IF PRICE DIFFERENCE)'

	/*
		DECLARE @i INT; SET @i = (1) + (SELECT MAX([BUILD_ID]) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[v_MONITOR_BUILD_PROCESS_LATEST_F_or_I])

		EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_HISTORY_SUB] @BUILD_ID = @i
		, @CSV_FILENAME = 'YAHOO_FINANCE_INDICES_01'
		, @ROWS_IN_BATCH_EXPECTED = 100, @BUILD_TYPE = 'I'
		, @ADD_PRICE_ROWS = 0
		, @ADD_MISSING_INVESTMENTS = 1
		, @CONFIGURE_SECTOR_AND_MARKET = 1
		, @DEBUG = 1
		-- , @CSV_DIRECTORY = 'C:\ALCHEMY_SQL_DATA\EXCEL_ FEEDS\2017Q3_IMPORT_MANY_OLD_YAHOO_HISTORY_SUB_FILES\'
	*/

	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	IF @DEBUG = (1) PRINT 'A'

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @PARENT_USP VARCHAR(250), @RETURN_VALUE INT
	DECLARE @ALERT_OVER_X_SECS INT, @STEP_START DATETIME, @SQL NVARCHAR(2500)
	DECLARE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	DECLARE @tSUBJ VARCHAR(250)

	SET @ALERT_OVER_X_SECS = (30)
	SET @STEP_START = GETDATE()

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
		
	IF @DEBUG = (1) PRINT 'B'

	-- ===============================================================================================================================================================================================================
	-- CHECK PARAMETERS
	-- ===============================================================================================================================================================================================================

	IF @ADD_PRICE_ROWS = (0)
	BEGIN
		SET @I_MSG_2500 = 'No work to do .. WTF'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		PRINT @I_MSG_2500
		RETURN (255)
	END

	IF @DEBUG = (1) PRINT 'C'

	-- ===============================================================================================================================================================================================================
	-- SET GET DETAILS OF CSV FILE PASSED IN
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1)
	BEGIN
		DECLARE @DIR_CMD VARCHAR(250), @LINE VARCHAR(250)
		CREATE TABLE #CommandShell ( Line VARCHAR(512)) 
 
		EXEC sp_configure 'show advanced options', 1
		RECONFIGURE
		EXEC sp_configure 'xp_cmdshell', 1
		RECONFIGURE

		SET @DIR_CMD = 'dir ' + @CSV_DIRECTORY + @CSV_FILENAME + '.' + @CSV_FILE_EXTENSION
		PRINT @DIR_CMD
		INSERT INTO #CommandShell
		EXEC XP_CMDSHELL @DIR_CMD
		
		SET @LINE = (SELECT * FROM #CommandShell WHERE [Line] LIKE '%201%csv%')
		SET @I_MSG_2500 = 'File In (CSV):'+ISNULL(@Line,'')
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		DROP TABLE #CommandShell
		
		EXEC sp_configure 'xp_cmdshell', 0
		RECONFIGURE
		EXEC sp_configure 'show advanced options', 0
		RECONFIGURE
	END

	IF @DEBUG = (1) PRINT 'D'

	-- ===============================================================================================================================================================================================================
	-- GET ALIAS DATA
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #INVESTMENT_ALIAS'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
/*
		SELECT *
		INTO #INVESTMENT_ALIAS
		FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] -- [AZURE_R7_ALCHEMY_DATA].
*/
		SELECT *
		INTO #INVESTMENT_ALIAS
		FROM [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] -- [AZURE_R7_ALCHEMY_DATA].
		UNION
		SELECT -- Add UU for UU. etc ... - Yahoo does not like UU..L
		[A].[ID]
		, [A].[INVESTMENT_ID]
		, LEFT([A].[LABEL], LEN([A].[LABEL]) - (1))
		, [A].[ALIAS_TYPE]
		, [A].[ENABLED]
		, [A].[crNotes]
		, [A].[crDate]
		, [A].[LAStUpdateDate]
		, (0)
		FROM [Alchemy_Data].[DIM].[INVESTMENT_ALIAS] A
		WHERE [A].[ENABLED] = (1)
		AND [LABEL] LIKE '%[.]'

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #INVESTMENT_ALIAS = ' + CONVERT(VARCHAR(10), @v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1) PRINT 'E'

	-- ===============================================================================================================================================================================================================
	-- ADD INDEXES
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ADD INDEXES (#INVESTMENT_ALIAS) '
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		CREATE INDEX IDX_001 ON #INVESTMENT_ALIAS ([LABEL])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT 'F'

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_SUB - exists from previous run'
		DROP TABLE ##ACTIVE_RAW_SUB

		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END TRY

	BEGIN CATCH
		SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_SUB - did not exist from previous run'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END CATCH

	IF @DEBUG = (1) PRINT 'G'

	-- ===============================================================================================================================================================================================================
	-- CREATE ##ACTIVE_RAW_SUB
	-- IT IS GLOBAL TEMP AS THIS IS NEEDED FOR sp_executesql
	-- 
	-- sp_executesql is needed for variable CSV name
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE ##ACTIVE_RAW_SUB: '+ @CSV_FILENAME
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		CREATE TABLE ##ACTIVE_RAW_SUB
		([SYMBOL] [nvarchar](255)
		, [ClosureDate] DATE NULL
		, [URLSource] VARCHAR(25) NULL -- Why not (1), YAHOO_FINANCE_OEIC_04.CSV has caused issue!!
		, [Open] VARCHAR(255) NULL
		, [High] VARCHAR(255) NULL
		, [Low] VARCHAR(255) NULL
		, [Close] VARCHAR(255) NULL
		, [AdjClose] VARCHAR(255) NULL
		-- , [Open] FLOAT NULL
		-- , [High] FLOAT NULL
		-- , [Low] FLOAT NULL
		-- , [Close] FLOAT NULL
		-- , [AdjClose] FLOAT NULL
		, [Volume] VARCHAR(255) NULL
		, [MarketCap] VARCHAR(255) NULL
		, [PERatio] VARCHAR(255) NULL
		, [EPS] VARCHAR(255) NULL
		) -- Handle 1+e06
		-- , [Volume] INT NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT 'H'

	SET @I_MSG_2500 = 'LOAD ##ACTIVE_RAW_SUB: '+ @CSV_FILENAME
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- IF (1) = (2)
	BEGIN TRY
		SET @SQL = 'BULK INSERT ##ACTIVE_RAW_SUB FROM ''' + @CSV_DIRECTORY + @CSV_FILENAME + '.' + @CSV_FILE_EXTENSION + ''''
		+ 'WITH (DATAFILETYPE = ''char'', 
				FIELDTERMINATOR = '','', 
				ROWTERMINATOR = ''\n'', 
				FIRSTROW = ' + CONVERT(VARCHAR, @FIRSTROW) + ', LASTROW = ' + CONVERT(VARCHAR, @LASTROW) + ')'

		IF @DEBUG = (1)
		PRINT @SQL

	    EXEC sp_executesql @sql
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to ##ACTIVE_RAW_SUB = ' + CONVERT(VARCHAR(10), (SELECT COUNT(*) FROM ##ACTIVE_RAW_SUB))
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1) PRINT 'J'

	IF @DEBUG = (1) SELECT TOP 25 '##ACTIVE_RAW_SUB', * FROM ##ACTIVE_RAW_SUB -- WHERE SYMBOL LIKE 'AV%'
	ORDER BY ClosureDate DESC

	IF @DEBUG = (1) SELECT DISTINCT '##ACTIVE_RAW_SUB ii ', [SYMBOL] FROM ##ACTIVE_RAW_SUB -- WHERE SYMBOL LIKE 'AV%'
	ORDER BY 2 DESC

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================
	SELECT @v_ROWCOUNT = (SELECT COUNT(DISTINCT [SYMBOL]) FROM ##ACTIVE_RAW_SUB)
	IF @v_ROWCOUNT < @MIN_NO_OF_PRODUCTS_EXPECTED AND @SEND_EMAIL = (1) -- AND @BUILD_TYPE = 'F'
	BEGIN
		SET @tSUBJ = 'Products loaded low? ([YAHOO_ONE_DAY_EXPORT]):EXPECTED:' + CONVERT(VARCHAR, @MIN_NO_OF_PRODUCTS_EXPECTED) + ':ACTUAL:' + CONVERT(VARCHAR, @v_ROWCOUNT)
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded: ' + @CSV_FILENAME
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	SET @I_MSG_2500 = 'DISTINCT [SYMBOL] = ' + CONVERT(VARCHAR(10), (SELECT COUNT(DISTINCT [SYMBOL]) FROM ##ACTIVE_RAW_SUB))
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1) PRINT 'K'

	-- ===============================================================================================================================================================================================================
	-- Look for BAD DATES coming in:
	-- e.g. B.DATE > GETDATE()
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'Check dates coming in from CSV: Dates greater than today'
	IF EXISTS (SELECT 1 FROM ##ACTIVE_RAW_SUB B1 WHERE [B1].[ClosureDate] > GETDATE())
	BEGIN
		SELECT @I_MSG_2500 = @I_MSG_2500 + ':' + CONVERT(VARCHAR, (SELECT COUNT(*) FROM ##ACTIVE_RAW_SUB B1 WHERE [B1].[ClosureDate] > GETDATE())) + ' row(s)'
		PRINT @I_MSG_2500
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- RETURN (255)
	END

	SET @I_MSG_2500 = 'Check dates coming in from CSV: No. months vs No. days'
	IF (SELECT COUNT(DISTINCT DATEPART(MM, [B1].[ClosureDate])) FROM ##ACTIVE_RAW_SUB B1) > (SELECT COUNT(DISTINCT DATEPART(DD, [B1].[ClosureDate])) FROM ##ACTIVE_RAW_SUB B1)
	BEGIN
		SELECT DISTINCT [B1].[ClosureDate], CONVERT(VARCHAR(11), [B1].[ClosureDate], 113) FROM ##ACTIVE_RAW_SUB B1
		SELECT 'MM', COUNT(DISTINCT DATEPART(MM, [B1].[ClosureDate])) FROM ##ACTIVE_RAW_SUB B1
		SELECT 'DD', COUNT(DISTINCT DATEPART(DD, [B1].[ClosureDate])) FROM ##ACTIVE_RAW_SUB B1
		PRINT @I_MSG_2500
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END

	IF @DEBUG = (1) PRINT 'L'

	-- ===============================================================================================================================================================================================================
	-- CREATE #ACTIVE_MAIN_PREP (#ACTIVE_MAIN has A1 WHERE clause on it = f(csv) i.e. MIN
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE_MAIN_PREP table from OPEN DATASOURCE (NO LONGER VIEW) YAHOO_HISTORY_SUB: '+ @CSV_FILENAME
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		SELECT DISTINCT -- 20181106
		-- TOP (9960) -- 2800
		LEFT(REPLACE([SYMBOL], '.L', ''),25) AS [SYMBOL] -- [ï»¿Investment]
		, CONVERT(INT, (0)) AS [EST_INVESTMENT_ID]			-- Calculated later . it is too slow in here (due to OR)
		-- , CONVERT(INT, (0)) AS [EST_INVESTMENT_ID_COUNT]	-- Calculated later . it is too slow in here (due to OR)
		, [ClosureDate]
		, [UrlSource]
		, CONVERT(FLOAT, CASE WHEN [Open] LIKE '%N%A%' THEN NULL ELSE CONVERT(FLOAT, [Open]) END)
		/ @FACTOR_DOWN_PRICES AS [OPEN]
		, CONVERT(FLOAT, CASE WHEN [High] LIKE '%N%A%' THEN NULL ELSE CONVERT(FLOAT, [High]) END)
		/ @FACTOR_DOWN_PRICES AS [HIGH]
		, CONVERT(FLOAT, CASE WHEN [Low] LIKE '%N%A%' THEN NULL ELSE CONVERT(FLOAT, [Low]) END)
		/ @FACTOR_DOWN_PRICES AS [LOW]
		, CONVERT(FLOAT, CASE WHEN [Close] LIKE '%N%A%' THEN NULL ELSE CONVERT(FLOAT, [Close]) END)
		/ @FACTOR_DOWN_PRICES AS [Close]
		, CONVERT(FLOAT, CASE WHEN [AdjClose] LIKE '%N%A%' THEN NULL ELSE CONVERT(FLOAT, [AdjClose]) END)
		/ @FACTOR_DOWN_PRICES AS [AdjClose]
		, CONVERT(FLOAT, CASE WHEN [Volume] LIKE '%N%A%' THEN NULL ELSE CONVERT(FLOAT, [Volume]) END) AS [Volume]
		-- , CONVERT(BIGINT, [Volume]) AS [Volume]
		, [MarketCap]
		, [PERatio]
		, [EPS]
		INTO #ACTIVE_MAIN_PREP -- DROP TABLE #ACTIVE_MAIN_PREP
		FROM ##ACTIVE_RAW_SUB B
		WHERE 1 = 1 -- CONVERT(FLOAT, [Close]) <> (0)
		AND LEFT(REPLACE([SYMBOL], '.L', ''),25) LIKE @SYMBOL -- [SYMBOL] 

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE_MAIN_PREP = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1)
	SELECT '#ACTIVE_MAIN_PREP A',  * FROM #ACTIVE_MAIN_PREP ORDER BY [ClosureDate] DESC
-- 	WHERE [MarketCap] IS NOT NULL

	IF @DEBUG = (1) PRINT 'M'

	-- ===============================================================================================================================================================================================================
	-- BODGE DUE TO NON GBP GBX CURRENCIES
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'UPDATE #ACTIVE_MAIN_PREP - BODGE'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		UPDATE #ACTIVE_MAIN_PREP -- DROP TABLE #ACTIVE_MAIN_PREP
		SET [OPEN] = [OPEN] * @FACTOR_DOWN_PRICES
		, [HIGH] = [HIGH] * @FACTOR_DOWN_PRICES
		, [LOW] = [LOW] * @FACTOR_DOWN_PRICES
		, [Close] = [Close] * @FACTOR_DOWN_PRICES
		, [AdjClose] = [AdjClose] * @FACTOR_DOWN_PRICES
		WHERE [SYMBOL] IN ('GRP', 'SMTG', 'INM') -- EUR

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- IF @DEBUG = (1)
	-- SELECT '#ACTIVE_MAIN_PREP A2',  * FROM #ACTIVE_MAIN_PREP ORDER BY [ClosureDate] DESC

	IF @DEBUG = (1) PRINT 'N'

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DROP TABLE ##ACTIVE_RAW_SUB: '+ @CSV_FILENAME
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		DROP TABLE ##ACTIVE_RAW_SUB
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT 'P'

	-- ===============================================================================================================================================================================================================
	-- ADD INDEXES
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'ADD INDEXES (#ACTIVE_MAIN_PREP) '
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		CREATE INDEX IDX_001 ON #ACTIVE_MAIN_PREP ([SYMBOL])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) PRINT 'Q'

	-- ===============================================================================================================================================================================================================
	-- UPDATE EST_INVESTMENT_ID
	-- SPLIT INTO 3 AS "OR" IS TOO SLOW 20170921
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'UPDATE #ACTIVE_MAIN_PREP (UPDATE EST_INVESTMENT_ID)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		UPDATE #ACTIVE_MAIN_PREP
		SET [EST_INVESTMENT_ID] = [INVESTMENT_ID]
		FROM #ACTIVE_MAIN_PREP B1, #INVESTMENT_ALIAS A1
		WHERE [A1].[LABEL] = [B1].[SYMBOL]
		AND ISNULL([EST_INVESTMENT_ID], 0) = 0

		SELECT @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS UPDATED to #ACTIVE_MAIN_PREP [EST_INVESTMENT_ID] = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1)
	SELECT '#ACTIVE_MAIN_PREP iii',  * FROM #ACTIVE_MAIN_PREP ORDER BY [ClosureDate] DESC

	IF @DEBUG = (1) PRINT 'R'

	-- ===============================================================================================================================================================================================================
	-- UPDATE MIN_COUNTER
	-- ===============================================================================================================================================================================================================

/*
	SET @I_MSG_2500 = 'UPDATE #ACTIVE_MAIN_PREP (UPDATE MIN_COUNTER)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		UPDATE #ACTIVE_MAIN_PREP
		SET [EST_INVESTMENT_ID_COUNT] = (SELECT COUNT(DISTINCT [A1].[INVESTMENT_ID]) FROM #INVESTMENT_ALIAS A1
											WHERE [A1].[LABEL] = [B1].[SYMBOL])
		FROM #ACTIVE_MAIN_PREP B1

		SELECT @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS UPDATED to #ACTIVE_MAIN_PREP [EST_INVESTMENT_ID_COUNT] = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
*/

	-- ===============================================================================================================================================================================================================
	-- Finally build A1 data set to INSERT
	-- CREATE #ACTIVE_MAIN
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE_MAIN table from #ACTIVE_MAIN_PREP' -- OPEN DATASOURCE (VIEW) YAHOO_HISTORY_SUB: '+ @CSV_FILENAME
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	BEGIN TRY
		SELECT *
		INTO #ACTIVE_MAIN
		FROM #ACTIVE_MAIN_PREP
		WHERE ISNULL([EST_INVESTMENT_ID],0) <> (0) -- 20170811 FAILED TO PICK UP "OLD DATA" e.g. '7IM AAP ADVENTUROUS D ACC'

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE_MAIN = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1)
	SELECT '#ACTIVE_MAIN iv',  * FROM #ACTIVE_MAIN ORDER BY [ClosureDate] DESC

	IF @DEBUG = (1) PRINT 'S'

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	IF @ADD_PRICE_ROWS = (1)
	BEGIN
		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		BEGIN TRY
			CREATE TABLE #SymbolsToProcess ([t_SYMBOL] VARCHAR(250), [t_ClosureDate] DATE NULL)
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = 'Error CREATE TABLE #SymbolsToProcess'
			RETURN (255)
		END CATCH
	
		SET @I_MSG_2500 = 'INSERT INTO #SymbolsToProcess (YAHOO_HISTORY_SUB)'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			INSERT INTO #SymbolsToProcess ([t_SYMBOL], [t_CLosureDate])
			SELECT DISTINCT [SYMBOL], CONVERT(DATE, [B1].[ClosureDate])
			FROM #ACTIVE_MAIN B1

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			IF @I_MSG_2500 IS NULL SET @I_MSG_2500 = 'NULL MESSAGE: '+ISNULL(@PARENT_USP,'UNKNOWN USP(1)')
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1) PRINT 'T'

		EXEC @STEP_START = [Alchemy_Functions].[dbo].[PRINT_MESSAGE_TO_LOG_IF_STAGE_IS_SLOW] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @D1 = @STEP_START, @ALERT_IF_OVER_X_SECONDS = @ALERT_OVER_X_SECS, @I_MSG = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		IF @DEBUG = (1) AND @SEND_EMAIL = (1)
		BEGIN
			DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT CONVERT(VARCHAR(11), [t_ClosureDate], 113)+ ':' + CONVERT(VARCHAR, COUNT(*)) + ' rows.'
			FROM #SymbolsToProcess
			GROUP BY CONVERT(VARCHAR(11), [t_ClosureDate], 113)
			ORDER BY CONVERT(DATE, LEFT(CONVERT(VARCHAR(11), [t_ClosureDate], 113)+ ':' + CONVERT(VARCHAR, COUNT(*)),11)) DESC
			
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] 'DATA Coming in for YAHOO HISTORY SUB', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END

		IF @DEBUG = (1)
		SELECT * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		ORDER BY CONVERT(DATE, LEFT([MESSAGE_CONTENT], 11)) DESC

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1) PRINT 'U'

		SET @I_MSG_2500 = 'CREATE #DUPLICATES'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			SELECT * INTO #YAHOO_HISTORY_SUB
			FROM #ACTIVE_MAIN
	
			SELECT [ClosureDate], [SYMBOL]
			INTO #DUPLICATES
			FROM #YAHOO_HISTORY_SUB
			GROUP BY [ClosureDate], [SYMBOL]
			HAVING COUNT(*) > 1
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH
		
		IF @SEND_EMAIL = (1) AND (0) < (SELECT COUNT(*) FROM #DUPLICATES)
		BEGIN
			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT CONVERT(VARCHAR(11), [ClosureDate], 113)+ ':' + [SYMBOL]
			FROM #DUPLICATES
			GROUP BY CONVERT(VARCHAR(11), [ClosureDate], 113), [SYMBOL]
			
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] 'Duplicate entries', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		IF @DEBUG = (1)
		SELECT '#DUPLICATES in #YAHOO_HISTORY_SUB', * FROM #YAHOO_HISTORY_SUB WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #DUPLICATES)

		DROP TABLE #YAHOO_HISTORY_SUB

	IF @DEBUG = (1) PRINT 'V'

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		IF @DEBUG = (1)
		SELECT [SYMBOL], COUNT(*)
		FROM #ACTIVE_MAIN
		GROUP BY SYMBOL
		ORDER BY 2
	
		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1) PRINT 'W'
	
/*
	IF @DEBUG = (1) 
	BEGIN
		SELECT * INTO ALEX FROM #ACTIVE_MAIN
	END
*/
		SET @I_MSG_2500 = 'CREATE #ACTIVE_MAIN_FINAL_INSERT'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500

		BEGIN TRY
			SELECT DISTINCT [SYMBOL]
			, [ClosureDate]
			, [Open]
			, [High]
			, [Low]
			, [Close]
			, [AdjClose]
			, [Volume]
			-- NEW
			
			,CASE
				WHEN [MarketCap] LIKE '%N%A' THEN NULL
				WHEN [MarketCap] LIKE '%[0-9]%T%' THEN CONVERT(FLOAT, REPLACE([MarketCap],'T','')) * (1000) * (1000)
				WHEN [MarketCap] LIKE '%[0-9]%B%' THEN CONVERT(FLOAT, REPLACE([MarketCap],'B','')) * (1000)
				WHEN [MarketCap] LIKE '%[0-9]%M%' THEN CONVERT(FLOAT, REPLACE([MarketCap],'M','')) * (1)
				WHEN [MarketCap] LIKE '%[0-9]%K%' THEN CONVERT(FLOAT, REPLACE([MarketCap],'K','')) * (0.001)
				ELSE [MarketCap]
			 END AS [MarketCap] 
			, CASE WHEN [PERatio] LIKE '%N%A' THEN NULL ELSE [PERatio] END AS [PERatio]
			, CASE WHEN [EPS] LIKE '%N%A' THEN NULL ELSE [EPS] END AS [EPS]
			INTO #ACTIVE_MAIN_FINAL_INSERT -- DROP TABLE #ACTIVE_MAIN_FINAL_INSERT
			FROM #ACTIVE_MAIN A1
			WHERE NOT EXISTS (SELECT (1) FROM #DUPLICATES B1 WHERE [A1].[ClosureDate] = [B1].[ClosureDate] AND [A1].[SYMBOL] = [B1].[SYMBOL])
			AND ISNULL([Close],(0)) <> (0) -- FLUSHED OUT N\A earlier
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

	IF @DEBUG = (1) PRINT 'X'

		DROP TABLE #DUPLICATES

		IF @DEBUG = (1)
		SELECT TOP (25) '#ACTIVE_MAIN_FINAL_INSERT i', * FROM #ACTIVE_MAIN_FINAL_INSERT ORDER BY [ClosureDate] DESC

		/*
		SELECT *
		INTO ACTIVE_MAIN_FINAL_INSERT -- DROP TABLE ACTIVE_MAIN_FINAL_INSERT
		FROM #ACTIVE_MAIN_FINAL_INSERT
		*/

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		SELECT *
		INTO #MISSING_FROM_DIM_INVESTMENT
		FROM #ACTIVE_MAIN_FINAL_INSERT
		WHERE [SYMBOL] NOT IN (SELECT [LABEL] FROM #INVESTMENT_ALIAS)-- (SELECT [PRIMARY_LABEL] FROM [ALCHEMY_DATA].[DIM].[V_INVESTMENT])

		IF @SEND_EMAIL = (1) AND (0) < (SELECT COUNT(*) FROM #MISSING_FROM_DIM_INVESTMENT)
		BEGIN
			DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT DISTINCT [SYMBOL]
			FROM #MISSING_FROM_DIM_INVESTMENT
			
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] 'Symbols missing from DIM.v_INVESTMENT', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END

		IF @DEBUG = (1) SELECT '#MISSING_FROM_DIM_INVESTMENT', * FROM #MISSING_FROM_DIM_INVESTMENT

		DROP TABLE #MISSING_FROM_DIM_INVESTMENT

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		IF @DEBUG = (1)
		SELECT TOP (2500) '#ACTIVE_MAIN_FINAL_INSERT ii', * FROM #ACTIVE_MAIN_FINAL_INSERT A1
		WHERE NOT EXISTS (SELECT 1 FROM [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B1 -- [AZURE_R7_ALCHEMY_DATA].
							WHERE [A1].[SYMBOL] = [B1].[SYMBOL] AND [A1].[ClosureDate] = [B1].[ClosureDate])
		ORDER BY [ClosureDate] DESC, [MarketCap] DESC

		-- ===============================================================================================================================================================================================================
		-- REMOVE DETAILS WHERE DETAIL IS NOT AS GOOD
		-- ===============================================================================================================================================================================================================

		SET @I_MSG_2500 = 'DELETE [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] - R7LSE as source' -- [AZURE_R7_ALCHEMY_DATA].
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			DELETE [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] -- [AZURE_R7_ALCHEMY_DATA].
			FROM #ACTIVE_MAIN_FINAL_INSERT A1 JOIN [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B1
			ON REPLACE([A1].[SYMBOL],'.','') = REPLACE([B1].[SYMBOL],'.','') -- CRUDE TO HANDLE UU. and UU etc
			AND [A1].[ClosureDate] = [B1].[ClosureDate]
			WHERE [B1].[Stock Exchange] = 'R7LSE' AND [B1].[Days_High] IS NULL AND [B1].[Days_Low] IS NULL

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS DELETED [YAHOO_ONE_DAY_EXPORT] - R7LSE as source = '+CONVERT(VARCHAR(10),@v_ROWCOUNT) + ':' + @CSV_FILENAME
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		PRINT @I_MSG_2500

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		SET @I_MSG_2500 = 'DELETE [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] (IF PRICE DIFFERENCE)' -- [AZURE_R7_ALCHEMY_DATA].
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		/*		
		SELECT [A1].[SYMBOL] , [B1].[SYMBOL], [A1].[ClosureDate] , [B1].[ClosureDate], [A1].[Close], [B1].[Price]
			, CONVERT(DECIMAL(15,4), [A1].[Close]) , NULLIF(CONVERT(DECIMAL(15,4), [B1].[Price]), (0)) -- NOT BETWEEN (0.95) AND (1.05)
			FROM #ACTIVE_MAIN_FINAL_INSERT A1, [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B1
			WHERE [A1].[SYMBOL] = [B1].[SYMBOL] AND [A1].[ClosureDate] = [B1].[ClosureDate]
			AND CONVERT(DECIMAL(15,4), [A1].[Close]) <> NULLIF(CONVERT(DECIMAL(15,4), [B1].[Price]), (0)) -- NOT BETWEEN (0.95) AND (1.05)
			AND [A1].[Close] >= (0.01)
		*/

		-- select * from #ACTIVE_MAIN_FINAL_INSERT where SYMBOL like 'VRS%' order by ClosureDate DESC

		BEGIN TRY
			DELETE [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
			FROM #ACTIVE_MAIN_FINAL_INSERT A1, [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B1
			WHERE [A1].[SYMBOL] = [B1].[SYMBOL] AND [A1].[ClosureDate] = [B1].[ClosureDate]
			-- AND [A1].[Close] / NULLIF([B1].[Price], (0)) NOT BETWEEN (0.95) AND (1.05)
			AND CONVERT(DECIMAL(15,4), [A1].[Close]) <> NULLIF(CONVERT(DECIMAL(15,4), [B1].[Price]), (0)) -- NOT BETWEEN (0.95) AND (1.05)
			AND [A1].[Close] >= (0.01)
			-- AND [A1].[SYMBOL] = 'VRS'

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS DELETED [YAHOO_ONE_DAY_EXPORT]:' + @CSV_FILENAME + ' = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		PRINT @I_MSG_2500

		IF @v_ERR <> (0)
		BEGIN
			SET @I_MSG_2500 = 'Error has occured (DELETE [YAHOO_ONE_DAY_EXPORT])' + CONVERT(VARCHAR(10),@v_ERR)
				EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END

		IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED AND @SEND_EMAIL = (1) AND @BUILD_TYPE = 'F'
		BEGIN
			-- DECLARE @tSUBJ VARCHAR(250)
			SET @tSUBJ = 'Data loaded low? ([YAHOO_ONE_DAY_EXPORT]):EXPECTED:' + CONVERT(VARCHAR, @ROWS_IN_BATCH_EXPECTED) + ':ACTUAL:' + CONVERT(VARCHAR, @v_ROWCOUNT)
			SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded: ' + @CSV_FILENAME
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
		END

		-- ===============================================================================================================================================================================================================
		-- 
		-- ===============================================================================================================================================================================================================

		SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT]' -- [AZURE_R7_ALCHEMY_DATA].
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

		BEGIN TRY
			INSERT INTO
			[Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] -- [AZURE_R7_ALCHEMY_DATA].
			([Symbol], [ClosureDate], [OPEN_PRICE], [Days_Low], [Days_High], [Price]
			, [Volume], [Currency], [Stock Exchange], [DateLoaded]
			, [MarketCapitalization]
			, [P/E_Ratio]
			, [DividendPerShare]
			)

			SELECT [SYMBOL], [ClosureDate], [Open], [Low], [High], [Close]
			, [Volume], 'GBP', 'LSE', GETDATE()
			, [MarketCap]
			, [PERatio]
			, [EPS]

			FROM #ACTIVE_MAIN_FINAL_INSERT A1
			WHERE NOT EXISTS (SELECT 1 FROM [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B1 -- [AZURE_R7_ALCHEMY_DATA].
								WHERE [A1].[SYMBOL] = [B1].[SYMBOL] AND [A1].[ClosureDate] = [B1].[ClosureDate])

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END CATCH

		SET @I_MSG_2500 = 'ROWS INSERTED [YAHOO_ONE_DAY_EXPORT]:' + @CSV_FILENAME + ' = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		PRINT @I_MSG_2500

		IF @v_ERR <> (0)
		BEGIN
			SET @I_MSG_2500 = 'Error has occured (INSERT [YAHOO_ONE_DAY_EXPORT])' + CONVERT(VARCHAR(10),@v_ERR)
				EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			RETURN (255)
		END

		IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED AND @SEND_EMAIL = (1) AND @BUILD_TYPE = 'F'
		BEGIN
			-- DECLARE @tSUBJ VARCHAR(250)
			SET @tSUBJ = 'Data loaded low? ([YAHOO_ONE_DAY_EXPORT]):EXPECTED:' + CONVERT(VARCHAR, @ROWS_IN_BATCH_EXPECTED) + ':ACTUAL:' + CONVERT(VARCHAR, @v_ROWCOUNT)
			SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded: ' + @CSV_FILENAME
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
		END

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		IF @UPDATE_PRICE_ROWS = (1)
		BEGIN
			SET @I_MSG_2500 = 'UPDATE [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT]' -- [AZURE_R7_ALCHEMY_DATA].
			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

			BEGIN TRY
				SELECT [A1].[ClosureDate], [A1].[SYMBOL], [A1].[Close], [B1].[Price], [A1].[Low], [B1].[Days_Low], [A1].[High], [B1].[Days_High], [A1].[Open], [B1].[OPEN_PRICE]
				, [A1].[MarketCap], [A1].[PERatio], [A1].[EPS], [A1].[Volume]
				INTO #ACTIVE_MAIN_FINAL_UPDATE
				FROM #ACTIVE_MAIN_FINAL_INSERT A1, [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B1 -- [AZURE_R7_ALCHEMY_DATA].
				WHERE [A1].[ClosureDate] = [B1].[ClosureDate]
				AND [A1].[SYMBOL] = [B1].[SYMBOL]
				AND 
				(
				ABS([A1].[Close] - [B1].[Price]) >= (0.0025) -- circa Penny difference?
				OR ABS([A1].[Low] - [B1].[Days_Low]) >= (0.0025) -- circa Penny difference?
				OR ABS([A1].[High] - [B1].[Days_High]) >= (0.0025) -- circa Penny difference?
				OR ABS([A1].[Open] - [B1].[OPEN_PRICE]) >= (0.0025) -- circa Penny difference?
				)

				IF @DEBUG= (1)
				SELECT '#ACTIVE_MAIN_FINAL_UPDATE' , * FROM #ACTIVE_MAIN_FINAL_UPDATE

				UPDATE [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] -- [AZURE_R7_ALCHEMY_DATA].
				SET [OPEN_PRICE] = [A1].[Open]
				, [Days_Low] = [A1].[Low]
				, [Days_High] = [A1].[High]
				, [Price] = [A1].[Close]
				, [Volume] = [A1].[Volume]
				, [MarketCapitalization] = [A1].[MarketCap]
				, [P/E_Ratio] = [A1].[PERatio]
				, [DividendPerShare] = [A1].[EPS]
				-- , [DateUpdated] = GETDATE()
				FROM #ACTIVE_MAIN_FINAL_UPDATE A1, [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B1 -- [AZURE_R7_ALCHEMY_DATA].
				WHERE [A1].[ClosureDate] = [B1].[ClosureDate]
				AND [A1].[SYMBOL] = [B1].[SYMBOL]

				SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
			END TRY

			BEGIN CATCH
				EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
				RETURN (255)
			END CATCH

			-- SET @I_MSG_2500 = 'ROWS UPDATED [YAHOO_ONE_DAY_EXPORT] = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
			SET @I_MSG_2500 = 'ROWS UPDATED [YAHOO_ONE_DAY_EXPORT]:' + @CSV_FILENAME + ' = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
			EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		END

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		DROP TABLE #ACTIVE_MAIN_FINAL_INSERT
		DROP TABLE #ACTIVE_MAIN_FINAL_UPDATE

		-- ===============================================================================================================================================================================================================
		-- ===============================================================================================================================================================================================================

		DROP TABLE #SymbolsToProcess
	END
	ELSE
	BEGIN
		SET @I_MSG_2500 = '@ADD_PRICE_ROWS IS ZERO'
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'W:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	END

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		DROP TABLE #ACTIVE_MAIN_PREP
		DROP TABLE #ACTIVE_MAIN
		DROP TABLE #INVESTMENT_ALIAS
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS] (@BUILD_ID INT = 0, @BUILD_TYPE CHAR(1) = 'I') WITH RECOMPILE AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	Februray 2017
	-- Version History:
	-- 1.0		Initial Release (1.1 2016110 Moved to Azure)
	-- 1.1		20190213 Stop call to [AZURE_R7_ALCHEMY_DATA].
	-- 1.2		20190219 Change ].[STG].[v_HL to ].[XLS].[v_HL
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS]
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @I_MSG_2500 VARCHAR(2500), @NEWLINE CHAR(2), @I_MSG_2500_fn VARCHAR(2500)
	DECLARE @ALERT_DESC_SHORT VARCHAR(50), @ALERT_DESC_LONG VARCHAR(250), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
	SELECT @NEWLINE = CHAR(13) + CHAR(10)

	-- ===============================================================================================================================================================================================================
	-- 
	-- ===============================================================================================================================================================================================================

	SET @ALERT_DESC_SHORT = '01B: MISSING HlReference'
	SET @ALERT_DESC_LONG  = '01B: MISSING HlReference from v_SIPP_transaction_history entries'

	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @ALERT_DESC_LONG

	SET @I_MSG_2500 = 'INSERT [ALCHEMY_DATA].[BLD].[LOAD_ALERTS]'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @KEY_STAGE = 1

	BEGIN TRY
		INSERT [ALCHEMY_DATA].[BLD].[LOAD_ALERTS] ([BUILD_ID], [ENTRY_CATGY], [ENTRY_NOTES]) -- [AZURE_R7_ALCHEMY_DATA].
		SELECT DISTINCT @BUILD_ID, @ALERT_DESC_SHORT, -- SELECT
		'EAH:'+[Reference]+':'+[Description]
		FROM [Alchemy_Build].[XLS].[v_HL_EAH_SIPP]
		WHERE [Reference] NOT IN (SELECT ISNULL([HlReference],'')
								FROM [Alchemy_Data].[dbo].[v_sipp_transaction_history]) -- [AZURE_R7_ALCHEMY_DATA].
		UNION
		SELECT DISTINCT @BUILD_ID, @ALERT_DESC_SHORT, -- SELECT
		'KAH:'+[Reference]+':'+[Description]
		FROM [Alchemy_Build].[XLS].[v_HL_KAH_SIPP]
		WHERE [Reference] NOT IN (SELECT ISNULL([HlReference],'')
								FROM [Alchemy_Data].[dbo].[v_sipp_transaction_history]) -- [AZURE_R7_ALCHEMY_DATA].

	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	IF EXISTS (SELECT * FROM [ALCHEMY_DATA].[BLD].[v_MONITOR_BUILD_ALERTS] WHERE [ENTRY_CATGY] = @ALERT_DESC_SHORT) -- [AZURE_R7_ALCHEMY_DATA].
	BEGIN
		-- IF @SEND_ERROR_EMAIL = 1
		BEGIN
			SET @I_MSG_2500 = '['
			SELECT @I_MSG_2500 = COALESCE(@I_MSG_2500+ '], [','[') + 'EAH:'+[Reference]+':'+[Description] + @NEWLINE
			FROM [Alchemy_Build].[XLS].[v_HL_EAH_SIPP]
			WHERE [Reference] NOT IN (SELECT ISNULL([HlReference],'')
									FROM [Alchemy_Data].[dbo].[v_sipp_transaction_history]) -- [AZURE_R7_ALCHEMY_DATA].

			SELECT @I_MSG_2500 = COALESCE(@I_MSG_2500+ '], [','[') + 'KAH:'+[Reference]+':'+[Description] + @NEWLINE
			FROM [Alchemy_Build].[XLS].[v_HL_KAH_SIPP]
			WHERE [Reference] NOT IN (SELECT ISNULL([HlReference],'')
									FROM [Alchemy_Data].[dbo].[v_sipp_transaction_history]) -- [AZURE_R7_ALCHEMY_DATA].

			PRINT @I_MSG_2500
			SET @I_MSG_2500_fn =[Alchemy_Functions].[dbo].[fnHeaderAndFooterEmailCharacters](@I_MSG_2500)
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @ALERT_DESC_LONG, @i_body = @I_MSG_2500_fn
			PRINT @I_MSG_2500_fn
		END
	END

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES] (@BUILD_ID INT = 0
, @DEBUG INT = 0
, @ADD_FTSE_350 INT = 0 -- REPORTS TOO MESSY WITH THIS ON??
, @LABEL VARCHAR(25) = '%'
, @SEND_EMAIL INT = 1
, @BUILD_TYPE CHAR(1) = 'F')
AS
BEGIN
	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	-- 1.1		20190124 ADD @LABEL
	-- 1.2		20190130 Move functions to Alchemy_Functions
	-- 1.3		20190218 Change [STG].[v_TELEGRAPH_SECTOR] to [CSV].[v_TELEGRAPH_SECTOR]
	-- 1.4		20190219 Change [STG].[v_STOCK_EXCHANGE_INVESTMENT_INDICES]to [CSV].[v_STOCK_EXCHANGE_INVESTMENT_INDICES] and ... [CSV].[v_TELEGRAPH_SECTOR]
	-- 1.5		20190228 Added more @LABEL SARG to reduce size of datasets
	-- 1.5		20190528 Moved code into [BLD].[usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES]
	-- 1.6		20190819 Moved YAHOO_ONE_DAY_EXPORT
	-- 
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES] @SEND_EMAIL = 0, @DEBUG = 1, @LABEL = 'VRS'
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- ===============================================================================================================================================================================================================
	-- DECLARE VARIABLES
	-- ===============================================================================================================================================================================================================

	DECLARE @I_MSG_2500 VARCHAR(2500), @PARENT_USP VARCHAR(250), @v_count INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	DECLARE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	DECLARE @i INT
	
	-- ===============================================================================================================================================================================================================
	-- CHECK IDS
	-- 20190124 Moved away from variables for this as harder to debug ...
	-- ===============================================================================================================================================================================================================
	IF [Alchemy_Functions].[dbo].[fnGet_FTSE100_MARKET_ID]() IS NULL 
	OR [Alchemy_Functions].[dbo].[fnGet_FTSE250_MARKET_ID]() IS NULL 
	OR [Alchemy_Functions].[dbo].[fnGet_FTSE350_MARKET_ID]() IS NULL 
	OR [Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_100_MARKET_ID]() IS NULL 
	OR [Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_50_MARKET_ID]() IS NULL 
	OR [Alchemy_Functions].[dbo].[fnGet_FTSE_AllShare_MARKET_ID]() IS NULL
	OR [Alchemy_Functions].[dbo].[fnGet_FTSE_SmallCap_MARKET_ID]() IS NULL 
	OR [Alchemy_Functions].[dbo].[fnGet_FTSE_TechMark_MARKET_ID]() IS NULL 
	OR [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]() IS NULL
	BEGIN
		SET @I_MSG_2500 = 'UNABLE TO GET ID FOR FTSE 100, 250, or 350.. or other'
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500
	END

	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE100_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE250_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE350_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_50_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_100_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE_AllShare_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_AllShare_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE_SmallCap_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_NotKnown_MARKET_ID]()
	IF @DEBUG = 1 PRINT [Alchemy_Functions].[dbo].[fnGet_NotKnown_SECTOR_ID]()

	-- ===============================================================================================================================================================================================================
	-- BE SURE ## TABLES DO NOT EXISTS
	-- ===============================================================================================================================================================================================================

	IF EXISTS (SELECT 1 FROM tempdb.sys.objects WHERE NAME LIKE '%ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN%')
	DROP TABLE ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN
	IF EXISTS (SELECT 1 FROM tempdb.sys.objects WHERE NAME LIKE '%v_TELEGRAPH_SECTOR_FROM_CSV%')
	DROP TABLE ##v_TELEGRAPH_SECTOR_FROM_CSV
	-- IF EXISTS (SELECT 1 FROM tempdb.sys.objects WHERE NAME LIKE '%v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV%')
	-- DROP TABLE ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV
	IF EXISTS (SELECT 1 FROM tempdb.sys.objects WHERE NAME LIKE '%v_TELEGRAPH_SECTOR_MANUALLY_ADDED%')
	DROP TABLE ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED
	
	-- ===============================================================================================================================================================================================================
	-- SECTORS
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT * INTO #DIM_SECTORS'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT * INTO #DIM_SECTORS -- SELECT * 
		FROM [Alchemy_Data].[DIM].[SECTORS]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- INVESTMENT FILTER
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1) SELECT 'SL100', GETDATE()

	SET @I_MSG_2500 = 'SELECT * INTO #INVESTMENT_FILTER'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT [A1].[ID]
		INTO #INVESTMENT_FILTER
		FROM [Alchemy_Data].[DIM].[v_INVESTMENT] A1
		WHERE [A1].[PRIMARY_LABEL] LIKE @LABEL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1)
	SELECT '#INVESTMENT_FILTER', * FROM #INVESTMENT_FILTER

	IF @DEBUG = (1) SELECT 'SL101', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- CREATE COPY OF REPORT FILTER
	-- ISSUE IS SECTOR AND MARKET UNKNOWN e.g. VRS, I add to ## v_TELEGRAPH_SECTOR_MANUALLY_ADDED and this is added as a fledgling ... incorrect!
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT * INTO #INVESTMENT_SECTOR_REPORT_FILTER'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT * INTO #INVESTMENT_SECTOR_REPORT_FILTER
		FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL101 - B', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- CREATE #v_INVESTMENT_SECTOR_REPORT_FILTER
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT * INTO #v_INVESTMENT_SECTOR_REPORT_FILTER'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT [A1].*
		INTO #v_INVESTMENT_SECTOR_REPORT_FILTER -- SELECT * 
		FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] A1
		WHERE [A1].[LABEL] LIKE @LABEL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1)
	SELECT '#v_INVESTMENT_SECTOR_REPORT_FILTER', * FROM #v_INVESTMENT_SECTOR_REPORT_FILTER

	IF @DEBUG = (1) SELECT 'SL102', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- READ FROM THE VIEWS (CSV) (i)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT * INTO ##v_TELEGRAPH_SECTOR_FROM_CSV'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT [A1].[Sector], [A1].[EST_INVESTMENT_ID], [A1].[EST_INVESTMENT_ID_COUNT], [A1].[EPIC], [A1].[Name], [A1].[PRICE_GBP], [A1].[Market Cap], [A1].[DateOfExport]
		INTO ##v_TELEGRAPH_SECTOR_FROM_CSV -- select top 10 * from ##v_TELEGRAPH_SECTOR_FROM_CSV -- select * 
		FROM [CSV].[v_TELEGRAPH_SECTOR] A1
		WHERE [A1].[EST_INVESTMENT_ID_COUNT] = (1)
		AND [A1].[EPIC] LIKE @LABEL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'CREATE INDEX IDX_001 ##v_TELEGRAPH_SECTOR_FROM_CSV'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		CREATE INDEX IDX_001 ON ##v_TELEGRAPH_SECTOR_FROM_CSV (EST_INVESTMENT_ID)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL103:Look in ##v_TELEGRAPH_SECTOR_FROM_CSV', GETDATE()
	IF @DEBUG = (1)
	SELECT * FROM ##v_TELEGRAPH_SECTOR_FROM_CSV
	WHERE [EST_INVESTMENT_ID] IN (SELECT [ID] FROM #INVESTMENT_FILTER)
	ORDER BY [Sector]

	-- ===============================================================================================================================================================================================================
	-- READ FROM THE VIEWS (CSV) (ii)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES]'
	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES] @BUILD_ID = @BUILD_ID, @DEBUG = @DEBUG, @SEND_EMAIL = @SEND_EMAIL, @BUILD_TYPE = @BUILD_TYPE, @LABEL = @LABEL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- SOME INVESTMENTS NOT SHOWING IN TELEGRAPH [Sector] .. add them if they continue to be missing
	-- ===============================================================================================================================================================================================================

	CREATE TABLE ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED ([SECTOR] VARCHAR(100), [EPIC] VARCHAR(12))

	SET @I_MSG_2500 = 'INSERT INTO ##v_TELEGRAPH_SECTOR_FROM_CSV'
	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB_MANUAL] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @LABEL = @LABEL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1) SELECT 'SL0', GETDATE()

	SET @I_MSG_2500 = 'INSERT INTO ##v_TELEGRAPH_SECTOR_FROM_CSV'
	BEGIN TRY
		INSERT INTO ##v_TELEGRAPH_SECTOR_FROM_CSV ([Sector], [EST_INVESTMENT_ID], [EPIC], [Name])
		SELECT [A1].[SECTOR], [B1].[ID], [A1].[EPIC], [B1].[INVESTMENT_NAME]
		FROM ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED A1
		JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].[PRIMARY_LABEL]
		WHERE NOT EXISTS (SELECT 1 FROM ##v_TELEGRAPH_SECTOR_FROM_CSV WHERE [EST_INVESTMENT_ID] = [B1].[ID])
		AND [A1].[SECTOR] <> 'BLANK'
		AND [A1].[EPIC] LIKE @LABEL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	IF @DEBUG = (1)
	SELECT TOP 10 'DBG:##v_TELEGRAPH_SECTOR_FROM_CSV ', * FROM ##v_TELEGRAPH_SECTOR_FROM_CSV A1
	WHERE [A1].[EPIC] LIKE @LABEL

	-- ===============================================================================================================================================================================================================
	-- ADD FROM KNOWN [Sector] IF IT IS MISSING!!!
	/*
		STOP ADDING !!! - USE WHAT WE HAVE ALREADY
	*/
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED SELECT'
	BEGIN TRY
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED -- VALUES ('Leisure Goods', 'CDM')
		SELECT DISTINCT [B1].[SECTOR], [A1].[EPIC]
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV A1 -- GHI
		JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]
		WHERE [EST_INVESTMENT_ID] NOT IN (SELECT [EST_INVESTMENT_ID] FROM ##v_TELEGRAPH_SECTOR_FROM_CSV)
		AND [B1].[SECTOR] NOT LIKE '%NOT KNOWN%'
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	IF @DEBUG = (1) SELECT 'SL2: Update ##v_TELEGRAPH_SECTOR_FROM_CSV', GETDATE()
	IF @DEBUG = (1)
	SELECT TOP 10 'DBG:##v_TELEGRAPH_SECTOR_MANUALLY_ADDED', * FROM ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED A1
	WHERE [A1].[EPIC] LIKE @LABEL

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================

	UPDATE ##v_TELEGRAPH_SECTOR_FROM_CSV
	SET [SECTOR] = 'Household Goods & Construction'
	WHERE [SECTOR] = 'Household Goods & Home Construction'

	UPDATE ##v_TELEGRAPH_SECTOR_FROM_CSV
	SET [SECTOR] = 'Oil Equipment & Services'
	WHERE [SECTOR] = 'Oil Equipment; Services & Distribution'

	UPDATE ##v_TELEGRAPH_SECTOR_FROM_CSV
	SET [SECTOR] = 'Industrial Metals & Mining'
	WHERE [SECTOR] = 'Industrial Metals'

	IF @DEBUG = (1)
	SELECT * FROM ##v_TELEGRAPH_SECTOR_FROM_CSV A1
	WHERE [SECTOR] NOT IN (SELECT [SECTOR] FROM #DIM_SECTORS)

/*
-- ===============================================================================================================================================================================================================
	-- MAY NEED AN EMAIL REPORT HERE ...
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1) SELECT 'SL3:Maybe email alert', GETDATE()
	IF @DEBUG = (1)
	BEGIN
		SELECT DISTINCT [A1].[EST_INVESTMENT_ID], [A1].[EPIC], [A1].[Name]--, [A1].INDICES
		, ','+CONVERT(varchar, [EST_INVESTMENT_ID])
		,[B1].[SECTOR]
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV A1
		LEFT JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]
		WHERE [EST_INVESTMENT_ID] NOT IN (SELECT [EST_INVESTMENT_ID] FROM ##v_TELEGRAPH_SECTOR_FROM_CSV)
		ORDER BY [EPIC]
	END
*/

	-- ===============================================================================================================================================================================================================
	-- SOMETHING STILL AMISS? .. what is this 201902?
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT * INTO #v_TELEGRAPH_SECTOR_FROM_CSV_Q_AMISS'
	BEGIN TRY
		SELECT [Sector], [EST_INVESTMENT_ID], [EST_INVESTMENT_ID_COUNT], [EPIC], [Name], [PRICE_GBP], [Market Cap], [DateOfExport]
		INTO #v_TELEGRAPH_SECTOR_FROM_CSV_Q_AMISS -- DROP TABLE #v_TELEGRAPH_SECTOR_FROM_CSV_Q_AMISS -- SELECT *
		FROM [CSV].[v_TELEGRAPH_SECTOR] A1
		WHERE [EST_INVESTMENT_ID_COUNT] <> (1)
		AND [EPIC] NOT IN (SELECT [EPIC] FROM ##v_TELEGRAPH_SECTOR_FROM_CSV)
		AND [EPIC] NOT IN (SELECT [EPIC] FROM ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED)
		AND [A1].[EPIC] NOT IN ('BVA', 'BWO', 'BFA', 'CZB', 'COD', 'BG79', 'GEC', 'HWA', 'IE1G', 'IEVG', 'IEVH', 'MEL', 'QIL'
		, 'RBD', 'RPG', 'TDE', 'THL', 'TTA', 'TGL', 'TYT', '41OV','USY', 'ZCC' -- FTSE [Sector] / MARKET BLANK
		, 'HVE', 'BMR', 'HAWK', 'SEV', 'VIP', 'ALPH', '01KG', '44JV', '50BF', '50PF', '52PA', '57KO', '59KD', '82LO', '96IO'
		,'96IR', 'ACID', 'BC94', 'BD96', 'DP2D', 'MIK', 'OIH', 'SDUS')
		-- AND (3) = (4)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	IF @DEBUG = (1) SELECT 'SL4', GETDATE()

	IF EXISTS (SELECT (1) FROM #v_TELEGRAPH_SECTOR_FROM_CSV_Q_AMISS)
	BEGIN
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])

		SELECT '#v_TELEGRAPH_SECTOR_FROM_CSV_Q_AMISS:' + ISNULL([A1].[EPIC],'') + ':' + ISNULL([A1].[Name],'') + ':' + ISNULL([A1].[Sector],'')
		FROM #v_TELEGRAPH_SECTOR_FROM_CSV_Q_AMISS A1 -- LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].[PRIMARY_LABEL]
		LEFT JOIN [Alchemy_Stage_Data].[STG].[YAHOO_ONE_DAY_EXPORT] C1 ON [A1].[EPIC] = [C1].[Symbol]
		GROUP BY [A1].[EPIC], [A1].[Name], [A1].[SECTOR]
		HAVING MAX([C1].[ClosureDate]) > DATEADD(DD, -(30), GETDATE())
		ORDER BY MAX([C1].[ClosureDate]) DESC
			
		IF @SEND_EMAIL = (1)
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] '[ALCHEMY_BUILD]:Investment without a MARKET', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		ELSE
			SELECT 'Investment without A1 MARKET', * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	END

	-- ===============================================================================================================================================================================================================
	-- RECONCILE CSV
	-- ===============================================================================================================================================================================================================
	BEGIN
		SET @I_MSG_2500 = '[ALCHEMY_BUILD]:BLANK [EST_INVESTMENT_ID] IN ##v_TELEGRAPH_SECTOR_FROM_CSV'
		PRINT @I_MSG_2500

		SELECT 'ADD ME (1)' AS [TITLE], 'EXEC [ALCHEMY_DATA].[dbo].[usp_ADD_INVESTMENT] @BUILD_ID = 0,@INVESTMENT_NAME =  ''' + [A1].[Name] + ''', @LABEL = ''' + [A1].[EPIC]
		+ ''', @INVESTMENT_TYPE = ''Equity'', @SECTOR = ''%' + [A1].[Sector] +'%'',@MARKET = ''%ftse%small%cap%'''AS [CMD], [B1].[INDICES]
		INTO #ADD_INVESTMENTS_01 -- DROP TABLE #ADD_INVESTMENTS_01
		FROM #v_TELEGRAPH_SECTOR_FROM_CSV_Q_AMISS A1 -- ##v_TELEGRAPH_SECTOR_FROM_CSV A
		LEFT JOIN ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV B1 ON [A1].[EPIC] = [B1].[EPIC]
		WHERE [A1].[EST_INVESTMENT_ID] IS NULL
		ORDER BY [A1].[EPIC]

		IF EXISTS (SELECT (1) FROM #ADD_INVESTMENTS_01)
		BEGIN
			DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT '' + [A1].[CMD] -- + ':' + [A1].[Name] -- + ':' + [A1].[INDICES]
			FROM #ADD_INVESTMENTS_01 A1

			IF @SEND_EMAIL = (1)
				EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] @I_MSG_2500, @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
			ELSE
				SELECT @I_MSG_2500, * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END
	END

	IF @DEBUG = (1) SELECT 'SL6', GETDATE()

	BEGIN
		SET @I_MSG_2500 = '[ALCHEMY_BUILD]:BLANK [EST_INVESTMENT_ID] IN ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV'
		PRINT @I_MSG_2500

		SELECT 'ADD ME (2)' AS [Title], *
		INTO #ADD_INVESTMENTS_02 -- DROP TABLE #ADD_INVESTMENTS_02
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV
		WHERE [EST_INVESTMENT_ID] IS NULL
		ORDER BY [EPIC]

		IF EXISTS (SELECT (1) FROM #ADD_INVESTMENTS_02)
		BEGIN
			DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT 'ADD_ME_2:' + [A1].[EPIC] + ':' + [A1].[Name] + ':' + [A1].[INDICES]
			FROM #ADD_INVESTMENTS_02 A1

			IF @SEND_EMAIL = (1)
				EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] @I_MSG_2500, @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
			ELSE
				SELECT @I_MSG_2500, * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END
	END

	IF @DEBUG = (1) SELECT 'SL7', GETDATE()

	BEGIN
		SET @I_MSG_2500 = '[ALCHEMY_BUILD]:JOIN BLANK [EST_INVESTMENT_ID] IN ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV'
		PRINT @I_MSG_2500

		SELECT 'ADD ME (3)' AS [TITLE], [A1].[EPIC], [A1].[Name], [B1].[Sector], [A1].[Indices] -- , [A1].*, [B1].*
		INTO #ADD_INVESTMENTS_03 -- DROP TABLE #ADD_INVESTMENTS_03
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV A1, ##v_TELEGRAPH_SECTOR_FROM_CSV B1
		WHERE [A1].[EST_INVESTMENT_ID] IS NULL
		AND [A1].[EPIC] = [B1].[EPIC]

		IF EXISTS (SELECT (1) FROM #ADD_INVESTMENTS_03)
		BEGIN
			DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT 'ADD_ME_3:' + [A1].[EPIC] + ':' + [A1].[Name] + ':' + [A1].[INDICES]
			FROM #ADD_INVESTMENTS_03 A1

			IF @SEND_EMAIL = (1)
				EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] @I_MSG_2500, @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
			ELSE
				SELECT @I_MSG_2500, * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END
	END

/*
	IF @DEBUG = (1) SELECT 'SL8:[EST_INVESTMENT_ID] IS NULL', GETDATE()
	IF @DEBUG = (1)
	SELECT * FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV
	WHERE [EST_INVESTMENT_ID] IS NULL
*/

	-- ===============================================================================================================================================================================================================
	-- CHECK FOR MISSING INVESTMENTS (SECTOR)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #v_TELEGRAPH_SECTOR_FROM_CSV_MISSING_INVESTMENT'
	BEGIN TRY
		SELECT *
		INTO #v_TELEGRAPH_SECTOR_FROM_CSV_MISSING_INVESTMENT
		FROM ##v_TELEGRAPH_SECTOR_FROM_CSV
		WHERE [EST_INVESTMENT_ID] IS NULL
		AND [EPIC] NOT IN ('ACID', 'BPFU', '45HR', 'TAM', 'PPIR') -- Blank FTSE index on http://www.londonstockexchange.com
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL9:Missing Investments', GETDATE()

	IF @DEBUG = (1)
	SELECT 'MISSING INVESTMENT (INDICES)', * FROM #v_TELEGRAPH_SECTOR_FROM_CSV_MISSING_INVESTMENT ORDER BY [EPIC], [Sector]

	IF (0) < (SELECT COUNT(*) FROM #v_TELEGRAPH_SECTOR_FROM_CSV_MISSING_INVESTMENT)
	BEGIN TRY
		DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT DISTINCT [Name] + ':' + ISNULL([EPIC],'') + ':' + CONVERT(VARCHAR(10), ISNULL([EST_INVESTMENT_ID],0))
		FROM #v_TELEGRAPH_SECTOR_FROM_CSV_MISSING_INVESTMENT
		
		IF @SEND_EMAIL = (1)
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] '[ALCHEMY_BUILD]:Telegraph [Sector] with NULL investment ID', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		ELSE
			SELECT * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL10', GETDATE()

	IF EXISTS (SELECT * FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV B1 LEFT JOIN ##v_TELEGRAPH_SECTOR_FROM_CSV A1 ON [A1].[EPIC] = [B1].[EPIC] WHERE [A1].[EPIC] IS NULL)
	BEGIN
		DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT DISTINCT -- ISNULL([B1].[EPIC],'') + ':' + 
		[B1].[Name] 
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV B1 LEFT JOIN ##v_TELEGRAPH_SECTOR_FROM_CSV A1 ON [A1].[EPIC] = [B1].[EPIC] WHERE [A1].[EPIC] IS NULL
			
		IF @SEND_EMAIL = (1)
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] '[ALCHEMY_BUILD]:Investment without A1 [Sector]', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		ELSE
			SELECT 'Investment without A1 [Sector]', * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	END

	IF @DEBUG = (1) SELECT 'SL11', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- CHECK FOR MISSING INVESTMENTS (INDICES)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT'
	BEGIN TRY
		SELECT *
		INTO #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV
		WHERE [EST_INVESTMENT_ID] IS NULL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL12:MISSING INVESTMENT (INDICES)', GETDATE()
	IF @DEBUG = (1)
	SELECT 'MISSING INVESTMENT (INDICES)', * FROM #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT

	IF (0) < (SELECT COUNT(*) FROM #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT)
	BEGIN TRY
		DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY -- AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT DISTINCT [Name] + ':' + ISNULL([EPIC],'') + ':' + CONVERT(VARCHAR(10), ISNULL([EST_INVESTMENT_ID],0))
		FROM #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT
			
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] '[ALCHEMY_BUILD]:Indices with missing investments (ii) - ACTION - usp_ADD_INVESTMENT', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL13', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- DELETE REPORT FILTER
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'DELETE [MAP].[INVESTMENT_SECTOR_REPORT_FILTER]'
	BEGIN TRY
		DELETE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		WHERE MARKET_ID IN (
				ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE100_MARKET_ID](),0)
				, ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE250_MARKET_ID](),0)
				, ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE350_MARKET_ID](),0)
				, ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_100_MARKET_ID](),0)
				, ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_50_MARKET_ID](),0)
				-- , ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID](),0) -- 20181227 -- 20190110 MANY OF THESE HAVE AN UNKNOWN SECTOR!!!
				, ISNULL([Alchemy_Functions].[dbo].[fnGet_NotKnown_MARKET_ID](),0)
				, ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE_AllShare_MARKET_ID](),0)	 --[Alchemy_Functions].[dbo].[fnGet_FTSE_SmallCap_MARKET_ID]()			)
				, ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_AllShare_MARKET_ID](),0)	 --[Alchemy_Functions].[dbo].[fnGet_FTSE_SmallCap_MARKET_ID]()			)
				, ISNULL([Alchemy_Functions].[dbo].[fnGet_FTSE_SmallCap_MARKET_ID](),0))
		AND [INVESTMENT_ID] IN (SELECT [ID] FROM #INVESTMENT_FILTER)

		SET @I_MSG_2500 = '[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] (DELETE):' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500
		-- ELSE PRINT @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL14', GETDATE()


/*
-- ===============================================================================================================================================================================================================
	-- INDICES SUMMARY
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY -- AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT DISTINCT [INDICES] + ':' + CONVERT(VARCHAR(10), COUNT(*))
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV -- [EPIC]
		GROUP BY [INDICES]
			
		IF @SEND_EMAIL = (1)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] '[ALCHEMY_BUILD]:Indices Summary', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END
		ELSE PRINT @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL15', GETDATE()
*/

	-- ===============================================================================================================================================================================================================
	-- CREATE ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN
	-- ===============================================================================================================================================================================================================

	CREATE TABLE ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN ([EST_INVESTMENT_ID] INT, [SECTOR] VARCHAR(250), [SECTOR_ID] INT, [Indices] VARCHAR(250), [MARKET_ID] INT)

	-- ===============================================================================================================================================================================================================
	-- FTSE 100 - AAA
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: FTSE 100'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SET @i = [Alchemy_Functions].[dbo].[fnGet_FTSE100_MARKET_ID]()

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE ,@TITLE = 'FTSE100', @COUNT_MIN = 100, @COUNT_MAX = 101
		, @SEARCH_1 = 'FTSE100', @SEARCH_2 = 'FTSE 100', @MARKET_ID = @i, @DEBUG = @DEBUG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

/*
	-- NEEDED???? 20190321
	IF @DEBUG = (1) -- 20180711 NOT SURE THIS IS DODGY !!!
	IF EXISTS (SELECT [EST_INVESTMENT_ID] FROM ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN GROUP BY [EST_INVESTMENT_ID] HAVING COUNT(*) > 1)
	BEGIN
		SELECT 'DODGY', [A1].*
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV A1
		WHERE [A1].[EST_INVESTMENT_ID] IN (SELECT [EST_INVESTMENT_ID] FROM ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN GROUP BY [EST_INVESTMENT_ID] HAVING COUNT(*) > 1)
		AND [A1].[Indices] IN ('FTSE100', 'FTSE 100')
	END
*/

	-- ===============================================================================================================================================================================================================
	-- FTSE250
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: FTSE 250'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SET @i = [Alchemy_Functions].[dbo].[fnGet_FTSE250_MARKET_ID]()

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE ,@TITLE = 'FTSE250', @COUNT_MIN = 250, @COUNT_MAX = 251
		, @SEARCH_1 = 'FTSE250', @SEARCH_2 = 'FTSE 250', @MARKET_ID = @i, @DEBUG = @DEBUG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- FTSE 100, 250 (INVESTMENTS MISSING FROM [Sector] EXPORT)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT INTO #v_TELEGRAPH_SECTOR_FROM_CSV_WITHOUT_THIS_INVESTMENT'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT DISTINCT [B1].[EST_INVESTMENT_ID], [B1].[EPIC], [B1].[Name], [D].*
		 -- , [C1].*
		INTO #v_TELEGRAPH_SECTOR_FROM_CSV_WITHOUT_THIS_INVESTMENT -- DROP TABLE #v_TELEGRAPH_SECTOR_FROM_CSV_WITHOUT_THIS_INVESTMENT
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV B1
		LEFT JOIN ##v_TELEGRAPH_SECTOR_FROM_CSV C1 ON [C1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]
		JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] D ON [D].[INVESTMENT_ID] = [B1].EST_INVESTMENT_ID
		WHERE [C1].[SECTOR] IS NULL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL18', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- MISSING SECTOR DETAIL THAT NEEDS TO BE MANUALLY ADDED
	-- ===============================================================================================================================================================================================================

	IF  (0) < (SELECT COUNT(*) FROM #v_TELEGRAPH_SECTOR_FROM_CSV_WITHOUT_THIS_INVESTMENT)
	BEGIN TRY
		IF @SEND_EMAIL = (1)
		BEGIN
			DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

			INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
			SELECT DISTINCT [Name] + ':' + ISNULL([EPIC],'') -- , [EST_INVESTMENT_ID]
			FROM #v_TELEGRAPH_SECTOR_FROM_CSV_WITHOUT_THIS_INVESTMENT
			
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] '[ALCHEMY_BUILD]:Telegraph [Sector] does not have this investment (add row to ##v_TELEGRAPH_SECTOR_FROM_CSV OR ADD INVESTMENT)'
			, @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END
		ELSE
			SELECT 'MISSING', * FROM #v_TELEGRAPH_SECTOR_FROM_CSV_WITHOUT_THIS_INVESTMENT
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL19', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- FTSE 350
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: FTSE 350'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	IF @ADD_FTSE_350 = (1) -- SOMETIME TOO MUCH NOISE ON REPORTS WHEN YOU CAN CHOOSE 250 and 100
	BEGIN TRY
		SET @i = [Alchemy_Functions].[dbo].[fnGet_FTSE350_MARKET_ID]()

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE ,@TITLE = 'FTSE350', @COUNT_MIN = 350, @COUNT_MAX = 351
		, @SEARCH_1 = 'FTSE350', @SEARCH_2 = 'FTSE 350', @MARKET_ID = @i, @DEBUG = @DEBUG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- FTSE AIM_50
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: FTSE AIM 50'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SET @i = [Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_50_MARKET_ID]()

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE ,@TITLE = 'FTSE AIM 50', @COUNT_MIN = 50, @COUNT_MAX = 51
		, @SEARCH_1 = 'FTSE AIM 50', @SEARCH_2 = '', @MARKET_ID = @i, @DEBUG = @DEBUG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- FTSE AIM_100
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: FTSE AIM 100'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SET @i = [Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_100_MARKET_ID]()

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE ,@TITLE = 'FTSE AIM 100', @COUNT_MIN = 100, @COUNT_MAX = 101
		, @SEARCH_1 = 'FTSE AIM 100', @SEARCH_2 = '', @MARKET_ID = @i, @DEBUG = @DEBUG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- FTSE All-Share
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: FTSE All-Share'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SET @i = [Alchemy_Functions].[dbo].[fnGet_FTSE_AllShare_MARKET_ID]()

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE ,@TITLE = 'FTSE All-Share', @COUNT_MIN = 634, @COUNT_MAX = 632
		, @SEARCH_1 = 'FTSE All-Share', @SEARCH_2 = '', @MARKET_ID = @i, @DEBUG = @DEBUG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- FTSE SMALL CAP
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: FTSE Small Cap'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SET @i = [Alchemy_Functions].[dbo].[fnGet_FTSE_SmallCap_MARKET_ID]()

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE ,@TITLE = 'FTSE Small Cap', @COUNT_MIN = 283, @COUNT_MAX = 282
		, @SEARCH_1 = 'FTSE Small Cap', @SEARCH_2 = '', @MARKET_ID = @i, @DEBUG = @DEBUG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- FTSE AIM ALL SHARE -- 20181227
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: FTSE AIM All-Share'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SET @i = [Alchemy_Functions].[dbo].[fnGet_FTSE_AIM_AllShare_MARKET_ID]()

		EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE ,@TITLE = 'FTSE AIM All-Share', @COUNT_MIN = 0, @COUNT_MAX = 0
		, @SEARCH_1 = 'FTSE AIM All-Share', @SEARCH_2 = '', @MARKET_ID = @i, @DEBUG = @DEBUG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ADD TO DATA SET (BUILD FINAL SET
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL'

	BEGIN TRY
		SELECT [EST_INVESTMENT_ID], [SECTOR_ID], [MARKET_ID]
		INTO #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL
		FROM ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN A1
		WHERE NOT EXISTS (SELECT 1 FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] B1
						WHERE [A1].[EST_INVESTMENT_ID] = [B1].[INVESTMENT_ID]
						AND [A1].[SECTOR_ID] = [B1].[SECTOR_ID]
						AND [A1].[MARKET_ID] = [B1].[MARKET_ID]
						AND [B1].[ENABLED] = (1))
		AND [EST_INVESTMENT_ID] IS NOT NULL
		AND [SECTOR_ID] IS NOT NULL
		AND [MARKET_ID] IS NOT NULL

		SET @I_MSG_2500 = 'CREATE #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL INSERTED:' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1)
	SELECT TOP (100) '##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN', *
	FROM ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN
	WHERE [EST_INVESTMENT_ID] IN (SELECT [ID] FROM #INVESTMENT_FILTER)

	IF @DEBUG = (1)
	SELECT TOP (100) '#ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL', *
	FROM #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL
	WHERE [EST_INVESTMENT_ID] IN (SELECT [ID] FROM #INVESTMENT_FILTER)

	IF @DEBUG = (1) SELECT 'SL26', GETDATE()
	IF @DEBUG = (1) SELECT TOP 10 'DBG:#ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL', * FROM #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL

	-- ===============================================================================================================================================================================================================
	-- ADD TO DATA SET (BUILD FINAL SET
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]'

	BEGIN TRY
		INSERT INTO [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] ([INVESTMENT_ID], [SECTOR_ID], [MARKET_ID])
		SELECT DISTINCT [EST_INVESTMENT_ID], [SECTOR_ID], [MARKET_ID] -- DISTINCT ADDED 20180711
		FROM #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL
		WHERE [EST_INVESTMENT_ID] IN (SELECT [ID] FROM #INVESTMENT_FILTER)

		SET @I_MSG_2500 = '[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] INSERTED (i):' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1)
	SELECT 'NULL INVESTMENT_ID (ii)', [A1].*
	FROM ##v_TELEGRAPH_SECTOR_FROM_CSV A1 	WHERE [A1].[EST_INVESTMENT_ID] IS NULL ORDER BY [A1].[EPIC]

	IF @DEBUG = (1)
	SELECT 'NULL INVESTMENT_ID (iii)', [A1].*
	FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV A1 WHERE [A1].[EST_INVESTMENT_ID] IS NULL ORDER BY [A1].[EPIC]
	
	IF @DEBUG = (1)
	SELECT 'NULL [Sector]', * FROM ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN WHERE [SECTOR_ID] IS NULL

	IF @DEBUG = (1) SELECT 'SL27:Fledgling 1', GETDATE()
	IF @DEBUG = (1) SELECT TOP 10 * 
	FROM ##v_TELEGRAPH_SECTOR_FROM_CSV A1 -- ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN A1 -- #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL A
		WHERE [EST_INVESTMENT_ID] NOT IN (SELECT [INVESTMENT_ID] FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER]
											) -- WHERE [MARKET_ID] <> [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]()) -- IGNORE FLEDGLGIN AS NEW RECORD WILL BE BETTER !!

	-- ===============================================================================================================================================================================================================
	-- FTSE FLEDGLING ALTHOUGH THE SECTOR IS KNOWN ... OR ADDED MANUALLY
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO [MAP].[INVESTMENT_SECTOR_REPORT_FILTER] (FLEDGLING) i'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		INSERT INTO [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] ([INVESTMENT_ID], [SECTOR_ID], [MARKET_ID])
		SELECT [EST_INVESTMENT_ID], [Alchemy_Functions].[dbo].[fnGetSectorID]([Sector]), [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]() -- SELECT *
		FROM ##v_TELEGRAPH_SECTOR_FROM_CSV A1 -- ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN A1 -- #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL A
		WHERE [EST_INVESTMENT_ID] NOT IN (SELECT [INVESTMENT_ID] FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER]
											) -- WHERE [MARKET_ID] <> [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]()) -- IGNORE FLEDGLING AS NEW RECORD WILL BE BETTER !!
		AND [EST_INVESTMENT_ID] IN (SELECT [ID] FROM #INVESTMENT_FILTER)

		SET @I_MSG_2500 = '[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] INSERTED (ii):' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	SELECT 'AA'

	SELECT [EST_INVESTMENT_ID], [SECTOR_ID], [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]() -- SELECT *
	FROM ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN A1 -- #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL A

	SELECT 'AB'

	IF @DEBUG = (1) SELECT 'SL27:Fledgling 2', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- FTSE FLEDGLING (STRAGGLERS)
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO [MAP].[INVESTMENT_SECTOR_REPORT_FILTER] (FLEDGLING) ii'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		INSERT INTO [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] ([INVESTMENT_ID], [SECTOR_ID], [MARKET_ID])
		SELECT [ID], [Alchemy_Functions].[dbo].[fnGet_NotKnown_SECTOR_ID](), [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]() -- SELECT *
		FROM [Alchemy_Data].[DIM].[v_INVESTMENT] A
		WHERE [ID] NOT IN (SELECT [INVESTMENT_ID] FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER])
		AND [INVESTMENT_TYPE_NAME] IN ('Equity')
		AND [ID] IN (SELECT [ID] FROM #INVESTMENT_FILTER)

		SET @I_MSG_2500 = '[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] INSERTED (ii):' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL29', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- FTSE FLEDGLING - IF [MAP].[INVESTMENT_SECTOR_REPORT_FILTER] BEFORE USP STARTED HAD a better market than fledgling, then use it
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'UPDATE [MAP].[INVESTMENT_SECTOR_REPORT_FILTER] (FLEDGLING)'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		SET [MARKET_ID] = [B1].[MARKET_ID]
		FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] A1
		JOIN #INVESTMENT_SECTOR_REPORT_FILTER B1 ON [A1].[INVESTMENT_ID] = [B1].[INVESTMENT_ID] AND [A1].[SECTOR_ID] = [B1].[SECTOR_ID]
		WHERE [A1].[MARKET_ID] <> [B1].[MARKET_ID]
		AND [B1].[MARKET_ID] <> [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]()
		AND [A1].[MARKET_ID] = [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]()

		SET @I_MSG_2500 = '[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] UPDATED:' + CONVERT(VARCHAR, @@ROWCOUNT)
		EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- TIDY UP (i)
	-- ===============================================================================================================================================================================================================
	DROP TABLE ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN
	DROP TABLE ##v_TELEGRAPH_SECTOR_FROM_CSV
	DROP TABLE ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV
	DROP TABLE ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED

	DROP TABLE #DIM_SECTORS
	DROP TABLE #v_INVESTMENT_SECTOR_REPORT_FILTER
	DROP TABLE #INVESTMENT_SECTOR_REPORT_FILTER
	DROP TABLE #v_TELEGRAPH_SECTOR_FROM_CSV_MISSING_INVESTMENT
	DROP TABLE #v_TELEGRAPH_SECTOR_FROM_CSV_WITHOUT_THIS_INVESTMENT
	DROP TABLE #ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN_FINAL
	DROP TABLE #INVESTMENT_FILTER
	DROP TABLE #v_TELEGRAPH_SECTOR_FROM_CSV_Q_AMISS
	DROP TABLE #ADD_INVESTMENTS_01
	DROP TABLE #ADD_INVESTMENTS_02
	DROP TABLE #ADD_INVESTMENTS_03
	DROP TABLE #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT

	-- ===============================================================================================================================================================================================================
	-- IF SECTOR IS KNOW REMOVE "NOT KNOWN"
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'DELETE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]: REMOVE NOT KNOWN'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500
	
	BEGIN TRY
		DELETE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		FROM   [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] A1
		WHERE [SECTOR_ID] = (85) -- SECTOR = 'Not Known - Default - From Yahoo Import'
		AND EXISTS (SELECT (1) FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] A2 WHERE [A1].[INVESTMENT_ID] = [A2].[INVESTMENT_ID] and [A1].[SECTOR_ID] <> [A2].[SECTOR_ID])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- FINAL TIDY UP AS PRODUCTS CHANGE IA SECTOR
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT * INTO #TIDY_ME_BASE'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT [INVESTMENT_ID], [MARKET_ID]
		INTO #TIDY_ME_BASE
		FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER]
		WHERE [MARKET_ID] <> [Alchemy_Functions].[dbo].[fnGet_FTSE_Fledgling_MARKET_ID]() -- Manage these manually!!!
		GROUP BY [INVESTMENT_ID], [MARKET_ID]
		HAVING COUNT(*) > (1)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'SELECT * INTO #TIDY_ME'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT [A1].*
		INTO #TIDY_ME
		FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] A1 JOIN #TIDY_ME_BASE B1 ON [A1].[INVESTMENT_ID] = [B1].[INVESTMENT_ID] AND [A1].[MARKET_ID] = [B1].[MARKET_ID]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'SELECT * INTO #TIDY_ME_MIN'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT [INVESTMENT_ID], MIN([crDate]) AS [crDate]
		INTO #TIDY_ME_MIN
		FROM #TIDY_ME
		GROUP BY [INVESTMENT_ID]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	BEGIN TRAN

	SET @I_MSG_2500 = 'DELETE [MAP].[INVESTMENT_SECTOR_REPORT_FILTER]'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		DELETE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] A1 JOIN #TIDY_ME_MIN B1 ON [A1].[INVESTMENT_ID] = [B1].[INVESTMENT_ID] AND [A1].[crDate] = [B1].[crDate]
		-- 20190325 WHERE (1) = (2)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @@ROWCOUNT > (50)
	BEGIN
		SET @I_MSG_2500 = 'Too many deleted for thisd automated step - take a look'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		ROLLBACK
	END
	ELSE COMMIT

	-- ===============================================================================================================================================================================================================
	-- TIDY UP (ii)
	-- ===============================================================================================================================================================================================================

	DROP TABLE #TIDY_ME_BASE
	DROP TABLE #TIDY_ME
	DROP TABLE #TIDY_ME_MIN

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB] (@BUILD_ID INT = 0
, @DEBUG INT = 0
, @SEND_EMAIL INT = 1
, @BUILD_TYPE CHAR(1) = 'F'
, @TITLE VARCHAR(25) = 'FTSE350'
, @COUNT_MIN INT = 1
, @COUNT_MAX INT = 1
, @MARKET_ID INT = 0
, @SEARCH_1 VARCHAR(25) = ''
, @SEARCH_2 VARCHAR(25) = ''
) -- [Alchemy_Functions].[dbo].[fnGet_FTSE350_MARKET_ID]())
AS
BEGIN
	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	March 2019
	-- Version History:
	--
	-- 1.0		Initial Release
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- ===============================================================================================================================================================================================================
	-- DECLARE VARIABLES
	-- ===============================================================================================================================================================================================================

	DECLARE @I_MSG_2500 VARCHAR(2500), @PARENT_USP VARCHAR(250), @v_count INT, @i_subject VARCHAR(250)
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	DECLARE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

	-- ===============================================================================================================================================================================================================
	-- 
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN: ' + @TITLE
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN
		BEGIN TRY
			INSERT INTO ##ADD_INVESTMENTS_WHERE_MARKET_AND_SECTOR_KNOWN
			SELECT DISTINCT [A1].[EST_INVESTMENT_ID]
			, [A1].[SECTOR]
			, (SELECT [ID] FROM #DIM_SECTORS WHERE [SECTOR] = [A1].[SECTOR]) AS [SECTOR_ID]
			, [B1].[Indices]
			, @MARKET_ID AS [MARKET_ID]
			FROM ##v_TELEGRAPH_SECTOR_FROM_CSV A1, ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV B1
			WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]
			AND [B1].[Indices] IN (@SEARCH_1, @SEARCH_2)

			SET @v_count = @@ROWCOUNT
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
			-- EAH - RETURN (255)
		END CATCH

		IF @v_count < @COUNT_MIN
		BEGIN
			SET @i_subject = 'Data loaded low?' + CONVERT(VARCHAR, @v_count)
			IF @SEND_EMAIL = (1)
				EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @i_subject , @i_body = @I_MSG_2500
			ELSE PRINT @I_MSG_2500
		END
		ELSE PRINT @I_MSG_2500

		IF @v_count > @COUNT_MAX
		BEGIN
			SET @i_subject = 'Data loaded high?' + CONVERT(VARCHAR, @v_count)
			IF @SEND_EMAIL = (1)
				EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @i_subject, @i_body = @I_MSG_2500 -- (TELEGRAPH [Sector] 350)
			ELSE PRINT @I_MSG_2500
		END
		ELSE PRINT @I_MSG_2500
	END

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB_MANUAL]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES_SUB_MANUAL] (@BUILD_ID INT = 0
, @DEBUG INT = 0
, @LABEL VARCHAR(25) = '%'
, @BUILD_TYPE CHAR(1) = 'F')
AS
BEGIN
	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	March 2019
	-- Version History:
	--
	-- 1.0		Initial Release
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- ===============================================================================================================================================================================================================
	-- DECLARE VARIABLES
	-- ===============================================================================================================================================================================================================

	DECLARE @I_MSG_2500 VARCHAR(2500), @PARENT_USP VARCHAR(250), @v_count INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	DECLARE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	DECLARE @i INT
	
	-- ===============================================================================================================================================================================================================
	-- 
	-- ===============================================================================================================================================================================================================

	BEGIN
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Health Care Equipment & Services', 'CTEC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Tobacco', 'IMB')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Media', 'SKY')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'WPG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Industrial Transportation', 'RMG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Beverages', 'CCH')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'TUI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'PPB')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'AA.')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Mining', 'ACA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'MERL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'FERG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Banks', 'ALD')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil Equipment & Services', 'AMFW')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Media', 'ASCL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Media', 'AUTO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'BME')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'CARD')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Industrials', 'COA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Household Goods & Construction', 'CSP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Banks', 'CYBG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'DC.')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Industrial Metals & Mining', 'EVR')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'FDM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Nonlife Insurance', 'HSTG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Construction & Materials', 'IBST')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Pharmaceuticals & Biotechnology', 'INDV')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'IWG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'JLG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'JE.')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Life Insurance', 'JUST')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'KWE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'LCL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Household Goods & Construction', 'MCS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Banks', 'MTRO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'NXG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil & Gas Producers', 'NOG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'OSB')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'P2P')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'PAGE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'PAYS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'PSH')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'PETS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Construction & Materials', 'PLP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'TRIG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'RSE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'SAGA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'SNN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'SCT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'SOPH')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Health Care Equipment & Services', 'SPI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'SSPG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Banks', 'TBCG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'TCAP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'BBOX')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'VEIL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Banks', 'VM.')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'WIZZ')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'WPCT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'SLA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Personal Goods', 'CHOO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'EQN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Mining', 'GLEN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'SEQI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'ALFA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'RWI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'SYNC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'BCA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Industrial Engineering', 'RHIM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Automobiles & Parts', 'TIFS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Personal Goods', 'SDRY')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Food Producers', 'BAKK')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'CCFS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Leisure Goods', 'GAW')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'OTB')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Electricity', 'GLO')

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '32ID')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '34NF')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '39IS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '41JB')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '43KV')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '47KT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '50XD')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '56UB')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '63PE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '69IR')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '71FG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '71HN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '73CL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '85PL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '86CL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '86PB')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '86PN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '87QR')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '98KI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', '98LM')

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'AXBA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'BB56')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'BP.B')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'BPFU')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'CGVA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'EGMA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'FEDA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'GAIA')
		-- INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'HHPG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'HVTB')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'IAES')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'LTTG')

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'MEIP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'PESA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'SBXA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('BLANK', 'SUPA')

	-- FFS - so many to add

	IF @DEBUG = (1) SELECT 'SL106', GETDATE()

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'ACSO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'ADIG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'ALM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'ANII')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'AO.')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'APAX')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'APGN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'ARW')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'ASIT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'ASLI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'ATT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Mining', 'ATYM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'BBH')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'BIFF')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Pharmaceuticals & Biotechnology', 'BMK')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'BOO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Construction & Materials', 'BOOT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'BOWL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'BSIF')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'CAKE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Food Producers', 'CARR')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'CCPG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Fixed Line Telecommunications', 'CITY')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'CLG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Health Care Equipment & Services', 'CMBN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'CMCX')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'CNCT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'CREI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'DFS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'DIGS')

	IF @DEBUG = (1) SELECT 'SL106 - B', GETDATE()

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'DPEU')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Electronic & Electrical Equipment', 'DSCV')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'EGL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'EIG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'EPIC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Industrial Transportation', 'ESL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'ESP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Construction & Materials', 'FAN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Pharmaceuticals & Biotechnology', 'FARN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'FCIF')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Leisure Goods', 'FDEV')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'FEET')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Beverages', 'FEVR')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'FOOT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Construction & Materials', 'FORT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'FOXT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'FSFL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'GABC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'GABI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Mobile Telecommunications', 'GAMA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Health Care Equipment & Services', 'GHG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil Equipment & Services', 'GMS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Media', 'GOCO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'GROW')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'GRP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'GYM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'HAST')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'HMSF')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Food Producers', 'HOTC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'HSW')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil & Gas Producers', 'HUR')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Pharmaceuticals & Biotechnology', 'HZD')

	IF @DEBUG = (1) SELECT 'SL106 - C', GETDATE()

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'ICGT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'JGCI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'JLEN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'JOUL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'JPGI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'JUS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Electronic & Electrical Equipment', 'KETL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'KNOS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'KWS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Electronic & Electrical Equipment', 'LUCE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'LXI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'MAB1')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Fixed Line Telecommunications', 'MANX')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Food & Drug Retailers', 'MCLS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Health Care Equipment & Services', 'MGP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'MIDW')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'MOTR')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'NBPE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'NESF')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'OCI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'PAM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'PCFT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'PEYS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Leisure Goods', 'PHTM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'PLUS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'PRSM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Pharmaceuticals & Biotechnology', 'PRTC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Industrial Engineering', 'PRV')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'PSDL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'PURP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Technology Hardware & Equipment', 'QXT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'RDL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'RGL')

	IF @DEBUG = (1) SELECT 'SL106 - D', GETDATE()

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Nonlife Insurance', 'SBRE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'SCH')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'SERE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'SIR')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'SLPE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'SMIF')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'SMTG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'SQN')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'SQNX')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Beverages', 'STCK')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Media', 'TAP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'UAI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'VSL')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Household Goods & Construction', 'WJG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'XAF')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Media', 'XLM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Industrial Engineering', 'XSG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'YNGA')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil & Gas Producers', 'ENOG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'IHP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'QLT')

	IF @DEBUG = (1) SELECT 'SL107', GETDATE()
	
		-- 20180807
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'BGUK')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'CCJI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'CGEO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'JTC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'LOOP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'RAV')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Media', 'RCH')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'RESI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'RIV')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil & Gas Producers', 'SAVP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'SOHO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Leisure Goods', 'SUMO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'TEG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Leisure Goods', 'TUNE')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'USA')
		-- 20181020
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'AMGO')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'AVST')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('General Retailers', 'VVO')
		-- 20181107
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'BOKU')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Leisure Goods', 'CDM')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'PLUS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'EIG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'IHP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil & Gas Producers', 'ENOG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'QLT')
		-- FORCE THESE IN FOR NOW .. 20180711
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'PLUS')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'EIG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'IHP')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil & Gas Producers', 'ENOG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'QLT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'AA.')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil & Gas Producers', 'DGOC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Leisure Goods', 'TM17')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'ASAI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'HWG')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Travel & Leisure', 'JPJ')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'ASEI')

	IF @DEBUG = (1) SELECT 'SL108', GETDATE()

		-- 20181113
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('(Alc) Other', 'FCI') -- Not on stock exchange
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('(Alc) Other', 'FCS') -- Not on stock exchange
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('(Alc) Other', 'FPEO') -- Not on stock exchange
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('(Alc) Other', 'FRCL') -- Not on stock exchange
		-- INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('(Alc) Other', 'HHPG') -- Not on stock exchange
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'ASEI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'BCI')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'BGSC')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'BPET')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'FCIT')
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Mining', 'BHP')		-- 20181129

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Automobiles & Parts', 'AML')		-- 20181227
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'SSON')		-- 20181227
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'FCH')		-- 20181227
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity', 'TPOS')		-- 20181227
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Industrial Engineering', 'ABDP')		-- 20181227
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Media', 'DATA')		-- 20181227
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Support Services', 'AFM')		-- 20190120
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil & Gas Producers', 'AAOG')		-- 20190121
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'AFX')		-- 20190130

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Pharmaceuticals & Biotechnology', 'CIR') -- 20190210
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'SMTP') -- 20190226
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Chemicals', 'VRS') -- 20190313
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Financial Services', 'AJB') -- 20190321
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Health Care Equipment & Services', 'CREO') -- 20190321
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Software & Computer Services', 'APTD') -- 20190409

		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'RDI') -- 20190503
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Oil Equipment & Services', 'WG.') -- 20190503
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment & Services', 'SMP') -- 20190503
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity Investment Instruments', 'ATR') -- 20190503
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Household Goods & Home Construction', 'GLE') -- 20190503
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Equity Investment Instruments', 'LBOW') -- 20190503
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'CSH') -- 20190503
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Gas, Water & Multiutilities', 'UU.') -- 20190503
		INSERT INTO ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED VALUES ('Real Estate Investment Trusts', 'BREI') -- 20190503
	END

	-- ===============================================================================================================================================================================================================
	-- CHECKS ...
	-- ===============================================================================================================================================================================================================

	IF @DEBUG = (1) SELECT 'SL108 - A - List EPICS that no longer need to be forced', GETDATE()

	IF @DEBUG = (1) 
	BEGIN
		SELECT DISTINCT 'Not needed to be forced anymore', [Sector], [EPIC]
		FROM ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED
		WHERE [EPIC] IN (SELECT [EPIC] FROM ##v_TELEGRAPH_SECTOR_FROM_CSV)
		AND [SECTOR] <> 'BLANK'
	END

	IF @DEBUG = (1)
		SELECT 'DBG:##v_TELEGRAPH_SECTOR_MANUALLY_ADDED', [A1].[SECTOR], [B1].[ID], [A1].[EPIC], [B1].[INVESTMENT_NAME]
		FROM ##v_TELEGRAPH_SECTOR_MANUALLY_ADDED A1
		JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].[PRIMARY_LABEL]
		WHERE NOT EXISTS (SELECT 1 FROM ##v_TELEGRAPH_SECTOR_FROM_CSV WHERE [EST_INVESTMENT_ID] = [B1].[ID])
		AND [A1].[SECTOR] <> 'BLANK'
		AND [A1].[EPIC] LIKE @LABEL
		ORDER BY [A1].[EPIC] -- AAOG IS IN HERE !!!!

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES] (@BUILD_ID INT = 0
, @DEBUG INT = 0
, @LABEL VARCHAR(25) = '%'
, @SEND_EMAIL INT = 1
, @BUILD_TYPE CHAR(1) = 'F')
AS
BEGIN
	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	May 2019
	-- Version History:
	--
	-- 1.0		20190528 Created
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_STOCK_EXCHANGE_INVESTMENT_INDICES]
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- ===============================================================================================================================================================================================================
	-- DECLARE VARIABLES
	-- ===============================================================================================================================================================================================================

	DECLARE @I_MSG_2500 VARCHAR(2500), @PARENT_USP VARCHAR(250), @v_count INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	DECLARE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	DECLARE @i INT
	
	-- ===============================================================================================================================================================================================================
	-- START AFRESH
	-- ===============================================================================================================================================================================================================

	IF EXISTS (SELECT 1 FROM tempdb.sys.objects WHERE NAME LIKE '%v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV%')
	DROP TABLE ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV

	-- ===============================================================================================================================================================================================================
	-- READ FROM THE VIEWS (CSV) (ii)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'SELECT * INTO ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		SELECT [A1].[EST_INVESTMENT_ID]
		, [A1].[IndexName] AS [INDICES]
		, [A1].[Ticker] AS [EPIC]
		, [A1].[INVESTMENT NAME] AS [Name]
		INTO ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV -- SELECT *
		FROM [CSV].[v_STOCK_EXCHANGE_INVESTMENT_INDICES] A1
		WHERE [A1].[Ticker] LIKE @LABEL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL104:Create Index', GETDATE()

	SET @I_MSG_2500 = 'CREATE INDEX ON ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV'
	EXEC [Alchemy_Functions].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500

	BEGIN TRY
		CREATE INDEX IDX_001 ON ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV ([EST_INVESTMENT_ID])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL105', GETDATE()
	IF @DEBUG = (1)
	SELECT [Indices], COUNT(*) FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV GROUP BY [Indices]
	ORDER BY 2 DESC

	-- ===============================================================================================================================================================================================================
	-- MAY NEED AN EMAIL REPORT HERE ...
	-- ===============================================================================================================================================================================================================

/* May need ##v_TELEGRAPH_SECTOR_FROM_CSV
	IF @DEBUG = (1) SELECT 'SL3:Maybe email alert', GETDATE()
	IF @DEBUG = (1)
	BEGIN
		SELECT DISTINCT [A1].[EST_INVESTMENT_ID], [A1].[EPIC], [A1].[Name]--, [A1].INDICES
		, ','+CONVERT(varchar, [EST_INVESTMENT_ID])
		,[B1].[SECTOR]
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV A1
		LEFT JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]
		WHERE [EST_INVESTMENT_ID] NOT IN (SELECT [EST_INVESTMENT_ID] FROM ##v_TELEGRAPH_SECTOR_FROM_CSV)
		ORDER BY [EPIC]
	END


	IF @DEBUG = (1) SELECT 'SL8:[EST_INVESTMENT_ID] IS NULL', GETDATE()
	IF @DEBUG = (1)
	SELECT * FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV
	WHERE [EST_INVESTMENT_ID] IS NULL
*/
	-- ===============================================================================================================================================================================================================
	-- CHECK FOR MISSING INVESTMENTS (INDICES)
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT'
	BEGIN TRY
		SELECT *
		INTO #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV
		WHERE [EST_INVESTMENT_ID] IS NULL
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL12:MISSING INVESTMENT (INDICES)', GETDATE()
	IF @DEBUG = (1)
	SELECT 'MISSING INVESTMENT (INDICES)', * FROM #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT

	IF (0) < (SELECT COUNT(*) FROM #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT)
	BEGIN TRY
		DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY -- AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT DISTINCT [Name] + ':' + ISNULL([EPIC],'') + ':' + CONVERT(VARCHAR(10), ISNULL([EST_INVESTMENT_ID],0))
		FROM #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT
			
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] '[ALCHEMY_BUILD]:Indices with missing investments (ii) - ACTION - usp_ADD_INVESTMENT', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL13', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- INDICES SUMMARY
	-- ===============================================================================================================================================================================================================

	BEGIN TRY
		DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY -- AS dbo.EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT DISTINCT [INDICES] + ':' + CONVERT(VARCHAR(10), COUNT(*))
		FROM ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV -- [EPIC]
		GROUP BY [INDICES]
			
		IF @SEND_EMAIL = (1)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] '[ALCHEMY_BUILD]:Indices Summary', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		END
		ELSE PRINT @I_MSG_2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		-- EAH - RETURN (255)
	END CATCH

	IF @DEBUG = (1) SELECT 'SL15', GETDATE()

	-- ===============================================================================================================================================================================================================
	-- TIDY UP
	-- ===============================================================================================================================================================================================================
	-- DROP TABLE ##v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV -- needed for TELEGRAPH usp
	-- DROP TABLE #v_EST_INVESTMENT_ID_plus_EPIC_plus_INDICES_FROM_CSV_MISSING_INVESTMENT

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_YAHOO_STATISTICS]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_YAHOO_STATISTICS] (@BUILD_ID INT = 0, @ROWS_IN_BATCH_EXPECTED INT = 0, @BUILD_TYPE CHAR(1) = 'F', @DEBUG INT = 0) AS
BEGIN

	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2019
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20191203 Remove 'SELECT *'
	
	/*
	EXEC [BLD].[usp_BUILD_IMPORT_XLS_YAHOO_STATISTICS]  @DEBUG = 1
	SELECT TOP (2000) * FROM [Alchemy_Stage_Data].[STG].[YAHOO_FINANCE_STATISTICS]
	*/
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @I_MSG_2500 VARCHAR(2500), @I_MESSAGE_5000 VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		SELECT CONVERT(DATE, CONVERT(VARCHAR, GETDATE(), 103)) AS [DateOfImport],
		[INVESTMENT_ID],
		[TICKER],
		[Name],
		[Name2],
		[Date Of Export],
		[MarketCapMillion],
		[EnterpriseValueMillion],
		[TrailingPE],
		[ForwardPE],
		[PEGRatio5YrExpected],
		[PriceOverSale],
		[PriceOverBook],
		[EnterpriseValueOverRevenue],
		[EnterpriseValueOverEBITDA],
		[FiscalYearEnds],
		[MostRecentQuarter],
		[ProfitMarginPCT],
		[OperatingMarginPCT],
		[ReturnOnAssetsPCT],
		[ReturnOnEquityPCT],
		[RevenueMillion],
		[RevenuePerShare],
		[QuarterlyRevenueGrowthPCT_Yoy],
		[GrossProfitMillion],
		[EBITDAMillion],
		[NetIncomeAviToCommonMillion],
		[DilutedEPS],
		[QuarterlyEarningsGrowthPCT_Yoy],
		[TotalCashMillion],
		[TotalCashPerShare],
		[TotalDebtMillion],
		[TotalDebtOverEquity],
		[CurrentRatio],
		[BookValuePerShare],
		[OperatingCashFlowMillion],
		[LeveredFreeCashFlowMillion],
		[Beta3YMonthly],
		[52WeekChange],
		[SandP52WeekChange],
		[52WeekHigh],
		[52WeekLow],
		[50DayMovingAverage],
		[200DayMovingAverage],
		[AvgVol3MonthMillion],
		[AvgVol10dayMillion],
		[SharesOutstandingMillion],
		[SharesFloat],
		[PCTHeldByInsiders],
		[PCTHeldByInstitutions],
		[SharesShort],
		[ForwardAnnualDividendRate],
		[ForwardAnnualDividendYieldPCT],
		[TrailingAnnualDividendRate],
		[TrailingAnnualDividendYieldPCT],
		[5YearAverageDividendYield],
		[PayoutRatio],
		[DividendDate],
		[ExDividendDate],
		[LastSplitFactorNewPerOld],
		[LastSplitDate] -- [date]
		INTO #ACTIVE -- SELECT REPLACE([Market Cap], 'N/A',0), *
		FROM [CSV].[v_YAHOO_FINANCE_STATISTICS] A1

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	IF @DEBUG = (1) PRINT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	-- STG
	-- ===============================================================================================================================================================================================================
	SET @I_MSG_2500 = 'DELETE [STG].[YAHOO_STATISTICS_DETAIL]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		DELETE [Alchemy_Stage_Data].[STG].[YAHOO_FINANCE_STATISTICS]
		FROM [Alchemy_Stage_Data].[STG].[YAHOO_FINANCE_STATISTICS] B1
		WHERE EXISTS (SELECT 1 FROM #ACTIVE A1 WHERE [A1].[Date Of Export] = [B1].[Date Of Export] AND [A1].[Ticker] = [B1].[Ticker])

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS DELETED (YAHOO_STATISTICS)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	IF @DEBUG = (1) SELECT @I_MSG_2500

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'INSERT INTO [Alchemy_Stage_Data].[STG].[YAHOO_FINANCE_STATISTICS]'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
	-- ELSE PRINT @I_MSG_2500

	BEGIN TRY
		IF @DEBUG = (1)
		BEGIN
			SELECT *
			FROM #ACTIVE A1
			-- WHERE [TICKER] = 'ARBB'
		END

		INSERT INTO [Alchemy_Stage_Data].[STG].[YAHOO_FINANCE_STATISTICS] ([DateOfImport],
		[INVESTMENT_ID],
		[TICKER],
		[Name],
		[Name2],
		[Date Of Export],
		[MarketCapMillion],
		[EnterpriseValueMillion],
		[TrailingPE],
		[ForwardPE],
		[PEGRatio5YrExpected],
		[PriceOverSale],
		[PriceOverBook],
		[EnterpriseValueOverRevenue],
		[EnterpriseValueOverEBITDA],
		[FiscalYearEnds],
		[MostRecentQuarter],
		[ProfitMarginPCT],
		[OperatingMarginPCT],
		[ReturnOnAssetsPCT],
		[ReturnOnEquityPCT],
		[RevenueMillion],
		[RevenuePerShare],
		[QuarterlyRevenueGrowthPCT_Yoy],
		[GrossProfitMillion],
		[EBITDAMillion],
		[NetIncomeAviToCommonMillion],
		[DilutedEPS],
		[QuarterlyEarningsGrowthPCT_Yoy],
		[TotalCashMillion],
		[TotalCashPerShare],
		[TotalDebtMillion],
		[TotalDebtOverEquity],
		[CurrentRatio],
		[BookValuePerShare],
		[OperatingCashFlowMillion],
		[LeveredFreeCashFlowMillion],
		[Beta3YMonthly],
		[52WeekChange],
		[SandP52WeekChange],
		[52WeekHigh],
		[52WeekLow],
		[50DayMovingAverage],
		[200DayMovingAverage],
		[AvgVol3MonthMillion],
		[AvgVol10dayMillion],
		[SharesOutstandingMillion],
		[SharesFloat],
		[PCTHeldByInsiders],
		[PCTHeldByInstitutions],
		[SharesShort],
		[ForwardAnnualDividendRate],
		[ForwardAnnualDividendYieldPCT],
		[TrailingAnnualDividendRate],
		[TrailingAnnualDividendYieldPCT],
		[5YearAverageDividendYield],
		[PayoutRatio],
		[DividendDate],
		[ExDividendDate],
		[LastSplitFactorNewPerOld],
		[LastSplitDate])

		SELECT [DateOfImport],
		[INVESTMENT_ID],
		[TICKER],
		[Name],
		[Name2],
		[Date Of Export],
		[MarketCapMillion],
		[EnterpriseValueMillion],
		[TrailingPE],
		[ForwardPE],
		[PEGRatio5YrExpected],
		[PriceOverSale],
		[PriceOverBook],
		[EnterpriseValueOverRevenue],
		[EnterpriseValueOverEBITDA],
		[FiscalYearEnds],
		[MostRecentQuarter],
		[ProfitMarginPCT],
		[OperatingMarginPCT],
		[ReturnOnAssetsPCT],
		[ReturnOnEquityPCT],
		[RevenueMillion],
		[RevenuePerShare],
		[QuarterlyRevenueGrowthPCT_Yoy],
		[GrossProfitMillion],
		[EBITDAMillion],
		[NetIncomeAviToCommonMillion],
		[DilutedEPS],
		[QuarterlyEarningsGrowthPCT_Yoy],
		[TotalCashMillion],
		[TotalCashPerShare],
		[TotalDebtMillion],
		[TotalDebtOverEquity],
		[CurrentRatio],
		[BookValuePerShare],
		[OperatingCashFlowMillion],
		[LeveredFreeCashFlowMillion],
		[Beta3YMonthly],
		[52WeekChange],
		[SandP52WeekChange],
		[52WeekHigh],
		[52WeekLow],
		[50DayMovingAverage],
		[200DayMovingAverage],
		[AvgVol3MonthMillion],
		[AvgVol10dayMillion],
		[SharesOutstandingMillion],
		[SharesFloat],
		[PCTHeldByInsiders],
		[PCTHeldByInstitutions],
		[SharesShort],
		[ForwardAnnualDividendRate],
		[ForwardAnnualDividendYieldPCT],
		[TrailingAnnualDividendRate],
		[TrailingAnnualDividendYieldPCT],
		[5YearAverageDividendYield],
		[PayoutRatio],
		[DividendDate],
		[ExDividendDate],
		[LastSplitFactorNewPerOld],
		[LastSplitDate]
		FROM #ACTIVE A1

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	SET @I_MSG_2500 = 'ROWS INSERTED (YAHOO_STATISTICS) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	IF @DEBUG = (1) PRINT @I_MSG_2500

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (YAHOO_STATISTICS)' --  1 email!!
		SET @I_MSG_2500 = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @tSUBJ, @i_body = @i_msg_2500
	END

	-- ===============================================================================================================================================================================================================
	-- ===============================================================================================================================================================================================================

	DROP TABLE #ACTIVE

	-- ===============================================================================================================================================================================================================
	--
	-- ===============================================================================================================================================================================================================

	SET @I_MSG_2500 = 'THE END'
	EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE

	-- ===============================================================================================================================================================================================================
	-- THE END
	-- ===============================================================================================================================================================================================================

	RETURN (0)
END
GO
/****** Object:  StoredProcedure [BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] (@i_subject VARCHAR(250)
, @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY READONLY
, @NUMBER_OF_NEW_LINES INT = NULL, @SendTo VARCHAR(250) = NULL, @SEND_EMAIL INT = 1, @DEBUG INT = 0)
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

	IF @SendTo IS NULL SET @SendTo = 'eahind@yahoo.co.uk'
	IF @SEND_EMAIL = (1)
	BEGIN
		IF @DEBUG = (1) PRINT 'Output: EMAIL'
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_EMAIL] @i_subject = @i_subject, @i_body = @FULL_MESSAGE, @SendTo = @SendTo
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
/****** Object:  StoredProcedure [BLD].[usp_UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV]
(@BUILD_ID INT = 0, @BUILD_TYPE CHAR(1) = 'I', @DEBUG INT = 0) WITH RECOMPILE AS
BEGIN
	-- ===============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2019
	-- Version History:
	-- 1.0		Initial Release
	--
	-- EXEC [BLD].[usp_UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV] @DEBUG = 1
	-- ===============================================================================================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- =============================================================================================================================================================================================
	-- INITIALISE @BUILD_ID
	-- =============================================================================================================================================================================================

	EXEC @BUILD_ID = [Alchemy_Functions].[BLD].[fnSetBuildID] @BUILD_ID = @BUILD_ID

	-- =============================================================================================================================================================================================
	-- 
	-- =============================================================================================================================================================================================

	DECLARE @I_MSG_2500 VARCHAR(2500), @NEWLINE CHAR(2), @I_MSG_2500_fn VARCHAR(2500)
	DECLARE @ALERT_DESC_SHORT VARCHAR(50), @ALERT_DESC_LONG VARCHAR(250), @PARENT_USP VARCHAR(250)
	DECLARE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY AS [dbo].[EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY]
	-- SELECT * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN'); EXEC [Alchemy_Functions].[BLD].[usp_AUDIT_USE_OF_USP] @PARENT_USP = @PARENT_USP, @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE
	SELECT @NEWLINE = CHAR(13) + CHAR(10)

	SET @I_MSG_2500 = 'CREATE #T1_CORE'

	-- ===============================================================================================================================================================================================================
	-- CREATE ROOT TABLE
	-- ===============================================================================================================================================================================================================
	BEGIN TRY
		SELECT [A1].[EST_INVESTMENT_ID]
		, [A1].[IndexName] AS [INDICES]
		, [A1].[Ticker] AS [EPIC]
		, [A1].[INVESTMENT NAME] AS [Name]
		, (1) AS [ENABLED]
		INTO #T1_CORE -- DROP TABLE #T1_CORE
		FROM [CSV].[v_STOCK_EXCHANGE_INVESTMENT_INDICES] A1
	END TRY

	BEGIN CATCH
		-- EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE,  @HEADER = @I_MSG_2500
		RETURN (255)
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- REPORT ON ROOT TABLE
	-- ===============================================================================================================================================================================================================
	BEGIN TRY
		SET @I_MSG_2500 = 'REPORT ON #T1_CORE'
		SELECT 'Aim for this:' + [INDICES], COUNT(*)
		FROM #T1_CORE
		WHERE INDICES <> 'FTSE 350'
		GROUP BY [INDICES]
		ORDER BY 2 DESC
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END CATCH

	-- ===============================================================================================================================================================================================================
	-- ELIMINATE DUPLICATE INDICES e.g. joint member of FTSE AIM 100 and FTSE AIM 50
	-- ===============================================================================================================================================================================================================
	BEGIN TRY
		SET @I_MSG_2500 = 'UPDATE #T1_CORE'

		UPDATE #T1_CORE
		SET [ENABLED] = (0)
		WHERE [ENABLED] = (1) AND [INDICES] = 'FTSE 350'

		UPDATE #T1_CORE
		SET [ENABLED] = (0)
		FROM #T1_CORE A1
		WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE AIM 100'
		AND EXISTS (SELECT 1 FROM #T1_CORE B1 WHERE [B1].[INDICES] = 'FTSE AIM 50' AND [A1].[EPIC] = [B1].[EPIC])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END CATCH

/*
IF (1) = (2)
SELECT [EPIC] FROM #T1_CORE
WHERE [INDICES] NOT IN ('FTSE All-Share', 'FTSE 350') -- If equity is in FTSE250 then it is also in FTSE350, same for AIM50 and AIM100
AND [ENABLED] = (1)
GROUP BY [EPIC]
HAVING COUNT(*) > (1)
*/

	-- ===============================================================================================================================================================================================================
	-- NEED TO AMEND MARKET FOR THESE - SRC IS CSV
	-- ===============================================================================================================================================================================================================
	BEGIN TRY
		SET @I_MSG_2500 = 'CREATE #AMEND_ME_100_SRC_CSV'

		SELECT [A1].[EPIC], [A1].[Name], 'FTSE100' AS [MARKET], [B1].[ID]
		INTO #AMEND_ME_100_SRC_CSV
		FROM #T1_CORE A1
		LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].[PRIMARY_LABEL]
		WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE 100'
		AND NOT EXISTS (SELECT 1 FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
					WHERE [MARKET_NAME] LIKE 'FTSE100%' AND [A1].[EPIC] = [B1].[LABEL])
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Functions].[BLD].[fn_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID = @BUILD_ID, @PARENT_USP = @PARENT_USP, @PRE_HEADER = 'I:', @HEADER = @I_MSG_2500, @BUILD_TYPE = @BUILD_TYPE
		-- ELSE PRINT @I_MSG_2500
	END CATCH

	SELECT [A1].[EPIC], [A1].[Name], 'FTSE250' AS [MARKET], [B1].[ID]
	INTO #AMEND_ME_250_SRC_CSV
	FROM #T1_CORE A1
	LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].	[PRIMARY_LABEL]
	WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE 250'
	AND NOT EXISTS (SELECT 1 FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
					WHERE [MARKET_NAME] LIKE 'FTSE250%' AND [A1].[EPIC] = [B1].[LABEL])

	SELECT [A1].[EPIC], [A1].[Name], 'FTSE AIM100' AS [MARKET], [B1].[ID]
	INTO #AMEND_ME_AIM_100_SRC_CSV -- DROP TABLE #AMEND_ME_AIM_100_SRC_CSV
	FROM #T1_CORE A1
	LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].[PRIMARY_LABEL]
	WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE AIM 100'
	AND NOT EXISTS (SELECT 1 FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
					WHERE [MARKET_NAME] LIKE 'FTSE%AIM%100%' AND [A1].[EPIC] = [B1].[LABEL])

	SELECT [A1].[EPIC], [A1].[Name], 'FTSE AIM50' AS [MARKET], [B1].[ID]
	INTO #AMEND_ME_AIM_50_SRC_CSV -- DROP TABLE #AMEND_ME_AIM_50_SRC_CSV
	FROM #T1_CORE A1
	LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].[PRIMARY_LABEL]
	WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE AIM 50'
	AND NOT EXISTS (SELECT 1 FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
					WHERE [MARKET_NAME] LIKE 'FTSE%AIM%50%' AND [A1].[EPIC] = [B1].[LABEL])

	SELECT [A1].[EPIC], [A1].[Name], 'FTSE Small Cap' AS [MARKET], [B1].[ID]
	INTO #AMEND_ME_SmallCap_SRC_CSV
	FROM #T1_CORE A1
	LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].[PRIMARY_LABEL]
	WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE Small Cap'
	AND NOT EXISTS (SELECT 1 FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
					WHERE [MARKET_NAME] LIKE 'FTSE%Small%Cap%' AND [A1].[EPIC] = [B1].[LABEL])

	SELECT [A1].[EPIC], [A1].[Name], 'FTSE All-Share' AS [MARKET], [B1].[ID]
	INTO #AMEND_ME_All_Share_SRC_CSV -- DROP TABLE #AMEND_ME_All-Share_50_SRC_CSV
	FROM #T1_CORE A1
	LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[EPIC] = [B1].[PRIMARY_LABEL]
	WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE All-Share'
	AND NOT EXISTS (SELECT 1 FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
					WHERE [MARKET_NAME] LIKE 'FTSE%All%Share%' AND [A1].[EPIC] = [B1].[LABEL])

	SELECT B1.*
	INTO #AMEND_ME_100_DST_MAP
	FROM #AMEND_ME_100_SRC_CSV A1
	JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]
	AND [MARKET_NAME] NOT IN ('FTSE All Share (Equities)', 'FTSE techMARK All-Share (Equities)')

	SELECT B1.*
	INTO #AMEND_ME_250_DST_MAP
	FROM #AMEND_ME_250_SRC_CSV A1
	JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]
	AND [MARKET_NAME] NOT IN ('FTSE All Share (Equities)', 'FTSE techMARK All-Share (Equities)', 'FTSE Fledgling (Equities) ZZ', 'FTSE techMARK Focus (Equities)') -- , 'FTSE Small Cap (Equities)'

	IF @DEBUG = (1)
	SELECT * FROM #AMEND_ME_250_DST_MAP

	SELECT B1.*
	INTO #AMEND_ME_AIM_100_DST_MAP
	FROM #AMEND_ME_AIM_100_SRC_CSV A1
	JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]
	AND [MARKET_NAME] NOT IN ('FTSE All Share (Equities)', 'FTSE techMARK All-Share (Equities)')

	SELECT B1.*
	INTO #AMEND_ME_AIM_50_DST_MAP
	FROM #AMEND_ME_AIM_50_SRC_CSV A1
	JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]
	AND [MARKET_NAME] NOT IN ('FTSE All Share (Equities)', 'FTSE techMARK All-Share (Equities)')

	SELECT B1.*
	INTO #AMEND_ME_SmallCap_DST_MAP
	FROM #AMEND_ME_SmallCap_SRC_CSV A1
	JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]
	AND [MARKET_NAME] NOT IN ('FTSE All Share (Equities)', 'FTSE techMARK All-Share (Equities)', 'FTSE Fledgling (Equities)', 'FTSE techMARK Focus (Equities)') -- , 'FTSE Small Cap (Equities)'

	SELECT B1.*
	INTO #AMEND_ME_All_Share_DST_MAP
	FROM #AMEND_ME_All_Share_SRC_CSV A1
	JOIN [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1 ON [A1].[EPIC] = [B1].[LABEL]

/*
IF (1) = (2) -- QUICK FIX
BEGIN
	UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
	SET [MARKET_ID] = (11) WHERE [ENABLED] = (1) AND [INVESTMENT_ID] IN (12490, 65506) AND [MARKET_ID] IN (20, 22) -- , 10553, 4205, 10507)
END
*/

	SELECT *
	INTO #AMEND_ME_SmallCap_DST_MAP_OTHER
	FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER]
	WHERE [LABEL] IN (SELECT [EPIC] FROM #AMEND_ME_250_SRC_CSV)
	AND [MARKET_NAME] = 'FTSE Small Cap (Equities)'

	-- ==============================================================================================================================
	-- NEED TO AMEND MARKET FOR THESE - SRC IS MAP
	-- ==============================================================================================================================
	SELECT [LABEL], [INVESTMENT_Name], 'FTSE100' AS [MARKET]
	INTO #AMEND_ME_100_SRC_MAP
	FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
	WHERE [MARKET_NAME] LIKE 'FTSE100%'
	AND NOT EXISTS (SELECT 1 FROM #T1_CORE A1
					WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE 100' AND [A1].[EPIC] = [B1].[LABEL])

	SELECT [LABEL], [INVESTMENT_Name], 'FTSE250' AS [MARKET]
	INTO #AMEND_ME_250_SRC_MAP
	FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
	WHERE [MARKET_NAME] LIKE 'FTSE250%'
	AND NOT EXISTS (SELECT 1 FROM #T1_CORE A1
					WHERE [A1].[ENABLED] = (1) AND [A1].[INDICES] = 'FTSE 250' AND [A1].[EPIC] = [B1].[LABEL])

/*
IF (1) = (2)
BEGIN
	SELECT * FROM #AMEND_ME_250_SRC_MAP -- DROP TABLE #AMEND_ME_250_SRC_MAP
	-- SAGA, FCPT, HFD, KIE, MLC, INDV, 888, EFM, STOB, CSH, JUST
	SELECT * FROM #T1_CORE WHERE [EPIC] = 'PPB'
	SELECT * FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] WHERE [LABEL] IN ('ACA','DCG','BTG','BTEM','JLT','RPC')
	SELECT * FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] WHERE [LABEL] IN ('FCPT','Saga','HFD','KIE','MLC','INDV', '888','EFM','STOB','CSH','JUST')
	SELECT * FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] WHERE [INVESTMENT_ID] = 39599

	UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
	SET [ENABLED] = (0) WHERE [ENABLED] = (1) AND [INVESTMENT_ID] IN (2386, 2484, 2623, 3303, 3814, 4708) -- 39599

	UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] SET [MARKET_ID] = (11)
	WHERE [ENABLED] = (1) AND [INVESTMENT_ID] IN (2494, 4021, 4678, 4690, 4693, 5407, 10374, 10540, 10567, 50382, 52045)
	AND [MARKET_ID] = (4)
END
*/

/*
IF (1) = (2) -- Small Cap -- CRUDE FIX
BEGIN
	SELECT * FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] WHERE [LABEL] IN ('XPP', 'DIA', 'RCDO', 'NCC', 'JUS', 'HAST', 'SDL', 'BVC', 'ASEI')
	AND [MARKET_NAME] <> 'FTSE techMARK All-Share (Equities)'

	UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] SET [MARKET_ID] = (11)
	WHERE [ENABLED] = (1) AND [INVESTMENT_ID] IN (10366, 10457, 10467, 10502, 10506, 10517, 10522)
	AND [MARKET_ID] IN (21, 37)
END
*/
	IF @DEBUG = (1)
		SELECT DISTINCT [INVESTMENT_ID], [SECTOR_ID], (7)
		FROM #AMEND_ME_All_Share_DST_MAP -- ORDER BY [Investment_Name]

	-- IF (1) = (2) -- QUICK FIX due to missing All Share sector
	BEGIN
		INSERT INTO [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] ([INVESTMENT_ID], [SECTOR_ID], [MARKET_ID])
		SELECT DISTINCT [INVESTMENT_ID], [SECTOR_ID], (7)
		FROM #AMEND_ME_All_Share_DST_MAP -- ORDER BY [Investment_Name]
	END

	IF EXISTS (SELECT 1 FROM #AMEND_ME_SmallCap_SRC_CSV)
	SELECT '#AMEND_ME_SmallCap_SRC_CSV', *
	, 'SELECT * FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] WHERE [LABEL] = ''' + [EPIC] + ''''
	FROM #AMEND_ME_SmallCap_SRC_CSV

/*
-- UPDATE [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] SET MARKET_ID = (11) WHERE MARKET_ID = (37) AND INVESTMENT_ID IN (50349, 65314, 65509)
*/

	DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

	BEGIN TRY
		-- ==============================================================================================================================
		-- Report differences
		-- ==============================================================================================================================
		-- 	DECLARE @NEWLINE CHAR(2) = CHAR(13) + CHAR(5)

		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_100_SRC_CSV)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_100_SRC_CSV' + ':' + [EPIC] -- select *
		FROM #AMEND_ME_100_SRC_CSV
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_100_DST_MAP)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_100_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_100_DST_MAP

		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_100_SRC_CSV)
		-- FFS
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_250_SRC_CSV' + ':' + [EPIC] -- select *
		FROM #AMEND_ME_250_SRC_CSV
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_250_DST_MAP)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_250_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_250_DST_MAP

		/*
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_250_SRC_CSV)
		-- INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_250_SRC_CSV' + ':' + [EPIC] FROM #AMEND_ME_250_SRC_CSV
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_250_DST_MAP)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_250_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_250_DST_MAP
		*/

		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_100_SRC_CSV)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_AIM_100_SRC_CSV' + ':' + [EPIC] -- select *
		FROM #AMEND_ME_AIM_100_SRC_CSV
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_AIM_100_DST_MAP)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_AIM_100_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_AIM_100_DST_MAP

/*
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_AIM_100_SRC_CSV)
		-- DOH INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_AIM_100_SRC_CSV' + ':' + [EPIC] FROM #AMEND_ME_AIM_100_SRC_CSV
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_AIM_100_DST_MAP)
		-- DOH INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_AIM_100_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_AIM_100_DST_MAP
*/

		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_50_SRC_CSV)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_AIM_50_SRC_CSV' + ':' + [EPIC] -- select *
		FROM #AMEND_ME_AIM_50_SRC_CSV
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_AIM_50_DST_MAP)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_AIM_50_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_AIM_50_DST_MAP

/*
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_AIM_50_SRC_CSV WHERE [EPIC] <> 'IPX')
		-- DOH INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_AIM_50_SRC_CSV' + ':' + [EPIC] FROM #AMEND_ME_AIM_50_SRC_CSV WHERE [EPIC] <> 'IPX' -- this is in AIM 50 and 100
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_AIM_50_DST_MAP WHERE [LABEL] <> 'IPX')
		-- DOH INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_AIM_50_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_AIM_50_DST_MAP WHERE [LABEL] <> 'IPX' -- this is in AIM 50 and 100
*/

		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_50_SRC_CSV)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_ALL_Share_SRC_CSV' + ':' + [EPIC] -- select *
		FROM #AMEND_ME_ALL_Share_SRC_CSV
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_ALL_Share_DST_MAP)
		INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_ALL_Share_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_ALL_Share_DST_MAP

/*
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_All_Share_SRC_CSV)
		-- DOH INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_All_Share_SRC_CSV' + ':' + [EPIC] FROM #AMEND_ME_All_Share_SRC_CSV ORDER BY [Name]
		-- IF EXISTS (SELECT 1 FROM #AMEND_ME_All_Share_DST_MAP)
		-- DOH INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		SELECT '#AMEND_ME_All_Share_DST_MAP' + ':' + [LABEL] FROM #AMEND_ME_All_Share_DST_MAP ORDER BY [Investment_Name]
*/
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		PRINT 'ERROR'
		SELECT 'ERROR'
	END CATCH

	IF EXISTS (SELECT * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY)
	BEGIN
		SELECT * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
		-- IF @EMAIL_REPORT = (1)
		EXEC [BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES] @i_subject = 'AMEND - usp_UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV'
		, @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY = @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
	END

-- ==============================================================================================================================
-- GET IDs
-- ==============================================================================================================================
IF (1) = (2) -- GET ID
BEGIN
	SELECT * FROM  [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] LIKE 'FTSE100%' -- 1

	SELECT * FROM  [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] LIKE 'FTSE250%' -- 4

	SELECT * FROM  [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] LIKE 'FTSE%Small%Cap%' -- 11

	SELECT * FROM  [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] LIKE 'FTSE%AIM%100%' -- 12

	SELECT * FROM  [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] LIKE 'FTSE%AIM%50%' -- 18

	SELECT * FROM  [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] LIKE 'FTSE%All Shar%' -- 7

	SELECT * FROM  [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] LIKE '%tech%' -- FTSE techMARK All-Share (Equities) -- 22

	SELECT * FROM  [Alchemy_Data].[DIM].[MARKET]
	WHERE [MARKET_NAME] LIKE 'FTSE%Fledg%' -- 37
END

-- ==============================================================================================================================
-- FIX to FTSE100 (was 250, now 100)
-- ==============================================================================================================================
	BEGIN TRAN
	UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
	SET MARKET_ID = (1) -- FTSE100
	FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] A1
	JOIN #AMEND_ME_100_DST_MAP B1 ON [A1].[INVESTMENT_ID] = [B1].[INVESTMENT_ID] AND [A1].[MARKET_ID] = (4) -- ASSUME 250
	IF @@ROWCOUNT <= (5) COMMIT ELSE
	BEGIN
		PRINT 'ROLLBACK'
		ROLLBACK
	END

	-- ==============================================================================================================================
	-- FIX to FTSE250 (was 100, now 250)
	-- ==============================================================================================================================
	BEGIN TRAN
	UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
	SET MARKET_ID = (4) -- FTSE250
	FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] A1
	JOIN #AMEND_ME_250_DST_MAP B1 ON [A1].[INVESTMENT_ID] = [B1].[INVESTMENT_ID] AND [A1].[MARKET_ID] = (1) -- ASSUME 100
	IF @@ROWCOUNT <= (5) COMMIT ELSE
	BEGIN
		PRINT 'ROLLBACK'
		ROLLBACK
	END

-- ==============================================================================================================================
-- FIX to FTSE250 (was SmallCap, now 250)
-- ==============================================================================================================================
	BEGIN TRAN
	UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
	SET MARKET_ID = (4) -- FTSE250
	FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] A1
	JOIN #AMEND_ME_SmallCap_DST_MAP_OTHER B1 ON [A1].[INVESTMENT_ID] = [B1].[INVESTMENT_ID] AND [A1].[MARKET_ID] = (11) -- SmallCap
	IF @@ROWCOUNT <= (10) COMMIT ELSE
	BEGIN
		PRINT 'ROLLBACK'
		ROLLBACK
	END

	BEGIN
		BEGIN TRAN
		UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		SET MARKET_ID = (18) -- AIM 50
		WHERE [ENABLED] = (1) AND [INVESTMENT_ID] IN (SELECT [ID] FROM #AMEND_ME_AIM_50_SRC_CSV) -- 20190926 -- (12511)
		AND [MARKET_ID] = (12) -- FTSE AIM 100 (Equities)
		IF @@ROWCOUNT <= (10) COMMIT ELSE
		BEGIN
			PRINT 'ROLLBACK'
			ROLLBACK
		END
	END

	BEGIN
		BEGIN TRAN
		UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		SET MARKET_ID = (12) -- AIM 100
		WHERE [ENABLED] = (1) AND [INVESTMENT_ID] IN (SELECT [ID] FROM #AMEND_ME_AIM_100_SRC_CSV) -- 20190926 -- (12511)
		AND [MARKET_ID] = (37) -- FTSE Fledgling (Equities)
		IF @@ROWCOUNT <= (10) COMMIT ELSE
		BEGIN
			PRINT 'ROLLBACK'
			ROLLBACK
		END
	END

	BEGIN
		BEGIN TRAN
		UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		SET MARKET_ID = (11) -- SmallCap
		WHERE [ENABLED] = (1) AND [INVESTMENT_ID] IN (SELECT [ID] FROM #AMEND_ME_SmallCap_SRC_CSV) -- #AMEND_ME_AIM_50_SRC_CSV) -- 20190926 -- (12511)
		AND [MARKET_ID] IN (4) -- FTSE250
		IF @@ROWCOUNT <= (10) COMMIT ELSE
		BEGIN
			PRINT 'ROLLBACK'
			ROLLBACK
		END

	/*
	Cannot insert duplicate key row in object 'MAP.INVESTMENT_SECTOR_REPORT_FILTER' with unique index 'pk_001'. The duplicate key value is (3842, 81, 11, 1).
	SELECT * FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] WHERE [INVESTMENT_ID]  IN (3842, 4683, 5576) -- duplicates
	SELECT * FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] WHERE [INVESTMENT_ID]  IN (3842, 4683, 5576) -- duplicates
	*/
	END

	SELECT 'Actual:' + [MARKET_NAME], COUNT(*)
	FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER]
	WHERE [MARKET_NAME] LIKE 'FTSE%'
	AND [MARKET_NAME] NOT IN ('FTSE Fledgling (Equities)', 'FTSE techMARK All-Share (Equities)', 'FTSE techMARK Focus (Equities)', 'FTSE AIM All-Share (Equities)')
	GROUP BY [MARKET_NAME]
	ORDER BY 2 DESC

	-- ==============================================================================================================================
	-- FINAL RECONCILIATION
	-- ==============================================================================================================================
	SELECT [EPIC], [Name], 
	CASE [INDICES]
	WHEN 'FTSE Small Cap' THEN 'FTSESmallCap'
	WHEN 'FTSE All-Share' THEN 'FTSEAllShare'
	WHEN 'FTSE 250' THEN 'FTSE250'
	WHEN 'FTSE AIM 100' THEN 'FTSEAIM100'
	WHEN 'FTSE 100' THEN 'FTSE100'
	WHEN 'FTSE AIM 50' THEN 'FTSEAIM50'
	END AS [MARKET]
	INTO #RECON_SMALL_CAP_CSV
	FROM #T1_CORE A1

	SELECT [LABEL], [INVESTMENT_NAME],
	CASE [MARKET_NAME] 
	WHEN 'FTSE Small Cap (Equities)' THEN 'FTSESmallCap'
	WHEN 'FTSE All Share (Equities)' THEN 'FTSEAllShare'
	WHEN 'FTSE250 (Equities)' THEN 'FTSE250'
	WHEN 'FTSE AIM 100 (Equities)' THEN 'FTSEAIM100'
	WHEN 'FTSE100 (Equities)' THEN 'FTSE100'
	WHEN 'FTSE AIM UK 50 (Equities)' THEN 'FTSEAIM50'
	ELSE [MARKET_NAME]
	END AS [MARKET]
	INTO #RECON_SMALL_CAP_MAP -- DROP TABLE #RECON_SMALL_CAP_MAP
	FROM [Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B1
	WHERE [MARKET_NAME] LIKE 'FTSE%'
	AND [MARKET_NAME] NOT IN ('FTSE Fledgling (Equities)')

/*
IF (2) = (3)
SELECT * FROM #RECON_SMALL_CAP_CSV A1
WHERE NOT EXISTS (SELECT 1 FROM #RECON_SMALL_CAP_MAP B1 WHERE [A1].[EPIC] = [B1].[LABEL])
*/

	DELETE @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY

	BEGIN TRY
		-- -- DOH INSERT INTO @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY ([MESSAGE_CONTENT])
		-- 	DECLARE @NEWLINE CHAR(2) = CHAR(13) + CHAR(5)
		SELECT 'Final RECON', B1.*, D1.ID, D1.[Ceased Trading Confirmed], C1.*
		FROM #RECON_SMALL_CAP_MAP B1
		LEFT JOIN #T1_CORE C1 ON [B1].[LABEL] = [C1].[EPIC]
		LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] D1 on [D1].[PRIMARY_LABEL] = [B1].[LABEL]
		WHERE NOT EXISTS (SELECT 1 FROM #RECON_SMALL_CAP_CSV A1 WHERE [A1].[EPIC] = [B1].[LABEL])
		AND [B1].[MARKET] NOT LIKE '%all%shar%'
		AND [D1].[Ceased Trading Confirmed] <> (1)
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		EXEC [Alchemy_Functions].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID = @BUILD_ID, @BUILD_TYPE = @BUILD_TYPE, @HEADER = @I_MSG_2500
		PRINT 'ERROR'
		SELECT 'ERROR'
	END CATCH

	-- DROP TABLE #SENTIMENT_OWNED

/*
	IF EXISTS (SELECT * FROM @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY)
	EXEC [Alchemy_Data].[BLD].[usp_STANDARD_EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY] 'usp_UPDATE_FTSE_SECTOR_FROM_STOCK_EXCHANGE_INVESTMENT_SECTOR_CSV', @EMAIL_TABLE_OF_MESSAGES_WITH_IDENTITY
*/

/*
IF (1) = (2)
UPDATE [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] SET ENABLED = (0), crNotes = '20190924 Ceased Trading Confirmed'
-- SELECT *
FROM [Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] A1
JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] D1 ON [D1].[ID] = [A1].[INVESTMENT_ID]
WHERE [D1].[Ceased Trading Confirmed] = (1)
AND [A1].[ENABLED] = (1)
AND [D1].[INVESTMENT_TYPE_NAME] = 'Equity'
*/

	-- ==============================================================================================================================
	-- Tidy up
	-- ==============================================================================================================================
	DROP TABLE #AMEND_ME_100_SRC_CSV
	DROP TABLE #AMEND_ME_100_DST_MAP
	DROP TABLE #AMEND_ME_250_SRC_CSV
	DROP TABLE #AMEND_ME_250_DST_MAP
	DROP TABLE #AMEND_ME_SmallCap_DST_MAP_OTHER

	DROP TABLE #AMEND_ME_AIM_100_SRC_CSV
	DROP TABLE #AMEND_ME_AIM_100_DST_MAP

	DROP TABLE #AMEND_ME_AIM_50_SRC_CSV
	DROP TABLE #AMEND_ME_AIM_50_DST_MAP

	DROP TABLE #AMEND_ME_All_Share_SRC_CSV
	DROP TABLE #AMEND_ME_All_Share_DST_MAP

	DROP TABLE #AMEND_ME_100_SRC_MAP
	DROP TABLE #AMEND_ME_250_SRC_MAP
	DROP TABLE #AMEND_ME_SmallCap_SRC_CSV
	DROP TABLE #AMEND_ME_SmallCap_DST_MAP

	DROP TABLE #RECON_SMALL_CAP_CSV
	DROP TABLE #RECON_SMALL_CAP_MAP
	DROP TABLE #T1_CORE
END
GO
/****** Object:  StoredProcedure [dbo].[usp_FIND_OBJECTNAME]    Script Date: 16/02/2021 10:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_FIND_OBJECTNAME] (@C VARCHAR(200))
AS
BEGIN
	SELECT DISTINCT SCHEMA_NAME([SO].[schema_id]), OBJECT_NAME([SC].[ID]), [SO].[type_desc], [SO].[modify_date]
	FROM syscomments SC
	JOIN sys.objects SO ON [SC].[id] = [SO].[object_id]
	WHERE [text] LIKE @C
	ORDER BY 4 DESC, 2 ASC
END
GO
USE [master]
GO
ALTER DATABASE [Alchemy_Build] SET  READ_WRITE 
GO
