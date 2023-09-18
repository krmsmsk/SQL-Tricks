USE DWH

DECLARE @SON_ISLEM_TAR DATE = (Select MAX(ISLEM_TARIHI) FROM DWH.dbo.KAMPANYA_URUN_KULLANIM_DETAY)

------------------------------------------------------------------------------------------
----> I CREATE MY TARGET AUDIENCE
------------------------------------------------------------------------------------------

-- The reason for this is that I search on my target audience instead of pressing my target audience into a virtual table and searching on all customers,
-- so as not to waste too much time browsing through large tables (million rows tables).

DROP TABLE IF EXISTS WORKDB.dbo.KAMPANYALI_MUSTERILER -- IF I have KAMPANYALI_MUSTERILER table, drop it. We will create new one.
SELECT DISTINCT
MUST_NO,
CASE WHEN MUST_TIP = 3 THEN 'KONTAK'
	 WHEN MUST_TIP = 2 THEN 'TUZEL'
	 WHEN MUST_TIP = 1 THEN 'GERCEK'
	 END AS MUSTERI_TIPI,
KREDI_KARTI_VAR_MI
INTO WORKDB.dbo.KAMPANYALI_MUSTERILER --> 261 Customers
FROM DWH.dbo.MUSTERILER (NOLOCK)
WHERE KREDI_KARTI_VAR_MI = 'EVET'

select top 5 * from WORKDB.dbo.KAMPANYALI_MUSTERILER 

------------------------------------------------------------------------------------------
----> Do these customers have active TBHS documents?
------------------------------------------------------------------------------------------

-- So firstly we should look at Document Table for TBHS ID
SELECT DISTINCT DOC_TYPE_ID,DOC_TYPE FROM DWH.dbo.DOKUMAN_DOKUM_TBL WHERE DOC_TYPE LIKE '%TBHS%'
/*
DOC_TYPE_ID,	DOC_TYPE
349				TBHS
376				TBHS3
414				TBHS2 
*/

-------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS WORKDB.dbo.TBHS_KAMPANYALI_MUSTERILER
SELECT
A.*,
CASE WHEN B.DOC_TYPE = 'TBHS3' THEN 'TBHS VAR'
	 WHEN B.DOC_TYPE = 'TBHS2' THEN 'TBHS VAR'
	 WHEN B.DOC_TYPE = 'TBHS' THEN 'TBHS VAR'
	 ELSE 'TBHS YOK' END AS DOKUMAN_ADI,
CASE WHEN B.STATUS = 3 THEN 'Aktif'
	 WHEN B.STATUS = 2 THEN 'Inaktif'
	 WHEN B.STATUS = 1 THEN 'Silinmiþ'
	 WHEN B.STATUS = 0 THEN 'Yok'
	 ELSE '' END AS STATUS
INTO WORKDB.dbo.TBHS_KAMPANYALI_MUSTERILER
FROM WORKDB.dbo.KAMPANYALI_MUSTERILER A
LEFT JOIN DWH.dbo.DOKUMAN_DOKUM_TBL B (NOLOCK) ON A.MUST_NO=B.MUST_NO AND DOC_TYPE_ID IN (349,376,414)

select top 5 * from WORKDB.dbo.TBHS_KAMPANYALI_MUSTERILER

------------------------------------------------------------------------------------------
----> Recent transaction information of customers who benefit from certain campaigns
------------------------------------------------------------------------------------------

/* In this case, If the name of our table contains a date (such as a year), 
we should change our table name to a dynamic structure so that we do not encounter any errors when we use our query again. 
For example, if we need to create a SP and run it with JOB at regular time intervals such as daily, weekly or monthly, 
it is very important to write our queries in a dynamic structure instead of returning to our queries in January of each year and editing tables with date content.
*/

DECLARE @GUNCEL_YIL VARCHAR(4) = YEAR(GETDATE())
DECLARE @SQL_QUERY VARCHAR(MAX)

