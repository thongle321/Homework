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
WHERE HONV LIKE N'Đinh' AND TENLOT LIKE N'Bá' AND TENNV LIKE N'Tiên'
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
SELECT HONV, TENLOT, TENNV, PHG
FROM NHANVIEN, PHONGBAN
WHERE MANV = TRPHG
--12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghiên cứu".
SELECT HONV, TENLOT, TENNV, DCHI
FROM NHANVIEN, PHONGBAN
WHERE PHG = MAPHG AND TENPHG = N'Nghiên cứu'
--13. Với mỗi đề án ở Hà Nội, cho biết tên đề án, tên phòng ban, họ tên và
--ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
SELECT TENDA, TENPHG, HONV, TENLOT, TENNV,NG_NHANCHUC
FROM DEAN D, PHONGBAN P, NHANVIEN N

--14. Tìm tên những nữ nhân viên và tên người thân của họ
SELECT HONV, TENLOT, TENNV, TENTN
FROM NHANVIEN nv, THANNHAN
WHERE nv.MANV = MA_NVIEN AND nv.PHAI = N'Nữ'
--15. Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý
--trực tiếp của nhân viên đó
SELECT NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV HoTenNV,
	NQL.HONV + ' ' + NQL.TENLOT + ' ' + NQL.TENNV HoTenNQL
From NHANVIEN NV, NHANVIEN NQL
WHERE NV.MA_NQL = NQL.MANV

--16. Với mỗi nhân viên, cho biết họ tên của nhân viên đó, họ tên người
--trưởng phòng và họ tên người quản lý trực tiếp của nhân viên đó.
SELECT NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV HoTenNV,
	NQL.HONV + ' ' + NQL.TENLOT + ' ' + NQL.TENNV HoTenNQL,
	TP.HONV + ' ' + TP.TENLOT + ' ' + TP.TENNV HoTenTP
FROM NHANVIEN NV LEFT JOIN NHANVIEN NQL ON NV.MA_NQL = NQL.MANV, PHONGBAN PB, NHANVIEN TP
WHERE NV.PHG = PB.MAPHG AND PB.TRPHG = TP.MANV
--17. Tên những nhân viên phòng số 5 có tham gia vào đề án "Sản phẩm X"
--và nhân viên này do "Nguyễn Thanh Tùng" quản lý trực tiếp.
SELECT NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV
FROM NHANVIEN NV, PHANCONG PC, DEAN DA, NHANVIEN NQL
WHERE NV.MANV = PC.MA_NVIEN AND PC.MADA = DA.MADA AND NV.MA_NQL = NQL.MANV
	AND NV.PHG = 5 AND DA.TENDA = N'San Pham X' AND
	NQL.HONV + ' ' + NQL.TENLOT + ' ' + NQL.TENNV = N'Nguyen Thanh Tung'
--18. Cho biết tên các đề án mà nhân viên Đinh Bá Tiến đã tham gia
SELECT TENDA
FROM NHANVIEN, PHANCONG, DEAN
WHERE MANV = MA_NVIEN AND PHANCONG.MADA = DEAN.MADA AND
	HONV + ' ' + TENLOT + ' ' + TENNV = N'Đinh Bá Tiến'
