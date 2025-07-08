CREATE FUNCTION dbo.fn_OdemesizOgrenciler()
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT O.ID AS OgrenciID, O.BIREY_ID, O.EGITIM_DURUMU, O.KAYIT_TARIHI, O.SUBE_ID
    FROM [dbo].[Bireyler.Ogrenciler] O
    INNER JOIN [dbo].[Kurslar.Kayitlar] K ON O.ID = K.OGRENCI_ID
    LEFT JOIN [dbo].[Odemeler] OD ON O.ID = OD.OGRENCI_ID
    WHERE OD.ID IS NULL  -- ödeme kaydý olmayanlar
);
SELECT * FROM dbo.fn_OdemesizOgrenciler();
select * from Odemeler
