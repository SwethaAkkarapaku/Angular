USE [master]
GO
/****** Object:  Database [TaskManager]    Script Date: 5/3/2025 2:06:36 PM ******/
CREATE DATABASE [TaskManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaskManager', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TaskManager.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TaskManager_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TaskManager_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TaskManager] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaskManager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaskManager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaskManager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaskManager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaskManager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaskManager] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaskManager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TaskManager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaskManager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaskManager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaskManager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaskManager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaskManager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaskManager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaskManager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaskManager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TaskManager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaskManager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaskManager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaskManager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaskManager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaskManager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TaskManager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaskManager] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TaskManager] SET  MULTI_USER 
GO
ALTER DATABASE [TaskManager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaskManager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaskManager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaskManager] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TaskManager] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TaskManager] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TaskManager] SET QUERY_STORE = ON
GO
ALTER DATABASE [TaskManager] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TaskManager]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](200) NOT NULL,
	[ParentTaskId] [int] NOT NULL,
	[TaskDescription] [text] NULL,
	[CommentBy] [int] NOT NULL,
	[CommentDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[ProjId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Description] [text] NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectMember]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectMember](
	[MemberId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ProjId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_User_Project] UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[ProjId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[TaskTitle] [varchar](100) NOT NULL,
	[Description] [text] NULL,
	[AssignedTo] [int] NOT NULL,
	[TaskType] [varchar](20) NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[TaskStatusId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskTypeMaster]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskTypeMaster](
	[TaskTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TaskTypeName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TaskTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[TaskTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[RoleId] [int] NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [varchar](10) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT (getdate()) FOR [CommentDate]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([CommentBy])
REFERENCES [dbo].[ProjectMember] ([MemberId])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([ParentTaskId])
REFERENCES [dbo].[Task] ([TaskId])
GO
ALTER TABLE [dbo].[ProjectMember]  WITH CHECK ADD FOREIGN KEY([ProjId])
REFERENCES [dbo].[Project] ([ProjId])
GO
ALTER TABLE [dbo].[ProjectMember]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInfo] ([UserId])
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD FOREIGN KEY([AssignedTo])
REFERENCES [dbo].[ProjectMember] ([MemberId])
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD FOREIGN KEY([TaskStatusId])
REFERENCES [dbo].[TaskTypeMaster] ([TaskTypeId])
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [task_project_fk] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjId])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [task_project_fk]
GO
ALTER TABLE [dbo].[UserInfo]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD CHECK  (([RoleName]='QA' OR [RoleName]='Developer' OR [RoleName]='Project Manager' OR [RoleName]='Site Admin'))
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD CHECK  (([TaskType]='New Feature' OR [TaskType]='Bug'))
GO
ALTER TABLE [dbo].[TaskTypeMaster]  WITH CHECK ADD CHECK  (([TaskTypeName]='CLOSED' OR [TaskTypeName]='RESOLVED' OR [TaskTypeName]='INPROGRESS' OR [TaskTypeName]='OPEN'))
GO
/****** Object:  StoredProcedure [dbo].[addnewuser]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[addnewuser]
@uname VARCHAR(100),
@email VARCHAR(100),
@upass VARCHAR(10),
@roleid INT, 
@phone VARCHAR(15)
as
insert into UserInfo(UserName, RoleId, Email, [Password], Phone)
values(@uname, @roleid, @email, @upass, @phone); -- QA
GO
/****** Object:  StoredProcedure [dbo].[addproject]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[addproject]
@Title VARCHAR(100),
@Description TEXT,
@StartDate DATE,
@EndDate DATE,
@PM int
as
begin
declare @new_projid bigint=0
	begin transaction
	begin try
	if not exists(select *from UserInfo where UserId=@PM and RoleId=2)
		throw 5001,'user is not in pm role',1
		insert into Project(Title, Description, StartDate, EndDate) values(@Title,@Description,@StartDate,@EndDate)
			set @new_projid=SCOPE_IDENTITY()
			print @new_projid
		INSERT INTO ProjectMember (UserId, ProjId) values(@PM, @new_projid)
		commit transaction
	end try
	begin catch
		rollback transaction
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[addprojectmember]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[addprojectmember]
@UserId INT,
@ProjId INT
as
begin
	if not exists (select *from UserInfo where UserId=@UserId and RoleId=2)
	insert into ProjectMember(UserId, ProjId)
	values(@UserId,@ProjId)
end
GO
/****** Object:  StoredProcedure [dbo].[addtask]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[addtask]
@TaskTitle VARCHAR(100),
@Description TEXT,
@AssignedTo INT,
@TaskType VARCHAR(20),
@StartDate DATE,
@EndDate DATE,
@TaskStatusId INT,
@ProjectId INT
as
begin
	insert into Task([TaskTitle], [Description], [AssignedTo], [TaskType], [StartDate], [EndDate], [TaskStatusId],[ProjectId]) 
	VALUES(@TaskTitle, @Description, @AssignedTo, @TaskType, @StartDate, @EndDate, @TaskStatusId,@ProjectId)
end
GO
/****** Object:  StoredProcedure [dbo].[getallroles]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getallroles]
as
begin
select *from Roles
end
GO
/****** Object:  StoredProcedure [dbo].[getallusers]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getallusers]
as
select u.*,r.RoleName from UserInfo u
join Roles r on u.RoleId=r.RoleId
GO
/****** Object:  StoredProcedure [dbo].[getpms]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getpms]
as
select *from UserInfo
where RoleId=2
GO
/****** Object:  StoredProcedure [dbo].[getproject]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getproject]
@ProjId INT
as
select ui.*, rol.* from ProjectMember projm
join Project pr on projm.ProjId=pr.ProjId
join UserInfo ui on projm.UserId=ui.UserId
join Roles rol on ui.RoleId=rol.RoleId
where projm.ProjId=@ProjId
GO
/****** Object:  StoredProcedure [dbo].[getuserbyemail]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getuserbyemail]
@email VARCHAR(100)
as
select * from UserInfo
where Email=@email
GO
/****** Object:  StoredProcedure [dbo].[getusersbyrole]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getusersbyrole]
@RoleName VARCHAR(50)
as
select *from UserInfo u
join Roles r on u.RoleId=r.RoleId
where r.RoleName=@RoleName
GO
/****** Object:  StoredProcedure [dbo].[removeprojectmember]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[removeprojectmember]
@MemberId INT
as
begin
	if not exists(
	select 1 from ProjectMember pmem
	join UserInfo ui on pmem.UserId=ui.UserId
	where ui.RoleId=2 and pmem.MemberId=@MemberId
	)
	delete from ProjectMember
	where MemberId=@MemberId
	else
		throw 50003,'pm cannot delete',1
end
GO
/****** Object:  StoredProcedure [dbo].[validateuser]    Script Date: 5/3/2025 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[validateuser]
@uemail VARCHAR(100),
@upass VARCHAR(10)
as
select *from UserInfo
where Email=@uemail and Password=@upass
GO
USE [master]
GO
ALTER DATABASE [TaskManager] SET  READ_WRITE 
GO
