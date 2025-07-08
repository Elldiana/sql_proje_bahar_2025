-- ClearView DB den ADRESLER TABlosundan veri çekitim
INSERT INTO LanguageCenter.dbo.[Adresler] ([IL_ID],[ILCE],[ADRES_DETAY],[POSTA_KODU])
SELECT [IL_ID],[ILCE],[ADRES_DETAY],[POSTA_KODU]
FROM ClearView.[dbo].[ADRESLER];

SELECT * FROM ADRESLER
SELECT * FROM Bireyler