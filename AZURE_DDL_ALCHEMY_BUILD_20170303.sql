USE [master]
GO
/****** Object:  Database [Alchemy_Build]    Script Date: 03/03/2017 13:30:55 ******/
CREATE DATABASE [Alchemy_Build]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Alchemy_Build', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.ALCHEMY\MSSQL\DATA\Alchemy_Build.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Alchemy_Build_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.ALCHEMY\MSSQL\DATA\Alchemy_Build_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
ALTER DATABASE [Alchemy_Build] SET RECOVERY FULL 
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
EXEC sys.sp_db_vardecimal_storage_format N'Alchemy_Build', N'ON'
GO
ALTER DATABASE [Alchemy_Build] SET QUERY_STORE = OFF
GO
USE [Alchemy_Build]
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
USE [Alchemy_Build]
GO
/****** Object:  User [WORDPRESS_PHP]    Script Date: 03/03/2017 13:30:56 ******/
CREATE USER [WORDPRESS_PHP] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [sa_PowerBI]    Script Date: 03/03/2017 13:30:56 ******/
CREATE USER [sa_PowerBI] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [WORDPRESS_PHP]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa_PowerBI]
GO
/****** Object:  Schema [ARC]    Script Date: 03/03/2017 13:30:57 ******/
CREATE SCHEMA [ARC]
GO
/****** Object:  Schema [BLD]    Script Date: 03/03/2017 13:30:57 ******/
CREATE SCHEMA [BLD]
GO
/****** Object:  Schema [CFG]    Script Date: 03/03/2017 13:30:57 ******/
CREATE SCHEMA [CFG]
GO
/****** Object:  Schema [DIM]    Script Date: 03/03/2017 13:30:57 ******/
CREATE SCHEMA [DIM]
GO
/****** Object:  Schema [DQ]    Script Date: 03/03/2017 13:30:57 ******/
CREATE SCHEMA [DQ]
GO
/****** Object:  Schema [FCT]    Script Date: 03/03/2017 13:30:57 ******/
CREATE SCHEMA [FCT]
GO
/****** Object:  Schema [IMPORT]    Script Date: 03/03/2017 13:30:57 ******/
CREATE SCHEMA [IMPORT]
GO
/****** Object:  Schema [STG]    Script Date: 03/03/2017 13:30:57 ******/
CREATE SCHEMA [STG]
GO
/****** Object:  UserDefinedTableType [dbo].[InvestmentsToAdd]    Script Date: 03/03/2017 13:30:57 ******/
CREATE TYPE [dbo].[InvestmentsToAdd] AS TABLE(
	[SYMBOL] [varchar](250) NULL,
	[INVESTMENT_NAME] [varchar](250) NULL,
	[INVESTMENT_TYPE] [varchar](250) NULL,
	[SECTOR] [varchar](250) NULL,
	[MARKET] [varchar](250) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SymbolsToProcess]    Script Date: 03/03/2017 13:30:58 ******/
CREATE TYPE [dbo].[SymbolsToProcess] AS TABLE(
	[tColumn01] [varchar](250) NULL,
	[tColumn02] [varchar](250) NULL,
	[tDate] [date] NULL
)
GO
/****** Object:  View [FCT].[v_YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD]    Script Date: 03/03/2017 13:30:58 ******/
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
/****** Object:  View [STG].[v_BROKERFORECAST]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_BROKERFORECAST]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT  * FROM [STG].[v_BROKERFORECAST]
	-- ==================================================================================================================================

		SELECT DISTINCT [ï»¿Broker] AS [Broker]
		, [Company]
		, CONVERT(VARCHAR, [Start Date]) AS [Start Date_TXT]
		, CONVERT(DATE, [Start Date], 103) AS [Start Date]-- [Start Date] -- MAX([Start Date])
		, MAX([Action]) AS [Action]
		, MAX([Previous Recomm]) AS [Previous Recomm]
		, MAX([New Recomm]) AS [New Recomm]
		, MAX(CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Recomm Change]))) AS [Recomm Change]
		, MAX(CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Prev Target])))	AS [Prev Target]
		, MAX(CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([New Target])))	AS [New Target]
		, MAX(CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Share Price])))	AS [Share Price]
		, MAX(CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Target Change])))	AS [Target Change]
		, MAX(CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Our Score])))		AS [Our Score]

		FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[BROKERFORECAST#csv] B
		WHERE NOT EXISTS (SELECT (1) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[BROKERFORECAST] C
							WHERE [C].[Company]= [B].[Company]
							  AND [C].[StartDate] = CONVERT(DATE, [Start Date], 103)) -- [B].[Start Date])
		AND [ï»¿Broker] IS NOT NULL
		GROUP BY [ï»¿Broker]
		, [Company]
		, CONVERT(VARCHAR, [Start Date])
		, CONVERT(DATE, [Start Date], 103) -- [Start Date]


GO
/****** Object:  View [STG].[v_HL_EAH_ISA]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_HL_EAH_ISA]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT * FROM [STG].[v_HL_EAH_ISA]
	-- ==================================================================================================================================

		SELECT (8) AS [ISA_ACCOUNT_ID]
		, [Trade date], [Settle date], [Reference], [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))	AS [UnitCost_GBX]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))		AS [Quantity]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))		AS [Value_GBP]
		FROM -- OPENQUERY(HL_PORTFOLIO_SUMMARY, 'SELECT * FROM [KAH Porfolio Summary$]')
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_ISA_Capital_account$] B
		WHERE [Trade date] IS NOT NULL
		AND [REFERENCE] <> 'MANAGE FEE'
		UNION
		SELECT (8), [Trade date], [Settle date], [Reference], [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))
		FROM -- OPENQUERY(HL_PORTFOLIO_SUMMARY, 'SELECT * FROM [KAH Loyalty$]')
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_ISA_Loyalty$] B
		WHERE [Trade date] IS NOT NULL
		AND [REFERENCE] <> 'MANAGE FEE'



GO
/****** Object:  View [STG].[v_HL_EAH_SIPP]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_HL_EAH_SIPP]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT * FROM [STG].[v_HL_EAH_SIPP]
	-- ==================================================================================================================================

		SELECT (1) AS [SIPP_ACCOUNT_ID]
		, [Trade date]
		, [Settle date]
		, [Reference]
		, [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))	AS [UnitCost_GBX]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))		AS [Quantity]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))		AS [Value_GBP]
		FROM -- OPENQUERY(HL_PORTFOLIO_SUMMARY, 'SELECT * FROM [EAH Porfolio Summary$]')
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_Porfolio_Summary$] B
		WHERE [Trade date] IS NOT NULL
		AND [REFERENCE] <> 'MANAGE FEE'
		UNION
		SELECT (1), [Trade date], [Settle date], [Reference], [Description]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))
		FROM
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[EAH_Loyalty$] B
		WHERE [Trade date] IS NOT NULL
		AND [REFERENCE] <> 'MANAGE FEE'


GO
/****** Object:  View [STG].[v_HL_KAH_SIPP]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_HL_KAH_SIPP]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT * FROM [STG].[v_HL_KAH_SIPP]
	-- ==================================================================================================================================

	SELECT (2) AS [SIPP_ACCOUNT_ID]
	, [Trade date]
	, [Settle date]
	, [Reference]
	, [Description]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))	AS [UnitCost_GBX]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))		AS [Quantity]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))		AS [Value_GBP]
	FROM
	OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_Porfolio_Summary$] B
	WHERE [Trade date] IS NOT NULL
	AND [REFERENCE] <> 'MANAGE FEE'
	UNION
	SELECT (2), [Trade date], [Settle date], [Reference], [Description]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Unit cost (p)]))
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Quantity]))
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Value (£)]))
	FROM
	OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\HL_PORTFOLIO_SUMMARY.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[KAH_Loyalty$] B
	WHERE [Trade date] IS NOT NULL
	AND [REFERENCE] <> 'MANAGE FEE'



GO
/****** Object:  View [STG].[v_TELEGRAPH_INDICES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_TELEGRAPH_INDICES]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT TOP (100) * FROM [STG].[v_TELEGRAPH_SECTOR]
	--
	-- SELECT DISTINCT [EPIC], [NAME] FROM [STG].[v_TELEGRAPH_INDICES] WHERE [EST_INVESTMENT_ID] IS NULL
	-- SELECT TOP (100) * FROM [STG].[v_TELEGRAPH_INDICES] ORDER BY EPIC
	-- SELECT [INDICES], COUNT(*) FROM [STG].[v_TELEGRAPH_INDICES] GROUP BY [INDICES]
	-- ==================================================================================================================================

	SELECT [ï»¿Indice] AS [Indices]
	, [EPIC]
	, (SELECT DISTINCT [ID] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] A
		WHERE REPLACE([A].[PRIMARY_LABEL],'.','') = REPLACE([B].[EPIC],'.','')) AS [EST_INVESTMENT_ID]
	-- , MIN([Name]) AS [NAME]
	, [NAME]
	-- , MIN([DateOfExport]) AS [DateOfExport]
	, [DateOfExport]
	-- SELECT *
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[TELEGRAPH_INDICES#csv] B
	-- GROUP BY [EPIC]

	/*
	DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
	WHERE MARKET_ID = (SELECT ID FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[MARKET]  WHERE [MARKET_NAME] = 'FTSE100 (Equities)')

	INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
	([INVESTMENT_ID], [SECTOR_ID], [MARKET_ID])

	SELECT TOP (175) [A].[EST_INVESTMENT_ID]
	, [A].[SECTOR]
	, (SELECT ID FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[SECTORS] WHERE [SECTOR] = [A].[SECTOR])
	, [B].[Indices]
	, (SELECT ID FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[MARKET]  WHERE [MARKET_NAME] = 'FTSE100 (Equities)')
	FROM [STG].[v_TELEGRAPH_SECTOR] A, [STG].[v_TELEGRAPH_INDICES] B
	WHERE [A].[EST_INVESTMENT_ID] = [B].[EST_INVESTMENT_ID]
	AND [B].[Indices] = 'FTSE 100'

	*/



GO
/****** Object:  View [STG].[v_TELEGRAPH_SECTOR]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_TELEGRAPH_SECTOR]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT DMY
	--
	-- SELECT TOP (250) * FROM [STG].[v_TELEGRAPH_SECTOR] WHERE [EST_INVESTMENT_ID] IS NOT NULL ORDER BY [EPIC]
	-- ==================================================================================================================================

	SELECT [ï»¿Sector] AS [Sector]
	, (SELECT DISTINCT [ID] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] A
		WHERE REPLACE([A].[PRIMARY_LABEL],'.','') = REPLACE([B].[EPIC],'.','')) AS [EST_INVESTMENT_ID]
	, [EPIC]
	, [Name]
	, [Price] / (100) AS [PRICE_GBP] -- GBX TO GBP
	, [Market Cap]
	, [DateOfExport]
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[TELEGRAPH#csv] B



GO
/****** Object:  View [STG].[v_TRUSTNET_ETF]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [STG].[v_TRUSTNET_ETF]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT DMY !!
	--
	-- SELECT  * FROM [STG].[v_TRUSTNET_ETF]
	-- ==================================================================================================================================

	SELECT REPLACE(REPLACE([ï»¿FundCode], 'fundCode=',''),'&univ=E','') AS [TRUSTNET_UNIQUE]
	, [ï»¿FundCode] AS [FundCode]
	, [FundName]
	, [PriceName]
	, [Bid]
	, [Offer]
	, [Currency]
	, [Year High] AS [YearHigh]
	, [Year Low] AS [YearLow]
	, [Date] AS [ClosureDate], [EPICCode]
	, ISNULL([ISINCode],'') AS [ISINCode]
	, ISNULL([Citicode],'') AS [CitiCode]
	, ISNULL([SEDOL],'') AS [SEDOL]
	, [Indice]
	, [Sector]
	, [Asset Class] AS [AssetClass]
	, [Fund size] AS [FundSize]
	, [Launch date] AS [LaunchDate]
	, [Dividends p#a#] AS [DividendsPA]
	, [Fund_Counter]
	, [Table_Counter]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[TRUSTNET_ETF#csv] B
	WHERE [Date] IS NOT NULL



GO
/****** Object:  View [STG].[v_TRUSTNET_GREEK]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [STG].[v_TRUSTNET_GREEK] AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY
	--
	-- SELECT * FROM [STG].[v_TRUSTNET_GREEK]
	-- ==================================================================================================================================

	SELECT DISTINCT
		CONVERT(INT,SectorRowNumber) AS SectorRowNumber
		, ISNULL([B].[SectorName],'') AS SectorName -- EAH -- Why empty FROM Sunday April 3rd 2016?
		, [B].[FundName]
		, [B].[FundGroup]
		, CONVERT(INT,REPLACE([B].[FERiskScore],'n/a','')) AS [FERiskScore]
		-- , bid as orig_bid
		, CASE WHEN [BID] LIKE '%GBP%' OR [FundName] LIKE '%GBP%' THEN
			CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[BID]))
			ELSE (0.01) * CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[BID]))
		  END AS [BID_GBP]
		, CASE WHEN [BID] LIKE '%GBP%' OR [FundName] LIKE '%GBP%' THEN
			CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[OFFER]))
			ELSE (0.01) * CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[OFFER]))
		  END AS [OFFER_GBP]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[Yield])) AS Yield
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[v_1Year])) AS v_1Year
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[v_3Year])) AS v_3Year
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[v_5Year])) AS v_5Year

		, LEFT(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE([Alchemy_Functions].[dbo].[fnRemoveNumericCharacters]([BID]), '.', '')
		, ',', '') -- [E].g. 1,019.00
		, '(', '')	, ')', ''))),5) AS [CURRENCY]
		, DATEADD(DD, -1,  -- [B].[ExportDate]
		CONVERT(DATE, [B].[ExportDate], 103)) AS [ClosureDateEst]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\TRUSTNET_EXPORT_v01.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[DATA$] B
	WHERE CONVERT(FLOAT, ISNULL([Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([BID]),0)) <> 0
	AND CONVERT(DATE, [B].[ExportDate], 103) > '1 JAN 2000'

GO
/****** Object:  View [STG].[v_TRUSTNET_OEIC]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_TRUSTNET_OEIC]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY ??
	-- SET DATEFORMAT DMY
	--
	-- SELECT  * FROM [STG].[v_TRUSTNET_OEIC] WHERE ISNULL([EST_INVESTMENT_ID_COUNT],0) <> 1 ORDER BY 3 DESC
	-- ==================================================================================================================================

	SELECT DISTINCT REPLACE(REPLACE([ï»¿FundCode], 'fundCode=',''),'&univ=E','') AS [TRUSTNET_UNIQUE]
	, (SELECT TOP (1) [INVESTMENT_ID]
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A
		WHERE [A].[LABEL] = [B].[ISIN] OR [A].[LABEL] = [B].[SEDOL] OR [A].[LABEL] = [B].[CITICODE]) AS [EST_INVESTMENT_ID]

	, (SELECT COUNT(DISTINCT [INVESTMENT_ID])
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A
		WHERE [A].[LABEL] = [B].[ISIN] OR [A].[LABEL] = [B].[SEDOL] OR [A].[LABEL] = [B].[CITICODE]) AS [EST_INVESTMENT_ID_COUNT]

	, [ï»¿FundCode] AS [FundCode], [FundName], [PriceName], [Group], [Focus], [FE Risk Score], [fund_counter]
	, [table_counter], [ShareClass], [Unit Type], [Currency], [Bid], [Offer], [Date], [Yield]
	, [Citicode], [SEDOL], [ISIN], [Region], [Asset Class], [Investment Focus], [Sector]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[TRUSTNET_OEIC#csv] B
	WHERE [Date] IS NOT NULL
	AND [CURRENCY] IN ('GBP','GBX','p')
	-- ==================================================================================================================================
	-- GET THE HIGHEST IN LIST (lowest fund_Counter) GBP FUND
	-- ==================================================================================================================================
	AND [fund_counter] = (SELECT -- REPLACE(REPLACE([ï»¿FundCode], 'fundCode=',''),'&univ=E',''), 
							MIN([fund_counter])
							FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[TRUSTNET_OEIC#csv] A
							WHERE [Date] IS NOT NULL AND [CURRENCY] IN ('GBP','GBX','p')
							AND [A].[ï»¿FundCode] = [B].[ï»¿FundCode]
							GROUP BY [ï»¿FundCode])

/*
	AND ([Fund_Counter] = (1) -- 3130 rather than 9491

	-- ==================================================================================================================================
	-- SOMETIMES MULTICURRENCY HAS EUR\USD\CHF etc. AS [fund_counter] = 1 although we have GBP price
	-- e.g. https://www.trustnet.com/Factsheets/Factsheet.aspx?fundCode=T3EE&univ=SU
	-- ==================================================================================================================================
	OR 	EXISTS (SELECT 1
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A
		WHERE ([A].[LABEL] = [B].[ISIN] OR [A].[LABEL] = [B].[SEDOL] OR [A].[LABEL] = [B].[CITICODE])
		AND [B].[CURRENCY] IN ('GBP','GBX','p')
		)
	)
*/


GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_EQUITIES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [STG].[v_YAHOO_FINANCE_EQUITIES]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY -- REQUIRED ????
	--
	/*
	SELECT * FROM [STG].[v_YAHOO_FINANCE_EQUITIES] WHERE SYMBOL = 'CTAG'
	SELECT TOP (5000) * INTO #T1
	FROM [STG].[v_YAHOO_FINANCE_EQUITIES]
	SELECT MArketCapitalization, * FROM #T1 WHERE [LAST_TRADE_DATE] <> '10 Jan 2017' ORDER BY 1 DESC
	DROP TABLE #T1
	-- 
	-- ERROR:
	-- Msg 241, Level 16, State 1, Line 26
	-- Conversion failed when converting date and/or time from character string.
	-- WHERE CAST([LAST_TRADE_DATE] AS DATE) = CAST('10 Jan 2017' AS DATE)
	-- WHERE CONVERT(DATE, [C16], 101) = '10 Jan 2017'
	*/
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿c1], '.L', '')) AS [SYMBOL]
	, (SELECT DISTINCT [INVESTMENT_ID]
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A
		WHERE [A].[LABEL] = CONVERT(VARCHAR(50),REPLACE([B].[ï»¿c1], '.L', ''))) AS EST_INVESTMENT_ID

	, CONVERT(VARCHAR(250), [C2]) AS [NAME]
--	, CONVERT(FLOAT, [C3]) / (100) AS [LAST_TRADE_PRICE] 
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C3])) / (100) AS [LAST_TRADE_PRICE_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C4])) / (100) AS [DAYS_LOW_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C5])) / (100) AS [DAYS_HIGH_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C6])) AS [PCT_CHANGE]
	, UPPER(CONVERT(VARCHAR(50), [C7])) AS [CURRENCY]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C8])) AS [PE_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C9])) AS [PEG_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C10])) / (100) AS [LOW_52WEEK_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C11])) / (100) AS [HIGH_52WEEK_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C12])) / (100) AS [MOVING_AVG_50_DAY_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C13])) AS [PCT_CHANGE_FROM_50_DAY_MA]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C14])) AS [DIVIDEND_YIELD]
	, CONVERT(VARCHAR(250), [C15]) AS [STOCK_EXCHANGE]
	, [C16]

	, CONVERT(DATE, [C16], 101)  -- CAST([C16] AS DATE)
	  AS [LAST_TRADE_DATE]
	, CASE WHEN CONVERT(VARCHAR(25), [C17]) LIKE '1e-00[12345678]%' THEN 0.000001
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C17])) / (100)
	  END AS [OPEN_PRICE_GBP]

	, CASE WHEN CONVERT(VARCHAR(25), [C18]) LIKE '1e-00[12345678]%' THEN 0.000001
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C18])) / (100)
	  END AS [PREVIOUS_CLOSE_GBP]

	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C19])) AS [Commission]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C20])) AS [Volume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C21])) AS [AverageDailyVolume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C22])) AS [DividendPerShare]
	, CASE
	WHEN [c23] LIKE '%M' THEN 1000000 * CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	WHEN [c23] LIKE '%B' THEN 1000000000 * CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	END AS [MarketCapitalization]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_EQUITIES#csv] B
	WHERE [C2] IS NOT NULL
	AND CONVERT(VARCHAR(10), [C3])  NOT LIKE '[0-9]e-00[12345678]%' -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR(10), [C3])  <> 'N/A' -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR(10), [C16]) <> 'N/A' -- [LAST_TRADE_DATE]
	AND CONVERT(VARCHAR(50), [C7]) IS NOT NULL -- [Currency] 

GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_EQUITIES_ICHART]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_YAHOO_FINANCE_EQUITIES_ICHART]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY
	--
	-- PRICE COME THROUGH IN PENNIES !!!!!!
	-- SELECT TOP (50) * FROM [STG].[v_YAHOO_FINANCE_EQUITIES_ICHART] WHERE [SYMBOL] LIKE 'CTAG'
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿Investment], '.L', '')) AS [SYMBOL]
	, CONVERT(DATE, [Date]) AS [ClosureDate]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([OPEN]))   / (100) AS [OPEN_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([HIGH]))   / (100) AS [HIGH_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([LOW]))    / (100) AS [LOW_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([CLOSE]))  / (100) AS [CLOSE_GBP]
 	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([VOLUME])) / (1) AS [VOLUME]
 	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Adj Close])) / (100) AS [Adj Close_GBP]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_EQUITIES_ICHART#csv] B


GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_FUTURES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [STG].[v_YAHOO_FINANCE_FUTURES]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY -- REQUIRED ????
	--
	/*
	SELECT TOP (5000) * INTO #T1
	FROM [STG].[v_YAHOO_FINANCE_FUTURES]
	SELECT * FROM #T1 WHERE [LAST_TRADE_DATE] <> '10 Jan 2017'
	DROP TABLE #T1
	-- 
	-- ERROR:
	-- Msg 241, Level 16, State 1, Line 26
	-- Conversion failed when converting date and/or time from character string.
	-- WHERE CAST([LAST_TRADE_DATE] AS DATE) = CAST('10 Jan 2017' AS DATE)
	-- WHERE CONVERT(DATE, [C16], 101) = '10 Jan 2017'
	*/
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿c1], '.L', '')) AS [SYMBOL]
	, (SELECT DISTINCT [INVESTMENT_ID]
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A
		WHERE [A].[LABEL] = CONVERT(VARCHAR(50),REPLACE([B].[ï»¿c1], '.L', ''))) AS EST_INVESTMENT_ID

	, [C2] AS [NAME]
--	, CONVERT(FLOAT, [C3]) / (100) AS [LAST_TRADE_PRICE] 
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C3])) / (100) AS [LAST_TRADE_PRICE_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C4])) / (100) AS [DAYS_LOW_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C5])) / (100) AS [DAYS_HIGH_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C6])) AS [PCT_CHANGE]
	, UPPER([C7]) AS [CURRENCY]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C8])) AS [PE_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C9])) AS [PEG_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C10]))/ (100) AS [LOW_52WEEK_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C11])) / (100) AS [HIGH_52WEEK_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C12])) / (100) AS [MOVING_AVG_50_DAY_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C13])) AS [PCT_CHANGE_FROM_50_DAY_MA]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C14])) AS [DIVIDEND_YIELD]
	, [C15] AS [STOCK_EXCHANGE]
	, [C16]

	, CONVERT(DATE, [C16], 101)  -- CAST([C16] AS DATE)
	  AS [LAST_TRADE_DATE]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C17])) / (100) AS [OPEN_PRICE_GBP]

	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C18])) / (100) AS [PREVIOUS_CLOSE_GBP]

	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C19])) AS [Commission]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C20])) AS [Volume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C21])) AS [AverageDailyVolume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C22])) AS [DividendPerShare]
	, CASE
	WHEN [c23] LIKE '%M' THEN 1000000 * CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	WHEN [c23] LIKE '%B' THEN 1000000000 * CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	END AS [MarketCapitalization]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_FUTURES#csv] B
	WHERE [C2] IS NOT NULL
	AND CONVERT(VARCHAR(10), [C3])  NOT LIKE '[0-9]e-00[12345678]%' -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR(10), [C3]) <> 'N/A'  -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR(10), [C16]) <> 'N/A' -- LAST_TRADE_DATE





GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_FUTURES_ICHART]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [STG].[v_YAHOO_FINANCE_FUTURES_ICHART]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY
	--
	-- PRICE COME THROUGH IN PENNIES !!!!!!
	-- SELECT TOP (50) * FROM [STG].[v_YAHOO_FINANCE_FUTURES_ICHART] WHERE SYMBOL LIKE 'CTAG'
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿Investment], '.L', '')) AS [SYMBOL]
	, CONVERT(DATE, [Date]) AS [ClosureDate]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([OPEN]))   / (100) AS [OPEN_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([HIGH]))   / (100) AS [HIGH_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([LOW]))    / (100) AS [LOW_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([CLOSE]))  / (100) AS [CLOSE_GBP]
 	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([VOLUME])) / (1) AS [VOLUME]
 	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Adj Close])) / (100) AS [Adj Close_GBP]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_FUTURES_ICHART#csv] B


GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_INDICES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_YAHOO_FINANCE_INDICES]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY -- REQUIRED ????
	--
	/*
	SELECT TOP (5000) * INTO #T1
	FROM [STG].[v_YAHOO_FINANCE_INDICES]
	SELECT * FROM #T1 WHERE [LAST_TRADE_DATE] <> '10 Jan 2017'
	DROP TABLE #T1
	-- 
	-- ERROR:
	-- Msg 241, Level 16, State 1, Line 26
	-- Conversion failed when converting date and/or time from character string.
	-- WHERE CAST([LAST_TRADE_DATE] AS DATE) = CAST('10 Jan 2017' AS DATE)
	-- WHERE CONVERT(DATE, [C16], 101) = '10 Jan 2017'
	*/
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿c1], '.L', '')) AS [SYMBOL]
	, (SELECT DISTINCT [INVESTMENT_ID]
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A
		WHERE [A].[LABEL] = CONVERT(VARCHAR(50),REPLACE([B].[ï»¿c1], '.L', ''))) AS EST_INVESTMENT_ID

	, CONVERT(VARCHAR(500), [C2]) AS [NAME]
