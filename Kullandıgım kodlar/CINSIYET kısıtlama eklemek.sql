ALTER TABLE Bireyler
ADD CONSTRAINT chk_cinsiyet CHECK (UPPER(CINSIYET) IN ('E', 'K'));