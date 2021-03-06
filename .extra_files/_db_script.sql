USE [master]
GO
/****** Object:  Database [BorsaDB]    Script Date: 13.07.2022 11:35:09 ******/
CREATE DATABASE [BorsaDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BorsaDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\BorsaDB.mdf' , SIZE = 25856KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BorsaDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\BorsaDB_1.LDF' , SIZE = 11456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BorsaDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BorsaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BorsaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BorsaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BorsaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BorsaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BorsaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BorsaDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BorsaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BorsaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BorsaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BorsaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BorsaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BorsaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BorsaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BorsaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BorsaDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BorsaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BorsaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BorsaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BorsaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BorsaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BorsaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BorsaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BorsaDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BorsaDB] SET  MULTI_USER 
GO
ALTER DATABASE [BorsaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BorsaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BorsaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BorsaDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BorsaDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BorsaDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BorsaDB', N'ON'
GO
ALTER DATABASE [BorsaDB] SET QUERY_STORE = OFF
GO
USE [BorsaDB]
GO
/****** Object:  DatabaseRole [aspnet_WebEvent_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_WebEvent_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Roles_ReportingAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Roles_ReportingAccess]
GO
/****** Object:  DatabaseRole [aspnet_Roles_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Roles_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Roles_BasicAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Roles_BasicAccess]
GO
/****** Object:  DatabaseRole [aspnet_Profile_ReportingAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Profile_ReportingAccess]
GO
/****** Object:  DatabaseRole [aspnet_Profile_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Profile_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Profile_BasicAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Profile_BasicAccess]
GO
/****** Object:  DatabaseRole [aspnet_Personalization_ReportingAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Personalization_ReportingAccess]
GO
/****** Object:  DatabaseRole [aspnet_Personalization_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Personalization_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Personalization_BasicAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Personalization_BasicAccess]
GO
/****** Object:  DatabaseRole [aspnet_Membership_ReportingAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Membership_ReportingAccess]
GO
/****** Object:  DatabaseRole [aspnet_Membership_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Membership_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Membership_BasicAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE ROLE [aspnet_Membership_BasicAccess]
GO
ALTER ROLE [aspnet_Roles_BasicAccess] ADD MEMBER [aspnet_Roles_FullAccess]
GO
ALTER ROLE [aspnet_Roles_ReportingAccess] ADD MEMBER [aspnet_Roles_FullAccess]
GO
ALTER ROLE [aspnet_Profile_BasicAccess] ADD MEMBER [aspnet_Profile_FullAccess]
GO
ALTER ROLE [aspnet_Profile_ReportingAccess] ADD MEMBER [aspnet_Profile_FullAccess]
GO
ALTER ROLE [aspnet_Personalization_BasicAccess] ADD MEMBER [aspnet_Personalization_FullAccess]
GO
ALTER ROLE [aspnet_Personalization_ReportingAccess] ADD MEMBER [aspnet_Personalization_FullAccess]
GO
ALTER ROLE [aspnet_Membership_BasicAccess] ADD MEMBER [aspnet_Membership_FullAccess]
GO
ALTER ROLE [aspnet_Membership_ReportingAccess] ADD MEMBER [aspnet_Membership_FullAccess]
GO
/****** Object:  Schema [aspnet_Membership_BasicAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Membership_BasicAccess]
GO
/****** Object:  Schema [aspnet_Membership_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Membership_FullAccess]
GO
/****** Object:  Schema [aspnet_Membership_ReportingAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Membership_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Personalization_BasicAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Personalization_BasicAccess]
GO
/****** Object:  Schema [aspnet_Personalization_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Personalization_FullAccess]
GO
/****** Object:  Schema [aspnet_Personalization_ReportingAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Personalization_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Profile_BasicAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Profile_BasicAccess]
GO
/****** Object:  Schema [aspnet_Profile_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Profile_FullAccess]
GO
/****** Object:  Schema [aspnet_Profile_ReportingAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Profile_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Roles_BasicAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Roles_BasicAccess]
GO
/****** Object:  Schema [aspnet_Roles_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Roles_FullAccess]
GO
/****** Object:  Schema [aspnet_Roles_ReportingAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_Roles_ReportingAccess]
GO
/****** Object:  Schema [aspnet_WebEvent_FullAccess]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [aspnet_WebEvent_FullAccess]
GO
/****** Object:  Schema [MERKEZ_BORSA]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [MERKEZ_BORSA]
GO
/****** Object:  Schema [PROGRAM]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [PROGRAM]
GO
/****** Object:  Schema [SALON_SATIS]    Script Date: 13.07.2022 11:35:09 ******/
CREATE SCHEMA [SALON_SATIS]
GO
/****** Object:  Table [dbo].[aspnet_Applications]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Applications](
	[ApplicationName] [nvarchar](256) NOT NULL,
	[LoweredApplicationName] [nvarchar](256) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Applications_Index]    Script Date: 13.07.2022 11:35:09 ******/
CREATE CLUSTERED INDEX [aspnet_Applications_Index] ON [dbo].[aspnet_Applications]
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_Applications]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_Applications]
  AS SELECT [dbo].[aspnet_Applications].[ApplicationName], [dbo].[aspnet_Applications].[LoweredApplicationName], [dbo].[aspnet_Applications].[ApplicationId], [dbo].[aspnet_Applications].[Description]
  FROM [dbo].[aspnet_Applications]
  
GO
/****** Object:  Table [dbo].[aspnet_Users]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[LoweredUserName] [nvarchar](256) NOT NULL,
	[MobileAlias] [nvarchar](16) NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Users_Index]    Script Date: 13.07.2022 11:35:09 ******/
CREATE UNIQUE CLUSTERED INDEX [aspnet_Users_Index] ON [dbo].[aspnet_Users]
(
	[ApplicationId] ASC,
	[LoweredUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_Users]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_Users]
  AS SELECT [dbo].[aspnet_Users].[ApplicationId], [dbo].[aspnet_Users].[UserId], [dbo].[aspnet_Users].[UserName], [dbo].[aspnet_Users].[LoweredUserName], [dbo].[aspnet_Users].[MobileAlias], [dbo].[aspnet_Users].[IsAnonymous], [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Users]
  
GO
/****** Object:  Table [dbo].[aspnet_Membership]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Membership](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[MobilePIN] [nvarchar](16) NULL,
	[Email] [nvarchar](256) NULL,
	[LoweredEmail] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NOT NULL,
	[Comment] [ntext] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Membership_index]    Script Date: 13.07.2022 11:35:09 ******/
CREATE CLUSTERED INDEX [aspnet_Membership_index] ON [dbo].[aspnet_Membership]
(
	[ApplicationId] ASC,
	[LoweredEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_MembershipUsers]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_MembershipUsers]
  AS SELECT [dbo].[aspnet_Membership].[UserId],
            [dbo].[aspnet_Membership].[PasswordFormat],
            [dbo].[aspnet_Membership].[MobilePIN],
            [dbo].[aspnet_Membership].[Email],
            [dbo].[aspnet_Membership].[LoweredEmail],
            [dbo].[aspnet_Membership].[PasswordQuestion],
            [dbo].[aspnet_Membership].[PasswordAnswer],
            [dbo].[aspnet_Membership].[IsApproved],
            [dbo].[aspnet_Membership].[IsLockedOut],
            [dbo].[aspnet_Membership].[CreateDate],
            [dbo].[aspnet_Membership].[LastLoginDate],
            [dbo].[aspnet_Membership].[LastPasswordChangedDate],
            [dbo].[aspnet_Membership].[LastLockoutDate],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptWindowStart],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptWindowStart],
            [dbo].[aspnet_Membership].[Comment],
            [dbo].[aspnet_Users].[ApplicationId],
            [dbo].[aspnet_Users].[UserName],
            [dbo].[aspnet_Users].[MobileAlias],
            [dbo].[aspnet_Users].[IsAnonymous],
            [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Membership] INNER JOIN [dbo].[aspnet_Users]
      ON [dbo].[aspnet_Membership].[UserId] = [dbo].[aspnet_Users].[UserId]
  
GO
/****** Object:  Table [dbo].[aspnet_Profile]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Profile](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [ntext] NOT NULL,
	[PropertyValuesString] [ntext] NOT NULL,
	[PropertyValuesBinary] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_Profiles]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_Profiles]
  AS SELECT [dbo].[aspnet_Profile].[UserId], [dbo].[aspnet_Profile].[LastUpdatedDate],
      [DataSize]=  DATALENGTH([dbo].[aspnet_Profile].[PropertyNames])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesString])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesBinary])
  FROM [dbo].[aspnet_Profile]
  
GO
/****** Object:  Table [dbo].[aspnet_Roles]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Roles](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[LoweredRoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Roles_index1]    Script Date: 13.07.2022 11:35:09 ******/
CREATE UNIQUE CLUSTERED INDEX [aspnet_Roles_index1] ON [dbo].[aspnet_Roles]
(
	[ApplicationId] ASC,
	[LoweredRoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_Roles]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_Roles]
  AS SELECT [dbo].[aspnet_Roles].[ApplicationId], [dbo].[aspnet_Roles].[RoleId], [dbo].[aspnet_Roles].[RoleName], [dbo].[aspnet_Roles].[LoweredRoleName], [dbo].[aspnet_Roles].[Description]
  FROM [dbo].[aspnet_Roles]
  
GO
/****** Object:  Table [dbo].[aspnet_UsersInRoles]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_UsersInRoles]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
  AS SELECT [dbo].[aspnet_UsersInRoles].[UserId], [dbo].[aspnet_UsersInRoles].[RoleId]
  FROM [dbo].[aspnet_UsersInRoles]
  
GO
/****** Object:  Table [dbo].[aspnet_Paths]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Paths](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NOT NULL,
	[Path] [nvarchar](256) NOT NULL,
	[LoweredPath] [nvarchar](256) NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Paths_index]    Script Date: 13.07.2022 11:35:09 ******/
CREATE UNIQUE CLUSTERED INDEX [aspnet_Paths_index] ON [dbo].[aspnet_Paths]
(
	[ApplicationId] ASC,
	[LoweredPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_Paths]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
  AS SELECT [dbo].[aspnet_Paths].[ApplicationId], [dbo].[aspnet_Paths].[PathId], [dbo].[aspnet_Paths].[Path], [dbo].[aspnet_Paths].[LoweredPath]
  FROM [dbo].[aspnet_Paths]
  
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationAllUsers]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers](
	[PathId] [uniqueidentifier] NOT NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_Shared]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Shared]
  AS SELECT [dbo].[aspnet_PersonalizationAllUsers].[PathId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationAllUsers].[PageSettings]), [dbo].[aspnet_PersonalizationAllUsers].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationAllUsers]
  
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationPerUser]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser](
	[Id] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [aspnet_PersonalizationPerUser_index1]    Script Date: 13.07.2022 11:35:09 ******/
CREATE UNIQUE CLUSTERED INDEX [aspnet_PersonalizationPerUser_index1] ON [dbo].[aspnet_PersonalizationPerUser]
(
	[PathId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_User]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

  CREATE VIEW [dbo].[vw_aspnet_WebPartState_User]
  AS SELECT [dbo].[aspnet_PersonalizationPerUser].[PathId], [dbo].[aspnet_PersonalizationPerUser].[UserId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationPerUser].[PageSettings]), [dbo].[aspnet_PersonalizationPerUser].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationPerUser]
  
