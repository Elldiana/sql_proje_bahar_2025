CREATE TRIGGER trg_Kurslar_Update_Yedek
ON Kurslar
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Kurslar_Yedek1')
    BEGIN
        UPDATE k
        SET 
            k.SEVIYE_ID = i.SEVIYE_ID,
            k.DIL_ID = i.DIL_ID,
            k.SURESI = i.SURESI,
            k.UCRETI = i.UCRETI,
            k.KONTENJAN = i.KONTENJAN,
            k.TUR_ID = i.TUR_ID,
            k.EKLENME_TARIHI = GETDATE(),
            k.EKLEYEN_KULLANICI = HOST_NAME()
        FROM Kurslar_Yedek1 k
        INNER JOIN INSERTED i ON k.ID = i.ID;
    END
    ELSE
    BEGIN
        CREATE TABLE Kurslar_Yedek1 (
            ID INT,
            SEVIYE_ID INT,
            DIL_ID INT,
            SURESI VARCHAR(50),
            UCRETI DECIMAL(10,2),
            KONTENJAN INT,
            TUR_ID INT,
            EKLENME_TARIHI DATETIME DEFAULT GETDATE(),
            EKLEYEN_KULLANICI NVARCHAR(50),
            SILINDI_MI BIT DEFAULT 0
        );

        INSERT INTO Kurslar_Yedek1 (ID, SEVIYE_ID, DIL_ID, SURESI, UCRETI, KONTENJAN, TUR_ID, EKLENME_TARIHI, EKLEYEN_KULLANICI, SILINDI_MI)
        SELECT ID, SEVIYE_ID, DIL_ID, SURESI, UCRETI, KONTENJAN, TUR_ID, GETDATE(), HOST_NAME(), 0
        FROM INSERTED;
    END
END;
