USE [master]
GO
/****** Object:  Database [DBSchool]    Script Date: 02-11-2019 15:55:59 ******/
CREATE DATABASE [DBSchool]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBSchool', FILENAME = N'D:\nilesh\EntityFramework\DBSchool.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DBSchool_log', FILENAME = N'D:\nilesh\EntityFramework\DBSchool_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DBSchool] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBSchool].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBSchool] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBSchool] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBSchool] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBSchool] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBSchool] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBSchool] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBSchool] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DBSchool] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBSchool] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBSchool] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBSchool] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBSchool] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBSchool] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBSchool] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBSchool] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBSchool] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DBSchool] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBSchool] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBSchool] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBSchool] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBSchool] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBSchool] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBSchool] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBSchool] SET RECOVERY FULL 
GO
ALTER DATABASE [DBSchool] SET  MULTI_USER 
GO
ALTER DATABASE [DBSchool] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBSchool] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBSchool] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBSchool] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [DBSchool]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentById]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetStudentById]
	-- Add the parameters for the stored procedure here
	@StudentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Student where StudentId=@StudentId
END

GO
/****** Object:  StoredProcedure [dbo].[SaveStandard]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveStandard]
	-- Add the parameters for the stored procedure here
@StandardId int,
@StandardName nvarchar(50),
@Description nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Standard values(@StandardId,@StandardName,@Description)
END

GO
/****** Object:  StoredProcedure [dbo].[SaveStudent]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveStudent] 
	-- Add the parameters for the stored procedure here
@StudentId int,
@StudentName nvarchar(50),
@StandardId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Student values(@StudentId,@StudentName,@StandardId)
END

GO
/****** Object:  StoredProcedure [dbo].[SaveStudentAddress]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveStudentAddress]
	-- Add the parameters for the stored procedure here
@StudentId int,
@Address1 nvarchar(50),
@Address2 nvarchar(50),
@City nvarchar(50),
@State nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into StudentAddress values(@StudentId,@Address1,@Address2,@City,@State)
END

GO
/****** Object:  Table [dbo].[Course]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] NOT NULL,
	[CourseName] [nvarchar](50) NOT NULL,
	[Location] [nvarchar](50) NOT NULL,
	[TeacherId] [int] NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Standard]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Standard](
	[StandardId] [int] NOT NULL,
	[StandardName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Standard] PRIMARY KEY CLUSTERED 
(
	[StandardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentId] [int] NOT NULL,
	[StudentName] [nvarchar](50) NOT NULL,
	[StandardId] [int] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentAddress]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAddress](
	[StudentId] [int] NOT NULL,
	[Address1] [nvarchar](50) NOT NULL,
	[Address2] [nvarchar](50) NULL,
	[City] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[TeacherId] [int] NOT NULL,
	[TeacherName] [nvarchar](50) NOT NULL,
	[StandardId] [int] NOT NULL,
	[TeacherType] [int] NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[TeacherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[StudentView]    Script Date: 02-11-2019 15:55:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentView]
AS
SELECT        dbo.Student.StudentId, dbo.Student.StudentName, dbo.StudentAddress.Address1, dbo.StudentAddress.Address2, dbo.StudentAddress.City, dbo.StudentAddress.State
FROM            dbo.Student INNER JOIN
                         dbo.StudentAddress ON dbo.Student.StudentId = dbo.StudentAddress.StudentId

GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teacher] ([TeacherId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Teacher]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Standard] FOREIGN KEY([StandardId])
REFERENCES [dbo].[Standard] ([StandardId])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Standard]
GO
ALTER TABLE [dbo].[StudentAddress]  WITH CHECK ADD  CONSTRAINT [FK_StudentAddress_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([StudentId])
GO
ALTER TABLE [dbo].[StudentAddress] CHECK CONSTRAINT [FK_StudentAddress_Student]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Standard] FOREIGN KEY([StandardId])
REFERENCES [dbo].[Standard] ([StandardId])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_Standard]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Student"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StudentAddress"
            Begin Extent = 
               Top = 6
               Left = 371
               Bottom = 136
               Right = 541
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StudentView'
GO
USE [master]
GO
ALTER DATABASE [DBSchool] SET  READ_WRITE 
GO
