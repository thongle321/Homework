﻿--Thủ tục không có tham số
--1 Liệt kê nhan viên sắp theo ngày sinh tăng dần
CREATE PROC SP_NHANVIEN_NGAYSINH
AS
BEGIN
	SELECT *
	FROM NHANVIEN
	ORDER BY NGSINH
END
EXEC SP_NHANVIEN_NGAYSINH

--2 Liệt kê nhân viên đến tuổi về hưu, nam >= 60, nữ >= 50
CREATE PROC SP_NHANVIEN_TUOI
AS
BEGIN
	SELECT *
	FROM NHANVIEN
	WHERE PHAI = N'NAM' AND (YEAR(GETDATE()) - YEAR(NGSINH) >= 60)
		  OR PHAI = N'Nữ' AND (YEAR(GETDATE()) - YEAR(NGSINH) >= 55)
END
EXEC SP_NHANVIEN_TUOI

--3 Tăng lương nhân viên 10% cho nhân viên phòng nghiên cứu 
CREATE PROC SP_NHANVIEN_LUONG
AS
BEGIN
	SELECT * FROM NHANVIEN
	UPDATE NHANVIEN
	SET LUONG = LUONG * 1.1
	FROM NHANVIEN JOIN PHONGBAN ON PHG = MAPHG
	WHERE TENPHG = N'nghiên cứu'
	SELECT * FROM NHANVIEN
END
EXEC SP_NHANVIEN_LUONG

--4 Tăng thời gian làm việc của nhân viên có mã '001', mã đề án 20, stt 1, tăng thêm 1
CREATE PROC SP_PHANCONG_THOIGIAN
AS
BEGIN
	UPDATE PHANCONG
	SET THOIGIAN = THOIGIAN + 1
	FROM PHANCONG
	WHERE MA_NVIEN = '001' AND MADA = 20 AND STT = 1
END
EXEC SP_PHANCONG_THOIGIAN

--5 Xóa hết phân công của đề án 20
CREATE PROC SP_PHANCONG_DEAN20
AS
BEGIN
	DELETE FROM PHANCONG
	WHERE MADA = 20
END
EXEC SP_PHANCONG_DEAN20

--6 Xóa đề án 20
CREATE PROC SP_DEAN_20
AS
BEGIN
	DELETE FROM PHANCONG
	WHERE MADA = 20
	DELETE FROM CONGVIEC
	WHERE MADA = 20
	DELETE FROM DEAN
	WHERE MADA = 20
END
EXEC SP_DEAN_20

--7 Thêm 1 phân công vào bảng phân công
CREATE PROC SP_PHANCONG_THEM
AS
BEGIN
	INSERT INTO PHANCONG
	VALUES('003',3,1,120)
END
DROP PROC SP_PHANCONG_THEM
EXEC SP_PHANCONG_THEM

--8 Thêm 1 nhân viên vào bảng nhân viên
CREATE PROC SP_NHANVIEN_THEM
AS
BEGIN
	INSERT INTO NHANVIEN
	VALUES ('LE', 'NGUYEN HOANG', 'THONG', '077', NULL, 'TPHCM', 'NAM', 500000, '003', 4)
END
DROP PROC SP_NHANVIEN_THEM
EXEC SP_NHANVIEN_THEM

--Thủ tục có tham số vào
--9 Liệt kê nhan viên có tuổi >= tuổi nhập, giảm dần
CREATE PROC SP_NHANVIEN_TUOIDESC (@TUOI INT)
AS 
BEGIN
	SELECT *
	FROM NHANVIEN
	WHERE YEAR(GETDATE()) - YEAR(NGSINH) >= @TUOI
	ORDER BY NGSINH DESC
END
EXEC SP_NHANVIEN_TUOIDESC 55

--10 Liệt ke nhân viên đến tuổi về hưu, sắp theo tuổi giảm dần, trong đó tuổi về hưu do người nhập
CREATE PROC SP_NHANVIEN_TUOIHUU (@TUOI INT, @PHAI NVARCHAR(3))
AS
BEGIN
	SELECT *, YEAR(GETDATE()) - YEAR(NGSINH) TUOI
	FROM NHANVIEN
	WHERE PHAI = @PHAI AND (YEAR(GETDATE()) - YEAR(NGSINH)) = @TUOI
