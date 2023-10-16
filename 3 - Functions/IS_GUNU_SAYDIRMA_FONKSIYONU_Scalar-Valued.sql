
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
        - (DATEDIFF(wk, @IlkTarih, @SonTarih) * 2) -- wk hafta say�s�n� verir. dd veya day g�n, mm veya month ay, yyyy veya year y�l fark�n� verir.
        - (CASE WHEN DATENAME(dw, @IlkTarih) = 'Sunday' THEN 1 ELSE 0 END) -- dw g�n ad�n� verir. mm ise ay�n ad�n�.
        - (CASE WHEN DATENAME(dw, @SonTarih) = 'Saturday' THEN 1 ELSE 0 END)
        - (CASE WHEN EXISTS (SELECT 1 FROM dbo.TATIL_GUNLERI WHERE TARIH BETWEEN @IlkTarih AND @SonTarih) THEN 1 ELSE 0 END);
    
    RETURN @IsGunSayisi;
END

-- 26 A�ustos : Cumartesi
-- 27 A�ustos : Pazar
-- 28 A�ustos : Pazartesi
-- 29 A�ustos : Sal�
-- 30 A�ustos : �ar�amba (Zafer Bayram� - Resmi Tatil)
-- 31 A�ustos : Per�embe

select * from [dbo].[IsGunuAdet]('20230826','20230831')