--	, CONVERT(FLOAT, [C3]) / (100) AS [LAST_TRADE_PRICE] 
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C3])) / (100) AS [LAST_TRADE_PRICE_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C4])) / (100) AS [DAYS_LOW_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C5])) / (100) AS [DAYS_HIGH_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C6])) AS [PCT_CHANGE]
	, UPPER(CONVERT(VARCHAR(50), [C7])) AS [CURRENCY]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C8])) AS [PE_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C9])) AS [PEG_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C10]))/ (100) AS [LOW_52WEEK_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C11])) / (100) AS [HIGH_52WEEK_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C12])) / (100) AS [MOVING_AVG_50_DAY_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C13])) AS [PCT_CHANGE_FROM_50_DAY_MA]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C14])) AS [DIVIDEND_YIELD]
	, CONVERT(VARCHAR(500), [C15]) AS [STOCK_EXCHANGE]
	, [C16]

	, CONVERT(DATE, [C16], 101)  -- CAST([C16] AS DATE)
	  AS [LAST_TRADE_DATE]
	, CASE WHEN CONVERT(VARCHAR(25), [C17]) LIKE '1e-00[12345678]%' THEN 0.000001
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C17])) / (100)
	  END AS [OPEN_PRICE_GBP]

	, CASE WHEN CONVERT(VARCHAR(25), [C18]) LIKE '1e-00[12345678]%' THEN 0.000001
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C18])) / (100)
	  END AS [PREVIOUS_CLOSE_GBP]

	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C19])) AS [Commission]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C20])) AS [Volume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C21])) AS [AverageDailyVolume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C22])) AS [DividendPerShare]
	, CASE
	WHEN [c23] LIKE '%M' THEN 1000000 * CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	WHEN [c23] LIKE '%B' THEN 1000000000 * CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	END AS [MarketCapitalization]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_INDICES#csv] B
	WHERE [C2] IS NOT NULL
	AND CONVERT(VARCHAR, [C3])  NOT LIKE '[0-9]e-00[12345678]%' -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR, [C3]) <> 'N/A'  -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR, [C16]) <> 'N/A' -- LAST_TRADE_DATE


GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_INDICES_ICHART]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_YAHOO_FINANCE_INDICES_ICHART]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY
	--
	-- PRICE COME THROUGH IN PENNIES !!!!!!
	-- SELECT TOP (50) * FROM [STG].[v_YAHOO_FINANCE_INDICES_ICHART] WHERE SYMBOL LIKE 'CTAG'
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿Investment], '.L', '')) AS [SYMBOL]
	, CONVERT(DATE, [Date]) AS [ClosureDate]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([OPEN]))   / (100) AS [OPEN_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([HIGH]))   / (100) AS [HIGH_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([LOW]))    / (100) AS [LOW_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([CLOSE]))  / (100) AS [CLOSE_GBP]
 	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([VOLUME])) / (1) AS [VOLUME]
 	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Adj Close])) / (100) AS [Adj Close_GBP]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_INDICES_ICHART#csv] B


GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_OEIC]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [STG].[v_YAHOO_FINANCE_OEIC]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY -- REQUIRED ????
	--
	/*
	SELECT TOP (5000) * INTO #T1
	FROM [STG].[v_YAHOO_FINANCE_OEIC]
	SELECT * FROM #T1 WHERE [LAST_TRADE_DATE] <> '10 Jan 2017'
	DROP TABLE #T1
	-- 
	-- ERROR:
	-- Msg 241, Level 16, State 1, Line 26
	-- Conversion failed when converting date and/or time from character string.
	-- WHERE CAST([LAST_TRADE_DATE] AS DATE) = CAST('10 Jan 2017' AS DATE)
	-- WHERE CONVERT(DATE, [C16], 101) = '10 Jan 2017'
	*/
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿c1], '.L', '')) AS [SYMBOL]
	, (SELECT DISTINCT [INVESTMENT_ID]
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A
		WHERE [A].[LABEL] = CONVERT(VARCHAR(50),REPLACE([B].[ï»¿c1], '.L', ''))) AS EST_INVESTMENT_ID

	, CONVERT(VARCHAR(250), [C2]) AS [NAME]
--	, CONVERT(FLOAT, [C3]) / (100) AS [LAST_TRADE_PRICE] 
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C3])) / (100) AS [LAST_TRADE_PRICE_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C4])) / (100) AS [DAYS_LOW_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C5])) / (100) AS [DAYS_HIGH_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C6])) AS [PCT_CHANGE]
	, UPPER(CONVERT(VARCHAR(50), [C7])) AS [CURRENCY]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C8])) AS [PE_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C9])) AS [PEG_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C10]))/ (100) AS [LOW_52WEEK_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C11])) / (100) AS [HIGH_52WEEK_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C12])) / (100) AS [MOVING_AVG_50_DAY_GBP]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C13])) AS [PCT_CHANGE_FROM_50_DAY_MA]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C14])) AS [DIVIDEND_YIELD]
	, CONVERT(VARCHAR(250), [C15]) AS [STOCK_EXCHANGE]
	, [C16]

	, CONVERT(DATE, [C16], 101)  -- CAST([C16] AS DATE)
	AS [LAST_TRADE_DATE]
	, CASE WHEN CONVERT(VARCHAR(25), [C17]) LIKE '1e-00[12345678]%' THEN (0.000001)
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C17])) / (100)
	  END AS [OPEN_PRICE_GBP]

	, CASE WHEN CONVERT(VARCHAR(25), [C18]) LIKE '1e-00[12345678]%' THEN (0.000001)
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C18])) / (100)
	  END AS [PREVIOUS_CLOSE_GBP]

	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C19])) AS [Commission]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C20])) AS [Volume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C21])) AS [AverageDailyVolume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C22])) AS [DividendPerShare]
	, CASE
	WHEN [c23] LIKE '%M' THEN 1000000 * CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	WHEN [c23] LIKE '%B' THEN 1000000000 * CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C23]))
	END AS [MarketCapitalization]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_OEIC#csv] B
	WHERE [C2] IS NOT NULL
	AND CONVERT(VARCHAR(10), [C3])  NOT LIKE '[0-9]e-00[12345678]%' -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR(10), [C3]) <> 'N/A'  -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR(10), [C16]) <> 'N/A' -- LAST_TRADE_DATE



GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_OEIC_ICHART]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [STG].[v_YAHOO_FINANCE_OEIC_ICHART]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY
	--
	-- PRICE COME THROUGH IN PENNIES !!!!!!
	-- SELECT TOP (50) * FROM [STG].[v_YAHOO_FINANCE_OEIC_ICHART] WHERE SYMBOL LIKE 'CTAG'
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿Investment], '.L', '')) AS [SYMBOL]
	, CONVERT(DATE, [Date]) AS [ClosureDate]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([OPEN]))   / (100) AS [OPEN_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([HIGH]))   / (100) AS [HIGH_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([LOW]))    / (100) AS [LOW_GBP]
 	, CONVERT(MONEY,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([CLOSE]))  / (100) AS [CLOSE_GBP]
 	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([VOLUME])) / (1) AS [VOLUME]
 	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Adj Close])) / (100) AS [Adj Close_GBP]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_OEIC_ICHART#csv] B


GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_OEIC_still_need_XLSM]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [STG].[v_YAHOO_FINANCE_OEIC_still_need_XLSM]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SELECT * FROM [STG].[v_YAHOO_FINANCE_OEIC_still_need_XLSM]
	-- ==================================================================================================================================

	SELECT DISTINCT REPLACE([Symbol], '.L', '') AS [Symbol]
	, [Name]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Price])) / (1) AS [Price]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Days_Low])) / (1) AS [Days_Low]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Days _High])) / (1) AS [Days _High]
	, CASE WHEN CONVERT(VARCHAR(25), [Change]) LIKE '%e-00[12345678]%' THEN (0.000001)
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Change])) / (1)
	  END AS [Change]
	, UPPER([Currency]) AS [Currency]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([P/E_Ratio])) / (1) AS [P/E_Ratio]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([PEG_Ratio])) / (1) AS [PEG_Ratio]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([52wk_low])) / (1) AS [52wk_low]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([52wk_high])) / (1) AS [52wk_high]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([50 day_moving avg])) / (1) AS [50 day_moving avg]
	, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([%age change FROM 50day avg])) AS [%age change FROM 50day avg]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Dividend_Yield])) / (1) AS [Dividend_Yield]
	, [Stock Exchange]
	, CONVERT(DATE, [Export Date]) AS [Export Date]
		
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 'Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\Yahoo_Finance_Export_OEIC_v01.xlsm;Excel 12.0;IMEX=1;HDR=YES;')...[ACTIVE$]

	WHERE CONVERT(VARCHAR(25),[PRICE]) <> 'N/A' AND [Currency] IS NOT NULL
	AND CONVERT(DATE,[Export Date]) > '1 JAN 2000'
	AND [Symbol] IS NOT NULL
	AND [PRICE] IS NOT NULL
	AND CONVERT(VARCHAR(25),[PRICE]) <> 'N/A'
	AND CONVERT(VARCHAR(25),[PRICE]) NOT LIKE '%[A-Za-z]%'

	AND LTRIM(RTRIM(ISNULL([Currency], ''))) NOT IN 
	('USD', 'JPY', 'EUX', 'USX', 'HKD', 'US', 'AUD', 'CAD', 'CHF', 'EU', 'JP', 'EUR', '(EUR)', '(USD)')


GO
/****** Object:  View [STG].[v_YAHOO_FINANCE_USD_CURRENCY]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [STG].[v_YAHOO_FINANCE_USD_CURRENCY]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- SET DATEFORMAT MDY -- REQUIRED ????
	--
	/*
	SELECT TOP (150) * INTO #T1
	FROM [STG].[v_YAHOO_FINANCE_USD_CURRENCY]
	SELECT * FROM #T1 WHERE [LAST_TRADE_DATE] <> '10 Jan 2017'
	DROP TABLE #T1
	-- 
	-- ERROR:
	-- Msg 241, Level 16, State 1, Line 26
	-- Conversion failed when converting date and/or time from character string.
	-- WHERE CAST([LAST_TRADE_DATE] AS DATE) = CAST('10 Jan 2017' AS DATE)
	-- WHERE CONVERT(DATE, [C16], 101) = '10 Jan 2017'
	*/

	/*
C1	s	symbol
C2	n	name
C3	l1	last trade price
C4	g	days low
C5	h	days high
C6	p2	pct change
C7	c4	currency
C8	r	p/e
C9	r2	p/e realtime
C10	j	52 week low
C11	k	52 week high
C12	m3	50 day mv avg
C13	m6	20 day
C14	y	dividend yield
C15	x	stock exchange
C16	d1	last trade date
C17	o	Open Price
C18	p	Previous Close
C19	c3	Commission
C20	v	Volume
C21	a2	Average Daily Volume
	*/
	-- ==================================================================================================================================

	SELECT CONVERT(VARCHAR(50),REPLACE([ï»¿c1], '.L', '')) AS [SYMBOL]
	, (SELECT DISTINCT [INVESTMENT_ID]
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS] A
		WHERE [A].[LABEL] = CONVERT(VARCHAR(50),REPLACE([B].[ï»¿c1], '.L', ''))) AS EST_INVESTMENT_ID

	, CONVERT(VARCHAR(250), [C2]) AS [NAME]
