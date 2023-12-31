USE [master]
GO
/****** Object:  Database [starAR]    Script Date: 9/16/2017 11:02:28 PM ******/
CREATE DATABASE [starAR] ON  PRIMARY 
( NAME = N'starAR', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\starAR.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'starAR_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\starAR_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [starAR] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [starAR].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [starAR] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [starAR] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [starAR] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [starAR] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [starAR] SET ARITHABORT OFF 
GO
ALTER DATABASE [starAR] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [starAR] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [starAR] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [starAR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [starAR] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [starAR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [starAR] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [starAR] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [starAR] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [starAR] SET  DISABLE_BROKER 
GO
ALTER DATABASE [starAR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [starAR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [starAR] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [starAR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [starAR] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [starAR] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [starAR] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [starAR] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [starAR] SET  MULTI_USER 
GO
ALTER DATABASE [starAR] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [starAR] SET DB_CHAINING OFF 
GO
USE [starAR]
GO
/****** Object:  User [starAR]    Script Date: 9/16/2017 11:02:28 PM ******/
CREATE USER [starAR] FOR LOGIN [starAR] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[advertisement]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[advertisement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[master] [nvarchar](50) NULL,
	[period_start] [nvarchar](50) NULL,
	[period_end] [nvarchar](50) NULL,
	[unlimited] [int] NULL,
	[imageurl] [text] NULL,
	[type] [int] NULL,
	[xml] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[albums]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[albums](
	[album_id] [varchar](50) NOT NULL,
	[studio_id] [varchar](50) NOT NULL,
	[create_date] [datetime] NOT NULL,
	[del] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[captures]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[captures](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[url1] [nvarchar](255) NOT NULL,
	[url2] [nvarchar](255) NOT NULL,
	[url3] [nvarchar](255) NOT NULL,
	[url4] [nvarchar](255) NOT NULL,
	[url5] [nvarchar](255) NOT NULL,
	[btn_url] [nvarchar](255) NOT NULL,
	[depth] [int] NOT NULL,
	[type] [tinyint] NOT NULL,
	[prev_count] [tinyint] NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[chromakeys]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chromakeys](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[type] [tinyint] NOT NULL,
	[run_opt] [tinyint] NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [tinyint] NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[configs]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[configs](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[cf_title] [nvarchar](255) NOT NULL,
	[cf_member_join] [tinyint] NOT NULL CONSTRAINT [DF_configs_cf_member_join]  DEFAULT ((0)),
	[cf_auto_delete] [int] NOT NULL CONSTRAINT [DF_configs_cf_auto_delete]  DEFAULT ((0)),
	[cf_page_rows] [int] NOT NULL CONSTRAINT [DF_configs_cf_page_rows]  DEFAULT ((0)),
	[cf_login_minutes] [int] NOT NULL CONSTRAINT [DF_configs_cf_login_minutes]  DEFAULT ((0)),
	[cf_intercept_ip] [ntext] NULL,
	[cf_prohibit_id] [ntext] NOT NULL,
	[cf_stipulation] [ntext] NULL,
	[cf_privacy] [ntext] NULL,
	[cf_quicknotice] [ntext] NULL,
	[cf_noticepad] [ntext] NULL,
	[cf_logincount_time] [bigint] NOT NULL CONSTRAINT [DF_configs_cf_logincount_time]  DEFAULT ((0)),
 CONSTRAINT [PK_configs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[contents]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contents](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[project_id] [bigint] NOT NULL,
	[userid] [bigint] NOT NULL,
	[title] [nvarchar](255) NULL,
	[marker_url] [nvarchar](255) NULL,
	[xml] [ntext] NULL,
	[server_id] [nvarchar](255) NULL,
	[api_requests] [int] NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NULL,
	[changedate] [datetime] NULL,
	[description] [nvarchar](255) NULL,
	[is_board] [tinyint] NULL,
	[studio_id] [varchar](50) NULL,
	[album_id] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contentsusehist]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contentsusehist](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[userid] [bigint] NOT NULL,
	[contentid] [bigint] NOT NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[eventlogs]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eventlogs](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[userid] [bigint] NOT NULL,
	[user_ip] [nvarchar](50) NOT NULL,
	[event] [nvarchar](50) NOT NULL,
	[regdate] [datetime] NOT NULL CONSTRAINT [DF_eventlogs_regdate]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[googlemaps]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[googlemaps](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [int] NOT NULL,
	[coordinate] [nvarchar](50) NOT NULL,
	[type] [tinyint] NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL,
	[color] [nvarchar](50) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[color_index] [tinyint] NOT NULL,
	[mode_index] [tinyint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[images]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[images](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[type] [tinyint] NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [int] NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[importants]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[importants](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[xpos] [int] NOT NULL,
	[ypos] [int] NOT NULL,
	[width] [int] NOT NULL,
	[height] [int] NOT NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[logins]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logins](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[user_ip] [nvarchar](50) NOT NULL,
	[url] [nvarchar](255) NULL,
	[agent] [nvarchar](255) NULL,
	[logout] [tinyint] NOT NULL CONSTRAINT [DF_logins_logout]  DEFAULT ((0)),
	[regdate] [datetime] NOT NULL,
 CONSTRAINT [PK_logins] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[m_users]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m_users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [nvarchar](50) NULL,
	[pwd] [nvarchar](max) NULL,
	[email] [nvarchar](50) NULL,
	[birth_year] [nvarchar](50) NULL,
	[ismarried] [int] NULL,
	[sex] [int] NULL,
	[place] [nvarchar](max) NULL,
	[statue] [int] NULL,
	[login_time] [nvarchar](50) NULL,
	[reg_date] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[notepads]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notepads](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [int] NOT NULL,
	[content] [nvarchar](255) NOT NULL,
	[view] [tinyint] NOT NULL,
	[regdate] [datetime] NOT NULL,
	[boardtype] [tinyint] NOT NULL,
	[boardcolor] [nvarchar](50) NOT NULL,
	[textplaymode] [tinyint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[notices]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notices](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[notice] [nvarchar](300) NOT NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[products]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](50) NOT NULL,
	[is_mainproduct] [tinyint] NOT NULL CONSTRAINT [DF_products_is_mainproduct]  DEFAULT ((0)),
	[markers] [int] NOT NULL,
	[hardused] [tinyint] NOT NULL,
	[traffic] [int] NOT NULL,
	[api_requests] [int] NOT NULL,
	[product_tag] [nvarchar](20) NOT NULL,
	[three_template] [tinyint] NOT NULL CONSTRAINT [DF_products_three_template]  DEFAULT ((0)),
	[video_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_video_obj]  DEFAULT ((0)),
	[web_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_web_obj]  DEFAULT ((0)),
	[slide_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_image_obj1]  DEFAULT ((0)),
	[image_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_image_obj]  DEFAULT ((0)),
	[capture_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_capture_obj]  DEFAULT ((0)),
	[three_model_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_three_model_obj]  DEFAULT ((0)),
	[tel_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_tel_obj]  DEFAULT ((0)),
	[googlemap_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_googlemap_obj]  DEFAULT ((0)),
	[notepad_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_notepad_obj]  DEFAULT ((0)),
	[bgm_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_bgm_obj]  DEFAULT ((0)),
	[chromakey_obj] [tinyint] NOT NULL CONSTRAINT [DF_products_chromakey_obj]  DEFAULT ((0)),
	[linkvideo_obj] [tinyint] NOT NULL,
	[pdf_obj] [tinyint] NOT NULL,
	[sns] [tinyint] NOT NULL,
	[regdate] [datetime] NOT NULL CONSTRAINT [DF_products_regdate]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[projects]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[projects](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[userid] [bigint] NOT NULL,
	[size] [tinyint] NOT NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[slides]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[slides](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[url1] [nvarchar](255) NOT NULL,
	[url2] [nvarchar](255) NOT NULL,
	[url3] [nvarchar](255) NOT NULL,
	[url4] [nvarchar](255) NOT NULL,
	[url5] [nvarchar](255) NOT NULL,
	[url6] [nvarchar](255) NOT NULL,
	[url7] [nvarchar](255) NOT NULL,
	[url8] [nvarchar](255) NOT NULL,
	[url9] [nvarchar](255) NOT NULL,
	[url10] [nvarchar](255) NOT NULL,
	[type] [tinyint] NOT NULL,
	[playtype] [tinyint] NOT NULL,
	[showtype] [tinyint] NOT NULL,
	[prev_count] [tinyint] NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [int] NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL,
 CONSTRAINT [PK_slides] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sounds]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sounds](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[type] [tinyint] NOT NULL,
	[run_opt] [tinyint] NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [tinyint] NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[studios]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[studios](
	[studio_id] [varchar](50) NOT NULL,
	[studio_name] [varchar](50) NOT NULL,
	[studio_logo_path] [varchar](50) NULL,
	[del] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[telephones]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[telephones](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[type] [tinyint] NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [int] NOT NULL,
	[tel_no] [nvarchar](50) NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL,
	[color] [nvarchar](50) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[threemode] [tinyint] NOT NULL,
 CONSTRAINT [PK_telephones] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[threes]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[threes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[type] [tinyint] NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [int] NOT NULL,
	[url1] [nvarchar](255) NOT NULL,
	[url2] [nvarchar](255) NULL,
	[front_angle] [float] NOT NULL,
	[run_times] [tinyint] NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[traffics]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[traffics](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[objtype] [tinyint] NOT NULL,
	[filename] [nvarchar](255) NOT NULL,
	[size] [float] NOT NULL,
	[userid] [bigint] NOT NULL,
	[content_id] [bigint] NOT NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[loginid] [nvarchar](20) NOT NULL,
	[loginpwd] [nvarchar](50) NOT NULL,
	[nickname] [nvarchar](50) NULL,
	[ulevel] [tinyint] NULL CONSTRAINT [DF_users_ulevel]  DEFAULT ((0)),
	[company] [nvarchar](255) NULL,
	[auth_no] [nvarchar](50) NULL,
	[address] [nvarchar](255) NULL,
	[owner] [nvarchar](50) NULL,
	[handphone] [nvarchar](255) NULL,
	[telephone] [nvarchar](50) NULL,
	[use_product] [tinyint] NOT NULL,
	[test_req] [tinyint] NOT NULL CONSTRAINT [DF_users_test_req]  DEFAULT ((0)),
	[contract_mode] [tinyint] NOT NULL CONSTRAINT [DF_users_contract_mode]  DEFAULT ((0)),
	[contract_start] [datetime] NULL,
	[contract_end] [datetime] NULL,
	[projects] [tinyint] NULL,
	[contents] [tinyint] NULL,
	[pay_check] [tinyint] NULL,
	[comment] [nvarchar](25) NULL,
	[email] [nvarchar](50) NULL,
	[reg_ip] [nvarchar](50) NULL,
	[user_ip] [nvarchar](50) NULL,
	[logindate] [datetime] NULL,
	[leavedate] [datetime] NULL,
	[interceptdate] [datetime] NULL,
	[regdate] [datetime] NOT NULL CONSTRAINT [DF_users_regdate]  DEFAULT (getdate()),
	[birth_year] [nvarchar](50) NULL,
	[ismarried] [int] NULL,
	[sex] [int] NULL,
	[user_type] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[videos]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[videos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[view_opt] [tinyint] NOT NULL,
	[run_opt] [tinyint] NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [tinyint] NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[websites]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[websites](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[view_opt] [tinyint] NOT NULL,
	[xpos] [float] NOT NULL,
	[ypos] [float] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[depth] [int] NULL,
	[btn_opt] [tinyint] NOT NULL,
	[btn_url] [nvarchar](255) NULL,
	[url] [nvarchar](255) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[color] [nvarchar](50) NOT NULL,
	[size] [float] NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[albums] ADD  CONSTRAINT [DF_albums_del]  DEFAULT ((0)) FOR [del]
GO
ALTER TABLE [dbo].[captures] ADD  CONSTRAINT [DF_Table_1_btn_opt]  DEFAULT ((0)) FOR [url2]
GO
ALTER TABLE [dbo].[captures] ADD  CONSTRAINT [DF_captures_url4]  DEFAULT ('') FOR [url4]
GO
ALTER TABLE [dbo].[captures] ADD  CONSTRAINT [DF_captures_url5]  DEFAULT ('') FOR [url5]
GO
ALTER TABLE [dbo].[captures] ADD  CONSTRAINT [DF_captures_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[chromakeys] ADD  CONSTRAINT [DF_chromakeys_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[chromakeys] ADD  CONSTRAINT [DF_chromakeys_depth]  DEFAULT ((2)) FOR [depth]
GO
ALTER TABLE [dbo].[chromakeys] ADD  CONSTRAINT [DF_chromakeys_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[contents] ADD  CONSTRAINT [DF_contents_api_requests]  DEFAULT ((0)) FOR [api_requests]
GO
ALTER TABLE [dbo].[contents] ADD  CONSTRAINT [DF_contents_size]  DEFAULT ((0)) FOR [size]
GO
ALTER TABLE [dbo].[contents] ADD  CONSTRAINT [DF_contents_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[contents] ADD  CONSTRAINT [DF_contents_changedate]  DEFAULT (getdate()) FOR [changedate]
GO
ALTER TABLE [dbo].[contentsusehist] ADD  CONSTRAINT [DF_contentsusehist_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[googlemaps] ADD  CONSTRAINT [DF_googlemaps_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[googlemaps] ADD  CONSTRAINT [DF_googlemaps_color]  DEFAULT ('#999999') FOR [color]
GO
ALTER TABLE [dbo].[googlemaps] ADD  CONSTRAINT [DF_googlemaps_title]  DEFAULT ('Google map') FOR [title]
GO
ALTER TABLE [dbo].[googlemaps] ADD  CONSTRAINT [DF_googlemaps_color_index]  DEFAULT ((1)) FOR [color_index]
GO
ALTER TABLE [dbo].[googlemaps] ADD  CONSTRAINT [DF_googlemaps_mode_index]  DEFAULT ((1)) FOR [mode_index]
GO
ALTER TABLE [dbo].[images] ADD  CONSTRAINT [DF_images_depth]  DEFAULT ((2)) FOR [depth]
GO
ALTER TABLE [dbo].[images] ADD  CONSTRAINT [DF_images_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[importants] ADD  CONSTRAINT [DF_importants_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[notepads] ADD  CONSTRAINT [DF_notepads_view]  DEFAULT ((0)) FOR [view]
GO
ALTER TABLE [dbo].[notepads] ADD  CONSTRAINT [DF_notepads_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[notepads] ADD  CONSTRAINT [DF_notepads_boardtype]  DEFAULT ((0)) FOR [boardtype]
GO
ALTER TABLE [dbo].[notepads] ADD  CONSTRAINT [DF_notepads_boardcolor]  DEFAULT ('#999999') FOR [boardcolor]
GO
ALTER TABLE [dbo].[notepads] ADD  CONSTRAINT [DF_notepads_textplaymode]  DEFAULT ((0)) FOR [textplaymode]
GO
ALTER TABLE [dbo].[notices] ADD  CONSTRAINT [DF_notices_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[projects] ADD  CONSTRAINT [DF_projects_size]  DEFAULT ((0)) FOR [size]
GO
ALTER TABLE [dbo].[projects] ADD  CONSTRAINT [DF_projects_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[slides] ADD  CONSTRAINT [DF_slides_type]  DEFAULT ('') FOR [type]
GO
ALTER TABLE [dbo].[slides] ADD  CONSTRAINT [DF_slides_playtype]  DEFAULT ((0)) FOR [playtype]
GO
ALTER TABLE [dbo].[slides] ADD  CONSTRAINT [DF_slides_showtype]  DEFAULT ((0)) FOR [showtype]
GO
ALTER TABLE [dbo].[slides] ADD  CONSTRAINT [DF_slides_depth]  DEFAULT ((2)) FOR [depth]
GO
ALTER TABLE [dbo].[slides] ADD  CONSTRAINT [DF_slides_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[sounds] ADD  CONSTRAINT [DF_Table3_view_opt]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[sounds] ADD  CONSTRAINT [DF_sounds_depth]  DEFAULT ((2)) FOR [depth]
GO
ALTER TABLE [dbo].[sounds] ADD  CONSTRAINT [DF_sounds_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[telephones] ADD  CONSTRAINT [DF_tels_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[telephones] ADD  CONSTRAINT [DF_telephones_color]  DEFAULT ('#666666') FOR [color]
GO
ALTER TABLE [dbo].[telephones] ADD  CONSTRAINT [DF_telephones_title]  DEFAULT ('Phone number') FOR [title]
GO
ALTER TABLE [dbo].[telephones] ADD  CONSTRAINT [DF_telephones_threemode]  DEFAULT ((0)) FOR [threemode]
GO
ALTER TABLE [dbo].[threes] ADD  CONSTRAINT [DF_threes_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[traffics] ADD  CONSTRAINT [DF_traffics_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[videos] ADD  CONSTRAINT [DF_videos_view_opt]  DEFAULT ((0)) FOR [view_opt]
GO
ALTER TABLE [dbo].[videos] ADD  CONSTRAINT [DF_videos_depth]  DEFAULT ((2)) FOR [depth]
GO
ALTER TABLE [dbo].[videos] ADD  CONSTRAINT [DF_videos_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[websites] ADD  CONSTRAINT [DF_websites_view_opt]  DEFAULT ((0)) FOR [view_opt]
GO
ALTER TABLE [dbo].[websites] ADD  CONSTRAINT [DF_websites_btn_opt]  DEFAULT ((0)) FOR [btn_opt]
GO
ALTER TABLE [dbo].[websites] ADD  CONSTRAINT [DF_websites_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[websites] ADD  CONSTRAINT [DF_websites_color]  DEFAULT ('#999999') FOR [color]
GO
ALTER TABLE [dbo].[websites] ADD  CONSTRAINT [DF_websites_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
/****** Object:  StoredProcedure [dbo].[sp_addContent]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_addContent]
	-- Add the parameters for the stored procedure here
	@userid		BIGINT,
	@project_id BIGINT , 
	@title NVARCHAR(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO contents
			(project_id, title, userid)
		VALUES
			(@project_id, @title, @userid)
	SELECT @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[sp_addEventLog]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_addEventLog]
	@event		NVARCHAR(50),
	@userid		BIGINT,
	@user_ip	NVARCHAR(50)

AS
	SET NOCOUNT ON
	INSERT INTO
		eventlogs
		(userid, user_ip, event)
	VALUES
		(@userid, @user_ip, @event)
	SELECT @@IDENTITY
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[sp_addProject]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_addProject]
	-- Add the parameters for the stored procedure here
	@title		NVARCHAR(255),
	@userid		BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO 
		projects
	(title, userid)
	VALUES
	(@title, @userid);
	SELECT @@IDENTITY;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_createLogin]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createLogin]
	-- Add the parameters for the stored procedure here
	@user_id		BIGINT,
	@user_ip		NVARCHAR(50),
	@url			NVARCHAR(255),
	@agent			NVARCHAR(255)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;    
		INSERT INTO logins
			(user_id, user_ip, url, agent, regdate)
		VALUES
			(@user_id, @user_ip, @url, @agent, GETDATE())
			
		SELECT COUNT(*) FROM logins WHERE user_id = @user_id AND CONVERT(NVARCHAR(30), regdate, 111) = CONVERT(NVARCHAR(30), GETDATE(), 111)
END

GO
/****** Object:  StoredProcedure [dbo].[sp_createNotice]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_createNotice]
	-- Add the parameters for the stored procedure here	
	@title		NVARCHAR(255),
	@notice		NVARCHAR(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	INSERT INTO notices (title,notice) VALUES(@title, @notice);
	
	SELECT @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[sp_createProduct]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createProduct]
	@product_name		NVARCHAR(50),
    @markers			INT,
    @hardused			INT,
    @traffic			INT,
    @api_requests		INT,
    @product_tag		NVARCHAR(20),
    @video_obj			TINYINT,
    @web_obj			TINYINT,
    @image_obj			TINYINT,
    @slide_obj			TINYINT,
    @cap_obj			TINYINT,
    @three_obj			TINYINT,
    @tel_obj			TINYINT,
    @google_obj			TINYINT,
    @notepad_obj		TINYINT,
    @sound_obj			TINYINT,
    @chromakey_obj		TINYINT,
    @three_template		TINYINT,
	@linkvideo_obj		TINYINT,
	@pdf_obj			TINYINT,
	@sns				TINYINT          
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO products
			(product_name, markers, hardused, traffic, api_requests, product_tag, video_obj, web_obj, image_obj, slide_obj, capture_obj, three_model_obj,
			tel_obj, googlemap_obj, notepad_obj, bgm_obj, chromakey_obj, three_template, linkvideo_obj, pdf_obj, sns)
		VALUES
			(@product_name, @markers, @hardused, @traffic, @api_requests, @product_tag, @video_obj, @web_obj, @image_obj, @slide_obj, @cap_obj, @three_obj,
			@tel_obj, @google_obj, @notepad_obj, @sound_obj, @chromakey_obj, @three_template, @linkvideo_obj, @pdf_obj, @sns)
			
	SELECT @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[sp_createUser]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_createUser]
	-- Add the parameters for the stored procedure here
	@loginid			NVARCHAR(20),
	@loginpwd			NVARCHAR(50),
	@company			NVARCHAR(255),		
	@owner				NVARCHAR(255),	
	@telephone			NVARCHAR(255)	= NULL,
	@email				NVARCHAR(50),
	@ulevel				tinyint			= 1,	
	@use_product		tinyint,	
	@reg_ip				NVARCHAR(50),
	@leavedate			DATETIME		= NULL,
	@interceptdate		DATETIME		= NULL,	
	@contract_start		DATETIME		= NULL,
	@contract_end		DATETIME		= NULL,
	@regdate			DATETIME		= NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO users
			(loginid, loginpwd, company, owner, telephone, email, ulevel, use_product, reg_ip, leavedate, interceptdate, contract_start, contract_end, regdate)
		VALUES
			(@loginid, @loginpwd, @company, @owner, @telephone, @email, @ulevel, @use_product, @reg_ip, @leavedate, @interceptdate, ISNULL(@contract_start, GETDATE()), ISNULL(@contract_end, GETDATE()), ISNULL(@regdate, GETDATE()));
			
	SELECT @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[sp_deleteContent]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_deleteContent]
	-- Add the parameters for the stored procedure here
	@id BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM contents WHERE id=@id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_deleteProject]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_deleteProject]
	-- Add the parameters for the stored procedure here
	@id		BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM projects WHERE id=@id;
	DELETE FROM contents WHERE project_id=@id;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getCampaignPopList]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getCampaignPopList]
	@searchdate		TINYINT,
	@userid			BIGINT
AS
	SET NOCOUNT ON
	IF @searchdate = 0
	BEGIN
		SELECT title, regdate, api_requests FROM contents WHERE userid = @userid
	END
	ELSE IF @searchdate = 1
	BEGIN
		SELECT title, regdate, api_requests FROM contents WHERE userid = @userid AND Datename(month,regdate) =  Datename(month,GetDate())
	END
	ELSE
	BEGIN
		SELECT title, regdate, api_requests FROM contents WHERE userid = @userid AND datediff(Month,regdate,getdate())=@searchdate-1  
	END	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[sp_getConfig]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getConfig]
AS
	SET NOCOUNT ON
		SELECT TOP(1) *
		FROM configs
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[sp_getContentsList]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getContentsList]
	-- Add the parameters for the stored procedure here
	@project_id		BIGINT = NULL	,
	@keyword		NVARCHAR(20)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @keyword IS NOT NULL
		SELECT * FROM contents WHERE project_id=@project_id AND CHARINDEX(@keyword, title) > 0
	ELSE
		SELECT * FROM contents WHERE project_id=@project_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getEventLog]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getEventLog]
	@searchtype		TINYINT=null,
	@keyword		NVARCHAR(20)=null	
AS
	SET NOCOUNT ON
	IF @keyword IS NOT NULL AND @searchtype = 1
	BEGIN
		SELECT *, users.company, users.loginid, users.ulevel FROM eventlogs INNER JOIN users ON users.id=eventlogs.userid WHERE CHARINDEX(@keyword, loginid) > 0 ORDER BY eventlogs.regdate DESC
	END
	ELSE IF @keyword IS NOT null AND @searchtype = 2
	BEGIN
		SELECT *, users.company, users.loginid , users.ulevel FROM eventlogs INNER JOIN users ON users.id=eventlogs.userid WHERE CHARINDEX(@keyword, eventlogs.user_ip) > 0 ORDER BY eventlogs.regdate DESC
	END
	ELSE IF @keyword IS NOT null AND @searchtype = 0
	BEGIN
		SELECT *, users.company, users.loginid , users.ulevel FROM eventlogs INNER JOIN users ON users.id=eventlogs.userid WHERE CHARINDEX(@keyword, company) > 0 ORDER BY eventlogs.regdate DESC
	END
	ELSE IF @keyword IS NOT null AND @searchtype = 3
	BEGIN
		SELECT *, users.company, users.loginid , users.ulevel FROM eventlogs INNER JOIN users ON users.id=eventlogs.userid WHERE users.ulevel=10 ORDER BY eventlogs.regdate DESC
	END
	IF @keyword IS null
	BEGIN
		SELECT *, users.company, users.loginid , users.ulevel FROM eventlogs INNER JOIN users ON users.id=eventlogs.userid ORDER BY eventlogs.regdate DESC
	END
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[sp_getLogins]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getLogins] 
	@adm_id		BIGINT = NULL,
	@user_id	BIGINT = NULL,
	@time		BIGINT			
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	IF @user_id IS NULL
	BEGIN
		SELECT
			l.url, l.regdate, u.loginid, u.nickname, u.id
		FROM
			logins AS l LEFT OUTER JOIN users AS u
		ON
			l.user_id = u.id
		WHERE
			l.logout = 0 AND DATEDIFF(mi, l.regdate, GETDATE()) < @time AND
			(@adm_id IS NULL OR u.id <> @adm_id)	
	END
	ELSE IF @user_id IS NOT NULL
	BEGIN
		SELECT
			*
		FROM
			(
				SELECT
					TOP(1) l.*, u.loginid, u.nickname
				FROM
					logins AS l LEFT OUTER JOIN users AS u
				ON
					l.user_id = u.id
				WHERE
					l.user_id = @user_id
				ORDER BY l.regdate DESC
			) AS A
		WHERE
			A.logout = 0 AND DATEDIFF(mi, A.regdate, GETDATE()) < @time
	END
	RETURN


    
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getMembers]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getMembers]
	-- Add the parameters for the stored procedure here	
	@searchtype		TINYINT=null,
	@keyword		NVARCHAR(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @sdate DATETIME;
	DECLARE @edate DATETIME;
	SET @sdate = CONVERT(DATETIME, CONVERT(VARCHAR(7), GETDATE(), 120) + '-01')
	SET @edate = DATEADD(MM, 1, CONVERT(DATETIME, CONVERT(VARCHAR(7), GETDATE(), 120) + '-01'));

    -- Insert statements for procedure here
	IF @keyword IS NOT NULL AND @searchtype = 0
	BEGIN
		SELECT 
			*,product_name AS use_productname, (SELECT COUNT(*) FROM contents WHERE userid=u.id AND regdate > @sdate) as usemakers, ISNULL((SELECT COUNT(*) FROM contentsusehist WHERE userid=u.id AND regdate > @sdate),0) as usescans, ISNULL((SELECT SUM(size) AS traffic FROM traffics WHERE userid=u.id AND regdate > @sdate), 0) as usetraffic, ISNULL((SELECT SUM(size) FROM contents WHERE userid=u.id), 0) as usedhard
		FROM users as u
			INNER JOIN
			products as p
		ON
			u.use_product=p.id
		WHERE
			CHARINDEX(@keyword, company) > 0
		ORDER BY company ASC;
	END
	ELSE IF @keyword IS NOT null AND @searchtype = 1
	BEGIN
		SELECT 
			*,product_name AS use_productname, (SELECT COUNT(*) FROM contents WHERE userid=u.id AND regdate > @sdate) as usemakers, ISNULL((SELECT COUNT(*) FROM contentsusehist WHERE userid=u.id AND regdate > @sdate),0) as usescans, ISNULL((SELECT SUM(size) AS traffic FROM traffics WHERE userid=u.id AND regdate > @sdate), 0) as usetraffic, ISNULL((SELECT SUM(size) FROM contents WHERE userid=u.id), 0) as usedhard
		FROM users as u
			INNER JOIN
			products as p
		ON
			u.use_product=p.id
		WHERE
			CHARINDEX(@keyword, loginid) > 0 
		ORDER BY company ASC;
	END
	ELSE IF @keyword IS NOT NULL AND @searchtype = 2
	BEGIN
		SELECT 
			*,product_name AS use_productname, (SELECT COUNT(*) FROM contents WHERE userid=u.id AND regdate > @sdate) as usemakers, ISNULL((SELECT COUNT(*) FROM contentsusehist WHERE userid=u.id AND regdate > @sdate),0) as usescans, ISNULL((SELECT SUM(size) AS traffic FROM traffics WHERE userid=u.id AND regdate > @sdate), 0) as usetraffic, ISNULL((SELECT SUM(size) FROM contents WHERE userid=u.id), 0) as usedhard
		FROM users as u
			INNER JOIN
			products as p
		ON
			u.use_product=p.id
		WHERE
			CHARINDEX(@keyword, owner) > 0
		ORDER BY company ASC;
	END
	ELSE IF @keyword IS NOT NULL AND @searchtype = 3
	BEGIN
		SELECT 
			*,product_name AS use_productname, (SELECT COUNT(*) FROM contents WHERE userid=u.id AND regdate > @sdate) as usemakers, ISNULL((SELECT COUNT(*) FROM contentsusehist WHERE userid=u.id AND regdate > @sdate),0) as usescans, ISNULL((SELECT SUM(size) AS traffic FROM traffics WHERE userid=u.id AND regdate > @sdate), 0) as usetraffic, ISNULL((SELECT SUM(size) FROM contents WHERE userid=u.id), 0) as usedhard
		FROM 
			(SELECT * FROM users WHERE id=@keyword) as u
				INNER JOIN
			products as p
		ON
			u.use_product=p.id;
	END
	IF @keyword IS null
	BEGIN
		SELECT 
			*,product_name AS use_productname, (SELECT COUNT(*) FROM contents WHERE userid=u.id AND regdate > @sdate) as usemakers, ISNULL((SELECT COUNT(*) FROM contentsusehist WHERE userid=u.id AND regdate > @sdate),0) as usescans, ISNULL((SELECT SUM(size) AS traffic FROM traffics WHERE userid=u.id AND regdate > @sdate), 0) as usetraffic, ISNULL((SELECT SUM(size) FROM contents WHERE userid=u.id), 0) as usedhard
		FROM users as u
			INNER JOIN
			products as p
		ON
			u.use_product=p.id			
		ORDER BY company ASC;
	END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getNoticeList]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getNoticeList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM notices ORDER BY regdate DESC
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getProductLists]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getProductLists]
	@searchtype		TINYINT=null,
	@keyword		NVARCHAR(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @keyword IS NOT NULL AND @searchtype = 0
	BEGIN
		SELECT 
			* FROM products
		WHERE
			CHARINDEX(@keyword, product_name) > 0
		ORDER BY products.regdate;
	END
	ELSE IF @keyword IS NOT null AND @searchtype = 1
	BEGIN
		SELECT 
			* FROM products
		WHERE
			CHARINDEX(@keyword, product_tag) > 0
		ORDER BY products.regdate;
	END	
	IF @keyword IS null
	BEGIN
		SELECT * FROM products
		ORDER BY products.regdate;
	END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getProjectsList]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getProjectsList]
	-- Add the parameters for the stored procedure here	
	@userid BIGINT = NULL	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM projects WHERE userid=@userid
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getSearchedResult]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getSearchedResult]
	@userid	BIGINT,
	@keyword	NVARCHAR(20)
AS
	SET NOCOUNT ON
	SELECT        
		*
	FROM            
		projects
	WHERE
	    (id IN
                (SELECT        project_id
                FROM            contents
                WHERE        CHARINDEX(@keyword, title) > 0)
		) AND userid=@userid
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[sp_getUnreadRequest]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getUnreadRequest]
	-- Add the parameters for the stored procedure here	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP(1) contents.title AS content_title, contents.id AS content_id, contents.marker_url, projects.title AS project_title FROM contents 
	INNER JOIN projects ON
	contents.project_id=projects.id
	WHERE server_id IS NULL

END

GO
/****** Object:  StoredProcedure [dbo].[sp_getUser]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getUser]	
	@id	BIGINT = NULL,
	@loginid NVARCHAR(20) = NULL,
	@nickname NVARCHAR(255) = NULL	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;    
	SELECT * FROM users 
	WHERE 
		(@id IS NULL OR id = @id) AND
		(@loginid IS NULL OR loginid = @loginid) AND		
		(@nickname IS NULL OR nickname = @nickname)		
END

GO
/****** Object:  StoredProcedure [dbo].[sp_modifyContentName]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_modifyContentName]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
	@content_id	BIGINT,
	@title	NVARCHAR(255)
AS
	SET NOCOUNT ON
		UPDATE
			contents
		SET
			title=@title
		WHERE
			id=@content_id
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[sp_modifyNotice]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_modifyNotice]
	-- Add the parameters for the stored procedure here
	@id			BIGINT,
	@title		NVARCHAR(255),
	@notice		NVARCHAR(300)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE 
		notices 
	SET
		title=@title,
		notice=@notice,
		regdate = GETDATE()
	WHERE id=@id;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_modifyProduct]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_modifyProduct]
	@id					BIGINT,
	@product_name		NVARCHAR(50),
    @markers			INT,
    @hardused			INT,
    @traffic			INT,
    @api_requests		INT,
    @product_tag		NVARCHAR(20),
    @video_obj			TINYINT,
    @web_obj			TINYINT,
    @image_obj			TINYINT,
    @slide_obj			TINYINT,
    @cap_obj			TINYINT,
    @three_obj			TINYINT,
    @tel_obj			TINYINT,
    @google_obj			TINYINT,
    @notepad_obj		TINYINT,
    @sound_obj			TINYINT,
    @chromakey_obj		TINYINT,
    @three_template		TINYINT,
	@linkvideo_obj		TINYINT,
	@pdf_obj			TINYINT,
	@sns				TINYINT          
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE products
	SET
			product_name=@product_name, markers=@markers, hardused=@hardused, traffic=@traffic, api_requests=@api_requests, product_tag=@product_tag,
			video_obj=@video_obj, web_obj=@web_obj, image_obj=@image_obj, slide_obj=@slide_obj, capture_obj=@cap_obj, three_model_obj=@three_obj,
			tel_obj=@tel_obj, googlemap_obj=@google_obj, notepad_obj=@notepad_obj, bgm_obj=@sound_obj, chromakey_obj=@chromakey_obj, three_template=@three_template, 
			linkvideo_obj=@linkvideo_obj, pdf_obj=@pdf_obj, sns=@sns
	WHERE	
		id=@id
	SELECT @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[sp_modifyProjectName]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_modifyProjectName]
	@project_id	BIGINT,
	@title		NVARCHAR(255)
AS
	SET NOCOUNT ON
		UPDATE
			projects
		SET
			title=@title
		WHERE
			id=@project_id
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[sp_modifyUser]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_modifyUser]
	-- Add the parameters for the stored procedure here
	@id					BIGINT,
	@loginid			NVARCHAR(20),
	@loginpwd			NVARCHAR(50),
	@company			NVARCHAR(255),		
	@owner				NVARCHAR(255),	
	@telephone			NVARCHAR(255)	= NULL,
	@email				NVARCHAR(50),	
	@use_product		tinyint,
	@contract_start		DATETIME		= NULL,
	@contract_end		DATETIME		= NULL	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE 
		users
	SET
		loginid=@loginid,
		loginpwd=@loginpwd, 
		company=@company,		
		owner=@owner,		
		telephone=@telephone, 		
		email=@email,
		use_product=@use_product,
		contract_start=@contract_start,
		contract_end=@contract_end
	WHERE id=@id;
	RETURN
END

GO
/****** Object:  StoredProcedure [dbo].[sp_updateLogin]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_updateLogin]
	@user_id	BIGINT,
	@url		NVARCHAR(255) = NULL,
	@logout		TINYINT = 0		
AS
	SET NOCOUNT ON
		UPDATE
			logins
		SET
			url		= @url,
			logout	= @logout,
			regdate = GETDATE()
		WHERE
			id = (SELECT TOP(1) id FROM logins WHERE user_id = @user_id ORDER BY regdate DESC)
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[sp_updateUserInfo]    Script Date: 9/16/2017 11:02:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateUserInfo]
	@id				BIGINT,		
	@leavedate		DATETIME = NULL,	
	@user_ip		NVARCHAR(50) = NULL
AS
	SET NOCOUNT ON
		IF @user_ip IS NOT NULL
		BEGIN
			UPDATE 
				users
			SET
				user_ip = @user_ip,
				logindate = GETDATE()
			WHERE
				id = @id
		END
--		ELSE IF @leavedate IS NULL
--		BEGIN
--			UPDATE
--				users
--			SET
--				ulevel = @ulevel,
--				interceptdate = @blockdate,
--				ischatblock = @ischatblock
--			WHERE
--				id = @id
--		END
		ELSE IF @leavedate IS NOT NULL
		BEGIN
			UPDATE
				users
			SET
				leavedate = @leavedate
			WHERE
				id = @id
		END
	RETURN

GO
USE [master]
GO
ALTER DATABASE [starAR] SET  READ_WRITE 
GO