GO
/****** Object:  Table [dbo].[aspnet_SchemaVersions]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_SchemaVersions](
	[Feature] [nvarchar](128) NOT NULL,
	[CompatibleSchemaVersion] [nvarchar](128) NOT NULL,
	[IsCurrentVersion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Feature] ASC,
	[CompatibleSchemaVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_WebEvent_Events]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_WebEvent_Events](
	[EventId] [char](32) NOT NULL,
	[EventTimeUtc] [datetime] NOT NULL,
	[EventTime] [datetime] NOT NULL,
	[EventType] [nvarchar](256) NOT NULL,
	[EventSequence] [decimal](19, 0) NOT NULL,
	[EventOccurrence] [decimal](19, 0) NOT NULL,
	[EventCode] [int] NOT NULL,
	[EventDetailCode] [int] NOT NULL,
	[Message] [nvarchar](1024) NULL,
	[ApplicationPath] [nvarchar](256) NULL,
	[ApplicationVirtualPath] [nvarchar](256) NULL,
	[MachineName] [nvarchar](256) NOT NULL,
	[RequestUrl] [nvarchar](1024) NULL,
	[ExceptionType] [nvarchar](256) NULL,
	[Details] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[AIDAT_TAKIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[AIDAT_TAKIP](
	[AidatTakipKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[DereceKey] [int] NULL,
	[Yil] [smallint] NULL,
	[AidatMiktar] [decimal](18, 2) NULL,
	[Taksit1OdemeTarihi] [date] NULL,
	[Taksit1OdemeMiktar] [decimal](18, 2) NULL,
	[Taksit1OdemeAciklama] [varchar](50) NULL,
	[Taksit2OdemeTarihi] [date] NULL,
	[Taksit2OdemeMiktar] [decimal](18, 2) NULL,
	[Taksit2OdemeAciklama] [varchar](50) NULL,
	[Taksit1CezaTarihi] [date] NULL,
	[Taksit1CezaMiktar] [decimal](18, 2) NULL,
	[Taksit1CezaAciklama] [varchar](50) NULL,
	[Taksit2CezaTarihi] [date] NULL,
	[Taksit2CezaMiktar] [decimal](18, 2) NULL,
	[Taksit2CezaAciklama] [varchar](50) NULL,
	[TahakkukTarihi] [date] NULL,
	[TahakkukMahsupNo] [char](4) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_AIDAT?TAKIP] PRIMARY KEY CLUSTERED 
(
	[AidatTakipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[BANKA_MEVDUAT]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[BANKA_MEVDUAT](
	[BankaMevduatKey] [int] IDENTITY(1,1) NOT NULL,
	[BankaHesapNo] [varchar](50) NOT NULL,
	[BankaAdi] [varchar](50) NOT NULL,
	[VadeliYatanMeblag] [decimal](16, 2) NOT NULL,
	[VadeBasi] [date] NOT NULL,
	[VadeSonu] [date] NOT NULL,
	[FaizYuzdesi] [float] NOT NULL,
	[StopajYuzdesi] [float] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_BANKA_MEVDUAT] PRIMARY KEY CLUSTERED 
(
	[BankaMevduatKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[BEYAN]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[BEYAN](
	[BeyanKey] [int] IDENTITY(1,1) NOT NULL,
	[BeyanTarihi] [date] NULL,
	[BorsaSubeKey] [int] NULL,
	[BeyanNo] [char](6) NULL,
	[BeyanSatirNo] [char](2) NULL,
	[AlisSatisTipKey] [tinyint] NOT NULL,
	[BeyanTipKey] [tinyint] NULL,
	[MustahsilNo] [char](10) NULL,
	[SaticiAd] [varchar](50) NULL,
	[SaticiAdres] [varchar](100) NULL,
	[BeyanMiktar] [decimal](15, 3) NULL,
	[SimsariyeMiktar] [decimal](16, 2) NULL,
	[TescilMiktar] [decimal](16, 2) NULL,
	[Stopaj] [decimal](16, 2) NULL,
	[FonPayiBagkur] [decimal](16, 2) NULL,
	[MeraFonu] [decimal](16, 2) NULL,
	[BirimFiyat] [decimal](12, 4) NULL,
	[BirimTipKey] [tinyint] NULL,
	[Mensei] [varchar](50) NULL,
	[UretimYili] [smallint] NULL,
	[OzelSartTanimlama] [varchar](50) NULL,
	[TeslimMahalli] [varchar](50) NULL,
	[TeslimTarihi] [date] NULL,
	[BeyanFaturaNo] [char](6) NULL,
	[BeyanFaturaTarihi] [date] NULL,
	[TuccarSicilKey] [int] NULL,
	[MaddeKodKey] [int] NULL,
	[BeyanKayitTipKey] [tinyint] NULL,
	[CanliHayvanAdet] [smallint] NULL,
	[SatisSekliKey] [int] NULL,
	[BeyannameKarsiFirmaTuccarSicilKey] [int] NULL,
	[KarsiVergiDairesiAdi] [varchar](50) NULL,
	[KarsiVergiNo] [varchar](11) NULL,
	[KarsiUnvan] [varchar](50) NULL,
	[KarsiAdres] [varchar](100) NULL,
	[BeyanSatisTutari] [decimal](16, 2) NULL,
	[DovizAdi] [char](2) NULL,
	[DovizKuru] [decimal](11, 6) NULL,
	[DovizTutari] [decimal](16, 2) NULL,
	[FisTarihiFisNoFisSatiri] [char](16) NULL,
	[StopajVarmi] [bit] NULL,
	[BulunduguYer] [varchar](50) NULL,
	[BeyanTastik] [decimal](16, 2) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_BEYAN] PRIMARY KEY CLUSTERED 
(
	[BeyanKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[DERECE_DEGISIKLIK]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[DERECE_DEGISIKLIK](
	[DereceDegisiklikKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[DereceVerilisYil] [smallint] NULL,
	[DereceKey] [int] NULL,
	[YKKTarih] [date] NULL,
	[YKKNo] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_DereceDegisiklik] PRIMARY KEY CLUSTERED 
(
	[DereceDegisiklikKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_ADRES]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_ADRES](
	[FirmaAdresKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NOT NULL,
	[FirmaAdres] [varchar](500) NOT NULL,
	[FirmaAdresTipKey] [tinyint] NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TUCCAR_ADRES] PRIMARY KEY CLUSTERED 
(
	[FirmaAdresKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_DIGER_FAALIYET_KOD]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_DIGER_FAALIYET_KOD](
	[FirmaDigerFaaliyetKodKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NOT NULL,
	[NaceKodu1] [varchar](20) NOT NULL,
	[NaceKodu2] [varchar](50) NOT NULL,
	[BaslangicTarihi] [date] NULL,
	[Aciklama] [varchar](500) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_FIRMA_DIGER_FAALIYET_KOD] PRIMARY KEY CLUSTERED 
(
	[FirmaDigerFaaliyetKodKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_FAALIYET]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_FAALIYET](
	[FirmaFaaliyetKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[MaddeKodKey] [int] NULL,
	[Uretim] [bit] NULL,
	[Bayi] [bit] NULL,
	[Alim] [bit] NULL,
	[Satim] [bit] NULL,
	[Ithalat] [bit] NULL,
	[Ihracat] [bit] NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_FirmaFaaliyet] PRIMARY KEY CLUSTERED 
(
	[FirmaFaaliyetKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_KAYITLI_ODA]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_KAYITLI_ODA](
	[FirmaKayitliOdaKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NOT NULL,
	[OdaBorsaAdi] [varchar](50) NOT NULL,
	[OdaBorsaKayitTarihi] [date] NULL,
	[OdaBorsaSicilNo] [varchar](20) NULL,
	[Aciklama] [varchar](500) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_FIRMA_KAYITLI_ODA] PRIMARY KEY CLUSTERED 
(
	[FirmaKayitliOdaKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_SAHIS]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_SAHIS](
	[FirmaSahisKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[Soyad] [varchar](50) NULL,
	[Ad] [varchar](50) NULL,
	[BabaAdi] [varchar](50) NULL,
	[DogumYeri] [varchar](50) NULL,
	[DogumTarihi] [date] NULL,
	[Uyruk] [varchar](50) NULL,
	[OgrenimDurumTipKey] [tinyint] NULL,
	[Adres] [varchar](100) NULL,
	[Tel] [varchar](50) NULL,
	[TcKimlikNo] [char](11) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_GercekFirmaSahisBilgi] PRIMARY KEY CLUSTERED 
(
	[FirmaSahisKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_TELEFON_FAX]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_TELEFON_FAX](
	[FirmaTelefonFaxKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[FirmaTelefonFax] [varchar](20) NOT NULL,
	[FirmaTelefonFaxTipKey] [tinyint] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TUCCAR_TELEFON_FAX] PRIMARY KEY CLUSTERED 
(
	[FirmaTelefonFaxKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_UYARI]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_UYARI](
	[FirmaUyariKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NOT NULL,
	[FirmaUyari] [varchar](500) NOT NULL,
	[FirmaUyariTarih] [date] NULL,
	[Aktif] [bit] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_FIRMA_UYARI] PRIMARY KEY CLUSTERED 
(
	[FirmaUyariKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_YETKILI]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_YETKILI](
	[FirmaYetkiliKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[AdSoyad] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_FirmaYetkilisi] PRIMARY KEY CLUSTERED 
(
	[FirmaYetkiliKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIRMA_YONETIM]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIRMA_YONETIM](
	[FirmaYonetimKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[AdSoyad] [varchar](50) NULL,
	[Unvan] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_FirmaYonetimi] PRIMARY KEY CLUSTERED 
(
	[FirmaYonetimKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[FIS_NO]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[FIS_NO](
	[FisNoKey] [int] IDENTITY(1,1) NOT NULL,
	[Yil] [smallint] NOT NULL,
	[MuhasebeTipKey] [int] NOT NULL,
	[FisTipKey] [tinyint] NOT NULL,
	[OcakNo] [int] NOT NULL,
	[SubatNo] [int] NOT NULL,
	[MartNo] [int] NOT NULL,
	[NisanNo] [int] NOT NULL,
	[MayisNo] [int] NOT NULL,
	[HaziranNo] [int] NOT NULL,
	[TemmuzNo] [int] NOT NULL,
	[AgustosNo] [int] NOT NULL,
	[EylulNo] [int] NOT NULL,
	[EkimNo] [int] NOT NULL,
	[KasimNo] [int] NOT NULL,
	[AralikNo] [int] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_FIS_NO] PRIMARY KEY CLUSTERED 
(
	[FisNoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[GELEN_GIDEN_EVRAK]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[GELEN_GIDEN_EVRAK](
	[GelenGidenEvrakKey] [int] IDENTITY(1,1) NOT NULL,
	[DosyaGrupKey] [int] NOT NULL,
	[KayitTarihi] [date] NULL,
	[EvrakSiraNo] [int] NULL,
	[AdSoyad] [varchar](50) NULL,
	[Adres] [varchar](150) NULL,
	[IlIlceKey] [int] NULL,
	[EvrakTarihi] [date] NULL,
	[EvrakNo] [varchar](50) NULL,
	[YaziOzeti] [varchar](150) NULL,
	[EvrakTipKey] [tinyint] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_GELEN_GIDEN_EVRAK] PRIMARY KEY CLUSTERED 
(
	[GelenGidenEvrakKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[HESAP_PLANI]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[HESAP_PLANI](
	[HesapPlaniKey] [int] IDENTITY(1,1) NOT NULL,
	[MuhasebeTipKey] [int] NOT NULL,
	[Yil] [smallint] NULL,
	[HesapKodu] [varchar](50) NOT NULL,
	[HesapAdi] [varchar](50) NOT NULL,
	[BorcOcak] [decimal](14, 2) NOT NULL,
	[BorcSubat] [decimal](14, 2) NOT NULL,
	[BorcMart] [decimal](14, 2) NOT NULL,
	[BorcNisan] [decimal](14, 2) NOT NULL,
	[BorcMayis] [decimal](14, 2) NOT NULL,
	[BorcHaziran] [decimal](14, 2) NOT NULL,
	[BorcTemmuz] [decimal](14, 2) NOT NULL,
	[BorcAgustos] [decimal](14, 2) NOT NULL,
	[BorcEylul] [decimal](14, 2) NOT NULL,
	[BorcEkim] [decimal](14, 2) NOT NULL,
	[BorcKasim] [decimal](14, 2) NOT NULL,
	[BorcAralik] [decimal](14, 2) NOT NULL,
	[Borc1_] [decimal](14, 2) NOT NULL,
	[Borc2_] [decimal](14, 2) NOT NULL,
	[AlacakOcak] [decimal](14, 2) NOT NULL,
	[AlacakSubat] [decimal](14, 2) NOT NULL,
	[AlacakMart] [decimal](14, 2) NOT NULL,
	[AlacakNisan] [decimal](14, 2) NOT NULL,
	[AlacakMayis] [decimal](14, 2) NOT NULL,
	[AlacakHaziran] [decimal](14, 2) NOT NULL,
	[AlacakTemmuz] [decimal](14, 2) NOT NULL,
	[AlacakAgustos] [decimal](14, 2) NOT NULL,
	[AlacakEylul] [decimal](14, 2) NOT NULL,
	[AlacakEkim] [decimal](14, 2) NOT NULL,
	[AlacakKasim] [decimal](14, 2) NOT NULL,
	[AlacakAralik] [decimal](14, 2) NOT NULL,
	[Alacak1_] [decimal](14, 2) NOT NULL,
	[Alacak2_] [decimal](14, 2) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_HESAP_PLANI] PRIMARY KEY CLUSTERED 
(
	[HesapPlaniKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[KAYIT_TAKIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[KAYIT_TAKIP](
	[KayitTakipKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[DereceKey] [int] NULL,
	[AidatMiktar] [decimal](13, 2) NULL,
	[OdemeTarihi] [date] NULL,
	[OdemeMiktar] [decimal](13, 2) NULL,
	[Aciklama] [varchar](50) NULL,
	[VadeTarihi] [date] NULL,
	[CezaTarihi] [date] NULL,
	[CezaMiktar] [decimal](13, 2) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_KayitTakip] PRIMARY KEY CLUSTERED 
(
	[KayitTakipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[MESLEK_GRUP_DEGISIKLIK]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[MESLEK_GRUP_DEGISIKLIK](
	[MeslekGrupDegisiklikKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NOT NULL,
	[MeslekGrupKey] [int] NOT NULL,
	[Yil] [smallint] NULL,
	[YKKTarih] [date] NULL,
	[YKKNo] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_MESLEK_GRUP_DEGISIKLIK] PRIMARY KEY CLUSTERED 
(
	[MeslekGrupDegisiklikKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[REHBER]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[REHBER](
	[RehberKey] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [varchar](50) NOT NULL,
	[Soyadi] [varchar](50) NOT NULL,
	[Tel1] [varchar](50) NULL,
	[Tel2] [varchar](50) NULL,
	[Tel3] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Aciklama] [varchar](100) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_REHBER] PRIMARY KEY CLUSTERED 
(
	[RehberKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[SERMAYE_DEGISIKLIK]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[SERMAYE_DEGISIKLIK](
	[SermayeDegisiklikKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NOT NULL,
	[Sermaye] [decimal](18, 4) NOT NULL,
	[Yil] [smallint] NULL,
	[YKKTarih] [date] NULL,
	[YKKNo] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_SERMAYE_DEGISIKLIK] PRIMARY KEY CLUSTERED 
(
	[SermayeDegisiklikKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TASDIK_FASIL_AKTARMA_ACIKLAMA]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TASDIK_FASIL_AKTARMA_ACIKLAMA](
	[TasdikFasilAktarmaAciklamaKey] [int] IDENTITY(1,1) NOT NULL,
	[TasdikFasilAktarmaTipKey] [tinyint] NOT NULL,
	[Aciklama] [varchar](max) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TASDIK_FASIL_AKTARMA_ACIKLAMA] PRIMARY KEY CLUSTERED 
(
	[TasdikFasilAktarmaAciklamaKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TESCIL_ORAN]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TESCIL_ORAN](
	[TescilOranKey] [int] IDENTITY(1,1) NOT NULL,
	[TescilOrani] [decimal](10, 4) NULL,
	[SimsarOrani] [decimal](10, 4) NULL,
	[Stopaj] [decimal](10, 4) NULL,
	[FonPayi] [decimal](10, 4) NULL,
	[MeraFonu] [decimal](10, 4) NULL,
	[Tavan] [decimal](10, 4) NULL,
	[TahsilatTipKey] [tinyint] NULL,
	[MuhasebeTipKey] [int] NULL,
	[Satis] [decimal](10, 4) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TESCIL_ORAN] PRIMARY KEY CLUSTERED 
(
	[TescilOranKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP](
	[AlisSatisTipKey] [tinyint] NOT NULL,
	[Kod] [char](1) NULL,
	[AlisSatisTipAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_ALIS_SATIS_TIP] PRIMARY KEY CLUSTERED 
(
	[AlisSatisTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_BEYAN_KAYIT_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_BEYAN_KAYIT_TIP](
	[BeyanKayitTipKey] [tinyint] NOT NULL,
	[Kod] [char](1) NOT NULL,
	[BeyanKayitTipAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_BEYAN_KAYIT_TIP] PRIMARY KEY CLUSTERED 
(
	[BeyanKayitTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_BEYAN_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_BEYAN_TIP](
	[BeyanTipKey] [tinyint] NOT NULL,
	[BeyanTipAdi] [varchar](50) NOT NULL,
	[Aciklama] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_BEYAN_TIP] PRIMARY KEY CLUSTERED 
(
	[BeyanTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_BIRIM_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_BIRIM_TIP](
	[BirimTipKey] [tinyint] IDENTITY(1,1) NOT NULL,
	[Kod] [char](2) NOT NULL,
	[BirimTipAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_BIRIM_TIP] PRIMARY KEY CLUSTERED 
(
	[BirimTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_BORSA_SUBE]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_BORSA_SUBE](
	[BorsaSubeKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](2) NOT NULL,
	[BorsaSubeAdi] [varchar](50) NOT NULL,
	[BorsaSubeSimsariyeKodu] [char](5) NULL,
	[BorsaSubeTesciliyeKodu] [char](5) NULL,
	[BorsaSubeMeraFonuKodu] [char](5) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_BORSA_SUBE] PRIMARY KEY CLUSTERED 
(
	[BorsaSubeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_DERECE]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_DERECE](
	[DereceKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](3) NULL,
	[Kaydiye] [decimal](13, 2) NULL,
	[Aidat] [decimal](13, 2) NULL,
	[MuhasebeKodu] [varchar](5) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_TuccarDerece] PRIMARY KEY CLUSTERED 
(
	[DereceKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_DERECE_CEZA_ORAN]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_DERECE_CEZA_ORAN](
	[DereceCezaOranKey] [int] IDENTITY(1,1) NOT NULL,
	[Yil] [smallint] NULL,
	[Ay1] [decimal](5, 4) NULL,
	[Ay2] [decimal](5, 4) NULL,
	[Ay3] [decimal](5, 4) NULL,
	[Ay4] [decimal](5, 4) NULL,
	[Ay5] [decimal](5, 4) NULL,
	[Ay6] [decimal](5, 4) NULL,
	[Ay7] [decimal](5, 4) NULL,
	[Ay8] [decimal](5, 4) NULL,
	[Ay9] [decimal](5, 4) NULL,
	[Ay10] [decimal](5, 4) NULL,
	[Ay11] [decimal](5, 4) NULL,
	[Ay12] [decimal](5, 4) NULL,
	[Taksit1] [tinyint] NULL,
	[Taksit2] [tinyint] NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_DereceCezaOran] PRIMARY KEY CLUSTERED 
(
	[DereceCezaOranKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_DOSYA_GRUP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_DOSYA_GRUP](
	[DosyaGrupKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](3) NOT NULL,
	[DosyaGrupAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_DOSYA_GRUP] PRIMARY KEY CLUSTERED 
(
	[DosyaGrupKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_EVRAK_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_EVRAK_TIP](
	[EvrakTipKey] [tinyint] NOT NULL,
	[EvrakTipAdi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TT_EVRAK_TIP] PRIMARY KEY CLUSTERED 
(
	[EvrakTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_FIRMA_ADRES_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_FIRMA_ADRES_TIP](
	[FirmaAdresTipKey] [tinyint] NOT NULL,
	[FirmaAdresTipAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_TUCCAR_ADRES_TIP] PRIMARY KEY CLUSTERED 
(
	[FirmaAdresTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_FIRMA_TELEFON_FAX_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_FIRMA_TELEFON_FAX_TIP](
	[FirmaTelefonFaxTipKey] [tinyint] NOT NULL,
	[FirmaTelefonFaxTipAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_TUCCAR_TELEFON_FAX_TIP] PRIMARY KEY CLUSTERED 
(
	[FirmaTelefonFaxTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_FIS_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_FIS_TIP](
	[FisTipKey] [tinyint] NOT NULL,
	[FisTipAdi] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_FIS_TIP] PRIMARY KEY CLUSTERED 
(
	[FisTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_HESAP_PLANI_DOKUM_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_HESAP_PLANI_DOKUM_TIP](
	[HesapPlaniDokumTipKey] [tinyint] NOT NULL,
	[HesapPlaniDokumTipAdi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TT_HESAP_PLANI_DOKUM_TIP] PRIMARY KEY CLUSTERED 
(
	[HesapPlaniDokumTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_IL_ILCE]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_IL_ILCE](
	[IlIlceKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](4) NULL,
	[IlIlceAdi] [varchar](50) NULL,
	[TobbKodu] [char](5) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_IlIlce] PRIMARY KEY CLUSTERED 
(
	[IlIlceKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_KONSOLIDE_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_KONSOLIDE_TIP](
	[KonsolideTipKey] [tinyint] NOT NULL,
	[KonsolideTipAdi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TT_KONSOLIDE_TIP] PRIMARY KEY CLUSTERED 
(
	[KonsolideTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_KURULUS_TUR]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_KURULUS_TUR](
	[KurulusTurKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](3) NULL,
	[Adi] [varchar](50) NULL,
	[TobbKodu] [char](2) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_KurulusTur] PRIMARY KEY CLUSTERED 
(
	[KurulusTurKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_MADDE_KOD]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_MADDE_KOD](
	[MaddeKodKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [varchar](10) NULL,
	[Adi] [varchar](50) NULL,
	[Stopaj] [bit] NULL,
	[MeraFonu] [bit] NULL,
	[MaddeKoduFonu] [bit] NULL,
	[Fire] [decimal](2, 0) NULL,
	[BirimKg] [decimal](10, 3) NULL,
	[LabGrubu] [decimal](2, 0) NULL,
	[TmoGrubu] [decimal](2, 0) NULL,
	[StopajYuzdesi] [decimal](4, 1) NULL,
	[TobbKodu] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_MaddeKodu] PRIMARY KEY CLUSTERED 
(
	[MaddeKodKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_MESLEK_GRUP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_MESLEK_GRUP](
	[MeslekGrupKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](4) NULL,
	[MeslekAdi] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_MeslekGrup] PRIMARY KEY CLUSTERED 
(
	[MeslekGrupKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_MUHASEBE_ADI]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_MUHASEBE_ADI](
	[MuhasebeAdiKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](2) NULL,
	[Adi] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_MUHASEBE_ADI] PRIMARY KEY CLUSTERED 
(
	[MuhasebeAdiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_MUHASEBE_DURUM_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_MUHASEBE_DURUM_TIP](
	[MuhasebeDurumTipKey] [tinyint] NOT NULL,
	[MuhasebeDurumTipAdi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TT_MUHASEBE_DURUM] PRIMARY KEY CLUSTERED 
(
	[MuhasebeDurumTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_MUHASEBE_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_MUHASEBE_TIP](
	[MuhasebeTipKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](2) NOT NULL,
	[Adi] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_MUHASEBE_TIP] PRIMARY KEY CLUSTERED 
(
	[MuhasebeTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_OGRENIM_DURUM_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_OGRENIM_DURUM_TIP](
	[OgrenimDurumTipKey] [tinyint] NOT NULL,
	[OgrenimDurumTipAdi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OGRENIM_DURUM_TIP] PRIMARY KEY CLUSTERED 
(
	[OgrenimDurumTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_SATIS_SEKLI]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI](
	[SatisSekliKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](3) NULL,
	[SatisSekliAdi] [varchar](50) NOT NULL,
	[SatisSekliUzunAdi] [varchar](50) NOT NULL,
	[SatanKey] [tinyint] NOT NULL,
	[AlanKey] [tinyint] NOT NULL,
	[StopajKey] [tinyint] NOT NULL,
	[TescilKey] [tinyint] NOT NULL,
	[SimsarKey] [tinyint] NOT NULL,
	[TipKey] [tinyint] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_SATIS_SEKLI] PRIMARY KEY CLUSTERED 
(
	[SatisSekliKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_SICIL_MEMURLUGU]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_SICIL_MEMURLUGU](
	[SicilMemurluguKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](3) NULL,
	[Adi] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_TicaretSicilMemurlugu] PRIMARY KEY CLUSTERED 
(
	[SicilMemurluguKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_TAHSILAT_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_TAHSILAT_TIP](
	[TahsilatTipKey] [tinyint] NOT NULL,
	[TahsilatTipAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_TAHSILAT_TIP] PRIMARY KEY CLUSTERED 
(
	[TahsilatTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_TASDIK_FASIL_AKTARMA_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_TASDIK_FASIL_AKTARMA_TIP](
	[TasdikFasilAktarmaTipKey] [tinyint] NOT NULL,
	[TasdikFasilAktarmaTipAdi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TT_TASDIK_FASIL_AKTARMA_TIP] PRIMARY KEY CLUSTERED 
(
	[TasdikFasilAktarmaTipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_VERGI_DAIRE]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_VERGI_DAIRE](
	[VergiDaireKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](4) NULL,
	[VergiDairesiAdi] [varchar](50) NULL,
	[TobbNo] [char](5) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_VergiDaire] PRIMARY KEY CLUSTERED 
(
	[VergiDaireKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TT_YAZISMA_ADRES]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TT_YAZISMA_ADRES](
	[YazismaAdresKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](5) NOT NULL,
	[YazismaAdresAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_YAZISMA_ADRES] PRIMARY KEY CLUSTERED 
(
	[YazismaAdresKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TUCCAR_ASKI]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TUCCAR_ASKI](
	[TuccarAskiKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[AskiTarihi] [date] NULL,
	[AskiKararNo] [varchar](50) NULL,
	[AskiAciklama] [varchar](50) NULL,
	[BitisTarihi] [date] NULL,
	[BitisKararNo] [varchar](50) NULL,
	[BitisAciklama] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TuccarAski] PRIMARY KEY CLUSTERED 
(
	[TuccarAskiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TUCCAR_DEPO]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TUCCAR_DEPO](
	[TuccarDepoKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[MaddeKodKey] [int] NULL,
	[Devir1] [decimal](12, 3) NULL,
	[Alis1] [decimal](12, 3) NULL,
	[Satis1] [decimal](12, 3) NULL,
	[DigerBorsaAlis1] [decimal](12, 3) NULL,
	[DigerBorsaSatis1] [decimal](12, 3) NULL,
	[Devir2] [decimal](12, 3) NULL,
	[Alis2] [decimal](12, 3) NULL,
	[Satis2] [decimal](12, 3) NULL,
	[DigerBorsaAlis2] [decimal](12, 3) NULL,
	[DigerBorsaSatis2] [decimal](12, 3) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TuccarDepo] PRIMARY KEY CLUSTERED 
(
	[TuccarDepoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TUCCAR_KEFALET_TEMINAT]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TUCCAR_KEFALET_TEMINAT](
	[TuccarKefaletTeminatKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarKey] [int] NOT NULL,
	[KefilKey] [int] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TUCCAR_KEFALET_TEMINAT] PRIMARY KEY CLUSTERED 
(
	[TuccarKefaletTeminatKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TUCCAR_SICIL]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TUCCAR_SICIL](
	[TuccarSicilKey] [int] IDENTITY(1,1) NOT NULL,
	[SicilNo] [varchar](6) NULL,
	[Unvan] [varchar](2500) NULL,
	[MeslekGrupKey] [int] NULL,
	[DereceKey] [int] NULL,
	[DereceYil] [smallint] NULL,
	[MersisNo] [varchar](50) NULL,
	[MerkezSubeMi] [bit] NOT NULL,
	[KayitTescilMi] [bit] NOT NULL,
	[BolgeAdi] [varchar](50) NULL,
	[IsciSayisi] [varchar](10) NULL,
	[EpostaAdresi] [varchar](50) NULL,
	[WebAdresi] [varchar](50) NULL,
	[ResenKayitMi] [bit] NOT NULL,
	[NaceKodu1] [varchar](20) NULL,
	[NaceKodu2] [varchar](50) NULL,
	[KurulusTurKey] [int] NULL,
	[SicilMemurluguKey] [int] NULL,
	[SicilTarih] [date] NULL,
	[SicilKayitNo] [varchar](50) NULL,
	[IlIlceKey] [int] NULL,
	[KayitTarihi] [date] NULL,
	[YKKTarihi] [date] NULL,
	[YKKNo] [varchar](50) NULL,
	[TerkinTarihi] [date] NULL,
	[TerkinYKKNo] [varchar](50) NULL,
	[Sermaye] [decimal](18, 4) NULL,
	[VergiDaireKey] [int] NULL,
	[VergiNo] [char](11) NULL,
	[TCKimlikNo] [char](11) NULL,
	[VergiNoEski] [char](10) NULL,
	[Aciklama] [varchar](1000) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TuccarSicilBilgi] PRIMARY KEY CLUSTERED 
(
	[TuccarSicilKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[TUCCAR_TAHSIL]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[TUCCAR_TAHSIL](
	[TuccarTahsilKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NULL,
	[TahsilTarihi] [date] NULL,
	[TahsilNo] [varchar](50) NULL,
	[Miktar] [decimal](13, 2) NULL,
	[VergiDaireKey] [int] NULL,
	[Ay] [tinyint] NULL,
	[Aciklama] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TUCCAR_TAHSIL] PRIMARY KEY CLUSTERED 
(
	[TuccarTahsilKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[UNVAN_DEGISIKLIK]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[UNVAN_DEGISIKLIK](
	[UnvanDegisiklikKey] [int] IDENTITY(1,1) NOT NULL,
	[TuccarSicilKey] [int] NOT NULL,
	[Unvan] [varchar](2500) NOT NULL,
	[Yil] [smallint] NULL,
	[YKKTarih] [date] NULL,
	[YKKNo] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_UNVAN_DEGISIKLIK] PRIMARY KEY CLUSTERED 
(
	[UnvanDegisiklikKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MERKEZ_BORSA].[YEVMIYE]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MERKEZ_BORSA].[YEVMIYE](
	[YevmiyeKey] [int] IDENTITY(1,1) NOT NULL,
	[MuhasebeTipKey] [int] NOT NULL,
	[HesapPlaniKey] [int] NOT NULL,
	[FisTipKey] [tinyint] NOT NULL,
	[FisTarih] [date] NOT NULL,
	[FisNo] [char](4) NOT NULL,
	[SatirNo] [char](4) NOT NULL,
	[Aciklama] [varchar](100) NULL,
	[Borc] [decimal](16, 2) NOT NULL,
	[Alacak] [decimal](16, 2) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_YEVMIYE] PRIMARY KEY CLUSTERED 
(
	[YevmiyeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PROGRAM].[BORSA_BILGI]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PROGRAM].[BORSA_BILGI](
	[ProgramBorsaBilgiKey] [int] IDENTITY(1,1) NOT NULL,
	[ProgramLogo] [image] NULL,
	[ProgramBaslik] [varchar](50) NOT NULL,
	[BorsaAdi] [varchar](50) NOT NULL,
	[TOBBKodu] [varchar](50) NOT NULL,
	[TOBBKurumTipi] [tinyint] NOT NULL,
	[KurulusTarihi] [date] NOT NULL,
	[IsyeriSicilNo] [varchar](50) NOT NULL,
	[GenelSekreter] [varchar](50) NOT NULL,
	[YonetimKuruluBaskani] [varchar](50) NOT NULL,
	[MeclisBaskani] [varchar](50) NOT NULL,
	[BorsaAdresi] [varchar](100) NOT NULL,
	[MuracaatMercii] [varchar](50) NOT NULL,
	[Telefon1] [varchar](20) NOT NULL,
	[Telefon2] [varchar](20) NULL,
	[Fax1] [varchar](20) NOT NULL,
	[Fax2] [varchar](20) NULL,
	[Email] [varchar](20) NOT NULL,
	[UyeTeminatTipiKey] [tinyint] NOT NULL,
	[GecTescil] [bit] NOT NULL,
	[TesekkulNo] [varchar](10) NOT NULL,
	[TasTesNo] [varchar](10) NOT NULL,
	[GecTescilBeyan30Gun] [bit] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_PROGRAM_BORSA_BILGI] PRIMARY KEY CLUSTERED 
(
	[ProgramBorsaBilgiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [PROGRAM].[DUYURU]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PROGRAM].[DUYURU](
	[ProgramDuyuruKey] [int] IDENTITY(1,1) NOT NULL,
	[ProgramDuyuruTarih] [date] NOT NULL,
	[ProgramDuyuru] [varchar](250) NOT NULL,
	[ProgramDuyuruAktif] [bit] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_PROGRAM_DUYURU] PRIMARY KEY CLUSTERED 
(
	[ProgramDuyuruKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PROGRAM].[LOG]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PROGRAM].[LOG](
	[LogKey] [int] IDENTITY(1,1) NOT NULL,
	[Tarih] [datetime] NULL,
	[Message] [varchar](max) NULL,
	[Source] [varchar](max) NULL,
	[StackTrace] [varchar](max) NULL,
	[ExceptionType] [varchar](max) NULL,
	[UserId] [uniqueidentifier] NULL,
	[Url] [varchar](max) NULL,
 CONSTRAINT [PK_LOG] PRIMARY KEY CLUSTERED 
(
	[LogKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [PROGRAM].[SALON_SATIS_AYAR]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PROGRAM].[SALON_SATIS_AYAR](
	[SalonSatisAyarKey] [int] IDENTITY(1,1) NOT NULL,
	[DusmeMiktari] [decimal](5, 3) NOT NULL,
	[ArtmaMiktari] [decimal](5, 3) NOT NULL,
	[SayacSuresi] [int] NOT NULL,
	[GeriSayacSuresi] [int] NOT NULL,
 CONSTRAINT [PK_SALON_SATIS_AYAR] PRIMARY KEY CLUSTERED 
(
	[SalonSatisAyarKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PROGRAM].[TT_UYE_TEMINAT_TIP]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PROGRAM].[TT_UYE_TEMINAT_TIP](
	[UyeTeminatTipiKey] [tinyint] NOT NULL,
	[UyeTeminatTipAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_UYE_TEMINAT_TIP] PRIMARY KEY CLUSTERED 
(
	[UyeTeminatTipiKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[SATIS]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[SATIS](
	[SatisKey] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[UrunKey] [int] NOT NULL,
	[Tarih] [date] NULL,
	[BaslangicZaman] [time](7) NULL,
	[BitisZaman] [time](7) NULL,
	[BaslangicFiyati] [decimal](18, 3) NOT NULL,
	[BitisFiyati] [decimal](18, 3) NULL,
	[AktifMi] [bit] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_SATIS] PRIMARY KEY CLUSTERED 
(
	[SatisKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[TEKLIF]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[TEKLIF](
	[TeklifKey] [int] IDENTITY(1,1) NOT NULL,
	[SatisKey] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[TarihSaat] [datetime] NULL,
	[AktifMi] [bit] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TEKLIF] PRIMARY KEY CLUSTERED 
(
	[TeklifKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[TESCIL]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[TESCIL](
	[TescilKey] [int] IDENTITY(1,1) NOT NULL,
	[TescilParametreKey] [int] NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TESCIL] PRIMARY KEY CLUSTERED 
(
	[TescilKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[TESCIL_KIMLIK]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[TESCIL_KIMLIK](
	[TescilKimlikKey] [int] IDENTITY(1,1) NOT NULL,
	[KimlikNo] [char](11) NOT NULL,
	[AdSoyad] [varchar](50) NOT NULL,
	[Adres] [varchar](100) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TESCIL_KIMLIK] PRIMARY KEY CLUSTERED 
(
	[TescilKimlikKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[TT_MADDE_KOD]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[TT_MADDE_KOD](
	[MaddeKodKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [varchar](10) NULL,
	[Adi] [varchar](50) NULL,
	[Stopaj] [bit] NULL,
	[MeraFonu] [bit] NULL,
	[MaddeKoduFonu] [bit] NULL,
	[Fire] [decimal](2, 0) NULL,
	[BirimKg] [decimal](10, 3) NULL,
	[LabGrubu] [decimal](2, 0) NULL,
	[TmoGrubu] [decimal](2, 0) NULL,
	[StopajYuzdesi] [decimal](4, 1) NULL,
	[TobbKodu] [varchar](50) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_MADDE_KOD] PRIMARY KEY CLUSTERED 
(
	[MaddeKodKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[TT_SATICI_URETIM_MERKEZ]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[TT_SATICI_URETIM_MERKEZ](
	[SaticiUretimMerkezKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](2) NOT NULL,
	[SaticiUretimMerkeziAdi] [varchar](50) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_SATICI_URETIM_MERKEZLERI] PRIMARY KEY CLUSTERED 
(
	[SaticiUretimMerkezKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[TT_TESCIL_PARAMETRE]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[TT_TESCIL_PARAMETRE](
	[TescilParametreKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](2) NOT NULL,
	[Adi] [varchar](50) NOT NULL,
	[AlinabilirMi] [bit] NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_TESCIL_PARAMETRE] PRIMARY KEY CLUSTERED 
(
	[TescilParametreKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[TT_TOBB_KOD]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[TT_TOBB_KOD](
	[TobbKodKey] [int] IDENTITY(1,1) NOT NULL,
	[Kod] [char](6) NOT NULL,
	[Derece1] [char](8) NULL,
	[Derece2] [char](8) NULL,
	[Derece3] [char](8) NULL,
	[Yemlik] [char](8) NULL,
	[BaremtDisi] [char](8) NULL,
	[YemlikKodu] [char](6) NULL,
	[BaremDisiKodu] [char](6) NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_TT_TOBB_KOD] PRIMARY KEY CLUSTERED 
(
	[TobbKodKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SALON_SATIS].[URUN]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SALON_SATIS].[URUN](
	[UrunKey] [int] IDENTITY(1,1) NOT NULL,
	[UrunAdi] [varchar](50) NOT NULL,
	[TabanFiyati] [decimal](18, 2) NOT NULL,
	[KayitKisiKey] [uniqueidentifier] NULL,
	[KayitTarih] [datetime] NULL,
	[GuncelleKisiKey] [uniqueidentifier] NULL,
	[GuncelleTarih] [datetime] NULL,
 CONSTRAINT [PK_URUN] PRIMARY KEY CLUSTERED 
(
	[UrunKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [aspnet_PersonalizationPerUser_ncindex2]    Script Date: 13.07.2022 11:35:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [aspnet_PersonalizationPerUser_ncindex2] ON [dbo].[aspnet_PersonalizationPerUser]
(
	[UserId] ASC,
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [aspnet_Users_Index2]    Script Date: 13.07.2022 11:35:09 ******/
CREATE NONCLUSTERED INDEX [aspnet_Users_Index2] ON [dbo].[aspnet_Users]
(
	[ApplicationId] ASC,
	[LastActivityDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [aspnet_UsersInRoles_index]    Script Date: 13.07.2022 11:35:09 ******/
CREATE NONCLUSTERED INDEX [aspnet_UsersInRoles_index] ON [dbo].[aspnet_UsersInRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aspnet_Applications] ADD  DEFAULT (newid()) FOR [ApplicationId]
GO
ALTER TABLE [dbo].[aspnet_Membership] ADD  DEFAULT ((0)) FOR [PasswordFormat]
GO
ALTER TABLE [dbo].[aspnet_Paths] ADD  DEFAULT (newid()) FOR [PathId]
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] ADD  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[aspnet_Roles] ADD  DEFAULT (newid()) FOR [RoleId]
GO
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (newid()) FOR [UserId]
GO
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (NULL) FOR [MobileAlias]
GO
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT ((0)) FOR [IsAnonymous]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] ADD  CONSTRAINT [DF_TUCCAR_SICIL_MerkezSubemi]  DEFAULT ((1)) FOR [MerkezSubeMi]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] ADD  CONSTRAINT [DF_TUCCAR_SICIL_KayitTescilMi]  DEFAULT ((1)) FOR [KayitTescilMi]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] ADD  CONSTRAINT [DF_TUCCAR_SICIL_ResenKayitMi]  DEFAULT ((0)) FOR [ResenKayitMi]
GO
ALTER TABLE [PROGRAM].[LOG] ADD  CONSTRAINT [DF_LOG_Tarih]  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [SALON_SATIS].[TEKLIF] ADD  CONSTRAINT [DF_TEKLIF_TarihSaat]  DEFAULT (getdate()) FOR [TarihSaat]
GO
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_Paths]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_Profile]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_Roles]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Users]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[aspnet_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [MERKEZ_BORSA].[AIDAT_TAKIP]  WITH CHECK ADD  CONSTRAINT [FK_AIDAT_TAKIP_TT_DERECE] FOREIGN KEY([DereceKey])
REFERENCES [MERKEZ_BORSA].[TT_DERECE] ([DereceKey])
GO
ALTER TABLE [MERKEZ_BORSA].[AIDAT_TAKIP] CHECK CONSTRAINT [FK_AIDAT_TAKIP_TT_DERECE]
GO
ALTER TABLE [MERKEZ_BORSA].[AIDAT_TAKIP]  WITH CHECK ADD  CONSTRAINT [FK_AIDAT_TAKIP_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[AIDAT_TAKIP] CHECK CONSTRAINT [FK_AIDAT_TAKIP_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TT_ALIS_SATIS_TIP] FOREIGN KEY([AlisSatisTipKey])
REFERENCES [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP] ([AlisSatisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TT_ALIS_SATIS_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TT_BEYAN_KAYIT_TIP] FOREIGN KEY([BeyanKayitTipKey])
REFERENCES [MERKEZ_BORSA].[TT_BEYAN_KAYIT_TIP] ([BeyanKayitTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TT_BEYAN_KAYIT_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TT_BEYAN_TIP] FOREIGN KEY([BeyanTipKey])
REFERENCES [MERKEZ_BORSA].[TT_BEYAN_TIP] ([BeyanTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TT_BEYAN_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TT_BIRIM_TIP] FOREIGN KEY([BirimTipKey])
REFERENCES [MERKEZ_BORSA].[TT_BIRIM_TIP] ([BirimTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TT_BIRIM_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TT_BORSA_SUBE] FOREIGN KEY([BorsaSubeKey])
REFERENCES [MERKEZ_BORSA].[TT_BORSA_SUBE] ([BorsaSubeKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TT_BORSA_SUBE]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TT_MADDE_KOD] FOREIGN KEY([MaddeKodKey])
REFERENCES [MERKEZ_BORSA].[TT_MADDE_KOD] ([MaddeKodKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TT_MADDE_KOD]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TT_SATIS_SEKLI] FOREIGN KEY([SatisSekliKey])
REFERENCES [MERKEZ_BORSA].[TT_SATIS_SEKLI] ([SatisSekliKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TT_SATIS_SEKLI]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN]  WITH CHECK ADD  CONSTRAINT [FK_BEYAN_TUCCAR_SICIL1] FOREIGN KEY([BeyannameKarsiFirmaTuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[BEYAN] CHECK CONSTRAINT [FK_BEYAN_TUCCAR_SICIL1]
GO
ALTER TABLE [MERKEZ_BORSA].[DERECE_DEGISIKLIK]  WITH CHECK ADD  CONSTRAINT [FK_DERECE_DEGISIKLIK_TT_DERECE] FOREIGN KEY([DereceKey])
REFERENCES [MERKEZ_BORSA].[TT_DERECE] ([DereceKey])
GO
ALTER TABLE [MERKEZ_BORSA].[DERECE_DEGISIKLIK] CHECK CONSTRAINT [FK_DERECE_DEGISIKLIK_TT_DERECE]
GO
ALTER TABLE [MERKEZ_BORSA].[DERECE_DEGISIKLIK]  WITH CHECK ADD  CONSTRAINT [FK_DERECE_DEGISIKLIK_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[DERECE_DEGISIKLIK] CHECK CONSTRAINT [FK_DERECE_DEGISIKLIK_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_ADRES]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_ADRES_TT_FIRMA_ADRES_TIP] FOREIGN KEY([FirmaAdresTipKey])
REFERENCES [MERKEZ_BORSA].[TT_FIRMA_ADRES_TIP] ([FirmaAdresTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_ADRES] CHECK CONSTRAINT [FK_FIRMA_ADRES_TT_FIRMA_ADRES_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_ADRES]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_ADRES_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_ADRES] CHECK CONSTRAINT [FK_FIRMA_ADRES_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_DIGER_FAALIYET_KOD]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_DIGER_FAALIYET_KOD_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_DIGER_FAALIYET_KOD] CHECK CONSTRAINT [FK_FIRMA_DIGER_FAALIYET_KOD_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_FAALIYET]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_FAALIYET_TT_MADDE_KOD] FOREIGN KEY([MaddeKodKey])
REFERENCES [MERKEZ_BORSA].[TT_MADDE_KOD] ([MaddeKodKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_FAALIYET] CHECK CONSTRAINT [FK_FIRMA_FAALIYET_TT_MADDE_KOD]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_FAALIYET]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_FAALIYET_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_FAALIYET] CHECK CONSTRAINT [FK_FIRMA_FAALIYET_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_KAYITLI_ODA]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_KAYITLI_ODA_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_KAYITLI_ODA] CHECK CONSTRAINT [FK_FIRMA_KAYITLI_ODA_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_SAHIS]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_SAHIS_TT_OGRENIM_DURUM_TIP] FOREIGN KEY([OgrenimDurumTipKey])
REFERENCES [MERKEZ_BORSA].[TT_OGRENIM_DURUM_TIP] ([OgrenimDurumTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_SAHIS] CHECK CONSTRAINT [FK_FIRMA_SAHIS_TT_OGRENIM_DURUM_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_SAHIS]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_SAHIS_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_SAHIS] CHECK CONSTRAINT [FK_FIRMA_SAHIS_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_TELEFON_FAX]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_TELEFON_FAX_TT_FIRMA_TELEFON_FAX_TIP] FOREIGN KEY([FirmaTelefonFaxTipKey])
REFERENCES [MERKEZ_BORSA].[TT_FIRMA_TELEFON_FAX_TIP] ([FirmaTelefonFaxTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_TELEFON_FAX] CHECK CONSTRAINT [FK_FIRMA_TELEFON_FAX_TT_FIRMA_TELEFON_FAX_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_TELEFON_FAX]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_TELEFON_FAX_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_TELEFON_FAX] CHECK CONSTRAINT [FK_FIRMA_TELEFON_FAX_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_UYARI]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_UYARI_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_UYARI] CHECK CONSTRAINT [FK_FIRMA_UYARI_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_YETKILI]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_YETKILI_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_YETKILI] CHECK CONSTRAINT [FK_FIRMA_YETKILI_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_YONETIM]  WITH CHECK ADD  CONSTRAINT [FK_FIRMA_YONETIM_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIRMA_YONETIM] CHECK CONSTRAINT [FK_FIRMA_YONETIM_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[FIS_NO]  WITH CHECK ADD  CONSTRAINT [FK_FIS_NO_TT_FIS_TIP] FOREIGN KEY([FisTipKey])
REFERENCES [MERKEZ_BORSA].[TT_FIS_TIP] ([FisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIS_NO] CHECK CONSTRAINT [FK_FIS_NO_TT_FIS_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[FIS_NO]  WITH CHECK ADD  CONSTRAINT [FK_FIS_NO_TT_MUHASEBE_TIP] FOREIGN KEY([MuhasebeTipKey])
REFERENCES [MERKEZ_BORSA].[TT_MUHASEBE_TIP] ([MuhasebeTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[FIS_NO] CHECK CONSTRAINT [FK_FIS_NO_TT_MUHASEBE_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[GELEN_GIDEN_EVRAK]  WITH CHECK ADD  CONSTRAINT [FK_GELEN_GIDEN_EVRAK_TT_DOSYA_GRUP] FOREIGN KEY([DosyaGrupKey])
REFERENCES [MERKEZ_BORSA].[TT_DOSYA_GRUP] ([DosyaGrupKey])
GO
ALTER TABLE [MERKEZ_BORSA].[GELEN_GIDEN_EVRAK] CHECK CONSTRAINT [FK_GELEN_GIDEN_EVRAK_TT_DOSYA_GRUP]
GO
ALTER TABLE [MERKEZ_BORSA].[GELEN_GIDEN_EVRAK]  WITH CHECK ADD  CONSTRAINT [FK_GELEN_GIDEN_EVRAK_TT_EVRAK_TIP] FOREIGN KEY([EvrakTipKey])
REFERENCES [MERKEZ_BORSA].[TT_EVRAK_TIP] ([EvrakTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[GELEN_GIDEN_EVRAK] CHECK CONSTRAINT [FK_GELEN_GIDEN_EVRAK_TT_EVRAK_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[GELEN_GIDEN_EVRAK]  WITH CHECK ADD  CONSTRAINT [FK_GELEN_GIDEN_EVRAK_TT_IL_ILCE] FOREIGN KEY([IlIlceKey])
REFERENCES [MERKEZ_BORSA].[TT_IL_ILCE] ([IlIlceKey])
GO
ALTER TABLE [MERKEZ_BORSA].[GELEN_GIDEN_EVRAK] CHECK CONSTRAINT [FK_GELEN_GIDEN_EVRAK_TT_IL_ILCE]
GO
ALTER TABLE [MERKEZ_BORSA].[HESAP_PLANI]  WITH CHECK ADD  CONSTRAINT [FK_HESAP_PLANI_TT_MUHASEBE_TIP] FOREIGN KEY([MuhasebeTipKey])
REFERENCES [MERKEZ_BORSA].[TT_MUHASEBE_TIP] ([MuhasebeTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[HESAP_PLANI] CHECK CONSTRAINT [FK_HESAP_PLANI_TT_MUHASEBE_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[KAYIT_TAKIP]  WITH CHECK ADD  CONSTRAINT [FK_KAYIT_TAKIP_TT_DERECE] FOREIGN KEY([DereceKey])
REFERENCES [MERKEZ_BORSA].[TT_DERECE] ([DereceKey])
GO
ALTER TABLE [MERKEZ_BORSA].[KAYIT_TAKIP] CHECK CONSTRAINT [FK_KAYIT_TAKIP_TT_DERECE]
GO
ALTER TABLE [MERKEZ_BORSA].[KAYIT_TAKIP]  WITH CHECK ADD  CONSTRAINT [FK_KAYIT_TAKIP_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[KAYIT_TAKIP] CHECK CONSTRAINT [FK_KAYIT_TAKIP_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[MESLEK_GRUP_DEGISIKLIK]  WITH CHECK ADD  CONSTRAINT [FK_MESLEK_GRUP_DEGISIKLIK_TT_MESLEK_GRUP] FOREIGN KEY([MeslekGrupKey])
REFERENCES [MERKEZ_BORSA].[TT_MESLEK_GRUP] ([MeslekGrupKey])
GO
ALTER TABLE [MERKEZ_BORSA].[MESLEK_GRUP_DEGISIKLIK] CHECK CONSTRAINT [FK_MESLEK_GRUP_DEGISIKLIK_TT_MESLEK_GRUP]
GO
ALTER TABLE [MERKEZ_BORSA].[MESLEK_GRUP_DEGISIKLIK]  WITH CHECK ADD  CONSTRAINT [FK_MESLEK_GRUP_DEGISIKLIK_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[MESLEK_GRUP_DEGISIKLIK] CHECK CONSTRAINT [FK_MESLEK_GRUP_DEGISIKLIK_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[SERMAYE_DEGISIKLIK]  WITH CHECK ADD  CONSTRAINT [FK_SERMAYE_DEGISIKLIK_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[SERMAYE_DEGISIKLIK] CHECK CONSTRAINT [FK_SERMAYE_DEGISIKLIK_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[TASDIK_FASIL_AKTARMA_ACIKLAMA]  WITH CHECK ADD  CONSTRAINT [FK_TASDIK_FASIL_AKTARMA_ACIKLAMA_TT_TASDIK_FASIL_AKTARMA_TIP] FOREIGN KEY([TasdikFasilAktarmaTipKey])
REFERENCES [MERKEZ_BORSA].[TT_TASDIK_FASIL_AKTARMA_TIP] ([TasdikFasilAktarmaTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TASDIK_FASIL_AKTARMA_ACIKLAMA] CHECK CONSTRAINT [FK_TASDIK_FASIL_AKTARMA_ACIKLAMA_TT_TASDIK_FASIL_AKTARMA_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[TESCIL_ORAN]  WITH CHECK ADD  CONSTRAINT [FK_TESCIL_ORAN_TT_MUHASEBE_TIP] FOREIGN KEY([MuhasebeTipKey])
REFERENCES [MERKEZ_BORSA].[TT_MUHASEBE_TIP] ([MuhasebeTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TESCIL_ORAN] CHECK CONSTRAINT [FK_TESCIL_ORAN_TT_MUHASEBE_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[TESCIL_ORAN]  WITH CHECK ADD  CONSTRAINT [FK_TESCIL_ORAN_TT_TAHSILAT_TIP] FOREIGN KEY([TahsilatTipKey])
REFERENCES [MERKEZ_BORSA].[TT_TAHSILAT_TIP] ([TahsilatTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TESCIL_ORAN] CHECK CONSTRAINT [FK_TESCIL_ORAN_TT_TAHSILAT_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI]  WITH CHECK ADD  CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP] FOREIGN KEY([SatanKey])
REFERENCES [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP] ([AlisSatisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI] CHECK CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI]  WITH CHECK ADD  CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP1] FOREIGN KEY([AlanKey])
REFERENCES [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP] ([AlisSatisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI] CHECK CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP1]
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI]  WITH CHECK ADD  CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP2] FOREIGN KEY([StopajKey])
REFERENCES [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP] ([AlisSatisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI] CHECK CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP2]
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI]  WITH CHECK ADD  CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP3] FOREIGN KEY([TescilKey])
REFERENCES [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP] ([AlisSatisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI] CHECK CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP3]
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI]  WITH CHECK ADD  CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP4] FOREIGN KEY([SimsarKey])
REFERENCES [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP] ([AlisSatisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI] CHECK CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP4]
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI]  WITH CHECK ADD  CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP5] FOREIGN KEY([TipKey])
REFERENCES [MERKEZ_BORSA].[TT_ALIS_SATIS_TIP] ([AlisSatisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TT_SATIS_SEKLI] CHECK CONSTRAINT [FK_TT_SATIS_SEKLI_TT_ALIS_SATIS_TIP5]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_ASKI]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_ASKI_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_ASKI] CHECK CONSTRAINT [FK_TUCCAR_ASKI_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_DEPO]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_DEPO_TT_MADDE_KOD] FOREIGN KEY([MaddeKodKey])
REFERENCES [MERKEZ_BORSA].[TT_MADDE_KOD] ([MaddeKodKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_DEPO] CHECK CONSTRAINT [FK_TUCCAR_DEPO_TT_MADDE_KOD]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_DEPO]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_DEPO_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_DEPO] CHECK CONSTRAINT [FK_TUCCAR_DEPO_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_KEFALET_TEMINAT]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_KEFALET_TEMINAT_TUCCAR_SICIL] FOREIGN KEY([TuccarKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_KEFALET_TEMINAT] CHECK CONSTRAINT [FK_TUCCAR_KEFALET_TEMINAT_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_KEFALET_TEMINAT]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_KEFALET_TEMINAT_TUCCAR_SICIL1] FOREIGN KEY([KefilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_KEFALET_TEMINAT] CHECK CONSTRAINT [FK_TUCCAR_KEFALET_TEMINAT_TUCCAR_SICIL1]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_SICIL_TT_DERECE] FOREIGN KEY([DereceKey])
REFERENCES [MERKEZ_BORSA].[TT_DERECE] ([DereceKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] CHECK CONSTRAINT [FK_TUCCAR_SICIL_TT_DERECE]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_SICIL_TT_IL_ILCE] FOREIGN KEY([IlIlceKey])
REFERENCES [MERKEZ_BORSA].[TT_IL_ILCE] ([IlIlceKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] CHECK CONSTRAINT [FK_TUCCAR_SICIL_TT_IL_ILCE]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_SICIL_TT_KURULUS_TUR] FOREIGN KEY([KurulusTurKey])
REFERENCES [MERKEZ_BORSA].[TT_KURULUS_TUR] ([KurulusTurKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] CHECK CONSTRAINT [FK_TUCCAR_SICIL_TT_KURULUS_TUR]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_SICIL_TT_MESLEK_GRUP] FOREIGN KEY([MeslekGrupKey])
REFERENCES [MERKEZ_BORSA].[TT_MESLEK_GRUP] ([MeslekGrupKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] CHECK CONSTRAINT [FK_TUCCAR_SICIL_TT_MESLEK_GRUP]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_SICIL_TT_SICIL_MEMURLUGU] FOREIGN KEY([SicilMemurluguKey])
REFERENCES [MERKEZ_BORSA].[TT_SICIL_MEMURLUGU] ([SicilMemurluguKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] CHECK CONSTRAINT [FK_TUCCAR_SICIL_TT_SICIL_MEMURLUGU]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_SICIL_TT_VERGI_DAIRE] FOREIGN KEY([VergiDaireKey])
REFERENCES [MERKEZ_BORSA].[TT_VERGI_DAIRE] ([VergiDaireKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_SICIL] CHECK CONSTRAINT [FK_TUCCAR_SICIL_TT_VERGI_DAIRE]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_TAHSIL]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_TAHSIL_TT_VERGI_DAIRE] FOREIGN KEY([VergiDaireKey])
REFERENCES [MERKEZ_BORSA].[TT_VERGI_DAIRE] ([VergiDaireKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_TAHSIL] CHECK CONSTRAINT [FK_TUCCAR_TAHSIL_TT_VERGI_DAIRE]
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_TAHSIL]  WITH CHECK ADD  CONSTRAINT [FK_TUCCAR_TAHSIL_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[TUCCAR_TAHSIL] CHECK CONSTRAINT [FK_TUCCAR_TAHSIL_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[UNVAN_DEGISIKLIK]  WITH CHECK ADD  CONSTRAINT [FK_UNVAN_DEGISIKLIK_TUCCAR_SICIL] FOREIGN KEY([TuccarSicilKey])
REFERENCES [MERKEZ_BORSA].[TUCCAR_SICIL] ([TuccarSicilKey])
GO
ALTER TABLE [MERKEZ_BORSA].[UNVAN_DEGISIKLIK] CHECK CONSTRAINT [FK_UNVAN_DEGISIKLIK_TUCCAR_SICIL]
GO
ALTER TABLE [MERKEZ_BORSA].[YEVMIYE]  WITH CHECK ADD  CONSTRAINT [FK_YEVMIYE_HESAP_PLANI] FOREIGN KEY([HesapPlaniKey])
REFERENCES [MERKEZ_BORSA].[HESAP_PLANI] ([HesapPlaniKey])
GO
ALTER TABLE [MERKEZ_BORSA].[YEVMIYE] CHECK CONSTRAINT [FK_YEVMIYE_HESAP_PLANI]
GO
ALTER TABLE [MERKEZ_BORSA].[YEVMIYE]  WITH CHECK ADD  CONSTRAINT [FK_YEVMIYE_TT_FIS_TIP] FOREIGN KEY([FisTipKey])
REFERENCES [MERKEZ_BORSA].[TT_FIS_TIP] ([FisTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[YEVMIYE] CHECK CONSTRAINT [FK_YEVMIYE_TT_FIS_TIP]
GO
ALTER TABLE [MERKEZ_BORSA].[YEVMIYE]  WITH CHECK ADD  CONSTRAINT [FK_YEVMIYE_TT_MUHASEBE_TIP] FOREIGN KEY([MuhasebeTipKey])
REFERENCES [MERKEZ_BORSA].[TT_MUHASEBE_TIP] ([MuhasebeTipKey])
GO
ALTER TABLE [MERKEZ_BORSA].[YEVMIYE] CHECK CONSTRAINT [FK_YEVMIYE_TT_MUHASEBE_TIP]
GO
ALTER TABLE [PROGRAM].[BORSA_BILGI]  WITH CHECK ADD  CONSTRAINT [FK_PROGRAM_BORSA_BILGI_TT_UYE_TEMINAT_TIP] FOREIGN KEY([UyeTeminatTipiKey])
REFERENCES [PROGRAM].[TT_UYE_TEMINAT_TIP] ([UyeTeminatTipiKey])
GO
ALTER TABLE [PROGRAM].[BORSA_BILGI] CHECK CONSTRAINT [FK_PROGRAM_BORSA_BILGI_TT_UYE_TEMINAT_TIP]
GO
ALTER TABLE [SALON_SATIS].[SATIS]  WITH CHECK ADD  CONSTRAINT [FK_SATIS_URUN] FOREIGN KEY([UrunKey])
REFERENCES [SALON_SATIS].[URUN] ([UrunKey])
GO
ALTER TABLE [SALON_SATIS].[SATIS] CHECK CONSTRAINT [FK_SATIS_URUN]
GO
ALTER TABLE [SALON_SATIS].[TEKLIF]  WITH CHECK ADD  CONSTRAINT [FK_TEKLIF_SATIS] FOREIGN KEY([SatisKey])
REFERENCES [SALON_SATIS].[SATIS] ([SatisKey])
GO
ALTER TABLE [SALON_SATIS].[TEKLIF] CHECK CONSTRAINT [FK_TEKLIF_SATIS]
GO
ALTER TABLE [SALON_SATIS].[TESCIL]  WITH CHECK ADD  CONSTRAINT [FK_TESCIL_TT_TESCIL_PARAMETRE] FOREIGN KEY([TescilParametreKey])
REFERENCES [SALON_SATIS].[TT_TESCIL_PARAMETRE] ([TescilParametreKey])
GO
ALTER TABLE [SALON_SATIS].[TESCIL] CHECK CONSTRAINT [FK_TESCIL_TT_TESCIL_PARAMETRE]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_AnyDataInTables]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_AnyDataInTables]
    @TablesToCheck int
AS
BEGIN
    -- Check Membership table if (@TablesToCheck & 1) is set
    IF ((@TablesToCheck & 1) <> 0 AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_MembershipUsers') AND (type = 'V'))))
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Membership))
        BEGIN
            SELECT N'aspnet_Membership'
            RETURN
        END
    END

    -- Check aspnet_Roles table if (@TablesToCheck & 2) is set
    IF ((@TablesToCheck & 2) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Roles') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 RoleId FROM dbo.aspnet_Roles))
        BEGIN
            SELECT N'aspnet_Roles'
            RETURN
        END
    END

    -- Check aspnet_Profile table if (@TablesToCheck & 4) is set
    IF ((@TablesToCheck & 4) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Profiles') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Profile))
        BEGIN
            SELECT N'aspnet_Profile'
            RETURN
        END
    END

    -- Check aspnet_PersonalizationPerUser table if (@TablesToCheck & 8) is set
    IF ((@TablesToCheck & 8) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_WebPartState_User') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_PersonalizationPerUser))
        BEGIN
            SELECT N'aspnet_PersonalizationPerUser'
            RETURN
        END
    END

    -- Check aspnet_PersonalizationPerUser table if (@TablesToCheck & 16) is set
    IF ((@TablesToCheck & 16) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'aspnet_WebEvent_LogEvent') AND (type = 'P'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 * FROM dbo.aspnet_WebEvent_Events))
        BEGIN
            SELECT N'aspnet_WebEvent_Events'
            RETURN
        END
    END

    -- Check aspnet_Users table if (@TablesToCheck & 1,2,4 & 8) are all set
    IF ((@TablesToCheck & 1) <> 0 AND
        (@TablesToCheck & 2) <> 0 AND
        (@TablesToCheck & 4) <> 0 AND
        (@TablesToCheck & 8) <> 0 AND
        (@TablesToCheck & 32) <> 0 AND
        (@TablesToCheck & 128) <> 0 AND
        (@TablesToCheck & 256) <> 0 AND
        (@TablesToCheck & 512) <> 0 AND
        (@TablesToCheck & 1024) <> 0)
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Users))
        BEGIN
            SELECT N'aspnet_Users'
            RETURN
        END
        IF (EXISTS(SELECT TOP 1 ApplicationId FROM dbo.aspnet_Applications))
        BEGIN
            SELECT N'aspnet_Applications'
            RETURN
        END
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Applications_CreateApplication]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Applications_CreateApplication]
    @ApplicationName      nvarchar(256),
    @ApplicationId        uniqueidentifier OUTPUT
AS
BEGIN
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName

    IF(@ApplicationId IS NULL)
    BEGIN
        DECLARE @TranStarted   bit
        SET @TranStarted = 0

        IF( @@TRANCOUNT = 0 )
        BEGIN
	        BEGIN TRANSACTION
	        SET @TranStarted = 1
        END
        ELSE
    	    SET @TranStarted = 0

        SELECT  @ApplicationId = ApplicationId
        FROM dbo.aspnet_Applications WITH (UPDLOCK, HOLDLOCK)
        WHERE LOWER(@ApplicationName) = LoweredApplicationName

        IF(@ApplicationId IS NULL)
        BEGIN
            SELECT  @ApplicationId = NEWID()
            INSERT  dbo.aspnet_Applications (ApplicationId, ApplicationName, LoweredApplicationName)
            VALUES  (@ApplicationId, @ApplicationName, LOWER(@ApplicationName))
        END


        IF( @TranStarted = 1 )
        BEGIN
            IF(@@ERROR = 0)
            BEGIN
	        SET @TranStarted = 0
	        COMMIT TRANSACTION
            END
            ELSE
            BEGIN
                SET @TranStarted = 0
                ROLLBACK TRANSACTION
            END
        END
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_CheckSchemaVersion]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_CheckSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    IF (EXISTS( SELECT  *
                FROM    dbo.aspnet_SchemaVersions
                WHERE   Feature = LOWER( @Feature ) AND
                        CompatibleSchemaVersion = @CompatibleSchemaVersion ))
        RETURN 0

    RETURN 1
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]
    @ApplicationName       nvarchar(256),
    @UserName              nvarchar(256),
    @NewPasswordQuestion   nvarchar(256),
    @NewPasswordAnswer     nvarchar(128)
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Membership m, dbo.aspnet_Users u, dbo.aspnet_Applications a
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId
    IF (@UserId IS NULL)
    BEGIN
        RETURN(1)
    END

    UPDATE dbo.aspnet_Membership
    SET    PasswordQuestion = @NewPasswordQuestion, PasswordAnswer = @NewPasswordAnswer
    WHERE  UserId=@UserId
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_CreateUser]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_CreateUser]
    @ApplicationName                        nvarchar(256),
    @UserName                               nvarchar(256),
    @Password                               nvarchar(128),
    @PasswordSalt                           nvarchar(128),
    @Email                                  nvarchar(256),
    @PasswordQuestion                       nvarchar(256),
    @PasswordAnswer                         nvarchar(128),
    @IsApproved                             bit,
    @CurrentTimeUtc                         datetime,
    @CreateDate                             datetime = NULL,
    @UniqueEmail                            int      = 0,
    @PasswordFormat                         int      = 0,
    @UserId                                 uniqueidentifier OUTPUT
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @NewUserId uniqueidentifier
    SELECT @NewUserId = NULL

    DECLARE @IsLockedOut bit
    SET @IsLockedOut = 0

    DECLARE @LastLockoutDate  datetime
    SET @LastLockoutDate = CONVERT( datetime, '17540101', 112 )

    DECLARE @FailedPasswordAttemptCount int
    SET @FailedPasswordAttemptCount = 0

    DECLARE @FailedPasswordAttemptWindowStart  datetime
    SET @FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 )

    DECLARE @FailedPasswordAnswerAttemptCount int
    SET @FailedPasswordAnswerAttemptCount = 0

    DECLARE @FailedPasswordAnswerAttemptWindowStart  datetime
    SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )

    DECLARE @NewUserCreated bit
    DECLARE @ReturnValue   int
    SET @ReturnValue = 0

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    SET @CreateDate = @CurrentTimeUtc

    SELECT  @NewUserId = UserId FROM dbo.aspnet_Users WHERE LOWER(@UserName) = LoweredUserName AND @ApplicationId = ApplicationId
    IF ( @NewUserId IS NULL )
    BEGIN
        SET @NewUserId = @UserId
        EXEC @ReturnValue = dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CreateDate, @NewUserId OUTPUT
        SET @NewUserCreated = 1
    END
    ELSE
    BEGIN
        SET @NewUserCreated = 0
        IF( @NewUserId <> @UserId AND @UserId IS NOT NULL )
        BEGIN
            SET @ErrorCode = 6
            GOTO Cleanup
        END
    END

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @ReturnValue = -1 )
    BEGIN
        SET @ErrorCode = 10
        GOTO Cleanup
    END

    IF ( EXISTS ( SELECT UserId
                  FROM   dbo.aspnet_Membership
                  WHERE  @NewUserId = UserId ) )
    BEGIN
        SET @ErrorCode = 6
        GOTO Cleanup
    END

    SET @UserId = @NewUserId

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  dbo.aspnet_Membership m WITH ( UPDLOCK, HOLDLOCK )
                    WHERE ApplicationId = @ApplicationId AND LoweredEmail = LOWER(@Email)))
        BEGIN
            SET @ErrorCode = 7
            GOTO Cleanup
        END
    END

    IF (@NewUserCreated = 0)
    BEGIN
        UPDATE dbo.aspnet_Users
        SET    LastActivityDate = @CreateDate
        WHERE  @UserId = UserId
        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    INSERT INTO dbo.aspnet_Membership
                ( ApplicationId,
                  UserId,
                  Password,
                  PasswordSalt,
                  Email,
                  LoweredEmail,
                  PasswordQuestion,
                  PasswordAnswer,
                  PasswordFormat,
                  IsApproved,
                  IsLockedOut,
                  CreateDate,
                  LastLoginDate,
                  LastPasswordChangedDate,
                  LastLockoutDate,
                  FailedPasswordAttemptCount,
                  FailedPasswordAttemptWindowStart,
                  FailedPasswordAnswerAttemptCount,
                  FailedPasswordAnswerAttemptWindowStart )
         VALUES ( @ApplicationId,
                  @UserId,
                  @Password,
                  @PasswordSalt,
                  @Email,
                  LOWER(@Email),
                  @PasswordQuestion,
                  @PasswordAnswer,
                  @PasswordFormat,
                  @IsApproved,
                  @IsLockedOut,
                  @CreateDate,
                  @CreateDate,
                  @CreateDate,
                  @LastLockoutDate,
                  @FailedPasswordAttemptCount,
                  @FailedPasswordAttemptWindowStart,
                  @FailedPasswordAnswerAttemptCount,
                  @FailedPasswordAnswerAttemptWindowStart )

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_FindUsersByEmail]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByEmail]
    @ApplicationName       nvarchar(256),
    @EmailToMatch          nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    IF( @EmailToMatch IS NULL )
        INSERT INTO #PageIndexForUsers (UserId)
            SELECT u.UserId
            FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
            WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND m.Email IS NULL
            ORDER BY m.LoweredEmail
    ELSE
        INSERT INTO #PageIndexForUsers (UserId)
            SELECT u.UserId
            FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
            WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND m.LoweredEmail LIKE LOWER(@EmailToMatch)
            ORDER BY m.LoweredEmail

    SELECT  u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY m.LoweredEmail

    SELECT  @TotalRecords = COUNT(*)
    FROM    #PageIndexForUsers
    RETURN @TotalRecords
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_FindUsersByName]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByName]
    @ApplicationName       nvarchar(256),
    @UserNameToMatch       nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
        SELECT u.UserId
        FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND u.LoweredUserName LIKE LOWER(@UserNameToMatch)
        ORDER BY u.UserName


    SELECT  u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName

    SELECT  @TotalRecords = COUNT(*)
    FROM    #PageIndexForUsers
    RETURN @TotalRecords
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetAllUsers]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetAllUsers]
    @ApplicationName       nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0


    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
    SELECT u.UserId
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u
    WHERE  u.ApplicationId = @ApplicationId AND u.UserId = m.UserId
    ORDER BY u.UserName

    SELECT @TotalRecords = @@ROWCOUNT

    SELECT u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName
    RETURN @TotalRecords
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetNumberOfUsersOnline]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetNumberOfUsersOnline]
    @ApplicationName            nvarchar(256),
    @MinutesSinceLastInActive   int,
    @CurrentTimeUtc             datetime
