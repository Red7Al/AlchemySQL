USE [master]
GO
/****** Object:  Database [Alchemy_Stage_Data]    Script Date: 16/02/2021 10:30:03 ******/
CREATE DATABASE [Alchemy_Stage_Data]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Alchemy_Stage_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Stage_Data.mdf' , SIZE = 10166272KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Alchemy_Stage_Data_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Stage_Data_log.ldf' , SIZE = 1384448KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Alchemy_Stage_Data] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Alchemy_Stage_Data].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Alchemy_Stage_Data] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET ARITHABORT OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET  MULTI_USER 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Alchemy_Stage_Data] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Alchemy_Stage_Data] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Alchemy_Stage_Data', N'ON'
GO
ALTER DATABASE [Alchemy_Stage_Data] SET QUERY_STORE = OFF
GO
USE [Alchemy_Stage_Data]
GO
/****** Object:  Schema [BLD]    Script Date: 16/02/2021 10:30:03 ******/
CREATE SCHEMA [BLD]
GO
/****** Object:  Schema [CFG]    Script Date: 16/02/2021 10:30:03 ******/
CREATE SCHEMA [CFG]
GO
/****** Object:  Schema [STG]    Script Date: 16/02/2021 10:30:03 ******/
CREATE SCHEMA [STG]
GO
/****** Object:  Table [STG].[DIRECTOR]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[DIRECTOR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EPIC] [varchar](10) NOT NULL,
	[DIRECTOR] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [STG].[DIRECTOR_DEALS]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[DIRECTOR_DEALS](
	[Declared] [date] NOT NULL,
	[Dealt] [date] NOT NULL,
	[TransactionType] [varchar](10) NOT NULL,
	[Epic] [varchar](10) NOT NULL,
	[Company] [varchar](75) NULL,
	[Director_ID] [int] NOT NULL,
	[Position] [nvarchar](255) NULL,
	[Shares] [int] NOT NULL,
	[Price_GBP] [float] NOT NULL,
	[Value_GBP] [float] NOT NULL,
	[CurrentPrice_GBP] [float] NOT NULL,
	[% Gain] [float] NULL,
	[Gain_GBP] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [STG].[DIRECTOR_DEALS_RUNNING_TOTAL]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[DIRECTOR_DEALS_RUNNING_TOTAL](
	[DIRECTOR_ID] [int] NULL,
	[DEALT] [date] NULL,
	[SHARES_IN_THIS_TRANSACTION] [int] NULL,
	[HoldingCurrent] [float] NULL,
	[DUMMY_RECORD] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [PK_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE CLUSTERED INDEX [PK_001] ON [STG].[DIRECTOR_DEALS_RUNNING_TOTAL]
(
	[DIRECTOR_ID] ASC,
	[DEALT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_DIRECTOR_DEALS]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  VIEW [STG].[v_DIRECTOR_DEALS] AS
-- WITH RECOMPILE
	-- =====================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	October 2019
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		CREATED DIRECTOR_ID column as 100K rows takes a long time to load when checking on DIRECTOR (VARCHAR)
	-- 1.2		20191015 MOved solme columns to final insert as they are slow ... and this view is used ina  afew places e.g for SharesOustanding
	--
	-- SELECT TOP (100) * FROM [STG].[v_DIRECTOR_DEALS] ORDER BY [BODSkinInGamePCT] -- [DECLARED] DESC, [VALUE_GBP] DESC
	-- EXEC sp_help [STG.v_DIRECTOR_DEALS]

	/*
	SELECT TOP (100) *
	FROM [FCT].[v_DIRECTOR_DEALS]
	WHERE DATEADD(DD, -(2), GETDATE()) < [DECLARED]
	AND [VALUE_GBP] >= 0 -- 25000
	AND [TransactionType] NOT IN ('SELL', 'SEXR')
	ORDER BY [DECLARED] DESC, [VALUE_GBP] DESC

	SELECT *
	FROM [FCT].[v_DIRECTOR_DEALS]
	WHERE DATEADD(DD, -(30), GETDATE()) < [DECLARED]
	AND [VALUE_GBP] >= 25000
	AND [TransactionType] NOT IN ('SELL', 'SEXR')
	ORDER BY [DECLARED] DESC, [VALUE_GBP] DESC
	*/
	-- =====================================================================================================================================================================================================

	WITH CTE_01_ROOT AS (SELECT
	[A1].[Declared]
	, [A1].[Dealt]
	, [A1].[TransactionType]
	, [A1].[Epic]
	, [A1].[Company]
	, [A1].[DIRECTOR_ID] -- [C1].[ID] AS [DIRECTOR_ID]
	, [A1].[Position]
	, CONVERT(BIGINT, [A1].[Shares]) AS [Shares]
	, [A1].[Price_GBP]
	, [A1].[Value_GBP]
	, [A1].[CurrentPrice_GBP]
	, [A1].[% Gain]
	, [A1].[Gain_GBP]
	, [B1].[ID] AS [INVESTMENT_ID]

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
	WHEN 'RIIS' THEN (1) -- was (0) as dunno
	ELSE [TransactionType]
	END AS [TransactionDirection]
	-- SELECT * 
	FROM [Alchemy_Stage_Data].[STG].[DIRECTOR_DEALS] A1
	LEFT JOIN [Alchemy_Data].[DIM].[v_INVESTMENT] B1 ON [A1].[Epic] = [B1].[PRIMARY_LABEL]
	)

	-- =====================================================================================================================================================================================================
	-- HOLDINGS AT END OF DAY
	-- =====================================================================================================================================================================================================

	, CTE_HOLDINGS_AT_END_OF_DAY AS
	(SELECT [DIRECTOR_ID], [Dealt], SUM([HoldingCurrent]) AS [HoldingsAtEndOfDay]
	FROM [ALCHEMY_STAGE_DATA].[STG].[DIRECTOR_DEALS_RUNNING_TOTAL] GROUP BY [DIRECTOR_ID], [Dealt]) -- 94,680

	-- =====================================================================================================================================================================================================
	-- FINAL SELECT
	-- =====================================================================================================================================================================================================
	, CTE_FINAL AS
	(SELECT	-- ROW_NUMBER() OVER (ORDER BY [A1].[Dealt] DESC, [A1].[EPIC]) AS [SORT Id]
	[A1].[Declared]
	, [A1].[Dealt]
	, CASE [A1].[TransactionType]
		WHEN 'Buy' THEN 'Buy'
		WHEN 'Sell' THEN 'Sell'
		WHEN 'EXR' THEN 'Exercise'
		WHEN 'SEXR' THEN 'Sale Post-Exercise'
		WHEN 'DRI' THEN 'Dividend Reinvestment'
		WHEN 'DRIP' THEN 'Dividend Reinvestment Plan'
		WHEN 'AWD' THEN 'Award'
		WHEN 'TIN' THEN 'Transfer In'
		WHEN 'TOUT' THEN 'Transfer Out'
		WHEN 'LOF' THEN 'In Lieu of Fees/Salary'
		WHEN 'SI' THEN 'Script Issue'
		WHEN 'PLAC' THEN 'Placing'
		WHEN 'RIS' THEN 'Rights Issue'
		WHEN 'RIIS' THEN 'Rights Issue (RIIS)'
		ELSE [TransactionType]
		END AS [TransactionType]
	, [A1].[Epic]
	, [A1].[Company]
	, CASE [A1].[Position]
		WHEN 'CH' THEN 'Chairman'
		WHEN 'CEO' THEN 'Chief Executive Officer'
		WHEN 'MD' THEN 'Managing Director'
		WHEN 'FD' THEN 'Financial Director'
		WHEN 'NED' THEN 'Non-Executive Director'
		WHEN 'ED' THEN 'Executive Director'
		WHEN 'RES' THEN 'Resigned'
		WHEN 'D' THEN 'Director / Unknown'
		ELSE [A1].[Position]
		END AS [Position]
	, [D1].[Director]
	, [A1].[Shares]
	, [A1].[Price_GBP]
	, [A1].[Value_GBP]
	, [A1].[CurrentPrice_GBP]
	, [A1].[% Gain]
	, [A1].[Gain_GBP]
	, [A1].[INVESTMENT_ID]
	, [C1].[HoldingsAtEndOfDay] AS [HoldingCurrent]
	, [C1].[HoldingsAtEndOfDay] - [A1].[Shares] AS [HoldingPrevious] -- [C1].[HoldingCurrent] 

	, ISNULL([A1].[Shares] / NULLIF((
		[C1].[HoldingsAtEndOfDay] -- [C1].[HoldingCurrent] 
		- [A1].[Shares]),0), (1)) AS [HoldingChange] -- PCT
/*
	, (SELECT COUNT(*) FROM CTE_01_ROOT B1 WHERE [A1].[Epic] = [B1].[Epic] AND [B1].[Declared] BETWEEN DATEADD(DD, -(6), [A1].[Declared]) AND [A1].[Declared] AND [B1].[VALUE_GBP] > (0))
		AS [MultiBuysInLast7Days]
	, (SELECT COUNT(*) FROM CTE_01_ROOT B1 WHERE [A1].[Epic] = [B1].[Epic] AND [B1].[Declared] BETWEEN DATEADD(DD, -(6), [A1].[Declared]) AND [A1].[Declared] AND [B1].[VALUE_GBP] < (0)) 
		AS [MultiSellsInLast7Days]
	, [C1].[HoldingsAtEndOfDay] -- [C1].[HoldingCurrent] 
		/ (NULLIF([E1].[SharesOutstandingMillion], (0)) * (1000) * (1000)) 
		AS [BODSkinInGamePCT]
	, [E1].[SharesOutstandingMillion]
*/

	FROM CTE_01_ROOT A1
	JOIN CTE_HOLDINGS_AT_END_OF_DAY C1 -- [ALCHEMY_STAGE_DATA].[STG].[DIRECTOR_DEALS_RUNNING_TOTAL] C1
	ON [A1].[DIRECTOR_ID] = [C1].[DIRECTOR_ID] AND [A1].[Dealt] = [C1].[Dealt]

	JOIN [Alchemy_Stage_Data].[STG].[DIRECTOR] D1 ON [A1].[DIRECTOR_ID] = [D1].[ID]
	-- LEFT JOIN [Alchemy_Data].[FCT].[v_YAHOO_STATISTICS_LATEST] E1 ON [A1].[Epic] = [E1].[TICKER]
	)

	, CTE_MISSING_SHARES AS
	(SELECT * FROM CTE_FINAL A1)


	SELECT * FROM CTE_FINAL
