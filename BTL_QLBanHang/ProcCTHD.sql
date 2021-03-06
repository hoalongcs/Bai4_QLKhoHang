----PROC Thêm sản phẩm
ALTER PROC ThemCTHD @mahd varchar(10), @masp varchar(10), @soluong int, @dongia float, @thanhtien float
AS
BEGIN
INSERT INTO CHITIETHOADONNHAP(MaHD, MaSP, SoLuong, DonGia, ThanhTien) values (@mahd, @masp, @soluong, @dongia, @thanhtien)
END

----exec DanhMaKH @tenKH = N'Hiếu', @dc = N'Thái Nguyên', @SDT = '09127862476', @LoaiKH = N'Khách VIP'

ALTER PROC SuaCTHD @mahd varchar(10), @masp nvarchar(50), @soluong int, @dongia float, @thanhtien float
AS
BEGIN
UPDATE CHITIETHOADONNHAP SET MaSP = @masp, SoLuong = @soluong, DonGia = @dongia, ThanhTien = @thanhtien
WHERE MaHD = @mahd
END

ALTER PROC XoaCTHD @mahd varchar(10), @masp varchar(10)
AS
BEGIN
DELETE FROM CHITIETHOADONNHAP WHERE MaHD = @mahd AND MaSP = @masp
END

