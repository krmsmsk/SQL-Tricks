USE [DWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsGunuAdet]
(
@IlkTarih Datetime,
@SonTarih Datetime
)
RETURNS TABLE AS RETURN
(
SELECT (DATEDIFF(dd, @IlkTarih, @SonTarih) +1) 
-(DATEDIFF (wk, @IlkTarih, @SonTarih) *2)  -- wk hafta sayısını verir. dd veya day gün, mm veya month ay, yyyy veya year yıl farkını verir.
-(CASE WHEN DATENAME(dw, @IlkTarih) = 'Sunday' Then 1 Else 0 End) -- dw gün adını verir. mm ise ayın adını.
-(CASE WHEN DATENAME(dw, @SonTarih) = 'Saturday' Then 1 Else 0 End)
-(CASE WHEN EXISTS ( SELECT 1 FROM dbo.TATIL_GUNLERI WHERE TARIH BETWEEN @IlkTarih AND @SonTarih) THEN 1 ELSE 0 END)
AS IS_GUNU
)

-- 26 Ağustos : Cumartesi
-- 27 Ağustos : Pazar
-- 28 Ağustos : Pazartesi
-- 29 Ağustos : Salı
-- 30 Ağustos : Çarşamba (Zafer Bayramı - Resmi Tatil)
-- 31 Ağustos : Perşembe

select * from [dbo].[IsGunuAdet]('20230826','20230831')