GO
/****** Object:  Table [STG].[SHORT_TRACKER_DETAIL]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[SHORT_TRACKER_DETAIL](
	[Company] [nvarchar](255) NOT NULL,
	[Ticker] [nvarchar](12) NULL,
	[Fund] [nvarchar](255) NOT NULL,
	[% short] [float] NOT NULL,
	[Change_Pct] [float] NULL,
	[CALC_CHANGE_PCT] [float] NULL,
	[Date Changed] [date] NOT NULL,
	[DateOfExport] [datetime] NOT NULL,
	[Current_YN] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_SHORT_TRACKER_DETAIL]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_SHORT_TRACKER_DETAIL]
AS

	-- ============================================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	July 2019
	-- Version History:
	-- 1.0		Initial Release
	-- ============================================================================================================================================================================================================================

		SELECT [A1].[Company]
		, [A1].[Ticker]
		, [A1].[Fund]
		, [A1].[% short]
		, [A1].[Change_Pct]
		, [A1].[CALC_CHANGE_PCT]
		, [A1].[Date Changed]
		, [A1].[DateOfExport]
		, [A1].[Current_YN]

		FROM [STG].[SHORT_TRACKER_DETAIL] A1
GO
/****** Object:  Table [STG].[TELEGRAPH_SECTOR]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[TELEGRAPH_SECTOR](
	[Sector] [nvarchar](100) NULL,
	[EPIC] [nvarchar](25) NULL,
	[Name] [nvarchar](255) NULL,
	[Price] [float] NULL,
	[Market Cap] [float] NULL,
	[DateOfExport] [date] NULL,
	[EST_INVESTMENT_ID] [int] NULL,
	[EST_INVESTMENT_ID_COUNT] [int] NULL,
	[EST_SECTOR_ID] [int] NULL,
	[EST_SECTOR_ID_COUNT] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_TELEGRAPH_SECTOR]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_TELEGRAPH_SECTOR]
AS

	-- ============================================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	--
	-- SELECT * FROM [STG].[v_TELEGRAPH_SECTOR]
	-- ============================================================================================================================================================================================================================

	WITH CTE AS (SELECT [EPIC], MAX([DateOfExport]) as [MAXDateOfExport] FROM [STG].[TELEGRAPH_SECTOR] GROUP BY EPIC)

	SELECT [A].[Sector]
      ,[A].[EPIC]
      ,[A].[Name]
      ,[A].[Price]
      ,[A].[Market Cap]
      ,[A].[DateOfExport]
      ,[A].[EST_INVESTMENT_ID]
      ,[A].[EST_INVESTMENT_ID_COUNT]
      ,[A].[EST_SECTOR_ID]
      ,[A].[EST_SECTOR_ID_COUNT]
	FROM [STG].[TELEGRAPH_SECTOR] A JOIN CTE B ON [A].[EPIC] = [B].[EPIC] AND [A].[DateOfExport] = [B].[MAXDateOfExport]

GO
/****** Object:  Table [STG].[TRUSTNET_OEIC]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[TRUSTNET_OEIC](
	[TRUSTNET_UNIQUE] [varchar](100) NULL,
	[FundCode] [varchar](100) NULL,
	[FundName] [varchar](255) NOT NULL,
	[PriceName] [varchar](255) NOT NULL,
	[Group] [varchar](100) NULL,
	[Focus] [varchar](100) NULL,
	[FE Risk Score] [int] NULL,
	[fund_counter] [int] NOT NULL,
	[table_counter] [int] NOT NULL,
	[ShareClass] [varchar](100) NULL,
	[Unit Type] [varchar](100) NULL,
	[Currency] [varchar](5) NULL,
	[Bid] [float] NULL,
	[Offer] [float] NULL,
	[ClosureDate] [date] NOT NULL,
	[Yield] [float] NULL,
	[Citicode] [varchar](100) NULL,
	[SEDOL] [varchar](100) NULL,
	[ISIN] [varchar](100) NULL,
	[DateLoaded] [datetime] NULL,
	[Region] [varchar](250) NULL,
	[Asset Class] [varchar](250) NULL,
	[Investment Focus] [varchar](250) NULL,
	[Sector] [varchar](250) NULL,
	[EST_INVESTMENT_ID] [int] NULL,
	[Fe Crown Fund Rating] [tinyint] NULL,
	[FundSize] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE CLUSTERED INDEX [PK_001] ON [STG].[TRUSTNET_OEIC]
(
	[Citicode] ASC,
	[ClosureDate] ASC,
	[fund_counter] ASC,
	[ISIN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_TRUSTNET_OEIC]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [STG].[v_TRUSTNET_OEIC] -- WITH SCHEMABINDING
AS

	-- =======================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	November 2016
	-- Version History:
	-- 1.0
	-- 1.1		20190227 Added SRCD
	-- 1.2		20190228 Added AND [A1].[ClosureDate] = [B1].[ClosureDate] ON sub select ON SRCB
	-- 1.3		20191122 Added FundSize
	--
	-- SELECT TOP 250 * FROM [STG].[v_TRUSTNET_OEIC] ORDER BY ClosureDate DESC
	/*
	SELECT DISTINCT TOP (250) [ISINCode], [SEDOL], [CITICODE], [EST_INVESTMENT_ID_CNT] FROM [STG].[v_TRUSTNET_OEIC] WHERE [EST_INVESTMENT_ID_CNT] <> (1)
	ORDER BY [EST_INVESTMENT_ID_CNT] DESC
	*/
	-- SELECT COUNT(*) FROM [STG].[v_TRUSTNET_OEIC]						-- 803,482 -- 20180215
	-- SELECT SUM([EST_INVESTMENT_ID_CNT]) FROM [STG].[v_TRUSTNET_OEIC]	-- 784,013 -- 20180215
	--
	-- SELECT COUNT(*) FROM [STG].[v_TRUSTNET_OEIC]						-- 803,388 -- 20180215
	-- SELECT SUM([EST_INVESTMENT_ID_CNT]) FROM [STG].[v_TRUSTNET_OEIC]	-- 783,572 -- 20180215
	-- SELECT * FROM [STG].[v_TRUSTNET_OEIC] WHERE [CTE_GBP_AND_COUNTER_EQ_ONESource] = 'SRCB'
	-- SELECT TOp 10 * FROM [STG].[v_TRUSTNET_OEIC] WHERE [TRUSTNET_UNIQUE] = 'FXFOP' OR ISINCODE = 'LU1280184760'
	-- SELECT * FROM [STG].[TRUSTNET_OEIC] WHERE [TRUSTNET_UNIQUE] = 'FXFOP' OR ISIN = 'LU1280184760'
	-- SELECT distinct pricename FROM [STG].[v_TRUSTNET_OEIC] WHERE CTE_GBP_AND_COUNTER_EQ_ONESOURCE = 'SRCD' -- 8 rows
	-- =======================================================================================================================================================

	WITH CTE_GBP_AND_COUNTER_EQ_ONE AS (
	SELECT [A1].[TRUSTNET_UNIQUE]
	, [A1].[FundCode]
	, [A1].[FundName]
	, [A1].[PriceName]
	, CASE WHEN [A1].[Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP
	, CASE WHEN [A1].[Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP
	, [Currency]
	-- , [YearHigh], [YearLow]
	, [A1].[ClosureDate]
	, ISNULL([ISIN],'')     AS [ISINCode]
	, ISNULL([CitiCode],'') AS [CITICODE]
	, ISNULL([SEDOL],'')    AS [SEDOL]
	, [A1].[Fund_Counter]
	, [A1].[Table_Counter]
	, [A1].[SECTOR]
	, [A1].[REGION]
	, [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	, [A1].[FE Risk Score]
	, [A1].[Asset Class]
	, [A1].[Fe Crown Fund Rating]
	, [A1].[FundSize] / (1000000) AS [FundSize]
	-- SELECT DISTINCT [Currency] FROM [STG].[TRUSTNET_OEIC] ORDER BY 1
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL -- 20180228
	AND ([A1].[Currency] IN ('GBP','GBX', 'p'))	-- Added 20180306
	AND [A1].[Fund_Counter] = (1)
	),

	CTE_GBP_AND_COUNTER_NOT_EQ_ONE AS (SELECT [A1].[TRUSTNET_UNIQUE]
	, [A1].[FundCode]
	, [A1].[FundName]
	, [A1].[PriceName]
	, CASE WHEN [A1].[Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP
	, CASE WHEN [A1].[Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP
	, [A1].[Currency]
	, [A1].[ClosureDate]
	, ISNULL([A1].[ISIN],'')     AS [ISINCode]
	, ISNULL([A1].[CitiCode],'') AS [CITICODE]
	, ISNULL([A1].[SEDOL],'')    AS [SEDOL]
	, [A1].[Fund_Counter]
	, [A1].[Table_Counter]
	, [A1].[SECTOR]
	, [A1].[REGION]
	, [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	, [A1].[FE Risk Score]
	, [A1].[Asset Class]
	, [A1].[Fe Crown Fund Rating]
	, [A1].[FundSize] / (1000000) AS [FundSize]
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL -- 20180228
	AND ([A1].[Currency] IN ('GBP','GBX', 'p'))	-- Added 20180306
	AND [A1].[Fund_Counter] <> (1)
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID] AND [A1].[ClosureDate] = [B1].[ClosureDate]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	)

	-- =======================================================================================================================================================
	-- GBP, GBX and FUND COUNTER = (1) - PRIME SELECTION
	-- =======================================================================================================================================================
	SELECT 'SRCA' AS [CTE_GBP_AND_COUNTER_EQ_ONESource], *
	FROM CTE_GBP_AND_COUNTER_EQ_ONE

	UNION

	-- =======================================================================================================================================================
	-- GBP, GBX and FUND COUNTER <> (1) - NOT PRIME SELECTION
	-- =======================================================================================================================================================
	SELECT 'SRCB', *
	FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE
	UNION

	-- =======================================================================================================================================================
	-- NONE - GBP, GBX and FUND COUNTER = (1) 
	-- =======================================================================================================================================================
	SELECT 'SRCC', [A1].[TRUSTNET_UNIQUE]
	, [A1].[FundCode]
	, [A1].[FundName]
	, [A1].[PriceName]
	, CASE WHEN [A1].[Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP
	, CASE WHEN [A1].[Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP
	, [A1].[Currency]
	, [A1].[ClosureDate]
	, ISNULL([A1].[ISIN],'')     AS [ISINCode]
	, ISNULL([A1].[CitiCode],'') AS [CITICODE]
	, ISNULL([A1].[SEDOL],'')    AS [SEDOL]
	, [A1].[Fund_Counter]
	, [A1].[Table_Counter]
	, [A1].[SECTOR]
	, [A1].[REGION]
	, [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	, [A1].[FE Risk Score]
	, [A1].[Asset Class]
	, [A1].[Fe Crown Fund Rating]
	, [A1].[FundSize] / (1000000) AS [FundSize]
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL -- 20180228
	AND ([A1].[Fund_Counter] = (1))	-- Added 20180306
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])

	UNION

	-- =======================================================================================================================================================
	-- NONE - GBP, GBX and FUND COUNTER <> (1) 
	-- =======================================================================================================================================================
	SELECT 'SRCD', [A1].[TRUSTNET_UNIQUE]
	, [A1].[FundCode]
	, [A1].[FundName]
	, [A1].[PriceName]
	, CASE WHEN [A1].[Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP
	, CASE WHEN [A1].[Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP
	, [A1].[Currency]
	, [A1].[ClosureDate]
	, ISNULL([A1].[ISIN],'')     AS [ISINCode]
	, ISNULL([A1].[CitiCode],'') AS [CITICODE]
	, ISNULL([A1].[SEDOL],'')    AS [SEDOL]
	, [A1].[Fund_Counter]
	, [A1].[Table_Counter]
	, [A1].[SECTOR]
	, [A1].[REGION]
	, [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	, [A1].[FE Risk Score]
	, [A1].[Asset Class]
	, [A1].[Fe Crown Fund Rating]
	, [A1].[FundSize] / (1000000) AS [FundSize]
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL
	AND ([A1].[Fund_Counter] <> (1))	-- Added 20190227
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])


GO
/****** Object:  View [STG].[v_TRUSTNET_OEIC_ALL_TO_LOAD]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_TRUSTNET_OEIC_ALL_TO_LOAD] -- WITH SCHEMABINDING
AS

	-- =======================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	November 2016
	-- Version History:
	-- 1.0
	-- 1.1		20191121 Added [FundSize]
	--
	/*
	SELECT DISTINCT [ISINCode], [CitiCode], [SEDOL], [CURRENCY], [Fund_Counter]
	FROM [STG].[v_TRUSTNET_OEIC_ALL_THAT_SHOULD_HAVE_BE_LOADED] WHERE [EST_INVESTMENT_ID] IS NULL
	ORDER BY 4, 1 DESC, 2 DESC, 3 DESC
	*/
	-- =======================================================================================================================================================

	WITH CTE_GBP_AND_COUNTER_EQ_ONE AS (
	SELECT [TRUSTNET_UNIQUE]
	, [FundCode]
	, [FundName]
	, [PriceName]
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP
	, [Currency]
	-- , [YearHigh], [YearLow]
	, [ClosureDate]
	, ISNULL([ISIN],'')     AS [ISINCode]
	, ISNULL([CitiCode],'') AS [CITICODE]
	, ISNULL([SEDOL],'')    AS [SEDOL]
	, [Fund_Counter]
	, [Table_Counter]
	, [SECTOR]
	, [REGION]
	, [DateLoaded]
	, [EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	-- SELECT DISTINCT [Currency] FROM [STG].[TRUSTNET_OEIC] ORDER BY 1
	, [FundSize]
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE -- [EST_INVESTMENT_ID] IS NOT NULL -- 20180228
	([Currency] IN ('GBP','GBX', 'p'))	-- Added 20180306
	AND [Fund_Counter] = (1)
	),

	CTE_GBP_AND_COUNTER_NOT_EQ_ONE AS (SELECT [TRUSTNET_UNIQUE]
	, [FundCode]
	, [FundName]
	, [PriceName]
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP
	, [Currency]
	, [ClosureDate]
	, ISNULL([ISIN],'')     AS [ISINCode]
	, ISNULL([CitiCode],'') AS [CITICODE]
	, ISNULL([SEDOL],'')    AS [SEDOL]
	, [Fund_Counter]
	, [Table_Counter]
	, [SECTOR]
	, [REGION]
	, [DateLoaded]
	, [EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	, [FundSize]
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE -- [EST_INVESTMENT_ID] IS NOT NULL -- 20180228
	([Currency] IN ('GBP','GBX', 'p'))	-- Added 20180306
	AND [Fund_Counter] <> (1)
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	)

	-- =======================================================================================================================================================
	-- GBP, GBX and FUND COUNTER = (1) - PRIME SELECTION
	-- =======================================================================================================================================================
	SELECT 'SRCA' AS [CTE_GBP_AND_COUNTER_EQ_ONESource], *
	FROM CTE_GBP_AND_COUNTER_EQ_ONE

	UNION

	-- =======================================================================================================================================================
	-- GBP, GBX and FUND COUNTER <> (1) - NOT PRIME SELECTION
	-- =======================================================================================================================================================
	SELECT 'SRCB', *
	FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE
	UNION

	-- =======================================================================================================================================================
	-- NONE - GBP, GBX and FUND COUNTER = (1) 
	-- =======================================================================================================================================================
	SELECT 'SRCC', [TRUSTNET_UNIQUE]
	, [FundCode]
	, [FundName]
	, [PriceName]
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP
	, [Currency]
	, [ClosureDate]
	, ISNULL([ISIN],'')     AS [ISINCode]
	, ISNULL([CitiCode],'') AS [CITICODE]
	, ISNULL([SEDOL],'')    AS [SEDOL]
	, [Fund_Counter]
	, [Table_Counter]
	, [SECTOR]
	, [REGION]
	, [DateLoaded]
	, [EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	, [FundSize]
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE -- [EST_INVESTMENT_ID] IS NOT NULL -- 20180228
	([Fund_Counter] = (1))	-- Added 20180306
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])

	/*
	AUD
	CAD
	CHF
	CHX
	CNH
	DKK
	EUR
	EUX
	GBP
	GBX
	HKD
	JPY
	p
	PLN
	SGD
	USD
	USX
	*/

GO
/****** Object:  View [STG].[v_TRUSTNET_OEIC_LATEST_DATA]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [STG].[v_TRUSTNET_OEIC_LATEST_DATA]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	December 2016
	-- Version History:
	-- 1.0
	-- 
	/*
	SELECT * FROM [STG].[v_TRUSTNET_OEIC_LATEST_DATA]
	WHERE [ClosureDate] > DATEADD(DD, -(7), GETDATE())
	ORDER BY 2
	*/
	-- ==================================================================================================================================

	SELECT *
	FROM [STG].[v_TRUSTNET_OEIC] A
	WHERE -- [Fund_Counter] = 1 AND
	[ClosureDate] = (SELECT MAX([ClosureDate]) FROM [STG].[v_TRUSTNET_OEIC] B
							WHERE -- [A].[Fund_Counter] = [B].[Fund_Counter]
							-- AND [A].[FundCode] = [B].[FundCode]
							[A].[EST_INVESTMENT_ID] = [B].[EST_INVESTMENT_ID] --20180310
							)

							-- SLOW AND [A].[CITICODE] = [B].[CITICODE]
							-- SLOW AND [A].[ISINCode] = [B].[ISINCode])


GO
/****** Object:  View [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE_ALL]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE_ALL] AS

	-- =============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	November 2019
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20191121 Adde [FundSize]
	-- 1.2		20191202 Remove Currency Filter & 'Top 25000' & CTE_FIND_FE_FOR_LIMIT
	--
	-- SELECT TOP (100) * FROM [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE_ALL] A1 ORDER BY [A1].[ClosureDate] DESC
	-- SELECT COUNT(*) FROM [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE_ALL]
	-- =============================================================================================================================================================================================================

	WITH CTE_CORE AS
	(SELECT ROW_NUMBER() OVER (ORDER BY ((1000) * [A1].[Fe Crown Fund Rating]) / ((1) + NULLIF([A1].[FE Risk Score],0)) DESC) AS [SortID]
	, [A1].[CTE_GBP_AND_COUNTER_EQ_ONESource], [A1].[TRUSTNET_UNIQUE], [A1].[FundCode], [A1].[FundName], [A1].[PriceName], [A1].[Bid], [A1].[Offer], [A1].[Currency], [A1].[ClosureDate]
	, [A1].[ISINCode]
	, [A1].[CITICODE], [A1].[SEDOL], [A1].[Fund_Counter], [A1].[Table_Counter], [A1].[SECTOR], [A1].[REGION], [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, [A1].[EST_INVESTMENT_ID_CNT]
	, [A1].[FE Risk Score]
	, [A1].[Asset Class]
	, [A1].[Fe Crown Fund Rating]
	, [A1].[FundSize]
	-- , 1000* [A1].[Fe Crown Fund Rating] / (1 + NULLIF([A1].[FE Risk Score],0)) AS [TmpCalc]
	-- , CASE WHEN [B1].[EST_INVESTMENT_ID] IS NOT NULL THEN 'Previous Risk' END AS [FE Risk Score (Previous]
	FROM [Alchemy_Stage_Data].[STG].[v_TRUSTNET_OEIC] A1 -- [v_TRUSTNET_OEIC]
	-- LEFT JOIN CTE_FIND_LATEST B1 ON [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID] AND [A1].[ClosureDate] = [B1].[ClosureDate]
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL -- JOIN CTE_FIND_FE_FOR_LIMIT B1 ON [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]
	)

	/*
	, CTE_LATEST AS
	(SELECT [EST_INVESTMENT_ID], MAX([ClosureDate]) AS [ClosureDate] FROM CTE_CORE GROUP BY [EST_INVESTMENT_ID])
	*/

	/*
	, CTE_PREVIOUS_FE_RISK_SCORE AS
	(SELECT [A2].[EST_INVESTMENT_ID], MAX([A2].[ClosureDate]) AS [ClosureDate] FROM CTE_CORE A1
	JOIN CTE_CORE A2 ON [A1].[EST_INVESTMENT_ID] = [A2].[EST_INVESTMENT_ID] AND [A2].[ClosureDate] < [A1].[ClosureDate]
	WHERE [A1].[FE Risk Score] <> [A2].[FE Risk Score]
	GROUP BY [A2].[EST_INVESTMENT_ID])
	*/

	/*
	, CTE_PREVIOUS_FE_CROWN_RATING AS
	(SELECT [A2].[EST_INVESTMENT_ID], MAX([A2].[ClosureDate]) AS [ClosureDate] FROM CTE_CORE A1
	JOIN CTE_CORE A2 ON [A1].[EST_INVESTMENT_ID] = [A2].[EST_INVESTMENT_ID] AND [A2].[ClosureDate] < [A1].[ClosureDate]
	WHERE [A1].[Fe Crown Fund Rating] <> [A2].[Fe Crown Fund Rating]
	GROUP BY [A2].[EST_INVESTMENT_ID])
	*/

	SELECT [A1].*

	/*
	, [A2].[ClosureDate] AS [FERiskScoreDateOfChange]
	, [A3].[FE Risk Score] AS [FERiskScorePrevious]
	, [A1].[FE Risk Score] - [A3].[FE Risk Score] AS [FERiskScoreChange]
	, CASE
		WHEN [A1].[FE Risk Score] - [A3].[FE Risk Score] > (0) THEN 'Up'
		WHEN [A1].[FE Risk Score] - [A3].[FE Risk Score] < (0) THEN 'Down' 
		ELSE '' END AS [FERiskScoreChangeDirection]
	*/
	/*
	, [A4].[ClosureDate] AS [FECrownRatingDateOfChange]
	, [A5].[Fe Crown Fund Rating] AS [FECrownRatingPrevious]
	, CONVERT(INT, [A1].[Fe Crown Fund Rating]) - ISNULL([A5].[Fe Crown Fund Rating], [A1].[Fe Crown Fund Rating]) AS [FECrownRatingChange]
	, CASE
		WHEN CONVERT(INT, [A1].[Fe Crown Fund Rating]) - ISNULL([A5].[Fe Crown Fund Rating], [A1].[Fe Crown Fund Rating]) > (0) THEN 'Up'
		WHEN CONVERT(INT, [A1].[Fe Crown Fund Rating]) - ISNULL([A5].[Fe Crown Fund Rating], [A1].[Fe Crown Fund Rating]) < (0) THEN 'Down' 
		ELSE '' END AS [FECrownRatingChangeDirection]
	*/

	FROM CTE_CORE A1
	-- JOIN CTE_PREVIOUS_FE_RISK_SCORE A2 ON [A1].[EST_INVESTMENT_ID] = [A2].[EST_INVESTMENT_ID]
	-- JOIN CTE_CORE A3 ON [A2].[EST_INVESTMENT_ID] = [A3].[EST_INVESTMENT_ID] AND [A2].[ClosureDate] = [A3].[ClosureDate]
	-- JOIN CTE_PREVIOUS_FE_CROWN_RATING A4 ON [A1].[EST_INVESTMENT_ID] = [A4].[EST_INVESTMENT_ID] -- rows
	-- JOIN CTE_CORE A5 ON [A4].[EST_INVESTMENT_ID] = [A5].[EST_INVESTMENT_ID] AND [A4].[ClosureDate] = [A5].[ClosureDate]
GO
/****** Object:  View [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE] AS

	-- =============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	June 2019
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190624 Change order from DESC to ASC ... to find low risk
	-- 1.2		20190624 Show all
	-- 1.3		20191121 Added [FundSize]
	-- 1.4		20191202 Remove Currency Filter & 'Top 25000' & CTE_FIND_FE_FOR_LIMIT
	--
	-- SELECT * FROM [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE] -- 3080
	-- =============================================================================================================================================================================================================

	/*
	WITH CTE_CORE AS (SELECT * FROM [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE_ALL])

	SELECT ROW_NUMBER() OVER (ORDER BY ((1000) * [A1].[Fe Crown Fund Rating]) / ((1) + NULLIF([A1].[FE Risk Score],0)) DESC) AS [SortID]
	, [A1].[CTE_GBP_AND_COUNTER_EQ_ONESource], [A1].[TRUSTNET_UNIQUE], [A1].[FundCode], [A1].[FundName], [A1].[PriceName], [A1].[Bid], [A1].[Offer], [A1].[Currency], [A1].[ClosureDate], [A1].[ISINCode]
	, [A1].[CITICODE], [A1].[SEDOL], [A1].[Fund_Counter], [A1].[Table_Counter], [A1].[SECTOR], [A1].[REGION], [A1].[DateLoaded], [A1].[EST_INVESTMENT_ID], [A1].[EST_INVESTMENT_ID_CNT], [A1].[FE Risk Score]
	, [A1].[Asset Class], [A1].[Fe Crown Fund Rating]
 	, [FundSize]

	FROM CTE_CORE A1 -- [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE_ALL] A1 -- [Alchemy_Stage_Data].[STG].[v_TRUSTNET_OEIC_LATEST_DATA] A1 -- [v_TRUSTNET_OEIC]
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL
	AND	[ClosureDate] = (SELECT MAX([ClosureDate]) FROM CTE_CORE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID])
	*/

	/*
	WITH CTE_CORE AS (
	-- SELECT * FROM [Alchemy_Stage_Data].[STG].[v_TRUSTNET_OEIC_LATEST_DATA]) -- [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE_ALL])

	SELECT ROW_NUMBER() OVER (ORDER BY ((1000) * [A1].[Fe Crown Fund Rating]) / ((1) + NULLIF([A1].[FE Risk Score],0)) DESC) AS [SortID]
	, [A1].[CTE_GBP_AND_COUNTER_EQ_ONESource], [A1].[TRUSTNET_UNIQUE], [A1].[FundCode], [A1].[FundName], [A1].[PriceName], [A1].[Bid], [A1].[Offer], [A1].[Currency], [A1].[ClosureDate], [A1].[ISINCode]
	, [A1].[CITICODE], [A1].[SEDOL], [A1].[Fund_Counter], [A1].[Table_Counter], [A1].[SECTOR], [A1].[REGION], [A1].[DateLoaded], [A1].[EST_INVESTMENT_ID], [A1].[EST_INVESTMENT_ID_CNT], [A1].[FE Risk Score]
	, [A1].[Asset Class], [A1].[Fe Crown Fund Rating]
 	, [FundSize]

	FROM [Alchemy_Stage_Data].[STG].[v_TRUSTNET_OEIC_LATEST_DATA] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL
	-- AND	[ClosureDate] = (SELECT MAX([ClosureDate]) FROM CTE_CORE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]))
	)

	, CTE_PREVIOUS_FE_RISK_SCORE AS
	(SELECT [A4].[EST_INVESTMENT_ID], MAX([A4].[ClosureDate]) AS [ClosureDate] FROM CTE_CORE A1
	JOIN CTE_CORE A4 ON [A1].[EST_INVESTMENT_ID] = [A4].[EST_INVESTMENT_ID] AND [A4].[ClosureDate] < [A1].[ClosureDate]
	WHERE [A1].[FE Risk Score] <> [A4].[FE Risk Score]
	GROUP BY [A4].[EST_INVESTMENT_ID])

	SELECT [A1].*
	FROM CTE_CORE A1
	*/

	WITH CTE_CORE AS
	(SELECT -- ROW_NUMBER() OVER (ORDER BY ((1000) * [A1].[Fe Crown Fund Rating]) / ((1) + NULLIF([A1].[FE Risk Score],0)) DESC) AS [SortID]
	[A1].[CTE_GBP_AND_COUNTER_EQ_ONESource], [A1].[TRUSTNET_UNIQUE], [A1].[FundCode], [A1].[FundName], [A1].[PriceName], [A1].[Bid], [A1].[Offer], [A1].[Currency], [A1].[ClosureDate]
	, [A1].[ISINCode]
	, [A1].[CITICODE], [A1].[SEDOL], [A1].[Fund_Counter], [A1].[Table_Counter], [A1].[SECTOR], [A1].[REGION], [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, [A1].[EST_INVESTMENT_ID_CNT]
	, [A1].[FE Risk Score]
	, [A1].[Asset Class]
	, [A1].[Fe Crown Fund Rating]
	, [A1].[FundSize]

	FROM [STG].[v_TRUSTNET_OEIC_FE_RISK_SCORE_ALL] A1 -- 3080
	)

	, CTE_PREVIOUS_FE_CROWN_RATING AS
	(SELECT [A4].[EST_INVESTMENT_ID], MAX([A4].[ClosureDate]) AS [ClosureDate] FROM CTE_CORE A1
	JOIN CTE_CORE A4 ON [A1].[EST_INVESTMENT_ID] = [A4].[EST_INVESTMENT_ID] AND [A4].[ClosureDate] < [A1].[ClosureDate]
	WHERE [A1].[Fe Crown Fund Rating] <> [A4].[Fe Crown Fund Rating]
	GROUP BY [A4].[EST_INVESTMENT_ID])

	, CTE_PREVIOUS_FE_RISK_SCORE AS
	(SELECT [A4].[EST_INVESTMENT_ID], MAX([A4].[ClosureDate]) AS [ClosureDate] FROM CTE_CORE A1
	JOIN CTE_CORE A4 ON [A1].[EST_INVESTMENT_ID] = [A4].[EST_INVESTMENT_ID] AND [A4].[ClosureDate] < [A1].[ClosureDate]
	WHERE [A1].[FE Risk Score] <> [A4].[FE Risk Score]
	GROUP BY [A4].[EST_INVESTMENT_ID])

	, CTE_LATEST AS
	(SELECT [EST_INVESTMENT_ID], MAX([ClosureDate]) AS [ClosureDate] FROM CTE_CORE GROUP BY [EST_INVESTMENT_ID])

	, CTE_RESULTS AS 
	(SELECT ROW_NUMBER() OVER (ORDER BY ((1000) * [A1].[Fe Crown Fund Rating]) / ((1) + NULLIF([A1].[FE Risk Score],0)) DESC) AS [SortID]
	, [A1].*
	FROM CTE_CORE A1
	JOIN CTE_LATEST A4 ON [A1].[EST_INVESTMENT_ID] = [A4].[EST_INVESTMENT_ID] AND [A1].[ClosureDate] = [A4].[ClosureDate])

	SELECT [A1].*
	, [A4].[ClosureDate] AS [FECrownRatingDateOfChange]

	, [A2].[ClosureDate] AS [FERiskScoreDateOfChange]
	, [A3].[FE Risk Score] AS [FERiskScorePrevious]
	, [A1].[FE Risk Score] - [A3].[FE Risk Score] AS [FERiskScoreChange]
	, CASE
		WHEN [A1].[FE Risk Score] - [A3].[FE Risk Score] > (0) THEN 'Up'
		WHEN [A1].[FE Risk Score] - [A3].[FE Risk Score] < (0) THEN 'Down' 
		ELSE '' END AS [FERiskScoreChangeDirection]

	, [A5].[Fe Crown Fund Rating] AS [FECrownRatingPrevious]
	, CONVERT(INT, [A1].[Fe Crown Fund Rating]) - ISNULL([A5].[Fe Crown Fund Rating], [A1].[Fe Crown Fund Rating]) AS [FECrownRatingChange]
	, CASE
		WHEN CONVERT(INT, [A1].[Fe Crown Fund Rating]) - ISNULL([A5].[Fe Crown Fund Rating], [A1].[Fe Crown Fund Rating]) > (0) THEN 'Up'
		WHEN CONVERT(INT, [A1].[Fe Crown Fund Rating]) - ISNULL([A5].[Fe Crown Fund Rating], [A1].[Fe Crown Fund Rating]) < (0) THEN 'Down' 
		ELSE '' END AS [FECrownRatingChangeDirection]

	FROM CTE_RESULTS A1
	LEFT JOIN CTE_PREVIOUS_FE_RISK_SCORE A2 ON [A1].[EST_INVESTMENT_ID] = [A2].[EST_INVESTMENT_ID]
	LEFT JOIN CTE_CORE A3 ON [A2].[EST_INVESTMENT_ID] = [A3].[EST_INVESTMENT_ID] AND [A2].[ClosureDate] = [A3].[ClosureDate]
	LEFT JOIN CTE_PREVIOUS_FE_CROWN_RATING A4 ON [A1].[EST_INVESTMENT_ID] = [A4].[EST_INVESTMENT_ID] -- rows
	LEFT JOIN CTE_CORE A5 ON [A4].[EST_INVESTMENT_ID] = [A5].[EST_INVESTMENT_ID] AND [A4].[ClosureDate] = [A5].[ClosureDate]

GO
/****** Object:  View [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS]
AS

	-- ============================================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	--
	-- SELECT * FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS]
	/*
	SELECT TRUSTNET_UNIQUE, ISINCODE, COUNT(*) -- , CURRENCY
	FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS]
	GROUP BY TRUSTNET_UNIQUE, ISINCODE -- , CURRENCY
	HAVING COUNT(*) > (1)
-- 	ORDER BY 4 DESC, 3

	SELECT *
	FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS]
	WHERE TRUSTNET_UNIQUE = 'BAFV8'
	AND ISINCODE = 'FR0007052782'
	-- AND CURRENCY = 'USD'

	SELECT fund_counter, currency, * FROM [STG].[TRUSTNET_OEIC]
	WHERE TRUSTNET_UNIQUE = 'MRFDM'
	AND ISINCODE = 'IE00BZ0PKV06'
	AND CURRENCY = 'GBP'
	AND [ClosureDate] > DATEADD(DD, -30, GETDATE())
	ORDER BY [ClosureDate] DESC
	*/
	-- ============================================================================================================================================================================================================================

	WITH CTE_GBP_AND_COUNTER_EQ_ONE AS (
	SELECT [TRUSTNET_UNIQUE]
	, [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	, ISNULL(MAX(REPLACE([ISIN],'n/a','')),'') AS [ISINCode]
	, ISNULL(MAX(REPLACE([CitiCode],'n/a','')),'') AS [CitiCode]
	, ISNULL(MAX(REPLACE([SEDOL],'n/a','')),'') AS [SEDOL]
	FROM [STG].[TRUSTNET_OEIC]
	WHERE [ClosureDate] > DATEADD(DD, -(14), GETDATE()) -- 30
	AND ([Currency] IN ('GBP','GBX'))		-- Added 20180306
	AND [Fund_Counter] = (1)
	GROUP BY [TRUSTNET_UNIQUE], [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	),

	CTE_GBP_AND_COUNTER_NOT_EQ_ONE AS (
	SELECT [TRUSTNET_UNIQUE]
	, [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	, ISNULL(MAX(REPLACE([ISIN],'n/a','')),'') AS [ISINCode]
	, ISNULL(MAX(REPLACE([CitiCode],'n/a','')),'') AS [CitiCode]
	, ISNULL(MAX(REPLACE([SEDOL],'n/a','')),'') AS [SEDOL]
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE [ClosureDate] > DATEADD(DD, -(14), GETDATE()) -- 30
	AND ([Currency] IN ('GBP','GBX'))
	AND [Fund_Counter] <> (1)
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	AND [Fund_Counter] = (SELECT MIN([Fund_Counter]) FROM [STG].[TRUSTNET_OEIC] C1 WHERE [A1].[TRUSTNET_UNIQUE] = [C1].[TRUSTNET_UNIQUE] AND ([Currency] IN ('GBP','GBX')) AND [Fund_Counter] <> (1))
	GROUP BY [TRUSTNET_UNIQUE], [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	)

	SELECT 'SRCA' AS [CTE_GBP_AND_COUNTER_EQ_ONESource], *
	FROM CTE_GBP_AND_COUNTER_EQ_ONE
	UNION

	SELECT 'SRCB', *
	FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE
	UNION

	SELECT 'SRCC', [TRUSTNET_UNIQUE]
	, [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	, ISNULL(MAX(REPLACE([ISIN],'n/a','')),'') AS [ISINCode]
	, ISNULL(MAX(REPLACE([CitiCode],'n/a','')),'') AS [CitiCode]
	, ISNULL(MAX(REPLACE([SEDOL],'n/a','')),'') AS [SEDOL]
	-- , [Fund_Counter]
	FROM [STG].[TRUSTNET_OEIC] A1
	WHERE [ClosureDate] > DATEADD(DD, -(14), GETDATE()) -- 30
	AND ([Fund_Counter] = (1))				-- Added 20180306
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE B1 WHERE [A1].[TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	GROUP BY [TRUSTNET_UNIQUE], [PRICENAME] -- , [CURRENCY], [Fund_Counter]

GO
/****** Object:  View [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS_WITH_EST_INVESTMENT_ID]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS_WITH_EST_INVESTMENT_ID]
AS

	-- =============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	March 2018
	-- Version History:
	-- 1.0		Initial Release
	--
	-- NOTE:
	-- Change IN PRICENAME will mean that 2 rows are shown for upto 'DATEADD(DD, -(14), GETDATE())  days
	--
	/*
	SELECT *
	INTO #A
	FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS_WITH_EST_INVESTMENT_ID]

	SELECT 'EXEC [ARC].[usp_DELETE_INVESTMENT] @BUILD_ID = 3222, @FORCE_DELETE_OF_YAHOO_COMBINED_PRICES = 1, @FORCE_RESET_OF_STG_TRUSNET = 1, @INVESTMENT_ID = '+convert(varchar, [A].[ID])
	, crdate, *
	FROM [DIM].[v_INVESTMENT_SUBSET_NON_EQUITIES] A
	WHERE [INVESTMENT_TYPE_NAME] = 'Exchange Traded Fund'
	AND [ID] NOT IN (SELECT [INVESTMENT_ID] FROM #A)
	AND [ID] NOT IN (SELECT [INVESTMENT_ID] FROM [FCT].[YAHOO_COMBINED_PRICES])
	-- AND crdate > '24 Feb 2018'
	*/


	-- =============================================================================================================================================================================================================

	WITH CTE_MATCH_ON_THREE
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_3_ALIASES] B1 ON [A1].[ISINCode] = [B1].[A_LABEL] AND [A1].[CITICODE] = [B1].[B_LABEL] AND [A1].[SEDOL] = [B1].[C_LABEL])
	
	,CTE_MATCH_ON_ISIN_CITICODE
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_2_ALIASES] B1 ON [A1].[ISINCode] = [B1].[A_LABEL] AND [A1].[CITICODE] = [B1].[B_LABEL])

	,CTE_MATCH_ON_ISIN_SEDOL
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_2_ALIASES] B1 ON [A1].[ISINCode] = [B1].[A_LABEL] AND [A1].[SEDOL] = [B1].[B_LABEL])

	,CTE_MATCH_ON_CITICODE_SEDOL
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_2_ALIASES] B1 ON [A1].[CITICode] = [B1].[A_LABEL] AND [A1].[SEDOL] = [B1].[B_LABEL])

	,CTE_MATCH_ON_ONE
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_OEIC_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_1_ALIAS] B1 ON [A1].[ISINCode] = [B1].[A_LABEL] OR [A1].[CITICODE] = [B1].[A_LABEL] OR [A1].[SEDOL] = [B1].[A_LABEL])

	SELECT 'FSRCA' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_THREE] A1
	UNION
	SELECT 'FSRCB' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_ISIN_CITICODE] A1
	UNION
	SELECT 'FSRCC' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_ISIN_SEDOL] A1
	UNION
	SELECT 'FSRCD' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_CITICODE_SEDOL] A1
	UNION
	SELECT 'FSRCE' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_ONE] A1