END
DROP PROC SP_NHANVIEN_TUOIHUU
EXEC SP_NHANVIEN_TUOIHUU 58, N'Nữ'

--11 Tăng lương cho nhân viên 10% cho nhân viên 1 tên phòng do người dùng nhập
CREATE PROC SP_NHANVIEN_PHONG (@TENPHONG NVARCHAR(10))
AS
BEGIN
	UPDATE NHANVIEN
	SET LUONG = LUONG * 1.1
	FROM PHONGBAN
	WHERE TENPHG = @TENPHONG
END
EXEC SP_NHANVIEN_PHONG N'nghiên cứu'

--12 Tăng thời gian làm cho 1 mã nhân viên thuộc 1 đề án và số tt, mã nhân viên, mã đề án, số stt và thời gian tăng do người dùng nhập
CREATE PROC SP_PHANCONG_TANG (@MANV CHAR(10), @MADA INT, @STT INT, @THOIGIAN INT)
AS
BEGIN
	UPDATE PHANCONG 
	SET THOIGIAN = THOIGIAN + @THOIGIAN
	WHERE MA_NVIEN = @MANV AND MADA = @MADA AND STT = @STT
END
EXEC SP_PHANCONG_TANG '001', 30, 1, 5

--13 Xóa phân công của đề án với mã đề do người dùng nhập
CREATE PROC SP_PHANCONG_XOADEAN (@MADA INT)
AS
BEGIN
	DELETE FROM PHANCONG
	WHERE MADA = @MADA
END
EXEC SP_PHANCONG_XOADEAN 10

--14 Xóa đề án với mã đề án do người dùng nhập
CREATE PROC SP_DEAN_MADAXOA (@MADA INT)
AS
BEGIN
	DELETE FROM PHANCONG
	WHERE MADA = @MADA
	DELETE FROM CONGVIEC
	WHERE MADA = @MADA
	DELETE FROM DEAN
	WHERE MADA = @MADA
END
EXEC SP_DEAN_MADAXOA 77

--15 Thêm 1 phân công vào bảng phân công, các thông tin là tham số vào
CREATE PROC SP_PHANCONG_THEMNV (@MANVIEN CHAR(10), @MADA INT, @STT INT, @THOIGIAN FLOAT)
AS
BEGIN
	INSERT INTO PHANCONG
	VALUES (@MANVIEN, @MADA, @STT, @THOIGIAN)
END
EXEC SP_PHANCONG_THEMNV '007', 2, 2, 20

--16 Thêm 1 nhân viên vào bảng nhân viên, các thông tin là tham số vào
CREATE PROC SP_NHANVIEN_THEMNV (@HONV NVARCHAR(10), 
@TENLOT NVARCHAR(10),
@TENNV NVARCHAR(10),
@MANV CHAR(9), 
@NGSINH DATE,
@DCHI NVARCHAR (50),
@PHAI NVARCHAR(3), 
@LUONG MONEY, 
@MA_NQL CHAR(9),
@PHG INT)
AS
BEGIN
	INSERT INTO NHANVIEN
	VALUES (@HONV, @TENLOT, @TENNV, @MANV, @MANV, @NGSINH, @DCHI, @PHAI, @LUONG, @MA_NQL, @PHG)
END
EXEC SP_NHANVIEN_THEMNV N'LÊ', N'NGUYỄN', N'HOÀNG THÔNG', '012', NULL, N'TPHCM', N'NỮ', 10000, '006', 3

--17
CREATE PROC SP_TUOI_LUONG @TUOI INT, @LUONG FLOAT OUT
AS
BEGIN
SELECT*
FROM NHANVIEN
WHERE YEAR(GETDATE())-YEAR(NGSINH)>=@TUOI 
ORDER BY NGSINH DESC

SELECT @LUONG =AVG(LUONG)
FROM NHANVIEN
WHERE YEAR(GETDATE())-YEAR(NGSINH)>=@TUOI
END

DECLARE @AVG FLOAT
EXEC SP_TUOI_LUONG 60,@AVG OUT
PRINT @AVG