AS
BEGIN
    DECLARE @DateActive datetime
    SELECT  @DateActive = DATEADD(minute,  -(@MinutesSinceLastInActive), @CurrentTimeUtc)

    DECLARE @NumOnline int
    SELECT  @NumOnline = COUNT(*)
    FROM    dbo.aspnet_Users u(NOLOCK),
            dbo.aspnet_Applications a(NOLOCK),
            dbo.aspnet_Membership m(NOLOCK)
    WHERE   u.ApplicationId = a.ApplicationId                  AND
            LastActivityDate > @DateActive                     AND
            a.LoweredApplicationName = LOWER(@ApplicationName) AND
            u.UserId = m.UserId
    RETURN(@NumOnline)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetPassword]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetPassword]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @MaxInvalidPasswordAttempts     int,
    @PasswordAttemptWindow          int,
    @CurrentTimeUtc                 datetime,
    @PasswordAnswer                 nvarchar(128) = NULL
AS
BEGIN
    DECLARE @UserId                                 uniqueidentifier
    DECLARE @PasswordFormat                         int
    DECLARE @Password                               nvarchar(128)
    DECLARE @passAns                                nvarchar(128)
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId,
            @Password = m.Password,
            @passAns = m.PasswordAnswer,
            @PasswordFormat = m.PasswordFormat,
            @IsLockedOut = m.IsLockedOut,
            @LastLockoutDate = m.LastLockoutDate,
            @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
            @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
            @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
            @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m WITH ( UPDLOCK )
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF ( @@rowcount = 0 )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    IF( @IsLockedOut = 1 )
    BEGIN
        SET @ErrorCode = 99
        GOTO Cleanup
    END

    IF ( NOT( @PasswordAnswer IS NULL ) )
    BEGIN
        IF( ( @passAns IS NULL ) OR ( LOWER( @passAns ) <> LOWER( @PasswordAnswer ) ) )
        BEGIN
            IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart ) )
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = 1
            END
            ELSE
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
            END

            BEGIN
                IF( @FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts )
                BEGIN
                    SET @IsLockedOut = 1
                    SET @LastLockoutDate = @CurrentTimeUtc
                END
            END

            SET @ErrorCode = 3
        END
        ELSE
        BEGIN
            IF( @FailedPasswordAnswerAttemptCount > 0 )
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = 0
                SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            END
        END

        UPDATE dbo.aspnet_Membership
        SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
            FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
            FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
            FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
            FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
        WHERE @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    IF( @ErrorCode = 0 )
        SELECT @Password, @PasswordFormat

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetPasswordWithFormat]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetPasswordWithFormat]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @UpdateLastLoginActivityDate    bit,
    @CurrentTimeUtc                 datetime