GO
/****** Object:  Table [STG].[CURRENCY_EXCHANGE_RATES]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[CURRENCY_EXCHANGE_RATES](
	[LABEL] [char](6) NOT NULL,
	[ClosureDate] [date] NOT NULL,
	[ClosureRate] [float] NOT NULL,
	[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20160817-100631]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20160817-100631] ON [STG].[CURRENCY_EXCHANGE_RATES]
(
	[ClosureDate] ASC,
	[LABEL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ClosureRates_LATEST_DATA]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_ClosureRates_LATEST_DATA]
AS
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	SELECT *
	FROM [STG].[CURRENCY_EXCHANGE_RATES] A
	WHERE [ClosureDate] = (SELECT MAX([ClosureDate]) FROM [STG].[CURRENCY_EXCHANGE_RATES] B
							WHERE [A].[LABEL] = [B].[LABEL])


GO
/****** Object:  View [STG].[v_CURRENCY_EXCHANGE_RATES]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_CURRENCY_EXCHANGE_RATES] AS
	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

SELECT [A].[LABEL]
      , [B].[DESCRIPTION]
	  , CASE WHEN [B].[RESERVE] = (1) THEN 'Yes' ELSE 'No' END AS [Reserve Currency]
	  , CASE WHEN [B].[MAJOR_MINOR_EXOTIC_OTHER] IS NULL THEN 'Unknown' ELSE [B].[MAJOR_MINOR_EXOTIC_OTHER] END AS [MAJOR_MINOR_EXOTIC_OTHER]
	  , CASE WHEN [B].[CONTINENT] IS NULL THEN 'Unknown' ELSE [B].[CONTINENT] END AS [CONTINENT]
	  , [A].[ClosureDate]
      , [A].[ClosureRate]
      , [A].[CreateDate]
  FROM [STG].[CURRENCY_EXCHANGE_RATES] A, [Alchemy_Data].[DIM].[EXCHANGE_RATE_CURRENCY] B
	WHERE [A].[LABEL] = [B].[LABEL]

GO
/****** Object:  Table [STG].[TRUSTNET_ADHOC_FUND_PRICES]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[TRUSTNET_ADHOC_FUND_PRICES](
	[FundName] [varchar](255) NULL,
	[Citicode] [varchar](50) NULL,
	[Sedol] [varchar](50) NULL,
	[Bid] [float] NULL,
	[Offer] [float] NULL,
	[Currency] [varchar](10) NULL,
	[Yield] [float] NULL,
	[Date] [date] NULL,
	[Isin] [varchar](50) NULL,
	[Link] [varchar](255) NULL,
	[DateLoaded] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_TRUSTNET_ADHOC_FUND_PRICES]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_TRUSTNET_ADHOC_FUND_PRICES]
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	April 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- =====================================================================================================================

	SELECT [FundName]
	, [Citicode]
	, [Sedol]
	, [Bid] / (100) * CASE WHEN ([CURRENCY] LIKE '%GBP%')
					THEN (100) ELSE (1) END	AS [Bid] -- PRICES ARE ALREADY IN GBP .....
	, [Offer] / (100) * CASE WHEN ([CURRENCY] LIKE '%GBP%')
					THEN (100) ELSE (1) END	AS [Offer] -- PRICES ARE ALREADY IN GBP .....
	, [Currency]
	, [Yield]
	, [Date]
	, [Isin]
	, [Link]
	, [DateLoaded]
	FROM [STG].[TRUSTNET_ADHOC_FUND_PRICES] A
	WHERE LTRIM(RTRIM([CURRENCY])) NOT IN ('EU', 'CAD', 'USD', 'CHF', 'JP', 'JPY', 'AUD', 'EUR', 'USX', 'US')
	AND [CURRENCY] NOT LIKE '%EUR%' -- above is not excluding them !!!!  EAH
	AND [CURRENCY] NOT LIKE '%USD%' -- above is not excluding them !!!!  EAH

GO
/****** Object:  View [STG].[v_TRUSTNET_ADHOC_FUND_PRICES_LATEST_DATA]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_TRUSTNET_ADHOC_FUND_PRICES_LATEST_DATA]
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	April 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	SELECT *
	FROM [STG].[v_TRUSTNET_ADHOC_FUND_PRICES] A
	WHERE [Date] = (SELECT MAX([Date]) FROM [STG].[v_TRUSTNET_ADHOC_FUND_PRICES] B
					WHERE [A].[CITICODE] = [B].[CITICODE] OR [A].[SEDOL] = [B].[SEDOL])


GO
/****** Object:  View [STG].[v_TRUSTNET_ADHOC_FUND_PRICES_LATEST_DAY]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_TRUSTNET_ADHOC_FUND_PRICES_LATEST_DAY]
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	April 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

	SELECT *
	FROM [STG].[v_TRUSTNET_ADHOC_FUND_PRICES]
	WHERE [Date] = (SELECT MAX([Date]) FROM [STG].[v_TRUSTNET_ADHOC_FUND_PRICES])


GO
/****** Object:  Table [STG].[TELEGRAPH_INDICES]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[TELEGRAPH_INDICES](
	[DateOfExport] [datetime] NULL,
	[EST_INVESTMENT_ID] [int] NULL,
	[EST_INVESTMENT_ID_COUNT] [int] NULL,
	[IndexNameShort] [varchar](10) NULL,
	[IndexName] [varchar](50) NULL,
	[EPIC] [varchar](15) NULL,
	[Investment Name] [varchar](100) NULL,
	[Currency] [varchar](3) NULL,
	[Price] [float] NULL,
	[ABS_Change] [float] NULL,
	[PCT_Change] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_TELEGRAPH_INDICES]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [STG].[v_TELEGRAPH_INDICES]
AS

	-- ============================================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	--
	-- SELECT * FROM [STG].[v_TELEGRAPH_INDICES]
	-- ============================================================================================================================================================================================================================

	WITH CTE AS (SELECT [EPIC], MAX([DateOfExport]) as [MAXDateOfExport] FROM [STG].[TELEGRAPH_INDICES] GROUP BY EPIC)

	SELECT [A1].[EST_INVESTMENT_ID]
	, [A1].[EST_INVESTMENT_ID_COUNT]
	, [A1].[DateOfExport]
	, [A1].[IndexNameShort]
	, [A1].[IndexName]
	, [A1].[EPIC]
	, [A1].[Investment Name]
	, [A1].[Currency]
	, [A1].[Price]
	, [A1].[ABS_CHange]
	, [A1].[PCT_Change]
	FROM [STG].[TELEGRAPH_INDICES] A1 JOIN CTE B1 ON [A1].[EPIC] = [B1].[EPIC] AND [A1].[DateOfExport] = [B1].[MAXDateOfExport]


GO
/****** Object:  Table [STG].[TRUSTNET_ETF]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[TRUSTNET_ETF](
	[TRUSTNET_UNIQUE] [varchar](25) NULL,
	[FundCode] [varchar](25) NULL,
	[FundName] [varchar](255) NULL,
	[PriceName] [varchar](255) NULL,
	[Bid] [float] NULL,
	[Offer] [float] NULL,
	[Currency] [varchar](10) NULL,
	[YearHigh] [float] NULL,
	[YearLow] [float] NULL,
	[ClosureDate] [date] NULL,
	[EPICCode] [varchar](25) NULL,
	[ISINCode] [varchar](25) NULL,
	[CitiCode] [varchar](25) NULL,
	[SEDOL] [varchar](25) NULL,
	[Indice] [varchar](255) NULL,
	[Sector] [varchar](255) NULL,
	[AssetClass] [varchar](255) NULL,
	[FundSize] [varchar](255) NULL,
	[LaunchDate] [date] NULL,
	[DividendsPA] [int] NULL,
	[Fund_Counter] [tinyint] NULL,
	[Table_Counter] [tinyint] NULL,
	[DateLoaded] [datetime] NULL,
	[EST_INVESTMENT_ID] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20160927-122631]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20160927-122631] ON [STG].[TRUSTNET_ETF]
(
	[ClosureDate] ASC,
	[ISINCode] ASC,
	[CitiCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_TRUSTNET_ETF]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_TRUSTNET_ETF]
AS

	-- ============================================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	-- 1.1		20190227 Added SRCD
	-- 1.2		20190227 CHANGED ...	, CASE WHEN [Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	-- 1.2		20190228 Added AND [A1].[ClosureDate] = [B1].[ClosureDate] ON sub select ON SRCB
	--
	-- SELECT TOP (500) * FROM [STG].[v_TRUSTNET_ETF] WHERE [CTE_GBP_AND_COUNTER_EQ_ONESource] = 'SRCB' ORDER BY ClosureDate DESC
	-- SELECT * FROM [STG].[v_TRUSTNET_ETF]
	/*
	SELECT [CTE_GBP_AND_COUNTER_EQ_ONESource], COUNT(*)
	FROM [STG].[v_TRUSTNET_ETF]
	GROUP BY [CTE_GBP_AND_COUNTER_EQ_ONESource]
	*/
	-- SELECT distinct pricename FROM [STG].[v_TRUSTNET_ETF] WHERE CTE_GBP_AND_COUNTER_EQ_ONESOURCE = 'SRCD' -- 46 rows
	-- ============================================================================================================================================================================================================================

	/* IMPORTANT FOR FOLLOWING LOGIC ...

	select a_alias_type, b_alias_type, c_alias_type, count(*)
	from [DIM].[v_INVESTMENT_ALIAS_WITH_3_ALIASES]
	group by a_alias_type, b_alias_type , c_alias_type

	ISIN	CITICODE	SEDOL	6578

	select a_alias_type, b_alias_type, count(*)
	from [v_INVESTMENT_ALIAS_WITH_2]
	group by a_alias_type, b_alias_type

	ISIN		CITICODE	1255
	CITICODE	SEDOL		139
	ISIN		SEDOL		15
	*/

	WITH CTE_GBP_AND_COUNTER_EQ_ONE AS (
	SELECT 	[A1].[TRUSTNET_UNIQUE]
	, [A1].[EPICCode]
	, ISNULL([A1].[ISINCode],'') AS [ISINCode]
	, ISNULL([A1].[CitiCode],'') AS [CitiCode]
	, ISNULL([A1].[SEDOL],'') AS [SEDOL]
	, [A1].[Indice]
	, [A1].[Sector]
	, [A1].[Currency]
	, [A1].[FundCode]
	, [A1].[FundName]
	, [A1].[PriceName]
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[BID] / (100) ELSE [A1].[BID] END AS [Bid] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[Offer] / (100) ELSE [A1].[Offer] END AS [Offer] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[YearHigh] / (100) ELSE [A1].[YearHigh] END AS [YearHigh] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[YearLow] / (100) ELSE [A1].[YearLow] END AS [YearLow] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, [A1].[ClosureDate]
	, [A1].[AssetClass]

	-- 20180315
	, [A1].[FundSize] AS [FundSize_CHAR]
	, CASE WHEN REPLACE(REPLACE(LEFT(REPLACE(REPLACE([A1].[fundSize], 'Â',''),'n/a',''), CHARINDEX('/', REPLACE(REPLACE([fundSize], 'Â',''),'n/a',''))),'/',''), '£','') LIKE '[0-9]%m'
	  THEN CONVERT(FLOAT, REPLACE(REPLACE(REPLACE(LEFT(REPLACE(REPLACE([A1].[fundSize], 'Â',''),'n/a',''), CHARINDEX('/', REPLACE(REPLACE([fundSize], 'Â',''),'n/a',''))),'/',''), '£',''),'m','')) -- * (1000000)
	  ELSE CONVERT(FLOAT,REPLACE(REPLACE([A1].[FundSize], 'Â',''),'n/a','')) / (1000000) END AS [FundSize] -- STORED IN MILLIONS

	, [A1].[LaunchDate]
	, [A1].[DividendsPA]
	, [A1].[Fund_Counter]
	, [A1].[Table_Counter]
	, [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	FROM [STG].[TRUSTNET_ETF] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL	-- Added 20180228
	AND ([Currency] IN ('GBP','GBX'))		-- Added 20180306
	AND [Fund_Counter] = (1)
	),

	CTE_GBP_AND_COUNTER_NOT_EQ_ONE AS (
	SELECT [A1].[TRUSTNET_UNIQUE]
	, [A1].[EPICCode]
	, ISNULL([A1].[ISINCode],'') AS [ISINCode]
	, ISNULL([A1].[CitiCode],'') AS [CitiCode]
	, ISNULL([A1].[SEDOL],'') AS [SEDOL]
	, [A1].[Indice]
	, [A1].[Sector]
	, [A1].[Currency]
	, [A1].[FundCode]
	, [A1].[FundName]
	, [A1].[PriceName]
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[BID] / (100) ELSE [A1].[BID] END AS [Bid] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[Offer] / (100) ELSE [A1].[Offer] END AS [Offer] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[YearHigh] / (100) ELSE [A1].[YearHigh] END AS [YearHigh] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[YearLow] / (100) ELSE [A1].[YearLow] END AS [YearLow] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, [A1].[ClosureDate]
	, [A1].[AssetClass]

	-- 20180315
	, [A1].[FundSize] AS [FundSize_CHAR]
	, CASE WHEN REPLACE(REPLACE(LEFT(REPLACE(REPLACE([A1].[fundSize], 'Â',''),'n/a',''), CHARINDEX('/', REPLACE(REPLACE([fundSize], 'Â',''),'n/a',''))),'/',''), '£','') LIKE '[0-9]%m'
	  THEN CONVERT(FLOAT, REPLACE(REPLACE(REPLACE(LEFT(REPLACE(REPLACE([A1].[fundSize], 'Â',''),'n/a',''), CHARINDEX('/', REPLACE(REPLACE([fundSize], 'Â',''),'n/a',''))),'/',''), '£',''),'m','')) -- * (1000000)
	  ELSE CONVERT(FLOAT,REPLACE(REPLACE([A1].[FundSize], 'Â',''),'n/a','')) / (1000000) END AS [FundSize] -- STORED IN MILLIONS

	, [A1].[LaunchDate]
	, [A1].[DividendsPA]
	, [A1].[Fund_Counter]
	, [A1].[Table_Counter]
	, [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	FROM [STG].[TRUSTNET_ETF] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL	-- Added 20180228
	AND ([Currency] IN ('GBP','GBX'))		-- Added 20180306
	AND [Fund_Counter] <> (1)
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID] AND [A1].[ClosureDate] = [B1].[ClosureDate]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	)

	-- =======================================================================================================================================================
	-- GBP, GBX and FUND COUNTER = (1) - PRIME SELECTION
	-- =======================================================================================================================================================
	SELECT 'SRCA' AS [CTE_GBP_AND_COUNTER_EQ_ONESource], *
	FROM CTE_GBP_AND_COUNTER_EQ_ONE
	UNION

	-- =======================================================================================================================================================
	-- GBP, GBX and FUND COUNTER <> (1) - NOT PRIME SELECTION
	-- =======================================================================================================================================================
	SELECT 'SRCB', *
	FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE
	UNION

	-- =======================================================================================================================================================
	-- NONE - GBP, GBX and FUND COUNTER = (1) 
	-- =======================================================================================================================================================
	SELECT 'SRCC', [A1].[TRUSTNET_UNIQUE]
	, [A1].[EPICCode]
	, ISNULL([A1].[ISINCode],'') AS [ISINCode]
	, ISNULL([A1].[CitiCode],'') AS [CitiCode]
	, ISNULL([A1].[SEDOL],'') AS [SEDOL]
	, [A1].[Indice]
	, [A1].[Sector]
	, [A1].[Currency]
	, [A1].[FundCode]
	, [A1].[FundName]
	, [A1].[PriceName]
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[BID] / (100) ELSE [A1].[BID] END AS [Bid] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[Offer] / (100) ELSE [A1].[Offer] END AS [Offer] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[YearHigh] / (100) ELSE [A1].[YearHigh] END AS [YearHigh] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [A1].[Currency] = 'GBX' THEN [A1].[YearLow] / (100) ELSE [A1].[YearLow] END AS [YearLow] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, [A1].[ClosureDate]
	, [A1].[AssetClass]

	-- 20180315
	, [A1].[FundSize] AS [FundSize_CHAR]
	, CASE WHEN REPLACE(REPLACE(LEFT(REPLACE(REPLACE([A1].[fundSize], 'Â',''),'n/a',''), CHARINDEX('/', REPLACE(REPLACE([fundSize], 'Â',''),'n/a',''))),'/',''), '£','') LIKE '[0-9]%m'
	  THEN CONVERT(FLOAT, REPLACE(REPLACE(REPLACE(LEFT(REPLACE(REPLACE([A1].[fundSize], 'Â',''),'n/a',''), CHARINDEX('/', REPLACE(REPLACE([fundSize], 'Â',''),'n/a',''))),'/',''), '£',''),'m','')) -- * (1000000)
	  ELSE CONVERT(FLOAT,REPLACE(REPLACE([A1].[FundSize], 'Â',''),'n/a','')) / (1000000) END AS [FundSize] -- STORED IN MILLIONS

	, [A1].[LaunchDate]
	, [A1].[DividendsPA]
	, [A1].[Fund_Counter]
	, [A1].[Table_Counter]
	, [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]

	FROM [STG].[TRUSTNET_ETF] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL	-- Added 20180228
	AND [A1].[Fund_Counter] = (1)				-- Added 20180306
	AND [A1].[Currency] NOT IN ('GBP','GBX')		-- Added 20180416

	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])	-- SLOW !!

	-- =======================================================================================================================================================
	-- NONE - GBP, GBX and FUND COUNTER = (1) 
	-- =======================================================================================================================================================
	UNION
	
	SELECT 'SRCD', [A1].[TRUSTNET_UNIQUE]
	, [A1].[EPICCode]
	, ISNULL([A1].[ISINCode],'') AS [ISINCode]
	, ISNULL([A1].[CitiCode],'') AS [CitiCode]
	, ISNULL([A1].[SEDOL],'') AS [SEDOL]
	, [A1].[Indice]
	, [A1].[Sector]
	, [A1].[Currency]
	, [A1].[FundCode]
	, [A1].[FundName]
	, [A1].[PriceName]
	, CASE WHEN [Currency] = 'GBX' THEN [A1].[BID] / (100) ELSE [A1].[BID] END AS [Bid] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBX' THEN [A1].[Offer] / (100) ELSE [A1].[Offer] END AS [Offer] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBX' THEN [A1].[YearHigh] / (100) ELSE [A1].[YearHigh] END AS [YearHigh] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBX' THEN [A1].[YearLow] / (100) ELSE [A1].[YearLow] END AS [YearLow] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, [A1].[ClosureDate]
	, [A1].[AssetClass]

	-- 20180315
	, [A1].[FundSize] AS [FundSize_CHAR]
	, CASE WHEN REPLACE(REPLACE(LEFT(REPLACE(REPLACE([A1].[fundSize], 'Â',''),'n/a',''), CHARINDEX('/', REPLACE(REPLACE([fundSize], 'Â',''),'n/a',''))),'/',''), '£','') LIKE '[0-9]%m'
	  THEN CONVERT(FLOAT, REPLACE(REPLACE(REPLACE(LEFT(REPLACE(REPLACE([A1].[fundSize], 'Â',''),'n/a',''), CHARINDEX('/', REPLACE(REPLACE([fundSize], 'Â',''),'n/a',''))),'/',''), '£',''),'m','')) -- * (1000000)
	  ELSE CONVERT(FLOAT,REPLACE(REPLACE([A1].[FundSize], 'Â',''),'n/a','')) / (1000000) END AS [FundSize] -- STORED IN MILLIONS

	, [A1].[LaunchDate]
	, [A1].[DividendsPA]
	, [A1].[Fund_Counter]
	, [A1].[Table_Counter]
	, [A1].[DateLoaded]
	, [A1].[EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]

	FROM [STG].[TRUSTNET_ETF] A1
	WHERE [A1].[EST_INVESTMENT_ID] IS NOT NULL
	AND [A1].[Fund_Counter] <> (1)			
	AND [A1].[Currency] NOT IN ('GBP','GBX')

	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])	-- SLOW !!

	/*
	AUD
	BRL
	CAD
	CHF
	CNH
	CNY
	EUR
	GBP
	GBX
	HKD
	INR
	JPY
	KRW
	MXN
	MYR
	NOK
	NZD
	PLN
	SAR
	SEK
	SGD
	TWD
	USD
	*/




