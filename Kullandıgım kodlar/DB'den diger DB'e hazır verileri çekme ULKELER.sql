-- ClearView DB den ILLER TABlosundan veri çekitim
INSERT INTO LanguageCenter.dbo.[Telefonlar.Ulkeler] (ULKE_KODU,ULKE)
SELECT ULKE_KODU,ULKE_ADI
FROM ClearView.dbo.ULKELER;

SELECT * FROM dbo.[Telefonlar.Ulkeler]