--18
CREATE PROC SP_18 (@TUOINAM INT, @TUOINU INT, @DEM1 INT OUT,@DEM2 INT OUT)
AS
BEGIN
SELECT*
FROM NHANVIEN
WHERE (YEAR(GETDATE())-YEAR(NGSINH)>=@TUOINAM AND PHAI LIKE N'NAM') 
ORDER BY NGSINH DESC
SELECT*
FROM NHANVIEN
WHERE (YEAR(GETDATE())-YEAR(NGSINH)>=@TUOINU AND PHAI LIKE N'NỮ')
ORDER BY NGSINH DESC
SELECT @DEM1 =COUNT(*)
FROM NHANVIEN
WHERE YEAR(GETDATE())-YEAR(NGSINH)>=@TUOINAM AND PHAI LIKE N'NAM'
SELECT @DEM2 =COUNT(*)
FROM NHANVIEN
WHERE YEAR(GETDATE())-YEAR(NGSINH)>=@TUOINU AND PHAI LIKE N'NỮ'
END
DECLARE @SONAM INT, @SONU INT
EXEC SP_18 60,55, @SONAM OUT, @SONU OUT
PRINT 'NAM' + CAST(@SONAM AS NVARCHAR)
PRINT 'NỮ' + CAST(@SONU AS NVARCHAR)

--19
CREATE PROC SP_19 (@PHONG NVARCHAR(50),@SONV INT OUT,@LUONGTANG INT OUT)
AS
BEGIN
SELECT  @LUONGTANG=SUM(LUONG) FROM NHANVIEN JOIN PHONGBAN ON PHG=MAPHG WHERE TENPHG LIKE @PHONG
UPDATE NHANVIEN SET LUONG =LUONG*1.1 FROM PHONGBAN  WHERE MAPHG=PHG AND TENPHG LIKE @PHONG
 SELECT @SONV =COUNT(*) FROM NHANVIEN JOIN PHONGBAN ON MAPHG=PHG WHERE TENPHG LIKE @PHONG
END

declare @so int, @luongtan int
exec SP_19 N'Nghiên cứu',@so  out,@luongtan out
PRINT 'so nhan vien' + CAST(@so AS NVARCHAR)
PRINT 'so luong tang' + CAST(@luongtan AS NVARCHAR)

--20
CREATE PROC SP_20 (@THOIGIAN INT, @SONV INT OUT, @TANGLUONG INT OUT)
AS
BEGIN
	UPDATE NHANVIEN
	SET LUONG = LUONG *1.05
	WHERE MANV IN (SELECT MA_NVIEN FROM PHANCONG WHERE THOIGIAN >= @THOIGIAN)

	SELECT @SONV = COUNT(*), @TANGLUONG= SUM(LUONG * 0.05) FROM NHANVIEN WHERE MANV IN (SELECT MA_NVIEN FROM PHANCONG WHERE THOIGIAN >= @THOIGIAN)
END
DECLARE @sonv1 int, @tangluong1 int
EXEC SP_20 120, @sonv1 out, @tangluong1 out
--21 
CREATE PROC SP_PC_XOADEAN (@MADA INT, @SLPC INT OUT, @SLTG FLOAT OUT)
AS
BEGIN
	DELETE FROM PHANCONG
	WHERE MADA = @MADA
	
	SELECT @SLPC = COUNT(*) FROM PHANCONG
	SELECT @SLTG = SUM(THOIGIAN) FROM PHANCONG WHERE MADA = @MADA
END
DECLARE @slpc1 int, @sltg1 float;
EXEC SP_PC_XOADEAN 30, @slpc1 OUTPUT, @sltg1 OUTPUT;
PRINT N'Số phân công:' + CAST(@slpc1 AS VARCHAR(10))
PRINT N'Số thời gian:' + CAST(@sltg1 AS VARCHAR(10))
--22 
CREATE PROC SP_DEAN_XOADEAN (@MADA INT, @SLPC INT OUT, @SLTG FLOAT OUT)
AS
BEGIN
  DELETE FROM PHANCONG
  WHERE MADA = @MADA;

  DELETE FROM CONGVIEC
  WHERE MADA = @MADA

  DELETE FROM DEAN
  WHERE MADA = @MADA
  
  SELECT @SLPC = COUNT(*), @SLTG = SUM(THOIGIAN) FROM PHANCONG WHERE MADA = @MADA

