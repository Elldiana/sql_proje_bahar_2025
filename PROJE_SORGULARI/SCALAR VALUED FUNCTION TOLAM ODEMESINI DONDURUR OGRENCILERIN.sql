CREATE FUNCTION fn_OgrenciToplamOdeme (@OGRENCI_ID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Toplam DECIMAL(10,2);
    
    SELECT @Toplam = SUM(ODEME_TUTARI)
    FROM Odemeler
    WHERE OGRENCI_ID = @OGRENCI_ID;
    
    RETURN ISNULL(@Toplam, 0);
END

SELECT dbo.fn_OgrenciToplamOdeme(2) AS ToplamOdeme;
SELECT * FROM Odemeler