--1. Tìm các nhân viên làm việc ở phòng số 4
SELECT * FROM NHANVIEN WHERE PHG = 4;
--2. Tìm các nhân viên có mức lương trên 30000
SELECT * FROM NHANVIEN WHERE LUONG > 30000;
--3. Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân
--viên có mức lương trên 30,000 ở phòng 5\
SELECT *
FROM NHANVIEN
WHERE (LUONG > 25000 AND PHG = 4) OR (LUONG > 30000 AND PHG = 5)
--4. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
SELECT HONV + ' ' + TENLOT + ' ' + TENNV AS TENDAYDU, DCHI
FROM NHANVIEN
WHERE DCHI LIKE '%TP HCM%'
--5. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
SELECT *
FROM NHANVIEN
WHERE HONV LIKE 'N%'
--6. Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien
SELECT NGSINH,DCHI,HONV,TENLOT,TENNV
FROM NHANVIEN
WHERE HONV LIKE N'Đinh' AND TENLOT LIKE 'Bá' AND TENNV LIKE N'Tiên'
--7. Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965
SELECT *
FROM NHANVIEN
WHERE YEAR(NGSINH) BETWEEN 1960 AND 1965
--8. Cho biết các nhân viên và năm sinh của nhân viên
SELECT *, YEAR(NGSINH) NAM
FROM NHANVIEN
--9. Cho biết các nhân viên và tuổi của nhân viên
SELECT *, YEAR(GETDATE()) - YEAR(NGSINH) TUOI
FROM NHANVIEN

--2.1.2 Truy vấn có sử dụng phép kết
--10. Với mỗi phòng ban, cho biết tên phòng ban và địa điểm phòng
SELECT TENPHG,DIADIEM
FROM PHONGBAN, DIADIEM_PHG
--11. Tìm tên những người trưởng phòng của từng phòng ban
SELECT 
FROM NHANVIEN
--12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghiên cứu".
--13. Với mỗi đề án ở Hà Nội, cho biết tên đề án, tên phòng ban, họ tên và
--ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
SELECT TENDA, TENPHG, HONV, TENLOT, TENNV,NG_NHANCHUC
FROM DEAN D, PHONGBAN P, NHANVIEN N

--14. Tìm tên những nữ nhân viên và tên người thân của họ
--15. Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý
--trực tiếp của nhân viên đó
--16. Với mỗi nhân viên, cho biết họ tên của nhân viên đó, họ tên người
--trưởng phòng và họ tên người quản lý trực tiếp của nhân viên đó.
--17. Tên những nhân viên phòng số 5 có tham gia vào đề án "Sản phẩm X"
--và nhân viên này do "Nguyễn Thanh Tùng" quản lý trực tiếp.
--18. Cho biết tên các đề án mà nhân viên Đinh Bá Tiến đã tham gia