--	, CONVERT(FLOAT, [C3]) / (1) AS [LAST_TRADE_PRICE] 
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C3])) / (1) AS [LAST_TRADE_PRICE]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C4])) / (1) AS [DAYS_LOW]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C5])) / (1) AS [DAYS_HIGH]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C6])) AS [PCT_CHANGE]
	, UPPER(CONVERT(VARCHAR(50), [C7])) AS [CURRENCY]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C8])) AS [PE_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C9])) AS [PEG_RATIO]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C10]))/ (1) AS [LOW_52WEEK]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C11])) / (1) AS [HIGH_52WEEK]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C12])) / (1) AS [MOVING_AVG_50_DAY]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C13])) AS [PCT_CHANGE_FROM_50_DAY_MA]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C14])) AS [DIVIDEND_YIELD]
	, CONVERT(VARCHAR(250), [C15]) AS [STOCK_EXCHANGE]
	, [C16]

	, CONVERT(DATE, [C16], 101) -- CAST([C16] AS DATE)
	  AS [LAST_TRADE_DATE]
	, CASE WHEN CONVERT(VARCHAR(25), [C17]) LIKE '1e-00[12345678]%' THEN (0.000001)
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C17])) / (1)
	  END AS [OPEN_PRICE]

	, CASE WHEN CONVERT(VARCHAR(25), [C18]) LIKE '1e-00[12345678]%' THEN (0.000001)
	  ELSE CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C18])) / (1)
	  END AS [PREVIOUS_CLOSE]

	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C19])) AS [Commission]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C20])) AS [Volume]
	, CONVERT(FLOAT, [Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([C21])) AS [AverageDailyVolume]

	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[YAHOO_FINANCE_USD_CURRENCY#csv] B
	WHERE [C2] IS NOT NULL
	AND CONVERT(VARCHAR(10), [C3])  NOT LIKE '[0-9]e-00[12345678]%' -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR(10), [C3])  <> 'N/A' -- [LAST_TRADE_PRICE]
	AND CONVERT(VARCHAR(10), [C16]) <> 'N/A' -- [LAST_TRADE_DATE]


GO
/****** Object:  Table [BLD].[SQLMailLog]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BLD].[SQLMailLog](
	[SQLMailProfile] [varchar](255) NULL,
	[SendTo] [varchar](255) NULL,
	[CC] [varchar](255) NULL,
	[BCC] [varchar](255) NULL,
	[Subject] [varchar](255) NULL,
	[Body] [varchar](max) NULL,
	[Attachments] [varchar](max) NULL,
	[SendAsHTML] [bit] NULL,
	[SendAsCritical] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EAH]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EAH](
	[EST_INVESTMENT_ID] [int] NULL,
	[SECTOR] [nvarchar](255) NULL,
	[SECTOR_ID] [int] NULL,
	[Indices] [nvarchar](255) NULL,
	[MARKET_ID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_GET_DATA_FROM_XLS_and_PROCESS_IMPORT_ONLY]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_BUILD_GET_DATA_FROM_XLS_and_PROCESS_IMPORT_ONLY]
(@import_OEIC INT, @import_EQUITIES INT, @LOAD_ONE_EPIC_DATA INT, @import_TRUSTNET INT, @import_TRUSTNET_SEDOL INT
, @import_TRUSTNET_EXTRA INT, @import_TRUSTNET_ADHOC INT, @import_BROKER INT, @import_CURRENCY INT
, @import_INDICES INT, @import_FUTURES INT, @import_HL_EAH INT, @import_HL_KAH INT, @import_HL_EAH_ISA INT
, @import_TRUSTNET_ETF INT, @import_TRUSTNET_OEIC INT, @set_trustnet_blank_currency INT
, @build_fact INT, @build_ema INT, @db_maintenance INT, @final_checks INT
, @create_fact_trustnet_main INT, @UPDATE_PRICES_BY_FACTOR_OF_100s INT,  @import_TELEGRAPH_SECTOR INT)
WITH RECOMPILE
AS
BEGIN

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- ==================================================================================================================================

	SET NOCOUNT ON
	
	DECLARE @ErrorNumber INT, @ErrorLine INT,  @ErrorMessage NVARCHAR(4000), @RETVAL INT
	DECLARE @ErrorProc NVARCHAR(4000), @ErrorSev INT,  @ErrorState INT

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @vRE INT, @I_MSG VARCHAR(255), @I_MSG2 VARCHAR(255)
	DECLARE @WAIT_FOR_DELAY INT, @BUILD_ID INT, @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
	SET @WAIT_FOR_DELAY = (1)
	SET @BUILD_ID = ISNULL((SELECT MAX(BUILD_ID) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[LOAD_STATUS]),0) + 1

	IF (1) = (SELECT CHARINDEX(HOST_NAME(), @@servername))
	BEGIN
		RAISERROR ('I: OUTPUT = RAISERROR style',10,1) WITH NOWAIT 
		SET @VRE = (1)
	END
	ELSE
	BEGIN
		RAISERROR ('I: OUTPUT = PRINT style',10,1) WITH NOWAIT 
		SET @vRE = (0) -- IF LOCAL THEN RAISERROR ELSE PRINT
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG]  @BUILD_ID, @PARENT_USP, 'I:', 'START BUILD', @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES] @import_OEIC = @import_OEIC, @import_EQUITIES = @import_EQUITIES
		, @LOAD_ONE_EPIC_DATA = @LOAD_ONE_EPIC_DATA, @import_TRUSTNET = @import_TRUSTNET, @import_TRUSTNET_SEDOL = @import_TRUSTNET_SEDOL
		, @import_TRUSTNET_EXTRA =  @import_TRUSTNET_EXTRA, @import_TRUSTNET_ADHOC = @import_TRUSTNET_ADHOC, @import_BROKER = @import_BROKER
		, @import_HL_EAH = @import_HL_EAH, @import_HL_KAH = @import_HL_KAH, @import_CURRENCY = @import_CURRENCY, @import_INDICES = @import_INDICES
		, @import_FUTURES = @import_FUTURES, @import_HL_EAH_ISA = @import_HL_EAH_ISA, @import_TRUSTNET_ETF = @import_TRUSTNET_ETF
		, @import_TRUSTNET_OEIC = @import_TRUSTNET_OEIC, @import_TELEGRAPH_SECTOR = @import_TELEGRAPH_SECTOR, @BUILD_ID = @BUILD_ID
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- ==========================================================================================================================================
	-- ADDED 20170225
	-- ==========================================================================================================================================
	
	SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES] 0, 1'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES] @BUILD_ID, @vRE
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- ==========================================================================================================================================
	-- ADDED 20170213
	-- ==========================================================================================================================================

	SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS] 0, 1'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS]  @BUILD_ID, @vRE
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END
	
	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG]  @BUILD_ID, @PARENT_USP, 'I:', 'END BUILD', @vRE

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_ALL_FILES]
(@import_OEIC INT, @import_EQUITIES INT, @LOAD_ONE_EPIC_DATA INT, @import_TRUSTNET INT, @import_TRUSTNET_SEDOL INT
, @import_TRUSTNET_EXTRA INT, @import_TRUSTNET_ADHOC INT, @import_BROKER INT
, @import_HL_EAH INT, @import_HL_KAH INT, @import_CURRENCY INT, @import_INDICES INT, @import_FUTURES INT, @import_HL_EAH_ISA INT
, @import_TRUSTNET_ETF INT, @import_TRUSTNET_OEIC INT, @import_TELEGRAPH_SECTOR INT, @BUILD_ID INT)
WITH RECOMPILE
AS
BEGIN

	-- ==========================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	July 2016
	-- Version History:
	-- 1.0		Initial Release
	-- ==========================================================================================================================================

	SET DATEFORMAT DMY
	SET NOCOUNT ON
	
	DECLARE @I_MSG VARCHAR(255), @vRE INT, @PARENT_USP VARCHAR(250), @v_ROWCOUNT INT, @RETVAL INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SELECT @I_MSG = 'I: ' + CONVERT(VARCHAR(25),GETDATE(), 121)+ ' IF you get an error with LINKED SERVER - check file is NOT OPEN!!!!'
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG
	
	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[LOAD_ALERTS]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[LOAD_ALERTS]
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_HL_EAH_ISA = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA] @BUILD_ID, @vRE, 2 -- 2 rows expected as a minimum
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_HL_EAH = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP] @BUILD_ID, @vRE, 300 -- 300 rows expected as a minimum
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] HL_PORTFOLIO_EAH NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_HL_KAH = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP] @BUILD_ID, @vRE, 100 -- 100 rows expected as a minimum
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] HL_PORTFOLIO_KAH NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	IF @import_EQUITIES = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES] @BUILD_ID, @vRE, 1250
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_OEIC = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC] @BUILD_ID, @vRE, 2400 -- 2400 rows expected as a minimum
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_TRUSTNET_ETF = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF] @BUILD_ID, @vRE, 1250
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] TRUSTNET_ETF NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_TRUSTNET),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_TRUSTNET_SEDOL = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_SEDOL] TRUSTNET_SEDOL'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	
		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_SEDOL] @BUILD_ID, 'TRUSTNET_SEDOL', @vRE, 2900 -- 2900 rows expected as a minimum
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_BROKER = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_BROKERFORECAST]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			-- EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS] @BUILD_ID, 'BROKERFORECAST', @vRE, (0) -- 0 rows expected as a minimum
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_BROKERFORECAST] @BUILD_ID, @vRE, 0 -- 0 rows expected as a minimum
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_BROKERFORECAST] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_CURRENCY = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_CURRENCY]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_CURRENCY] @BUILD_ID, @vRE, 5
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_CURRENCY] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_INDICES = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES] @BUILD_ID, @vRE, 5
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILEINDICES] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_FUTURES = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES] @BUILD_ID, @vRE, 5
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_TELEGRAPH_SECTOR = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR] @BUILD_ID, @vRE, 1500
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS] TELEGRAPH_SECTOR NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_TRUSTNET),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_TRUSTNET_OEIC = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] @BUILD_ID, @vRE, 1250
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_TRUSTNET),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	IF @import_TRUSTNET = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_TRUSTNET]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_TRUSTNET] @BUILD_ID, @vRE, 2500 -- 2500 rows expected as a minimum
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_TRUSTNET] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_TRUSTNET),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
	END

	-- ==========================================================================================================================================
	-- ICHART (EQUITIES)
	-- ==========================================================================================================================================
	IF @import_EQUITIES = (1) AND (1) = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART] @BUILD_ID, @vRE, 1
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ICHART (OEIC)
	-- ==========================================================================================================================================
	IF @import_OEIC = (1) AND (1) = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC_ICHART]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC_ICHART] @BUILD_ID, @vRE, 1
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC_ICHART] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ICHART (INDICES)
	-- ==========================================================================================================================================
	IF @import_INDICES = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES_ICHART]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES_ICHART] @BUILD_ID, @vRE, 0 
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES_ICHART] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ICHART (FUTURES)
	-- ==========================================================================================================================================
	IF @import_FUTURES = (1)
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES_ICHART]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES_ICHART] @BUILD_ID, @vRE, 0 
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
	ELSE
	BEGIN
		SELECT @I_MSG = 'EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES_ICHART] NOT REQUIRED: ' + ISNULL(CONVERT(VARCHAR(1),@import_OEIC),'WTF')
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'W:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	BEGIN
		SET @I_MSG = 'EXEC [Alchemy_Build].[DQ].[usp_SET_LARGE_CHANGEPCT_COMBINED_PRICES_FROM_TELEGRAPH_SECTOR]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			EXEC @RETVAL = [Alchemy_Build].[DQ].[usp_SET_LARGE_CHANGEPCT_COMBINED_PRICES_FROM_TELEGRAPH_SECTOR] 0, 1
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END CATCH

		IF @RETVAL <> (0)
		BEGIN
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] (@BUILD_ID INT,  @vRE INT
, @InvestmentsToAdd dbo.InvestmentsToAdd READONLY)
-- , @INVESTMENT_TYPE VARCHAR(50), @SECTOR VARCHAR(50), @MARKET VARCHAR(50))
AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT MDY -- SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd -- , '%Futures%', '%KNOWN%', 'ALC%Futures%'
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250), @RETURN_VALUE INT
	DECLARE @SYMBOL VARCHAR(25), @NAME VARCHAR(250), @i_msg_fn VARCHAR(2500), @NEWLINE CHAR(2)
	DECLARE @INVESTMENT_TYPE VARCHAR(50), @SECTOR VARCHAR(50), @MARKET VARCHAR(50)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID), 'PROCID_UNKNOWN')
	SET @DEBUG = (1)
	SET @NEWLINE = CHAR(13) + CHAR(10)
	
	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS
	-- ==================================================================================================================================

	CREATE TABLE #NEW_INVESTMENTS ([Symbol] VARCHAR(25), [Name] VARCHAR(250), [INVESTMENT_TYPE] VARCHAR(50)
	, [SECTOR]  VARCHAR(100), [MARKET] VARCHAR(100))

	INSERT INTO #NEW_INVESTMENTS
	SELECT * FROM @InvestmentsToAdd

	SET @I_MSG = 'AUTO ADD INVESTMENTS via [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[dbo].[usp_ADD_INVESTMENT]:'
	+ (SELECT CONVERT(VARCHAR, COUNT(*)) FROM #NEW_INVESTMENTS) + ' rows.'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF 0 <> (SELECT COUNT(*) FROM #NEW_INVESTMENTS)
	BEGIN
		SET @i_msg = '['
		SELECT @i_msg = COALESCE(@i_msg+ '], [','[')
		+ [SYMBOL] + ':'
		+ [NAME] + ':'
		+ [INVESTMENT_TYPE] + ':'
		+ [SECTOR] + ':'
		+ [MARKET] + ':'
		+ ']' + @NEWLINE
		FROM #NEW_INVESTMENTS
		ORDER BY [NAME]

		SET @i_msg_fn =[Alchemy_Functions].[dbo].[fnHeaderAndFooterEmailCharacters](@i_msg)
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] '[BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] INVESTMENTS to add', @i_msg_fn
		-- @PARENT_USP
	END

	-- ==================================================================================================================================
	-- CURSOR THROUGH AND ADD THE INVESTMENT
	-- ==================================================================================================================================

	DECLARE db_cursor_investment CURSOR FOR
	SELECT [Symbol], [Name], [INVESTMENT_TYPE], [SECTOR], [MARKET] FROM #NEW_INVESTMENTS

	OPEN db_cursor_investment   
	FETCH NEXT FROM db_cursor_investment INTO @Symbol, @NAME, @INVESTMENT_TYPE, @SECTOR, @MARKET

	WHILE @@FETCH_STATUS = 0   
	BEGIN
		EXEC @RETURN_VALUE = [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[dbo].[usp_ADD_INVESTMENT] 
		@BUILD_ID, @vRE, @NAME, @SYMBOL, @INVESTMENT_TYPE, @SECTOR, @MARKET, 1, 0

		FETCH NEXT FROM db_cursor_investment INTO @Symbol, @NAME, @INVESTMENT_TYPE, @SECTOR, @MARKET

		IF @RETURN_VALUE <> 0
		BEGIN
			SET @I_MSG = 'EXEC [dbo].[usp_ADD_INVESTMENT]:' + @Symbol + ':' + @NAME
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
	END

	CLOSE db_cursor_investment   
	DEALLOCATE db_cursor_investment 

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #NEW_INVESTMENTS

END


GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_BROKERFORECAST]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_BROKERFORECAST] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- import data FROM Excel
	-- https://support.microsoft.com/en-gb/kb/321686#bookmark-4c
	-- http://www.excel-sql-server.com/excel-import-to-sql-server-using-linked-servers.htm

	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_BROKERFORECAST] 0, 1, 1

	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (0)
		
	-- ==============================================================================================================
	-- ==============================================================================================================
	IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
		DROP TABLE #SymbolsToProcess

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error CREATE TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT *
		INTO #ACTIVE
		FROM [STG].[v_BROKERFORECAST] -- in file and not in table

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess ('+ 'BROKERFORECAST)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO #SymbolsToProcess
		SELECT DISTINCT [Company], [Company], [Start Date]
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ====================================================================================================================
	-- STG
	-- ====================================================================================================================

	SET @I_MSG = 'EXEC [BLD].[usp_DELETE_STG_BROKERFORECAST_cursor]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	DECLARE @SymbolsToProcess AS dbo.SymbolsToProcess
	INSERT INTO @SymbolsToProcess
	SELECT * FROM #SymbolsToProcess

	BEGIN TRY
		EXEC @RETVAL = [BLD].[usp_DELETE_STG_BROKERFORECAST_cursor] @BUILD_ID, @vRE, @SymbolsToProcess, 1250
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- ==========================================================================================================
	-- ==========================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[BROKERFORECAST]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[BROKERFORECAST]
		SELECT DISTINCT GETDATE(), [Broker], [Company], [Start Date] , [Action], [Previous Recomm], [New Recomm]
		, [Recomm Change], [Prev Target], [New Target], [Share Price], [Target Change], [Our Score]
		FROM #ACTIVE B -- [STG].[v_BROKERFORECAST] B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID
		, 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[BROKERFORECAST]', @vRE
		RETURN (255)
	END CATCH
	
	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT BROKERFORECAST]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'ROWS INSERTED (BROKERFORECAST) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (' + 'BROKERFORECAST)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	DROP TABLE #SymbolsToProcess

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END


GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_SEDOL]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_SEDOL] (@BUILD_ID INT, @IMPORT_TYPE VARCHAR(25), @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	-- IF @IMPORT_TYPE IN ( 'CURRENCY') SET DATEFORMAT MDY ELSE 
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- import data FROM Excel
	-- https://support.microsoft.com/en-gb/kb/321686#bookmark-4c
	-- http://www.excel-sql-server.com/excel-import-to-sql-server-using-linked-servers.htm

	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS] 0, 'TRUSTNET_OEIC', 1, 10

	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT_A INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @sqlCommand_CURR VARCHAR(1000), @PARENT_USP VARCHAR(250), @v_ROWCOUNT_B INT

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	IF @IMPORT_TYPE NOT IN ('TRUSTNET_SEDOL')
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Invalid IMPORT CLASS eg. ''EQ''', @vRE
		RETURN (255)
	END

	-- ==============================================================================================================
	-- ==============================================================================================================
	IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
		DROP TABLE #SymbolsToProcess

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error ALTER TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==============================================================================================================
	-- ALTER "PHRASE" TO IGNORE FOREIGN CURRENCY
	-- ==============================================================================================================

	SET @sqlCommand_CURR = 'AND LTRIM(RTRIM(ISNULL([Currency],''''))) NOT IN (''USD'', ''JPY'',''EUX'',''USX'',''HKD'',''US'','
	SET @sqlCommand_CURR = @sqlCommand_CURR + '''AUD'',''CAD'',''CHF'',''EU'',''JP'',''EUR'',''(EUR)'',''(USD)'')'

	-- ==============================================================================================================
	-- ==============================================================================================================

	IF @IMPORT_TYPE = 'TRUSTNET_SEDOL'
	BEGIN
		SET @sqlCommand = 'SELECT DISTINCT [FundName], [LINK], GETDATE() FROM ' -- [FundName]
		SET @sqlCommand = @sqlCommand + 'OPENDATASOURCE(''Microsoft.ACE.OLEDB.12.0'',''Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\TRUSTNET_SEDOL_v01.xlsx;Excel 12.0;IMEX=1;HDR=YES;'')...[DATA$] B '
	END

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess ('+ @IMPORT_TYPE +')'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		-- SET @sqlCommand = 'DECLARE @RETVAL INT; INSERT INTO #SymbolsToProcess ' +@sqlCommand +'; SELECT @RETVAL= @@ERROR; SET @RETVAL OUTPUT'
		SET @sqlCommand = 'INSERT INTO #SymbolsToProcess ' +@sqlCommand
		IF @BUILD_ID = 0 PRINT @sqlCommand

		EXECUTE (@sqlCommand)
		-- EXECUTE sp_executesql @sqlCommand, @ret = @RETVAL OUTPUT

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT_A = @@rowcount

	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = @IMPORT_TYPE +' ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT_A)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================
	
	BEGIN TRY
		IF @IMPORT_TYPE IN ('TRUSTNET_SEDOL')
		BEGIN
			SET @I_MSG = @IMPORT_TYPE + ' DELETE data FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_SEDOL]'
			IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
			ELSE PRINT @I_MSG

			DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_SEDOL]
			FROM #SymbolsToProcess A, [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_SEDOL] B
			WHERE [A].[tColumn01] = [B].[FundName] AND [A].[tColumn02] = [B].[Link]

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT_A = @@rowcount
		END
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Delete ....', @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = @IMPORT_TYPE +' ROWS DELETED = '+CONVERT(VARCHAR(10),@v_ROWCOUNT_A)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE ' + @IMPORT_TYPE + ']' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	-- ==========================================================================================================
	-- ==========================================================================================================

	SET @I_MSG = @IMPORT_TYPE + ' LOAD DATA FROM XLSM'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================

	IF @IMPORT_TYPE = 'TRUSTNET_SEDOL'
	BEGIN
		BEGIN TRY
			INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_SEDOL]
			SELECT DISTINCT
			[FundName],
			[Citicode],
			[Sedol],
			[Region],
			[Asset class],
			[Investment focus],
			[Sector],
			[Isin],
			[Link],
--			[Currency],
			REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fnRemoveNumericCharacters]([Currency]),'.','')
			)), '(p)', 'GBX'), '(',''), ')','')
			
			FROM -- OPENQUERY(TRUSTNET_SEDOL_v01, 'SELECT * FROM [DATA$]') B
			OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\TRUSTNET_SEDOL_v01.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[DATA$] B

			WHERE LTRIM(RTRIM(ISNULL([Currency],''))) NOT IN ('USD', 'JPY','EUX','USX','HKD','US'
			,'AUD','CAD','CHF','EU','JP','EUR','(EUR)','(USD)')

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT_A = @@rowcount
		END TRY
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID
			, 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_SEDOL]', @vRE
			RETURN (255)
		END CATCH

		-- ======================================================================================================
		-- LTRIM RTRIM does not work on some data coming through that look LIKE blanks
		-- ======================================================================================================
		BEGIN TRY
			UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_SEDOL]
			SET [SEDOL] =[Alchemy_Functions].[dbo].[fnLeaveOnlyCharactersAZ09]([SEDOL])
			,[CITICODE] =[Alchemy_Functions].[dbo].[fnLeaveOnlyCharactersAZ09]([CITICODE])
			,[ISIN] =[Alchemy_Functions].[dbo].[fnLeaveOnlyCharactersAZ09]([ISIN])
			WHERE LEN([SEDOL]) > (7)
			OR LEN([CITICODE]) > (4)
			OR LEN([ISIN])> (12)
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID
			, 'UPDATE of TRUSTNET_SEDOL removing "blanks"', @vRE
			RETURN (255)
		END CATCH

	END

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = @IMPORT_TYPE +' ROWS INSERTED = '+CONVERT(VARCHAR(10),@v_ROWCOUNT_A)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT ' + @IMPORT_TYPE + ']' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	IF @v_ROWCOUNT_A < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (' + @IMPORT_TYPE + ')'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT_A)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #SymbolsToProcess

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = @IMPORT_TYPE +' THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END















GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_TRUSTNET]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_TRUSTNET] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	-- import data FROM Excel
	-- https://support.microsoft.com/en-gb/kb/321686#bookmark-4c
	-- http://www.excel-sql-server.com/excel-import-to-sql-server-using-linked-servers.htm
	--
	-- EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_GREEK_TRUSTNET] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==============================================================================================================
	-- ==============================================================================================================
	IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
		DROP TABLE #SymbolsToProcess

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error CREATE TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT *
		INTO #ACTIVE
		-- SELECT TOP (10) *
		FROM [STG].[v_TRUSTNET_GREEK]
		-- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\TRUSTNET_EXPORT_v01.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[DATA$]
	END TRY

		BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess ('+ 'GREEK_TRUSTNET)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SET @sqlCommand = 'INSERT INTO #SymbolsToProcess ' +@sqlCommand
		IF @BUILD_ID = 0 PRINT @sqlCommand

		INSERT INTO #SymbolsToProcess SELECT DISTINCT [FundName], [FundName], CONVERT(DATE, DATEADD(DD, -1, [B].[ClosureDateEst]))
		FROM #ACTIVE B -- OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Data Source=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\TRUSTNET_EXPORT_v01.xlsx;Excel 12.0;IMEX=1;HDR=YES;')...[DATA$] B
		-- WHERE CONVERT(FLOAT, ISNULL([Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Bid]),0)) <> 0
		-- AND CONVERT(DATE,[EXPORTDATE]) > '1 JAN 2000'
		-- EXECUTE (@sqlCommand)

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'DELETE [STG].[TRUSTNET_FUND_PRICES] (Name)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_FUND_PRICES]
		FROM #SymbolsToProcess A
		WHERE [A].[tColumn01] = [FundName]
		AND [ClosureDateEst] = [A].[tDate]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS DELETED (TRUSTNET_FUND_PRICES)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG


	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'DELETE [STG].[TRUSTNET_FUND_PRICES] (Fundname)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_FUND_PRICES]
		FROM #SymbolsToProcess A
		-- , [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_FUND_PRICES] B
		WHERE [A].[tColumn01] = [FundName]
		AND [ClosureDateEst] = [A].[tDate]
		-- AND CONVERT(DATE,[ClosureDateEst]) = CONVERT(DATE,[A].[tDate])

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS DELETED (TRUSTNET_FUND_PRICES) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================

	SET @I_MSG = 'BUILD #FUND_WITH_ONLY_ONE_SECTOR TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		-- ==========================================================================================================================================================
		-- GET DISTINCT FUND, SECTOR and DATE
		-- ==========================================================================================================================================================

		SELECT [FundName], MAX([SectorName]) AS [SectorName], [ClosureDateEst]
		INTO #FUND_WITH_ONLY_ONE_SECTOR -- .. bad data can give multi sector
		FROM #ACTIVE B
		WHERE -- CONVERT(FLOAT, ISNULL([Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([Bid]),0)) <> 0
		-- AND CONVERT(DATE,[EXPORTDATE]) > '1 JAN 2000'
		-- AND 
		NOT EXISTS (SELECT (1) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_FUND_PRICES] C
						WHERE [C].[FundName]= [B].[FundName]
						AND [C].[ClosureDateEst] = [ClosureDateEst])
		GROUP BY [FundName], [ClosureDateEst]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================
	-- ==========================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_FUND_PRICES]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		-- ==========================================================================================================================================================
		-- INSERT INTO MAIN TABLE
		-- ==========================================================================================================================================================
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_FUND_PRICES]
		([SectorRowNumber], [SectorName], [FundName], [FundGroup], [FERiskScore], [Bid], [Offer], [Yield]
		, [v_1Year], [v_3Year], [v_5Year], [CURRENCY], [ClosureDateEst])

		SELECT DISTINCT
		CONVERT(INT,SectorRowNumber) AS [SectorRowNumber]
		, ISNULL([B].[SectorName],'') AS [SectorName] -- EAH -- Why empty FROM Sunday April 3rd 2016?
		, [B].[FundName]
		, [B].[FundGroup]
		, CONVERT(INT,REPLACE([B].[FERiskScore],'n/a','')) AS FERiskScore
		, [B].[BID_GBP] -- CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[BID_GBP]))
		, [B].[Offer_GBP] -- CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[Offer_GBP]))
		, [B].[Yield] -- CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[Yield]))
		, [B].[v_1Year] -- CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[v_1Year]))
		, [B].[v_3Year] -- CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[v_3Year]))
		, [B].[v_5Year] -- CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([B].[v_5Year]))

		, LEFT(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE([Alchemy_Functions].[dbo].[fnRemoveNumericCharacters]([BID_GBP]), '.', '')
		, ',', '') -- [E].g. 1,019.00
		, '(', '')	, ')', ''))),5) AS [CURRENCY]
		, [B].[ClosureDateEst] -- DATEADD(DD, -1, [B].[ExportDate]) AS [ClosureDateEst] -- ffs! 20160803

		FROM #ACTIVE B
		,#FUND_WITH_ONLY_ONE_SECTOR A

		WHERE [A].[FundName] = [B].[FundName]
		AND [A].[SectorName] = [B].[SectorName]
		AND [A].[ClosureDateEst] = [B].[ClosureDateEst] -- DATEADD(DD, -1, [B].[ExportDate])

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'ROWS INSERTED (TRUSTNET_FUND_PRICES) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (GREEK_TRUSTNET)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #SymbolsToProcess
	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_ISA] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT *
		INTO #ACTIVE
		FROM [STG].[v_HL_EAH_ISA]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- SHOULD REALLY BE A MERGE .....
	-- ==========================================================================================================
	
	BEGIN TRY
		BEGIN
			SET @I_MSG = 'DELETE [STG].[HL_PORTFOLIO_SUMMARY]'
			IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
			ELSE PRINT @I_MSG

			DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]
			WHERE [SIPP_ACCOUNT_ID] = (8)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE ' + 'HL_EAH_ISA]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG = 'ROWS DELETED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN
		BEGIN TRY
			INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]
			([SIPP_ACCOUNT_ID], [TradeDate], [SettleDate], [Reference],	[Description], [UnitCost_GBX],[Quantity], [Value_GBP])
			SELECT (8), [Trade date], [Settle date], [Reference], [Description]
			, [UnitCost_GBX]
			, [Quantity]
			, [Value_GBP]
			FROM #ACTIVE B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH
	END

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT HL_EAH_ISA]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'ROWS INSERTED (HL_PORTFOLIO_SUMMARY) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (HL_EAH_ISA)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2016
	-- Version History:
	-- 1.0		Initial Release
	-- import data FROM Excel
	--
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT *
		INTO #ACTIVE
		FROM [STG].[v_HL_EAH_SIPP]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- SHOULD REALLY BE A MERGE .....
	-- ==========================================================================================================
	BEGIN TRY
		SET @I_MSG = 'DELETE data FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]
		WHERE [SIPP_ACCOUNT_ID] = (1)

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG = 'ROWS DELETED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================

	BEGIN
		BEGIN TRY
			INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]
			([SIPP_ACCOUNT_ID], [TradeDate], [SettleDate], [Reference],	[Description], [UnitCost_GBX],[Quantity], [Value_GBP])
			SELECT 1, [Trade date], [Settle date], [Reference], [Description]
			, [UnitCost_GBX]
			, [Quantity]
			, [Value_GBP]
			FROM #ACTIVE B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID
			, 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO] EAH', @vRE
			RETURN (255)
		END CATCH
	END

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'ROWS INSERTED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (usp_BUILD_IMPORT_XLS_FILE_HL_EAH_SIPP)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT * 
		INTO #ACTIVE
		FROM [STG].[v_HL_KAH_SIPP]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- SHOULD REALLY BE A MERGE
	-- ==========================================================================================================
	
	BEGIN TRY
		BEGIN
			SET @I_MSG = 'DELETE data FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]'
			IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
			ELSE PRINT @I_MSG

			DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]
			WHERE SIPP_ACCOUNT_ID = (2)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE ' + 'usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG = 'ROWS DELETED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================
	BEGIN
		BEGIN TRY
			INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO_SUMMARY]
			([SIPP_ACCOUNT_ID], [TradeDate], [SettleDate], [Reference],	[Description], [UnitCost_GBX],[Quantity], [Value_GBP])
			SELECT 2, [Trade date], [Settle date], [Reference], [Description]
			, [UnitCost_GBX]
			, [Quantity]
			, [Value_GBP]
			FROM #ACTIVE B

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH
	END

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT ' + 'usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	-- ==============================================================================================================
	-- ==============================================================================================================

	SET @I_MSG = 'ROWS INSERTED (HL_PORTFOLIO_SUMMARY)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (' + 'usp_BUILD_IMPORT_XLS_FILE_HL_KAH_SIPP)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG
END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	-- import data FROM Excel
	-- https://support.microsoft.com/en-gb/kb/321686#bookmark-4c
	-- http://www.excel-sql-server.com/excel-import-to-sql-server-using-linked-servers.htm

	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TELEGRAPH_SECTOR] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [Sector], [EPIC], [Name], [PRICE_GBP], [Market Cap], [DateOfExport]
		INTO #ACTIVE
		FROM [STG].[v_TELEGRAPH_SECTOR]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- STG
	-- ==================================================================================================================================
	SET @I_MSG = 'DELETE [STG].[TELEGRAPH_SECTOR]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TELEGRAPH_SECTOR]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS DELETED (TELEGRAPH_SECTOR)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	--
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TELEGRAPH_SECTOR]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TELEGRAPH_SECTOR] ([Sector], [EPIC], [Name], [Price], [Market Cap], [DateOfExport])
		SELECT [Sector], [EPIC], [Name], [PRICE_GBP], [Market Cap], [DateOfExport]
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED (TELEGRAPH_SECTOR) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (TELEGRAPH_SECTOR)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	--
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_ETF] 0, 1, 5000
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT * INTO #ACTIVE
		FROM [STG].[v_TRUSTNET_ETF]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================
	IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
		DROP TABLE #SymbolsToProcess

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error CREATE TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess (TRUSTNET_ETF)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SET @sqlCommand = 'INSERT INTO #SymbolsToProcess ' +@sqlCommand
		IF @BUILD_ID = 0 PRINT @sqlCommand

		INSERT INTO #SymbolsToProcess SELECT DISTINCT [ISINCODE], [CITICODE], CONVERT(DATE, [B].[ClosureDate]) -- [Date])
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

	-- ==================================================================================================================================
	-- ==================================================================================================================================
	
	SET @I_MSG = 'DELETE [STG].[TRUSTNET_ETF]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_ETF]
		FROM #SymbolsToProcess A
		WHERE [A].[tColumn01] = [ISINCODE]
		AND [A].[tColumn02] = [CITICODE]
		AND [A].[tDate] = [ClosureDate]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS DELETED (TRUSTNET_ETF) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================
	-- ==========================================================================================================

	SET @I_MSG = 'PREPARE DATASET FOR INSERT INTO [STG].[TRUSTNET_ETF]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT * INTO #TRUSTNET_ETF
		FROM #ACTIVE
	
		SELECT [ClosureDate], [ISINCode], [CitiCode]
		INTO #DUPLICATES FROM #TRUSTNET_ETF
		GROUP BY [ClosureDate], [ISINCode], [CitiCode] HAVING COUNT(*) > 1
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH
		
	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_ETF]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_ETF] ([TRUSTNET_UNIQUE], [FundCode]
		, [FundName], [PriceName], [Bid], [Offer], [Currency], [YearHigh], [YearLow], [ClosureDate], [EPICCode]
		, [ISINCode], [CitiCode], [SEDOL], [Indice], [Sector], [AssetClass], [FundSize], [LaunchDate]
		, [DividendsPA], [Fund_Counter], [Table_Counter])
	
		SELECT DISTINCT [TRUSTNET_UNIQUE], [FundCode], [FundName], [PriceName], [Bid], [Offer], [Currency]
		, [YearHigh], [YearLow], [ClosureDate], [EPICCode], [ISINCode], [CitiCode], [SEDOL], [Indice], [Sector]
		, [AssetClass], [FundSize], [LaunchDate], [DividendsPA], [Fund_Counter], [Table_Counter]
	
		FROM #TRUSTNET_ETF A
		WHERE NOT EXISTS (SELECT (1) FROM #DUPLICATES B WHERE [A].[ClosureDate] = [B].[ClosureDate]
							AND [A].[ISINCode] = [B].[ISINCode] AND [A].[CitiCode] = [B].[CitiCode])
		OR 	(EXISTS (SELECT (1) FROM #DUPLICATES B WHERE [A].[ClosureDate] = [B].[ClosureDate]
							AND [A].[ISINCode] = [B].[ISINCode] AND [A].[CitiCode] = [B].[CitiCode]) AND [Fund_Counter] = 1)

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED (TRUSTNET_ETF)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (TRUSTNET_ETF)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #SymbolsToProcess
	DROP TABLE #TRUSTNET_ETF
	DROP TABLE #DUPLICATES

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
	-- ==================================================================================================================================

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

/*
	INSERT INTO @InvestmentsToAdd
	-- SELECT TOP (10) * FROM #ACTIVE
	SELECT DISTINCT [Symbol], [Name], '%Excha%', '%KNOWN%', '%Excha%'
	FROM #ACTIVE B
	WHERE [NAME] LIKE '[%A-Za-z]%'
	AND [SYMBOL] NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT])
	AND 1 = 0 -- nned to check currencies etc
	SKIP FOR NOW AS IT MAYBE ISINCode or CITICODE or SEDOL to add
*/
	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
	-- ==================================================================================================================================

	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END


GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_TRUSTNET_OEIC] 0, 1, 10
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250), @RETURN_VALUE INT

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
		DROP TABLE #SymbolsToProcess

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error CREATE TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT *
		INTO #ACTIVE -- DROP TABLE #ACTIVE
		FROM [STG].[v_TRUSTNET_OEIC]
		/*
		OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\ALCHEMY_SQL_DATA\EXCEL_FEEDS\;HDR=YES')...[TRUSTNET_OEIC#csv]
		WHERE [Date] IS NOT NULL
		AND [Fund_Counter] = (1) -- 3130 rather than 9491
		*/

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess (TRUSTNET_OEIC)'
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SET @sqlCommand = 'INSERT INTO #SymbolsToProcess ' +@sqlCommand
		IF @BUILD_ID = 0 PRINT @sqlCommand

		INSERT INTO #SymbolsToProcess SELECT DISTINCT [ISIN], [CITICODE], CONVERT(DATE, [B].[Date])
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		IF @I_MSG IS NULL SET @I_MSG = 'NULL MESSAGE: '+ISNULL(@PARENT_USP,'UNKNOWN USP(1)')
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================
	
	SET @I_MSG = 'DELETE [STG].[TRUSTNET_OEIC]'
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_OEIC]
		FROM #SymbolsToProcess A
		WHERE ISNULL([A].[tColumn01], '') = ISNULL([ISIN], '')
		AND ISNULL([A].[tColumn02], '') = ISNULL([CITICODE], '')
		AND [A].[tDate] = [ClosureDate]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		IF @I_MSG IS NULL SET @I_MSG = 'NULL MESSAGE: '+ISNULL(@PARENT_USP,'UNKNOWN USP(2)')
		-- IF @BUILD_ID IS NULL SET @BUILD_ID = 0
		-- IF @vRE IS NULL SET @VRE = (1)
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS DELETED (TRUSTNET_OEIC) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ERR <> (0)
	BEGIN
		SET @I_MSG = 'Error had occured [TRUSTNET_OEIC]' + ISNULL(CONVERT(VARCHAR(10),@v_ERR),'')
		-- IF @I_MSG IS NULL SET @I_MSG = 'NULL MESSAGE: '+ISNULL(@PARENT_USP,'UNKNOWN USP')
		-- IF @BUILD_ID IS NULL SET @BUILD_ID = 0
		-- IF @vRE IS NULL SET @VRE = (1)
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_OEIC]'
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[TRUSTNET_OEIC] ([TRUSTNET_UNIQUE]
		, [FundCode], [FundName], [PriceName], [Group]
		, [Focus], [FE Risk Score], [fund_counter], [table_counter], [ShareClass], [Unit Type], [Currency]
		, [Bid], [Offer], [ClosureDate], [Yield], [Citicode], [SEDOL], [ISIN], [Region], [Asset Class]
		, [Investment Focus], [Sector])

		SELECT DISTINCT -- REPLACE(REPLACE([ï»¿FundCode], 'fundCode=',''),'&univ=E','') AS [TRUSTNET_UNIQUE]
		[TRUSTNET_UNIQUE] -- 20170215
		, [FundCode] -- [ï»¿FundCode]
		, [FundName], [PriceName], [Group], [Focus], [FE Risk Score], [fund_counter]
		, [table_counter], [ShareClass], [Unit Type], [Currency], [Bid], [Offer], [Date], [Yield]
		, [Citicode], [SEDOL], [ISIN], [Region], [Asset Class], [Investment Focus], [Sector]

		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED (TRUSTNET_OEIC) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ERR <> (0)
	BEGIN
		SET @I_MSG = 'Error has occured [INSERT TRUSTNET_OEIC]' + CONVERT(VARCHAR(10),@v_ERR)
		-- IF @I_MSG IS NULL SET @I_MSG = 'NULL MESSAGE: '+ISNULL(@PARENT_USP,'UNKNOWN USP')
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (TRUSTNET_OEIC)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==============================================================================================================
	-- ==============================================================================================================

	DROP TABLE #SymbolsToProcess

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
	-- ==================================================================================================================================

	-- DECLARE @BUILD_ID INT, @vRE INT, @I_MSG VARCHAR(250); SET @BUILD_ID = 0; SET @VRE = (1)
	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	INSERT INTO @InvestmentsToAdd
	SELECT DISTINCT [ISIN], [PriceName], 'Fund', [SECTOR], 'IA (Unit Trusts & OEICS)'
	FROM #ACTIVE B
	WHERE [PriceName] LIKE '[%A-Za-z]%'
	AND [ISIN] IS NOT NULL
	AND [ISIN] NOT IN (SELECT [LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS])

	UNION

	SELECT DISTINCT [SEDOL], [PriceName], 'Fund', [SECTOR], 'IA (Unit Trusts & OEICS)'
	FROM #ACTIVE
	WHERE [PriceName] LIKE '[%A-Za-z]%'
	AND [ISIN] IS NULL
	AND [SEDOL] IS NOT NULL
	AND [SEDOL] NOT IN (SELECT [LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS])

	UNION

	SELECT DISTINCT [CitiCode], [PriceName], 'Fund', [SECTOR], 'IA (Unit Trusts & OEICS)'
	FROM #ACTIVE
	WHERE [PriceName] LIKE '[%A-Za-z]%'
	AND [ISIN] IS NULL
	AND [SEDOL] IS NULL
	AND [CitiCode] NOT IN (SELECT [LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS])

	UPDATE @InvestmentsToAdd SET [SECTOR] = 'IA ' + [SECTOR] WHERE [SECTOR] NOT LIKE 'IA %'

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
	-- ==================================================================================================================================

	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH
	
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END


GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_CURRENCY]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_CURRENCY] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	-- SET DATEFORMAT MDY -- DIFFERENT TO "NORMAL" !! 
	SET DATEFORMAT MDY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	-- import data FROM Excel
	-- https://support.microsoft.com/en-gb/kb/321686#bookmark-4c
	-- http://www.excel-sql-server.com/excel-import-to-sql-server-using-linked-servers.htm
	--
	-- 1.1		Using MarkMark exports via a VIEW
	-- exec [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_CURRENCY] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT *
		INTO #ACTIVE
		FROM [STG].[v_YAHOO_FINANCE_USD_CURRENCY]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error CREATE TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess (CURRENCY)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO #SymbolsToProcess
		SELECT DISTINCT 
		REPLACE([B].[SYMBOL],'=X', '') -- REPLACE([B].[LABEL],'=X', '')
		, REPLACE([B].[SYMBOL],'=X', '') -- REPLACE([B].[LABEL],'=X', '')
		, [LAST_TRADE_DATE] -- CONVERT(DATE, REPLACE([LAST_TRADE_DATE],'"','')) -- CONVERT(DATE, REPLACE([ClosureDate],'"',''))
		FROM #ACTIVE B -- [STG].[v_YAHOO_FINANCE_USD_CURRENCY] B
		ORDER BY 1 DESC

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================
	
	BEGIN TRY
		BEGIN
			SET @I_MSG = 'DELETE [STG].[CURRENCY_EXCHANGE_RATES]'
			IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
			ELSE PRINT @I_MSG

			DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[CURRENCY_EXCHANGE_RATES]
			FROM #SymbolsToProcess A
			WHERE [A].[tDate] = [ClosureDate]

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Delete ....', @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS DELETED (CURRENCY_EXCHANGE_RATES) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [DELETE CURRENCY]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'EXEC [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[CURRENCY_EXCHANGE_RATES]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	BEGIN
		BEGIN TRY
			INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[CURRENCY_EXCHANGE_RATES] ([LABEL], [ClosureDate], [ClosureRate])
			SELECT DISTINCT 
			REPLACE([SYMBOL],'=X', '') -- REPLACE([LABEL],'=X', '')
			, CONVERT(DATE, REPLACE([LAST_TRADE_DATE],'"','')) -- CONVERT(DATE, REPLACE([ClosureDate],'"',''))
			, [LAST_TRADE_PRICE] -- [ClosureRate]
			FROM #ACTIVE A -- [STG].[v_YAHOO_FINANCE_USD_CURRENCY] A
			ORDER BY 1 DESC
		END TRY

		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID
			, 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[HL_PORTFOLIO] CURRENCY', @vRE
			-- RETURN (255)
		END CATCH
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'ROWS INSERTED (CURRENCY_EXCHANGE_RATES)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT ' + 'CURRENCY]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (' + 'CURRENCY)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- 
	-- ==================================================================================================================================
	
	DROP TABLE #SymbolsToProcess

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
	-- ==================================================================================================================================

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	INSERT INTO @InvestmentsToAdd
	SELECT DISTINCT [Symbol], [Name], '%Curr%', '%KNOWN%', 'ALC%Curr%'
	FROM #ACTIVE B -- [STG].[v_YAHOO_FINANCE_INDICES] B
	WHERE [NAME] LIKE '[%A-Za-z]%'
	AND [SYMBOL] NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT])
	AND 1 = 0 -- CURRENCIES ARE STORED in [CURRENCY_EXCHANGE_RATES]

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
	-- ==================================================================================================================================

	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END



GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES] (@BUILD_ID INT,  @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT MDY -- SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	-- import data FROM Excel
	-- https://support.microsoft.com/en-gb/kb/321686#bookmark-4c
	-- http://www.excel-sql-server.com/excel-import-to-sql-server-using-linked-servers.htm
	--
	-- EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250), @RETURN_VALUE int

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID), 'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [SYMBOL]
		, [NAME]
		, MAX([LAST_TRADE_PRICE_GBP]) AS [LAST_TRADE_PRICE_GBP]
		, MAX([DAYS_LOW_GBP]) AS [DAYS_LOW_GBP]
		, MAX([DAYS_HIGH_GBP]) AS [DAYS_HIGH_GBP]
		, MAX([PCT_CHANGE]) AS [PCT_CHANGE]
		, [CURRENCY]
		, MAX([PE_RATIO]) AS [PE_RATIO]
		, MAX([PEG_RATIO]) AS [PEG_RATIO]
		, MAX([LOW_52WEEK_GBP]) AS [LOW_52WEEK_GBP]
		, MAX([HIGH_52WEEK_GBP]) AS [HIGH_52WEEK_GBP]
		, MAX([MOVING_AVG_50_DAY_GBP]) AS [MOVING_AVG_50_DAY_GBP]
		, MAX([PCT_CHANGE_FROM_50_DAY_MA]) AS [PCT_CHANGE_FROM_50_DAY_MA]
		, MAX([DIVIDEND_YIELD]) AS [DIVIDEND_YIELD]
		, [STOCK_EXCHANGE]
		, [LAST_TRADE_DATE]
		, MAX([OPEN_PRICE_GBP]) AS [OPEN_PRICE_GBP]
		, MAX([PREVIOUS_CLOSE_GBP]) AS [PREVIOUS_CLOSE_GBP]
		, MAX([Commission]) AS [Commission]
		, MAX([Volume]) AS [Volume]
		, MAX([AverageDailyVolume]) AS [AverageDailyVolume]
		, MAX([DividendPerShare]) AS [DividendPerShare]
		, MAX([MarketCapitalization]) AS [MarketCapitalization]
		INTO #ACTIVE
		FROM [STG].[v_YAHOO_FINANCE_EQUITIES]
		GROUP BY [SYMBOL], [NAME], [CURRENCY], [STOCK_EXCHANGE], [LAST_TRADE_DATE]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	--
	-- ==================================================================================================================================

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error CREATE TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess (YAHOO_EQ)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SET @sqlCommand = 'INSERT INTO #SymbolsToProcess ' +@sqlCommand
		IF @BUILD_ID = 0 PRINT @sqlCommand

		INSERT INTO #SymbolsToProcess
		SELECT DISTINCT [B].[Symbol], [B].[Symbol], [LAST_TRADE_DATE]
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- REPORT MISSING INVESTMENTS
	-- ==================================================================================================================================
	SET @I_MSG = 'CHECK FOR MISSING INVESTMENT ALIASES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF EXISTS (SELECT (1) FROM #SymbolsToProcess A WHERE [A].[tColumn01]
				NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT]))
	BEGIN
		SET @I_MSG = @PARENT_USP + ':New [Symbol]s required?'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		SELECT @i_message = [tColumn01] FROM #SymbolsToProcess A
		WHERE [A].[tColumn01]
		NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT])

		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @I_MSG, @i_message
	END
	
	-- ==================================================================================================================================
	-- STG
	-- ==================================================================================================================================

	SET @I_MSG = 'EXEC [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	DECLARE @SymbolsToProcess AS dbo.SymbolsToProcess
	INSERT INTO @SymbolsToProcess SELECT * FROM #SymbolsToProcess

	BEGIN TRY
		EXEC @RETVAL = [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor] @BUILD_ID, @vRE, @SymbolsToProcess, 5000 -- 2500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
		([Symbol], [Name], [Price], [Days_Low], [Days_High], [Change]
		, [Currency], [P/E_Ratio], [PEG_Ratio], [52wk_low], [52wk_high], [50 day_moving avg]
		, [%age change FROM 50day avg], [Dividend_Yield], [Stock Exchange], [ClosureDate]
		, [OPEN_PRICE], [PREVIOUS_CLOSE], [Volume], [AverageDailyVolume]
		, [DividendPerShare], [MarketCapitalization]
		)

		SELECT DISTINCT
		[B].[Symbol]
		, [Name]
		, [LAST_TRADE_PRICE_GBP]
		, [Days_Low_GBP]
		, [Days_High_GBP]
		, [PCT_CHANGE]
		, [Currency]
		, [PE_RATIO]
		, [PEG_RATIO]
		, [LOW_52WEEK_GBP]
		, [HIGH_52WEEK_GBP]
		, [MOVING_AVG_50_DAY_GBP]
		, [PCT_CHANGE_FROM_50_DAY_MA]
		, [Dividend_Yield]
		, [STOCK_EXCHANGE]
		, [LAST_TRADE_DATE]
		, [OPEN_PRICE_GBP]
		, [PREVIOUS_CLOSE_GBP]
		, [Volume]
		, [AverageDailyVolume]
		, [DividendPerShare]
		, [MarketCapitalization]

		FROM #ACTIVE B
		, #SymbolsToProcess D

		WHERE [B].[LAST_TRADE_DATE] = [D].[tDate] -- [Export Date]
		AND [B].[Symbol] = [D].[tColumn01]
		AND NOT EXISTS (SELECT (1) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] S
						WHERE [B].[Symbol] = [S].[Symbol]
						AND [B].[LAST_TRADE_DATE] = [S].[ClosureDate])

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'LOAD DATA FOR "YAHOO EQ"', @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED (YAHOO_ONE_DAY_EXPORT) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (' +  'YAHOO_EQ )'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #SymbolsToProcess

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
	-- ==================================================================================================================================

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	INSERT INTO @InvestmentsToAdd
	SELECT DISTINCT [Symbol], [Name], '%EQU%', '%KNOWN%', '%EQU%'
	FROM #ACTIVE B
	WHERE [NAME] LIKE '[%A-Za-z]%'
	AND [SYMBOL] NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT])

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
	-- ==================================================================================================================================

	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END


GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART] (@BUILD_ID INT, @vRE INT, @UPDATE_OPEN_PRICE INT) AS
BEGIN	

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version HistoryEQUITIES
	-- 1.0		Initial Release
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_EQUITIES_ICHART] 0, 1, 0
	-- ==================================================================================================================================

	SET DATEFORMAT MDY
	SET NOCOUNT ON
	
	DECLARE @v_ERR INT, @I_MSG VARCHAR(255), @PARENT_USP VARCHAR(250), @v_ROWCOUNT INT, @RETVAL INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	
	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[v_YAHOO_FINANCE_EQUITIES_ICHART] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [SYMBOL], [ClosureDate]
		, MAX([OPEN_GBP])  AS [OPEN_GBP]
		, MAX([HIGH_GBP])  AS [HIGH_GBP]
		, MAX([LOW_GBP])   AS [LOW_GBP]
		, MAX([CLOSE_GBP]) AS [CLOSE_GBP]
		, MAX([VOLUME])	   AS [VOLUME]
		, MAX([Adj Close_GBP]) AS [Adj Close_GBP]
		, NULL AS [PREVIOUS_CLOSE_GBP]
		INTO #YAHOO_FINANCE_EQUITIES_ICHART -- DROP TABLE #YAHOO_FINANCE_EQUITIES_ICHART
		FROM [STG].[v_YAHOO_FINANCE_EQUITIES_ICHART] B
		WHERE DATEADD(DD,(365),[Closuredate]) > GETDATE() -- ONLY GET THIS YEARS DATA
		GROUP BY [SYMBOL], [ClosureDate]
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'CREATE INDEX IDX_001 ON #YAHOO_FINANCE_EQUITIES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		CREATE INDEX IDX_001 ON #YAHOO_FINANCE_EQUITIES_ICHART ([SYMBOL], [ClosureDate], [CLOSE_GBP])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[YAHOO_ONE_DAY_EXPORT] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT DISTINCT [B].[SYMBOL], [B].[ClosureDate], [B].[PRICE]
		INTO #YAHOO_ONE_DAY_EXPORT
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B
		WHERE EXISTS (SELECT 1 FROM #YAHOO_FINANCE_EQUITIES_ICHART A WHERE [A].[Symbol] = [B].[Symbol])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'CREATE INDEX IDX_001 ON #YAHOO_ONE_DAY_EXPORT'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		CREATE INDEX IDX_001 ON #YAHOO_ONE_DAY_EXPORT ([SYMBOL], [ClosureDate], [PRICE])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[v_YAHOO_FINANCE_EQUITIES] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY -- do me next ...
		SELECT * INTO #YAHOO_FINANCE_EQUITIES
		FROM [STG].[v_YAHOO_FINANCE_EQUITIES] B
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT * INTO #INVESTMENT_SECTOR_REPORT_FILTER
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ..MANAGE GBP OR GBX FROM ICHART
	-- MULTIPLY #YAHOO_FINANCE_EQUITIES_ICHART BY 100
	-- ==========================================================================================================================================

	SET @I_MSG = 'BUILD #YAHOO_FINANCE_EQUITIES_ICHART_MULTIPLY_100'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [A].*
		INTO #YAHOO_FINANCE_EQUITIES_ICHART_MULTIPLY_100
		FROM #YAHOO_FINANCE_EQUITIES A, #YAHOO_FINANCE_EQUITIES_ICHART B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[LAST_TRADE_DATE] = [B].[ClosureDate]
		AND [A].[LAST_TRADE_PRICE_GBP] <> [B].[CLOSE_GBP]
		AND ([B].[CLOSE_GBP] * (100)) / [A].[LAST_TRADE_PRICE_GBP] BETWEEN (0.90) AND (1.10)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_EQUITIES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_EQUITIES_ICHART
		SET [OPEN_GBP] = [OPEN_GBP] * (100)
		, [HIGH_GBP] = [HIGH_GBP] * (100)
		, [LOW_GBP] = [LOW_GBP] * (100)
		, [CLOSE_GBP] = [CLOSE_GBP] * (100)
		, [Adj Close_GBP] = [Adj Close_GBP] * (100)
		WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #YAHOO_FINANCE_EQUITIES_ICHART_MULTIPLY_100)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ..MANAGE GBP OR GBX FROM ICHART
	-- DIVIDE #YAHOO_FINANCE_EQUITIES_ICHART BY 100
	-- ==========================================================================================================================================

	SET @I_MSG = 'BUILD #YAHOO_FINANCE_EQUITIES_ICHART_DIVIDE_100'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [A].*
		INTO #YAHOO_FINANCE_EQUITIES_ICHART_DIVIDE_100
		FROM #YAHOO_FINANCE_EQUITIES A, #YAHOO_FINANCE_EQUITIES_ICHART B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[LAST_TRADE_DATE] = [B].[ClosureDate]
		AND [A].[LAST_TRADE_PRICE_GBP] <> [B].[CLOSE_GBP]
		AND ([B].[CLOSE_GBP] / (100)) / [A].[LAST_TRADE_PRICE_GBP] BETWEEN (0.90) AND (1.10)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_EQUITIES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_EQUITIES_ICHART
		SET [OPEN_GBP] = [OPEN_GBP] / (100)
		, [HIGH_GBP] = [HIGH_GBP] / (100)
		, [LOW_GBP] = [LOW_GBP] / (100)
		, [CLOSE_GBP] = [CLOSE_GBP] / (100)
		, [Adj Close_GBP] = [Adj Close_GBP] / (100)
		WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #YAHOO_FINANCE_EQUITIES_ICHART_DIVIDE_100)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- GET LIST OF PREVIOUS DATES
	-- ==========================================================================================================================================
	SET @I_MSG = 'CREATE #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT DISTINCT [Symbol], [ClosureDate], (SELECT MAX([ClosureDate]) FROM #YAHOO_FINANCE_EQUITIES_ICHART B
										WHERE [A].[Symbol] = [B].[Symbol]
										AND [B].[ClosureDate] < [A].[ClosureDate]) AS [Previous_Closure_Date]
		INTO #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES -- DROP TABLE #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES
		FROM #YAHOO_FINANCE_EQUITIES_ICHART A
		/*
		36GK	2016-12-26	2016-08-29
		36GK	2016-08-29	2016-06-10
		*/
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'DELETE #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES
		WHERE ABS(DATEDIFF(dd, [ClosureDate], [Previous_Closure_Date])) > 7
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_EQUITIES_ICHART (SET PREVIOUS_CLOSE)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

/*
SELECT [A].[ClosureDate], [A].[SYMBOL], [B].[CLOSE_GBP], [C].[Previous_Closure_Date], COUNT(*)
FROM #YAHOO_FINANCE_EQUITIES_ICHART A, #YAHOO_FINANCE_EQUITIES_ICHART B, #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES C
WHERE [A].[ClosureDate] = [C].[ClosureDate] AND [C].[Previous_Closure_Date] = [B].[ClosureDate]
AND [A].[SYMBOL] = [B].[SYMBOL] AND [B].[SYMBOL] = [C].[SYMBOL]
GROUP BY [A].[ClosureDate], [A].[SYMBOL], [B].[CLOSE_GBP], [C].[Previous_Closure_Date]
HAVING COUNT(*) > 1

-- 2016-07-22
70GD
0.65
2016-07-21

select * from #YAHOO_FINANCE_EQUITIES_ICHART
WHERE symbol = '70gd' and closuredate = '2016-07-22'


SELECT * FROM #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES
WHERE symbol = '70gd' and closuredate = '2016-07-22'
*/

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_EQUITIES_ICHART
		SET [PREVIOUS_CLOSE_GBP] = (SELECT [CLOSE_GBP] FROM #YAHOO_FINANCE_EQUITIES_ICHART B, #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES C
									WHERE [A].[ClosureDate] = [C].[ClosureDate] AND [C].[Previous_Closure_Date] = [B].[ClosureDate]
									AND [A].[SYMBOL] = [B].[SYMBOL] AND [B].[SYMBOL] = [C].[SYMBOL])
		FROM #YAHOO_FINANCE_EQUITIES_ICHART A
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- INSERT
	-- ==========================================================================================================================================

	SET @I_MSG = 'INSERT INTO [STG].[YAHOO_ONE_DAY_EXPORT]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
		([Name], [Symbol], [ClosureDate], [OPEN_PRICE], [Days_Low], [Days_High], [Price], [Currency]
		, [Stock Exchange], [DateLoaded], [Volume], [PREVIOUS_CLOSE])

		SELECT DISTINCT [C].[INVESTMENT_NAME], [B].[SYMBOL], [B].[ClosureDate], [B].[OPEN_GBP], [B].[LOW_GBP], [B].[HIGH_GBP]
		, [B].[CLOSE_GBP],  'GBP', 'LSE', GETDATE(), [Volume], [B].[PREVIOUS_CLOSE_GBP]
		FROM #YAHOO_FINANCE_EQUITIES_ICHART B, [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] C
		WHERE NOT EXISTS (SELECT (1) FROM #YAHOO_ONE_DAY_EXPORT A
							WHERE [A].[SYMBOL] = [B].[SYMBOL]
							AND [A].[ClosureDate] = [B].[ClosureDate])
		AND [C].[PRIMARY_LABEL] = [B].[SYMBOL]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error has occured INSERT [STG].[YAHOO_ONE_DAY_EXPORT]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG = 'ROWS INSERTED ([STG].[YAHOO_ONE_DAY_EXPORT]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================================================
	-- UPDATE
	-- ==========================================================================================================================================

	IF @UPDATE_OPEN_PRICE = (1)
	BEGIN
		SET @I_MSG = 'UPDATE [OPEN_PRICE] on [STG].[YAHOO_ONE_DAY_EXPORT]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
			SET [OPEN_PRICE] = [B].[OPEN_GBP]
			FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] A
			, [STG].[v_YAHOO_FINANCE_EQUITIES_ICHART] B
			WHERE [A].[SYMBOL] = [B].[SYMBOL]
			AND [A].[ClosureDate] = [B].[ClosureDate]
			AND [A].[OPEN_PRICE] IS NULL
			AND [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) BETWEEN (0.75) and (1.25)
			AND ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) <> (0)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH

		IF @v_ERR <> (0)
		BEGIN
			PRINT 'Error has occured UPDATE [STG].[YAHOO_ONE_DAY_EXPORT]' + CONVERT(VARCHAR(10),@v_ERR)
			RETURN (255)
		END

		SET @I_MSG = 'ROWS UPDATED ([STG].[YAHOO_ONE_DAY_EXPORT]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	DECLARE @FINAL_CHECKS INT
	SET @FINAL_CHECKS = 0

	IF @FINAL_CHECKS = (1)
	BEGIN
		SET @I_MSG = 'PRICE CHECK REPORT'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		SELECT [B].[OPEN_GBP], [A].[PRICE] AS CURRENT_PRICE, [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) AS cCHECK, [A].*
		INTO #UPDATE_ME -- DROP TABLE #UPDATE_ME
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] A
		, [STG].[v_YAHOO_FINANCE_EQUITIES_ICHART] B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[ClosureDate] = [B].[ClosureDate]
		AND [B].[OPEN_GBP] > (0.009)
		AND [A].[PRICE] > (0.009)
		AND [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) NOT BETWEEN (0.75) and (1.25)

		-- ===========================================================================================
		-- FUNDS ARE PROVIDED BY YAHOO AS GBP AND SO SHOULD NOT BE DIV 100
		-- ===========================================================================================

		SELECT TOP (500) CURRENT_PRICE / ([OPEN_GBP] * (100)), *
		FROM #UPDATE_ME WHERE LEN(SYMBOL) = (12)
		AND CURRENT_PRICE / ([OPEN_GBP] * (100)) NOT BETWEEN (0.97) and (1.03)
		ORDER BY [ClosureDate] DESC
	-- .. conclusion very FEW to correct and leave alone ....

		-- ===========================================================================================
		-- FUNDS ARE PROVIDED BY YAHOO AS GBP AND SO SHOULD NOT BE DIV 100
		-- ===========================================================================================
	
		SELECT TOP (500) [B].MARKET_NAME, [A].*
		FROM #UPDATE_ME A, #INVESTMENT_SECTOR_REPORT_FILTER B
		WHERE LEN([A].[SYMBOL]) < (12) AND [A].[SYMBOL] = [B].LABEL
		AND [B].MARKET_NAME NOT LIKE '%FTSE AIM All-Share (EQUITIES)%' -- many of these are a guess at AIM
		AND [B].MARKET_NAME NOT LIKE '%FTSE All Share (EQUITIES)' -- ignore just for now
		AND [A].CURRENT_PRICE / ([A].[OPEN_GBP] * (1)) NOT BETWEEN (0.97) and (1.03)
		ORDER BY [A].[ClosureDate] DESC

		SELECT TOP (500) * FROM #UPDATE_ME ORDER BY ABS(cCHECK)
	
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [PRIMARY_LABEL] = 'JDTC'
	
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [SOURCE_OF_IMPORT] LIKE '%HARGRE%'
		AND INVESTMENT_TYPE_NAME = 'Equity'
	END

	-- ==================================================================================================================================
	-- TIDY UP
	-- ==================================================================================================================================

	DROP TABLE #YAHOO_ONE_DAY_EXPORT
	DROP TABLE #YAHOO_FINANCE_EQUITIES_ICHART
	DROP TABLE #INVESTMENT_SECTOR_REPORT_FILTER
	DROP TABLE #YAHOO_FINANCE_EQUITIES
	DROP TABLE #YAHOO_FINANCE_EQUITIES_ICHART_MULTIPLY_100
	DROP TABLE #YAHOO_FINANCE_EQUITIES_ICHART_DIVIDE_100
	DROP TABLE #YAHOO_FINANCE_EQUITIES_ICHART_PREVIOUS_DATES

	IF @FINAL_CHECKS = (1) DROP TABLE #UPDATE_ME

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	-- SET DATEFORMAT DMY
	SET DATEFORMAT MDY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [SYMBOL]
		, [NAME]
		, MAX([LAST_TRADE_PRICE_GBP]) AS [LAST_TRADE_PRICE_GBP]
		, MAX([DAYS_LOW_GBP]) AS [DAYS_LOW_GBP]
		, MAX([DAYS_HIGH_GBP]) AS [DAYS_HIGH_GBP]
		, MAX([PCT_CHANGE]) AS [PCT_CHANGE]
		, [CURRENCY]
		, MAX([PE_RATIO]) AS [PE_RATIO]
		, MAX([PEG_RATIO]) AS [PEG_RATIO]
		, MAX([LOW_52WEEK_GBP]) AS [LOW_52WEEK_GBP]
		, MAX([HIGH_52WEEK_GBP]) AS [HIGH_52WEEK_GBP]
		, MAX([MOVING_AVG_50_DAY_GBP]) AS [MOVING_AVG_50_DAY_GBP]
		, MAX([PCT_CHANGE_FROM_50_DAY_MA]) AS [PCT_CHANGE_FROM_50_DAY_MA]
		, MAX([DIVIDEND_YIELD]) AS [DIVIDEND_YIELD]
		, [STOCK_EXCHANGE]
		, [LAST_TRADE_DATE]
		, MAX([OPEN_PRICE_GBP]) AS [OPEN_PRICE_GBP]
		, MAX([PREVIOUS_CLOSE_GBP]) AS [PREVIOUS_CLOSE_GBP]
		, MAX([Commission]) AS [Commission]
		, MAX([Volume]) AS [Volume]
		, MAX([AverageDailyVolume]) AS [AverageDailyVolume]
		, MAX([DividendPerShare]) AS [DividendPerShare]
		, MAX([MarketCapitalization]) AS [MarketCapitalization]
		INTO #ACTIVE
		FROM [STG].[v_YAHOO_FINANCE_FUTURES]
		GROUP BY [SYMBOL], [NAME], [CURRENCY], [STOCK_EXCHANGE], [LAST_TRADE_DATE]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
		DROP TABLE #SymbolsToProcess

	SET @I_MSG = 'Error CREATE TABLE #SymbolsToProcess'
	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess (FUTURES)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO #SymbolsToProcess
		SELECT DISTINCT [B].[Symbol]
		, [B].[Symbol]
		, [LAST_TRADE_DATE]
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- STG
	-- ==================================================================================================================================

	SET @I_MSG = 'EXEC [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	DECLARE @SymbolsToProcess AS dbo.SymbolsToProcess
	INSERT INTO @SymbolsToProcess SELECT * FROM #SymbolsToProcess

	BEGIN TRY
		EXEC @RETVAL = [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor] @BUILD_ID, @vRE, @SymbolsToProcess, 1500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] ([Symbol], [Name], [Price], [Days_Low]
		, [Days_High], [Change], [Currency], [P/E_Ratio], [PEG_Ratio], [52wk_low], [52wk_high], [50 day_moving avg]
		, [%age change FROM 50day avg], [Dividend_Yield], [Stock Exchange], [ClosureDate]
		, [OPEN_PRICE], [PREVIOUS_CLOSE], [Volume], [AverageDailyVolume], [DividendPerShare], [MarketCapitalization])

		SELECT DISTINCT
		[B].[Symbol]
		, [Name]
		, [LAST_TRADE_PRICE_GBP]
		, [Days_Low_GBP]
		, [Days_High_GBP]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([PCT_CHANGE]))
		, [Currency]
		, [PE_RATIO]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([PEG_RATIO]))
		, [LOW_52WEEK_GBP]
		, [HIGH_52WEEK_GBP]
		, [MOVING_AVG_50_DAY_GBP]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([PCT_CHANGE_FROM_50_DAY_MA]))
		, [Dividend_Yield]
		, [STOCK_EXCHANGE]
		, [LAST_TRADE_DATE]
		, [OPEN_PRICE_GBP]
		, [PREVIOUS_CLOSE_GBP]
		, [Volume]
		, [AverageDailyVolume]
		, [DividendPerShare] -- PROBABLY NOT NEEDED BUT ADDED TO BE CONSITENT ACRROSS THE SET OF USPs
		, [MarketCapitalization]

		FROM #ACTIVE B, #SymbolsToProcess D

		WHERE NOT EXISTS (SELECT (1) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] C
							WHERE [C].[Symbol]= [B].[Symbol]
							AND [B].[LAST_TRADE_DATE] = [C].[ClosureDate]) 
		AND [B].[LAST_TRADE_DATE] = [D].[tDate] -- [Export Date]
		AND [B].[Symbol] = [D].[tColumn01]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'ROWS INSERTED (YAHOO_ONE_DAY_EXPORT)= '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error had occured [INSERT FUTURES]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (FUTURES)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #SymbolsToProcess

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
	-- ==================================================================================================================================

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	INSERT INTO @InvestmentsToAdd
	SELECT DISTINCT [Symbol], [Name], '%Futures%', '%KNOWN%', 'ALC%Futures%'
	FROM [STG].[v_YAHOO_FINANCE_FUTURES] WHERE [NAME] LIKE '[%A-Za-z]%'
	AND [SYMBOL] NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT])
	AND [SYMBOL] NOT IN (SELECT [LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS])

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
	-- ==================================================================================================================================

	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd -- , '%Futures%', '%KNOWN%', 'ALC%Futures%'
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES_ICHART]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES_ICHART] (@BUILD_ID INT, @vRE INT, @UPDATE_OPEN_PRICE INT) AS
BEGIN	

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	-- 1.0		Initial Release
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_FUTURES_ICHART] 0, 1, 0
	-- ==================================================================================================================================

	SET DATEFORMAT MDY
	SET NOCOUNT ON
	
	DECLARE @v_ERR INT, @I_MSG VARCHAR(255), @PARENT_USP VARCHAR(250), @v_ROWCOUNT INT, @RETVAL INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	
	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[v_YAHOO_FINANCE_FUTURES_ICHART] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
