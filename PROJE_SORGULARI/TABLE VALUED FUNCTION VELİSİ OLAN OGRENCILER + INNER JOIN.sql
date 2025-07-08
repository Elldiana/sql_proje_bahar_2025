SELECT O.ID AS OgrenciID, O.BIREY_ID, O.EGITIM_DURUMU, O.KAYIT_TARIHI, O.SUBE_ID
FROM [dbo].[Bireyler.Ogrenciler] O
INNER JOIN [dbo].[Bireyler.Veliler] V ON O.ID = V.OGRENCI_ID;


--Ogrencýlerin velisi olanlarý lýstele

CREATE FUNCTION dbo.fn_VelisiOlanOgrenciler()
RETURNS TABLE
AS
RETURN
(
    SELECT O.ID AS OgrenciID, O.BIREY_ID, O.EGITIM_DURUMU, O.KAYIT_TARIHI, O.SUBE_ID
    FROM [dbo].[Bireyler.Ogrenciler] O
    INNER JOIN [dbo].[Bireyler.Veliler] V ON O.ID = V.OGRENCI_ID
);

select * from dbo.fn_VelisiOlanOgrenciler();
