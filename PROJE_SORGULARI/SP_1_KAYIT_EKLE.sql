CREATE PROCEDURE OrtalamaHesaplaVeSertifikalaraEkle
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

EXEC OrtalamaHesaplaVeSertifikalaraEkle @OgrenciID = 6;


select * from Sertifikalar
select * from notlar

