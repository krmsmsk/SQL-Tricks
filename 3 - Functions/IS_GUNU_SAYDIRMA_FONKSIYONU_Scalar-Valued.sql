
CREATE FUNCTION [dbo].[IsGunu_Adet]
(
    @IlkTarih Datetime,
    @SonTarih Datetime
)
RETURNS INT
AS
BEGIN
    DECLARE @IsGunSayisi INT;
    
    SET @IsGunSayisi = (DATEDIFF(dd, @IlkTarih, @SonTarih) + 1)
        - (DATEDIFF(wk, @IlkTarih, @SonTarih) * 2) -- wk hafta sayýsýný verir. dd veya day gün, mm veya month ay, yyyy veya year yýl farkýný verir.
        - (CASE WHEN DATENAME(dw, @IlkTarih) = 'Sunday' THEN 1 ELSE 0 END) -- dw gün adýný verir. mm ise ayýn adýný.
        - (CASE WHEN DATENAME(dw, @SonTarih) = 'Saturday' THEN 1 ELSE 0 END)
        - (CASE WHEN EXISTS (SELECT 1 FROM dbo.TATIL_GUNLERI WHERE TARIH BETWEEN @IlkTarih AND @SonTarih) THEN 1 ELSE 0 END);
    
    RETURN @IsGunSayisi;
END

-- 26 Aðustos : Cumartesi
-- 27 Aðustos : Pazar
-- 28 Aðustos : Pazartesi
-- 29 Aðustos : Salý
-- 30 Aðustos : Çarþamba (Zafer Bayramý - Resmi Tatil)
-- 31 Aðustos : Perþembe

select * from [dbo].[IsGunuAdet]('20230826','20230831')
