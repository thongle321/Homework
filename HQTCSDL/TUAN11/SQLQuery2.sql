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