GO
/****** Object:  View [STG].[v_TRUSTNET_ETF_ALL_TO_LOAD]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [STG].[v_TRUSTNET_ETF_ALL_TO_LOAD]
AS

	-- ============================================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	--
	/*
	SELECT COUNT(*) FROM [STG].[v_TRUSTNET_ETF_ALL_TO_LOAD]
	SELECT COUNT(*) FROM [STG].[v_TRUSTNET_ETF_ALL_TO_LOAD_OLD_MATCH_TECHNIQUE]
	*/
	/*
	SELECT DISTINCT [TRUSTNET_UNIQUE], [ISINCode], [CitiCode], [SEDOL], [CURRENCY], [Fund_Counter]
	FROM [STG].[v_TRUSTNET_ETF_ALL_THAT_SHOULD_HAVE_BE_LOADED] WHERE [EST_INVESTMENT_ID] IS NULL
	AND [ISINCode]= 'US33733E6095'
	ORDER BY 4, 1 DESC, 2 DESC, 3 DESC

	SELECT * FROM [DIM].v_INVESTMENT_ALIAS WHERE LABEL IN ('US33733E6095','GRCX','B84J3B0')
	SELECT * FROM [DIM].[v_INVESTMENT_ALIAS_WITH_3_ALIASES] WHERE INVESTMENT_ID  = 51522
	SELECT * FROM [DIM].[v_INVESTMENT_ALIAS_WITH_2_ALIASES] WHERE INVESTMENT_ID  = 51522
	SELECT * FROM [DIM].[v_INVESTMENT_ALIAS_WITH_1_ALIAS] WHERE INVESTMENT_ID  = 51522
	*/

	/*
	FFS - BAD DATA .... SOMetime ISINCODE or CITICODE or SEDOL is missing
	... so is the investment unique by one of these or combination of all 3 ... ?????

	SELECT 
	[TRUSTNET_UNIQUE]
	, [PRICENAME]
	, [CURRENCY]
	, MAX(REPLACE([ISINCode],'n/a','')) AS [ISINCode]
	, MAX(REPLACE([CitiCode],'n/a','')) AS [CitiCode]
	, MAX(REPLACE([SEDOL],'n/a','')) AS [SEDOL]
	-- , [Fund_Counter]
	INTO #ATTEMPT_AT_UNIQUE_ETF_MANAGING_BAD_DATA -- DROP TABLE #ATTEMPT_AT_UNIQUE_ETF_MANAGING_BAD_DATA
	FROM [STG].[v_TRUSTNET_ETF_ALL_THAT_SHOULD_HAVE_BE_LOADED]
	-- WHERE TRUSTNET_UNIQUE]= 'GRFCX'
	WHERE [ClosureDate] > DATEADD(DD, -15, GETDATE()) -- 30
	GROUP BY	[TRUSTNET_UNIQUE]
	, [PRICENAME]
	, [CURRENCY]

	SELECT TRUSTNET_UNIQUE , COUNT(*)
	FROM #ATTEMPT_AT_UNIQUE_ETF_MANAGING_BAD_DATA
	GROUP BY TRUSTNET_UNIQUE
	HAVING COUNT(*) > (1)

	SELECT * FROM #ATTEMPT_AT_UNIQUE_ETF_MANAGING_BAD_DATA
	WHERE TRUSTNET_UNIQUE = '01F0I'

	SELECT * FROM [STG].[v_TRUSTNET_ETF_ALL_THAT_SHOULD_HAVE_BE_LOADED]
	WHERE TRUSTNET_UNIQUE = '01F0I'
	AND [ClosureDate] > DATEADD(DD, -30, GETDATE())
	ORDER BY [ClosureDate] DESC

CTE_GBP_AND_COUNTER_EQ_ONESource	TRUSTNET_UNIQUE	EPICCode	ISINCode	CitiCode	SEDOL	Indice	Sector	Currency	FundCode	FundName	PriceName	Bid	Offer	YearHigh	YearLow	ClosureDate	AssetClass	FundSize	LaunchDate	DividendsPA	Fund_Counter	Table_Counter	DateLoaded	EST_INVESTMENT_ID	EST_INVESTMENT_ID_CNT
SRCC	01F0I	NULL	US57060U4316	010I		NULL	NULL	USD	01F0I	VanEck Vectors Emerging Markets Aggregate Bond ETF	VanEck Vectors Emerging Markets Aggregate Bond ETF	0.218701	0.218701	NULL	NULL	2018-03-08	Fixed Interest	1.559e+007	2011-05-11	NULL	1	1	2018-03-10 21:07:34.470	41807	1
SRCC	01F0I	NULL	US57060U4316	010I		NULL	NULL	USD	01F0I	Market Vectors Emerging Markets Aggregate Bond ETF	Market Vectors Emerging Markets Aggregate Bond ETF	0.218411	0.218411	NULL	NULL	2018-03-01	Fixed Interest	1.559e+007	2011-05-11	NULL	1	1	2018-03-06 12:21:07.903	41807	1

	DROP TABLE #ATTEMPT_AT_UNIQUE_ETF_MANAGING_BAD_DATA
	*/
	-- ============================================================================================================================================================================================================================

	/* IMPORTANT FOR FOLLOWING LOGIC ...

	select a_alias_type, b_alias_type, c_alias_type, count(*)
	from [DIM].[v_INVESTMENT_ALIAS_WITH_3_ALIASES]
	group by a_alias_type, b_alias_type , c_alias_type

	ISIN	CITICODE	SEDOL	6578

	select a_alias_type, b_alias_type, count(*)
	from [v_INVESTMENT_ALIAS_WITH_2]
	group by a_alias_type, b_alias_type

	ISIN		CITICODE	1255
	CITICODE	SEDOL		139
	ISIN		SEDOL		15
	*/

	WITH CTE_GBP_AND_COUNTER_EQ_ONE AS (
	SELECT 	[TRUSTNET_UNIQUE]
	, [EPICCode]
	, ISNULL([ISINCode],'') AS [ISINCode]
	, ISNULL([CitiCode],'') AS [CitiCode]
	, ISNULL([SEDOL],'') AS [SEDOL]
	, [Indice]
	, [Sector]
	, [Currency]
	, [FundCode]
	, [FundName]
	, [PriceName]
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[YearHigh] ELSE [A1].[YearHigh] / (100) END AS [YearHigh] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[YearLow] ELSE [A1].[YearLow] / (100) END AS [YearLow] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, [ClosureDate]
	, [AssetClass]
	, [FundSize]
	, [LaunchDate]
	, [DividendsPA]
	, [Fund_Counter]
	, [Table_Counter]
	, [DateLoaded]
	, [EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	FROM [STG].[TRUSTNET_ETF] A1
	WHERE -- [EST_INVESTMENT_ID] IS NOT NULL	-- Added 20180228
	([Currency] IN ('GBP','GBX'))		-- Added 20180306
	AND [Fund_Counter] = (1)
	),

	CTE_GBP_AND_COUNTER_NOT_EQ_ONE AS (
	SELECT 	[TRUSTNET_UNIQUE]
	, [EPICCode]
	, ISNULL([ISINCode],'') AS [ISINCode]
	, ISNULL([CitiCode],'') AS [CitiCode]
	, ISNULL([SEDOL],'') AS [SEDOL]
	, [Indice]
	, [Sector]
	, [Currency]
	, [FundCode]
	, [FundName]
	, [PriceName]
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[YearHigh] ELSE [A1].[YearHigh] / (100) END AS [YearHigh] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[YearLow] ELSE [A1].[YearLow] / (100) END AS [YearLow] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, [ClosureDate]
	, [AssetClass]
	, [FundSize]
	, [LaunchDate]
	, [DividendsPA]
	, [Fund_Counter]
	, [Table_Counter]
	, [DateLoaded]
	, [EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	FROM [STG].[TRUSTNET_ETF] A1
	WHERE -- [EST_INVESTMENT_ID] IS NOT NULL	-- Added 20180228
	([Currency] IN ('GBP','GBX'))		-- Added 20180306
	AND [Fund_Counter] <> (1)
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	)

	-- =======================================================================================================================================================
	-- GBP, GBX and FUND COUNTER = (1) - PRIME SELECTION
	-- =======================================================================================================================================================
	SELECT 'SRCA' AS [CTE_GBP_AND_COUNTER_EQ_ONESource], *
	FROM CTE_GBP_AND_COUNTER_EQ_ONE

	UNION

	-- =======================================================================================================================================================
	-- GBP, GBX and FUND COUNTER <> (1) - NOT PRIME SELECTION
	-- =======================================================================================================================================================
	SELECT 'SRCB', *
	FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE
	UNION

	-- =======================================================================================================================================================
	-- NONE - GBP, GBX and FUND COUNTER = (1) 
	-- =======================================================================================================================================================
	SELECT 'SRCC', [TRUSTNET_UNIQUE]
	, [EPICCode]
	, ISNULL([ISINCode],'') AS [ISINCode]
	, ISNULL([CitiCode],'') AS [CitiCode]
	, ISNULL([SEDOL],'') AS [SEDOL]
	, [Indice]
	, [Sector]
	, [Currency]
	, [FundCode]
	, [FundName]
	, [PriceName]
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[BID] ELSE [A1].[BID] / (100) END AS [Bid] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[Offer] ELSE [A1].[Offer] / (100) END AS [Offer] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[YearHigh] ELSE [A1].[YearHigh] / (100) END AS [YearHigh] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, CASE WHEN [Currency] = 'GBP' THEN [A1].[YearLow] ELSE [A1].[YearLow] / (100) END AS [YearLow] -- Convert "GBX" and "p" to GBP -- 20180301 ... added very late !!!!!
	, [ClosureDate]
	, [AssetClass]
	, [FundSize]
	, [LaunchDate]
	, [DividendsPA]
	, [Fund_Counter]
	, [Table_Counter]
	, [DateLoaded]
	, [EST_INVESTMENT_ID]
	, (1) AS [EST_INVESTMENT_ID_CNT]
	-- SELECT DISTINCT [Currency] FROM [STG].[TRUSTNET_ETF] ORDER BY 1
	FROM [STG].[TRUSTNET_ETF] A1
	WHERE -- [EST_INVESTMENT_ID] IS NOT NULL	-- Added 20180228
	([Fund_Counter] = (1))				-- Added 20180306
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[EST_INVESTMENT_ID] = [B1].[EST_INVESTMENT_ID]) -- 20180418 [TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])

	/*
	AUD
	BRL
	CAD
	CHF
	CNH
	CNY
	EUR
	GBP
	GBX
	HKD
	INR
	JPY
	KRW
	MXN
	MYR
	NOK
	NZD
	PLN
	SAR
	SEK
	SGD
	TWD
	USD
	*/


