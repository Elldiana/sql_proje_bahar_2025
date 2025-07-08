alter TRIGGER trg_Kurslar_Delete
ON Kurslar
INSTEAD OF DELETE
AS
BEGIN
    UPDATE Kurslar_Yedek
    SET SILINDI_MI = 1
    WHERE ID IN (SELECT ID FROM deleted);
       
END;
DELETE FROM Kurslar WHERE ID = 36;