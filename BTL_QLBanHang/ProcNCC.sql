----PROC Thêm sản phẩm
ALTER PROC ThemNCC @tenlh nvarchar(50), @diachi nvarchar(50), @sdt varchar(15)
AS
BEGIN
DECLARE @MaNCC varchar(10)
DECLARE @Sott int
DECLARE contro CURSOR FORWARD_ONLY FOR SELECT MaNCC from NHACUNGCAP
SET @Sott = 0

OPEN contro
FETCH NEXT FROM contro INTO @MaNCC
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF((CAST(right(@MaNCC, 7) AS int) - @sott) = 1)
		BEGIN
			SET @Sott = @Sott + 1
		END
	ELSE BREAK
	FETCH NEXT FROM contro INTO @MaNCC
END
DECLARE @cdai int
DECLARE @i int
SET @MaNCC = CAST((@sott + 1) as varchar(8))
SET @cdai = LEN(@MaNCC)
SET @i = 1
while ( @i <= 7 - @cdai)
BEGIN
	SET @MaNCC = '0' + @MaNCC
	SET @i = @i + 1
END
SET @MaNCC = 'NCC' + @MaNCC

INSERT INTO NHACUNGCAP(MaNCC, TenNCC, DiaChi, SDT) values (@MaNCC, @tenlh, @diachi, @sdt)
CLOSE contro
DEALLOCATE contro
END

----exec DanhMaKH @tenKH = N'Hiếu', @dc = N'Thái Nguyên', @SDT = '09127862476', @LoaiKH = N'Khách VIP'

--CREATE PROC SuaNCC @mancc varchar(10), @tenncc nvarchar(50), @diachi nvarchar(50), @sdt varchar(15)
--AS
--BEGIN
--UPDATE NHACUNGCAP SET TenNCC = @tenncc, DiaChi = @diachi, SDT = @sdt
--WHERE MaNCC = @mancc
--END

--CREATE PROC XoaNCC @mancc varchar(10)
--AS
--BEGIN
--DELETE FROM NHACUNGCAP WHERE MaNCC = @mancc
--END