AS
BEGIN
    DECLARE @IsLockedOut                        bit
    DECLARE @UserId                             uniqueidentifier
    DECLARE @Password                           nvarchar(128)
    DECLARE @PasswordSalt                       nvarchar(128)
    DECLARE @PasswordFormat                     int
    DECLARE @FailedPasswordAttemptCount         int
    DECLARE @FailedPasswordAnswerAttemptCount   int
    DECLARE @IsApproved                         bit
    DECLARE @LastActivityDate                   datetime
    DECLARE @LastLoginDate                      datetime

    SELECT  @UserId          = NULL

    SELECT  @UserId = u.UserId, @IsLockedOut = m.IsLockedOut, @Password=Password, @PasswordFormat=PasswordFormat,
            @PasswordSalt=PasswordSalt, @FailedPasswordAttemptCount=FailedPasswordAttemptCount,
		    @FailedPasswordAnswerAttemptCount=FailedPasswordAnswerAttemptCount, @IsApproved=IsApproved,
            @LastActivityDate = LastActivityDate, @LastLoginDate = LastLoginDate
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF (@UserId IS NULL)
        RETURN 1

    IF (@IsLockedOut = 1)
        RETURN 99

    SELECT   @Password, @PasswordFormat, @PasswordSalt, @FailedPasswordAttemptCount,
             @FailedPasswordAnswerAttemptCount, @IsApproved, @LastLoginDate, @LastActivityDate

    IF (@UpdateLastLoginActivityDate = 1 AND @IsApproved = 1)
    BEGIN
        UPDATE  dbo.aspnet_Membership
        SET     LastLoginDate = @CurrentTimeUtc
        WHERE   UserId = @UserId

        UPDATE  dbo.aspnet_Users
        SET     LastActivityDate = @CurrentTimeUtc
        WHERE   @UserId = UserId
    END


    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByEmail]    Script Date: 13.07.2022 11:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByEmail]
    @ApplicationName  nvarchar(256),
    @Email            nvarchar(256)