END
DECLARE @slpc2 int, @sltg2 float;
EXEC SP_DEAN_XOADEAN 1, @slpc2 OUTPUT, @sltg2 OUTPUT
PRINT N'Số phân công:' + CAST(@slpc2 AS VARCHAR(10))
PRINT N'Số thời gian:' + CAST(@sltg2 AS VARCHAR(10))
--23
CREATE PROC SP_PC_THEMPC
  @MA_NVIEN char(9),
  @MADA INT,
  @STT INT,
  @THOIGIAN int,
  @SLPC INT OUT,
  @SLDA INT OUT,
  @SLTHOIGIAN FLOAT OUT
AS
BEGIN
    INSERT INTO PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
    VALUES (@MA_NVIEN, @MADA, @STT, @THOIGIAN)

    SELECT @SLPC = COUNT(*) FROM PHANCONG
    SELECT @SLDA = COUNT(DISTINCT MADA) FROM PHANCONG
    SELECT @SLTHOIGIAN = SUM(THOIGIAN) FROM PHANCONG 
END
declare @slpc3 int, @slda3 int, @slthoigian3 float
EXEC SP_PC_THEMPC '001', 1, 2, 120, @slpc3 OUTPUT, @slda3 OUTPUT, @slthoigian3 OUTPUT
PRINT N'Số phân công' + CAST(@slpc3 as varchar(10))
PRINT N'Số lượng đề án' + CAST(@slda3 as varchar(10))
PRINT N'Tổng thời gian' + CAST(@slthoigian3 as varchar(10))

--24
CREATE PROC SP_NHANVIEN_THEMNV (@HONV NVARCHAR(10), 
@TENLOT NVARCHAR(10),
@TENNV NVARCHAR(10),
@MANV CHAR(9), 
@NGSINH DATE,
@DCHI NVARCHAR (50),
@PHAI NVARCHAR(3), 
@LUONG MONEY, 
@MA_NQL CHAR(9),
@PHG INT,
@SLNV INT OUT)
AS
BEGIN
	INSERT INTO NHANVIEN
	VALUES (@HONV, @TENLOT, @TENNV, @MANV, @NGSINH, @DCHI, @PHAI, @LUONG, @MA_NQL, @PHG)

	SELECT @SLNV = COUNT(*) FROM NHANVIEN
END
DECLARE @slnv2 int
EXEC SP_NHANVIEN_THEMNV N'LÊ', N'NGUYỄN', N'HOÀNG THÔNG', '012', NULL, N'TPHCM', N'NỮ', 10000, '006', 4, @slnv2 OUTPUT
PRINT N'Số lượng nhân viên:' + CAST(@slnv2 AS VARCHAR(10))

--25
CREATE PROC SP_NV_LIETKEAGE @Tuoi INT = 35
AS
BEGIN
    SELECT *
    FROM NHANVIEN
    WHERE YEAR(GETDATE()) - YEAR(NGSINH) >= @Tuoi
    ORDER BY YEAR(GETDATE()) - YEAR(NGSINH) DESC
END
EXEC SP_NV_LIETKEAGE 65
--26
alter PROC SP_NV_TUOIVEHUU (@TUOINAM INT = 60, @TUOINU INT = 55)
AS
BEGIN
SELECT*
FROM NHANVIEN
WHERE (YEAR(GETDATE())-YEAR(NGSINH)>=@TUOINAM AND PHAI LIKE N'NAM') 
ORDER BY NGSINH DESC
SELECT*
FROM NHANVIEN
WHERE (YEAR(GETDATE())-YEAR(NGSINH)>=@TUOINU AND PHAI LIKE N'NỮ')
ORDER BY NGSINH DESC
END
EXEC SP_NV_TUOIVEHUU 
--27
CREATE PROCEDURE SP_NV_TANGLUONG1PHONG
    @TenPhong NVARCHAR(15) = NULL
AS
BEGIN
    UPDATE NHANVIEN
    SET LUONG = LUONG * 1.1
    WHERE PHG = ISNULL((SELECT MAPHG FROM PHONGBAN WHERE TENPHG = @TenPhong), PHG)
	SELECT LUONG FROM NHANVIEN