--19. Cho biết số lượng đề án của công ty
SELECT COUNT(MADA)SLDA
FROM DEAN
--20. Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì
SELECT COUNT(MADA)
FROM DEAN, PHONGBAN
WHERE PHONG = MAPHG AND TENPHG = N'Nghien cuu'
--21. Cho biết lương trung bình của các nữ nhân viên
SELECT AVG(LUONG) LTBNu
FROM NHANVIEN
WHERE PHAI = N'Nu'
--22. Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'
SELECT COUNT(QUANHE)SLTHANNHAN
FROM NHANVIEN, THANNHAN
WHERE MANV = MA_NVIEN AND HONV = N'Đinh' AND TENLOT = N'Bá' AND TENNV = N'Tiên'
--23. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của
--tất cả các nhân viên tham dự đề án đó.
SELECT TENDA, SUM (THOIGIAN) TGGIOLAM
FROM DEAN DA, PHANCONG PC
WHERE DA.MADA = PC.MADA
GROUP BY DA.MADA, TENDA
--24. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó
SELECT COUNT(PC.MADA) SLNHANVIEN
FROM DEAN DA, PHANCONG PC
WHERE DA.MADA = PC.MADA
GROUP BY DA.MADA
--25. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân
--của nhân viên đó.
SELECT HONV, TENLOT, TENNV, COUNT(QUANHE) SLNHANTHAN
FROM NHANVIEN, THANNHAN
WHERE MANV = MA_NVIEN
GROUP BY MANV, HONV, TENLOT, TENNV
--26. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà
--nhân viên đó đã tham gia.
SELECT HONV, TENLOT, TENNV, COUNT(MADA)
FROM NHANVIEN, PHANCONG
WHERE MANV = MA_NVIEN
GROUP BY MANV, HONV, TENLOT, TENNV
--27. Với mỗi nhân viên, cho biết số lượng nhân viên mà nhân viên đó quản
--lý trực tiếp.
SELECT COUNT(NV.MANV) SLNHANVIENQUANLY
FROM NHANVIEN NV, NHANVIEN NQL
WHERE NV.MANV = NQL.MA_NQL
GROUP BY NV.MANV
--28. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của
--những nhân viên làm việc cho phòng ban đó.
SELECT TENPHG, AVG(LUONG) LUONGTBNV
FROM PHONGBAN, NHANVIEN
WHERE MAPHG = PHG
GROUP BY MAPHG, TENPHG
--29. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên
--phòng ban và số lượng nhân viên của phòng ban đó.
SELECT AVG(LUONG) LUONGTB, TENPHG, COUNT(MANV)
FROM PHONGBAN PB, NHANVIEN NV
WHERE PB.MAPHG = NV.PHG AND LUONG > 30000
GROUP BY PB.MAPHG, TENPHG
--30. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà
--phòng ban đó chủ trì
SELECT TENPHG, COUNT(MADA)SLDA
FROM PHONGBAN PB, DEAN DA
WHERE PB.MAPHG = DA.PHONG
GROUP BY PB.MAPHG, TENPHG
--31. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng
--phòng và số lượng đề án mà phòng ban đó chủ trì
SELECT TENPHG, NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV + ' ' HOTENNV, COUNT(MADA) SLDA
FROM PHONGBAN PB, NHANVIEN NV, DEAN DA
WHERE DA.PHONG = PB.MAPHG AND PB.TRPHG = NV.MANV
GROUP BY PB.MAPHG, TENPHG, NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV + ' '
--32. Với mỗi phòng ban có mức lương trung bình lớn hơn 40,000, cho biết
--tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.
SELECT AVG(LUONG) LUONGTB, TENPHG, COUNT(MADA) SLDA
FROM PHONGBAN PB, NHANVIEN NV, DEAN DA
WHERE PB.MAPHG = DA.PHONG AND PB.MAPHG = NV.PHG AND LUONG > 40000
GROUP BY PB.MAPHG, TENPHG
--33. Cho biết số đề án diễn ra tại từng địa điểm
--34. Với mỗi đề án, cho biết tên đề án và số lượng công việc của đề án này.
SELECT TENDA, COUNT(CV.MADA) SLCV
FROM DEAN DA, CONGVIEC CV
WHERE DA.MADA = CV.MADA
GROUP BY DA.MADA, TENDA
--35. Với mỗi công việc trong đề án có mã đề án là 30, cho biết số lượng
--nhân viên được phân công.
SELECT COUNT(MA_NVIEN) SLNV
FROM DEAN DA, PHANCONG PC
WHERE DA.MADA = PC.MADA AND DA.MADA = 30
GROUP BY DA.MADA
--36. Với mỗi công việc trong đề án có mã đề án là 'Dao Tao', cho biết số
--lượng nhân viên được phân công.
SELECT TENDA, COUNT(MA_NVIEN) SLNV
FROM DEAN DA, PHANCONG PC
WHERE DA.MADA = PC.MADA AND DA.TENDA = N'Đào tạo'
GROUP BY DA.MADA, TENDA
--2.3 TRUY VẤN LỒNG + GOM NHÓM
--37. Cho biết danh sách các đề án (MADA) có: nhân công với họ (HONV) là
--'Đinh' hoặc có người trưởng phòng chủ trì đề án với họ (HONV) là
--'Đinh'.
SELECT DA.MADA
FROM DEAN DA, NHANVIEN NV
WHERE DA.PHONG = NV.PHG AND NV.HONV = N'Đinh'
UNION 
SELECT DA.MADA
FROM DEAN DA, PHONGBAN PB, NHANVIEN NV
WHERE DA.PHONG = PB.MAPHG AND PB.TRPHG = NV.MANV AND NV.HONV = N'Trần'
--38. Danh sách những nhân viên (HONV, TENLOT, TENNV) có trên 2 thân
--nhân.
SELECT NV1.HONV, NV1.TENLOT, NV1.TENNV, COUNT(NV1.MANV)
FROM NHANVIEN NV1, THANNHAN TN

SELECT NV.HONV, NV.TENLOT, NV.TENNV, COUNT(MANV)
FROM NHANVIEN NV, THANNHAN TN
WHERE NV.MANV = TN.MA_NVIEN
GROUP BY NV.MANV, NV.HONV, NV.TENLOT, NV.TENNV
HAVING COUNT(MANV) >= 2

