--1. Hiển danh sách tất cả các khách hàng gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và
--địa chỉ E-mail.
SELECT *
FROM KHACHHANG
--2. Hiển thị danh sách tất cả các vật tư gồm tên vật tư, giá mua, số lượng tồn
SELECT TENVT, GIAMUA, SLTON
FROM VATTU
--3. Hiển danh sách các khách hàng có địa chỉ là “TÂN BÌNH” gồm mã khách hàng, tên khách hàng, địa
--chỉ, điện thoại, và địa chỉ E-mail.
SELECT *
FROM KHACHHANG
WHERE DIACHI = N'TÂN BÌNH'
--4. Hiển danh sách các khách hàng có địa chỉ là “BÌNH CHÁNH” gồm mã khách hàng, tên khách hàng,
--địa chỉ, điện thoại, và địa chỉ E-mail.
SELECT *
FROM KHACHHANG
WHERE DIACHI = N'BÌNH CHÁNH'
--5. Hiển thị danh sách vật tư có giá mua từ 15000 trở lên (hiển thị tất cả thông tin)
SELECT *
FROM VATTU
WHERE GIAMUA >= 15000
--6. Hiển thị tất cả thông tin trong danh sách vật tư có lượng tồn trên 50000
SELECT *
FROM VATTU
WHERE SLTON > 50000
--7. Hiển danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng, địa chỉ và địa
--chỉ E-mail của những khách hàng chưa có số điện thoại
SELECT *
FROM KHACHHANG
WHERE DT IS NULL

--8. Hiển danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa chỉ Email gồm mã khách
--hàng, tên khách hàng, địa chỉ.
SELECT *
FROM KHACHHANG
WHERE DT IS NULL AND EMAIL IS NULL 
--9. Hiển danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên
--khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
SELECT *
FROM KHACHHANG
WHERE DT IS NOT NULL AND EMAIL IS NOT NULL 
--10. Hiển danh sách tất cả các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
SELECT *
FROM VATTU
--11. Hiển danh sách các vật tư có đơn vị tính là “CAI” gồm mã vật tư, tên vật tư và giá mua.
SELECT MAVT, TENVT ,DVT, GIAMUA
FROM VATTU
WHERE DVT = N'CÁI'
--12. Hiển danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên
--25000.
SELECT MAVT, TENVT, DVT, GIAMUA
FROM VATTU
WHERE GIAMUA > 25000
--13. Hiển danh sách các vật tư là “GẠCH” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính
--và giá mua .
SELECT MAVT, TENVT, DVT, GIAMUA
FROM VATTU
WHERE TENVT LIKE N'G%'
--14. Hiển danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm
--trong khoảng từ 20000 đến 40000.
SELECT MAVT, TENVT, DVT, GIAMUA
FROM VATTU
WHERE GIAMUA BETWEEN 20000 AND 40000
--15. Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách
--hàng và số điện thoại.
SELECT MAHD, NGAY, TENKH, DIACHI, DT
FROM HOADON H, KHACHHANG K
WHERE H.MAKH = K.MAKH
--16. Tạo query để lấy ra các thông tin gồm Mã hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện
--thoại của ngày 25/5/2015.
SELECT MAHD, TENKH, DIACHI, DT, NGAY
FROM HOADON H, KHACHHANG K
WHERE H.MAKH = K.MAKH AND NGAY = '2015/05/25'
--17. Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách
--hàng và số điện thoại của những hoá đơn trong tháng 6/2015.
SELECT MAHD, NGAY, TENKH, DIACHI, DT 
FROM HOADON H, KHACHHANG K
WHERE H.MAKH = K.MAKH AND NGAY BETWEEN '2015/06/1' AND '2015/06/30'
--18. Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách
--hàng và số điện thoại.
SELECT MAHD, NGAY, TENKH, DIACHI, DT
FROM HOADON H, KHACHHANG K
WHERE H.MAKH = K.MAKH
--19. Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong
--tháng 6/2015.
SELECT TENKH, DIACHI, DT, NGAY
FROM KHACHHANG K, HOADON H
WHERE K.MAKH = H.MAKH AND NGAY BETWEEN '2015/06/1' AND '2015/06/30'
--20. Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2015 gồm các thông tin tên
--khách hàng, địa chỉ, số điện thoại.
SELECT TENKH, DIACHI, DT, NGAY
FROM KHACHHANG K, HOADON H
WHERE K.MAKH = H.MAKH AND NGAY NOT IN (SELECT NGAY
										FROM HOADON
										WHERE NGAY BETWEEN '2015/06/1' AND '2015/06/30')