/*
		SELECT DISTINCT [SYMBOL], [ClosureDate], [OPEN_GBP], [HIGH_GBP], [LOW_GBP], [CLOSE_GBP], [VOLUME], [Adj Close_GBP], NULL AS [PREVIOUS_CLOSE_GBP]
		INTO #YAHOO_FINANCE_FUTURES_ICHART -- DROP TABLE #YAHOO_FINANCE_FUTURES_ICHART
		FROM [STG].[v_YAHOO_FINANCE_FUTURES_ICHART] B
		WHERE DATEADD(DD,(365),[Closuredate]) > GETDATE() -- ONLY GET THIS YEARS DATA
*/
		SELECT [SYMBOL], [ClosureDate]
		, MAX([OPEN_GBP])  AS [OPEN_GBP]
		, MAX([HIGH_GBP])  AS [HIGH_GBP]
		, MAX([LOW_GBP])   AS [LOW_GBP]
		, MAX([CLOSE_GBP]) AS [CLOSE_GBP]
		, MAX([VOLUME])	   AS [VOLUME]
		, MAX([Adj Close_GBP]) AS [Adj Close_GBP]
		, NULL AS [PREVIOUS_CLOSE_GBP]
		INTO #YAHOO_FINANCE_FUTURES_ICHART
		FROM [STG].[v_YAHOO_FINANCE_FUTURES_ICHART] B
		WHERE DATEADD(DD,(365),[Closuredate]) > GETDATE() -- ONLY GET THIS YEARS DATA
		GROUP BY [SYMBOL], [ClosureDate]
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'CREATE INDEX IDX_001 ON #YAHOO_FINANCE_FUTURES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		CREATE INDEX IDX_001 ON #YAHOO_FINANCE_FUTURES_ICHART ([SYMBOL], [ClosureDate], [CLOSE_GBP])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[YAHOO_ONE_DAY_EXPORT] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [B].[SYMBOL], [B].[ClosureDate], [B].[PRICE]
		INTO #YAHOO_ONE_DAY_EXPORT
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B
		WHERE EXISTS (SELECT 1 FROM #YAHOO_FINANCE_FUTURES_ICHART A WHERE [A].[Symbol] = [B].[Symbol])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'CREATE INDEX IDX_001 ON #YAHOO_ONE_DAY_EXPORT'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		CREATE INDEX IDX_001 ON #YAHOO_ONE_DAY_EXPORT ([SYMBOL], [ClosureDate], [PRICE])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[v_YAHOO_FINANCE_FUTURES] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY -- do me next ...
		SELECT * INTO #YAHOO_FINANCE_FUTURES
		FROM [STG].[v_YAHOO_FINANCE_FUTURES] B
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT * INTO #INVESTMENT_SECTOR_REPORT_FILTER
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ..MANAGE GBP OR GBX FROM ICHART
	-- MULTIPLY #YAHOO_FINANCE_FUTURES_ICHART BY 100
	-- ==========================================================================================================================================

	SET @I_MSG = 'BUILD #YAHOO_FINANCE_FUTURES_ICHART_MULTIPLY_100'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [A].*
		INTO #YAHOO_FINANCE_FUTURES_ICHART_MULTIPLY_100
		FROM #YAHOO_FINANCE_FUTURES A, #YAHOO_FINANCE_FUTURES_ICHART B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[LAST_TRADE_DATE] = [B].[ClosureDate]
		AND [A].[LAST_TRADE_PRICE_GBP] <> [B].[CLOSE_GBP]
		AND ([B].[CLOSE_GBP] * (100)) / [A].[LAST_TRADE_PRICE_GBP] BETWEEN (0.90) AND (1.10)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_FUTURES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_FUTURES_ICHART
		SET [OPEN_GBP] = [OPEN_GBP] * (100)
		, [HIGH_GBP] = [HIGH_GBP] * (100)
		, [LOW_GBP] = [LOW_GBP] * (100)
		, [CLOSE_GBP] = [CLOSE_GBP] * (100)
		, [Adj Close_GBP] = [Adj Close_GBP] * (100)
		WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #YAHOO_FINANCE_FUTURES_ICHART_MULTIPLY_100)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ..MANAGE GBP OR GBX FROM ICHART
	-- DIVIDE #YAHOO_FINANCE_FUTURES_ICHART BY 100
	-- ==========================================================================================================================================

	SET @I_MSG = 'BUILD #YAHOO_FINANCE_FUTURES_ICHART_DIVIDE_100'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [A].*
		INTO #YAHOO_FINANCE_FUTURES_ICHART_DIVIDE_100
		FROM #YAHOO_FINANCE_FUTURES A, #YAHOO_FINANCE_FUTURES_ICHART B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[LAST_TRADE_DATE] = [B].[ClosureDate]
		AND [A].[LAST_TRADE_PRICE_GBP] <> [B].[CLOSE_GBP]
		AND ([B].[CLOSE_GBP] / (100)) / [A].[LAST_TRADE_PRICE_GBP] BETWEEN (0.90) AND (1.10)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_FUTURES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_FUTURES_ICHART
		SET [OPEN_GBP] = [OPEN_GBP] / (100)
		, [HIGH_GBP] = [HIGH_GBP] / (100)
		, [LOW_GBP] = [LOW_GBP] / (100)
		, [CLOSE_GBP] = [CLOSE_GBP] / (100)
		, [Adj Close_GBP] = [Adj Close_GBP] / (100)
		WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #YAHOO_FINANCE_FUTURES_ICHART_DIVIDE_100)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- GET LIST OF PREVIOUS DATES
	-- ==========================================================================================================================================
	SET @I_MSG = 'CREATE #YAHOO_FINANCE_FUTURES_ICHART_PREVIOUS_DATES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT DISTINCT [Symbol], [ClosureDate], (SELECT MAX([ClosureDate]) FROM #YAHOO_FINANCE_FUTURES_ICHART B
										WHERE [A].[Symbol] = [B].[Symbol]
										AND [B].[ClosureDate] < [A].[ClosureDate]) AS [Previous_Closure_Date]
		INTO #YAHOO_FINANCE_FUTURES_ICHART_PREVIOUS_DATES
		FROM #YAHOO_FINANCE_FUTURES_ICHART A
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'DELETE #YAHOO_FINANCE_FUTURES_ICHART_PREVIOUS_DATES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE #YAHOO_FINANCE_FUTURES_ICHART_PREVIOUS_DATES
		WHERE ABS(DATEDIFF(dd, [ClosureDate], [Previous_Closure_Date])) > 7
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_FUTURES_ICHART (SET PREVIOUS_CLOSE)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_FUTURES_ICHART
		SET [PREVIOUS_CLOSE_GBP] = (SELECT [CLOSE_GBP] FROM #YAHOO_FINANCE_FUTURES_ICHART B, #YAHOO_FINANCE_FUTURES_ICHART_PREVIOUS_DATES C
									WHERE [A].[ClosureDate] = [C].[ClosureDate] AND [C].[Previous_Closure_Date] = [B].[ClosureDate])
		FROM #YAHOO_FINANCE_FUTURES_ICHART A
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- INSERT
	-- ==========================================================================================================================================

	SET @I_MSG = 'INSERT INTO [STG].[YAHOO_ONE_DAY_EXPORT]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
		([Name], [Symbol], [ClosureDate], [OPEN_PRICE], [Days_Low], [Days_High], [Price], [Currency]
		, [Stock Exchange], [DateLoaded], [Volume], [PREVIOUS_CLOSE])

		SELECT DISTINCT [C].[INVESTMENT_NAME], [B].[SYMBOL], [B].[ClosureDate], [B].[OPEN_GBP], [B].[LOW_GBP], [B].[HIGH_GBP]
		, [B].[CLOSE_GBP],  'GBP', 'LSE', GETDATE(), [Volume], [B].[PREVIOUS_CLOSE_GBP]
		FROM #YAHOO_FINANCE_FUTURES_ICHART B, [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] C
		WHERE NOT EXISTS (SELECT (1) FROM #YAHOO_ONE_DAY_EXPORT A
							WHERE [A].[SYMBOL] = [B].[SYMBOL]
							AND [A].[ClosureDate] = [B].[ClosureDate])
		AND [C].[PRIMARY_LABEL] = [B].[SYMBOL]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error has occured INSERT [STG].[YAHOO_ONE_DAY_EXPORT]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG = 'ROWS INSERTED ([STG].[YAHOO_ONE_DAY_EXPORT]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================================================
	-- UPDATE
	-- ==========================================================================================================================================

	IF @UPDATE_OPEN_PRICE = (1)
	BEGIN
		SET @I_MSG = 'UPDATE [OPEN_PRICE] on [STG].[YAHOO_ONE_DAY_EXPORT]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
			SET [OPEN_PRICE] = [B].[OPEN_GBP]
			FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] A
			, [STG].[v_YAHOO_FINANCE_FUTURES_ICHART] B
			WHERE [A].[SYMBOL] = [B].[SYMBOL]
			AND [A].[ClosureDate] = [B].[ClosureDate]
			AND [A].[OPEN_PRICE] IS NULL
			AND [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) BETWEEN (0.75) and (1.25)
			AND ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) <> (0)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH

		IF @v_ERR <> (0)
		BEGIN
			PRINT 'Error has occured UPDATE [STG].[YAHOO_ONE_DAY_EXPORT]' + CONVERT(VARCHAR(10),@v_ERR)
			RETURN (255)
		END

		SET @I_MSG = 'ROWS UPDATED ([STG].[YAHOO_ONE_DAY_EXPORT]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	DECLARE @FINAL_CHECKS INT
	SET @FINAL_CHECKS = 0

	IF @FINAL_CHECKS = (1)
	BEGIN
		SET @I_MSG = 'PRICE CHECK REPORT'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		SELECT [B].[OPEN_GBP], [A].[PRICE] AS CURRENT_PRICE, [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) AS cCHECK, [A].*
		INTO #UPDATE_ME -- DROP TABLE #UPDATE_ME
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] A
		, [STG].[v_YAHOO_FINANCE_FUTURES_ICHART] B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[ClosureDate] = [B].[ClosureDate]
		AND [B].[OPEN_GBP] > (0.009)
		AND [A].[PRICE] > (0.009)
		AND [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) NOT BETWEEN (0.75) and (1.25)

		-- ===========================================================================================
		-- FUNDS ARE PROVIDED BY YAHOO AS GBP AND SO SHOULD NOT BE DIV 100
		-- ===========================================================================================

		SELECT TOP (500) CURRENT_PRICE / ([OPEN_GBP] * (100)), *
		FROM #UPDATE_ME WHERE LEN(SYMBOL) = (12)
		AND CURRENT_PRICE / ([OPEN_GBP] * (100)) NOT BETWEEN (0.97) and (1.03)
		ORDER BY [ClosureDate] DESC
	-- .. conclusion very FEW to correct and leave alone ....

		-- ===========================================================================================
		-- FUNDS ARE PROVIDED BY YAHOO AS GBP AND SO SHOULD NOT BE DIV 100
		-- ===========================================================================================
	
		SELECT TOP (500) [B].MARKET_NAME, [A].*
		FROM #UPDATE_ME A, #INVESTMENT_SECTOR_REPORT_FILTER B
		WHERE LEN([A].[SYMBOL]) < (12) AND [A].[SYMBOL] = [B].LABEL
		AND [B].MARKET_NAME NOT LIKE '%FTSE AIM All-Share (FUTURES)%' -- many of these are a guess at AIM
		AND [B].MARKET_NAME NOT LIKE '%FTSE All Share (FUTURES)' -- ignore just for now
		AND [A].CURRENT_PRICE / ([A].[OPEN_GBP] * (1)) NOT BETWEEN (0.97) and (1.03)
		ORDER BY [A].[ClosureDate] DESC

		SELECT TOP (500) * FROM #UPDATE_ME ORDER BY ABS(cCHECK)
	
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [PRIMARY_LABEL] = 'JDTC'
	
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [SOURCE_OF_IMPORT] LIKE '%HARGRE%'
		AND INVESTMENT_TYPE_NAME = 'Equity'
	END

	-- ==================================================================================================================================
	-- TIDY UP
	-- ==================================================================================================================================

	DROP TABLE #YAHOO_ONE_DAY_EXPORT
	DROP TABLE #YAHOO_FINANCE_FUTURES_ICHART
	DROP TABLE #INVESTMENT_SECTOR_REPORT_FILTER
	DROP TABLE #YAHOO_FINANCE_FUTURES
	DROP TABLE #YAHOO_FINANCE_FUTURES_ICHART_MULTIPLY_100
	DROP TABLE #YAHOO_FINANCE_FUTURES_ICHART_DIVIDE_100
	DROP TABLE #YAHOO_FINANCE_FUTURES_ICHART_PREVIOUS_DATES

	IF @FINAL_CHECKS = (1) DROP TABLE #UPDATE_ME

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	-- SET DATEFORMAT DMY
	SET DATEFORMAT MDY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [SYMBOL]
		, [NAME]
		, MAX([LAST_TRADE_PRICE_GBP]) AS [LAST_TRADE_PRICE_GBP]
		, MAX([DAYS_LOW_GBP]) AS [DAYS_LOW_GBP]
		, MAX([DAYS_HIGH_GBP]) AS [DAYS_HIGH_GBP]
		, MAX([PCT_CHANGE]) AS [PCT_CHANGE]
		, [CURRENCY]
		, MAX([PE_RATIO]) AS [PE_RATIO]
		, MAX([PEG_RATIO]) AS [PEG_RATIO]
		, MAX([LOW_52WEEK_GBP]) AS [LOW_52WEEK_GBP]
		, MAX([HIGH_52WEEK_GBP]) AS [HIGH_52WEEK_GBP]
		, MAX([MOVING_AVG_50_DAY_GBP]) AS [MOVING_AVG_50_DAY_GBP]
		, MAX([PCT_CHANGE_FROM_50_DAY_MA]) AS [PCT_CHANGE_FROM_50_DAY_MA]
		, MAX([DIVIDEND_YIELD]) AS [DIVIDEND_YIELD]
		, [STOCK_EXCHANGE]
		, [LAST_TRADE_DATE]
		, MAX([OPEN_PRICE_GBP]) AS [OPEN_PRICE_GBP]
		, MAX([PREVIOUS_CLOSE_GBP]) AS [PREVIOUS_CLOSE_GBP]
		, MAX([Commission]) AS [Commission]
		, MAX([Volume]) AS [Volume]
		, MAX([AverageDailyVolume]) AS [AverageDailyVolume]
		, MAX([DividendPerShare]) AS [DividendPerShare]
		, MAX([MarketCapitalization]) AS [MarketCapitalization]
		INTO #ACTIVE
		FROM [STG].[v_YAHOO_FINANCE_INDICES]
		GROUP BY [SYMBOL], [NAME], [CURRENCY], [STOCK_EXCHANGE], [LAST_TRADE_DATE]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
		DROP TABLE #SymbolsToProcess

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error CREATE TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess (INDICES)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO #SymbolsToProcess
		SELECT DISTINCT [B].[Symbol]
		, [B].[Symbol]
		, [LAST_TRADE_DATE]
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- STG
	-- ==================================================================================================================================

	SET @I_MSG = 'EXEC [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	DECLARE @SymbolsToProcess AS dbo.SymbolsToProcess
	INSERT INTO @SymbolsToProcess SELECT * FROM #SymbolsToProcess

	BEGIN TRY
		EXEC @RETVAL = [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor] @BUILD_ID, @vRE, @SymbolsToProcess, 1500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] ([Symbol], [Name], [Price], [Days_Low]
		, [Days_High], [Change], [Currency], [P/E_Ratio], [PEG_Ratio], [52wk_low], [52wk_high], [50 day_moving avg]
		, [%age change FROM 50day avg], [Dividend_Yield], [Stock Exchange], [ClosureDate]
		, [OPEN_PRICE], [PREVIOUS_CLOSE], [Volume], [AverageDailyVolume], [DividendPerShare], [MarketCapitalization])

		SELECT DISTINCT
		[B].[Symbol]
		, [Name]
		, [LAST_TRADE_PRICE_GBP]
		, [Days_Low_GBP]
		, [Days_High_GBP]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([PCT_CHANGE]))
		, [Currency]
		, [PE_RATIO]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([PEG_RATIO]))
		, [LOW_52WEEK_GBP]
		, [HIGH_52WEEK_GBP]
		, [MOVING_AVG_50_DAY_GBP]
		, CONVERT(FLOAT,[Alchemy_Functions].[dbo].[fnRemoveNonNumericCharacters]([PCT_CHANGE_FROM_50_DAY_MA])) -- [%age change FROM 50day avg]))
		, [Dividend_Yield]
		, [STOCK_EXCHANGE]
		, [LAST_TRADE_DATE]
		, [OPEN_PRICE_GBP]
		, [PREVIOUS_CLOSE_GBP]
		, [Volume]
		, [AverageDailyVolume]
		, [DividendPerShare] -- PROBABLY NOT NEEDED BUT ADDED TO BE CONSITENT ACROSS THE SET OF USPs
		, [MarketCapitalization]

		FROM #ACTIVE B
		, #SymbolsToProcess D

		WHERE NOT EXISTS (SELECT (1) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] C
							WHERE [C].[Symbol]= [B].[Symbol]
							AND [B].[LAST_TRADE_DATE] = [C].[ClosureDate])
		AND [B].[Symbol] = [D].[tColumn01]
		AND [B].[LAST_TRADE_DATE] = [D].[tDate]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED (YAHOO_ONE_DAY_EXPORT) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (INDICES)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #SymbolsToProcess

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
	-- ==================================================================================================================================

	-- DECLARE @BUILD_ID INT , @I_MSG VARCHAR(250), @vRE INT; SET @BUILD_ID = 0; SET @VRE = (1);
	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	INSERT INTO @InvestmentsToAdd
	SELECT DISTINCT [Symbol], [Name], '%Market%Index%', '%KNOWN%', 'ALC%Indices%'
	FROM #ACTIVE B
	WHERE [NAME] LIKE '[%A-Za-z]%'
	AND [SYMBOL] NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT])

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
	-- ==================================================================================================================================

	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END

GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES_ICHART]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES_ICHART] (@BUILD_ID INT, @vRE INT, @UPDATE_OPEN_PRICE INT) AS
BEGIN	

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version History:
	-- 1.0		Initial Release
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_INDICES_ICHART] 0, 1, 0
	-- ==================================================================================================================================

	SET DATEFORMAT MDY
	SET NOCOUNT ON
	
	DECLARE @v_ERR INT, @I_MSG VARCHAR(255), @PARENT_USP VARCHAR(250), @v_ROWCOUNT INT, @RETVAL INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	
	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[v_YAHOO_FINANCE_INDICES_ICHART] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
/*
		SELECT DISTINCT [SYMBOL], [ClosureDate], [OPEN_GBP], [HIGH_GBP], [LOW_GBP], [CLOSE_GBP]
		, [VOLUME], [Adj Close_GBP], NULL AS [PREVIOUS_CLOSE_GBP]
		INTO #YAHOO_FINANCE_INDICES_ICHART -- DROP TABLE #YAHOO_FINANCE_INDICES_ICHART
		FROM [STG].[v_YAHOO_FINANCE_INDICES_ICHART] B
		WHERE DATEADD(DD,(365),[Closuredate]) > GETDATE() -- ONLY GET THIS YEARS DATA
*/
		SELECT [SYMBOL], [ClosureDate]
		, MAX([OPEN_GBP])  AS [OPEN_GBP]
		, MAX([HIGH_GBP])  AS [HIGH_GBP]
		, MAX([LOW_GBP])   AS [LOW_GBP]
		, MAX([CLOSE_GBP]) AS [CLOSE_GBP]
		, MAX([VOLUME])	   AS [VOLUME]
		, MAX([Adj Close_GBP]) AS [Adj Close_GBP]
		, NULL AS [PREVIOUS_CLOSE_GBP]
		INTO #YAHOO_FINANCE_INDICES_ICHART -- DROP TABLE #YAHOO_FINANCE_INDICES_ICHART
		FROM [STG].[v_YAHOO_FINANCE_INDICES_ICHART] B
		WHERE DATEADD(DD,(365),[Closuredate]) > GETDATE() -- ONLY GET THIS YEARS DATA
		GROUP BY [SYMBOL], [ClosureDate]
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'CREATE INDEX IDX_001 ON #YAHOO_FINANCE_INDICES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		CREATE INDEX IDX_001 ON #YAHOO_FINANCE_INDICES_ICHART ([SYMBOL], [ClosureDate], [CLOSE_GBP])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[YAHOO_ONE_DAY_EXPORT] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [B].[SYMBOL], [B].[ClosureDate], [B].[PRICE]
		INTO #YAHOO_ONE_DAY_EXPORT
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B
		WHERE EXISTS (SELECT 1 FROM #YAHOO_FINANCE_INDICES_ICHART A WHERE [A].[Symbol] = [B].[Symbol])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'CREATE INDEX IDX_001 ON #YAHOO_ONE_DAY_EXPORT'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		CREATE INDEX IDX_001 ON #YAHOO_ONE_DAY_EXPORT ([SYMBOL], [ClosureDate], [PRICE])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[v_YAHOO_FINANCE_INDICES] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY -- do me next ...
		SELECT * INTO #YAHOO_FINANCE_INDICES
		FROM [STG].[v_YAHOO_FINANCE_INDICES] B
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT * INTO #INVESTMENT_SECTOR_REPORT_FILTER
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ..MANAGE GBP OR GBX FROM ICHART
	-- MULTIPLY #YAHOO_FINANCE_INDICES_ICHART BY 100
	-- ==========================================================================================================================================

	SET @I_MSG = 'BUILD #YAHOO_FINANCE_INDICES_ICHART_MULTIPLY_100'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [A].*
		INTO #YAHOO_FINANCE_INDICES_ICHART_MULTIPLY_100
		FROM #YAHOO_FINANCE_INDICES A, #YAHOO_FINANCE_INDICES_ICHART B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[LAST_TRADE_DATE] = [B].[ClosureDate]
		AND [A].[LAST_TRADE_PRICE_GBP] <> [B].[CLOSE_GBP]
		AND ([B].[CLOSE_GBP] * (100)) / [A].[LAST_TRADE_PRICE_GBP] BETWEEN (0.90) AND (1.10)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_INDICES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_INDICES_ICHART
		SET [OPEN_GBP] = [OPEN_GBP] * (100)
		, [HIGH_GBP] = [HIGH_GBP] * (100)
		, [LOW_GBP] = [LOW_GBP] * (100)
		, [CLOSE_GBP] = [CLOSE_GBP] * (100)
		, [Adj Close_GBP] = [Adj Close_GBP] * (100)
		WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #YAHOO_FINANCE_INDICES_ICHART_MULTIPLY_100)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ..MANAGE GBP OR GBX FROM ICHART
	-- DIVIDE #YAHOO_FINANCE_INDICES_ICHART BY 100
	-- ==========================================================================================================================================

	SET @I_MSG = 'BUILD #YAHOO_FINANCE_INDICES_ICHART_DIVIDE_100'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [A].*
		INTO #YAHOO_FINANCE_INDICES_ICHART_DIVIDE_100
		FROM #YAHOO_FINANCE_INDICES A, #YAHOO_FINANCE_INDICES_ICHART B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[LAST_TRADE_DATE] = [B].[ClosureDate]
		AND [A].[LAST_TRADE_PRICE_GBP] <> [B].[CLOSE_GBP]
		AND ([B].[CLOSE_GBP] / (100)) / [A].[LAST_TRADE_PRICE_GBP] BETWEEN (0.90) AND (1.10)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_INDICES_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_INDICES_ICHART
		SET [OPEN_GBP] = [OPEN_GBP] / (100)
		, [HIGH_GBP] = [HIGH_GBP] / (100)
		, [LOW_GBP] = [LOW_GBP] / (100)
		, [CLOSE_GBP] = [CLOSE_GBP] / (100)
		, [Adj Close_GBP] = [Adj Close_GBP] / (100)
		WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #YAHOO_FINANCE_INDICES_ICHART_DIVIDE_100)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- GET LIST OF PREVIOUS DATES
	-- ==========================================================================================================================================
	SET @I_MSG = 'CREATE #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT DISTINCT [Symbol], [ClosureDate], (SELECT MAX([ClosureDate]) FROM #YAHOO_FINANCE_INDICES_ICHART B
										WHERE [A].[Symbol] = [B].[Symbol]
										AND [B].[ClosureDate] < [A].[ClosureDate]) AS [Previous_Closure_Date]
		INTO #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES-- DROP TABLE #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES
		FROM #YAHOO_FINANCE_INDICES_ICHART A
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'DELETE #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES
		WHERE ABS(DATEDIFF(dd, [ClosureDate], [Previous_Closure_Date])) > 7
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_INDICES_ICHART (SET PREVIOUS_CLOSE)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

