CREATE PROCEDURE SertifikaSil
    @OgrenciID INT
AS
BEGIN
    DELETE FROM Sertifikalar
    WHERE OGRENCI_ID = @OgrenciID;
END;

EXEC SertifikaSil @OgrenciID = 1;
