UPDATE [dbo].[Subeler]
SET Konum = geography::STPointFromText('POINT(27.1287 38.4192)', 4326)
WHERE ID = 1;

UPDATE [dbo].[Subeler]
SET Konum = geography::STPointFromText('POINT(28.9795 41.0082)', 4326)
WHERE ID = 2;

SELECT * FROM SUBELER