--39. Danh sách những nhân viên (HONV, TENLOT, TENNV) không có thân
--nhân nào.
SELECT HONV, TENLOT, TENNV
FROM NHANVIEN
WHERE MANV NOT IN (SELECT MA_NVIEN FROM THANNHAN)
--40. Danh sách những trưởng phòng (HONV, TENLOT, TENNV) có tối thiểu
--một thân nhân.
SELECT *
FROM NHANVIEN NV, PHONGBAN PB, (SELECT MA_NVIEN
								FROM THANNHAN
								GROUP BY MA_NVIEN
								HAVING COUNT(MA_NVIEN) >= 1)
--WHERE NV.PHG = PB.MAPHG AND 
								
--41. Tìm họ (HONV) của những trưởng phòng chưa có gia đình.
SELECT HONV
FROM PHONGBAN, NHANVIEN
WHERE TRPHG = MANV AND MANV NOT IN (SELECT MA_NVIEN FROM THANNHAN)
--42. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên
--mức lương trung bình của phòng "Nghiên cứu"
SELECT HONV, TENLOT, TENNV, LUONG
FROM NHANVIEN, PHONGBAN
WHERE PHG = MAPHG AND LUONG > (SELECT AVG(LUONG)
							   FROM NHANVIEN, PHONGBAN
							   WHERE PHG = MAPHG AND TENPHG = N'Nghiên cứu')			
GROUP BY MANV, HONV, TENLOT, TENNV, LUONG

--43. Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có
--đông nhân viên nhất.
SELECT *
FROM PHONGBAN, NHANVIEN
WHERE MAPHG = PHG
--44. Cho biết danh sách các mã đề án mà nhân viên có mã là 009 chưa làm.
--45. Cho biết danh sách các công việc (tên công việc) trong đề án 'Sản
--phẩm X
--46. Tìm họ tên (HONV, TENLOT, TENNV) và địa chỉ (DCHI) của những
--nhân viên làm việc cho một đề án ở 'TP HCM' nhưng phòng ban mà họ
--trực thuộc lại không tọa lạc ở thành phố 'TP HCM'.
--47. Tổng quát câu 16, tìm họ tên và địa chỉ của các nhân viên làm việc cho
--một đề án ở một thành phố nhưng phòng ban mà họ trực thuộc lại
--không toạ lạc ở thành phố đó.

--2.4 PHÉP CHIA
--48. Danh sách những nhân viên (HONV, TENLOT, TENNV) làm việc trong
--mọi đề án của công ty
--49. Danh sách những nhân viên (HONV, TENLOT, TENNV) được phân công
--tất cả đề án do phòng số 4 chủ trì.
--50. Tìm những nhân viên (HONV, TENLOT, TENNV) được phân công tất cả
--đề án mà nhân viên 'Đinh Bá Tiến' làm việc
--51. Cho biết những nhân được phân công cho tất cả các công việc trong đề
--án 'Sản phẩm X'
--52. Cho biết danh sách nhân viên tham gia vào tất cả các đề án ở TP HCM
--53. Cho biết phòng ban chủ trì tất cả các đề án ở TP HCM\

--1.
SELECT HONV, TENLOT, TENNV
FROM NHANVIEN
WHERE PHG = 4 AND LUONG >= ALL (SELECT LUONG FROM NHANVIEN WHERE PHG = 4)

--3. cho biết thông tin những nhân viên có tổng giờ làm đề án nhiều nhất
SELECT HONV, TENLOT , TENNV, MA_NVIEN, NGSINH, SUM(THOIGIAN) TTG
FROM NHANVIEN, PHANCONG
WHERE MANV = MA_NVIEN
GROUP BY MA_NVIEN, HONV, TENLOT , TENNV, MA_NVIEN, NGSINH
HAVING SUM(THOIGIAN) >= ALL (SELECT SUM(THOIGIAN)
							 FROM PHANCONG
							 GROUP BY MA_NVIEN)
--4. cho biết thông tin họ tên nhân viên có lương lớn nhât của mỗi phòng
SELECT NV.*
FROM NHANVIEN NV, (SELECT PHG, MAX(LUONG) LM
				   FROM NHANVIEN
				   GROUP BY PHG) PMAX
WHERE NV.PHG = PMAX.PHG AND NV.LUONG = LM

SELECT *
FROM NHANVIEN NV1
WHERE LUONG = (SELECT MAX(NV2.LUONG)
				FROM NHANVIEN NV2
				WHERE NV2.PHG = NV1.PHG)
--5 Cho biết họ tên nhân viên có tổng giờ làm cao nhất
SELECT HONV, TENLOT, TENNV, THOIGIAN
FROM NHANVIEN, PHANCONG
WHERE MANV = MA_NVIEN AND THOIGIAN >=(SELECT MAX(THOIGIAN)
									FROM NHANVIEN, PHANCONG
									WHERE MANV = MA_NVIEN)
GROUP BY MANV, HONV, TENLOT, TENNV, THOIGIAN