AS
BEGIN
    IF( @Email IS NULL )
        SELECT  u.UserName
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                u.UserId = m.UserId AND
                m.ApplicationId = a.ApplicationId AND
                m.LoweredEmail IS NULL
    ELSE
        SELECT  u.UserName
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                u.UserId = m.UserId AND
                m.ApplicationId = a.ApplicationId AND
                LOWER(@Email) = m.LoweredEmail

    IF (@@rowcount = 0)
        RETURN(1)
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByName]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByName]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @CurrentTimeUtc       datetime,
    @UpdateLastActivity   bit = 0
AS
BEGIN
    DECLARE @UserId uniqueidentifier

    IF (@UpdateLastActivity = 1)
    BEGIN
        -- select user ID from aspnet_users table
        SELECT TOP 1 @UserId = u.UserId
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE    LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                LOWER(@UserName) = u.LoweredUserName AND u.UserId = m.UserId

        IF (@@ROWCOUNT = 0) -- Username not found
            RETURN -1

        UPDATE   dbo.aspnet_Users
        SET      LastActivityDate = @CurrentTimeUtc
        WHERE    @UserId = UserId

        SELECT m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
                m.CreateDate, m.LastLoginDate, u.LastActivityDate, m.LastPasswordChangedDate,
                u.UserId, m.IsLockedOut, m.LastLockoutDate
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE  @UserId = u.UserId AND u.UserId = m.UserId 
    END
    ELSE
    BEGIN
        SELECT TOP 1 m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
                m.CreateDate, m.LastLoginDate, u.LastActivityDate, m.LastPasswordChangedDate,
                u.UserId, m.IsLockedOut,m.LastLockoutDate
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE    LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                LOWER(@UserName) = u.LoweredUserName AND u.UserId = m.UserId

        IF (@@ROWCOUNT = 0) -- Username not found
            RETURN -1
    END

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByUserId]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByUserId]
    @UserId               uniqueidentifier,
    @CurrentTimeUtc       datetime,
    @UpdateLastActivity   bit = 0