GO
/****** Object:  View [STG].[v_TRUSTNET_ETF_LATEST_DATA]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [STG].[v_TRUSTNET_ETF_LATEST_DATA]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	April 2017
	-- Version History:
	-- 1.0
	-- 
	/*
	SELECT * FROM [STG].[v_TRUSTNET_ETF_LATEST_DATA]
	WHERE [ClosureDate] > DATEADD(DD, -(7), GETDATE())
	ORDER BY 2
	*/
	-- ==================================================================================================================================

	SELECT *
	FROM [STG].[v_TRUSTNET_ETF] A
	WHERE -- [Fund_Counter] = 1 AND
	[ClosureDate] = (SELECT MAX([ClosureDate]) FROM [STG].[v_TRUSTNET_ETF] B
							WHERE -- [A].[Fund_Counter] = [B].[Fund_Counter]
							-- AND [A].[FundCode] = [B].[FundCode]
							[A].[EST_INVESTMENT_ID] = [B].[EST_INVESTMENT_ID] --20180310
							)

							-- SLOW AND [A].[CITICODE] = [B].[CITICODE]
							-- SLOW AND [A].[ISINCode] = [B].[ISINCode])

GO
/****** Object:  View [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS]
AS

	-- ============================================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	
	-- Version History:
	-- 1.0		Initial Release
	--
	-- SELECT * FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS]
	/*
	SELECT TRUSTNET_UNIQUE, ISINCODE, COUNT(*) -- , CURRENCY
	FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS]
	GROUP BY TRUSTNET_UNIQUE, ISINCODE -- , CURRENCY
	HAVING COUNT(*) > (1)
-- 	ORDER BY 4 DESC, 3

	SELECT *
	FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS]
	WHERE TRUSTNET_UNIQUE = 'BAFV8'
	AND ISINCODE = 'FR0007052782'
	-- AND CURRENCY = 'USD'

	SELECT fund_counter, currency, * FROM [STG].[TRUSTNET_ETF]
	WHERE TRUSTNET_UNIQUE = 'MRFDM'
	AND ISINCODE = 'IE00BZ0PKV06'
	AND CURRENCY = 'GBP'
	AND [ClosureDate] > DATEADD(DD, -30, GETDATE())
	ORDER BY [ClosureDate] DESC
	*/
	-- ============================================================================================================================================================================================================================

	WITH CTE_GBP_AND_COUNTER_EQ_ONE AS (
	SELECT [TRUSTNET_UNIQUE]
	, [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	, ISNULL(MAX(REPLACE([ISINCode],'n/a','')),'') AS [ISINCode]
	, ISNULL(MAX(REPLACE([CitiCode],'n/a','')),'') AS [CitiCode]
	, ISNULL(MAX(REPLACE([SEDOL],'n/a','')),'') AS [SEDOL]
	FROM [STG].[TRUSTNET_ETF]
	WHERE [ClosureDate] > DATEADD(DD, -(14), GETDATE()) -- 30
	AND ([Currency] IN ('GBP','GBX'))		-- Added 20180306
	AND [Fund_Counter] = (1)
	GROUP BY [TRUSTNET_UNIQUE], [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	),

	CTE_GBP_AND_COUNTER_NOT_EQ_ONE AS (
	SELECT [TRUSTNET_UNIQUE]
	, [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	, ISNULL(MAX(REPLACE([ISINCode],'n/a','')),'') AS [ISINCode]
	, ISNULL(MAX(REPLACE([CitiCode],'n/a','')),'') AS [CitiCode]
	, ISNULL(MAX(REPLACE([SEDOL],'n/a','')),'') AS [SEDOL]
	FROM [STG].[TRUSTNET_ETF] A1
	WHERE [ClosureDate] > DATEADD(DD, -(14), GETDATE()) -- 30
	AND ([Currency] IN ('GBP','GBX'))
	AND [Fund_Counter] <> (1)
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	AND [Fund_Counter] = (SELECT MIN([Fund_Counter]) FROM [STG].[TRUSTNET_ETF] C1 WHERE [A1].[TRUSTNET_UNIQUE] = [C1].[TRUSTNET_UNIQUE] AND ([Currency] IN ('GBP','GBX')) AND [Fund_Counter] <> (1))
	GROUP BY [TRUSTNET_UNIQUE], [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	)

	SELECT 'SRCA' AS [CTE_GBP_AND_COUNTER_EQ_ONESource], *
	FROM CTE_GBP_AND_COUNTER_EQ_ONE
	UNION

	SELECT 'SRCB', *
	FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE
	UNION

	SELECT 'SRCC', [TRUSTNET_UNIQUE]
	, [PRICENAME] -- , [CURRENCY], [Fund_Counter]
	, ISNULL(MAX(REPLACE([ISINCode],'n/a','')),'') AS [ISINCode]
	, ISNULL(MAX(REPLACE([CitiCode],'n/a','')),'') AS [CitiCode]
	, ISNULL(MAX(REPLACE([SEDOL],'n/a','')),'') AS [SEDOL]
	-- , [Fund_Counter]
	FROM [STG].[TRUSTNET_ETF] A1
	WHERE [ClosureDate] > DATEADD(DD, -(14), GETDATE()) -- 30
	AND ([Fund_Counter] = (1))				-- Added 20180306
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_EQ_ONE B1 WHERE [A1].[TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	AND NOT EXISTS (SELECT 1 FROM CTE_GBP_AND_COUNTER_NOT_EQ_ONE B1 WHERE [A1].[TRUSTNET_UNIQUE] = [B1].[TRUSTNET_UNIQUE])
	GROUP BY [TRUSTNET_UNIQUE], [PRICENAME] -- , [CURRENCY], [Fund_Counter]

GO
/****** Object:  View [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS_WITH_EST_INVESTMENT_ID]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS_WITH_EST_INVESTMENT_ID]
AS

	-- =============================================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP#
	-- Created:	March 2018
	-- Version History:
	-- 1.0		Initial Release
	--
	-- NOTE:
	-- A1 change in PRICENAME will mean that 2 rows are shown for upto 'DATEADD(DD, -(14), GETDATE())  days
	--
	/*
	SELECT *
	INTO #A
	FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS_WITH_EST_INVESTMENT_ID]

	SELECT 'EXEC [ARC].[usp_DELETE_INVESTMENT] @BUILD_ID = 3222, @FORCE_DELETE_OF_YAHOO_COMBINED_PRICES = 1, @FORCE_RESET_OF_STG_TRUSNET = 1, @INVESTMENT_ID = '+convert(varchar, A.id)
	, crdate, *
	FROM [DIM].[v_INVESTMENT_SUBSET_NON_EQUITIES] A
	WHERE [INVESTMENT_TYPE_NAME] = 'Exchange Traded Fund'
	AND [ID] NOT IN (SELECT [INVESTMENT_ID] FROM #A)
	AND [ID] NOT IN (SELECT [INVESTMENT_ID] FROM [FCT].[YAHOO_COMBINED_PRICES])
	-- AND crdate > '24 Feb 2018'
	*/


	-- =============================================================================================================================================================================================================

	WITH CTE_MATCH_ON_THREE
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_3_ALIASES] B1 ON [A1].[ISINCode] = [B1].[A_LABEL] AND [A1].[CITICODE] = [B1].[B_LABEL] AND [A1].[SEDOL] = [B1].[C_LABEL])
	
	,CTE_MATCH_ON_ISIN_CITICODE
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_2_ALIASES] B1 ON [A1].[ISINCode] = [B1].[A_LABEL] AND [A1].[CITICODE] = [B1].[B_LABEL])

	,CTE_MATCH_ON_ISIN_SEDOL
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_2_ALIASES] B1 ON [A1].[ISINCode] = [B1].[A_LABEL] AND [A1].[SEDOL] = [B1].[B_LABEL])

	,CTE_MATCH_ON_CITICODE_SEDOL
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_2_ALIASES] B1 ON [A1].[CITICode] = [B1].[A_LABEL] AND [A1].[SEDOL] = [B1].[B_LABEL])

	,CTE_MATCH_ON_ONE
	AS (SELECT [B1].[INVESTMENT_ID], [A1].* FROM [STG].[v_TRUSTNET_ETF_MANAGE_BAD_DATA_IN_THREE_LABELS] A1
	JOIN [Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS_WITH_1_ALIAS] B1 ON [A1].[ISINCode] = [B1].[A_LABEL] OR [A1].[CITICODE] = [B1].[A_LABEL] OR [A1].[SEDOL] = [B1].[A_LABEL])

	SELECT 'FSRCA' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_THREE] A1
	UNION
	SELECT 'FSRCB' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_ISIN_CITICODE] A1
	UNION
	SELECT 'FSRCC' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_ISIN_SEDOL] A1
	UNION
	SELECT 'FSRCD' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_CITICODE_SEDOL] A1
	UNION
	SELECT 'FSRCE' AS [VIEW_SOURCE], [A1].* FROM [CTE_MATCH_ON_ONE] A1

