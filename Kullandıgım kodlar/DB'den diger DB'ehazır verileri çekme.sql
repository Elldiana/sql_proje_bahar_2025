-- ClearView DB den ILLER TABlosundan veri �ekitim
INSERT INTO LanguageCenter.dbo.[Adresler.Iler] (IL_ADI)
SELECT IL_ADI
FROM ClearView.dbo.ILLER;