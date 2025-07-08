--INNER JOIN
-- OGRENCINI ald�g� notlar�n hang� s�nav turu oldugunu gosteriyor
SELECT NS.ID, NS.SINAV_TURU , N.PUAN, N.TARIH
FROM [Notlar.SinavTurleri] NS
INNER JOIN Notlar N
ON NS.ID = N.SINAV_TURU_ID

--LEFT JOIN
--Bu sorgu, t�m s�n�flar�n hangi programlara ba�l� oldu�unu (ve ba�l� de�ilse bile s�n�f�n listede g�r�nmesini) sa�lar.
SELECT S.ID, S.SINIF_NO,S.KAPASITE, KP.ID, KP.GUNLER,KP.BASLANGIC_SAATI,KP.BITIS_SAATI
FROM [Siniflar] S
LEFT JOIN  [Kurslar.Programlar] KP
ON KP.KURS_ID = S.ID

--RIGHT JOIN
--��retmenlerin hangi �ubede �al��t���
SELECT 
    OG.ID AS OGRETMEN_ID,
    OG.BIREY_ID,
    OG.BRANS,
    OG.EGITIM_DURUMU,
    OG.MAASI,
    S.SUBE_ADI,
    S.ACILIS_TARIHI,
    S.DURUMU,
    S.TOPLAM_CALISANLAR,
    S.KONUM
FROM [dbo].[Bireyler.Ogretmenler] OG
RIGHT JOIN [dbo].[Subeler] S
ON OG.SUBE_ID = S.ID;

--FULL OUTER JOIN
--Bireylerin eposta adresi olup olmad���n� kontrol et.
SELECT B.AD, B.SOYAD, E.EPOSTA
FROM [dbo].[Bireyler] B
FULL JOIN [dbo].[Epostalar] E
ON B.BIREY_ID = E.BIREY_ID;
