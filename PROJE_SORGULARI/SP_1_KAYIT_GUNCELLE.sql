CREATE PROCEDURE BasariDurumuSertifikalaraEkle
AS
BEGIN
   
    UPDATE Sertifikalar
    SET DURUM = 
        CASE 
            WHEN ORTALAMA_PUAN >= 60 THEN 'Baþarýlý'
            ELSE 'Baþarýsýz'
        END
    WHERE DURUM IS NULL;  
END;

EXEC BasariDurumuSertifikalaraEkle;

select * from Sertifikalar

