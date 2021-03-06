USE [master]
GO
/****** Object:  Database [Alchemy_Reports]    Script Date: 03/03/2017 13:28:52 ******/
CREATE DATABASE [Alchemy_Reports]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Alchemy_Reports', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Reports.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Alchemy_Reports_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.RED7TECH_ALCHEMY\MSSQL\DATA\Alchemy_Reports_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Alchemy_Reports] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Alchemy_Reports].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Alchemy_Reports] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET ARITHABORT OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Alchemy_Reports] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Alchemy_Reports] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Alchemy_Reports] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Alchemy_Reports] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET RECOVERY FULL 
GO
ALTER DATABASE [Alchemy_Reports] SET  MULTI_USER 
GO
ALTER DATABASE [Alchemy_Reports] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Alchemy_Reports] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Alchemy_Reports] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Alchemy_Reports] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Alchemy_Reports] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Alchemy_Reports] SET QUERY_STORE = OFF
GO
USE [Alchemy_Reports]
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
USE [Alchemy_Reports]
GO
/****** Object:  User [sa_PowerBI]    Script Date: 03/03/2017 13:28:52 ******/
CREATE USER [sa_PowerBI] FOR LOGIN [sa_PowerBI] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa_PowerBI]
GO
/****** Object:  Schema [BLD]    Script Date: 03/03/2017 13:28:52 ******/
CREATE SCHEMA [BLD]
GO
/****** Object:  Schema [RPT]    Script Date: 03/03/2017 13:28:52 ******/
CREATE SCHEMA [RPT]
GO
/****** Object:  View [RPT].[v_usp_RISER_001_ETF_ALL_FUNDS]    Script Date: 03/03/2017 13:28:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [RPT].[v_usp_RISER_001_ETF_ALL_FUNDS]
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	August 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

 	SELECT *
	FROM OPENQUERY (LOCAL,
	'execute [Alchemy_Reports].[RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT] ''ALC (Exchange Traded Funds)'',''EQT''')

GO
/****** Object:  View [RPT].[v_usp_RISER_001_FTSE_ALL_FUNDS]    Script Date: 03/03/2017 13:28:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [RPT].[v_usp_RISER_001_FTSE_ALL_FUNDS]
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	August 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

 	SELECT *
	FROM OPENQUERY (LOCAL, 'execute [Alchemy_Reports].[RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT] ''%FTSE%'',''EQT''')


GO
/****** Object:  View [RPT].[v_usp_RISER_001_FUTURES_ALL_FUNDS]    Script Date: 03/03/2017 13:28:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [RPT].[v_usp_RISER_001_FUTURES_ALL_FUNDS]
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

 	SELECT *
	FROM OPENQUERY (LOCAL,
	'execute [Alchemy_Reports].[RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT] ''ALC (FUTURES)'',''EQT''')


GO
/****** Object:  View [RPT].[v_usp_RISER_001_IA_ALL_FUNDS]    Script Date: 03/03/2017 13:28:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [RPT].[v_usp_RISER_001_IA_ALL_FUNDS]
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	June 2016
	-- Version History:
	-- 1.0		Initial Release
	-- =====================================================================================================================

 	SELECT *
	FROM OPENQUERY (LOCAL, 'execute [Alchemy_Reports].[RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT] ''IA (Unit Trusts & OEICS)'',''FND''')

GO
/****** Object:  View [RPT].[v_usp_RISER_001_INDICES_ALL_FUNDS]    Script Date: 03/03/2017 13:28:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [RPT].[v_usp_RISER_001_INDICES_ALL_FUNDS]
AS

	-- =====================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	November 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- SELECT * FROM [RPT].[v_usp_RISER_001_INDICES_ALL_FUNDS]
	-- =====================================================================================================================

 	SELECT *
	FROM OPENQUERY (LOCAL,
	'execute [Alchemy_Reports].[RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT] ''ALC_INDICES'', ''EQT''')

GO
/****** Object:  StoredProcedure [RPT].[usp_RISER_001_1week_IA_ALL_FUNDS]    Script Date: 03/03/2017 13:28:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [RPT].[usp_RISER_001_1week_IA_ALL_FUNDS]
WITH RECOMPILE AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	June 2016
	-- Version History:
	-- 1.0		Initial Release
	-- ==================================================================================================================================

	DECLARE @SQLC NVARCHAR(2000)

 	SELECT @SQLC = 'SELECT 	* FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC  = @SQLC + '@MARKET = N''''IA (Unit Trusts & OEICS)'''',	'
	SELECT @SQLC  = @SQLC + '@SECTOR = N''''%'''',	@TIME_PERIOD = N''''01 week'''''')'

	EXEC sp_executesql @SQLC

		WITH RESULT SETS
	(
		(
			RiserID INT , [MARKET_NAME] VARCHAR(50), sector VARCHAR(50), [Symbol] VARCHAR(50)
			, [NAME] VARCHAR(50), ClosureDate DATE, Days_High FLOAT, Days_Low FLOAT , Price FLOAT, PRICE_OLD FLOAT
			, Yahoo_ChangePct_over_X_Day FLOAT, Yahoo_ChangePct_over_latest_Day FLOAT , [52wk_low] FLOAT, [52wk_high] FLOAT
			, Currency VARCHAR(50), FERiskScore VARCHAR(5)
		)
	)
END

GO
/****** Object:  StoredProcedure [RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT]    Script Date: 03/03/2017 13:28:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT] (@MARKET VARCHAR(250), @INVESTMENT_TYPE CHAR(3))
WITH RECOMPILE AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

	-- ==================================================================================================================================
	-- Owner:	Red Seven Technologies Ltd (c)
	-- Author:	Alex Hind
	-- Created:	June 2016
	-- Version History:
	-- 1.0		Initial Release
	--
	-- EXEC [RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT] '%FTSE%', 'EQT'
	-- EXEC [RPT].[usp_RISER_001_WITH_EIGHT_PERIOD_OUTPUT] 'IA (Unit Trusts & OEICS)', 'FND'
	-- ==================================================================================================================================

	DECLARE @SECTOR VARCHAR(100), @TOP_SECTOR VARCHAR(100), @SQLC NVARCHAR(2000)
	DECLARE @T1 TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_1_week] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T1_SECTOR_ONLY TABLE ([sector] VARCHAR(100))

	DECLARE @T1_3dy TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_3_days] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T1_1wk TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_1_week] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T1_2wk TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_2_weeks] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T1_1mn TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_1_month] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T1_3mn TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_3_months] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T1_6mn TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_6_months] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T1_9mn TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_9_months] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T1_1yr TABLE ([RiserID] INT, [MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_1_year] FLOAT, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	DECLARE @T2 TABLE ([sector] VARCHAR(100), vcount INT)
	DECLARE @T3 TABLE ([sector] VARCHAR(100), vcount INT)

	-- ==================================================================================================================================
	-- GET RISER REPORTS FOR EACH PERIOD
	-- ==================================================================================================================================

 	SELECT @SQLC = 'SELECT [RiserID], [MARKET_NAME], [sector], [Symbol], [NAME], [ClosureDate], [Days_High], [Days_Low], [Price]' 
	SELECT @SQLC = @SQLC + ', [PRICE_OLD], [Yahoo_ChangePct_over_X_Day], [Yahoo_ChangePct_over_latest_Day], [52wk_low]'
	SELECT @SQLC = @SQLC + ', [52wk_high], [Currency], [FERiskScore]'
	SELECT @SQLC = @SQLC + 'FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC = @SQLC + '@MARKET = N''''' + @MARKET + ''''',	'
	SELECT @SQLC = @SQLC + '@SECTOR = N''''%'''', @TIME_PERIOD = N''''03 days'''', @INVESTMENT_TYPE = N'''''
	+ @INVESTMENT_TYPE + ''''''')'
	PRINT @SQLC
	INSERT INTO @T1_3dy EXEC sp_executesql @SQLC

	-- IF 1 = 1 SELECT COUNT(*) FROM @T1_3dy

 	SELECT @SQLC = 'SELECT [RiserID], [MARKET_NAME], [sector], [Symbol], [NAME], [ClosureDate], [Days_High], [Days_Low], [Price]' 
	SELECT @SQLC = @SQLC + ', [PRICE_OLD], [Yahoo_ChangePct_over_X_Day], [Yahoo_ChangePct_over_latest_Day], [52wk_low]'
	SELECT @SQLC = @SQLC + ', [52wk_high], [Currency], [FERiskScore]'
	SELECT @SQLC = @SQLC + 'FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC = @SQLC + '@MARKET = N''''' + @MARKET + ''''',	'
	SELECT @SQLC = @SQLC + '@SECTOR = N''''%'''', @TIME_PERIOD = N''''01 week'''',  @INVESTMENT_TYPE = N'''''
	+ @INVESTMENT_TYPE + ''''''')'
	INSERT INTO @T1_1wk EXEC sp_executesql @SQLC
	
	-- IF 1 = 1 SELECT COUNT(*) FROM @T1_1wk

 	SELECT @SQLC = 'SELECT [RiserID], [MARKET_NAME], [sector], [Symbol], [NAME], [ClosureDate], [Days_High], [Days_Low], [Price]' 
	SELECT @SQLC = @SQLC + ', [PRICE_OLD], [Yahoo_ChangePct_over_X_Day], [Yahoo_ChangePct_over_latest_Day], [52wk_low]'
	SELECT @SQLC = @SQLC + ', [52wk_high], [Currency], [FERiskScore]'
	SELECT @SQLC = @SQLC + 'FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC = @SQLC + '@MARKET = N''''' + @MARKET + ''''',	'
	SELECT @SQLC = @SQLC + '@SECTOR = N''''%'''',	@TIME_PERIOD = N''''02 weeks'''',  @INVESTMENT_TYPE = N'''''
	+ @INVESTMENT_TYPE + ''''''')'
	INSERT INTO @T1_2wk EXEC sp_executesql @SQLC 

	-- IF 1 = 1 SELECT COUNT(*) FROM @T1_2wk

 	SELECT @SQLC = 'SELECT [RiserID], [MARKET_NAME], [sector], [Symbol], [NAME], [ClosureDate], [Days_High], [Days_Low], [Price]' 
	SELECT @SQLC = @SQLC + ', [PRICE_OLD], [Yahoo_ChangePct_over_X_Day], [Yahoo_ChangePct_over_latest_Day], [52wk_low]'
	SELECT @SQLC = @SQLC + ', [52wk_high], [Currency], [FERiskScore]'
	SELECT @SQLC = @SQLC + 'FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC = @SQLC + '@MARKET = N''''' + @MARKET + ''''',	' 
	SELECT @SQLC = @SQLC + '@SECTOR = N''''%'''',	@TIME_PERIOD = N''''01 month'''', @INVESTMENT_TYPE = N'''''
	+ @INVESTMENT_TYPE + ''''''')'
	INSERT INTO @T1_1mn EXEC sp_executesql @SQLC

	-- IF 1 = 1 SELECT COUNT(*) FROM @T1_1mn

 	SELECT @SQLC = 'SELECT [RiserID], [MARKET_NAME], [sector], [Symbol], [NAME], [ClosureDate], [Days_High], [Days_Low], [Price]' 
	SELECT @SQLC = @SQLC + ', [PRICE_OLD], [Yahoo_ChangePct_over_X_Day], [Yahoo_ChangePct_over_latest_Day], [52wk_low]'
	SELECT @SQLC = @SQLC + ', [52wk_high], [Currency], [FERiskScore]'
	SELECT @SQLC = @SQLC + 'FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC = @SQLC + '@MARKET = N''''' + @MARKET + ''''',	'
	SELECT @SQLC = @SQLC + '@SECTOR = N''''%'''',	@TIME_PERIOD = N''''03 months'''', @INVESTMENT_TYPE = N'''''
	+ @INVESTMENT_TYPE + ''''''')'
	INSERT INTO @T1_3mn EXEC sp_executesql @SQLC

	-- IF 1 = 1 SELECT COUNT(*) FROM @T1_3mn

 	SELECT @SQLC = 'SELECT [RiserID], [MARKET_NAME], [sector], [Symbol], [NAME], [ClosureDate], [Days_High], [Days_Low], [Price]' 
	SELECT @SQLC = @SQLC + ', [PRICE_OLD], [Yahoo_ChangePct_over_X_Day], [Yahoo_ChangePct_over_latest_Day], [52wk_low]'
	SELECT @SQLC = @SQLC + ', [52wk_high], [Currency], [FERiskScore]'
	SELECT @SQLC = @SQLC + 'FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC = @SQLC + '@MARKET = N''''' + @MARKET + ''''',	'
	SELECT @SQLC = @SQLC + '@SECTOR = N''''%'''',	@TIME_PERIOD = N''''06 months'''', @INVESTMENT_TYPE = N'''''
	+ @INVESTMENT_TYPE + ''''''')'
	INSERT INTO @T1_6mn EXEC sp_executesql @SQLC

	-- IF 1 = 1 SELECT COUNT(*) FROM @T1_6mn

 	SELECT @SQLC = 'SELECT [RiserID], [MARKET_NAME], [sector], [Symbol], [NAME], [ClosureDate], [Days_High], [Days_Low], [Price]' 
	SELECT @SQLC = @SQLC + ', [PRICE_OLD], [Yahoo_ChangePct_over_X_Day], [Yahoo_ChangePct_over_latest_Day], [52wk_low]'
	SELECT @SQLC = @SQLC + ', [52wk_high], [Currency], [FERiskScore]'
	SELECT @SQLC = @SQLC + 'FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC = @SQLC + '@MARKET = N''''' + @MARKET + ''''',	'
	SELECT @SQLC = @SQLC + '@SECTOR = N''''%'''',	@TIME_PERIOD = N''''09 months'''', @INVESTMENT_TYPE = N'''''
	+ @INVESTMENT_TYPE + ''''''')'
	INSERT INTO @T1_9mn EXEC sp_executesql @SQLC

	-- IF 1 = 1 SELECT COUNT(*) FROM @T1_9mn

 	SELECT @SQLC = 'SELECT [RiserID], [MARKET_NAME], [sector], [Symbol], [NAME], [ClosureDate], [Days_High], [Days_Low], [Price]' 
	SELECT @SQLC = @SQLC + ', [PRICE_OLD], [Yahoo_ChangePct_over_X_Day], [Yahoo_ChangePct_over_latest_Day], [52wk_low]'
	SELECT @SQLC = @SQLC + ', [52wk_high], [Currency], [FERiskScore]'
	SELECT @SQLC = @SQLC + 'FROM OPENQUERY (AZURE_R7_ALCHEMY_DATA,''execute [RPT].[usp_RISER_001] '
	SELECT @SQLC = @SQLC + '@MARKET = N''''' + @MARKET + ''''',	'
	SELECT @SQLC = @SQLC + '@SECTOR = N''''%'''',	@TIME_PERIOD = N''''12 months'''', @INVESTMENT_TYPE = N'''''
	+ @INVESTMENT_TYPE + ''''''')'
	INSERT INTO @T1_1yr EXEC sp_executesql @SQLC

	-- IF 1 = 1 SELECT COUNT(*) FROM @T1_1yr

	-- ==================================================================================================================================
	-- CREATE A TABLE TO LIST ALL FUNDS
	-- ==================================================================================================================================
	DECLARE @ALL_FUNDS TABLE ([MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5))

	-- ==================================================================================================================================
	-- GET A LIST OF ALL THE FUNDS .. there may be periods that have missing funds e.g. bad data
	-- ==================================================================================================================================

	INSERT INTO @ALL_FUNDS
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol], [A].[NAME], [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	FROM @T1_3dy A WHERE NOT EXISTS (SELECT 1 FROM @ALL_FUNDS B WHERE [A].SYMBOL = [B].Symbol)
	
	INSERT INTO @ALL_FUNDS
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol], [A].[NAME], [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	FROM @T1_1wk A WHERE NOT EXISTS (SELECT 1 FROM @ALL_FUNDS B WHERE [A].SYMBOL = [B].Symbol)
	
	INSERT INTO @ALL_FUNDS
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol], [A].[NAME], [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	FROM @T1_2wk A WHERE NOT EXISTS (SELECT 1 FROM @ALL_FUNDS B WHERE [A].SYMBOL = [B].Symbol)
	
	INSERT INTO @ALL_FUNDS
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol], [A].[NAME], [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	FROM @T1_1mn A WHERE NOT EXISTS (SELECT 1 FROM @ALL_FUNDS B WHERE [A].SYMBOL = [B].Symbol)
	
	INSERT INTO @ALL_FUNDS
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol], [A].[NAME], [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	FROM @T1_3mn A WHERE NOT EXISTS (SELECT 1 FROM @ALL_FUNDS B WHERE [A].SYMBOL = [B].Symbol)
	
	INSERT INTO @ALL_FUNDS
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol], [A].[NAME], [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	FROM @T1_6mn A WHERE NOT EXISTS (SELECT 1 FROM @ALL_FUNDS B WHERE [A].SYMBOL = [B].Symbol)
	
	INSERT INTO @ALL_FUNDS
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol], [A].[NAME], [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	FROM @T1_9mn A WHERE NOT EXISTS (SELECT 1 FROM @ALL_FUNDS B WHERE [A].SYMBOL = [B].Symbol)
	
	INSERT INTO @ALL_FUNDS
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol], [A].[NAME], [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	FROM @T1_1yr A WHERE NOT EXISTS (SELECT 1 FROM @ALL_FUNDS B WHERE [A].SYMBOL = [B].Symbol)

	-- ==================================================================================================================================
	-- ALTER FINAL REPORT TABLE
	-- ==================================================================================================================================
	DECLARE @FINAL_PREP TABLE 
	([MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5)
	, [ChangePct_over_3_days] FLOAT
	, [ChangePct_over_1_week] FLOAT
	, [ChangePct_over_2_weeks] FLOAT
	, [ChangePct_over_1_month] FLOAT
	, [ChangePct_over_3_months] FLOAT
	, [ChangePct_over_6_months] FLOAT
	, [ChangePct_over_9_months] FLOAT
	, [ChangePct_over_1_year] FLOAT)

	-- ==================================================================================================================================
	-- ALTER FINAL REPORT TABLE
	-- ==================================================================================================================================
	DECLARE @FINAL TABLE 
	([MARKET_NAME] VARCHAR(100), [sector] VARCHAR(100), [Symbol] VARCHAR(100)
	, [NAME] VARCHAR(200), [ClosureDate] DATE, [Days_High] FLOAT, [Days_Low] FLOAT, [Price] FLOAT, [PRICE_OLD] FLOAT
	, [ChangePct_over_latest_Day] FLOAT, [52wk_low] FLOAT, [52wk_high] FLOAT
	, [Currency] VARCHAR(10), [FERiskScore] VARCHAR(5)
	, [ChangePct_over_3_days] FLOAT
	, [ChangePct_over_1_week] FLOAT
	, [ChangePct_over_2_weeks] FLOAT
	, [ChangePct_over_1_month] FLOAT
	, [ChangePct_over_3_months] FLOAT
	, [ChangePct_over_6_months] FLOAT
	, [ChangePct_over_9_months] FLOAT
	, [ChangePct_over_1_year] FLOAT
	, [SUM_OF_SIGN_OF_CHANGES] INT)

	-- ==================================================================================================================================
	-- POPULATE FINAL PREP REPORT TABLE
	-- ==================================================================================================================================

	INSERT INTO @FINAL_PREP
	SELECT [A].[MARKET_NAME], [A].[sector], [A].[Symbol]
	, LEFT([A].[NAME], 45) AS [NAME]
	, [A].[ClosureDate], [A].[Days_High], [A].[Days_Low]
	, [A].[Price], [A].[PRICE_OLD], [A].[ChangePct_over_latest_Day], [A].[52wk_low], [A].[52wk_high], [A].[Currency], [A].[FERiskScore]
	, (SELECT MAX([ChangePct_over_3_days])   FROM @T1_3dy B WHERE [A].[Symbol] = [B].[Symbol]) AS [ChangePct_over_3_days]
	, (SELECT MAX([ChangePct_over_1_week])   FROM @T1_1wk B WHERE [A].[Symbol] = [B].[Symbol]) AS [ChangePct_over_1_week]
	, (SELECT MAX([ChangePct_over_2_weeks])  FROM @T1_2wk B WHERE [A].[Symbol] = [B].[Symbol]) AS [ChangePct_over_2_weeks]
	, (SELECT MAX([ChangePct_over_1_month])  FROM @T1_1mn C WHERE [A].[Symbol] = [C].[Symbol]) AS [ChangePct_over_1_month]
	, (SELECT MAX([ChangePct_over_3_months]) FROM @T1_3mn D WHERE [A].[Symbol] = [D].[Symbol]) AS [ChangePct_over_1_month]
	, (SELECT MAX([ChangePct_over_6_months]) FROM @T1_6mn E WHERE [A].[Symbol] = [E].[Symbol]) AS [ChangePct_over_6_months]
	, (SELECT MAX([ChangePct_over_9_months]) FROM @T1_9mn E WHERE [A].[Symbol] = [E].[Symbol]) AS [ChangePct_over_9_months]
	, (SELECT MAX([ChangePct_over_1_year])   FROM @T1_1yr F WHERE [A].[Symbol] = [F].[Symbol]) AS [ChangePct_over_1_year]
	FROM @ALL_FUNDS A
	ORDER BY [A].[NAME]

	-- ==================================================================================================================================
	-- BUILD FINAL REPORT (ADD SUM_OF_SIGN_OF_CHANGES)
	-- ==================================================================================================================================
	INSERT INTO @FINAL
	SELECT *
	, SIGN(ISNULL([ChangePct_over_3_days],0))   + SIGN(ISNULL([ChangePct_over_1_week],0))  + SIGN(ISNULL([ChangePct_over_2_weeks],0))
	+ SIGN(ISNULL([ChangePct_over_1_month],0))  + SIGN(ISNULL([ChangePct_over_1_month],0)) + SIGN(ISNULL([ChangePct_over_6_months],0))
	+ SIGN(ISNULL([ChangePct_over_9_months],0)) + SIGN(ISNULL([ChangePct_over_1_year],0))
	AS [SUM_OF_SIGN_OF_CHANGES]
	FROM @FINAL_PREP

	-- ==================================================================================================================================
	-- RUN FINAL REPORT
	-- ==================================================================================================================================
	SELECT ROW_NUMBER() OVER (ORDER BY [SUM_OF_SIGN_OF_CHANGES] DESC, [ChangePct_over_3_days] DESC) AS RiserID
	, *
	FROM @FINAL
END

GO
USE [master]
GO
ALTER DATABASE [Alchemy_Reports] SET  READ_WRITE 
GO