--21. Tạo query để lấy ra các thông tin gồm các thông tin mã hóa đơn, ,mã vật tư, tên vật tư, đơn vị tính,
--giá bán, giá mua, số lượng , trị giá mua (giá mua * số lượng), trị giá bán , ( giá bán * số lượng).
SELECT MAHD, V.MAVT, TENVT, DVT, GIABAN, GIAMUA, SL, (GIAMUA*SL) AS TRIGIAMUA , (GIABAN*SL) AS TRIGIABAN
FROM CHITIETHOADON CTHD, VATTU V
WHERE CTHD.MAVT = V.MAVT
--22. Tạo query để lấy ra các chi tiết hoá đơn gồm các thông tin mã hóa đơn, ,mã vật tư, tên vật tư, đơn
--vị tính, giá bán, giá mua, số lượng , trị giá mua (giá mua * số lượng), trị giá bán , ( giá bán * số
--lượng) mà có giá bán lớn hơn hoặc bằng giá mua.
SELECT MAHD, V.MAVT, TENVT, DVT, GIABAN, GIAMUA, SL, (GIAMUA*SL) AS TRIGIAMUA , (GIABAN*SL) AS TRIGIABAN
FROM CHITIETHOADON CTHD, VATTU V
WHERE CTHD.GIABAN >= V.GIAMUA
--23. Tạo query để lấy ra các thông tin gồm mã hóa đơn, ,mã vật tư, tên vật tư, đơn vị tính, giá bán, giá
--mua, số lượng , trị giá mua (giá mua * số lượng), trị giá bán , ( giá bán * số lượng) và cột khuyến
--mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lơn hơn 100.
SELECT MAHD, VT.MAVT, TENVT, DVT, GIABAN, GIAMUA, SL, (GIAMUA*SL) TRIGIAMUA , (GIABAN*SL) TRIGIABAN,
(CASE WHEN SL > 100 THEN 0.1 ELSE 0 END) KHUYENMAI
FROM CHITIETHOADON CT, VATTU VT
WHERE CT.MAVT = VT.MAVT
--24. Tìm ra những mặt hàng chưa bán được.
 