AS
BEGIN
    IF ( @UpdateLastActivity = 1 )
    BEGIN
        UPDATE   dbo.aspnet_Users
        SET      LastActivityDate = @CurrentTimeUtc
        FROM     dbo.aspnet_Users
        WHERE    @UserId = UserId

        IF ( @@ROWCOUNT = 0 ) -- User ID not found
            RETURN -1
    END

    SELECT  m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate, m.LastLoginDate, u.LastActivityDate,
            m.LastPasswordChangedDate, u.UserName, m.IsLockedOut,
            m.LastLockoutDate
    FROM    dbo.aspnet_Users u, dbo.aspnet_Membership m
    WHERE   @UserId = u.UserId AND u.UserId = m.UserId

    IF ( @@ROWCOUNT = 0 ) -- User ID not found
       RETURN -1

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_ResetPassword]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_ResetPassword]
    @ApplicationName             nvarchar(256),
    @UserName                    nvarchar(256),
    @NewPassword                 nvarchar(128),
    @MaxInvalidPasswordAttempts  int,
    @PasswordAttemptWindow       int,
    @PasswordSalt                nvarchar(128),
    @CurrentTimeUtc              datetime,
    @PasswordFormat              int = 0,
    @PasswordAnswer              nvarchar(128) = NULL
AS
BEGIN
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @UserId                                 uniqueidentifier
    SET     @UserId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    SELECT @IsLockedOut = IsLockedOut,
           @LastLockoutDate = LastLockoutDate,
           @FailedPasswordAttemptCount = FailedPasswordAttemptCount,
           @FailedPasswordAttemptWindowStart = FailedPasswordAttemptWindowStart,
           @FailedPasswordAnswerAttemptCount = FailedPasswordAnswerAttemptCount,
           @FailedPasswordAnswerAttemptWindowStart = FailedPasswordAnswerAttemptWindowStart
    FROM dbo.aspnet_Membership WITH ( UPDLOCK )
    WHERE @UserId = UserId

    IF( @IsLockedOut = 1 )
    BEGIN
        SET @ErrorCode = 99
        GOTO Cleanup
    END

    UPDATE dbo.aspnet_Membership
    SET    Password = @NewPassword,
           LastPasswordChangedDate = @CurrentTimeUtc,
           PasswordFormat = @PasswordFormat,
           PasswordSalt = @PasswordSalt
    WHERE  @UserId = UserId AND
           ( ( @PasswordAnswer IS NULL ) OR ( LOWER( PasswordAnswer ) = LOWER( @PasswordAnswer ) ) )

    IF ( @@ROWCOUNT = 0 )
        BEGIN
            IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart ) )
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = 1
            END
            ELSE
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1
            END

            BEGIN
                IF( @FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts )
                BEGIN
                    SET @IsLockedOut = 1
                    SET @LastLockoutDate = @CurrentTimeUtc
                END
            END

            SET @ErrorCode = 3
        END
    ELSE
        BEGIN
            IF( @FailedPasswordAnswerAttemptCount > 0 )
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = 0
                SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            END
        END

    IF( NOT ( @PasswordAnswer IS NULL ) )
    BEGIN
        UPDATE dbo.aspnet_Membership
        SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
            FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
            FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
            FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
            FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
        WHERE @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_SetPassword]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_SetPassword]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @NewPassword      nvarchar(128),
    @PasswordSalt     nvarchar(128),
    @CurrentTimeUtc   datetime,
    @PasswordFormat   int = 0
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF (@UserId IS NULL)
        RETURN(1)

    UPDATE dbo.aspnet_Membership
    SET Password = @NewPassword, PasswordFormat = @PasswordFormat, PasswordSalt = @PasswordSalt,
        LastPasswordChangedDate = @CurrentTimeUtc
    WHERE @UserId = UserId
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UnlockUser]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UnlockUser]
    @ApplicationName                         nvarchar(256),
    @UserName                                nvarchar(256)
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
        RETURN 1

    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = 0,
        FailedPasswordAttemptCount = 0,
        FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        FailedPasswordAnswerAttemptCount = 0,
        FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        LastLockoutDate = CONVERT( datetime, '17540101', 112 )
    WHERE @UserId = UserId

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UpdateUser]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUser]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @Email                nvarchar(256),
    @Comment              ntext,
    @IsApproved           bit,
    @LastLoginDate        datetime,
    @LastActivityDate     datetime,
    @UniqueEmail          int,
    @CurrentTimeUtc       datetime
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId, @ApplicationId = a.ApplicationId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF (@UserId IS NULL)
        RETURN(1)

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  dbo.aspnet_Membership WITH (UPDLOCK, HOLDLOCK)
                    WHERE ApplicationId = @ApplicationId  AND @UserId <> UserId AND LoweredEmail = LOWER(@Email)))
        BEGIN
            RETURN(7)
        END
    END

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
	SET @TranStarted = 0

    UPDATE dbo.aspnet_Users WITH (ROWLOCK)
    SET
         LastActivityDate = @LastActivityDate
    WHERE
       @UserId = UserId

    IF( @@ERROR <> 0 )
        GOTO Cleanup

    UPDATE dbo.aspnet_Membership WITH (ROWLOCK)
    SET
         Email            = @Email,
         LoweredEmail     = LOWER(@Email),
         Comment          = @Comment,
         IsApproved       = @IsApproved,
         LastLoginDate    = @LastLoginDate
    WHERE
       @UserId = UserId

    IF( @@ERROR <> 0 )
        GOTO Cleanup

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN -1
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UpdateUserInfo]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUserInfo]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @IsPasswordCorrect              bit,
    @UpdateLastLoginActivityDate    bit,
    @MaxInvalidPasswordAttempts     int,
    @PasswordAttemptWindow          int,
    @CurrentTimeUtc                 datetime,
    @LastLoginDate                  datetime,
    @LastActivityDate               datetime
