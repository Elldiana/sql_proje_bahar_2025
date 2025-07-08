CREATE PROCEDURE BasariDurumuSertifikalaraEkle
AS
BEGIN
   
    UPDATE Sertifikalar
    SET DURUM = 
        CASE 
            WHEN ORTALAMA_PUAN >= 60 THEN 'Ba�ar�l�'
            ELSE 'Ba�ar�s�z'
        END
    WHERE DURUM IS NULL;  
END;

EXEC BasariDurumuSertifikalaraEkle;

select * from Sertifikalar

