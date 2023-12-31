USE QuanLyDuAn;
GO
-- Tạo bảng Nhân Viên
create table NHANVIEN
(
	HONV nvarchar(15),
	TENLOT nvarchar(15),
	TENNV nvarchar(15),
	MANV char(9),
	NGSINH date,
	DCHI nvarchar(30),
	PHAI nvarchar(3),
	LUONG float,
	MA_NQL  char(9),
	PHG  int,
	PRIMARY KEY (MANV)
)

-- Tạo bảng Đề Án
create table DEAN
(
	TENDA nvarchar(15),
	MADA int,
	DDIEM_DA nvarchar(15),
	PHONG int,
	PRIMARY KEY (MADA)
)

-- Tạo bảng Công Việc
create table CONGVIEC
(
	MADA int,
	STT int,
	TEN_CONG_VIEC nvarchar(50),
	PRIMARY KEY (MADA, STT)
)

-- Tạo bảng Phòng Ban
create table PHONGBAN
(
	TENPHG nvarchar(15),
	MAPHG int,
	TRPHG char(9),
	NG_NHANCHUC date,
	PRIMARY KEY (MAPHG)
)

-- Tạo bảng Phân Công
create table PHANCONG
(
	MA_NVIEN  char(9),
	MADA int,
	STT int,
	THOIGIAN float,
	PRIMARY KEY (MA_NVIEN, MADA, STT)
)

-- Tạo bảng Thân Nhân
create table THANNHAN
(
	MA_NVIEN char(9),
	TENTN nvarchar(15),
	PHAI nvarchar(3),
	NGSINH date,
	QUANHE  nvarchar(15),
	PRIMARY KEY (MA_NVIEN, TENTN)
)

-- Tạo bảng Địa Điểm Phòng
create table DIADIEM_PHG
(
	MAPHG  int,
	DIADIEM nvarchar(15),
	PRIMARY KEY (MAPHG, DIADIEM)
)

-- Tạo khóa ngọai FK_NHANVIEN_NHANVIEN
alter table NHANVIEN 
	add constraint FK_NHANVIEN_NHANVIEN
		foreign key (MA_NQL)
			references NHANVIEN(MANV)

-- Tạo khóa ngọai FK_NHANVIEN_PHONGBAN
alter table NHANVIEN 
	add constraint FK_NHANVIEN_PHONGBAN
		foreign key (PHG)
			references PHONGBAN(MAPHG)

-- Tạo khóa ngọai FK_PHONGBAN_NHANVIEN
alter table PHONGBAN 
	add constraint FK_PHONGBAN_NHANVIEN
		foreign key (TRPHG)
			references NHANVIEN(MANV)

-- Tạo khóa ngọai FK_DEAN_PHONGBAN
alter table DEAN 
	add constraint FK_DEAN_PHONGBAN
		foreign key (PHONG)
			references PHONGBAN(MAPHG)

-- Tạo khóa ngọai FK_CONGVIEC_DEAN
alter table CONGVIEC 
	add constraint FK_CONGVIEC_DEAN
		foreign key (MADA)
			references DEAN(MADA)

-- Tạo khóa ngọai FK_PHANCONG_CONGVIEC
alter table PHANCONG 
	add constraint FK_PHANCONG_CONGVIEC
		foreign key (MADA, STT)
			references CONGVIEC(MADA, STT)

-- Tạo khóa ngọai FK_PHANCONG_NHANVIEN
alter table PHANCONG 
	add constraint FK_PHANCONG_NHANVIEN
		foreign key (MA_NVIEN)
			references NHANVIEN(MANV)

-- Tạo khóa ngọai FK_DIADIEM_PHG_PHONGBAN
alter table THANNHAN 
	add constraint FK_THANNHAN_NHANVIEN
		foreign key (MA_NVIEN)
			references NHANVIEN(MANV)

-- Tạo khóa ngọai FK_DIADIEM_PHG_PHONGBAN
alter table DIADIEM_PHG 
	add constraint FK_DIADIEM_PHG_PHONGBAN
		foreign key (MAPHG)
			references PHONGBAN(MAPHG)