create PROCEDURE EklemeTransactionu
    @SEVIYE_ID INT,
    @DIL_ID INT,
    @SURESI VARCHAR(50),
    @UCRETI DECIMAL(10,2),
    @KONTENJAN INT,
    @TUR_ID INT,
    @SINIF_ID INT,
    @GUNLER VARCHAR(100),
    @BASLANGIC_SAATI TIME,
    @BITIS_SAATI TIME,
    @OGRETMEN_ID INT,
    @OGRENCI_ID INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Kurs ekle
    INSERT INTO KURSLAR (SEVIYE_ID, DIL_ID, SURESI, UCRETI, KONTENJAN, TUR_ID)
    VALUES (@SEVIYE_ID, @DIL_ID, @SURESI, @UCRETI, @KONTENJAN, @TUR_ID);

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Eklenen kursun ID'sini al
    DECLARE @KURS_ID INT = SCOPE_IDENTITY();

    -- Program ekle
    INSERT INTO [dbo].[Kurslar.Programlar] (KURS_ID, SINIF_ID, GUNLER, BASLANGIC_SAATI, BITIS_SAATI, OGRETMEN_ID)
    VALUES (@KURS_ID, @SINIF_ID, @GUNLER, @BASLANGIC_SAATI, @BITIS_SAATI, @OGRETMEN_ID);

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Eklenen programýn ID'sini al
    DECLARE @DERS_PROGRAM_ID INT = SCOPE_IDENTITY();

    -- Kayýt ekle
    INSERT INTO [dbo].[Kurslar.Kayitlar] (DERS_PROGRAM_ID, OGRENCI_ID, KAYIT_TARIHI)
    VALUES (@DERS_PROGRAM_ID, @OGRENCI_ID, GETDATE());

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

    COMMIT TRANSACTION;
END

EXEC EklemeTransactionu
    @SEVIYE_ID = 1,
    @DIL_ID = 2,
    @SURESI = '3 ay',
    @UCRETI = 9000,
    @KONTENJAN = 30,
    @TUR_ID = 2,
    @SINIF_ID = 1,
    @GUNLER = 'Pazartesi, Çarþamba',
    @BASLANGIC_SAATI = '09:00',
    @BITIS_SAATI = '11:00',
    @OGRETMEN_ID = 1,
    @OGRENCI_ID = 6;
	