/*
SELECT a.symbol,
A.[CLOSuredate]
-- , A.[CLOSE_GBP]
, sum([b].[close_gbp])
, [C].[AS Previous_Closure_Date]
, count(*)
 FROM #YAHOO_FINANCE_INDICES_ICHART A, #YAHOO_FINANCE_INDICES_ICHART B, #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES C
									WHERE [A].[ClosureDate] = [C].[ClosureDate] AND [C].[AS Previous_Closure_Date] = [B].[ClosureDate]
									AND [A].[Symbol] = [B].[Symbol] AND [C].[Symbol] = [B].[Symbol]
group by a.symbol,A.[CLOSuredate], [C].[AS Previous_Closure_Date]
having count(*) > 1
		-- FROM 

select top (100) * from #YAHOO_FINANCE_INDICES_ICHART -- #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES
where symbol = '^GSPC'
and closuredate = '2016-09-08'
*/

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_INDICES_ICHART
		SET [PREVIOUS_CLOSE_GBP] = (SELECT [B].[CLOSE_GBP] FROM #YAHOO_FINANCE_INDICES_ICHART B, #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES C
									WHERE [A].[ClosureDate] = [C].[ClosureDate] AND [C].[Previous_Closure_Date] = [B].[ClosureDate]
									AND [A].[Symbol] = [B].[Symbol] AND [C].[Symbol] = [B].[Symbol])
		FROM #YAHOO_FINANCE_INDICES_ICHART A
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- INSERT
	-- ==========================================================================================================================================

	SET @I_MSG = 'INSERT INTO [STG].[YAHOO_ONE_DAY_EXPORT]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
		([Name], [Symbol], [ClosureDate], [OPEN_PRICE], [Days_Low], [Days_High], [Price], [Currency]
		, [Stock Exchange], [DateLoaded], [Volume], [PREVIOUS_CLOSE])

		SELECT DISTINCT [C].[INVESTMENT_NAME], [B].[SYMBOL], [B].[ClosureDate], [B].[OPEN_GBP], [B].[LOW_GBP], [B].[HIGH_GBP]
		, [B].[CLOSE_GBP],  'GBP', 'LSE', GETDATE(), [Volume], [B].[PREVIOUS_CLOSE_GBP]
		FROM #YAHOO_FINANCE_INDICES_ICHART B, [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] C
		WHERE NOT EXISTS (SELECT (1) FROM #YAHOO_ONE_DAY_EXPORT A
							WHERE [A].[SYMBOL] = [B].[SYMBOL]
							AND [A].[ClosureDate] = [B].[ClosureDate])
		AND [C].[PRIMARY_LABEL] = [B].[SYMBOL]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error has occured INSERT [STG].[YAHOO_ONE_DAY_EXPORT]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG = 'ROWS INSERTED ([STG].[YAHOO_ONE_DAY_EXPORT]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================================================
	-- UPDATE
	-- ==========================================================================================================================================

	IF @UPDATE_OPEN_PRICE = (1)
	BEGIN
		SET @I_MSG = 'UPDATE [OPEN_PRICE] on [STG].[YAHOO_ONE_DAY_EXPORT]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
			SET [OPEN_PRICE] = [B].[OPEN_GBP]
			FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] A
			, [STG].[v_YAHOO_FINANCE_INDICES_ICHART] B
			WHERE [A].[SYMBOL] = [B].[SYMBOL]
			AND [A].[ClosureDate] = [B].[ClosureDate]
			AND [A].[OPEN_PRICE] IS NULL
			AND [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) BETWEEN (0.75) and (1.25)
			AND ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) <> (0)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH

		IF @v_ERR <> (0)
		BEGIN
			PRINT 'Error has occured UPDATE [STG].[YAHOO_ONE_DAY_EXPORT]' + CONVERT(VARCHAR(10),@v_ERR)
			RETURN (255)
		END

		SET @I_MSG = 'ROWS UPDATED ([STG].[YAHOO_ONE_DAY_EXPORT]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	DECLARE @FINAL_CHECKS INT
	SET @FINAL_CHECKS = 0

	IF @FINAL_CHECKS = (1)
	BEGIN
		SET @I_MSG = 'PRICE CHECK REPORT'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		SELECT [B].[OPEN_GBP], [A].[PRICE] AS CURRENT_PRICE, [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) AS cCHECK, [A].*
		INTO #UPDATE_ME -- DROP TABLE #UPDATE_ME
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] A
		, [STG].[v_YAHOO_FINANCE_INDICES_ICHART] B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[ClosureDate] = [B].[ClosureDate]
		AND [B].[OPEN_GBP] > (0.009)
		AND [A].[PRICE] > (0.009)
		AND [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) NOT BETWEEN (0.75) and (1.25)

		-- ===========================================================================================
		-- FUNDS ARE PROVIDED BY YAHOO AS GBP AND SO SHOULD NOT BE DIV 100
		-- ===========================================================================================

		SELECT TOP (500) CURRENT_PRICE / ([OPEN_GBP] * (100)), *
		FROM #UPDATE_ME WHERE LEN(SYMBOL) = (12)
		AND CURRENT_PRICE / ([OPEN_GBP] * (100)) NOT BETWEEN (0.97) and (1.03)
		ORDER BY [ClosureDate] DESC
	-- .. conclusion very FEW to correct and leave alone ....

		-- ===========================================================================================
		-- FUNDS ARE PROVIDED BY YAHOO AS GBP AND SO SHOULD NOT BE DIV 100
		-- ===========================================================================================
	
		SELECT TOP (500) [B].MARKET_NAME, [A].*
		FROM #UPDATE_ME A, #INVESTMENT_SECTOR_REPORT_FILTER B
		WHERE LEN([A].[SYMBOL]) < (12) AND [A].[SYMBOL] = [B].LABEL
		AND [B].MARKET_NAME NOT LIKE '%FTSE AIM All-Share (INDICES)%' -- many of these are a guess at AIM
		AND [B].MARKET_NAME NOT LIKE '%FTSE All Share (INDICES)' -- ignore just for now
		AND [A].CURRENT_PRICE / ([A].[OPEN_GBP] * (1)) NOT BETWEEN (0.97) and (1.03)
		ORDER BY [A].[ClosureDate] DESC

		SELECT TOP (500) * FROM #UPDATE_ME ORDER BY ABS(cCHECK)
	
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [PRIMARY_LABEL] = 'JDTC'
	
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [SOURCE_OF_IMPORT] LIKE '%HARGRE%'
		AND INVESTMENT_TYPE_NAME = 'Equity'
	END

	-- ==================================================================================================================================
	-- TIDY UP
	-- ==================================================================================================================================

	DROP TABLE #YAHOO_ONE_DAY_EXPORT
	DROP TABLE #YAHOO_FINANCE_INDICES_ICHART
	DROP TABLE #INVESTMENT_SECTOR_REPORT_FILTER
	DROP TABLE #YAHOO_FINANCE_INDICES
	DROP TABLE #YAHOO_FINANCE_INDICES_ICHART_MULTIPLY_100
	DROP TABLE #YAHOO_FINANCE_INDICES_ICHART_DIVIDE_100
	DROP TABLE #YAHOO_FINANCE_INDICES_ICHART_PREVIOUS_DATES

	IF @FINAL_CHECKS = (1) DROP TABLE #UPDATE_ME

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC] (@BUILD_ID INT, @vRE INT, @ROWS_IN_BATCH_EXPECTED INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	October 2016
	-- Version History:
	-- 1.0		Initial Release
	-- import data FROM Excel
	-- https://support.microsoft.com/en-gb/kb/321686#bookmark-4c
	-- http://www.excel-sql-server.com/excel-import-to-sql-server-using-linked-servers.htm

	-- EXEC [Alchemy_Build].[BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC] 0, 1, 1
	-- ==================================================================================================================================

	DECLARE @v_ERR INT, @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @i_message VARCHAR(5000), @RETVAL INT
	DECLARE @sqlCommand VARCHAR(2500), @sqlCommand_CURR VARCHAR(1000), @PARENT_USP VARCHAR(250), @RETURN_VALUE int

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID), 'PROCID_UNKNOWN')
	SET @DEBUG = (1)

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [SYMBOL]
		, [NAME]
		, MAX([LAST_TRADE_PRICE_GBP]) AS [LAST_TRADE_PRICE_GBP]
		, MAX([DAYS_LOW_GBP]) AS [DAYS_LOW_GBP]
		, MAX([DAYS_HIGH_GBP]) AS [DAYS_HIGH_GBP]
		, MAX([PCT_CHANGE]) AS [PCT_CHANGE]
		, [CURRENCY]
		, MAX([PE_RATIO]) AS [PE_RATIO]
		, MAX([PEG_RATIO]) AS [PEG_RATIO]
		, MAX([LOW_52WEEK_GBP]) AS [LOW_52WEEK_GBP]
		, MAX([HIGH_52WEEK_GBP]) AS [HIGH_52WEEK_GBP]
		, MAX([MOVING_AVG_50_DAY_GBP]) AS [MOVING_AVG_50_DAY_GBP]
		, MAX([PCT_CHANGE_FROM_50_DAY_MA]) AS [PCT_CHANGE_FROM_50_DAY_MA]
		, MAX([DIVIDEND_YIELD]) AS [DIVIDEND_YIELD]
		, [STOCK_EXCHANGE]
		, [LAST_TRADE_DATE]
		, MAX([OPEN_PRICE_GBP]) AS [OPEN_PRICE_GBP]
		, MAX([PREVIOUS_CLOSE_GBP]) AS [PREVIOUS_CLOSE_GBP]
		, MAX([Commission]) AS [Commission]
		, MAX([Volume]) AS [Volume]
		, MAX([AverageDailyVolume]) AS [AverageDailyVolume]
		, MAX([DividendPerShare]) AS [DividendPerShare]
		, MAX([MarketCapitalization]) AS [MarketCapitalization]
		INTO #ACTIVE
		FROM [STG].[v_YAHOO_FINANCE_OEIC]
		GROUP BY [SYMBOL], [NAME], [CURRENCY], [STOCK_EXCHANGE], [LAST_TRADE_DATE]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'CREATE #ACTIVE table from OPEN DATASOURCE (VIEW)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO #ACTIVE
		([SYMBOL], [NAME], [LAST_TRADE_PRICE_GBP], [DAYS_LOW_GBP], [DAYS_HIGH_GBP], [PCT_CHANGE], [CURRENCY], [PE_RATIO]
		, [PEG_RATIO], [LOW_52WEEK_GBP], [HIGH_52WEEK_GBP], [MOVING_AVG_50_DAY_GBP], [PCT_CHANGE_FROM_50_DAY_MA], [DIVIDEND_YIELD]
		, [STOCK_EXCHANGE], [LAST_TRADE_DATE])

		SELECT [Symbol], [Name], MAX([Price]), MAX([Days_Low]), MAX([Days _High]), MAX([Change]), [Currency], MAX([P/E_Ratio])
		, MAX([PEG_Ratio]), MAX([52wk_low]), MAX([52wk_high]), MAX([50 day_moving avg]), MAX([%age change FROM 50day avg])
		, MAX([Dividend_Yield]), [Stock Exchange], [Export Date]
		FROM [STG].[v_YAHOO_FINANCE_OEIC_still_need_XLSM] A
		WHERE NOT EXISTS (SELECT (1) FROM #ACTIVE B WHERE [A].[Symbol] = [B].[Symbol] AND [A].[Export Date] = [B].[LAST_TRADE_DATE])
		GROUP BY [Symbol], [Name], [Currency], [Stock Exchange], [Export Date]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = '(MORE) ROWS INSERTED to #ACTIVE = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	IF EXISTS (SELECT (1) FROM [tempdB]..sysobjects WHERE NAME LIKE '#SymbolsToProcess')
		DROP TABLE #SymbolsToProcess

	BEGIN TRY
		CREATE TABLE #SymbolsToProcess ([tColumn01] VARCHAR(250), [tColumn02] VARCHAR(250), [tDate] DATE NULL)
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, 'Error CREATE TABLE #SymbolsToProcess', @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO #SymbolsToProcess (YAHOO_OEIC)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SET @sqlCommand = 'INSERT INTO #SymbolsToProcess ' +@sqlCommand
		IF @BUILD_ID = 0 PRINT @sqlCommand

		INSERT INTO #SymbolsToProcess SELECT DISTINCT 
		[Symbol], [Symbol], [LAST_TRADE_DATE]
		FROM #ACTIVE B

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED to #SymbolsToProcess = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- REPORT MISSING INVESTMENTS
	-- ==================================================================================================================================
	SET @I_MSG = 'CHECK FOR MISSING INVESTMENT ALIASES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF EXISTS (SELECT [tColumn01] FROM #SymbolsToProcess A WHERE [A].[tColumn01]
				NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT]))
	BEGIN
		SET @I_MSG = @PARENT_USP + ':New [Symbol]s required?'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		SELECT @i_message = [tColumn01] FROM #SymbolsToProcess A
		WHERE [A].[tColumn01]
		NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT])

		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @I_MSG, @i_message
	END

	-- ==================================================================================================================================
	-- STG
	-- ==================================================================================================================================

	SET @I_MSG = 'EXEC [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	DECLARE @SymbolsToProcess AS dbo.SymbolsToProcess
	INSERT INTO @SymbolsToProcess SELECT * FROM #SymbolsToProcess

	BEGIN TRY
		EXEC @RETVAL = [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor] @BUILD_ID, @vRE, @SymbolsToProcess, 5000 -- 1500
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @RETVAL <> (0)
	BEGIN
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] ([Symbol], [Name], [Price], [Days_Low]
		, [Days_High], [Change], [Currency], [P/E_Ratio], [PEG_Ratio], [52wk_low], [52wk_high], [50 day_moving avg]
		, [%age change FROM 50day avg], [Dividend_Yield], [Stock Exchange], [ClosureDate]
		, [OPEN_PRICE], [PREVIOUS_CLOSE], [Volume], [AverageDailyVolume]
		, [DividendPerShare], [MarketCapitalization])

		SELECT DISTINCT [SYMBOL]
		, [NAME]
		, [LAST_TRADE_PRICE_GBP]
		, [DAYS_LOW_GBP]
		, [DAYS_HIGH_GBP]
		, [PCT_CHANGE]
		, [CURRENCY]
		, [PE_RATIO]
		, [PEG_RATIO]
		, [LOW_52WEEK_GBP]
		, [HIGH_52WEEK_GBP]
		, [MOVING_AVG_50_DAY_GBP]
		, [PCT_CHANGE_FROM_50_DAY_MA]
		, [DIVIDEND_YIELD]
		, [STOCK_EXCHANGE]
		, [LAST_TRADE_DATE]
		, [OPEN_PRICE_GBP]
		, [PREVIOUS_CLOSE_GBP]
		, [Volume]
		, [AverageDailyVolume]
		, [DividendPerShare]
		, [MarketCapitalization]

		FROM
		#ACTIVE B, #SymbolsToProcess D
		WHERE NOT EXISTS (SELECT (1) FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] S
						WHERE [B].[Symbol] = [S].[Symbol]
						AND [S].[ClosureDate] = [B].[LAST_TRADE_DATE])
		AND [B].[Symbol] = [D].[tColumn01]
		AND [D].[tDate] = [B].[LAST_TRADE_DATE]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'ROWS INSERTED (YAHOO_ONE_DAY_EXPORT) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	IF @v_ROWCOUNT < @ROWS_IN_BATCH_EXPECTED
	BEGIN
		DECLARE @tSUBJ VARCHAR(250)
		SET @tSUBJ = 'Data loaded low? (YAHOO_OEIC)'
		SET @i_msg = @PARENT_USP + ': '+ CONVERT(VARCHAR(100),@v_ROWCOUNT)+ ' rows loaded.'
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_EMAIL] @tSUBJ, @i_msg
	END

	-- ==================================================================================================================================
	-- 
	-- ==================================================================================================================================

	DROP TABLE #SymbolsToProcess

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - DEFINE THE DATA SET
	-- ==================================================================================================================================

	DECLARE @InvestmentsToAdd AS dbo.InvestmentsToAdd

	INSERT INTO @InvestmentsToAdd
	SELECT DISTINCT [Symbol]
	, [Name], 'Fund', '%KNOWN%', 'IA (Unit Trusts & OEICS)' -- 20170120 GUESS AT LABELS - 0 rows so hard to check
	FROM #ACTIVE
	WHERE [NAME] LIKE '[%A-Za-z]%'
	AND [Symbol] NOT IN (SELECT [PRIMARY_LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT]) -- REPLACE([Symbol], '.L', '')
	AND [Symbol] NOT IN (SELECT [LABEL] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT_ALIAS]) -- REPLACE([Symbol], '.L', '')

	-- ==================================================================================================================================
	-- AUTO ADD MISSING INVESTMENTS - ADD NOW ...
	-- ==================================================================================================================================

	BEGIN TRY
		EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_ADD_MISSING_INVESTMENTS] 1, 0, @InvestmentsToAdd
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		-- RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	DROP TABLE #ACTIVE

	-- ==================================================================================================================================
	-- ==================================================================================================================================

	SET @I_MSG = 'THE END'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE

END




GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC_ICHART]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC_ICHART] (@BUILD_ID INT, @vRE INT, @UPDATE_OPEN_PRICE INT) AS
BEGIN	

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2017
	-- Version HistoryOEIC
	-- 1.0		Initial Release
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FILE_YAHOO_OEIC_ICHART] 0, 1, 0
	-- ==================================================================================================================================

	SET DATEFORMAT MDY
	SET NOCOUNT ON
	
	DECLARE @v_ERR INT, @I_MSG VARCHAR(255), @PARENT_USP VARCHAR(250), @v_ROWCOUNT INT, @RETVAL INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	
	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[v_YAHOO_FINANCE_OEIC_ICHART] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [SYMBOL], [ClosureDate]
		, MAX([OPEN_GBP])  AS [OPEN_GBP]
		, MAX([HIGH_GBP])  AS [HIGH_GBP]
		, MAX([LOW_GBP])   AS [LOW_GBP]
		, MAX([CLOSE_GBP]) AS [CLOSE_GBP]
		, MAX([VOLUME])	   AS [VOLUME]
		, MAX([Adj Close_GBP]) AS [Adj Close_GBP]
		, NULL AS [PREVIOUS_CLOSE_GBP]
		INTO #YAHOO_FINANCE_OEIC_ICHART
		FROM [STG].[v_YAHOO_FINANCE_OEIC_ICHART] B
		WHERE DATEADD(DD,(365),[Closuredate]) > GETDATE() -- ONLY GET THIS YEARS DATA
		GROUP BY [SYMBOL], [ClosureDate]
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'CREATE INDEX IDX_001 ON #YAHOO_FINANCE_OEIC_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		CREATE INDEX IDX_001 ON #YAHOO_FINANCE_OEIC_ICHART ([SYMBOL], [ClosureDate], [CLOSE_GBP])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[YAHOO_ONE_DAY_EXPORT] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [B].[SYMBOL], [B].[ClosureDate], [B].[PRICE]
		INTO #YAHOO_ONE_DAY_EXPORT
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] B
		WHERE EXISTS (SELECT 1 FROM #YAHOO_FINANCE_OEIC_ICHART A WHERE [A].[Symbol] = [B].[Symbol])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'CREATE INDEX IDX_001 ON #YAHOO_ONE_DAY_EXPORT'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		CREATE INDEX IDX_001 ON #YAHOO_ONE_DAY_EXPORT ([SYMBOL], [ClosureDate], [PRICE])
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [STG].[v_YAHOO_FINANCE_OEIC] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY -- do me next ...
		SELECT * INTO #YAHOO_FINANCE_OEIC
		FROM [STG].[v_YAHOO_FINANCE_OEIC] B
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================

	SET @I_MSG = 'GET ALL OF [MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] INTO #TABLE'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT * INTO #INVESTMENT_SECTOR_REPORT_FILTER
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[v_INVESTMENT_SECTOR_REPORT_FILTER] B
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ..MANAGE GBP OR GBX FROM ICHART
	-- MULTIPLY #YAHOO_FINANCE_OEIC_ICHART BY 100
	-- ==========================================================================================================================================

	SET @I_MSG = 'BUILD #YAHOO_FINANCE_OEIC_ICHART_MULTIPLY_100'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [A].*
		INTO #YAHOO_FINANCE_OEIC_ICHART_MULTIPLY_100
		FROM #YAHOO_FINANCE_OEIC A, #YAHOO_FINANCE_OEIC_ICHART B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[LAST_TRADE_DATE] = [B].[ClosureDate]
		AND [A].[LAST_TRADE_PRICE_GBP] <> [B].[CLOSE_GBP]
		AND ([B].[CLOSE_GBP] * (100)) / [A].[LAST_TRADE_PRICE_GBP] BETWEEN (0.90) AND (1.10)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_OEIC_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_OEIC_ICHART
		SET [OPEN_GBP] = [OPEN_GBP] * (100)
		, [HIGH_GBP] = [HIGH_GBP] * (100)
		, [LOW_GBP] = [LOW_GBP] * (100)
		, [CLOSE_GBP] = [CLOSE_GBP] * (100)
		, [Adj Close_GBP] = [Adj Close_GBP] * (100)
		WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #YAHOO_FINANCE_OEIC_ICHART_MULTIPLY_100)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- ..MANAGE GBP OR GBX FROM ICHART
	-- DIVIDE #YAHOO_FINANCE_OEIC_ICHART BY 100
	-- ==========================================================================================================================================

	SET @I_MSG = 'BUILD #YAHOO_FINANCE_OEIC_ICHART_DIVIDE_100'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [A].*
		INTO #YAHOO_FINANCE_OEIC_ICHART_DIVIDE_100
		FROM #YAHOO_FINANCE_OEIC A, #YAHOO_FINANCE_OEIC_ICHART B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[LAST_TRADE_DATE] = [B].[ClosureDate]
		AND [A].[LAST_TRADE_PRICE_GBP] <> [B].[CLOSE_GBP]
		AND ([B].[CLOSE_GBP] / (100)) / [A].[LAST_TRADE_PRICE_GBP] BETWEEN (0.90) AND (1.10)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_OEIC_ICHART'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_OEIC_ICHART
		SET [OPEN_GBP] = [OPEN_GBP] / (100)
		, [HIGH_GBP] = [HIGH_GBP] / (100)
		, [LOW_GBP] = [LOW_GBP] / (100)
		, [CLOSE_GBP] = [CLOSE_GBP] / (100)
		, [Adj Close_GBP] = [Adj Close_GBP] / (100)
		WHERE [SYMBOL] IN (SELECT [SYMBOL] FROM #YAHOO_FINANCE_OEIC_ICHART_DIVIDE_100)
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- GET LIST OF PREVIOUS DATES
	-- ==========================================================================================================================================
	SET @I_MSG = 'CREATE #YAHOO_FINANCE_OEIC_ICHART_PREVIOUS_DATES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		SELECT [Symbol], [ClosureDate], (SELECT MAX([ClosureDate]) FROM #YAHOO_FINANCE_OEIC_ICHART B
										WHERE [A].[Symbol] = [B].[Symbol]
										AND [B].[ClosureDate] < [A].[ClosureDate]) AS [Previous_Closure_Date]
		INTO #YAHOO_FINANCE_OEIC_ICHART_PREVIOUS_DATES
		FROM #YAHOO_FINANCE_OEIC_ICHART A
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'DELETE #YAHOO_FINANCE_OEIC_ICHART_PREVIOUS_DATES'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		DELETE #YAHOO_FINANCE_OEIC_ICHART_PREVIOUS_DATES
		WHERE ABS(DATEDIFF(dd, [ClosureDate], [Previous_Closure_Date])) > 7
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- 
	-- ==========================================================================================================================================
	SET @I_MSG = 'UPDATE #YAHOO_FINANCE_OEIC_ICHART (SET PREVIOUS_CLOSE)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE #YAHOO_FINANCE_OEIC_ICHART
		SET [PREVIOUS_CLOSE_GBP] = (SELECT [CLOSE_GBP] FROM #YAHOO_FINANCE_OEIC_ICHART B, #YAHOO_FINANCE_OEIC_ICHART_PREVIOUS_DATES C
									WHERE [A].[ClosureDate] = [C].[ClosureDate] AND [C].[Previous_Closure_Date] = [B].[ClosureDate]
									AND [A].[SYMBOL] = [B].[SYMBOL] AND [B].[SYMBOL] = [C].[SYMBOL])
		FROM #YAHOO_FINANCE_OEIC_ICHART A
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==========================================================================================================================================
	-- INSERT
	-- ==========================================================================================================================================

	SET @I_MSG = 'INSERT INTO [STG].[YAHOO_ONE_DAY_EXPORT]'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
		([Name], [Symbol], [ClosureDate], [OPEN_PRICE], [Days_Low], [Days_High], [Price], [Currency]
		, [Stock Exchange], [DateLoaded], [Volume], [PREVIOUS_CLOSE])

		SELECT DISTINCT [C].[INVESTMENT_NAME], [B].[SYMBOL], [B].[ClosureDate], [B].[OPEN_GBP], [B].[LOW_GBP], [B].[HIGH_GBP]
		, [B].[CLOSE_GBP],  'GBP', 'LSE', GETDATE(), [Volume], [B].[PREVIOUS_CLOSE_GBP]
		FROM #YAHOO_FINANCE_OEIC_ICHART B, [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] C
		WHERE NOT EXISTS (SELECT (1) FROM #YAHOO_ONE_DAY_EXPORT A
							WHERE [A].[SYMBOL] = [B].[SYMBOL]
							AND [A].[ClosureDate] = [B].[ClosureDate])
		AND [C].[PRIMARY_LABEL] = [B].[SYMBOL]

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY
	
	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	IF @v_ERR <> (0)
	BEGIN
		PRINT 'Error has occured INSERT [STG].[YAHOO_ONE_DAY_EXPORT]' + CONVERT(VARCHAR(10),@v_ERR)
		RETURN (255)
	END

	SET @I_MSG = 'ROWS INSERTED ([STG].[YAHOO_ONE_DAY_EXPORT]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==========================================================================================================================================
	-- UPDATE
	-- ==========================================================================================================================================

	IF @UPDATE_OPEN_PRICE = (1)
	BEGIN
		SET @I_MSG = 'UPDATE [OPEN_PRICE] on [STG].[YAHOO_ONE_DAY_EXPORT]'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		BEGIN TRY
			UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT]
			SET [OPEN_PRICE] = [B].[OPEN_GBP]
			FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] A
			, [STG].[v_YAHOO_FINANCE_OEIC_ICHART] B
			WHERE [A].[SYMBOL] = [B].[SYMBOL]
			AND [A].[ClosureDate] = [B].[ClosureDate]
			AND [A].[OPEN_PRICE] IS NULL
			AND [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) BETWEEN (0.75) and (1.25)
			AND ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) <> (0)

			SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
		END TRY
	
		BEGIN CATCH
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			RETURN (255)
		END CATCH

		IF @v_ERR <> (0)
		BEGIN
			PRINT 'Error has occured UPDATE [STG].[YAHOO_ONE_DAY_EXPORT]' + CONVERT(VARCHAR(10),@v_ERR)
			RETURN (255)
		END

		SET @I_MSG = 'ROWS UPDATED ([STG].[YAHOO_ONE_DAY_EXPORT]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END

	-- ==========================================================================================================================================
	-- ==========================================================================================================================================
	DECLARE @FINAL_CHECKS INT
	SET @FINAL_CHECKS = 0

	IF @FINAL_CHECKS = (1)
	BEGIN
		SET @I_MSG = 'PRICE CHECK REPORT'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG

		SELECT [B].[OPEN_GBP], [A].[PRICE] AS CURRENT_PRICE, [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) AS cCHECK, [A].*
		INTO #UPDATE_ME -- DROP TABLE #UPDATE_ME
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[STG].[YAHOO_ONE_DAY_EXPORT] A
		, [STG].[v_YAHOO_FINANCE_OEIC_ICHART] B
		WHERE [A].[SYMBOL] = [B].[SYMBOL]
		AND [A].[ClosureDate] = [B].[ClosureDate]
		AND [B].[OPEN_GBP] > (0.009)
		AND [A].[PRICE] > (0.009)
		AND [A].[PRICE] / ((0.000001) + ISNULL([B].[OPEN_GBP], 0)) NOT BETWEEN (0.75) and (1.25)

		-- ===========================================================================================
		-- FUNDS ARE PROVIDED BY YAHOO AS GBP AND SO SHOULD NOT BE DIV 100
		-- ===========================================================================================

		SELECT TOP (500) CURRENT_PRICE / ([OPEN_GBP] * (100)), *
		FROM #UPDATE_ME WHERE LEN(SYMBOL) = (12)
		AND CURRENT_PRICE / ([OPEN_GBP] * (100)) NOT BETWEEN (0.97) and (1.03)
		ORDER BY [ClosureDate] DESC
	-- .. conclusion very FEW to correct and leave alone ....

		-- ===========================================================================================
		-- FUNDS ARE PROVIDED BY YAHOO AS GBP AND SO SHOULD NOT BE DIV 100
		-- ===========================================================================================
	
		SELECT TOP (500) [B].MARKET_NAME, [A].*
		FROM #UPDATE_ME A, #INVESTMENT_SECTOR_REPORT_FILTER B
		WHERE LEN([A].[SYMBOL]) < (12) AND [A].[SYMBOL] = [B].LABEL
		AND [B].MARKET_NAME NOT LIKE '%FTSE AIM All-Share (OEIC)%' -- many of these are a guess at AIM
		AND [B].MARKET_NAME NOT LIKE '%FTSE All Share (OEIC)' -- ignore just for now
		AND [A].CURRENT_PRICE / ([A].[OPEN_GBP] * (1)) NOT BETWEEN (0.97) and (1.03)
		ORDER BY [A].[ClosureDate] DESC

		SELECT TOP (500) * FROM #UPDATE_ME ORDER BY ABS(cCHECK)
	
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [PRIMARY_LABEL] = 'JDTC'
	
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[v_INVESTMENT] WHERE [SOURCE_OF_IMPORT] LIKE '%HARGRE%'
		AND INVESTMENT_TYPE_NAME = 'Equity'
	END

	-- ==================================================================================================================================
	-- TIDY UP
	-- ==================================================================================================================================

	DROP TABLE #YAHOO_ONE_DAY_EXPORT
	DROP TABLE #YAHOO_FINANCE_OEIC_ICHART
	DROP TABLE #INVESTMENT_SECTOR_REPORT_FILTER
	DROP TABLE #YAHOO_FINANCE_OEIC
	DROP TABLE #YAHOO_FINANCE_OEIC_ICHART_MULTIPLY_100
	DROP TABLE #YAHOO_FINANCE_OEIC_ICHART_DIVIDE_100
	DROP TABLE #YAHOO_FINANCE_OEIC_ICHART_PREVIOUS_DATES

	IF @FINAL_CHECKS = (1) DROP TABLE #UPDATE_ME