--25. Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện
--thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán.
SELECT CTHD.MAHD, NGAY, TENKH, DIACHI, DT, TENVT, DVT, GIAMUA, GIABAN, SL, (GIAMUA*SL) TRIGIAMUA , (GIABAN*SL) TRIGIABAN
FROM HOADON H, KHACHHANG K, VATTU VT, CHITIETHOADON CTHD
--26. Tạo bảng tổng hợp của tháng 5/2015 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách
----hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá
----bán.
SELECT H.MAHD, NGAY, TENKH, DIACHI, DT, TENVT, DVT, GIAMUA, GIABAN, SL, (GIAMUA*SL) TRIGIAMUA , (GIABAN*SL) TRIGIABAN
FROM HOADON H, KHACHHANG K, CHITIETHOADON CTHD, VATTU VT
WHERE H.MAKH = K.MAKH AND H.MAHD = CTHD.MAHD AND CTHD.MAVT = VT.MAVT AND NGAY BETWEEN '2015/05/01' AND '2015/05/31'
--27. Tạo bảng tổng hợp của tháng 6/2015 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách
--hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá
--bán.
SELECT H.MAHD, NGAY, TENKH, DIACHI, DT, TENVT, DVT, GIAMUA, GIABAN, SL, (GIAMUA*SL) TRIGIAMUA , (GIABAN*SL) TRIGIABAN
FROM HOADON H, KHACHHANG K, CHITIETHOADON CTHD, VATTU VT
WHERE H.MAKH = K.MAKH AND H.MAHD = CTHD.MAHD AND CTHD.MAVT = VT.MAVT AND NGAY BETWEEN '2015/06/01' AND '2015/06/30'
--28. Tạo bảng tổng hợp của quý 1 năm 2015 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách
--hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá
--bán.
--29. Lấy ra danh sách các hoá đơn gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách
--hàng, tổng trị giá của hoá đơn.
SELECT H.MAHD, NGAY, TENKH, DIACHI, COUNT(CTHD.GIABAN)
FROM HOADON H, KHACHHANG K, CHITIETHOADON CTHD
WHERE CTHD.MAHD = H.MAHD AND H.MAKH = K.MAKH
--30. Lấy ra hoá đơn có tổng trị giá lớn nhất gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa
--chỉ khách hàng, tổng trị giá của hoá đơn.
SELECT H.MAHD, NGAY, TENKH, DIACHI, SUM(SL*GIABAN) TONGGIATRI
FROM HOADON H, KHACHHANG K, CHITIETHOADON CTHD
WHERE H.MAKH = K.MAKH AND H.MAHD = CTHD.MAHD
GROUP BY H.MAHD, NGAY, TENKH, DIACHI
HAVING SUM(SL*GIABAN) >= ALL (SELECT SUM(SL*GIABAN)
								FROM CHITIETHOADON
								GROUP BY MAHD)
															

--31. Lấy ra hoá đơn có tổng trị giá lớn nhất trong tháng 5/2015 gồm các thông tin: Số hoá đơn, ngày,
--tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
SELECT H.MAHD, NGAY, TENKH, DIACHI, SL
FROM HOADON H, KHACHHANG K, CHITIETHOADON CTHD
WHERE H.MAKH = K.MAKH AND H.MAHD = CTHD.MAHD AND SL >= ALL (SELECT MAX(SL)
															FROM CHITIETHOADON CTHD, HOADON H
															WHERE CTHD.MAHD = H.MAHD AND NGAY BETWEEN '2015/05/01' AND '2015/05/31')	
GROUP BY H.MAHD, NGAY, TENKH, DIACHI, SL

--32. Lấy ra hoá đơn có tổng trị giá nhỏ nhất gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa
--chỉ khách hàng, tổng trị giá của hoá đơn.
SELECT H.MAHD, NGAY, TENKH, DIACHI, SL
FROM HOADON H, KHACHHANG K, CHITIETHOADON CTHD
WHERE H.MAKH = K.MAKH AND H.MAHD = CTHD.MAHD AND SL <= ALL (SELECT MIN(SL)
															FROM CHITIETHOADON)
																
--33. Đếm xem mỗi khách hàng có bao nhiêu hoá đơn.
SELECT TENKH, COUNT(H.MAHD) SOHOADON
FROM KHACHHANG K, HOADON H, CHITIETHOADON CTHD
WHERE K.MAKH = H.MAKH AND H.MAHD = CTHD.MAHD
GROUP BY H.MAKH, TENKH
--34. Lấy ra các thông tin của khách hàng có số lượng hoá đơn mua hàng nhiều nhất.
SELECT K.MAKH, TENKH, DIACHI, DT, EMAIL, COUNT(CTHD.MAHD)
FROM KHACHHANG K, CHITIETHOADON CTHD, HOADON H
WHERE H.MAKH = K.MAKH AND CTHD.MAHD = H.MAHD
GROUP BY CTHD.MAHD, K.MAKH, TENKH, DIACHI, DT, EMAIL
--35. Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
--36. Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hoá đơn nhất.
--37. Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất.
--38. Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, địa chỉ , số lượng hoá
--đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hoá đơn để trống)
SELECT K.MAKH, TENKH, DIACHI, COUNT(H.MAHD)
FROM KHACHHANG K, HOADON H, CHITIETHOADON CTHD
WHERE K.MAKH = H.MAKH AND H.MAHD = CTHD.MAHD