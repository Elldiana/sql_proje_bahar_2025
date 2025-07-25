USE [master]
GO
/****** Object:  Database [LanguageCenter]    Script Date: 2.05.2025 21:16:40 ******/
CREATE DATABASE [LanguageCenter]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LanguageCenter', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\LanguageCenter.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LanguageCenter_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\LanguageCenter_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LanguageCenter] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LanguageCenter].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LanguageCenter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LanguageCenter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LanguageCenter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LanguageCenter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LanguageCenter] SET ARITHABORT OFF 
GO
ALTER DATABASE [LanguageCenter] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LanguageCenter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LanguageCenter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LanguageCenter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LanguageCenter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LanguageCenter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LanguageCenter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LanguageCenter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LanguageCenter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LanguageCenter] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LanguageCenter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LanguageCenter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LanguageCenter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LanguageCenter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LanguageCenter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LanguageCenter] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LanguageCenter] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LanguageCenter] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LanguageCenter] SET  MULTI_USER 
GO
ALTER DATABASE [LanguageCenter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LanguageCenter] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LanguageCenter] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LanguageCenter] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LanguageCenter] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LanguageCenter] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LanguageCenter] SET QUERY_STORE = ON
GO
ALTER DATABASE [LanguageCenter] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LanguageCenter]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OgrenciKursKayitSayisi]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_OgrenciKursKayitSayisi] (@OGRENCI_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @KayitSayisi INT;

    SELECT @KayitSayisi = COUNT(*)
    FROM [dbo].[Kurslar.Kayitlar]
    WHERE OGRENCI_ID = @OGRENCI_ID;

    RETURN @KayitSayisi;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OgrenciToplamOdeme]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_OgrenciToplamOdeme] (@OGRENCI_ID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Toplam DECIMAL(10,2);
    
    SELECT @Toplam = SUM(ODEME_TUTARI)
    FROM Odemeler
    WHERE OGRENCI_ID = @OGRENCI_ID;
    
    RETURN ISNULL(@Toplam, 0);
END
GO
/****** Object:  Table [dbo].[Bireyler.Ogrenciler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bireyler.Ogrenciler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BIREY_ID] [int] NULL,
	[EGITIM_DURUMU] [nvarchar](80) NULL,
	[KAYIT_TARIHI] [date] NULL,
	[SUBE_ID] [tinyint] NULL,
 CONSTRAINT [PK_Bireyler.Ogrenciler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bireyler.Veliler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bireyler.Veliler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OGRENCI_ID] [int] NOT NULL,
	[VELI_ID] [int] NOT NULL,
	[NOTLAR] [nvarchar](50) NULL,
 CONSTRAINT [PK_Bireyler.Veliler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_VelisiOlanOgrenciler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_VelisiOlanOgrenciler]()
RETURNS TABLE
AS
RETURN
(
    SELECT O.ID AS OgrenciID, O.BIREY_ID, O.EGITIM_DURUMU, O.KAYIT_TARIHI, O.SUBE_ID
    FROM [dbo].[Bireyler.Ogrenciler] O
    INNER JOIN [dbo].[Bireyler.Veliler] V ON O.ID = V.OGRENCI_ID
);
GO
/****** Object:  Table [dbo].[Kurslar.Kayitlar]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurslar.Kayitlar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DERS_PROGRAM_ID] [int] NOT NULL,
	[OGRENCI_ID] [int] NOT NULL,
	[KAYIT_TARIHI] [date] NULL,
 CONSTRAINT [PK_Kurslar.Kayitlar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Odemeler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Odemeler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OGRENCI_ID] [int] NOT NULL,
	[KURS_KAYIT_ID] [int] NULL,
	[ODEME_TUTARI] [decimal](18, 2) NULL,
	[ODEME_TURU_ID] [char](1) NULL,
	[ODEME_TARIHI] [date] NULL,
 CONSTRAINT [PK_Odemeler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OdemesizOgrenciler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_OdemesizOgrenciler]()
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT O.ID AS OgrenciID, O.BIREY_ID, O.EGITIM_DURUMU, O.KAYIT_TARIHI, O.SUBE_ID
    FROM [dbo].[Bireyler.Ogrenciler] O
    INNER JOIN [dbo].[Kurslar.Kayitlar] K ON O.ID = K.OGRENCI_ID
    LEFT JOIN [dbo].[Odemeler] OD ON O.ID = OD.OGRENCI_ID
    WHERE OD.ID IS NULL  -- ödeme kaydı olmayanlar
);
GO
/****** Object:  Table [dbo].[Adresler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adresler](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[IL_ID] [tinyint] NOT NULL,
	[ILCE] [nvarchar](50) NOT NULL,
	[ADRES_DETAY] [nvarchar](120) NOT NULL,
	[POSTA_KODU] [varchar](10) NULL,
	[BIREY_ID] [int] NULL,
	[SUBE_ID] [tinyint] NULL,
 CONSTRAINT [PK_Adresler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Adresler.Iler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adresler.Iler](
	[IL_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[IL_ADI] [nvarchar](30) NULL,
 CONSTRAINT [PK_Adress.Iler] PRIMARY KEY CLUSTERED 
(
	[IL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bireyler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bireyler](
	[BIREY_ID] [int] IDENTITY(1,1) NOT NULL,
	[AD] [nvarchar](50) NULL,
	[SOYAD] [nvarchar](50) NULL,
	[DOGUM_TARIHI] [date] NULL,
	[CINSIYET] [char](1) NOT NULL,
	[TC_KIMLIK_NO] [char](11) NOT NULL,
 CONSTRAINT [PK_BIREYLER_1] PRIMARY KEY CLUSTERED 
(
	[BIREY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bireyler.AcilDurumdaYakinlari]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bireyler.AcilDurumdaYakinlari](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OGRENCI_ID] [int] NULL,
	[YAKINI_ID] [int] NULL,
 CONSTRAINT [PK_Bireyler.AcilDurumdaYakinlari] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bireyler.Ogretmenler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bireyler.Ogretmenler](
	[ID] [smallint] IDENTITY(1,100) NOT NULL,
	[BIREY_ID] [int] NOT NULL,
	[BRANS] [nvarchar](50) NULL,
	[EGITIM_DURUMU] [nvarchar](80) NULL,
	[ISE_BASLAMA_TARIHI] [date] NULL,
	[CALISMA_DURUMU] [nvarchar](20) NULL,
	[MAASI] [money] NOT NULL,
	[SUBE_ID] [tinyint] NULL,
 CONSTRAINT [PK_Bireyler.Ogretmenler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bireyler.Personeller]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bireyler.Personeller](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BIREY_ID] [int] NOT NULL,
	[GOREV] [nvarchar](50) NOT NULL,
	[MAAS] [money] NULL,
	[SUBE_ID] [tinyint] NULL,
	[ISE_BASLAMA_TARIHI] [date] NULL,
	[DURUM] [nvarchar](30) NULL,
 CONSTRAINT [PK_Bireyler.Personeller] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Epostalar]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Epostalar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EPOSTA] [varchar](100) NOT NULL,
	[BIREY_ID] [int] NULL,
 CONSTRAINT [PK_Epostalar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[EPOSTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kurslar]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurslar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SEVIYE_ID] [tinyint] NULL,
	[DIL_ID] [tinyint] NULL,
	[SURESI] [nvarchar](10) NOT NULL,
	[UCRETI] [decimal](18, 2) NULL,
	[KONTENJAN] [smallint] NULL,
	[TUR_ID] [tinyint] NULL,
 CONSTRAINT [PK_Kurslar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kurslar.Diller]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurslar.Diller](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[DIL] [nvarchar](50) NULL,
 CONSTRAINT [PK_Kurslar.Diller] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kurslar.Programlar]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurslar.Programlar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KURS_ID] [int] NOT NULL,
	[SINIF_ID] [tinyint] NOT NULL,
	[GUNLER] [nvarchar](50) NOT NULL,
	[BASLANGIC_SAATI] [time](0) NULL,
	[BITIS_SAATI] [time](0) NULL,
	[OGRETMEN_ID] [smallint] NOT NULL,
 CONSTRAINT [PK_Kurslar.Programlari] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kurslar.Sevıyeler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurslar.Sevıyeler](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[SEVIYE] [char](2) NULL,
 CONSTRAINT [PK_Kurslar.Sevıyeler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kurslar.Turler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurslar.Turler](
	[TUR_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[TURU] [nvarchar](15) NULL,
 CONSTRAINT [PK_Kurslar.Turler] PRIMARY KEY CLUSTERED 
(
	[TUR_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kurslar_Yedek]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurslar_Yedek](
	[ID] [int] NULL,
	[SEVIYE_ID] [int] NULL,
	[DIL_ID] [int] NULL,
	[SURESI] [varchar](50) NULL,
	[UCRETI] [decimal](10, 2) NULL,
	[KONTENJAN] [int] NULL,
	[TUR_ID] [int] NULL,
	[EKLENME_TARIHI] [datetime] NULL,
	[EKLEYEN_KULLANICI] [nvarchar](50) NULL,
	[SILINDI_MI] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kurslar_Yedek1]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurslar_Yedek1](
	[ID] [int] NULL,
	[SEVIYE_ID] [int] NULL,
	[DIL_ID] [int] NULL,
	[SURESI] [varchar](50) NULL,
	[UCRETI] [decimal](10, 2) NULL,
	[KONTENJAN] [int] NULL,
	[TUR_ID] [int] NULL,
	[EKLENME_TARIHI] [datetime] NULL,
	[EKLEYEN_KULLANICI] [nvarchar](50) NULL,
	[SILINDI_MI] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notlar]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notlar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OGRENCI_ID] [int] NULL,
	[SINAV_TURU_ID] [int] NULL,
	[PUAN] [decimal](5, 2) NULL,
	[TARIH] [date] NULL,
	[OGRETMEN_ID] [smallint] NULL,
 CONSTRAINT [PK_Notlar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notlar.SinavTurleri]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notlar.SinavTurleri](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SINAV_TURU] [nvarchar](50) NULL,
 CONSTRAINT [PK_Notlar.Turleri] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Odemeler.OdemeTurleri]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Odemeler.OdemeTurleri](
	[ID] [char](1) NOT NULL,
	[ODEME_TURU] [nvarchar](20) NULL,
 CONSTRAINT [PK_Kurslar.OdemeTurleri] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sertifikalar]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sertifikalar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OGRENCI_ID] [int] NOT NULL,
	[ORTALAMA_PUAN] [decimal](5, 2) NULL,
	[TARIHI] [date] NULL,
	[BELGE_NUMARASI] [varchar](50) NULL,
	[DURUM] [nvarchar](20) NULL,
 CONSTRAINT [PK_Sertifikalar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Siniflar]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Siniflar](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[SINIF_NO] [varchar](7) NULL,
	[KAPASITE] [tinyint] NULL,
	[DONANIM] [nvarchar](250) NOT NULL,
	[SUBE_ID] [tinyint] NULL,
 CONSTRAINT [PK_Siniflar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subeler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subeler](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[SUBE_ADI] [nvarchar](50) NOT NULL,
	[ACILIS_TARIHI] [date] NULL,
	[DURUMU] [nvarchar](30) NULL,
	[TOPLAM_CALISANLAR] [tinyint] NOT NULL,
	[KONUM] [geography] NULL,
 CONSTRAINT [PK_Subeler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Telefonlar]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Telefonlar](
	[ULKE_KODU] [char](4) NOT NULL,
	[ALAN_KODU] [varchar](7) NOT NULL,
	[TELEFON_NO] [nvarchar](12) NOT NULL,
	[BIREY_ID] [int] NULL,
	[SUBE_ID] [tinyint] NULL,
 CONSTRAINT [PK_Telefonlar] PRIMARY KEY CLUSTERED 
(
	[ULKE_KODU] ASC,
	[ALAN_KODU] ASC,
	[TELEFON_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Telefonlar.AlanKodu]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Telefonlar.AlanKodu](
	[ALAN_KODU] [varchar](7) NOT NULL,
	[SEHIR] [nvarchar](50) NULL,
 CONSTRAINT [PK_ALAN_KODU] PRIMARY KEY CLUSTERED 
(
	[ALAN_KODU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Telefonlar.Ulkeler]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Telefonlar.Ulkeler](
	[ULKE_KODU] [char](4) NOT NULL,
	[ULKE] [nvarchar](50) NULL,
 CONSTRAINT [PK_Telefonlar.Ulkeler] PRIMARY KEY CLUSTERED 
(
	[ULKE_KODU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Adresler] ON 

INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (3, 1, N'Dikili', N'Mah Barış Sk. Gülistan No:5/10 ', N'0897', 2, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (4, 24, N'Çankaya', N'Ödemiş No:11/1', N'06080', 3, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (5, 24, N'Gazıemir', N'Turnova Sk Menderes No:34/5', N'06120', 4, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (6, 24, N'Kiraz', N'Çanakkale No:96/2', N'06130', 5, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (7, 24, N'Bayındır', N'Seferhisar Sk Aksaray No:165/8', N'06120', 6, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (8, 25, N'Alsancak', N'Bahçelievler No:34/6', N'35060', 7, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (9, 25, N'Karabağlar', N'Bahçelievler No:89/4', N'35050', 8, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (10, 25, N'Balçova', N'Ersincan No:48/3', N'35000', 9, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (11, 25, N'Karşıyaka', N'Karaburun No:96/11', N'35060', 10, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (12, 25, N'Bornova', N'Güzelbahçe 96 Sk No:71/5', N'35120', 11, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (13, 25, N'Bayraklı', N'Atatürk 145 Sk No:566/7', N'35130', 12, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (14, 25, N'Foça', N'Güzelsanatlar 264 Sk No: 96/1', N'35080', 13, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (15, 6, N'Dikili', N'Konak  118 Sk No:17/10', N'78622', 14, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (16, 24, N'Akuyurt', N'Anaftvalar Cd 78 Sk No:5/1', N'06100', 15, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (17, 24, N'Beypazarı', N'Suluova Cd 46 Sk No:1/1', N'06120', 16, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (18, 24, N'Elmadağ', N'Hamamözü Cd 786 Sk No:7/5', N'06130', 17, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (19, 25, N'Buca', N'Haymana Cd 196 Sk No:9/2', N'35000', 18, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (20, 25, N'Buca', N'Taşova Cd 125 Sk No:4/6', N'35000', 19, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (21, 24, N'Güdül', N'Kalecik Cd 78 Sk No:2/3', N'06150', 20, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (22, 24, N'Altındağ', N'Çanakaya Cd 155 Sk No:15/9', N'06080', 21, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (23, 24, N'Evren', N'Ersincan Cd 45 Sk No:4/4', N'06130', 22, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (24, 25, N'Narlıdere', N'Atatürk Cd 66 Sk No:5/3', N'35060', 23, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (25, 25, N'Evka-3', N'Hisarönü Cd 159 Sk No:14/5', N'35150', 24, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (26, 24, N'Yenimahalle', N'Akseki Cd 144 Sk No:9/7', N'06100', 25, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (27, 24, N'Sincan', N'Kahramankazan No:12/1', N'06110', 26, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (28, 9, N'Pursaklar', N'Baahçelievler No:48/6', N'39100', 27, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (29, 4, N'Bayındır', N'468 Sk No:88/4', N'48688', 28, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (30, 5, N'Beypazarı', N'498 Sk No:88/4', N'58487', 29, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (31, 6, N'Bahcelerarası', N'598 Sk No:18/4', N'86568', 30, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (32, 25, N'Elmadağ', N'468 Sk No:88/4', N'56887', 31, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (33, 4, N'Karşıyaka', N'125 Sk No:17/1', N'84877', 32, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (34, 10, N'Balçova', N'68 Sk No:87/8', N'65889', 33, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (35, 12, N'Güdül', N'98 Sk No:88/4', N'48786', 34, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (36, 15, N'Karabğlar', N'56 Sk No:2/3', N'65898', 35, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (37, 24, N'Sincan', N'468 Sk No:88/4', N'54832', 36, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (38, 16, N'Altındağ', N'Kalecik Cd 78 Sk No:2/3', N'48786', 37, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (39, 24, N'Suluova', N'Anaftvalar Cd 78 Sk No:5/1', N'86889', 38, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (40, 25, N'Evka-5', N'Anaftvalar Cd 78 Sk No:5/1', N'566', 39, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (41, 6, N'Guldu', N'Kalecik Cd 78 Sk No:5/1', N'58989', 40, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (42, 9, N'Sincan', N'Akseki Cd 144 Sk No:9/7', N'856', 41, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (43, 5, N'Çankaya', N'Atatürk Cd 66 Sk No:5/3', N'56898', 42, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (44, 6, N'Taşova', N'Kahramankazan No:12/1', N'598', 43, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (45, 5, N'Yenimahale', N'Kahramankazan No:12/1', N'5889', 44, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (47, 4, N'yebb', N'MDX', N'5555', 45, NULL)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (48, 6, N'Içmeler', N'Ata Cd 139 Sk No:10/5', N'12000', NULL, 1)
INSERT [dbo].[Adresler] ([ID], [IL_ID], [ILCE], [ADRES_DETAY], [POSTA_KODU], [BIREY_ID], [SUBE_ID]) VALUES (49, 6, N'Turunç', N'231 Sk No: 3/1', N'12200', NULL, 2)
SET IDENTITY_INSERT [dbo].[Adresler] OFF
GO
SET IDENTITY_INSERT [dbo].[Adresler.Iler] ON 

INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (1, N'Adana')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (2, N'Adıyaman')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (3, N' Afyon')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (4, N'Ağrı')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (5, N'Aksaray')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (6, N'Amasya')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (7, N'Ardahan')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (8, N'Artvin')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (9, N'Aydın')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (10, N'Balıkesir')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (11, N'Bartın')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (12, N'Batman')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (13, N'Bayburt')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (14, N'Bilecik')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (15, N'Bolu')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (16, N'Bitlis')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (17, N'Burdur')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (18, N'Bursa')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (19, N'Çanakkale')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (20, N'Çankırı')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (21, N'Çorum')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (22, N'Denizli')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (23, N'Diyarbakır')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (24, N'Ankara')
INSERT [dbo].[Adresler.Iler] ([IL_ID], [IL_ADI]) VALUES (25, N'İzmir')
SET IDENTITY_INSERT [dbo].[Adresler.Iler] OFF
GO
SET IDENTITY_INSERT [dbo].[Bireyler] ON 

INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (2, N'Ela', N'Dursun', CAST(N'1988-09-15' AS Date), N'E', N'25874663531')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (3, N'Caner', N'Açıkgöz', CAST(N'1997-05-29' AS Date), N'K', N'47965824456')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (4, N'Bekir', N'Ağaoğlu', CAST(N'1985-11-14' AS Date), N'E', N'69488264117')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (5, N'Ali', N'Aslan', CAST(N'1994-02-20' AS Date), N'E', N'48657223487')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (6, N'Ertekin', N'Uyanık', CAST(N'1965-07-24' AS Date), N'E', N'48647223558')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (7, N'Ahmet', N'Çelik', CAST(N'2003-05-01' AS Date), N'E', N'48852556625')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (8, N'Svetlana', N'Aleksandrovna', CAST(N'1998-12-23' AS Date), N'K', N'48796635588')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (9, N'Gülbahar', N'Sevindi', CAST(N'1995-08-02' AS Date), N'K', N'78942254821')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (10, N'Şükürye', N'Altın', CAST(N'1977-07-31' AS Date), N'K', N'45825586574')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (11, N'Maksat', N'Ziyafe', CAST(N'1979-02-15' AS Date), N'E', N'48652879254')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (12, N'Temel', N'Ergül', CAST(N'1981-04-07' AS Date), N'E', N'47256847811')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (13, N'Ersin', N'Çalışan', CAST(N'1991-06-01' AS Date), N'E', N'47685215637')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (14, N'Fatmagül', N'Aitekin', CAST(N'1993-11-27' AS Date), N'K', N'48957642122')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (15, N'Temel', N'Demircan', CAST(N'1969-08-04' AS Date), N'E', N'47625884627')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (16, N'Aysen', N'Akbarali', CAST(N'1975-01-07' AS Date), N'K', N'47628821202')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (17, N'Aykanat', N'Sevinç', CAST(N'1999-03-08' AS Date), N'K', N'48624552249')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (18, N'Lemi', N'Akarçay', CAST(N'1986-05-25' AS Date), N'E', N'49652526334')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (19, N'Umid', N'Akıllı', CAST(N'1979-11-06' AS Date), N'E', N'48679156431')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (20, N'Ayşen', N'Akfırat', CAST(N'1996-06-19' AS Date), N'K', N'47698319736')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (21, N'Ata Keren', N'Akca', CAST(N'1989-12-25' AS Date), N'E', N'48976267462')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (22, N'Ayşe', N'Güneş', CAST(N'1999-09-29' AS Date), N'K', N'47964854445')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (23, N'Zeynep', N'Aydın', CAST(N'1996-01-17' AS Date), N'K', N'47642582134')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (24, N'Yaşar Utku', N'Anıl', CAST(N'1971-01-13' AS Date), N'E', N'48679125456')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (25, N'Burak Tatkan', N'Çaprak', CAST(N'1962-08-19' AS Date), N'E', N'48647825448')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (26, N'Aydın Mert', N'Bural', CAST(N'1959-05-15' AS Date), N'E', N'48667786255')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (27, N'Hayriye	', N'Caner', CAST(N'1958-02-10' AS Date), N'K', N'48657552238')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (28, N'Aleda', N'Bülent', CAST(N'2015-06-25' AS Date), N'K', N'47624489823')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (29, N'Mustafa', N'Canbek', CAST(N'2002-10-01' AS Date), N'E', N'48679465822')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (30, N'Abdullah Emirhan', N'Akbarali', CAST(N'2019-03-21' AS Date), N'E', N'47895246847')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (31, N'Sena Nur', N'Çardak', CAST(N'2001-06-20' AS Date), N'K', N'48665782223')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (32, N'Cansu', N'Yaprak', CAST(N'2005-07-31' AS Date), N'K', N'48614567655')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (33, N'Yağmur', N'Dursun', CAST(N'1985-05-02' AS Date), N'K', N'48679504488')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (34, N'Ahmet', N'Yılmaz', CAST(N'2016-03-14' AS Date), N'E', N'47685286654')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (35, N'Seyit', N'Burak', CAST(N'1981-09-06' AS Date), N'E', N'48258426532')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (36, N'Cankız', N'Bural', CAST(N'1991-03-03' AS Date), N'K', N'47689652823')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (37, N'Zeynep Büşra	', N'Dereli', CAST(N'1992-04-09' AS Date), N'K', N'44822468155')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (38, N'Miraç', N'Dalılı', CAST(N'1986-09-11' AS Date), N'E', N'48793569729')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (39, N'Tubanur', N'Dengizek', CAST(N'1993-02-28' AS Date), N'K', N'48997522497')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (40, N'Elif', N'Çardak', CAST(N'2016-03-21' AS Date), N'K', N'47965858541')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (41, N'Derya', N'Ergün', CAST(N'2019-12-21' AS Date), N'K', N'47644898124')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (42, N'Samed', N'Zorlu', CAST(N'1996-04-04' AS Date), N'E', N'48978528658')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (43, N'Erkoç', N'Hanif', CAST(N'1955-06-01' AS Date), N'E', N'48657259736')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (44, N'Gülnaz', N'Akça', CAST(N'1994-01-25' AS Date), N'K', N'47855285691')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (45, N'Zeynep', N'Sevinç', CAST(N'1995-10-22' AS Date), N'K', N'17795885456')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (46, N'Natalya', N'Fiyodorovna', CAST(N'1982-02-15' AS Date), N'K', N'48656982228')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (47, N'Vladimir ', N'Kapchuk', CAST(N'1993-05-20' AS Date), N'E', N'48629825291')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (48, N'Aysezim', N'Kerimbekova', CAST(N'2006-06-25' AS Date), N'K', N'48876363525')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (49, N'Nurkyz', N'Kadyralieva', CAST(N'1997-09-25' AS Date), N'K', N'15878745656')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (50, N'Gabrina', N'Holmas', CAST(N'1995-11-06' AS Date), N'K', N'78545258895')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (51, N'Dinks', N'Hein', CAST(N'2000-09-10' AS Date), N'E', N'48798742499')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (52, N'Diana', N'Bel', CAST(N'2005-07-15' AS Date), N'K', N'68982248965')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (53, N'Elif', N'Yılmaz', CAST(N'2021-10-15' AS Date), N'K', N'48635648226')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (54, N'ajsıfj', N'zşsppoeı', CAST(N'2022-02-01' AS Date), N'E', N'48975878257')
INSERT [dbo].[Bireyler] ([BIREY_ID], [AD], [SOYAD], [DOGUM_TARIHI], [CINSIYET], [TC_KIMLIK_NO]) VALUES (57, N'D', N'D', CAST(N'2025-05-15' AS Date), N'K', N'48975875257')
SET IDENTITY_INSERT [dbo].[Bireyler] OFF
GO
SET IDENTITY_INSERT [dbo].[Bireyler.Ogrenciler] ON 

INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (1, 25, N'Lise mezunu', CAST(N'2024-05-20' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (2, 26, N'Öğrenci Ege Üniversitesi Işletme bölümü', CAST(N'2020-04-14' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (3, 27, N'Öğrenci Ön Lisans Sivil Havacılık', CAST(N'2021-01-12' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (4, 28, N'Lise 9.Sınıf', CAST(N'2023-12-19' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (5, 29, N'Öğrenci Ege Üniversitesi Işletme bölümü', CAST(N'2023-11-25' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (6, 30, N'Lise 9.Sınıf', CAST(N'2019-05-13' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (7, 31, N'Öğrenci Ege Üniversitesi Işletme bölümü', CAST(N'2024-10-17' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (8, 32, N'Öğrenci Ön Lisans Sivil Havacılık', CAST(N'2021-12-01' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (9, 33, NULL, CAST(N'2024-11-29' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (10, 34, N'Lise 10.Sınıf', CAST(N'2024-09-25' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (11, 35, N'Öğrenci Ön Lisans Sivil Havacılık', CAST(N'2024-11-30' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (12, 36, N'Öğrenci Ege Üniversitesi Işletme bölümü', CAST(N'2020-04-15' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (13, 37, N'Lise mezunu', CAST(N'2019-10-25' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (14, 38, N'Öğrenci Ön Lisans Bilgisayar Programcılığı', CAST(N'2023-11-16' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (15, 39, N'Öğrenci Ön Lisans Bilgisayar Programcılığı', CAST(N'2023-11-17' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (16, 40, N'Orta Okul 6. Sınıf', CAST(N'2019-12-26' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (17, 41, N'Orta Okul 7. Sınıf', CAST(N'2024-12-01' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (18, 42, N'Öğrenci Ege Üniversitesi Işletme bölümü', CAST(N'2024-11-27' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (19, 43, N'Öğrenci Ön Lisans Sivil Havacılık', CAST(N'2022-01-05' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (20, 44, NULL, CAST(N'2023-02-20' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (21, 47, N'Öğrenci Ön Lisans Bilgisayar Programcılığı', CAST(N'2024-12-01' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (22, 48, N'Öğrenci Ön Lisans Bilgisayar Programcılığı', CAST(N'2024-11-06' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (23, 49, N'Lise mezunu', CAST(N'2024-12-05' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (24, 50, N'Öğrenci Ege Üniversitesi Işletme bölümü', CAST(N'2024-12-09' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (25, 51, NULL, CAST(N'2024-12-09' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (26, 25, N'Öğrenci Ege Üniversitesi Işletme bölümü', CAST(N'2024-05-20' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (27, 26, N'Öğrenci Ön Lisans Sivil Havacılık', CAST(N'2020-04-14' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (28, 27, NULL, CAST(N'2021-01-12' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (29, 28, N'Öğrenci Ön Lisans Bilgisayar Programcılığı', CAST(N'2023-12-19' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (30, 29, NULL, CAST(N'2023-11-25' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (31, 30, N'Lise mezunu', CAST(N'2019-05-13' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (32, 31, N'Lise mezunu', CAST(N'2024-10-17' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (33, 32, NULL, CAST(N'2021-12-01' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (34, 33, N'Öğrenci Ön Lisans Bilgisayar Programcılığı', CAST(N'2024-11-29' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (35, 34, N'Öğrenci Ege Üniversitesi Işletme bölümü', CAST(N'2024-09-25' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (36, 35, N'Öğrenci Ön Lisans Sivil Havacılık', CAST(N'2024-11-30' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (37, 36, NULL, CAST(N'2020-04-15' AS Date), 1)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (38, 37, N'Lise mezunu', CAST(N'2019-10-25' AS Date), 2)
INSERT [dbo].[Bireyler.Ogrenciler] ([ID], [BIREY_ID], [EGITIM_DURUMU], [KAYIT_TARIHI], [SUBE_ID]) VALUES (39, 38, N'Öğrenci Ön Lisans Bilgisayar Programcılığı', CAST(N'2023-11-16' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Bireyler.Ogrenciler] OFF
GO
SET IDENTITY_INSERT [dbo].[Bireyler.Ogretmenler] ON 

INSERT [dbo].[Bireyler.Ogretmenler] ([ID], [BIREY_ID], [BRANS], [EGITIM_DURUMU], [ISE_BASLAMA_TARIHI], [CALISMA_DURUMU], [MAASI], [SUBE_ID]) VALUES (1, 2, N'Türkçe Öğretmeni', N'Ege Üniversitesi Lisans mezunu', CAST(N'2022-03-01' AS Date), N'Aktif', 37000.0000, 1)
INSERT [dbo].[Bireyler.Ogretmenler] ([ID], [BIREY_ID], [BRANS], [EGITIM_DURUMU], [ISE_BASLAMA_TARIHI], [CALISMA_DURUMU], [MAASI], [SUBE_ID]) VALUES (101, 3, N'Inglizce Öğretmeni', N'Dokuz Eylül Üniversitesi Yüksek lisans mezunu', CAST(N'2019-09-01' AS Date), N'Aktif', 45000.0000, 1)
INSERT [dbo].[Bireyler.Ogretmenler] ([ID], [BIREY_ID], [BRANS], [EGITIM_DURUMU], [ISE_BASLAMA_TARIHI], [CALISMA_DURUMU], [MAASI], [SUBE_ID]) VALUES (201, 4, N'Rusça Öğretmeni', N'Koç Üniversitesi', CAST(N'2023-05-01' AS Date), N'Aktif', 30000.0000, 1)
INSERT [dbo].[Bireyler.Ogretmenler] ([ID], [BIREY_ID], [BRANS], [EGITIM_DURUMU], [ISE_BASLAMA_TARIHI], [CALISMA_DURUMU], [MAASI], [SUBE_ID]) VALUES (301, 5, N'Almanca Öğretmeni', N'Ege Üniversitesi', CAST(N'2025-07-01' AS Date), N'Aktif', 35000.0000, 1)
INSERT [dbo].[Bireyler.Ogretmenler] ([ID], [BIREY_ID], [BRANS], [EGITIM_DURUMU], [ISE_BASLAMA_TARIHI], [CALISMA_DURUMU], [MAASI], [SUBE_ID]) VALUES (401, 6, N'Çince Öğretmeni', N'Dokuz Eylül Üniversitesi Lisans mezunu', CAST(N'2021-01-01' AS Date), N'Aktif', 39000.0000, 2)
INSERT [dbo].[Bireyler.Ogretmenler] ([ID], [BIREY_ID], [BRANS], [EGITIM_DURUMU], [ISE_BASLAMA_TARIHI], [CALISMA_DURUMU], [MAASI], [SUBE_ID]) VALUES (501, 7, N'Japonca Öğretmeni', N'Dıkuz Eylül Üniversitesi', CAST(N'2025-04-01' AS Date), N'Aktif', 30000.0000, 2)
INSERT [dbo].[Bireyler.Ogretmenler] ([ID], [BIREY_ID], [BRANS], [EGITIM_DURUMU], [ISE_BASLAMA_TARIHI], [CALISMA_DURUMU], [MAASI], [SUBE_ID]) VALUES (601, 8, N'Korece Öğretmeni', N'Koç Üniversitesi Lisans mezunu', CAST(N'2022-03-01' AS Date), N'Aktif', 37000.0000, 2)
INSERT [dbo].[Bireyler.Ogretmenler] ([ID], [BIREY_ID], [BRANS], [EGITIM_DURUMU], [ISE_BASLAMA_TARIHI], [CALISMA_DURUMU], [MAASI], [SUBE_ID]) VALUES (801, 9, N'Inglizce Öğretmeni', N'Ankara Üniversitesi', CAST(N'2023-11-01' AS Date), N'Aktif', 37000.0000, 2)
SET IDENTITY_INSERT [dbo].[Bireyler.Ogretmenler] OFF
GO
SET IDENTITY_INSERT [dbo].[Bireyler.Personeller] ON 

INSERT [dbo].[Bireyler.Personeller] ([ID], [BIREY_ID], [GOREV], [MAAS], [SUBE_ID], [ISE_BASLAMA_TARIHI], [DURUM]) VALUES (1, 10, N'Müdür', 50000.0000, 1, CAST(N'2018-05-01' AS Date), N'Aktif')
INSERT [dbo].[Bireyler.Personeller] ([ID], [BIREY_ID], [GOREV], [MAAS], [SUBE_ID], [ISE_BASLAMA_TARIHI], [DURUM]) VALUES (2, 11, N'Müdür', 50000.0000, 2, CAST(N'2023-01-01' AS Date), N'Aktif')
INSERT [dbo].[Bireyler.Personeller] ([ID], [BIREY_ID], [GOREV], [MAAS], [SUBE_ID], [ISE_BASLAMA_TARIHI], [DURUM]) VALUES (3, 12, N'Resepsyon', 25000.0000, 1, CAST(N'2023-01-01' AS Date), N'Aktif')
INSERT [dbo].[Bireyler.Personeller] ([ID], [BIREY_ID], [GOREV], [MAAS], [SUBE_ID], [ISE_BASLAMA_TARIHI], [DURUM]) VALUES (4, 13, N'Resepsyon', 25000.0000, 2, CAST(N'2025-09-01' AS Date), N'Aktif')
INSERT [dbo].[Bireyler.Personeller] ([ID], [BIREY_ID], [GOREV], [MAAS], [SUBE_ID], [ISE_BASLAMA_TARIHI], [DURUM]) VALUES (5, 14, N'Temizlikçi', 27000.0000, 1, CAST(N'2018-11-01' AS Date), N'Aktif')
INSERT [dbo].[Bireyler.Personeller] ([ID], [BIREY_ID], [GOREV], [MAAS], [SUBE_ID], [ISE_BASLAMA_TARIHI], [DURUM]) VALUES (6, 15, N'Temizlikçi', 27000.0000, 2, CAST(N'2025-03-01' AS Date), N'Aktif')
INSERT [dbo].[Bireyler.Personeller] ([ID], [BIREY_ID], [GOREV], [MAAS], [SUBE_ID], [ISE_BASLAMA_TARIHI], [DURUM]) VALUES (7, 16, N'Resepsyon', 25000.0000, 2, CAST(N'2023-06-01' AS Date), N'Ayrıldı')
INSERT [dbo].[Bireyler.Personeller] ([ID], [BIREY_ID], [GOREV], [MAAS], [SUBE_ID], [ISE_BASLAMA_TARIHI], [DURUM]) VALUES (8, 17, N'Temizlikçi', 27000.0000, 2, CAST(N'2023-08-01' AS Date), N'Ayrıldı')
SET IDENTITY_INSERT [dbo].[Bireyler.Personeller] OFF
GO
SET IDENTITY_INSERT [dbo].[Bireyler.Veliler] ON 

INSERT [dbo].[Bireyler.Veliler] ([ID], [OGRENCI_ID], [VELI_ID], [NOTLAR]) VALUES (2, 6, 42, NULL)
INSERT [dbo].[Bireyler.Veliler] ([ID], [OGRENCI_ID], [VELI_ID], [NOTLAR]) VALUES (3, 10, 43, NULL)
INSERT [dbo].[Bireyler.Veliler] ([ID], [OGRENCI_ID], [VELI_ID], [NOTLAR]) VALUES (4, 4, 44, NULL)
INSERT [dbo].[Bireyler.Veliler] ([ID], [OGRENCI_ID], [VELI_ID], [NOTLAR]) VALUES (5, 17, 45, NULL)
INSERT [dbo].[Bireyler.Veliler] ([ID], [OGRENCI_ID], [VELI_ID], [NOTLAR]) VALUES (6, 16, 46, NULL)
SET IDENTITY_INSERT [dbo].[Bireyler.Veliler] OFF
GO
SET IDENTITY_INSERT [dbo].[Epostalar] ON 

INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (5, N'bekiragaoglu65@gmail.com', 3)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (6, N'bekiragaoglu@gmail.com', 3)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (7, N'aliaslan1111@gmail.com', 4)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (8, N'canercaneracikgoz@gmail.com', 2)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (9, N'ertekinuyanik@hotmail.com', 5)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (10, N'gulbaharsevindi95@gmail.com', 9)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (11, N'altinsukuriyeee@gmail.com', 10)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (12, N'maksatziyafe@gmail.com', 11)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (13, N'temelergul312@gmail.com', 12)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (14, N'ersincalisanizmir@gmail.com', 13)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (15, N'fatmagulaitekin@gmail.com', 14)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (16, N'aysenakbaralikizi@gmail.com', 16)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (17, N'sevincsevinc@gamail.com', 17)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (18, N'lemiakaracay35@gmail.com', 18)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (19, N'umidakilli@hotmail.com', 19)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (20, N'aysenakfiratadana@gmail.com', 20)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (21, N'atakerenakca@gmail.com', 22)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (22, N'yasarutku@gmail.com', 25)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (23, N'buraktatkan48@hotmail.com', 26)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (24, N'mertaydin@gmail.com', 27)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (25, N'hayriyecan4789@gmail.com', 28)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (26, N'mustafacanbek@gmail.com', 30)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (27, N'abdullahemirhannn@gmail.com', 31)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (28, N'senanurcardaklar@gmail.com', 32)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (29, N'cansucansuyaprak@gmail.com', 33)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (30, N'yagmurdursun@gmail.com', 34)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (31, N'ahmetyilmaz@gmail.com', 35)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (32, N'seyitbirak@gmail.com', 36)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (33, N'cankizbural@gmail.com', 37)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (34, N'zeynepbusraburalı@gmail.com', 38)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (35, N'deryaergun@gmail.com', 39)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (36, N'samedzorlu@gmail.com', 43)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (37, N'erkochanif@gmail.com', 44)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (38, N'zeynepsevinc@gmail.com', 46)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (39, N'natalyfiofor@gmail.com', 47)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (40, N'vladimirkapchuk@gmail.com', 48)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (41, N'nuryizkadiralieva@gmail.com', 50)
INSERT [dbo].[Epostalar] ([ID], [EPOSTA], [BIREY_ID]) VALUES (42, N'gabrinaholms@gmail.com', 51)
SET IDENTITY_INSERT [dbo].[Epostalar] OFF
GO
SET IDENTITY_INSERT [dbo].[Kurslar] ON 

INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (1, 1, 2, N'3 ay', CAST(10000.00 AS Decimal(18, 2)), 30, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (2, 2, 2, N'3 ay', CAST(10000.00 AS Decimal(18, 2)), 50, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (3, 3, 2, N'3 ay', CAST(15000.00 AS Decimal(18, 2)), 50, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (4, 3, 2, N'3 ay', CAST(13000.00 AS Decimal(18, 2)), 50, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (5, 2, 2, N'3 ay', CAST(10000.00 AS Decimal(18, 2)), 30, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (6, 4, 2, N'3 ay', CAST(15000.00 AS Decimal(18, 2)), 50, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (7, 4, 2, N'3 ay', CAST(13000.00 AS Decimal(18, 2)), 50, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (8, 1, 1, N'3 ay', CAST(12000.00 AS Decimal(18, 2)), 30, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (9, 1, 1, N'3 ay', CAST(10000.00 AS Decimal(18, 2)), 30, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (10, 2, 1, N'3 ay', CAST(12000.00 AS Decimal(18, 2)), 30, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (11, 3, 1, N'3 ay', CAST(15000.00 AS Decimal(18, 2)), 40, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (12, 4, 1, N'3 ay', CAST(15000.00 AS Decimal(18, 2)), 40, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (13, 5, 1, N'3 ay', CAST(15000.00 AS Decimal(18, 2)), 40, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (14, 6, 1, N'3 ay', CAST(15000.00 AS Decimal(18, 2)), 40, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (15, 1, 3, N'4 ay', CAST(15000.00 AS Decimal(18, 2)), 20, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (16, 2, 3, N'4 ay', CAST(15000.00 AS Decimal(18, 2)), 20, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (17, 3, 3, N'4 ay', CAST(18000.00 AS Decimal(18, 2)), 20, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (18, 4, 3, N'4 ay', CAST(18000.00 AS Decimal(18, 2)), 20, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (19, 1, 5, N'2 ay', CAST(18000.00 AS Decimal(18, 2)), 15, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (20, 2, 5, N'3 ay', CAST(18000.00 AS Decimal(18, 2)), 15, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (21, 3, 5, N'3 ay', CAST(18000.00 AS Decimal(18, 2)), 15, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (22, 4, 5, N'2 ay', CAST(15000.00 AS Decimal(18, 2)), 15, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (23, 5, 5, N'3 ay', CAST(18000.00 AS Decimal(18, 2)), 15, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (24, 1, 7, N'4 ay', CAST(15000.00 AS Decimal(18, 2)), 10, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (25, 2, 7, N'4 ay', CAST(15000.00 AS Decimal(18, 2)), 10, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (26, 3, 7, N'4 ay', CAST(15000.00 AS Decimal(18, 2)), 10, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (27, 1, 6, N'4 ay', CAST(15000.00 AS Decimal(18, 2)), 10, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (28, 2, 6, N'4 ay', CAST(15000.00 AS Decimal(18, 2)), 10, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (29, 1, 8, N'3 ay', CAST(18000.00 AS Decimal(18, 2)), 15, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (30, 2, 8, N'3 ay', CAST(18000.00 AS Decimal(18, 2)), 15, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (35, 1, 2, N'3 ay', CAST(9000.00 AS Decimal(18, 2)), 30, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (37, 2, 2, N'3 Ay', CAST(9000.00 AS Decimal(18, 2)), 30, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (38, 1, 7, N'3 ay', CAST(20000.00 AS Decimal(18, 2)), 15, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (39, 1, 2, N'3 ay', CAST(9000.00 AS Decimal(18, 2)), 30, 2)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (40, 4, 3, N'4 ay', CAST(16000.00 AS Decimal(18, 2)), 20, 1)
INSERT [dbo].[Kurslar] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID]) VALUES (41, 1, 1, N'4 ay', CAST(18000.00 AS Decimal(18, 2)), 20, 1)
SET IDENTITY_INSERT [dbo].[Kurslar] OFF
GO
SET IDENTITY_INSERT [dbo].[Kurslar.Diller] ON 

INSERT [dbo].[Kurslar.Diller] ([ID], [DIL]) VALUES (1, N'Türkçe')
INSERT [dbo].[Kurslar.Diller] ([ID], [DIL]) VALUES (2, N'Inglizce')
INSERT [dbo].[Kurslar.Diller] ([ID], [DIL]) VALUES (3, N'Rusça')
INSERT [dbo].[Kurslar.Diller] ([ID], [DIL]) VALUES (4, N'Fransızca')
INSERT [dbo].[Kurslar.Diller] ([ID], [DIL]) VALUES (5, N'Almanca')
INSERT [dbo].[Kurslar.Diller] ([ID], [DIL]) VALUES (6, N'Çınce')
INSERT [dbo].[Kurslar.Diller] ([ID], [DIL]) VALUES (7, N'Japonca')
INSERT [dbo].[Kurslar.Diller] ([ID], [DIL]) VALUES (8, N'Korece')
SET IDENTITY_INSERT [dbo].[Kurslar.Diller] OFF
GO
SET IDENTITY_INSERT [dbo].[Kurslar.Kayitlar] ON 

INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (1, 1, 2, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (2, 2, 1, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (3, 3, 3, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (4, 4, 6, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (5, 5, 4, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (6, 6, 5, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (7, 7, 10, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (8, 8, 7, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (9, 9, 8, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (10, 10, 9, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (12, 11, 16, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (13, 12, 15, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (19, 14, 11, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (20, 15, 12, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (21, 16, 13, CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (23, 20, 5, CAST(N'2025-05-01' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (24, 4, 1, CAST(N'2025-05-01' AS Date))
INSERT [dbo].[Kurslar.Kayitlar] ([ID], [DERS_PROGRAM_ID], [OGRENCI_ID], [KAYIT_TARIHI]) VALUES (25, 21, 5, CAST(N'2025-05-01' AS Date))
SET IDENTITY_INSERT [dbo].[Kurslar.Kayitlar] OFF
GO
SET IDENTITY_INSERT [dbo].[Kurslar.Programlar] ON 

INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (1, 8, 3, N'1,3,5', CAST(N'14:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (2, 8, 3, N'2,4,6', CAST(N'14:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (3, 1, 5, N'1,3,5', CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 101)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (4, 1, 5, N'1,2,3', CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 101)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (5, 2, 6, N'2,5,6', CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 101)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (6, 15, 9, N'1,3,5', CAST(N'12:00:00' AS Time), CAST(N'15:00:00' AS Time), 201)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (7, 16, 9, N'2,5,6', CAST(N'12:00:00' AS Time), CAST(N'15:00:00' AS Time), 201)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (8, 19, 10, N'1,3,5', CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 301)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (9, 19, 10, N'2,4,6', CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 301)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (10, 25, 11, N'1,3,5', CAST(N'09:00:00' AS Time), CAST(N'12:00:00' AS Time), 501)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (11, 24, 11, N'1,3,5', CAST(N'09:00:00' AS Time), CAST(N'12:00:00' AS Time), 501)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (12, 10, 5, N'2,4,6', CAST(N'09:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (14, 11, 3, N'1.3,5', CAST(N'09:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (15, 2, 5, N'1,3,5', CAST(N'14:00:00' AS Time), CAST(N'17:00:00' AS Time), 101)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (16, 3, 6, N'2,4,6', CAST(N'11:00:00' AS Time), CAST(N'14:00:00' AS Time), 101)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (20, 35, 1, N'Pazartesi, Çarşamba, Cuma', CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[Kurslar.Programlar] ([ID], [KURS_ID], [SINIF_ID], [GUNLER], [BASLANGIC_SAATI], [BITIS_SAATI], [OGRETMEN_ID]) VALUES (21, 39, 1, N'Pazartesi, Çarşamba, Cuma', CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
SET IDENTITY_INSERT [dbo].[Kurslar.Programlar] OFF
GO
SET IDENTITY_INSERT [dbo].[Kurslar.Sevıyeler] ON 

INSERT [dbo].[Kurslar.Sevıyeler] ([ID], [SEVIYE]) VALUES (1, N'A1')
INSERT [dbo].[Kurslar.Sevıyeler] ([ID], [SEVIYE]) VALUES (2, N'A2')
INSERT [dbo].[Kurslar.Sevıyeler] ([ID], [SEVIYE]) VALUES (3, N'B1')
INSERT [dbo].[Kurslar.Sevıyeler] ([ID], [SEVIYE]) VALUES (4, N'B2')
INSERT [dbo].[Kurslar.Sevıyeler] ([ID], [SEVIYE]) VALUES (5, N'C1')
INSERT [dbo].[Kurslar.Sevıyeler] ([ID], [SEVIYE]) VALUES (6, N'C2')
SET IDENTITY_INSERT [dbo].[Kurslar.Sevıyeler] OFF
GO
SET IDENTITY_INSERT [dbo].[Kurslar.Turler] ON 

INSERT [dbo].[Kurslar.Turler] ([TUR_ID], [TURU]) VALUES (1, N'Yüz Yüze')
INSERT [dbo].[Kurslar.Turler] ([TUR_ID], [TURU]) VALUES (2, N'Online')
SET IDENTITY_INSERT [dbo].[Kurslar.Turler] OFF
GO
INSERT [dbo].[Kurslar_Yedek] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID], [EKLENME_TARIHI], [EKLEYEN_KULLANICI], [SILINDI_MI]) VALUES (36, 1, 2, N'3 Ay', CAST(9000.00 AS Decimal(10, 2)), 30, 1, CAST(N'2025-05-01T18:28:03.223' AS DateTime), N'sa', 0)
INSERT [dbo].[Kurslar_Yedek] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID], [EKLENME_TARIHI], [EKLEYEN_KULLANICI], [SILINDI_MI]) VALUES (37, 2, 2, N'3 Ay', CAST(9000.00 AS Decimal(10, 2)), 30, 1, CAST(N'2025-05-01T18:36:41.330' AS DateTime), N'sa', 1)
INSERT [dbo].[Kurslar_Yedek] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID], [EKLENME_TARIHI], [EKLEYEN_KULLANICI], [SILINDI_MI]) VALUES (38, 1, 7, N'3 ay', CAST(20000.00 AS Decimal(10, 2)), 15, 1, CAST(N'2025-05-01T18:44:54.417' AS DateTime), N'sa', 0)
INSERT [dbo].[Kurslar_Yedek] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID], [EKLENME_TARIHI], [EKLEYEN_KULLANICI], [SILINDI_MI]) VALUES (39, 1, 2, N'3 ay', CAST(9000.00 AS Decimal(10, 2)), 30, 2, CAST(N'2025-05-01T20:38:43.020' AS DateTime), N'sa', 0)
INSERT [dbo].[Kurslar_Yedek] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID], [EKLENME_TARIHI], [EKLEYEN_KULLANICI], [SILINDI_MI]) VALUES (41, 1, 1, N'4 ay', CAST(18000.00 AS Decimal(10, 2)), 20, 1, CAST(N'2025-05-02T19:53:14.180' AS DateTime), N'sa', 0)
INSERT [dbo].[Kurslar_Yedek] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID], [EKLENME_TARIHI], [EKLEYEN_KULLANICI], [SILINDI_MI]) VALUES (40, 4, 3, N'4 ay', CAST(16000.00 AS Decimal(10, 2)), 20, 1, CAST(N'2025-05-02T19:51:22.957' AS DateTime), N'sa', 0)
GO
INSERT [dbo].[Kurslar_Yedek1] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID], [EKLENME_TARIHI], [EKLEYEN_KULLANICI], [SILINDI_MI]) VALUES (40, 4, 3, N'4 ay', CAST(16000.00 AS Decimal(10, 2)), 20, 1, CAST(N'2025-05-02T19:51:22.990' AS DateTime), N'DESKTOP-F10UNK6', 0)
INSERT [dbo].[Kurslar_Yedek1] ([ID], [SEVIYE_ID], [DIL_ID], [SURESI], [UCRETI], [KONTENJAN], [TUR_ID], [EKLENME_TARIHI], [EKLEYEN_KULLANICI], [SILINDI_MI]) VALUES (41, 1, 1, N'4 ay', CAST(18000.00 AS Decimal(10, 2)), 20, 1, CAST(N'2025-05-02T19:53:14.207' AS DateTime), N'DESKTOP-F10UNK6', 0)
GO
SET IDENTITY_INSERT [dbo].[Notlar] ON 

INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (1, 1, 1, CAST(80.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (2, 2, 1, CAST(90.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (3, 3, 1, CAST(100.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (4, 4, 1, CAST(67.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (5, 7, 1, CAST(83.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (6, 5, 1, CAST(72.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (7, 1, 3, CAST(79.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (8, 2, 3, CAST(84.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (9, 3, 3, CAST(51.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (10, 4, 3, CAST(74.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (11, 7, 3, CAST(94.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (12, 5, 3, CAST(98.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (13, 6, 3, CAST(78.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (14, 1, 4, CAST(84.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (15, 2, 4, CAST(75.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (16, 3, 4, CAST(89.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (17, 4, 4, CAST(70.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (18, 5, 4, CAST(45.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (19, 6, 4, CAST(57.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), 1)
INSERT [dbo].[Notlar] ([ID], [OGRENCI_ID], [SINAV_TURU_ID], [PUAN], [TARIH], [OGRETMEN_ID]) VALUES (20, 7, 4, CAST(98.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Notlar] OFF
GO
SET IDENTITY_INSERT [dbo].[Notlar.SinavTurleri] ON 

INSERT [dbo].[Notlar.SinavTurleri] ([ID], [SINAV_TURU]) VALUES (1, N'Writing')
INSERT [dbo].[Notlar.SinavTurleri] ([ID], [SINAV_TURU]) VALUES (2, N'Reading')
INSERT [dbo].[Notlar.SinavTurleri] ([ID], [SINAV_TURU]) VALUES (3, N'Odevler')
INSERT [dbo].[Notlar.SinavTurleri] ([ID], [SINAV_TURU]) VALUES (4, N'Sınav')
SET IDENTITY_INSERT [dbo].[Notlar.SinavTurleri] OFF
GO
SET IDENTITY_INSERT [dbo].[Odemeler] ON 

INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (1, 1, 10, CAST(5000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-04-30' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (2, 2, 9, CAST(8000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-02-15' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (3, 3, 8, CAST(10000.00 AS Decimal(18, 2)), N'1', CAST(N'2024-12-01' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (4, 4, 7, CAST(5000.00 AS Decimal(18, 2)), N'2', CAST(N'2025-01-07' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (5, 3, 8, CAST(8000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-02-09' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (6, 5, 10, CAST(10000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-04-29' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (7, 2, 9, CAST(10000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-04-21' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (8, 4, 7, CAST(5000.00 AS Decimal(18, 2)), N'2', CAST(N'2025-03-17' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (9, 2, 9, CAST(10000.00 AS Decimal(18, 2)), N'2', CAST(N'2025-04-05' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (10, 6, 6, CAST(3000.00 AS Decimal(18, 2)), N'2', CAST(N'2025-02-03' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (11, 7, 5, CAST(10000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-02-23' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (12, 8, 4, CAST(15000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-02-14' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (13, 6, 6, CAST(2000.00 AS Decimal(18, 2)), N'2', CAST(N'2025-03-01' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (14, 7, 5, CAST(5000.00 AS Decimal(18, 2)), N'2', CAST(N'2025-03-29' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (15, 6, 6, CAST(10000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-05-01' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (16, 9, 3, CAST(8000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-01-25' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (17, 10, 2, CAST(18000.00 AS Decimal(18, 2)), NULL, CAST(N'2025-05-01' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (18, 11, 1, CAST(5000.00 AS Decimal(18, 2)), N'2', CAST(N'2025-03-08' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (19, 12, 12, NULL, NULL, CAST(N'2025-05-01' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (20, 13, 13, CAST(8000.00 AS Decimal(18, 2)), N'1', CAST(N'2025-04-14' AS Date))
INSERT [dbo].[Odemeler] ([ID], [OGRENCI_ID], [KURS_KAYIT_ID], [ODEME_TUTARI], [ODEME_TURU_ID], [ODEME_TARIHI]) VALUES (24, 16, 19, CAST(5000.00 AS Decimal(18, 2)), N'2', CAST(N'2025-04-09' AS Date))
SET IDENTITY_INSERT [dbo].[Odemeler] OFF
GO
INSERT [dbo].[Odemeler.OdemeTurleri] ([ID], [ODEME_TURU]) VALUES (N'1', N'Nakit')
INSERT [dbo].[Odemeler.OdemeTurleri] ([ID], [ODEME_TURU]) VALUES (N'2', N'Kredi Kart')
GO
SET IDENTITY_INSERT [dbo].[Sertifikalar] ON 

INSERT [dbo].[Sertifikalar] ([ID], [OGRENCI_ID], [ORTALAMA_PUAN], [TARIHI], [BELGE_NUMARASI], [DURUM]) VALUES (1, 1, CAST(81.00 AS Decimal(5, 2)), CAST(N'2025-05-01' AS Date), NULL, N'Başarılı')
INSERT [dbo].[Sertifikalar] ([ID], [OGRENCI_ID], [ORTALAMA_PUAN], [TARIHI], [BELGE_NUMARASI], [DURUM]) VALUES (2, 2, CAST(83.00 AS Decimal(5, 2)), CAST(N'2025-05-01' AS Date), NULL, N'Başarılı')
INSERT [dbo].[Sertifikalar] ([ID], [OGRENCI_ID], [ORTALAMA_PUAN], [TARIHI], [BELGE_NUMARASI], [DURUM]) VALUES (3, 3, CAST(80.00 AS Decimal(5, 2)), CAST(N'2025-05-01' AS Date), NULL, N'Başarılı')
INSERT [dbo].[Sertifikalar] ([ID], [OGRENCI_ID], [ORTALAMA_PUAN], [TARIHI], [BELGE_NUMARASI], [DURUM]) VALUES (4, 4, CAST(70.33 AS Decimal(5, 2)), CAST(N'2025-05-01' AS Date), NULL, N'Başarılı')
INSERT [dbo].[Sertifikalar] ([ID], [OGRENCI_ID], [ORTALAMA_PUAN], [TARIHI], [BELGE_NUMARASI], [DURUM]) VALUES (5, 5, CAST(71.67 AS Decimal(5, 2)), CAST(N'2025-05-01' AS Date), NULL, N'Başarılı')
INSERT [dbo].[Sertifikalar] ([ID], [OGRENCI_ID], [ORTALAMA_PUAN], [TARIHI], [BELGE_NUMARASI], [DURUM]) VALUES (6, 6, CAST(67.50 AS Decimal(5, 2)), CAST(N'2025-05-01' AS Date), NULL, N'Başarılı')
SET IDENTITY_INSERT [dbo].[Sertifikalar] OFF
GO
SET IDENTITY_INSERT [dbo].[Siniflar] ON 

INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (1, N'M100', 15, N'Akıllı Tahta,Bilgisayar, Kamera', 1)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (2, N'M101', 20, N'Yazı Tahtası, Bilgisayar, Kamera', 1)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (3, N'M102', 30, N'Yazı Tahtası, Kamera, Hoparlör', 1)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (5, N'M103', 50, N'Akıllı Tahta, Bilgisayar, Kamera', 1)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (6, N'M104', 10, N'Yazı Tahtası, Bilgisayar, Kamera', 1)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (7, N'M105', 20, N'Akıllı Tahta, Bilgisayar, Kamera', 1)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (9, N'C01', 10, N'Bilgisayar, Beyaz tahta', 2)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (10, N'C02', 20, N'Bilgisayar, Beyaz tahta, Kamera', 2)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (11, N'C03', 15, N'Bilgisayar, Beyaz tahta', 2)
INSERT [dbo].[Siniflar] ([ID], [SINIF_NO], [KAPASITE], [DONANIM], [SUBE_ID]) VALUES (12, N'C04', 30, N'Bilgisayar, Beyaz tahta, Kamera', 2)
SET IDENTITY_INSERT [dbo].[Siniflar] OFF
GO
SET IDENTITY_INSERT [dbo].[Subeler] ON 

INSERT [dbo].[Subeler] ([ID], [SUBE_ADI], [ACILIS_TARIHI], [DURUMU], [TOPLAM_CALISANLAR], [KONUM]) VALUES (1, N'001', CAST(N'2018-05-10' AS Date), N'Aktif', 6, 0xE6100000010CD93D7958A8354340C5FEB27BF2203B40)
INSERT [dbo].[Subeler] ([ID], [SUBE_ADI], [ACILIS_TARIHI], [DURUMU], [TOPLAM_CALISANLAR], [KONUM]) VALUES (2, N'002', CAST(N'2023-01-01' AS Date), N'Aktif', 6, 0xE6100000010CE2E995B20C814440986E1283C0FA3C40)
SET IDENTITY_INSERT [dbo].[Subeler] OFF
GO
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'212', N'Istanbul Avrupa Yakası')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'216', N'Istanbul Anadolu Yakası')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'224', N'Bursa')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'228', N'Bilecik')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'232', N'Izmir')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'242', N'Antalya')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'248', N'Burdur')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'256', N'Aydın')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'258', N'Denizli')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'266', N'Balıkesir')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'272', N'Afyon')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'286', N'Çanakkale')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'312', N'Ankara')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'322', N'Adana')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'358', N'Amasya')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'364', N'Çorum')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'374', N'Bolu')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'376', N'Çankırı')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'378', N'Bartın')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'382', N'Aksaray')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'412', N'Diyarbakır')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'416', N'Adıyaman')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'426', N'Bingöl')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'434', N'Bitlis')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'458', N'Bayburt')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'466', N'Artvin')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'472', N'Ağrı')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'478', N'Ardahan')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'488', N'Batman')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'501', N'Türk Telekom')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'502', N'Türk Telekom')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'503', N'Türk Telekom')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'504', N'Türk Telekom')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'505', N'Türk Telekom')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'506', N'Türk Telekom')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'507', N'Türk Telekom')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'530', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'531', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'532', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'533', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'534', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'535', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'536', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'537', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'538', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'539', N'Turkcell')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'540', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'541', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'542', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'543', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'544', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'545', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'546', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'547', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'548', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'549', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'550', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'551', N'Türk Telekom')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'552', N'Vodafone')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'555', N'Megakom Bişkek')
INSERT [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU], [SEHIR]) VALUES (N'7894', N'Moskova')
GO
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+1  ', N'Amerika Birleşik Devletleri')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+30 ', N'Yunanistan')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+31 ', N'Hollanda')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+33 ', N'Fransa	')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+34 ', N'İspanya	')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+357', N'Kıbrıs')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+359', N'Bulgaristan')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+374', N'Ermenistan')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+375', N'Belarus')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+380', N'Ukrayna')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+39 ', N'İtalya')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+41 ', N'İsviçre')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+420', N'Çek Cumhuriyeti')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+44 ', N'Birleşik Krallık')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+45 ', N'Danimarka')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+46 ', N'İsveç')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+49 ', N'Almanya')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+54 ', N'Arjantin')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+55 ', N'Brezilya')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+61 ', N'Avustralya')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+62 ', N'Endonezya')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+7  ', N'Rusya')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+7 6', N'Kazakistan')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+81 ', N'Japonya')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+82 ', N'Güney Kore')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+84 ', N'Vietnam')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+86 ', N'Çin Halk Cumhuriyeti')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+90 ', N'Türkiye')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+91 ', N'Hindistan	')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+964', N'Irak	')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+971', N'Birleşik Arap Emirlikleri')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+98 ', N'İran	')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+993', N'Türkmenistan')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+994', N'Azerbaycan')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+995', N'Gürcistan')
INSERT [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU], [ULKE]) VALUES (N'+996', N'Kırgızistan	')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_BIREYLER]    Script Date: 2.05.2025 21:16:41 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_BIREYLER] ON [dbo].[Bireyler]
(
	[TC_KIMLIK_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Siniflar]    Script Date: 2.05.2025 21:16:41 ******/
CREATE NONCLUSTERED INDEX [IX_Siniflar] ON [dbo].[Siniflar]
(
	[SINIF_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bireyler.Ogrenciler] ADD  CONSTRAINT [DF_Bireyler.Ogrenciler_KAYIT_TARIHI]  DEFAULT (getdate()) FOR [KAYIT_TARIHI]
GO
ALTER TABLE [dbo].[Bireyler.Ogretmenler] ADD  CONSTRAINT [DF_Bireyler.Ogretmenler_CALISMA_DURUMU]  DEFAULT (N'Aktif') FOR [CALISMA_DURUMU]
GO
ALTER TABLE [dbo].[Bireyler.Personeller] ADD  CONSTRAINT [DF_Bireyler.Personeller_ISE_BASLAMA_TARIHI]  DEFAULT (getdate()) FOR [ISE_BASLAMA_TARIHI]
GO
ALTER TABLE [dbo].[Bireyler.Personeller] ADD  CONSTRAINT [DF_Bireyler.Personeller_DURUM]  DEFAULT (N'Aktif') FOR [DURUM]
GO
ALTER TABLE [dbo].[Kurslar.Kayitlar] ADD  CONSTRAINT [DF_Kurslar.Kayitlar_KAYIT_TARIHI]  DEFAULT (getdate()) FOR [KAYIT_TARIHI]
GO
ALTER TABLE [dbo].[Kurslar_Yedek] ADD  DEFAULT (getdate()) FOR [EKLENME_TARIHI]
GO
ALTER TABLE [dbo].[Kurslar_Yedek] ADD  DEFAULT ((0)) FOR [SILINDI_MI]
GO
ALTER TABLE [dbo].[Kurslar_Yedek1] ADD  DEFAULT (getdate()) FOR [EKLENME_TARIHI]
GO
ALTER TABLE [dbo].[Kurslar_Yedek1] ADD  DEFAULT ((0)) FOR [SILINDI_MI]
GO
ALTER TABLE [dbo].[Odemeler] ADD  CONSTRAINT [DF_Odemeler_ODEME_TARIHI]  DEFAULT (getdate()) FOR [ODEME_TARIHI]
GO
ALTER TABLE [dbo].[Subeler] ADD  CONSTRAINT [DF_Subeler_DURUMU]  DEFAULT (N'Aktif') FOR [DURUMU]
GO
ALTER TABLE [dbo].[Adresler]  WITH CHECK ADD  CONSTRAINT [FK_Adresler_Adresler.Iler] FOREIGN KEY([IL_ID])
REFERENCES [dbo].[Adresler.Iler] ([IL_ID])
GO
ALTER TABLE [dbo].[Adresler] CHECK CONSTRAINT [FK_Adresler_Adresler.Iler]
GO
ALTER TABLE [dbo].[Adresler]  WITH CHECK ADD  CONSTRAINT [FK_Adresler_Bireyler] FOREIGN KEY([BIREY_ID])
REFERENCES [dbo].[Bireyler] ([BIREY_ID])
GO
ALTER TABLE [dbo].[Adresler] CHECK CONSTRAINT [FK_Adresler_Bireyler]
GO
ALTER TABLE [dbo].[Adresler]  WITH CHECK ADD  CONSTRAINT [FK_Adresler_Subeler] FOREIGN KEY([SUBE_ID])
REFERENCES [dbo].[Subeler] ([ID])
GO
ALTER TABLE [dbo].[Adresler] CHECK CONSTRAINT [FK_Adresler_Subeler]
GO
ALTER TABLE [dbo].[Bireyler.AcilDurumdaYakinlari]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.AcilDurumdaYakinlari_Bireyler] FOREIGN KEY([YAKINI_ID])
REFERENCES [dbo].[Bireyler] ([BIREY_ID])
GO
ALTER TABLE [dbo].[Bireyler.AcilDurumdaYakinlari] CHECK CONSTRAINT [FK_Bireyler.AcilDurumdaYakinlari_Bireyler]
GO
ALTER TABLE [dbo].[Bireyler.AcilDurumdaYakinlari]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.AcilDurumdaYakinlari_Bireyler.Ogrenciler] FOREIGN KEY([OGRENCI_ID])
REFERENCES [dbo].[Bireyler.Ogrenciler] ([ID])
GO
ALTER TABLE [dbo].[Bireyler.AcilDurumdaYakinlari] CHECK CONSTRAINT [FK_Bireyler.AcilDurumdaYakinlari_Bireyler.Ogrenciler]
GO
ALTER TABLE [dbo].[Bireyler.Ogrenciler]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Ogrenciler_Bireyler] FOREIGN KEY([BIREY_ID])
REFERENCES [dbo].[Bireyler] ([BIREY_ID])
GO
ALTER TABLE [dbo].[Bireyler.Ogrenciler] CHECK CONSTRAINT [FK_Bireyler.Ogrenciler_Bireyler]
GO
ALTER TABLE [dbo].[Bireyler.Ogrenciler]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Ogrenciler_Bireyler.Ogrenciler] FOREIGN KEY([ID])
REFERENCES [dbo].[Bireyler.Ogrenciler] ([ID])
GO
ALTER TABLE [dbo].[Bireyler.Ogrenciler] CHECK CONSTRAINT [FK_Bireyler.Ogrenciler_Bireyler.Ogrenciler]
GO
ALTER TABLE [dbo].[Bireyler.Ogrenciler]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Ogrenciler_Subeler] FOREIGN KEY([SUBE_ID])
REFERENCES [dbo].[Subeler] ([ID])
GO
ALTER TABLE [dbo].[Bireyler.Ogrenciler] CHECK CONSTRAINT [FK_Bireyler.Ogrenciler_Subeler]
GO
ALTER TABLE [dbo].[Bireyler.Ogretmenler]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Ogretmenler_Bireyler] FOREIGN KEY([BIREY_ID])
REFERENCES [dbo].[Bireyler] ([BIREY_ID])
GO
ALTER TABLE [dbo].[Bireyler.Ogretmenler] CHECK CONSTRAINT [FK_Bireyler.Ogretmenler_Bireyler]
GO
ALTER TABLE [dbo].[Bireyler.Ogretmenler]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Ogretmenler_Subeler] FOREIGN KEY([SUBE_ID])
REFERENCES [dbo].[Subeler] ([ID])
GO
ALTER TABLE [dbo].[Bireyler.Ogretmenler] CHECK CONSTRAINT [FK_Bireyler.Ogretmenler_Subeler]
GO
ALTER TABLE [dbo].[Bireyler.Personeller]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Personeller_Bireyler] FOREIGN KEY([BIREY_ID])
REFERENCES [dbo].[Bireyler] ([BIREY_ID])
GO
ALTER TABLE [dbo].[Bireyler.Personeller] CHECK CONSTRAINT [FK_Bireyler.Personeller_Bireyler]
GO
ALTER TABLE [dbo].[Bireyler.Personeller]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Personeller_Subeler] FOREIGN KEY([SUBE_ID])
REFERENCES [dbo].[Subeler] ([ID])
GO
ALTER TABLE [dbo].[Bireyler.Personeller] CHECK CONSTRAINT [FK_Bireyler.Personeller_Subeler]
GO
ALTER TABLE [dbo].[Bireyler.Veliler]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Veliler_Bireyler] FOREIGN KEY([VELI_ID])
REFERENCES [dbo].[Bireyler] ([BIREY_ID])
GO
ALTER TABLE [dbo].[Bireyler.Veliler] CHECK CONSTRAINT [FK_Bireyler.Veliler_Bireyler]
GO
ALTER TABLE [dbo].[Bireyler.Veliler]  WITH CHECK ADD  CONSTRAINT [FK_Bireyler.Veliler_Bireyler.Ogrenciler] FOREIGN KEY([OGRENCI_ID])
REFERENCES [dbo].[Bireyler.Ogrenciler] ([ID])
GO
ALTER TABLE [dbo].[Bireyler.Veliler] CHECK CONSTRAINT [FK_Bireyler.Veliler_Bireyler.Ogrenciler]
GO
ALTER TABLE [dbo].[Epostalar]  WITH CHECK ADD  CONSTRAINT [FK_Epostalar_Bireyler] FOREIGN KEY([BIREY_ID])
REFERENCES [dbo].[Bireyler] ([BIREY_ID])
GO
ALTER TABLE [dbo].[Epostalar] CHECK CONSTRAINT [FK_Epostalar_Bireyler]
GO
ALTER TABLE [dbo].[Kurslar]  WITH CHECK ADD  CONSTRAINT [FK_Kurslar_Kurslar.Diller] FOREIGN KEY([DIL_ID])
REFERENCES [dbo].[Kurslar.Diller] ([ID])
GO
ALTER TABLE [dbo].[Kurslar] CHECK CONSTRAINT [FK_Kurslar_Kurslar.Diller]
GO
ALTER TABLE [dbo].[Kurslar]  WITH CHECK ADD  CONSTRAINT [FK_Kurslar_Kurslar.Sevıyeler] FOREIGN KEY([SEVIYE_ID])
REFERENCES [dbo].[Kurslar.Sevıyeler] ([ID])
GO
ALTER TABLE [dbo].[Kurslar] CHECK CONSTRAINT [FK_Kurslar_Kurslar.Sevıyeler]
GO
ALTER TABLE [dbo].[Kurslar]  WITH CHECK ADD  CONSTRAINT [FK_Kurslar_Kurslar.Turler] FOREIGN KEY([TUR_ID])
REFERENCES [dbo].[Kurslar.Turler] ([TUR_ID])
GO
ALTER TABLE [dbo].[Kurslar] CHECK CONSTRAINT [FK_Kurslar_Kurslar.Turler]
GO
ALTER TABLE [dbo].[Kurslar.Kayitlar]  WITH CHECK ADD  CONSTRAINT [FK_Kurslar.Kayitlar_Bireyler.Ogrenciler] FOREIGN KEY([OGRENCI_ID])
REFERENCES [dbo].[Bireyler.Ogrenciler] ([ID])
GO
ALTER TABLE [dbo].[Kurslar.Kayitlar] CHECK CONSTRAINT [FK_Kurslar.Kayitlar_Bireyler.Ogrenciler]
GO
ALTER TABLE [dbo].[Kurslar.Kayitlar]  WITH CHECK ADD  CONSTRAINT [FK_Kurslar.Kayitlar_Kurslar.Programlar] FOREIGN KEY([DERS_PROGRAM_ID])
REFERENCES [dbo].[Kurslar.Programlar] ([ID])
GO
ALTER TABLE [dbo].[Kurslar.Kayitlar] CHECK CONSTRAINT [FK_Kurslar.Kayitlar_Kurslar.Programlar]
GO
ALTER TABLE [dbo].[Kurslar.Programlar]  WITH CHECK ADD  CONSTRAINT [FK_Kurslar.Programlar_Bireyler.Ogretmenler] FOREIGN KEY([OGRETMEN_ID])
REFERENCES [dbo].[Bireyler.Ogretmenler] ([ID])
GO
ALTER TABLE [dbo].[Kurslar.Programlar] CHECK CONSTRAINT [FK_Kurslar.Programlar_Bireyler.Ogretmenler]
GO
ALTER TABLE [dbo].[Kurslar.Programlar]  WITH CHECK ADD  CONSTRAINT [FK_Kurslar.Programlar_Kurslar] FOREIGN KEY([KURS_ID])
REFERENCES [dbo].[Kurslar] ([ID])
GO
ALTER TABLE [dbo].[Kurslar.Programlar] CHECK CONSTRAINT [FK_Kurslar.Programlar_Kurslar]
GO
ALTER TABLE [dbo].[Kurslar.Programlar]  WITH CHECK ADD  CONSTRAINT [FK_Kurslar.Programlar_Siniflar] FOREIGN KEY([SINIF_ID])
REFERENCES [dbo].[Siniflar] ([ID])
GO
ALTER TABLE [dbo].[Kurslar.Programlar] CHECK CONSTRAINT [FK_Kurslar.Programlar_Siniflar]
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD  CONSTRAINT [FK_Notlar_Bireyler.Ogrenciler] FOREIGN KEY([OGRENCI_ID])
REFERENCES [dbo].[Bireyler.Ogrenciler] ([ID])
GO
ALTER TABLE [dbo].[Notlar] CHECK CONSTRAINT [FK_Notlar_Bireyler.Ogrenciler]
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD  CONSTRAINT [FK_Notlar_Bireyler.Ogretmenler] FOREIGN KEY([OGRETMEN_ID])
REFERENCES [dbo].[Bireyler.Ogretmenler] ([ID])
GO
ALTER TABLE [dbo].[Notlar] CHECK CONSTRAINT [FK_Notlar_Bireyler.Ogretmenler]
GO
ALTER TABLE [dbo].[Notlar]  WITH CHECK ADD  CONSTRAINT [FK_Notlar_Notlar.Turleri] FOREIGN KEY([SINAV_TURU_ID])
REFERENCES [dbo].[Notlar.SinavTurleri] ([ID])
GO
ALTER TABLE [dbo].[Notlar] CHECK CONSTRAINT [FK_Notlar_Notlar.Turleri]
GO
ALTER TABLE [dbo].[Odemeler]  WITH CHECK ADD  CONSTRAINT [FK_Odemeler_Bireyler.Ogrenciler] FOREIGN KEY([OGRENCI_ID])
REFERENCES [dbo].[Bireyler.Ogrenciler] ([ID])
GO
ALTER TABLE [dbo].[Odemeler] CHECK CONSTRAINT [FK_Odemeler_Bireyler.Ogrenciler]
GO
ALTER TABLE [dbo].[Odemeler]  WITH CHECK ADD  CONSTRAINT [FK_Odemeler_Kurslar.Kayitlar] FOREIGN KEY([KURS_KAYIT_ID])
REFERENCES [dbo].[Kurslar.Kayitlar] ([ID])
GO
ALTER TABLE [dbo].[Odemeler] CHECK CONSTRAINT [FK_Odemeler_Kurslar.Kayitlar]
GO
ALTER TABLE [dbo].[Odemeler]  WITH CHECK ADD  CONSTRAINT [FK_Odemeler_Odemeler.OdemeTurleri] FOREIGN KEY([ODEME_TURU_ID])
REFERENCES [dbo].[Odemeler.OdemeTurleri] ([ID])
GO
ALTER TABLE [dbo].[Odemeler] CHECK CONSTRAINT [FK_Odemeler_Odemeler.OdemeTurleri]
GO
ALTER TABLE [dbo].[Sertifikalar]  WITH CHECK ADD  CONSTRAINT [FK_Sertifikalar_Bireyler.Ogrenciler] FOREIGN KEY([OGRENCI_ID])
REFERENCES [dbo].[Bireyler.Ogrenciler] ([ID])
GO
ALTER TABLE [dbo].[Sertifikalar] CHECK CONSTRAINT [FK_Sertifikalar_Bireyler.Ogrenciler]
GO
ALTER TABLE [dbo].[Siniflar]  WITH CHECK ADD  CONSTRAINT [FK_Siniflar_Subeler] FOREIGN KEY([SUBE_ID])
REFERENCES [dbo].[Subeler] ([ID])
GO
ALTER TABLE [dbo].[Siniflar] CHECK CONSTRAINT [FK_Siniflar_Subeler]
GO
ALTER TABLE [dbo].[Telefonlar]  WITH CHECK ADD  CONSTRAINT [FK_Telefonlar_Bireyler] FOREIGN KEY([BIREY_ID])
REFERENCES [dbo].[Bireyler] ([BIREY_ID])
GO
ALTER TABLE [dbo].[Telefonlar] CHECK CONSTRAINT [FK_Telefonlar_Bireyler]
GO
ALTER TABLE [dbo].[Telefonlar]  WITH CHECK ADD  CONSTRAINT [FK_Telefonlar_Subeler] FOREIGN KEY([SUBE_ID])
REFERENCES [dbo].[Subeler] ([ID])
GO
ALTER TABLE [dbo].[Telefonlar] CHECK CONSTRAINT [FK_Telefonlar_Subeler]
GO
ALTER TABLE [dbo].[Telefonlar]  WITH CHECK ADD  CONSTRAINT [FK_Telefonlar_Telefonlar.AlanKodu] FOREIGN KEY([ALAN_KODU])
REFERENCES [dbo].[Telefonlar.AlanKodu] ([ALAN_KODU])
GO
ALTER TABLE [dbo].[Telefonlar] CHECK CONSTRAINT [FK_Telefonlar_Telefonlar.AlanKodu]
GO
ALTER TABLE [dbo].[Telefonlar]  WITH CHECK ADD  CONSTRAINT [FK_Telefonlar_Telefonlar.Ulkeler] FOREIGN KEY([ULKE_KODU])
REFERENCES [dbo].[Telefonlar.Ulkeler] ([ULKE_KODU])
GO
ALTER TABLE [dbo].[Telefonlar] CHECK CONSTRAINT [FK_Telefonlar_Telefonlar.Ulkeler]
GO
ALTER TABLE [dbo].[Bireyler]  WITH CHECK ADD  CONSTRAINT [chk_cinsiyet] CHECK  ((upper([CINSIYET])='K' OR upper([CINSIYET])='E'))
GO
ALTER TABLE [dbo].[Bireyler] CHECK CONSTRAINT [chk_cinsiyet]
GO
/****** Object:  StoredProcedure [dbo].[BasariDurumuSertifikalaraEkle]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BasariDurumuSertifikalaraEkle]
AS
BEGIN
   
    UPDATE Sertifikalar
    SET DURUM = 
        CASE 
            WHEN ORTALAMA_PUAN >= 60 THEN 'Başarılı'
            ELSE 'Başarısız'
        END
    WHERE DURUM IS NULL;  
END;
GO
/****** Object:  StoredProcedure [dbo].[EklemeTransactionu]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EklemeTransactionu]
    @SEVIYE_ID INT,
    @DIL_ID INT,
    @SURESI VARCHAR(50),
    @UCRETI DECIMAL(10,2),
    @KONTENJAN INT,
    @TUR_ID INT,
    @SINIF_ID INT,
    @GUNLER VARCHAR(100),
    @BASLANGIC_SAATI TIME,
    @BITIS_SAATI TIME,
    @OGRETMEN_ID INT,
    @OGRENCI_ID INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Kurs ekle
    INSERT INTO KURSLAR (SEVIYE_ID, DIL_ID, SURESI, UCRETI, KONTENJAN, TUR_ID)
    VALUES (@SEVIYE_ID, @DIL_ID, @SURESI, @UCRETI, @KONTENJAN, @TUR_ID);

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Eklenen kursun ID'sini al
    DECLARE @KURS_ID INT = SCOPE_IDENTITY();

    -- Program ekle
    INSERT INTO KURSLAR.PROGRAMLAR (KURS_ID, SINIF_ID, GUNLER, BASLANGIC_SAATI, BITIS_SAATI, OGRETMEN_ID)
    VALUES (@KURS_ID, @SINIF_ID, @GUNLER, @BASLANGIC_SAATI, @BITIS_SAATI, @OGRETMEN_ID);

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Eklenen programın ID'sini al
    DECLARE @DERS_PROGRAM_ID INT = SCOPE_IDENTITY();

    -- Kayıt ekle
    INSERT INTO KURSLAR.KAYITLAR (DERS_PROGRAM_ID, OGRENCI_ID, KAYIT_TARIHI)
    VALUES (@DERS_PROGRAM_ID, @OGRENCI_ID, GETDATE());

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

    COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[OrtalamaHesaplaVeSertifikalaraEkle]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrtalamaHesaplaVeSertifikalaraEkle]
    @OgrenciID INT
AS
BEGIN
    DECLARE @Ortalama DECIMAL(5,2);

    SELECT @Ortalama = AVG(CAST(puan AS DECIMAL(5,2)))
    FROM Notlar
    WHERE OGRENCI_ID = @OgrenciID;

    INSERT INTO Sertifikalar ([OGRENCI_ID],[ORTALAMA_PUAN] ,[TARIHI])
    VALUES (@OgrenciID, @Ortalama, GETDATE());
END;
GO
/****** Object:  StoredProcedure [dbo].[SertifikaSil]    Script Date: 2.05.2025 21:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SertifikaSil]
    @OgrenciID INT
AS
BEGIN
    DELETE FROM Sertifikalar
    WHERE OGRENCI_ID = @OgrenciID;
END;
GO
USE [master]
GO
ALTER DATABASE [LanguageCenter] SET  READ_WRITE 
GO