SET @SQL_QUERY = '
DROP TABLE IF EXISTS WORKDB.dbo.TABLE1
SELECT DISTINCT
A.*,
B.BOLGE,
B.SUBE_ADI,
C.URUN_ADI,
B.KAMPANYA_URUN_KODU,
B.TOPLAM_KULLANIM_TUTARI, -- Credit amount used for the campaign
CONVERT(VARCHAR(10), B.ISLEM_TARIHI, 104) AS SON_ISLEM_TARIHI,
ROW_NUMBER() OVER (PARTITION BY A.MUST_NO ORDER BY B.ISLEM_TARIHI DESC) AS SIRA
INTO WORKDB.dbo.TABLE1
FROM WORKDB.dbo.TBHS_KAMPANYALI_MUSTERILER A
INNER JOIN DWH.dbo.KAMPANYA_URUN_KULLANIM_DETAY B (NOLOCK) ON A.MUST_NO=B.MUST_NO AND KAMPANYA_URUN_KODU IN (''VSTL'',''MMARKT'',''HPSBRD'',''TRDYL'',''GTR'',''ARCLK'')
LEFT JOIN DWH.dbo.URUNLER_TBL_'+@GUNCEL_YIL+' C (NOLOCK) ON C.URUN_KODU=B.URUN_KODU'

EXEC (@SQL_QUERY)

select top 10 * from WORKDB.dbo.TABLE1

------------------------------------------------------------------------------------------
----> Listing of the last loans received by each customer
------------------------------------------------------------------------------------------

-- A customer can only receive credit by using a campaign code. He cannot get a new one without paying off his existing loan. 
-- That's why I did these steps for the most up-to-date list.

DROP TABLE IF EXISTS WORKDB.dbo.DATA_SON
SELECT MUST_NO,
MUSTERI_TIPI,
KREDI_KARTI_VAR_MI,
DOKUMAN_ADI,
STATUS,
BOLGE,
SUBE_ADI,
URUN_ADI,
KAMPANYA_URUN_KODU,
SUM(TOPLAM_KULLANIM_TUTARI) AS TOPLAM_KULLANIM_TUTARI,
SON_ISLEM_TARIHI
INTO WORKDB.dbo.DATA_SON
FROM WORKDB.dbo.TABLE1
WHERE SIRA = 1
GROUP BY MUST_NO,MUSTERI_TIPI,KREDI_KARTI_VAR_MI,DOKUMAN_ADI,STATUS,BOLGE,SUBE_ADI,URUN_ADI,KAMPANYA_URUN_KODU,SON_ISLEM_TARIHI

select top 10 * from WORKDB.dbo.DATA_SON

------------------------------------------------------------------------------------------
----> Grouping results by products
------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS WORKDB.dbo.DATA_OZET
SELECT
COALESCE(URUN_ADI, 'TOPLAM') AS URUNLER,
SUM(TOPLAM_KULLANIM_TUTARI) AS TOPLAM_KULLANIM_TUTARI,
COUNT(MUST_NO) AS ADET
INTO WORKDB.dbo.DATA_OZET
FROM WORKDB.dbo.DATA_SON
GROUP BY URUN_ADI WITH ROLLUP

select * from WORKDB.dbo.DATA_OZET

------------------------------------------------------------------------------------------
----> The most profitable products per piece?
------------------------------------------------------------------------------------------

SELECT 
URUNLER,
TOPLAM_KULLANIM_TUTARI,
ADET,
ROUND(TOPLAM_KULLANIM_TUTARI / ADET, 0) AS ADET_KARLILIK
FROM WORKDB.dbo.DATA_OZET
ORDER BY CASE WHEN URUNLER = 'TOPLAM' THEN 1 ELSE -ROUND(TOPLAM_KULLANIM_TUTARI / ADET, 0) END


select top 10 * from dbo.MUSTERILER
select top 10 * from dbo.DOKUMAN_DOKUM_TBL
select top 10 * from dbo.KAMPANYA_URUN_KULLANIM_DETAY
select top 10 * from dbo.URUNLER_TBL_2023