AS
BEGIN
    DECLARE @UserId                                 uniqueidentifier
    DECLARE @IsApproved                             bit
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId,
            @IsApproved = m.IsApproved,
            @IsLockedOut = m.IsLockedOut,
            @LastLockoutDate = m.LastLockoutDate,
            @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
            @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
            @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
            @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m WITH ( UPDLOCK )
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF ( @@rowcount = 0 )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    IF( @IsLockedOut = 1 )
    BEGIN
        GOTO Cleanup
    END

    IF( @IsPasswordCorrect = 0 )
    BEGIN
        IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAttemptWindowStart ) )
        BEGIN
            SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc
            SET @FailedPasswordAttemptCount = 1
        END
        ELSE
        BEGIN
            SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc
            SET @FailedPasswordAttemptCount = @FailedPasswordAttemptCount + 1
        END

        BEGIN
            IF( @FailedPasswordAttemptCount >= @MaxInvalidPasswordAttempts )
            BEGIN
                SET @IsLockedOut = 1
                SET @LastLockoutDate = @CurrentTimeUtc
            END
        END
    END
    ELSE
    BEGIN
        IF( @FailedPasswordAttemptCount > 0 OR @FailedPasswordAnswerAttemptCount > 0 )
        BEGIN
            SET @FailedPasswordAttemptCount = 0
            SET @FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            SET @FailedPasswordAnswerAttemptCount = 0
            SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            SET @LastLockoutDate = CONVERT( datetime, '17540101', 112 )
        END
    END

    IF( @UpdateLastLoginActivityDate = 1 )
    BEGIN
        UPDATE  dbo.aspnet_Users
        SET     LastActivityDate = @LastActivityDate
        WHERE   @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END

        UPDATE  dbo.aspnet_Membership
        SET     LastLoginDate = @LastLoginDate
        WHERE   UserId = @UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END


    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
        FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
        FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
        FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
        FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
    WHERE @UserId = UserId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Paths_CreatePath]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Paths_CreatePath]
    @ApplicationId UNIQUEIDENTIFIER,
    @Path           NVARCHAR(256),
    @PathId         UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    BEGIN TRANSACTION
    IF (NOT EXISTS(SELECT * FROM dbo.aspnet_Paths WHERE LoweredPath = LOWER(@Path) AND ApplicationId = @ApplicationId))
    BEGIN
        INSERT dbo.aspnet_Paths (ApplicationId, Path, LoweredPath) VALUES (@ApplicationId, @Path, LOWER(@Path))
    END
    COMMIT TRANSACTION
    SELECT @PathId = PathId FROM dbo.aspnet_Paths WHERE LOWER(@Path) = LoweredPath AND ApplicationId = @ApplicationId
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Personalization_GetApplicationId]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Personalization_GetApplicationId] (
    @ApplicationName NVARCHAR(256),
    @ApplicationId UNIQUEIDENTIFIER OUT)
AS
BEGIN
    SELECT @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_DeleteAllState]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_DeleteAllState] (
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @Count int OUT)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        IF (@AllUsersScope = 1)
            DELETE FROM aspnet_PersonalizationAllUsers
            WHERE PathId IN
               (SELECT Paths.PathId
                FROM dbo.aspnet_Paths Paths
                WHERE Paths.ApplicationId = @ApplicationId)
        ELSE
            DELETE FROM aspnet_PersonalizationPerUser
            WHERE PathId IN
               (SELECT Paths.PathId
                FROM dbo.aspnet_Paths Paths
                WHERE Paths.ApplicationId = @ApplicationId)

        SELECT @Count = @@ROWCOUNT
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_FindState]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_FindState] (
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @PageIndex              INT,
    @PageSize               INT,
    @Path NVARCHAR(256) = NULL,
    @UserName NVARCHAR(256) = NULL,
    @InactiveSinceDate DATETIME = NULL)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        RETURN

    -- Set the page bounds
    DECLARE @PageLowerBound INT
    DECLARE @PageUpperBound INT
    DECLARE @TotalRecords   INT
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table to store the selected results
    CREATE TABLE #PageIndex (
        IndexId int IDENTITY (0, 1) NOT NULL,
        ItemId UNIQUEIDENTIFIER
    )

    IF (@AllUsersScope = 1)
    BEGIN
        -- Insert into our temp table
        INSERT INTO #PageIndex (ItemId)
        SELECT Paths.PathId
        FROM dbo.aspnet_Paths Paths,
             ((SELECT Paths.PathId
               FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
               WHERE Paths.ApplicationId = @ApplicationId
                      AND AllUsers.PathId = Paths.PathId
                      AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              ) AS SharedDataPerPath
              FULL OUTER JOIN
              (SELECT DISTINCT Paths.PathId
               FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Paths Paths
               WHERE Paths.ApplicationId = @ApplicationId
                      AND PerUser.PathId = Paths.PathId
                      AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              ) AS UserDataPerPath
              ON SharedDataPerPath.PathId = UserDataPerPath.PathId
             )
        WHERE Paths.PathId = SharedDataPerPath.PathId OR Paths.PathId = UserDataPerPath.PathId
        ORDER BY Paths.Path ASC

        SELECT @TotalRecords = @@ROWCOUNT

        SELECT Paths.Path,
               SharedDataPerPath.LastUpdatedDate,
               SharedDataPerPath.SharedDataLength,
               UserDataPerPath.UserDataLength,
               UserDataPerPath.UserCount
        FROM dbo.aspnet_Paths Paths,
             ((SELECT PageIndex.ItemId AS PathId,
                      AllUsers.LastUpdatedDate AS LastUpdatedDate,
                      DATALENGTH(AllUsers.PageSettings) AS SharedDataLength
               FROM dbo.aspnet_PersonalizationAllUsers AllUsers, #PageIndex PageIndex
               WHERE AllUsers.PathId = PageIndex.ItemId
                     AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
              ) AS SharedDataPerPath
              FULL OUTER JOIN
              (SELECT PageIndex.ItemId AS PathId,
                      SUM(DATALENGTH(PerUser.PageSettings)) AS UserDataLength,
                      COUNT(*) AS UserCount
               FROM aspnet_PersonalizationPerUser PerUser, #PageIndex PageIndex
               WHERE PerUser.PathId = PageIndex.ItemId
                     AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
               GROUP BY PageIndex.ItemId
              ) AS UserDataPerPath
              ON SharedDataPerPath.PathId = UserDataPerPath.PathId
             )
        WHERE Paths.PathId = SharedDataPerPath.PathId OR Paths.PathId = UserDataPerPath.PathId
        ORDER BY Paths.Path ASC
    END
    ELSE
    BEGIN
        -- Insert into our temp table
        INSERT INTO #PageIndex (ItemId)
        SELECT PerUser.Id
        FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
        WHERE Paths.ApplicationId = @ApplicationId
              AND PerUser.UserId = Users.UserId
              AND PerUser.PathId = Paths.PathId
              AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              AND (@UserName IS NULL OR Users.LoweredUserName LIKE LOWER(@UserName))
              AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
        ORDER BY Paths.Path ASC, Users.UserName ASC

        SELECT @TotalRecords = @@ROWCOUNT

        SELECT Paths.Path, PerUser.LastUpdatedDate, DATALENGTH(PerUser.PageSettings), Users.UserName, Users.LastActivityDate
        FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths, #PageIndex PageIndex
        WHERE PerUser.Id = PageIndex.ItemId
              AND PerUser.UserId = Users.UserId
              AND PerUser.PathId = Paths.PathId
              AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
        ORDER BY Paths.Path ASC, Users.UserName ASC
    END

    RETURN @TotalRecords
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_GetCountOfState]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_GetCountOfState] (
    @Count int OUT,
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @Path NVARCHAR(256) = NULL,
    @UserName NVARCHAR(256) = NULL,
    @InactiveSinceDate DATETIME = NULL)
AS
BEGIN

    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
        IF (@AllUsersScope = 1)
            SELECT @Count = COUNT(*)
            FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
            WHERE Paths.ApplicationId = @ApplicationId
                  AND AllUsers.PathId = Paths.PathId
                  AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
        ELSE
            SELECT @Count = COUNT(*)
            FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
            WHERE Paths.ApplicationId = @ApplicationId
                  AND PerUser.UserId = Users.UserId
                  AND PerUser.PathId = Paths.PathId
                  AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
                  AND (@UserName IS NULL OR Users.LoweredUserName LIKE LOWER(@UserName))
                  AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_ResetSharedState]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_ResetSharedState] (
    @Count int OUT,
    @ApplicationName NVARCHAR(256),
    @Path NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationAllUsers
        WHERE PathId IN
            (SELECT AllUsers.PathId
             FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
             WHERE Paths.ApplicationId = @ApplicationId
                   AND AllUsers.PathId = Paths.PathId
                   AND Paths.LoweredPath = LOWER(@Path))

        SELECT @Count = @@ROWCOUNT
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_ResetUserState]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_ResetUserState] (
    @Count                  int                 OUT,
    @ApplicationName        NVARCHAR(256),
    @InactiveSinceDate      DATETIME            = NULL,
    @UserName               NVARCHAR(256)       = NULL,
    @Path                   NVARCHAR(256)       = NULL)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationPerUser
        WHERE Id IN (SELECT PerUser.Id
                     FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
                     WHERE Paths.ApplicationId = @ApplicationId
                           AND PerUser.UserId = Users.UserId
                           AND PerUser.PathId = Paths.PathId
                           AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
                           AND (@UserName IS NULL OR Users.LoweredUserName = LOWER(@UserName))
                           AND (@Path IS NULL OR Paths.LoweredPath = LOWER(@Path)))

        SELECT @Count = @@ROWCOUNT
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_GetPageSettings]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_GetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path              NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT p.PageSettings FROM dbo.aspnet_PersonalizationAllUsers p WHERE p.PathId = @PathId
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path              NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    DELETE FROM dbo.aspnet_PersonalizationAllUsers WHERE PathId = @PathId
    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_SetPageSettings]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_SetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path             NVARCHAR(256),
    @PageSettings     IMAGE,
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT
    END

    IF (EXISTS(SELECT PathId FROM dbo.aspnet_PersonalizationAllUsers WHERE PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationAllUsers SET PageSettings = @PageSettings, LastUpdatedDate = @CurrentTimeUtc WHERE PathId = @PathId
    ELSE
        INSERT INTO dbo.aspnet_PersonalizationAllUsers(PathId, PageSettings, LastUpdatedDate) VALUES (@PathId, @PageSettings, @CurrentTimeUtc)
    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_GetPageSettings]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_GetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        RETURN
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    SELECT p.PageSettings FROM dbo.aspnet_PersonalizationPerUser p WHERE p.PathId = @PathId AND p.UserId = @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_ResetPageSettings]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_ResetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        RETURN
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    DELETE FROM dbo.aspnet_PersonalizationPerUser WHERE PathId = @PathId AND UserId = @UserId
    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_SetPageSettings]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_SetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @PageSettings     IMAGE,
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CurrentTimeUtc, @UserId OUTPUT
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    IF (EXISTS(SELECT PathId FROM dbo.aspnet_PersonalizationPerUser WHERE UserId = @UserId AND PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationPerUser SET PageSettings = @PageSettings, LastUpdatedDate = @CurrentTimeUtc WHERE UserId = @UserId AND PathId = @PathId
    ELSE
        INSERT INTO dbo.aspnet_PersonalizationPerUser(UserId, PathId, PageSettings, LastUpdatedDate) VALUES (@UserId, @PathId, @PageSettings, @CurrentTimeUtc)
    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_DeleteInactiveProfiles]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_DeleteInactiveProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @InactiveSinceDate      datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
    BEGIN
        SELECT  0
        RETURN
    END

    DELETE
    FROM    dbo.aspnet_Profile
    WHERE   UserId IN
            (   SELECT  UserId
                FROM    dbo.aspnet_Users u
                WHERE   ApplicationId = @ApplicationId
                        AND (LastActivityDate <= @InactiveSinceDate)
                        AND (
                                (@ProfileAuthOptions = 2)
                             OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                             OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
                            )
            )

    SELECT  @@ROWCOUNT
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_DeleteProfiles]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_DeleteProfiles]
    @ApplicationName        nvarchar(256),
    @UserNames              nvarchar(4000)
AS
BEGIN
    DECLARE @UserName     nvarchar(256)
    DECLARE @CurrentPos   int
    DECLARE @NextPos      int
    DECLARE @NumDeleted   int
    DECLARE @DeletedUser  int
    DECLARE @TranStarted  bit
    DECLARE @ErrorCode    int

    SET @ErrorCode = 0
    SET @CurrentPos = 1
    SET @NumDeleted = 0
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    WHILE (@CurrentPos <= LEN(@UserNames))
    BEGIN
        SELECT @NextPos = CHARINDEX(N',', @UserNames,  @CurrentPos)
        IF (@NextPos = 0 OR @NextPos IS NULL)
            SELECT @NextPos = LEN(@UserNames) + 1

        SELECT @UserName = SUBSTRING(@UserNames, @CurrentPos, @NextPos - @CurrentPos)
        SELECT @CurrentPos = @NextPos+1

        IF (LEN(@UserName) > 0)
        BEGIN
            SELECT @DeletedUser = 0
            EXEC dbo.aspnet_Users_DeleteUser @ApplicationName, @UserName, 4, @DeletedUser OUTPUT
            IF( @@ERROR <> 0 )
            BEGIN
                SET @ErrorCode = -1
                GOTO Cleanup
            END
            IF (@DeletedUser <> 0)
                SELECT @NumDeleted = @NumDeleted + 1
        END
    END
    SELECT @NumDeleted
    IF (@TranStarted = 1)
    BEGIN
    	SET @TranStarted = 0
    	COMMIT TRANSACTION
    END
    SET @TranStarted = 0

    RETURN 0

