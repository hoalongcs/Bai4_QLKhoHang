----PROC Thêm sản phẩm
ALTER PROC ThemHDN @mancc nvarchar(50), @ngaynhap date
AS
BEGIN
DECLARE @MaHDN varchar(10)
DECLARE @Sott int
DECLARE contro CURSOR FORWARD_ONLY FOR SELECT MaHDN from HOADONNHAP
SET @Sott = 0

OPEN contro
FETCH NEXT FROM contro INTO @MaHDN
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF((CAST(right(@MaHDN, 7) AS int) - @sott) = 1)
		BEGIN
			SET @Sott = @Sott + 1
		END
	ELSE BREAK
	FETCH NEXT FROM contro INTO @MaHDN
END
DECLARE @cdai int
DECLARE @i int
SET @MaHDN = CAST((@sott + 1) as varchar(8))
SET @cdai = LEN(@MaHDN)
SET @i = 1
while ( @i <= 7 - @cdai)
BEGIN
	SET @MaHDN = '0' + @MaHDN
	SET @i = @i + 1
END
SET @MaHDN = 'HDN' + @MaHDN

INSERT INTO HOADONNHAP(MaHDN, MaNCC, NgayNhap) values (@MaHDN, @mancc, @ngaynhap)
SELECT @MaHDN
CLOSE contro
DEALLOCATE contro
END

----exec DanhMaKH @tenKH = N'Hiếu', @dc = N'Thái Nguyên', @SDT = '09127862476', @LoaiKH = N'Khách VIP'

CREATE PROC SuaHDN @mahdn varchar(10), @mancc nvarchar(50), @ngaynhap date
AS
BEGIN
UPDATE HOADONNHAP SET MaNCC = @mancc, NgayNhap = @ngaynhap
WHERE MaHDN = @mahdn
END

CREATE PROC XoaHDN @mahdn varchar(10)
AS
BEGIN
DELETE FROM HOADONNHAP WHERE MaHDN = @mahdn
END

ALTER PROC TongTien @mahd varchar(10)
AS
BEGIN
	DECLARE @tongtien bigint
	SELECT @tongtien = SUM(ThanhTien)
	FROM CHITIETHOADONNHAP WHERE MaHD = @mahd
	SELECT @tongtien
END

exec dbo.TongTien 'HDN0000001'

CREATE PROC ThongKeHDN @ngaydau date, @ngaycuoi date
AS
BEGIN
	SELECT * FROM HOADONNHAP
	WHERE NgayNhap BETWEEN @ngaydau AND @ngaycuoi
END

CREATE PROC PhieuNhap @mancc varchar(10)
AS
BEGIN
	SELECT MaHDN, NgayNhap, TongTien FROM HOADONNHAP, 
	(SELECT MaHD, SUM(ThanhTien)TongTien FROM CHITIETHOADONNHAP GROUP BY MaHD) a
	WHERE MaNCC = @mancc AND MaHDN = MaHD
END
exec dbo.PhieuNhap 'NCC0000001'
