USE [master]
GO
/****** Object:  Database [EMPZensar]    Script Date: 02-11-2019 15:56:56 ******/
CREATE DATABASE [EMPZensar]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EMPZensar', FILENAME = N'D:\nilesh\SQL Server\EMPZensar.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EMPZensar_log', FILENAME = N'D:\nilesh\SQL Server\EMPZensar_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EMPZensar] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EMPZensar].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EMPZensar] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EMPZensar] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EMPZensar] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EMPZensar] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EMPZensar] SET ARITHABORT OFF 
GO
ALTER DATABASE [EMPZensar] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EMPZensar] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EMPZensar] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EMPZensar] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EMPZensar] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EMPZensar] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EMPZensar] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EMPZensar] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EMPZensar] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EMPZensar] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EMPZensar] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EMPZensar] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EMPZensar] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EMPZensar] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EMPZensar] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EMPZensar] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EMPZensar] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EMPZensar] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EMPZensar] SET RECOVERY FULL 
GO
ALTER DATABASE [EMPZensar] SET  MULTI_USER 
GO
ALTER DATABASE [EMPZensar] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EMPZensar] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EMPZensar] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EMPZensar] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EMPZensar]
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteEmployee]
	-- Add the parameters for the stored procedure here
@EmpCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from EmpMaster where EmpCode=@EmpCode                                                                  
END
GO
/****** Object:  StoredProcedure [dbo].[GetSalSheets]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetSalSheets]
@EmpCode int
as
begin
	select * from SalaryInfo where EmpCode=@EmpCode
end
GO
/****** Object:  StoredProcedure [dbo].[SaveEmployee]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nilesh
-- Create date: 22-Oct-2019
-- Description:	To Save Employee Information
-- =============================================
CREATE PROCEDURE [dbo].[SaveEmployee]
	-- Add the parameters for the stored procedure here
@EmpCode int,
@EmpName nvarchar(50),
@EmpDob datetime,
@EmpGender nvarchar(10),
@EmpDepartment nvarchar(50),
@EmpDesignation nvarchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into EmpMaster values(@EmpCode,@EmpName,@EmpDob,@EmpGender,@EmpDepartment,@EmpDesignation)                                                                  
END

GO
/****** Object:  StoredProcedure [dbo].[SaveSalary]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nilesh
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveSalary]
	-- Add the parameters for the stored procedure here
@EmpCode int,
@DateOfSalary Datetime,
@Basic numeric(10,0),
@Hra numeric(10,0),
@Da numeric(10,0),
@SalarySheetNo int output

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into SalaryInfo values(@EmpCode,@DateOfSalary,@Basic,@Hra,@Da)
	set @SalarySheetNo=SCOPE_IDENTITY() 
END

GO
/****** Object:  StoredProcedure [dbo].[TotalBasicSalary]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TotalBasicSalary]
	-- Add the parameters for the stored procedure here
@EmpCode int,
@TotalBasic int output

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select @TotalBasic= sum(Basic) from SalaryInfo where EmpCode=@EmpCode;
	return @TotalBasic
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEmployee]
	-- Add the parameters for the stored procedure here
@EmpCode int,
@EmpName nvarchar(50),
@EmpDob datetime,
@EmpGender nvarchar(10),
@EmpDepartment nvarchar(50),
@EmpDesignation nvarchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update EmpMaster set EmpName=@EmpName,EmpDob=@EmpDob,EmpGender=@EmpGender,
	EmpDepartment=@EmpDepartment,EmpDesignation=@EmpDesignation
	where EmpCode=@EmpCode                                                                  
END
GO
/****** Object:  StoredProcedure [dbo].[ViewAllEmployees]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ViewAllEmployees]
as
begin
	select * from EmpMaster;
end
GO
/****** Object:  StoredProcedure [dbo].[ViewEmployee]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ViewEmployee]
	-- Add the parameters for the stored procedure here
@EmpCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from EmpMaster where EmpCode=@EmpCode                                                                  
END
GO
/****** Object:  Table [dbo].[DepartmentMaster]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentMaster](
	[EmpDepartment] [nvarchar](50) NOT NULL,
	[EmpDesignation] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DepartmentMaster] PRIMARY KEY CLUSTERED 
(
	[EmpDepartment] ASC,
	[EmpDesignation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmpMaster]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpMaster](
	[EmpCode] [int] NOT NULL,
	[EmpName] [nvarchar](50) NOT NULL,
	[EmpDob] [datetime] NOT NULL,
	[EmpGender] [nvarchar](50) NOT NULL,
	[EmpDepartment] [nvarchar](50) NOT NULL,
	[EmpDesignation] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_EmpMaster] PRIMARY KEY CLUSTERED 
(
	[EmpCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SalaryInfo]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryInfo](
	[SalarySheetNo] [int] IDENTITY(1,1) NOT NULL,
	[EmpCode] [int] NOT NULL,
	[DateOfSalary] [datetime] NOT NULL,
	[Basic] [numeric](10, 0) NOT NULL,
	[Hra] [numeric](10, 0) NULL,
	[Da] [numeric](10, 0) NULL,
	[NetSalary]  AS (([Basic]+[Hra])+[Da]),
 CONSTRAINT [PK_SalaryInfo] PRIMARY KEY CLUSTERED 
(
	[SalarySheetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 02-11-2019 15:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserName] [nvarchar](30) NOT NULL,
	[Password] [nvarchar](20) NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[EmpMaster]  WITH CHECK ADD  CONSTRAINT [FK_EmpMaster_DepartmentMaster] FOREIGN KEY([EmpDepartment], [EmpDesignation])
REFERENCES [dbo].[DepartmentMaster] ([EmpDepartment], [EmpDesignation])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmpMaster] CHECK CONSTRAINT [FK_EmpMaster_DepartmentMaster]
GO
ALTER TABLE [dbo].[SalaryInfo]  WITH CHECK ADD  CONSTRAINT [FK_SalaryInfo_EmpMaster] FOREIGN KEY([EmpCode])
REFERENCES [dbo].[EmpMaster] ([EmpCode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SalaryInfo] CHECK CONSTRAINT [FK_SalaryInfo_EmpMaster]
GO
USE [master]
GO
ALTER DATABASE [EMPZensar] SET  READ_WRITE 
GO