Cleanup:
    IF (@TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END
    RETURN @ErrorCode
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetNumberOfInactiveProfiles]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_GetNumberOfInactiveProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @InactiveSinceDate      datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
    BEGIN
        SELECT 0
        RETURN
    END

    SELECT  COUNT(*)
    FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p
    WHERE   ApplicationId = @ApplicationId
        AND u.UserId = p.UserId
        AND (LastActivityDate <= @InactiveSinceDate)
        AND (
                (@ProfileAuthOptions = 2)
                OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
            )
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetProfiles]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_GetProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @PageIndex              int,
    @PageSize               int,
    @UserNameToMatch        nvarchar(256) = NULL,
    @InactiveSinceDate      datetime      = NULL
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
        SELECT  u.UserId
        FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p
        WHERE   ApplicationId = @ApplicationId
            AND u.UserId = p.UserId
            AND (@InactiveSinceDate IS NULL OR LastActivityDate <= @InactiveSinceDate)
            AND (     (@ProfileAuthOptions = 2)
                   OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                   OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
                 )
            AND (@UserNameToMatch IS NULL OR LoweredUserName LIKE LOWER(@UserNameToMatch))
        ORDER BY UserName

    SELECT  u.UserName, u.IsAnonymous, u.LastActivityDate, p.LastUpdatedDate,
            DATALENGTH(p.PropertyNames) + DATALENGTH(p.PropertyValuesString) + DATALENGTH(p.PropertyValuesBinary)
    FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p, #PageIndexForUsers i
    WHERE   u.UserId = p.UserId AND p.UserId = i.UserId AND i.IndexId >= @PageLowerBound AND i.IndexId <= @PageUpperBound

    SELECT COUNT(*)
    FROM   #PageIndexForUsers

    DROP TABLE #PageIndexForUsers
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetProperties]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_GetProperties]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @CurrentTimeUtc       datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN

    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL

    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId AND LoweredUserName = LOWER(@UserName)

    IF (@UserId IS NULL)
        RETURN
    SELECT TOP 1 PropertyNames, PropertyValuesString, PropertyValuesBinary
    FROM         dbo.aspnet_Profile
    WHERE        UserId = @UserId

    IF (@@ROWCOUNT > 0)
    BEGIN
        UPDATE dbo.aspnet_Users
        SET    LastActivityDate=@CurrentTimeUtc
        WHERE  UserId = @UserId
    END
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_SetProperties]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_SetProperties]
    @ApplicationName        nvarchar(256),
    @PropertyNames          ntext,
    @PropertyValuesString   ntext,
    @PropertyValuesBinary   image,
    @UserName               nvarchar(256),
    @IsUserAnonymous        bit,
    @CurrentTimeUtc         datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
       BEGIN TRANSACTION
       SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    DECLARE @UserId uniqueidentifier
    DECLARE @LastActivityDate datetime
    SELECT  @UserId = NULL
    SELECT  @LastActivityDate = @CurrentTimeUtc

    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId AND LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
        EXEC dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, @IsUserAnonymous, @LastActivityDate, @UserId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    UPDATE dbo.aspnet_Users
    SET    LastActivityDate=@CurrentTimeUtc
    WHERE  UserId = @UserId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF (EXISTS( SELECT *
               FROM   dbo.aspnet_Profile
               WHERE  UserId = @UserId))
        UPDATE dbo.aspnet_Profile
        SET    PropertyNames=@PropertyNames, PropertyValuesString = @PropertyValuesString,
               PropertyValuesBinary = @PropertyValuesBinary, LastUpdatedDate=@CurrentTimeUtc
        WHERE  UserId = @UserId
    ELSE
        INSERT INTO dbo.aspnet_Profile(UserId, PropertyNames, PropertyValuesString, PropertyValuesBinary, LastUpdatedDate)
             VALUES (@UserId, @PropertyNames, @PropertyValuesString, @PropertyValuesBinary, @CurrentTimeUtc)

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
    	SET @TranStarted = 0
    	COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_RegisterSchemaVersion]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_RegisterSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128),
    @IsCurrentVersion          bit,
    @RemoveIncompatibleSchema  bit
AS
BEGIN
    IF( @RemoveIncompatibleSchema = 1 )
    BEGIN
        DELETE FROM dbo.aspnet_SchemaVersions WHERE Feature = LOWER( @Feature )
    END
    ELSE
    BEGIN
        IF( @IsCurrentVersion = 1 )
        BEGIN
            UPDATE dbo.aspnet_SchemaVersions
            SET IsCurrentVersion = 0
            WHERE Feature = LOWER( @Feature )
        END
    END

    INSERT  dbo.aspnet_SchemaVersions( Feature, CompatibleSchemaVersion, IsCurrentVersion )
    VALUES( LOWER( @Feature ), @CompatibleSchemaVersion, @IsCurrentVersion )
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_CreateRole]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Roles_CreateRole]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
        SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF (EXISTS(SELECT RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId))
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    INSERT INTO dbo.aspnet_Roles
                (ApplicationId, RoleName, LoweredRoleName)
         VALUES (@ApplicationId, @RoleName, LOWER(@RoleName))

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        COMMIT TRANSACTION
    END

    RETURN(0)

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_DeleteRole]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Roles_DeleteRole]
    @ApplicationName            nvarchar(256),
    @RoleName                   nvarchar(256),
    @DeleteOnlyIfRoleIsEmpty    bit
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
        SET @TranStarted = 0

    DECLARE @RoleId   uniqueidentifier
    SELECT  @RoleId = NULL
    SELECT  @RoleId = RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
    BEGIN
        SELECT @ErrorCode = 1
        GOTO Cleanup
    END
    IF (@DeleteOnlyIfRoleIsEmpty <> 0)
    BEGIN
        IF (EXISTS (SELECT RoleId FROM dbo.aspnet_UsersInRoles  WHERE @RoleId = RoleId))
        BEGIN
            SELECT @ErrorCode = 2
            GOTO Cleanup
        END
    END


    DELETE FROM dbo.aspnet_UsersInRoles  WHERE @RoleId = RoleId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    DELETE FROM dbo.aspnet_Roles WHERE @RoleId = RoleId  AND ApplicationId = @ApplicationId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        COMMIT TRANSACTION
    END

    RETURN(0)

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_GetAllRoles]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Roles_GetAllRoles] (
    @ApplicationName           nvarchar(256))
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN
    SELECT RoleName
    FROM   dbo.aspnet_Roles WHERE ApplicationId = @ApplicationId
    ORDER BY RoleName
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_RoleExists]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Roles_RoleExists]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(0)
    IF (EXISTS (SELECT RoleName FROM dbo.aspnet_Roles WHERE LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId ))
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Setup_RemoveAllRoleMembers]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Setup_RemoveAllRoleMembers]
    @name   sysname
AS
BEGIN
    CREATE TABLE #aspnet_RoleMembers
    (
        Group_name      sysname,
        Group_id        smallint,
        Users_in_group  sysname,
        User_id         smallint
    )

    INSERT INTO #aspnet_RoleMembers
    EXEC sp_helpuser @name

    DECLARE @user_id smallint
    DECLARE @cmd nvarchar(500)
    DECLARE c1 cursor FORWARD_ONLY FOR
        SELECT User_id FROM #aspnet_RoleMembers

    OPEN c1

    FETCH c1 INTO @user_id
    WHILE (@@fetch_status = 0)
    BEGIN
        SET @cmd = 'EXEC sp_droprolemember ' + '''' + @name + ''', ''' + USER_NAME(@user_id) + ''''
        EXEC (@cmd)
        FETCH c1 INTO @user_id
    END

    CLOSE c1
    DEALLOCATE c1
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Setup_RestorePermissions]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Setup_RestorePermissions]
    @name   sysname
AS
BEGIN
    DECLARE @object sysname
    DECLARE @protectType char(10)
    DECLARE @action varchar(60)
    DECLARE @grantee sysname
    DECLARE @cmd nvarchar(500)
    DECLARE c1 cursor FORWARD_ONLY FOR
        SELECT Object, ProtectType, [Action], Grantee FROM #aspnet_Permissions where Object = @name

    OPEN c1

    FETCH c1 INTO @object, @protectType, @action, @grantee
    WHILE (@@fetch_status = 0)
    BEGIN
        SET @cmd = @protectType + ' ' + @action + ' on ' + @object + ' TO [' + @grantee + ']'
        EXEC (@cmd)
        FETCH c1 INTO @object, @protectType, @action, @grantee
    END

    CLOSE c1
    DEALLOCATE c1
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UnRegisterSchemaVersion]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UnRegisterSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    DELETE FROM dbo.aspnet_SchemaVersions
        WHERE   Feature = LOWER(@Feature) AND @CompatibleSchemaVersion = CompatibleSchemaVersion
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Users_CreateUser]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Users_CreateUser]
    @ApplicationId    uniqueidentifier,
    @UserName         nvarchar(256),
    @IsUserAnonymous  bit,
    @LastActivityDate DATETIME,
    @UserId           uniqueidentifier OUTPUT
AS
BEGIN
    IF( @UserId IS NULL )
        SELECT @UserId = NEWID()
    ELSE
    BEGIN
        IF( EXISTS( SELECT UserId FROM dbo.aspnet_Users
                    WHERE @UserId = UserId ) )
            RETURN -1
    END

    INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
    VALUES (@ApplicationId, @UserId, @UserName, LOWER(@UserName), @IsUserAnonymous, @LastActivityDate)

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_Users_DeleteUser]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Users_DeleteUser]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @TablesToDeleteFrom int,
    @NumTablesDeletedFrom int OUTPUT
AS
BEGIN
    DECLARE @UserId               uniqueidentifier
    SELECT  @UserId               = NULL
    SELECT  @NumTablesDeletedFrom = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
	SET @TranStarted = 0

    DECLARE @ErrorCode   int
    DECLARE @RowCount    int

    SET @ErrorCode = 0
    SET @RowCount  = 0

    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a
    WHERE   u.LoweredUserName       = LOWER(@UserName)
        AND u.ApplicationId         = a.ApplicationId
        AND LOWER(@ApplicationName) = a.LoweredApplicationName

    IF (@UserId IS NULL)
    BEGIN
        GOTO Cleanup
    END

    -- Delete from Membership table if (@TablesToDeleteFrom & 1) is set
    IF ((@TablesToDeleteFrom & 1) <> 0 AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_MembershipUsers') AND (type = 'V'))))
    BEGIN
        DELETE FROM dbo.aspnet_Membership WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
               @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_UsersInRoles table if (@TablesToDeleteFrom & 2) is set
    IF ((@TablesToDeleteFrom & 2) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_UsersInRoles') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_UsersInRoles WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_Profile table if (@TablesToDeleteFrom & 4) is set
    IF ((@TablesToDeleteFrom & 4) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Profiles') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_Profile WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_PersonalizationPerUser table if (@TablesToDeleteFrom & 8) is set
    IF ((@TablesToDeleteFrom & 8) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_WebPartState_User') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationPerUser WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_Users table if (@TablesToDeleteFrom & 1,2,4 & 8) are all set
    IF ((@TablesToDeleteFrom & 1) <> 0 AND
        (@TablesToDeleteFrom & 2) <> 0 AND
        (@TablesToDeleteFrom & 4) <> 0 AND
        (@TablesToDeleteFrom & 8) <> 0 AND
        (EXISTS (SELECT UserId FROM dbo.aspnet_Users WHERE @UserId = UserId)))
    BEGIN
        DELETE FROM dbo.aspnet_Users WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:
    SET @NumTablesDeletedFrom = 0

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
	    ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_AddUsersToRoles]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_AddUsersToRoles]
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000),
	@CurrentTimeUtc   datetime
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)
	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames	table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles	table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers	table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num		int
	DECLARE @Pos		int
	DECLARE @NextPos	int
	DECLARE @Name		nvarchar(256)

	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		SELECT TOP 1 Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END

	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1

	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		DELETE FROM @tbNames
		WHERE LOWER(Name) IN (SELECT LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE au.UserId = u.UserId)

		INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
		  SELECT @AppId, NEWID(), Name, LOWER(Name), 0, @CurrentTimeUtc
		  FROM   @tbNames

		INSERT INTO @tbUsers
		  SELECT  UserId
		  FROM	dbo.aspnet_Users au, @tbNames t
		  WHERE   LOWER(t.Name) = au.LoweredUserName AND au.ApplicationId = @AppId
	END

	IF (EXISTS (SELECT * FROM dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr WHERE tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId))
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr, aspnet_Users u, aspnet_Roles r
		WHERE		u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	INSERT INTO dbo.aspnet_UsersInRoles (UserId, RoleId)
	SELECT UserId, RoleId
	FROM @tbUsers, @tbRoles

	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_FindUsersInRole]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_FindUsersInRole]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256),
    @UserNameToMatch  nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
     DECLARE @RoleId uniqueidentifier
     SELECT  @RoleId = NULL

     SELECT  @RoleId = RoleId
     FROM    dbo.aspnet_Roles
     WHERE   LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId

     IF (@RoleId IS NULL)
         RETURN(1)

    SELECT u.UserName
    FROM   dbo.aspnet_Users u, dbo.aspnet_UsersInRoles ur
    WHERE  u.UserId = ur.UserId AND @RoleId = ur.RoleId AND u.ApplicationId = @ApplicationId AND LoweredUserName LIKE LOWER(@UserNameToMatch)
    ORDER BY u.UserName
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_GetRolesForUser]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetRolesForUser]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        RETURN(1)

    SELECT r.RoleName
    FROM   dbo.aspnet_Roles r, dbo.aspnet_UsersInRoles ur
    WHERE  r.RoleId = ur.RoleId AND r.ApplicationId = @ApplicationId AND ur.UserId = @UserId
    ORDER BY r.RoleName
    RETURN (0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_GetUsersInRoles]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetUsersInRoles]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
     DECLARE @RoleId uniqueidentifier
     SELECT  @RoleId = NULL

     SELECT  @RoleId = RoleId
     FROM    dbo.aspnet_Roles
     WHERE   LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId

     IF (@RoleId IS NULL)
         RETURN(1)

    SELECT u.UserName
    FROM   dbo.aspnet_Users u, dbo.aspnet_UsersInRoles ur
    WHERE  u.UserId = ur.UserId AND @RoleId = ur.RoleId AND u.ApplicationId = @ApplicationId
    ORDER BY u.UserName
    RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_IsUserInRole]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_IsUserInRole]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(2)
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    DECLARE @RoleId uniqueidentifier
    SELECT  @RoleId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        RETURN(2)

    SELECT  @RoleId = RoleId
    FROM    dbo.aspnet_Roles
    WHERE   LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
        RETURN(3)

    IF (EXISTS( SELECT * FROM dbo.aspnet_UsersInRoles WHERE  UserId = @UserId AND RoleId = @RoleId))
        RETURN(1)
    ELSE
        RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles]
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000)
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)


	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames  table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles  table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers  table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num	  int
	DECLARE @Pos	  int
	DECLARE @NextPos  int
	DECLARE @Name	  nvarchar(256)
	DECLARE @CountAll int
	DECLARE @CountU	  int
	DECLARE @CountR	  int


	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId
	SELECT @CountR = @@ROWCOUNT

	IF (@CountR <> @Num)
	BEGIN
		SELECT TOP 1 N'', Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END


	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1


	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	SELECT @CountU = @@ROWCOUNT
	IF (@CountU <> @Num)
	BEGIN
		SELECT TOP 1 Name, N''
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT au.LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE u.UserId = au.UserId)

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(1)
	END

	SELECT  @CountAll = COUNT(*)
	FROM	dbo.aspnet_UsersInRoles ur, @tbUsers u, @tbRoles r
	WHERE   ur.UserId = u.UserId AND ur.RoleId = r.RoleId

	IF (@CountAll <> @CountU * @CountR)
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 @tbUsers tu, @tbRoles tr, dbo.aspnet_Users u, dbo.aspnet_Roles r
		WHERE		 u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND
					 tu.UserId NOT IN (SELECT ur.UserId FROM dbo.aspnet_UsersInRoles ur WHERE ur.RoleId = tr.RoleId) AND
					 tr.RoleId NOT IN (SELECT ur.RoleId FROM dbo.aspnet_UsersInRoles ur WHERE ur.UserId = tu.UserId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	DELETE FROM dbo.aspnet_UsersInRoles
	WHERE UserId IN (SELECT UserId FROM @tbUsers)
	  AND RoleId IN (SELECT RoleId FROM @tbRoles)
	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
GO
/****** Object:  StoredProcedure [dbo].[aspnet_WebEvent_LogEvent]    Script Date: 13.07.2022 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_WebEvent_LogEvent]
        @EventId         char(32),
        @EventTimeUtc    datetime,
        @EventTime       datetime,
        @EventType       nvarchar(256),
        @EventSequence   decimal(19,0),
        @EventOccurrence decimal(19,0),
        @EventCode       int,
        @EventDetailCode int,
        @Message         nvarchar(1024),
        @ApplicationPath nvarchar(256),
        @ApplicationVirtualPath nvarchar(256),
        @MachineName    nvarchar(256),
        @RequestUrl      nvarchar(1024),
        @ExceptionType   nvarchar(256),
        @Details         ntext
AS
BEGIN
    INSERT
        dbo.aspnet_WebEvent_Events
        (
            EventId,
            EventTimeUtc,
            EventTime,
            EventType,
            EventSequence,
            EventOccurrence,
            EventCode,
            EventDetailCode,
            Message,
            ApplicationPath,
            ApplicationVirtualPath,
            MachineName,
            RequestUrl,
            ExceptionType,
            Details
        )
    VALUES
    (
        @EventId,
        @EventTimeUtc,
        @EventTime,
        @EventType,
        @EventSequence,
        @EventOccurrence,
        @EventCode,
        @EventDetailCode,
        @Message,
        @ApplicationPath,
        @ApplicationVirtualPath,
        @MachineName,
        @RequestUrl,
        @ExceptionType,
        @Details
    )
END
GO
USE [master]
GO
ALTER DATABASE [BorsaDB] SET  READ_WRITE 
GO