GO
/****** Object:  Table [STG].[INVESTING_TECHNICAL]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[INVESTING_TECHNICAL](
	[Name] [nvarchar](255) NULL,
	[Symbol] [nvarchar](255) NULL,
	[PairId] [int] NULL,
	[ExportDate] [datetime] NULL,
	[period] [nvarchar](255) NULL,
	[summary] [nvarchar](255) NULL,
	[ma_summary] [nvarchar](255) NULL,
	[ma_buy] [nvarchar](255) NULL,
	[ma_sell] [nvarchar](255) NULL,
	[ti_summary] [nvarchar](255) NULL,
	[ti_buy] [nvarchar](255) NULL,
	[ti_sell] [nvarchar](255) NULL,
	[INVESTMENT_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_INVESTING_TECHNICAL_LATEST]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_INVESTING_TECHNICAL_LATEST]
AS
	WITH CTE AS (
	SELECT [SYMBOL], [PERIOD], MAX([ExportDate]) AS [ExportDate]
	FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL]
	GROUP BY [SYMBOL], [PERIOD])

 	SELECT A.* FROM
	[Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL] A
	JOIN CTE B ON [A].[SYMBOL] = [B].[SYMBOL] AND [A].[ExportDate] = [B].[ExportDate] AND [A].[period] = [B].[period]
GO
/****** Object:  Table [STG].[INVESTING_TECHNICAL-TI]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[INVESTING_TECHNICAL-TI](
	[Name] [nvarchar](255) NULL,
	[symbol] [nvarchar](255) NULL,
	[pairId] [int] NULL,
	[ExportDate] [datetime] NULL,
	[period] [nvarchar](255) NULL,
	[rsi_14_value] [float] NULL,
	[rsi_14_action] [nvarchar](255) NULL,
	[stoch_9_6_value] [float] NULL,
	[stoch_9_6_action] [nvarchar](255) NULL,
	[stoch_rsi_14_value] [float] NULL,
	[stoch_rsi_14_action] [nvarchar](255) NULL,
	[macd_12_26_value] [float] NULL,
	[macd_12_26_action] [nvarchar](255) NULL,
	[adx_14_value] [float] NULL,
	[adx_14_action] [nvarchar](255) NULL,
	[williams_r_value] [float] NULL,
	[williams_r_action] [nvarchar](255) NULL,
	[cci_14_value] [float] NULL,
	[cci_14_action] [nvarchar](255) NULL,
	[atr_14_value] [float] NULL,
	[atr_14_action] [nvarchar](255) NULL,
	[highs_lows_14_value] [float] NULL,
	[highs_lows_14_action] [nvarchar](255) NULL,
	[ultimate_oscillator_value] [float] NULL,
	[ultimate_oscillator_action] [nvarchar](255) NULL,
	[roc_value] [float] NULL,
	[roc_action] [nvarchar](255) NULL,
	[bull_bear_power_13_value] [float] NULL,
	[bull_bear_power_13_action] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  View [STG].[v_INVESTING_TECHNICAL_LATEST-TI]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_INVESTING_TECHNICAL_LATEST-TI]
AS

	-- 202010702 Added PERIOD

	-- SELECT COUNT(*) FROM [STG].[v_INVESTING_TECHNICAL-TI_LATEST]
	WITH CTE AS (
	SELECT [SYMBOL], [Period], MAX([ExportDate]) AS [ExportDate]
	FROM [Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL-TI]
	GROUP BY [SYMBOL], [Period])

 	SELECT A.* FROM
	[Alchemy_Stage_Data].[STG].[INVESTING_TECHNICAL-TI] A
	JOIN CTE B ON [A].[SYMBOL] = [B].[SYMBOL] AND [A].[ExportDate] = [B].[ExportDate] AND [A].[period] = [B].[period]
GO
/****** Object:  Table [STG].[HL_PORTFOLIO_SUMMARY]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[HL_PORTFOLIO_SUMMARY](
	[SIPP_ACCOUNT_ID] [int] NULL,
	[TradeDate] [date] NULL,
	[SettleDate] [date] NULL,
	[Reference] [varchar](255) NULL,
	[Description] [varchar](255) NULL,
	[UnitCost_GBX] [float] NULL,
	[Quantity] [float] NULL,
	[Value_GBP] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [STG].[MANUAL_INPUT_OF_INVESTMENT_CLOSE_PRICE]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[MANUAL_INPUT_OF_INVESTMENT_CLOSE_PRICE](
	[Symbol] [nvarchar](255) NOT NULL,
	[ClosureDate] [date] NOT NULL,
	[Close] [float] NULL,
	[INVESTMENT_NAME] [varchar](250) NULL,
	[DateLoaded] [datetime] NOT NULL,
	[INVESTMENT_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ClusteredIndex-20160720-172543]    Script Date: 16/02/2021 10:30:03 ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20160720-172543] ON [STG].[MANUAL_INPUT_OF_INVESTMENT_CLOSE_PRICE]
(
	[ClosureDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [STG].[YAHOO_FINANCE_STATISTICS]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[YAHOO_FINANCE_STATISTICS](
	[DateOfImport] [date] NULL,
	[INVESTMENT_ID] [int] NULL,
	[TICKER] [nvarchar](6) NULL,
	[Name] [nvarchar](50) NULL,
	[Name2] [nvarchar](255) NULL,
	[Date Of Export] [date] NULL,
	[MarketCapMillion] [float] NULL,
	[EnterpriseValueMillion] [float] NULL,
	[TrailingPE] [float] NULL,
	[ForwardPE] [float] NULL,
	[PEGRatio5YrExpected] [float] NULL,
	[PriceOverSale] [float] NULL,
	[PriceOverBook] [float] NULL,
	[EnterpriseValueOverRevenue] [float] NULL,
	[EnterpriseValueOverEBITDA] [float] NULL,
	[FiscalYearEnds] [date] NULL,
	[MostRecentQuarter] [date] NULL,
	[ProfitMarginPCT] [float] NULL,
	[OperatingMarginPCT] [float] NULL,
	[ReturnOnAssetsPCT] [float] NULL,
	[ReturnOnEquityPCT] [float] NULL,
	[RevenueMillion] [float] NULL,
	[RevenuePerShare] [float] NULL,
	[QuarterlyRevenueGrowthPCT_Yoy] [float] NULL,
	[GrossProfitMillion] [float] NULL,
	[EBITDAMillion] [float] NULL,
	[NetIncomeAviToCommonMillion] [float] NULL,
	[DilutedEPS] [float] NULL,
	[QuarterlyEarningsGrowthPCT_Yoy] [float] NULL,
	[TotalCashMillion] [float] NULL,
	[TotalCashPerShare] [float] NULL,
	[TotalDebtMillion] [float] NULL,
	[TotalDebtOverEquity] [float] NULL,
	[CurrentRatio] [float] NULL,
	[BookValuePerShare] [float] NULL,
	[OperatingCashFlowMillion] [float] NULL,
	[LeveredFreeCashFlowMillion] [float] NULL,
	[Beta3YMonthly] [float] NULL,
	[52WeekChange] [float] NULL,
	[SandP52WeekChange] [float] NULL,
	[52WeekHigh] [float] NULL,
	[52WeekLow] [float] NULL,
	[50DayMovingAverage] [float] NULL,
	[200DayMovingAverage] [float] NULL,
	[AvgVol3MonthMillion] [float] NULL,
	[AvgVol10dayMillion] [float] NULL,
	[SharesOutstandingMillion] [float] NULL,
	[SharesFloat] [float] NULL,
	[PCTHeldByInsiders] [float] NULL,
	[PCTHeldByInstitutions] [float] NULL,
	[SharesShort] [float] NULL,
	[ForwardAnnualDividendRate] [float] NULL,
	[ForwardAnnualDividendYieldPCT] [float] NULL,
	[TrailingAnnualDividendRate] [float] NULL,
	[TrailingAnnualDividendYieldPCT] [float] NULL,
	[5YearAverageDividendYield] [float] NULL,
	[PayoutRatio] [float] NULL,
	[DividendDate] [date] NULL,
	[ExDividendDate] [date] NULL,
	[LastSplitFactorNewPerOld] [nvarchar](255) NULL,
	[LastSplitDate] [date] NULL,
	[STATISTICS_ID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndexPK]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndexPK] ON [STG].[YAHOO_FINANCE_STATISTICS]
(
	[Date Of Export] ASC,
	[TICKER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [STG].[YAHOO_ONE_DAY_EXPORT]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[YAHOO_ONE_DAY_EXPORT](
	[Symbol] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Price] [decimal](18, 4) NULL,
	[Days_Low] [decimal](18, 4) NULL,
	[Days_High] [decimal](18, 4) NULL,
	[Change] [float] NULL,
	[Currency] [nvarchar](255) NULL,
	[P/E_Ratio] [nvarchar](255) NULL,
	[PEG_Ratio] [float] NULL,
	[52wk_low] [decimal](18, 4) NULL,
	[52wk_high] [decimal](18, 4) NULL,
	[50 day_moving avg] [money] NULL,
	[%age change from 50day avg] [float] NULL,
	[Dividend_Yield] [money] NULL,
	[Stock Exchange] [nvarchar](255) NULL,
	[ClosureDate] [date] NULL,
	[Dividend] [datetime] NULL,
	[DateLoaded] [datetime] NULL,
	[PREVIOUS_CLOSE] [decimal](18, 4) NULL,
	[OPEN_PRICE] [decimal](18, 4) NULL,
	[Volume] [bigint] NULL,
	[AverageDailyVolume] [bigint] NULL,
	[DividendPerShare] [decimal](18, 4) NULL,
	[MarketCapitalization] [bigint] NULL,
	[EPS_Estimate_Current_Year_GBX] [decimal](18, 4) NULL,
	[EPS_Estimate_Next_Year_GBX] [decimal](18, 4) NULL,
	[EPS_Estimate_Current_Quarter_GBX] [decimal](18, 4) NULL,
	[Price_per_EPS_Estimate_Current_Year_GBX] [decimal](18, 4) NULL,
	[Price_per_EPS_Estimate_Next_Year_GBX] [decimal](18, 4) NULL,
	[MCAP_Realtime] [bigint] NULL,
	[Revenue_GBP] [money] NULL,
	[One_Year_Target_Price_GBP] [money] NULL,
	[Shares_Outstanding] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_ClusteredIndex]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE CLUSTERED INDEX [PK_ClusteredIndex] ON [STG].[YAHOO_ONE_DAY_EXPORT]
(
	[ClosureDate] ASC,
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_001] ON [STG].[DIRECTOR]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_002]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IDX_002] ON [STG].[DIRECTOR]
(
	[EPIC] ASC,
	[DIRECTOR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_002]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_002] ON [STG].[DIRECTOR_DEALS]
(
	[Director_ID] ASC,
	[Dealt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_003]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_003] ON [STG].[DIRECTOR_DEALS]
(
	[Epic] ASC,
	[Declared] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_004]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_004] ON [STG].[DIRECTOR_DEALS]
(
	[Epic] ASC,
	[Dealt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_02]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [idx_02] ON [STG].[INVESTING_TECHNICAL]
(
	[PairId] ASC,
	[INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_03]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [idx_03] ON [STG].[INVESTING_TECHNICAL]
(
	[period] ASC,
	[PairId] ASC,
	[INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_04]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [idx_04] ON [STG].[INVESTING_TECHNICAL]
(
	[ExportDate] DESC,
	[INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_investment_id]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [idx_investment_id] ON [STG].[INVESTING_TECHNICAL]
(
	[INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX01]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX01] ON [STG].[INVESTING_TECHNICAL]
(
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX02]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX02] ON [STG].[INVESTING_TECHNICAL]
(
	[PairId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE NONCLUSTERED INDEX [PK_001] ON [STG].[INVESTING_TECHNICAL]
(
	[Symbol] ASC,
	[PairId] ASC,
	[ExportDate] ASC,
	[period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX01]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX01] ON [STG].[INVESTING_TECHNICAL-TI]
(
	[symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX02]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX02] ON [STG].[INVESTING_TECHNICAL-TI]
(
	[pairId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE NONCLUSTERED INDEX [PK_001] ON [STG].[INVESTING_TECHNICAL-TI]
(
	[symbol] ASC,
	[pairId] ASC,
	[ExportDate] ASC,
	[period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IDX_001] ON [STG].[TELEGRAPH_INDICES]
(
	[EPIC] ASC,
	[DateOfExport] ASC,
	[IndexNameShort] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Missing_IXNC_TELEGRAPH_SECTOR_DateOfExport_8C408]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TELEGRAPH_SECTOR_DateOfExport_8C408] ON [STG].[TELEGRAPH_SECTOR]
(
	[DateOfExport] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_TELEGRAPH_SECTOR_EPIC_DateOfExport_6FFB6]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TELEGRAPH_SECTOR_EPIC_DateOfExport_6FFB6] ON [STG].[TELEGRAPH_SECTOR]
(
	[EPIC] ASC,
	[DateOfExport] ASC
)
INCLUDE([Sector],[Name],[Price],[Market Cap],[EST_INVESTMENT_ID],[EST_INVESTMENT_ID_COUNT],[EST_SECTOR_ID],[EST_SECTOR_ID_COUNT]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Missing_IXNC_TELEGRAPH_SECTOR_EST_INVESTMENT_ID_DF05E]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TELEGRAPH_SECTOR_EST_INVESTMENT_ID_DF05E] ON [STG].[TELEGRAPH_SECTOR]
(
	[EST_INVESTMENT_ID] ASC
)
INCLUDE([EPIC],[Market Cap],[DateOfExport]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_001] ON [STG].[TRUSTNET_ETF]
(
	[ISINCode] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_002]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_002] ON [STG].[TRUSTNET_ETF]
(
	[SEDOL] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_003]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_003] ON [STG].[TRUSTNET_ETF]
(
	[CitiCode] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_006]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_006] ON [STG].[TRUSTNET_ETF]
(
	[ISINCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_007]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_007] ON [STG].[TRUSTNET_ETF]
(
	[SEDOL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_010]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_010] ON [STG].[TRUSTNET_ETF]
(
	[DateLoaded] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_011]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_011] ON [STG].[TRUSTNET_ETF]
(
	[EST_INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_012]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_012] ON [STG].[TRUSTNET_ETF]
(
	[Fund_Counter] ASC,
	[EST_INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_014]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_014] ON [STG].[TRUSTNET_ETF]
(
	[EST_INVESTMENT_ID] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_015]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_015] ON [STG].[TRUSTNET_ETF]
(
	[EST_INVESTMENT_ID] ASC,
	[Fund_Counter] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_016]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_016] ON [STG].[TRUSTNET_ETF]
(
	[TRUSTNET_UNIQUE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_017]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_017] ON [STG].[TRUSTNET_ETF]
(
	[Currency] ASC,
	[Fund_Counter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_018]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_018] ON [STG].[TRUSTNET_ETF]
(
	[CitiCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_ETF_CitiCode_576D3]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_ETF_CitiCode_576D3] ON [STG].[TRUSTNET_ETF]
(
	[CitiCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_ETF_Fund_Counter_DateLoaded_8653D]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_ETF_Fund_Counter_DateLoaded_8653D] ON [STG].[TRUSTNET_ETF]
(
	[Fund_Counter] ASC,
	[DateLoaded] ASC
)
INCLUDE([PriceName],[Bid],[Currency]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_ETF_ISIN_Citicode_SEDOL_3588B]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_ETF_ISIN_Citicode_SEDOL_3588B] ON [STG].[TRUSTNET_ETF]
(
	[ISINCode] ASC,
	[CitiCode] ASC,
	[SEDOL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [nci_wi_TRUSTNET_ETF_C2DE46408524CB479F82C1B552C30063]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [nci_wi_TRUSTNET_ETF_C2DE46408524CB479F82C1B552C30063] ON [STG].[TRUSTNET_ETF]
(
	[Fund_Counter] ASC,
	[EST_INVESTMENT_ID] ASC
)
INCLUDE([AssetClass],[Bid],[Currency],[DateLoaded],[DividendsPA],[EPICCode],[FundCode],[FundName],[FundSize],[Indice],[LaunchDate],[Offer],[PriceName],[Sector],[SEDOL],[Table_Counter],[TRUSTNET_UNIQUE],[YearHigh],[YearLow]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [nci_wi_TRUSTNET_ETF_D4410E0EC50513B2B512283897FD207A]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [nci_wi_TRUSTNET_ETF_D4410E0EC50513B2B512283897FD207A] ON [STG].[TRUSTNET_ETF]
(
	[EST_INVESTMENT_ID] ASC
)
INCLUDE([DateLoaded],[EPICCode],[Fund_Counter],[PriceName],[SEDOL],[Table_Counter],[TRUSTNET_UNIQUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE UNIQUE NONCLUSTERED INDEX [PK_001] ON [STG].[TRUSTNET_ETF]
(
	[ISINCode] ASC,
	[CitiCode] ASC,
	[SEDOL] ASC,
	[ClosureDate] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_001]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_001] ON [STG].[TRUSTNET_OEIC]
(
	[ISIN] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_002]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_002] ON [STG].[TRUSTNET_OEIC]
(
	[SEDOL] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_003]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_003] ON [STG].[TRUSTNET_OEIC]
(
	[Citicode] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_004]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_004] ON [STG].[TRUSTNET_OEIC]
(
	[Currency] ASC
)
INCLUDE([TRUSTNET_UNIQUE],[FundCode],[FundName],[PriceName],[table_counter],[Bid],[Offer],[SEDOL]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_005]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_005] ON [STG].[TRUSTNET_OEIC]
(
	[fund_counter] ASC
)
INCLUDE([FundCode],[Sector],[SEDOL]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_006]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_006] ON [STG].[TRUSTNET_OEIC]
(
	[ISIN] ASC
)
INCLUDE([TRUSTNET_UNIQUE],[FundCode],[FundName],[PriceName],[table_counter],[Currency],[Bid],[Offer],[SEDOL]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_007]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_007] ON [STG].[TRUSTNET_OEIC]
(
	[SEDOL] ASC
)
INCLUDE([TRUSTNET_UNIQUE],[FundCode],[FundName],[PriceName],[table_counter],[Currency],[Bid],[Offer]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_010]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_010] ON [STG].[TRUSTNET_OEIC]
(
	[DateLoaded] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_011]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_011] ON [STG].[TRUSTNET_OEIC]
(
	[EST_INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_012]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_012] ON [STG].[TRUSTNET_OEIC]
(
	[fund_counter] ASC,
	[EST_INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_014]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_014] ON [STG].[TRUSTNET_OEIC]
(
	[EST_INVESTMENT_ID] ASC,
	[ClosureDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_015]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_015] ON [STG].[TRUSTNET_OEIC]
(
	[EST_INVESTMENT_ID] ASC,
	[fund_counter] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_016]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_016] ON [STG].[TRUSTNET_OEIC]
(
	[TRUSTNET_UNIQUE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_017]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_017] ON [STG].[TRUSTNET_OEIC]
(
	[Currency] ASC,
	[fund_counter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_018]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IDX_018] ON [STG].[TRUSTNET_OEIC]
(
	[Citicode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_OEIC_Currency_DateLoaded_CBA01]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_OEIC_Currency_DateLoaded_CBA01] ON [STG].[TRUSTNET_OEIC]
(
	[Currency] ASC,
	[DateLoaded] ASC
)
INCLUDE([PriceName],[Bid],[SEDOL]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_OEIC_fund_counter_ClosureDate_EST_INVESTMENT_ID_AC953]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_OEIC_fund_counter_ClosureDate_EST_INVESTMENT_ID_AC953] ON [STG].[TRUSTNET_OEIC]
(
	[fund_counter] ASC,
	[ClosureDate] ASC,
	[EST_INVESTMENT_ID] ASC
)
INCLUDE([TRUSTNET_UNIQUE],[FundCode],[FundName],[PriceName],[table_counter],[Currency],[Bid],[Offer],[Citicode],[SEDOL],[ISIN],[DateLoaded],[Region],[Sector]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_OEIC_fund_counter_Currency_447FC]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_OEIC_fund_counter_Currency_447FC] ON [STG].[TRUSTNET_OEIC]
(
	[fund_counter] ASC,
	[Currency] ASC
)
INCLUDE([PriceName],[Bid],[ClosureDate],[Citicode],[SEDOL],[ISIN]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_OEIC_fund_counter_Currency_SEDOL_83FF0]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_OEIC_fund_counter_Currency_SEDOL_83FF0] ON [STG].[TRUSTNET_OEIC]
(
	[fund_counter] ASC,
	[Currency] ASC,
	[SEDOL] ASC
)
INCLUDE([PriceName],[Bid],[ClosureDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_OEIC_ISIN_Citicode_SEDOL_3588B]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_OEIC_ISIN_Citicode_SEDOL_3588B] ON [STG].[TRUSTNET_OEIC]
(
	[ISIN] ASC,
	[Citicode] ASC,
	[SEDOL] ASC
)
INCLUDE([TRUSTNET_UNIQUE],[FundCode],[FundName],[PriceName],[table_counter],[Currency],[Bid],[Offer]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_TRUSTNET_OEIC_TRUSTNET_UNIQUE_ClosureDate_6820D]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_TRUSTNET_OEIC_TRUSTNET_UNIQUE_ClosureDate_6820D] ON [STG].[TRUSTNET_OEIC]
(
	[TRUSTNET_UNIQUE] ASC,
	[ClosureDate] ASC
)
INCLUDE([fund_counter],[Citicode],[SEDOL],[ISIN],[EST_INVESTMENT_ID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [nci_wi_TRUSTNET_OEIC_D81BEA3D4DA71118322AE4DBD4BF156B]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [nci_wi_TRUSTNET_OEIC_D81BEA3D4DA71118322AE4DBD4BF156B] ON [STG].[TRUSTNET_OEIC]
(
	[EST_INVESTMENT_ID] ASC
)
INCLUDE([DateLoaded],[PriceName],[SEDOL],[table_counter],[TRUSTNET_UNIQUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [nci_wi_TRUSTNET_OEIC_DEF2E522DCFB2D1E0C54A88778411B81]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [nci_wi_TRUSTNET_OEIC_DEF2E522DCFB2D1E0C54A88778411B81] ON [STG].[TRUSTNET_OEIC]
(
	[fund_counter] ASC,
	[Currency] ASC
)
INCLUDE([Bid],[DateLoaded],[EST_INVESTMENT_ID],[FundCode],[FundName],[Offer],[PriceName],[Region],[Sector],[SEDOL],[table_counter],[TRUSTNET_UNIQUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_INVESTMENT_ID]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IX_INVESTMENT_ID] ON [STG].[YAHOO_FINANCE_STATISTICS]
(
	[INVESTMENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TICKER_DateOf_Export]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [IX_TICKER_DateOf_Export] ON [STG].[YAHOO_FINANCE_STATISTICS]
(
	[TICKER] ASC,
	[DateOfImport] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Missing_IXNC_YAHOO_ONE_DAY_EXPORT_DateLoaded_A7C52]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_YAHOO_ONE_DAY_EXPORT_DateLoaded_A7C52] ON [STG].[YAHOO_ONE_DAY_EXPORT]
(
	[DateLoaded] ASC
)
INCLUDE([Name],[Price],[Currency]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_YAHOO_ONE_DAY_EXPORT_Days_Low_Days_High_Stock Exchange_A31CF]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_YAHOO_ONE_DAY_EXPORT_Days_Low_Days_High_Stock Exchange_A31CF] ON [STG].[YAHOO_ONE_DAY_EXPORT]
(
	[Days_Low] ASC,
	[Days_High] ASC,
	[Stock Exchange] ASC
)
INCLUDE([Symbol],[ClosureDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_YAHOO_ONE_DAY_EXPORT_Symbol_Price_ClosureDate_BFC64]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_YAHOO_ONE_DAY_EXPORT_Symbol_Price_ClosureDate_BFC64] ON [STG].[YAHOO_ONE_DAY_EXPORT]
(
	[Symbol] ASC,
	[Price] ASC,
	[ClosureDate] ASC
)
INCLUDE([Name],[Days_Low],[Days_High],[Currency],[P/E_Ratio],[PEG_Ratio],[Dividend_Yield],[Stock Exchange],[DateLoaded],[PREVIOUS_CLOSE],[OPEN_PRICE],[Volume],[AverageDailyVolume],[DividendPerShare],[MarketCapitalization]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Missing_IXNC_YAHOO_ONE_DAY_EXPORT_Symbol_Price_EC6D0]    Script Date: 16/02/2021 10:30:03 ******/
CREATE NONCLUSTERED INDEX [Missing_IXNC_YAHOO_ONE_DAY_EXPORT_Symbol_Price_EC6D0] ON [STG].[YAHOO_ONE_DAY_EXPORT]
(
	[Symbol] ASC,
	[Price] ASC
)
INCLUDE([Days_Low],[Days_High],[52wk_low],[52wk_high]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [STG].[CURRENCY_EXCHANGE_RATES] ADD  CONSTRAINT [DF_CURRENCY_EXCHANGE_RATES_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [STG].[MANUAL_INPUT_OF_INVESTMENT_CLOSE_PRICE] ADD  CONSTRAINT [DF_MANUAL_INPUT_OF_INVESTMENT_CLOSE_PRICE_DateLoaded]  DEFAULT (getdate()) FOR [DateLoaded]
GO
ALTER TABLE [STG].[TRUSTNET_ADHOC_FUND_PRICES] ADD  CONSTRAINT [DF2_TRUSTNET_ADHOC_FUND_PRICES_DateLoaded]  DEFAULT (getdate()) FOR [DateLoaded]
GO
ALTER TABLE [STG].[TRUSTNET_ETF] ADD  CONSTRAINT [DF_TRUSTNET_ETF_DateLoaded]  DEFAULT (getdate()) FOR [DateLoaded]
GO
ALTER TABLE [STG].[TRUSTNET_OEIC] ADD  CONSTRAINT [DF_TRUSTNET_OEIC_DateLoaded]  DEFAULT (getdate()) FOR [DateLoaded]
GO
ALTER TABLE [STG].[YAHOO_ONE_DAY_EXPORT] ADD  CONSTRAINT [DF_YAHOO_ONE_DAY_EXPORT_DateLoaded2]  DEFAULT (getdate()) FOR [DateLoaded]
GO
/****** Object:  StoredProcedure [BLD].[SHRINK_Alchemy_Stage_Data_log]    Script Date: 16/02/2021 10:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- CREATE SCHEMA BLD

CREATE PROCEDURE [BLD].[SHRINK_Alchemy_Stage_Data_log]
AS
	-- =============================================================================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind -- [Tag] for further work is #EAHWIP# (Note: All prices stored IN GBP)
	-- Created:	August 2019
	-- Version History:
	-- 1.0		Initial Release
	-- =============================================================================================================================================================================================

	BEGIN
		IF (SELECT SUM([Size]) FROM sysfiles WHERE [NAME] LIKE '%log%') > (258) * (1024) -- select (2048) * (1024) -- select 4194304 / 1024 -- select (2048) * (1024) -- select (256) * (1024)
		BEGIN
			PRINT 'RUN DBCC SHRINKFILE'
			DBCC SHRINKFILE (N'Alchemy_Stage_Data_log' , 2048)
		END
		-- sp_helpdb alchemy_Stage_Data
		-- SELECT *  FROM sysfiles WHERE [NAME] LIKE '%log%'
	END
-- sp_helpdb Alchemy_Stage_Data

/*
DBCC execution completed. If DBCC printed error messages, contact your system administrator.
Cannot shrink log file 2 (Alchemy_Stage_Data_log) because requested size (2097152KB) is larger than the start of the last logical log file.
DbId   FileId      CurrentSize MinimumSize UsedPages   EstimatedPages
------ ----------- ----------- ----------- ----------- --------------
8      2           263168      1024        263168      1024

*/
GO
/****** Object:  StoredProcedure [dbo].[usp_FIND_OBJECTNAME]    Script Date: 16/02/2021 10:30:03 ******/
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
USE [master]
GO
ALTER DATABASE [Alchemy_Stage_Data] SET  READ_WRITE 
GO