END
GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS] (@BUILD_ID INT, @vRE INT ) WITH RECOMPILE AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	Februray 2017
	-- Version History:
	-- 1.0		Initial Release (1.1 2016110 Moved to Azure)
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_FINAL_CHECKS] 837, 1
	-- ==================================================================================================================================

	DECLARE @i_msg VARCHAR(3000), @NEWLINE CHAR(2), @i_msg_fn VARCHAR(3000)
	DECLARE @ALERT_DESC_SHORT VARCHAR(50), @ALERT_DESC_LONG VARCHAR(250), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SELECT @NEWLINE = CHAR(13) + CHAR(10)

	-- ==================================================================================================================================
	-- 
	-- ==================================================================================================================================

	SET @ALERT_DESC_SHORT = '01B: MISSING HlReference'
	SET @ALERT_DESC_LONG  = '01B: MISSING HlReference from v_SIPP_transaction_history entries'

	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @ALERT_DESC_LONG, @vRE

	INSERT [AZURE_R7_ALCHEMY_DATA].[ALCHEMY_DATA].[BLD].[LOAD_ALERTS] ([BUILD_ID], [ENTRY_CATGY], [ENTRY_NOTES])
	SELECT DISTINCT @BUILD_ID, @ALERT_DESC_SHORT, -- SELECT
	'EAH:'+[Reference]+':'+[Description]
	FROM [Alchemy_Build].[STG].[v_HL_EAH_SIPP]
	WHERE [Reference] NOT IN (SELECT ISNULL([HlReference],'')
							FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[dbo].[v_sipp_transaction_history])
	UNION
	SELECT DISTINCT @BUILD_ID, @ALERT_DESC_SHORT, -- SELECT
	'KAH:'+[Reference]+':'+[Description]
	FROM [Alchemy_Build].[STG].[v_HL_KAH_SIPP]
	WHERE [Reference] NOT IN (SELECT ISNULL([HlReference],'')
							FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[dbo].[v_sipp_transaction_history])

	IF EXISTS (SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[ALCHEMY_DATA].[BLD].[v_MONITOR_BUILD_ALERTS] WHERE [ENTRY_CATGY] = @ALERT_DESC_SHORT)
	BEGIN
		-- IF @SEND_ERROR_EMAIL = 1
		BEGIN
			SET @i_msg = '['
			SELECT @i_msg = COALESCE(@i_msg+ '], [','[') + 'EAH:'+[Reference]+':'+[Description] + @NEWLINE
			FROM [Alchemy_Build].[STG].[v_HL_EAH_SIPP]
			WHERE [Reference] NOT IN (SELECT ISNULL([HlReference],'')
									FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[dbo].[v_sipp_transaction_history])

			SELECT @i_msg = COALESCE(@i_msg+ '], [','[') + 'KAH:'+[Reference]+':'+[Description] + @NEWLINE
			FROM [Alchemy_Build].[STG].[v_HL_KAH_SIPP]
			WHERE [Reference] NOT IN (SELECT ISNULL([HlReference],'')
									FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[dbo].[v_sipp_transaction_history])

			PRINT @i_msg
			SET @i_msg_fn =[Alchemy_Functions].[dbo].[fnHeaderAndFooterEmailCharacters](@i_msg)
			EXEC [BLD].[usp_STANDARD_EMAIL] @ALERT_DESC_LONG, @i_msg_fn
			PRINT @i_msg_fn
		END
	END
END