END
EXEC SP_NV_TANGLUONG1PHONG N'Điều Hành'
--28
CREATE PROC SP_NV_TANGLUONG5PHANTRAM
    @ThoiGian FLOAT = NULL,
    @SoNhanVien INT OUTPUT,
    @TongLuongDaTang MONEY OUTPUT
AS
BEGIN
    IF @ThoiGian IS NULL
	BEGIN
        SET @ThoiGian = (SELECT AVG(THOIGIAN) FROM PHANCONG)
	END
    UPDATE NHANVIEN
    SET LUONG = LUONG * 1.05
    WHERE MANV IN ( SELECT MA_NVIEN FROM PHANCONG WHERE THOIGIAN >= @ThoiGian)

    SELECT @SoNhanVien = COUNT(*) FROM NHANVIEN
    SELECT @TongLuongDaTang = SUM(LUONG * 0.05) FROM NHANVIEN WHERE MANV IN (SELECT MA_NVIEN FROM PHANCONG WHERE THOIGIAN >= @THOIGIAN);
END
DECLARE @sonv int, @tongluong money
EXEC SP_NV_TANGLUONG5PHANTRAM @SoNhanVien = @sonv OUTPUT, @TongLuongDaTang = @tongluong OUTPUT
PRINT N'Số nhân viên tăng lương:' + CAST(@sonv as VARCHAR(10))
PRINT N'Tổng lương đã tăng: ' + CAST(@tongluong as VARCHAR(10))
--29
CREATE PROCEDURE SP_DEAN_XOA1DEAN
    @MADA INT = NULL,
    @PhongBanPhuTrach NVARCHAR(15) OUTPUT
AS
BEGIN
    IF @MADA IS NULL
        SET @MADA = (SELECT TOP 1 MADA FROM DEAN WHERE NOT EXISTS (SELECT TOP 1 MADA FROM PHANCONG WHERE DEAN.MADA = PHANCONG.MADA))
	
	DELETE FROM CONGVIEC
    WHERE MADA = @MADA;
    SET @PhongBanPhuTrach = (SELECT TENPHG FROM PHONGBAN WHERE MAPHG = (SELECT PHONG FROM DEAN WHERE MADA = @MADA))

    DELETE FROM DEAN
    WHERE MADA = @MADA;
END
DECLARE @phongban nvarchar(15)
EXEC SP_DEAN_XOA1DEAN 2,@PhongBanPhuTrach = @phongban output
PRINT N'Phòng ban: ' + @phongban
--30
CREATE PROCEDURE AddPhanCong
@MA_NVIEN char(9) = NULL,
@MADA int,
@STT int,
@THOIGIAN float
AS
BEGIN
    IF @MA_NVIEN IS NULL
    BEGIN
        SELECT @MA_NVIEN = TRPHG FROM PHONGBAN WHERE MAPHG = (SELECT PHONG FROM DEAN WHERE MADA = @MADA)
    END

    INSERT INTO PHANCONG(MA_NVIEN, MADA, STT, THOIGIAN)
    VALUES (@MA_NVIEN, @MADA, @STT, @THOIGIAN)
END
EXEC AddPhanCong @MADA = 2, @STT = 1, @THOIGIAN = 60
--31
CREATE PROCEDURE AddNhanVien
@MANV char(9) = NULL,
@HONV nvarchar(15),
@TENLOT nvarchar(15),
@TENNV nvarchar(15),
@NGSINH date,
@DCHI nvarchar(30),
@PHAI nvarchar(3),
@LUONG float,
@MA_NQL char(9),
@PHG int
AS
BEGIN
    IF @MANV IS NULL
    BEGIN
        SET @MANV = (SELECT TOP 1 MANV FROM NHANVIEN ORDER BY MANV DESC) + 1
    END

    INSERT INTO NHANVIEN(MANV, HONV, TENLOT, TENNV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
    VALUES (@MANV, @HONV, @TENLOT, @TENNV, @NGSINH, @DCHI, @PHAI, @LUONG, @MA_NQL, @PHG)
END
EXEC AddNhanVien @HONV = N'Nguyen',@TENLOT = N'Thuy',@TENNV = N'Linh',@NGSINH = '1990-01-01',@DCHI = N'TPHCM',@PHAI = N'Nữ',
@LUONG = 50000, @MA_NQL = '001', @PHG = 1

