USE [master]
GO
/****** Object:  Database [poquidex_pokemons]    Script Date: 4/10/2025 3:00:18 AM ******/
CREATE DATABASE [poquidex_pokemons]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'poquidex_pokemons', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\poquidex_pokemons.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'poquidex_pokemons_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\poquidex_pokemons_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [poquidex_pokemons] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [poquidex_pokemons].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [poquidex_pokemons] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET ARITHABORT OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [poquidex_pokemons] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [poquidex_pokemons] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET  ENABLE_BROKER 
GO
ALTER DATABASE [poquidex_pokemons] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [poquidex_pokemons] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET RECOVERY FULL 
GO
ALTER DATABASE [poquidex_pokemons] SET  MULTI_USER 
GO
ALTER DATABASE [poquidex_pokemons] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [poquidex_pokemons] SET DB_CHAINING OFF 
GO
ALTER DATABASE [poquidex_pokemons] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [poquidex_pokemons] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [poquidex_pokemons] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [poquidex_pokemons] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'poquidex_pokemons', N'ON'
GO
ALTER DATABASE [poquidex_pokemons] SET QUERY_STORE = ON
GO
ALTER DATABASE [poquidex_pokemons] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [poquidex_pokemons]
GO
/****** Object:  Table [dbo].[custom_pokemon]    Script Date: 4/10/2025 3:00:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[custom_pokemon](
	[user] [nvarchar](50) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[number] [int] NULL,
	[name] [nvarchar](50) NULL,
	[level] [int] NULL,
	[hp] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pokemon]    Script Date: 4/10/2025 3:00:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pokemon](
	[number] [int] NULL,
	[name] [nvarchar](50) NULL,
	[species] [nvarchar](50) NULL,
	[hp] [int] NULL,
	[type] [nvarchar](50) NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [poquidex_pokemons] SET  READ_WRITE 
GO