GO
/****** Object:  StoredProcedure [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES] (@BUILD_ID INT, @vRE INT)
AS
BEGIN
	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	February 2017
	-- Version History:
	--
	-- 1.0		Initial Release
	--
	-- EXEC [BLD].[usp_BUILD_IMPORT_XLS_SET_TELEGRAPH_INDICES] 0,1
	-- ==================================================================================================================================

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	DECLARE @I_MSG VARCHAR(255), @PARENT_USP VARCHAR(250)
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')

	-- ==================================================================================================================================
	-- GET IDS
	-- ==================================================================================================================================
	DECLARE @FTSE_100 INT, @FTSE_250 INT, @FTSE_350 INT

	SET @FTSE_100 = (SELECT [ID] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[MARKET] WHERE [MARKET_NAME] = 'FTSE100 (Equities)')
	SET @FTSE_250 = (SELECT [ID] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[MARKET] WHERE [MARKET_NAME] = 'FTSE250 (Equities)')
	SET @FTSE_350 = (SELECT [ID] FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[MARKET] WHERE [MARKET_NAME] = 'FTSE350 (Equities)')

	PRINT @FTSE_100
	PRINT @FTSE_250
	PRINT @FTSE_350

	IF @FTSE_100 IS NULL OR @FTSE_250 IS NULL OR @FTSE_350 IS NULL
	BEGIN
		SET @I_MSG = 'UNABLE TO GET ID FOR FTSE 100, 250, or 350'
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'E:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
		RETURN (255)
	END

	-- ==================================================================================================================================
	-- DELETE REPORT FILTER
	-- ==================================================================================================================================
	SET @I_MSG = 'DELETE [MAP].[INVESTMENT_SECTOR_REPORT_FILTER]'
	BEGIN TRY
		DELETE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		WHERE MARKET_ID IN (ISNULL(@FTSE_100,0), ISNULL(@FTSE_250,0), ISNULL(@FTSE_350,0))

		SET @I_MSG = '[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] (DELETE):' + CONVERT(VARCHAR, @@ROWCOUNT)
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- READ FROM AZURE
	-- ==================================================================================================================================
	SET @I_MSG = 'SELECT * INTO #SECTORS'
	BEGIN TRY
		SELECT * INTO #SECTORS
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[SECTORS]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- ==================================================================================================================================
	-- READ FROM THE VIEWS (CSV)
	-- ==================================================================================================================================
	SET @I_MSG = 'SELECT * INTO #v_TELEGRAPH_SECTOR'
	BEGIN TRY
		SELECT * INTO #v_TELEGRAPH_SECTOR
		FROM [STG].[v_TELEGRAPH_SECTOR]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = 'SELECT * INTO #v_TELEGRAPH_INDICES'
	BEGIN TRY
		SELECT * INTO #v_TELEGRAPH_INDICES
		FROM [STG].[v_TELEGRAPH_INDICES]
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	/*
	SELECT [INDICES], COUNT(*) FROM #v_TELEGRAPH_INDICES -- EPIC
	GROUP BY [INDICES]
	*/

	-- ==================================================================================================================================
	-- NOte .. ah
	-- FTSE350 - combination of the FTSE 100 Index of the largest 100 companies and the FTSE 250 Index of the NEXT largest 250
	-- ==================================================================================================================================
	
	SELECT *
	INTO #350_ONLY -- Drop table #350_ONLY
	FROM #v_TELEGRAPH_INDICES WHERE [INDICES] = 'FTSE 350'
	AND [EPIC] NOT IN (SELECT [EPIC] FROM #v_TELEGRAPH_INDICES WHERE [INDICES] = 'FTSE 100')
	AND [EPIC] NOT IN (SELECT [EPIC] FROM #v_TELEGRAPH_INDICES WHERE [INDICES] = 'FTSE 250')

	-- will be zero rows as INVESTMENT will be in FTSE100 or FTSE250 but NOT BOTH !!!!

	-- ==================================================================================================================================
	-- CREATE LIST TO ADD INTO FILTER TABLE
	-- ==================================================================================================================================

	-- ==================================================================================================================================
	-- FTSE 100
	-- ==================================================================================================================================
	SELECT [A].[EST_INVESTMENT_ID]
	, [A].[SECTOR]
	, (SELECT [ID] FROM #SECTORS WHERE [SECTOR] = [A].[SECTOR]) AS [SECTOR_ID]
	, [B].[Indices]
	, @FTSE_100 AS [MARKET_ID]
	INTO #ADD_ME_FTSE
	FROM #v_TELEGRAPH_SECTOR A, #v_TELEGRAPH_INDICES B
	WHERE [A].[EST_INVESTMENT_ID] = [B].[EST_INVESTMENT_ID]
	AND [B].[Indices] IN ('FTSE 100')

	SET @I_MSG = '#ADD_ME_FTSE ADD (FTSE100):' + CONVERT(VARCHAR, @@ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- FTSE 250
	-- ==================================================================================================================================
	INSERT INTO #ADD_ME_FTSE
	SELECT [A].[EST_INVESTMENT_ID]
	, [A].[SECTOR]
	, (SELECT [ID] FROM #SECTORS WHERE [SECTOR] = [A].[SECTOR]) AS [SECTOR_ID]
	, [B].[Indices]
	, @FTSE_250 AS [MARKET_ID]
	FROM #v_TELEGRAPH_SECTOR A, #v_TELEGRAPH_INDICES B
	WHERE [A].[EST_INVESTMENT_ID] = [B].[EST_INVESTMENT_ID]
	AND [B].[Indices] IN ('FTSE 250')
	AND NOT EXISTS (SELECT 1 FROM #ADD_ME_FTSE C WHERE [C].[EST_INVESTMENT_ID] = [A].[EST_INVESTMENT_ID])

	SET @I_MSG = '#ADD_ME_FTSE ADD (FTSE250):' + CONVERT(VARCHAR, @@ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- FTSE 350
	-- ==================================================================================================================================
	INSERT INTO #ADD_ME_FTSE
	SELECT [A].[EST_INVESTMENT_ID]
	, [A].[SECTOR]
	, (SELECT [ID] FROM #SECTORS WHERE [SECTOR] = [A].[SECTOR]) AS [SECTOR_ID]
	, [B].[Indices]
	, @FTSE_350 AS [MARKET_ID]
	-- , A.[Name]
	FROM #v_TELEGRAPH_SECTOR A, #v_TELEGRAPH_INDICES B
	WHERE [A].[EST_INVESTMENT_ID] = [B].[EST_INVESTMENT_ID]
	AND [B].[Indices] IN ('FTSE 350')

	SET @I_MSG = '#ADD_ME_FTSE ADD (FTSE350):' + CONVERT(VARCHAR, @@ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- ==================================================================================================================================
	-- ADD TO DATA SET
	-- ==================================================================================================================================
	SET @I_MSG = 'INSERT INTO [AZURE_R7_ALCHEMY_DATA]'

	if exists (select 1 from sys.objects where name = 'eah')
	drop table eah
	SELECT * INTO EAH FROM #ADD_ME_FTSE

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] ([INVESTMENT_ID], [SECTOR_ID], [MARKET_ID])
		SELECT [EST_INVESTMENT_ID], [SECTOR_ID], [MARKET_ID]
		-- FROM EAH A -- DROP TABLE EAH
		FROM #ADD_ME_FTSE A
		WHERE NOT EXISTS (SELECT 1 FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] B
						WHERE [A].[EST_INVESTMENT_ID] = [B].[INVESTMENT_ID]
						AND [A].[SECTOR_ID] = [B].[SECTOR_ID]
						AND [A].[MARKET_ID] = [B].[MARKET_ID])
		AND [EST_INVESTMENT_ID] IS NOT NULL
		AND [SECTOR_ID] IS NOT NULL
		AND [MARKET_ID] IS NOT NULL

		SET @I_MSG = '[MAP].[INVESTMENT_SECTOR_REPORT_FILTER] ADD:' + CONVERT(VARCHAR, @@ROWCOUNT)
		IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
		ELSE PRINT @I_MSG
	END TRY

	BEGIN CATCH
		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	/*
		SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[MAP].[INVESTMENT_SECTOR_REPORT_FILTER]
		WHERE CRDATE > '2017-02-26 10:09'
		WHERE [INVESTMENT_ID] = 2615
		AND [SECTOR_ID] = 44
		AND [MARKET_ID] = 1
	*/
	-- ==================================================================================================================================
	-- WARNING
	-- ==================================================================================================================================
	IF (1) = (1)
	SELECT 'NULL INVESTMENT_ID (i)', [A].[EST_INVESTMENT_ID], [B].[EST_INVESTMENT_ID]
	, '[usp_ADD_INVESTMENT] 0, 1, '''+[A].[NAME] +''',''' + [A].[EPIC]
	 +''',''' + 'Equity' +''',''' + '%' + [A].[SECTOR] + '%' +''',''' + '%' + [B].[INDICES] + '%' + ''', 1 , 0'
	FROM #v_TELEGRAPH_SECTOR A, #v_TELEGRAPH_INDICES B
	WHERE [A].[EPIC] =[B].[EPIC]
	AND ([A].[EST_INVESTMENT_ID] IS NULL OR [B].[EST_INVESTMENT_ID] IS NULL)
	ORDER BY [A].[EPIC], [B].[INDICES]

	-- EXEC [usp_ADD_INVESTMENT] 'Koovs plc', 'KOOV.L', 'Equity', '%Retailer%', '%AIM%ALL%SHARE%', 1, 0

	IF (1) = (1)
	SELECT 'NULL INVESTMENT_ID (ii)', [A].*
	FROM #v_TELEGRAPH_SECTOR A
	WHERE [A].[EST_INVESTMENT_ID] IS NULL
	ORDER BY [A].[EPIC]

	IF (1) = (0)
	SELECT * FROM #v_TELEGRAPH_SECTOR WHERE EPIC = 'CTEC'

	IF (1) = (1)
	SELECT 'NULL INVESTMENT_ID (iii)', [A].*
	FROM #v_TELEGRAPH_INDICES A
	WHERE [A].[EST_INVESTMENT_ID] IS NULL
	ORDER BY [A].[EPIC]
	
	IF (1) = (1)
	SELECT 'NULL SECTOR', * FROM #ADD_ME_FTSE WHERE [SECTOR_ID] IS NULL

	-- ==================================================================================================================================
	-- TIDY UP
	-- ==================================================================================================================================
	DROP TABLE #ADD_ME_FTSE
	DROP TABLE #v_TELEGRAPH_SECTOR
	DROP TABLE #v_TELEGRAPH_INDICES
	DROP TABLE #SECTORS
	DROP TABLE #350_ONLY

	/*
	SELECT * FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[SECTORS]
	WHERE sector like '%oil%gas%'

	update [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[DIM].[SECTORS]
	set sector = 'Oil & Gas Producers'
	WHERE sector = 'Oil and Gas Producers'
	and 1 = 2
	*/
END
GO
/****** Object:  StoredProcedure [BLD].[usp_CHECK_AND_REPORT_ON_OLD_DATA]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [BLD].[usp_CHECK_AND_REPORT_ON_OLD_DATA]
AS
BEGIN

	SET NOCOUNT ON
	-- SET DATEFORMAT DMY
	SET DATEFORMAT MDY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 
	-- EXEC [BLD].[usp_CHECK_AND_REPORT_ON_OLD_DATA]
	-- ==================================================================================================================================

	SELECT * 
	INTO #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD
	FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[FCT].[v_YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD]
	WHERE [ClosureDate] > DATEADD(YY, -1,  GETDATE())

	-- DROP TABLE #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD
	-- DROP TABLE #YAHOO_FINANCE_ALL_XLSM

	SELECT 'EQUITIES' AS FEEDTYPE, *
	INTO #YAHOO_FINANCE_ALL_XLSM
	FROM [STG].[v_YAHOO_FINANCE_EQUITIES] A

/*
	INSERT INTO #YAHOO_FINANCE_ALL_XLSM
	SELECT 'OEIC', *
	FROM [STG].[v_YAHOO_FINANCE_OEIC] A
*/

	INSERT INTO #YAHOO_FINANCE_ALL_XLSM
	SELECT 'FUTURES', *
	FROM [STG].[v_YAHOO_FINANCE_FUTURES] A

	INSERT INTO #YAHOO_FINANCE_ALL_XLSM
	SELECT 'INDICES', *
	FROM [STG].[v_YAHOO_FINANCE_INDICES] A

	INSERT INTO #YAHOO_FINANCE_ALL_XLSM
	SELECT 'CURRENCY', *
	FROM [STG].[v_YAHOO_FINANCE_USD_CURRENCY] A

	-- ================================================================================================================
	-- CREATE TEMP TABLE
	-- ================================================================================================================
	-- DROP TABLE #REASONS_FOR_OLD
	SELECT CONVERT(CHAR(50),'') AS [Reason], [B].[FEEDTYPE], [B].[LAST_TRADE_DATE] -- , [A].[MARKET_NAME]
	, [A].[SECTOR], [A].[Symbol]
	, [A].[ImportType], [A].[ClosureDate], [A].[DateLoaded], [A].[Currency], [B].[CURRENCY] AS XLSM_CURRENCY
	, [A].[INVESTMENT_TYPE_NAME], [A].[Name], [A].[Price], [A].[INVESTMENT_ID], [B].[Est_INVESTMENT_ID]
	INTO #REASONS_FOR_OLD
	FROM #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD A
	JOIN #YAHOO_FINANCE_ALL_XLSM B ON [A].[SYMBOL] = [B].[SYMBOL]
	WHERE 1 = 2

	-- ================================================================================================================
	-- EQ - CHANGE IN CURRENCY AND NEW CURRENCY IS NOT IN SCOPE
	-- ================================================================================================================
	INSERT INTO #REASONS_FOR_OLD -- DISTINCT needed as some INVESTMENTS in multiple markets eg FTSE100, FTSEALL
	SELECT DISTINCT 'LAST TRADE DATE over 2 week ago' + ':'
	+ CONVERT(CHAR(4),DATEPART([YEAR], [B].[LAST_TRADE_DATE]))
	+ CONVERT(CHAR(2),[B].[LAST_TRADE_DATE],101)
	+ ':' + [A].[INVESTMENT_TYPE_NAME] 
	, [B].[FEEDTYPE], [B].[LAST_TRADE_DATE] -- , [A].[MARKET_NAME]
	, [A].[SECTOR], [A].[Symbol]
	, [A].[ImportType], [A].[ClosureDate], [A].[DateLoaded], [A].[Currency], [B].[CURRENCY] AS XLSM_CURRENCY
	, [A].[INVESTMENT_TYPE_NAME], [A].[Name], [A].[Price], [A].[INVESTMENT_ID], [B].[Est_INVESTMENT_ID]
	FROM #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD A
	JOIN #YAHOO_FINANCE_ALL_XLSM B ON [A].[SYMBOL] = [B].[SYMBOL]
	WHERE [B].[LAST_TRADE_DATE] < DATEADD( DD, -14, GETDATE())
	AND [INVESTMENT_ID] NOT IN (SELECT [INVESTMENT_ID] FROM #REASONS_FOR_OLD)

	-- DROP TABLE #REASONS_FOR_OLD

	-- ================================================================================================================
	-- EQ - CHANGE IN CURRENCY AND NEW CURRENCY IS NOT IN SCOPE
	-- ================================================================================================================
	INSERT INTO #REASONS_FOR_OLD
	SELECT DISTINCT 'CURRENCY not in scope:'+[A].[INVESTMENT_TYPE_NAME], [B].[FEEDTYPE]
	, [B].[LAST_TRADE_DATE] -- , [A].[MARKET_NAME]
	, [A].[SECTOR], [A].[Symbol]
	, [A].[ImportType], [A].[ClosureDate], [A].[DateLoaded], [A].[Currency], [B].[CURRENCY] AS XLSM_CURRENCY
	, [A].[INVESTMENT_TYPE_NAME], [A].[Name], [A].[Price], [A].[INVESTMENT_ID], [B].[Est_INVESTMENT_ID]
	FROM #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD A
	JOIN #YAHOO_FINANCE_ALL_XLSM B ON [A].[SYMBOL] = [B].[SYMBOL]
	AND [A].[CURRENCY] <> ISNULL([B].[CURRENCY],'')
	AND LTRIM(RTRIM(ISNULL([B].[CURRENCY],''))) NOT IN ('', 'p', 'GBX', 'GBP')
	AND [INVESTMENT_ID] NOT IN (SELECT [INVESTMENT_ID] FROM #REASONS_FOR_OLD)

	-- ================================================================================================================
	-- EQ - What's left?
	-- ================================================================================================================
	INSERT INTO #REASONS_FOR_OLD
	SELECT DISTINCT 'What now?:'+[A].[INVESTMENT_TYPE_NAME], [B].[FEEDTYPE], [B].[LAST_TRADE_DATE] -- , [A].[MARKET_NAME]
	, [A].[SECTOR], [A].[Symbol]
	, [A].[ImportType], [A].[ClosureDate], [A].[DateLoaded], [A].[Currency], [B].[CURRENCY] AS XLSM_CURRENCY
	, [A].[INVESTMENT_TYPE_NAME], [A].[Name], [A].[Price], [A].[INVESTMENT_ID], [B].[Est_INVESTMENT_ID]
	FROM #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD A
	JOIN #YAHOO_FINANCE_ALL_XLSM B ON [A].[SYMBOL] = [B].[SYMBOL]
	AND [INVESTMENT_ID] NOT IN (SELECT [INVESTMENT_ID] FROM #REASONS_FOR_OLD)

	SELECT [Reason], [ImportType], COUNT(*) FROM #REASONS_FOR_OLD
	WHERE [ImportType] NOT IN ('0QTNTGRK', '06_YAHOO_HISTORY')
	-- AND [ClosureDate] > DATEADD(YY, -1,  GETDATE())
	AND [LAST_TRADE_DATE] > DATEADD(YY, -1,  GETDATE())
	GROUP BY [Reason], [ImportType]
	ORDER BY 1 DESC

/*
	SELECT COUNT(*) FROM #YAHOO_FINANCE_ALL_XLSM
	WHERE SYMBOL IN (SELECT SYMBOL FROM #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD)
*/
	-- SELECT COUNT(*) FROM #REASONS_FOR_OLD

	-- ================================================================================================================
	-- 
	-- ================================================================================================================
	/*
	SELECT [B].[LAST_TRADE_DATE], [A].[MARKET_NAME], [A].[SECTOR], [A].[Symbol], [A].[ImportType], [A].[ClosureDate]
    , [A].[DateLoaded], [A].[Currency], [A].[INVESTMENT_TYPE_NAME], [A].[Name], [A].[Price], [A].[INVESTMENT_ID]
	, [B].[Est_INVESTMENT_ID], [B].[CURRENCY]
	FROM #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD A
	LEFT JOIN #YAHOO_FINANCE_ALL_XLSM B
	ON [A].[SYMBOL] = [B].[SYMBOL]
	WHERE [A].[IMPORTTYPE] NOT LIKE '%EQT%'
	AND [A].[IMPORTTYPE] NOT IN ('07_TRUSTNET_ETF','0QTNTGRK','02_MANUAL_ENTRY')
	AND [A].[IMPORTTYPE] IN ('06_YAHOO_HISTORY')
	-- AND [A].[SYMBOL] NOT IN (SELECT [SYMBOL] FROM [STG].[v_YAHOO_FINANCE_EQUITIES])
	AND ISNULL([A].[CURRENCY],'') NOT IN ('USD','EUR','JPY')
	ORDER BY 1 DESC, [A].[DateLoaded] DESC, [A].[ClosureDate] DESC, [A].[IMPORTTYPE] DESC
	*/

	DROP TABLE #YAHOO_COMBINED_PRICES_MOST_RECENT_DATA_OVER_2_WEEKS_OLD
	DROP TABLE #YAHOO_FINANCE_ALL_XLSM
END


GO
/****** Object:  StoredProcedure [BLD].[usp_DELETE_FCT_YAHOO_COMBINED_PRICES_cursor]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BLD].[usp_DELETE_FCT_YAHOO_COMBINED_PRICES_cursor] (@BUILD_ID INT,  @vRE INT
, @SymbolsToProcess dbo.SymbolsToProcess READONLY, @ImportType VARCHAR(25), @REPORT_EVERY_X_ROWS INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- ==================================================================================================================================

	DECLARE @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @sqlCommand VARCHAR(2500),@PARENT_USP VARCHAR(250)
	DECLARE @REPORT_BATCH INT, @RETURN_VALUE int, @Symbol VARCHAR(50), @ClosureDate DATE, @i INT, @TOTAL_ROWS INT

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- 
	-- ==================================================================================================================================

	SET @I_MSG = 'DELETE [FCT].[YAHOO_COMBINED_PRICES] (cursor)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	SET @i = 0
	SET @TOTAL_ROWS = 0

	DECLARE db_cursor_investment CURSOR FOR  
	SELECT [tColumn01], [tDate] FROM @SymbolsToProcess

	OPEN db_cursor_investment   
	FETCH NEXT FROM db_cursor_investment INTO @Symbol, @ClosureDate

	WHILE @@FETCH_STATUS = 0   
	BEGIN
		IF @i <> 0 AND @i % @REPORT_EVERY_X_ROWS = 0	-- PRINT EVERY 750
		BEGIN
			SET @I_MSG = CONVERT(VARCHAR(5), @i) + ' rows checked in this batch (FCT). Rows deleted so far:' + CONVERT(VARCHAR(10), @TOTAL_ROWS)
			IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
			ELSE PRINT @I_MSG
		END
		SET @i = @i + 1

		EXEC @RETURN_VALUE = [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[usp_DELETE_FCT_YAHOO_COMBINED_PRICES]
		@BUILD_ID, @vRE, @SYMBOL, @ClosureDate, @ImportType, 0 -- DO NOT PRINT TO LOG (We already have message at the top)
		-- '03_YAHOO_LATEST'

		SET @TOTAL_ROWS = @TOTAL_ROWS + ISNULL(@RETURN_VALUE, 0)

		FETCH NEXT FROM db_cursor_investment INTO @Symbol, @ClosureDate

		/* @RETURN_VALUE WILL BE ROWCOUNT !!!
		IF @RETURN_VALUE <> 0
		BEGIN
			SET @I_MSG = 'DELETE [FCT].[YAHOO_COMBINED_PRICES]:'
			+@Symbol+':'+CONVERT(VARCHAR(10), @ClosureDate)
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
		*/
	END

	CLOSE db_cursor_investment   
	DEALLOCATE db_cursor_investment 

	SET @I_MSG = 'ROWS DELETED (FCT:Cursor) = ' + CONVERT(VARCHAR(5), @TOTAL_ROWS)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG
END




GO
/****** Object:  StoredProcedure [BLD].[usp_DELETE_STG_BROKERFORECAST_cursor]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BLD].[usp_DELETE_STG_BROKERFORECAST_cursor] (@BUILD_ID INT,  @vRE INT
, @CompanysToProcess dbo.SymbolsToProcess READONLY, @REPORT_EVERY_X_ROWS INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- ==================================================================================================================================

	DECLARE @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @sqlCommand VARCHAR(2500),@PARENT_USP VARCHAR(250)
	DECLARE @REPORT_BATCH INT, @RETURN_VALUE int, @Company VARCHAR(50), @StartDate DATE, @i INT, @TOTAL_ROWS INT

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- 
	-- ==================================================================================================================================

	SET @I_MSG = 'DELETE [STG].[BROKERFORECAST] (cursor)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	SET @i = 0
	SET @TOTAL_ROWS = 0

	DECLARE db_cursor_investment CURSOR FOR  
	SELECT [tColumn01], [tDate] FROM @CompanysToProcess

	OPEN db_cursor_investment   
	FETCH NEXT FROM db_cursor_investment INTO @Company, @StartDate

	WHILE @@FETCH_STATUS = 0   
	BEGIN

		IF @i <> 0 AND @i % @REPORT_EVERY_X_ROWS = 0	-- PRINT EVERY 750
		BEGIN
			SET @I_MSG = CONVERT(VARCHAR(5), @i) + ' rows checked in this batch (STG). Rows deleted so far:' + CONVERT(VARCHAR(10), @TOTAL_ROWS)
			IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
			ELSE PRINT @I_MSG
		END

		SET @i = @i + 1
		EXEC @RETURN_VALUE = [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[usp_DELETE_STG_BROKERFORECAST]
		@BUILD_ID, @vRE, @Company, @StartDate, 0 -- DO NOT PRINT TO LOG (We already have message at the top)

		SET @TOTAL_ROWS = @TOTAL_ROWS + ISNULL(@RETURN_VALUE, 0)

		FETCH NEXT FROM db_cursor_investment INTO @Company, @StartDate

		/* @RETURN_VALUE WILL BE ROWCOUNT !!!
		IF @RETURN_VALUE <> 0
		BEGIN
			SET @I_MSG = 'DELETE [STG].[BROKERFORECAST]:'
			+@Company+':'+CONVERT(VARCHAR(10), @StartDate)
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
		*/
	END

	CLOSE db_cursor_investment   
	DEALLOCATE db_cursor_investment 

	SET @I_MSG = 'ROWS DELETED (STG:Cursor) = ' + CONVERT(VARCHAR(5), @TOTAL_ROWS)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG
END




GO
/****** Object:  StoredProcedure [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT_cursor] (@BUILD_ID INT,  @vRE INT
, @SymbolsToProcess dbo.SymbolsToProcess READONLY, @REPORT_EVERY_X_ROWS INT) AS
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT DMY

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	December 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- ==================================================================================================================================

	DECLARE @v_ROWCOUNT INT, @DEBUG INT, @I_MSG VARCHAR(255), @sqlCommand VARCHAR(2500),@PARENT_USP VARCHAR(250)
	DECLARE @REPORT_BATCH INT, @RETURN_VALUE int, @Symbol VARCHAR(50), @ClosureDate DATE, @i INT, @TOTAL_ROWS INT

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	SET @DEBUG = (1)
		
	-- ==================================================================================================================================
	-- 
	-- ==================================================================================================================================

	SET @I_MSG = 'DELETE [STG].[YAHOO_ONE_DAY_EXPORT] (cursor)'
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	SET @i = 0
	SET @TOTAL_ROWS = 0

	DECLARE db_cursor_investment CURSOR FOR  
	SELECT [tColumn01], [tDate] FROM @SymbolsToProcess

	OPEN db_cursor_investment   
	FETCH NEXT FROM db_cursor_investment INTO @Symbol, @ClosureDate

	WHILE @@FETCH_STATUS = 0   
	BEGIN
		IF @i <> 0 AND @i % @REPORT_EVERY_X_ROWS = 0	-- PRINT EVERY 750
		BEGIN
			SET @I_MSG = CONVERT(VARCHAR(5), @i) + ' rows checked in this batch (STG). Rows deleted so far:' + CONVERT(VARCHAR(10), @TOTAL_ROWS)
			IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
			ELSE PRINT @I_MSG
		END
		SET @i = @i + 1

		EXEC @RETURN_VALUE = [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[usp_DELETE_STG_YAHOO_ONE_DAY_EXPORT]
		@BUILD_ID, @vRE, @SYMBOL, @ClosureDate, 0 -- DO NOT PRINT TO LOG (We already have message at the top)

		SET @TOTAL_ROWS = @TOTAL_ROWS + ISNULL(@RETURN_VALUE, 0)

		FETCH NEXT FROM db_cursor_investment INTO @Symbol, @ClosureDate

		/* @RETURN_VALUE WILL BE ROWCOUNT !!!
		IF @RETURN_VALUE <> 0
		BEGIN
			SET @I_MSG = 'DELETE [STG].[YAHOO_ONE_DAY_EXPORT]:'
			+@Symbol+':'+CONVERT(VARCHAR(10), @ClosureDate)
			EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
			-- RETURN (255)
		END
		*/
	END

	CLOSE db_cursor_investment   
	DEALLOCATE db_cursor_investment 

	SET @I_MSG = 'ROWS DELETED (STG:Cursor) = ' + CONVERT(VARCHAR(5), @TOTAL_ROWS)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG
END



GO
/****** Object:  StoredProcedure [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] (@BUILD_ID INT, @PARENT_USP VARCHAR(100), @PRE_HEADER VARCHAR(5)
, @HEADER VARCHAR(500), @vRE INT)
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- ==================================================================================================================================

BEGIN
	DECLARE @I_MSG VARCHAR(500)

	SELECT @I_MSG = @PRE_HEADER + ' ' + CONVERT(VARCHAR(25),GETDATE(), 121)+ ' ' + @HEADER
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[BLD].[LOAD_STATUS]
		([BUILD_ID], [ENTRY_DATETIME], [PARENT_USP], [ENTRY_NOTES])
		VALUES (@BUILD_ID, GETDATE() , @PARENT_USP, @PRE_HEADER + @HEADER)
		-- INSERT INTO [Alchemy_Build].[BLD].[LOAD_STATUS] ([BUILD_ID], [ENTRY_DATETIME], [ENTRY_NOTES]) 
		-- VALUES (@BUILD_ID, GETDATE() , @PRE_HEADER + CONVERT(VARCHAR(1),@vRE)+':'+@HEADER)
	END TRY
	BEGIN CATCH
-- 		EXEC [Alchemy_Build].[BLD].[usp_STANDARD_ERROR_HANDLING] @HEADER
 		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @HEADER
		RETURN (255)
	END CATCH

END

















GO
/****** Object:  StoredProcedure [BLD].[usp_sendSMTPEmail]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_sendSMTPEmail] 
	@SQLMailProfile varchar(255) = 'Email for RED7DP',  -- 'Red7 Profile', 
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
	-- ==================================================================================================================================

	BEGIN 

	SET NOCOUNT ON 

	--Test: EXEC <DB name>.[dbo].sendSMTPEmail @SQLMailProfile='Default', @SendTo='?', @CC='?', @BCC='?', @Subject='?', @Body='?', @Attachments='?', @SendAsHTML=?, @SendAsCritical=? 

	DECLARE @BodyFormat varchar(20) 
	DECLARE @Importance varchar(6) 
	
	--Populate required variables 
	IF LEN(RTRIM(ISNULL(@SQLMailProfile, ''))) = 0 SELECT @SQLMailProfile = 'Default' 
	SELECT @BodyFormat = CASE WHEN @SendAsHTML = (1) THEN 'HTML' ELSE 'TEXT' END 
	SELECT @Importance = CASE WHEN @SendAsCritical = (1) THEN 'High' ELSE 'Normal' END 

	BEGIN TRY
		INSERT INTO [AZURE_R7_ALCHEMY_DATA].[ALCHEMY_DATA].[BLD].[SQLMailLog]
		(SQLMailProfile, SendTo, CC, BCC, Subject, Body, Attachments, SendAsHTML, SendAsCritical) 
		VALUES (@SQLMailProfile, @SendTo, @CC, @BCC, @Subject, @Body, @Attachments, @SendAsHTML, @SendAsCritical)
	END TRY

	BEGIN CATCH
		DECLARE @I_MSG VARCHAR(500), @v_ROWCOUNT INT, @PARENT_USP VARCHAR(250), @RETVAL INT
		SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	
		SET @I_MSG= 'E: Error insert into [BLD].[SQLMailLog])'
		PRINT @I_MSG

		DECLARE @BUILD_ID INT
		SET @BUILD_ID = (SELECT MAX([BUILD_ID]) FROM [AZURE_R7_ALCHEMY_DATA].[ALCHEMY_DATA].[BLD].[v_MONITOR_BUILD_PROCESS])
		EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, @I_MSG, 'HEADER', 1
	END CATCH

	--Send the email
/*
	IF @@VERSION NOT LIKE '%Azure%'
	EXEC [msdB].[dbo].sp_send_dbmail 
		@profile_name=@SQLMailProfile, 
		@recipients=@SendTo, 
		@copy_recipients=@CC, 
		@blind_copy_recipients=@BCC, 
		@subject=@Subject, 
		@body=@Body, 
		@body_format=@BodyFormat, 
		@importance=@Importance, 
		@file_attachments=@Attachments; 
|*/
	Finish: 
	SET NOCOUNT OFF 

END 





































GO
/****** Object:  StoredProcedure [BLD].[usp_STANDARD_EMAIL]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BLD].[usp_STANDARD_EMAIL] (@i_subject VARCHAR(100), @i_body VARCHAR(2500))
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	March 2016
	-- Version History:
	-- 1.0		Initial Release
	-- 
	-- EXEC[BLD].[usp_STANDARD_EMAIL] 'Test subject', 'Hello'
	-- SELECT * FROM [BLD].[SQLMailLog]
	-- ==================================================================================================================================

BEGIN
	
	RAISERROR (@i_subject,10,1) 

	EXEC [Alchemy_Build].[BLD].[usp_sendSMTPEmail] @SQLMailProfile='Red7 Profile', @SendTo='eahind@yahoo.co.uk', @CC='', @BCC=''
	, @Subject=@i_subject, @Body=@i_body, @Attachments='', @SendAsHTML=0, @SendAsCritical=1

END





































GO
/****** Object:  StoredProcedure [BLD].[usp_STANDARD_ERROR_HANDLING]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BLD].[usp_STANDARD_ERROR_HANDLING] (@BUILD_ID INT, @header VARCHAR(250), @vRE INT NULL)
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- ==================================================================================================================================

BEGIN
	DECLARE @I_MSG VARCHAR(250), @PARENT_USP VARCHAR(250)

	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	IF @vRE = NULL SET @VRE = (1)

	DECLARE @ErrorNumber INT = ERROR_NUMBER()
	DECLARE @ErrorLine INT = ERROR_LINE()
	DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
	DECLARE @ErrorProcedure NVARCHAR(4000) = ERROR_PROCEDURE()
	DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
	DECLARE @ErrorState INT = ERROR_STATE()

	DECLARE @NEWLINE CHAR(2)
	SELECT @NEWLINE = CHAR(13) + CHAR(10)

	-- SELECT @I_MSG = 'E: ' + CONVERT(VARCHAR(25),GETDATE(), 121)+ ' ' + @header

	SELECT @I_MSG = CONVERT(VARCHAR(25),GETDATE(), 121)+ ' ' + @header
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG

	SELECT @I_MSG = @I_MSG + @NEWLINE + CONVERT(VARCHAR(25),GETDATE(), 121)+ ' No.: '  + ISNULL(CAST(@ErrorNumber AS VARCHAR(10)),'')
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG
	
	SELECT @I_MSG = @I_MSG + @NEWLINE + ' :Msg: ' + ISNULL(CAST(@ErrorMessage AS VARCHAR(500)),'')
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG

	SELECT @I_MSG = @I_MSG + @NEWLINE + ' :LineNo: '   + ISNULL(CAST(@ErrorLine AS VARCHAR(10)),'')
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG

	SELECT @I_MSG = @I_MSG + @NEWLINE + ' :Proc: ' + ISNULL(CAST(@ErrorProcedure AS VARCHAR(500)),'')
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG

	SELECT @I_MSG = @I_MSG + @NEWLINE + ' :Sev: ' + ISNULL(CAST(@ErrorSeverity AS VARCHAR(500)),'')
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG

	SELECT @I_MSG = @I_MSG + @NEWLINE + ' :State: ' + ISNULL(CAST(@ErrorState AS VARCHAR(500)),'')
	IF @vRE = (1) RAISERROR (@I_MSG,10,1) WITH NOWAIT ELSE PRINT @I_MSG

	SELECT @I_MSG = @I_MSG + @NEWLINE + ISNULL(CAST(@ErrorMessage AS VARCHAR(500)),'')
	exec [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'E:', @I_MSG, @vRE

	IF @BUILD_ID <> 0
	BEGIN TRY
		EXEC [Alchemy_Build].[BLD].[usp_sendSMTPEmail] @SQLMailProfile='Red7 Profile', @SendTo='eahind@yahoo.co.uk', @CC='', @BCC=''
		, @Subject=@I_msg, @Body='Red Seven Technologies Ltd. (c)', @Attachments='', @SendAsHTML=0, @SendAsCritical=1 -- was HTML=1
	-- RAISERROR (@I_msg, 10, 1) WITH NOWAIT
	END TRY
	BEGIN CATCH
		SET @I_MSG = 'Unable to [usp_sendSMTPEmail]'
		EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	END CATCH
END





GO
/****** Object:  StoredProcedure [BLD].[usp_UPDATE_STATS]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BLD].[usp_UPDATE_STATS]
AS

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	January 2016
	-- Version History:
	-- 1.0		Initial Release
	-- ==================================================================================================================================

	-- https://ol[A].hallengren.com/
	EXECUTE master.[dbo].[IndexOptimize] @Databases = 'USER_DATABASES',
	@FragmentationLow = NULL,
	@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
	@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
	@FragmentationLevel1 = 5,
	@FragmentationLevel2 = 30

	-- https://ol[A].hallengren.com/
	EXECUTE master.[dbo].[IndexOptimize] @Databases = 'USER_DATABASES',
	@FragmentationLow = NULL,
	@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
	@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
	@FragmentationLevel1 = 5,
	@FragmentationLevel2 = 30,
	@UpdateStatistics = 'ALL',
	@OnlyModifiedStatistics = 'Y'

	-- MSSQLTIPS 2734
	EXECUTE sp_createstats @INDEXONLY='NO', @fullscan = 'FULLSCAN', @norecompute = 'No'

	-- ANY WA statistics left?
	SELECT 'I: DROP STATISTICS '+[C].[name]+'.'+OBJECT_NAME(S.object_id)+'.'+S.[name] AS 'WA_SCHEMA_TO_DROP'
	FROM sys.stats S, sys.objects o, sys.schemas C
	WHERE S.object_ID = O.object_ID
	AND [C].schema_id = o.schema_id
	AND S.[NAME] LIKE '%WA%SYS%'
	AND OBJECT_NAME(S.object_id) NOT LIKE '%sys%'
	AND 1 = 2
	ORDER BY 1

	/* -- http://stackoverflow.com/questions/7956620/do-statistics-referencing-a-column-prevent-that-column-from-being-dropped
	DECLARE @sql NVARCHAR(MAX)

	DECLARE statCursor CURSOR FOR 
	SELECT 
    'DROP STATISTICS ' + QUOTENAME(SCHEMA_NAME(t.schema_id)) 
                        + '.' + QUOTENAME(t.[name]) 
                        + '.' + QUOTENAME(st.[name]) AS sql
	FROM
    sys.stats AS st 
    INNER JOIN sys.tables AS t
        ON st.object_id = t.object_id
	WHERE
    st.user_created = 1
	ORDER BY 1;

	OPEN statCursor;

	FETCH NEXT FROM statCursor INTO @sql
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
    PRINT @sql
    EXEC sp_executesql @sql
    FETCH NEXT FROM statCursor INTO @sql
	END  
	CLOSE statCursor  
	DEALLOCATE statCursor
*/

	-- ANY MISSING INDEXS THAT SHOULD BE PERMANENT
	SELECT 'I: DROP INDEX '+[C].[name]+'.'+OBJECT_NAME(S.object_id)+'.['+S.[name]+']' AS 'WA_SCHEMA_TO_DROP'
	FROM sys.indexes S, sys.objects o, sys.schemas C
	WHERE S.object_ID = O.object_ID
	AND [C].schema_id = o.schema_id
	AND S.[NAME] LIKE 'MISSING%'
	-- AND OBJECT_NAME(S.object_id) LIKE 'Missing_IX%'
	ORDER BY 1


	-- https://ol[A].hallengren.com/
	EXECUTE master.[dbo].[DatabaseIntegrityCheck]
	@Databases = 'USER_DATABASES',
	@CheckCommands = 'CHECKDB',
	@PhysicalOnly = 'N'






































GO
/****** Object:  StoredProcedure [CFG].[usp_add_LS_AZURE_R7_ALCHEMY_MI]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [CFG].[usp_add_LS_AZURE_R7_ALCHEMY_MI]
as
begin
	EXEC sp_dropserver 'AZURE_R7_ALCHEMY_MI', droplogins
	EXEC master.[dbo].sp_addlinkedserver @server = N'AZURE_R7_ALCHEMY_MI', @srvproduct=N'', @provider=N'SQLNCLI11', @datasrc=N'RED7-LENOVO-ATH\RED7_06_2016'
	EXEC master.[dbo].sp_addlinkedsrvlogin @rmtsrvname=N'AZURE_R7_ALCHEMY_MI',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL

	/*
	EXEC sp_addlinkedserver
	@server='AZURE_R7_ALCHEMY_MI',
	@srvproduct='',     
	@provider='sqlncli',
	@datasrc='red7dpalchemy.database.windows.net',
	@location='',
	@provstr='',
	@catalog='R7_ALCHEMY_MI'

	exec sp_addlinkedsrvlogin 'AZURE_R7_ALCHEMY_MI', 'FALSE', NULL, 'ALEX_ADMIN@red7dpalchemy', 'Pol1cezxc';
	*/
end































GO
/****** Object:  StoredProcedure [CFG].[usp_add_LS_AZURE_R7_ALCHEMY_SOURCE_DATA]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [CFG].[usp_add_LS_AZURE_R7_ALCHEMY_SOURCE_DATA]
as
begin

	EXEC sp_dropserver 'AZURE_R7_ALCHEMY_SOURCE_DATA', droplogins
	EXEC master.[dbo].sp_addlinkedserver @server = N'AZURE_R7_ALCHEMY_SOURCE_DATA', @srvproduct=N'', @provider=N'SQLNCLI11', @datasrc=N'RED7-LENOVO-ATH\RED7_06_2016'
	EXEC master.[dbo].sp_addlinkedsrvlogin @rmtsrvname=N'AZURE_R7_ALCHEMY_SOURCE_DATA',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL

/*
	EXEC sp_addlinkedserver
	@server='AZURE_R7_ALCHEMY_SOURCE_DATA',
	@srvproduct='',     
	@provider='sqlncli',
	@datasrc='red7dpalchemy.database.windows.net',
	@location='',
	@provstr='',
	@catalog='R7_ALCHEMY_SOURCE_DATA'

	exec sp_addlinkedsrvlogin 'AZURE_R7_ALCHEMY_SOURCE_DATA', 'FALSE', NULL, 'ALEX_ADMIN@red7dpalchemy', 'Pol1cezxc';
*/
end






























GO
/****** Object:  StoredProcedure [dbo].[usp_add_LS_LOCAL]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_add_LS_LOCAL]
as
begin
	EXEC master.[dbo].sp_addlinkedserver @server = N'LOCAL', @srvproduct=N'', @provider=N'SQLNCLI11', @datasrc=N'RED7-SURFACE-ED,1433'
	EXEC master.[dbo].sp_addlinkedsrvlogin @rmtsrvname=N'LOCAL',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
end



























GO
/****** Object:  StoredProcedure [DQ].[usp_SET_LARGE_CHANGEPCT_COMBINED_PRICES_FROM_TELEGRAPH_SECTOR]    Script Date: 03/03/2017 13:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [DQ].[usp_SET_LARGE_CHANGEPCT_COMBINED_PRICES_FROM_TELEGRAPH_SECTOR] (@BUILD_ID INT, @vRE INT)
AS
BEGIN
	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	August 2016
	-- Version History:
	-- 1.0
	--
	-- EXEC [DQ].[usp_SET_LARGE_CHANGEPCT_COMBINED_PRICES_FROM_TELEGRAPH_SECTOR] 0, 1
	-- ==================================================================================================================================

	SET DATEFORMAT DMY
	SET NOCOUNT ON
	
	DECLARE @I_MSG VARCHAR(255), @PARENT_USP VARCHAR(250), @v_ROWCOUNT INT,  @v_ERR INT
	SET @PARENT_USP = ISNULL(OBJECT_NAME(@@PROCID),'PROCID_UNKNOWN')
	
	-- ==========================================================================================================================================
	-- ANY BIG CHANGES IN PRICE?
	-- =================================================================================================================================================
	SET @I_MSG = 'CREATE #YAHOO_COMBINED_PRICES_WITH_LARGE_CHANGEPCT TABLE'
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY -- DROP TABLE #YAHOO_COMBINED_PRICES_WITH_LARGE_CHANGEPCT
		SELECT [SYMBOL] AS [EPIC], [INVESTMENT_ID] AS [t_INVESTMENT_ID], [PRICE] AS [YAHOO_PRICE]
		INTO #YAHOO_COMBINED_PRICES_WITH_LARGE_CHANGEPCT
		FROM [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[FCT].[YAHOO_COMBINED_PRICES]
		WHERE [ChangePct] > (75)
	END TRY

	BEGIN CATCH
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	-- =================================================================================================================================================
	-- ANY BIG CHANGES IN PRICE?
	-- ROWCOUNT USED AS ACROSS SITE TRANSACTION NOT OK
	-- =================================================================================================================================================
	SET @I_MSG = 'UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[FCT].[YAHOO_COMBINED_PRICES]'
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[FCT].[YAHOO_COMBINED_PRICES]
		SET [PRICE] = [PRICE] / (100)
		, [DAYS_LOW] = [DAYS_LOW] / (100)
		, [DAYS_HIGH] = [DAYS_HIGH] / (100)
		, [52wk_LOW] = [52wk_LOW] / (100)
		, [52wk_HIGH] = [52wk_HIGH] / (100)
		FROM #YAHOO_COMBINED_PRICES_WITH_LARGE_CHANGEPCT B --  #UPDATE_ME_DIV_100 B
		WHERE [INVESTMENT_ID] = [B].[t_INVESTMENT_ID] --,[SYMBOL] = [B].[EPIC]
		AND [PRICE] > (0.001)
		AND [B].[YAHOO_PRICE] / [PRICE] BETWEEN (50.0) AND (300.0) -- (150.0)
		
		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = '(DIV 100) ROWS UPDATED ([STG].[YAHOO_COMBINED_PRICES]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- =================================================================================================================================================
	-- ANY BIG CHANGES IN PRICE?
	-- ROWCOUNT USED AS ACROSS SITE TRANSACTION NOT OK
	-- =================================================================================================================================================
	SET @I_MSG = 'UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[FCT].[YAHOO_COMBINED_PRICES]'
	IF @BUILD_ID <> (0) EXEC [BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	BEGIN TRY
		UPDATE [AZURE_R7_ALCHEMY_DATA].[Alchemy_Data].[FCT].[YAHOO_COMBINED_PRICES]
		SET [PRICE] = [PRICE] / (10)
		, [DAYS_LOW] = [DAYS_LOW] / (10)
		, [DAYS_HIGH] = [DAYS_HIGH] / (10)
		, [52wk_LOW] = [52wk_LOW] / (10)
		, [52wk_HIGH] = [52wk_HIGH] / (10)
		FROM #YAHOO_COMBINED_PRICES_WITH_LARGE_CHANGEPCT B --  #UPDATE_ME_DIV_100 B
		WHERE [SYMBOL] = [B].[EPIC]
		AND [PRICE] > (0.001)
		AND [B].[YAHOO_PRICE] / [PRICE] BETWEEN (10.0) AND (30.0)

		SELECT @v_ERR = @@ERROR, @v_ROWCOUNT = @@rowcount
	END TRY

	BEGIN CATCH
		EXEC [BLD].[usp_STANDARD_ERROR_HANDLING] @BUILD_ID, @I_MSG, @vRE
		RETURN (255)
	END CATCH

	SET @I_MSG = '(DIV 10) ROWS UPDATED ([STG].[YAHOO_COMBINED_PRICES]) = '+CONVERT(VARCHAR(10),@v_ROWCOUNT)
	IF @BUILD_ID <> (0) EXEC [Alchemy_Build].[BLD].[usp_PRINT_MESSAGE_AND_ADD_TO_STATUS_LOG] @BUILD_ID, @PARENT_USP, 'I:', @I_MSG, @vRE
	ELSE PRINT @I_MSG

	-- =================================================================================================================================================
	-- TIDY UP
	-- =================================================================================================================================================
	DROP TABLE #YAHOO_COMBINED_PRICES_WITH_LARGE_CHANGEPCT
END
GO
USE [master]
GO
ALTER DATABASE [Alchemy_Build] SET  READ_WRITE 
GO
