-- ClearView DB den ILLER TABlosundan veri çekitim
INSERT INTO LanguageCenter.dbo.[Telefonlar.AlanKodu] (ALAN_KODU,SEHIR)
SELECT ALAN_KODU,SEHIR_ADI_OPERATOR
FROM ClearView.dbo.ALAN_KODU;