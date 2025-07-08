CREATE FUNCTION fn_OgrenciKursKayitSayisi (@OGRENCI_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @KayitSayisi INT;

    SELECT @KayitSayisi = COUNT(*)
    FROM [dbo].[Kurslar.Kayitlar]
    WHERE OGRENCI_ID = @OGRENCI_ID;

    RETURN @KayitSayisi;
END;

SELECT dbo.fn_OgrenciKursKayitSayisi(1) AS KayitSayisi;

SELECT * FROM [Kurslar.Kayitlar]
