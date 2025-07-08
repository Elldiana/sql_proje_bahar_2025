CREATE TRIGGER trg_Kurslar_Update
ON Kurslar
AFTER UPDATE
AS
BEGIN
    UPDATE Kurslar_Yedek
    SET 
        Kurslar_Yedek.SEVIYE_ID = inserted.SEVIYE_ID,
        Kurslar_Yedek.DIL_ID = inserted.DIL_ID,
        Kurslar_Yedek.SURESI = inserted.SURESI,
        Kurslar_Yedek.UCRETI = inserted.UCRETI,
        Kurslar_Yedek.KONTENJAN = inserted.KONTENJAN,
        Kurslar_Yedek.TUR_ID = inserted.TUR_ID
    FROM Kurslar_Yedek
    INNER JOIN inserted 
        ON Kurslar_Yedek.ID = inserted.ID;
END;

-- KONTROL
INSERT INTO Kurslar (SEVIYE_ID, DIL_ID, SURESI, UCRETI, KONTENJAN, TUR_ID)
VALUES (1, 5, '2 ay', 15000, 15, 1);

SELECT * FROM Kurslar_Yedek;
SELECT * FROM Kurslar

UPDATE Kurslar
SET  SURESI = '3 ay', UCRETI = 16000
WHERE ID = 39;

