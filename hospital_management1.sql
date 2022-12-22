-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 22, 2022 lúc 05:46 AM
-- Phiên bản máy phục vụ: 10.4.21-MariaDB
-- Phiên bản PHP: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `hospital_management1`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `diagnostics`
--

CREATE TABLE `diagnostics` (
  `id` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `tname` varchar(20) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `dprice` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `diagnostics`
--

INSERT INTO `diagnostics` (`id`, `pid`, `tname`, `tid`, `dprice`, `date`) VALUES
(1, 7, 'Biopsy', 1002, 600, '2022-07-01 19:59:28'),
(2, 7, 'Biopsy', 1002, 600, '2022-07-01 20:00:25'),
(3, 7, 'Complete blood count', 1011, 500, '2022-07-01 20:01:19'),
(4, 13, 'Biopsy', 1002, 600, '2022-07-02 14:22:38'),
(5, 13, 'Electrocardioscopy', 1015, 2050, '2022-07-02 14:30:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `diagnosticsmaster`
--

CREATE TABLE `diagnosticsmaster` (
  `tid` int(11) NOT NULL,
  `tname` varchar(250) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `diagnosticsmaster`
--

INSERT INTO `diagnosticsmaster` (`tid`, `tname`, `price`) VALUES
(1001, 'Blood test', 200),
(1002, 'Biopsy', 600),
(1003, 'Physical examination', 1000),
(1004, 'Medical test', 500),
(1005, 'X-ray', 500),
(1006, 'Magnetic resonance imaging', 800),
(1007, 'Ultrasonography', 3500),
(1008, 'Computed tomography', 950),
(1009, 'Positron emission tomography', 5000),
(1010, 'Genetic testing ', 7000),
(1011, 'Complete blood count', 500),
(1012, 'Serology', 600),
(1013, 'Clinical urine test', 800),
(1014, 'Chest radiograph', 850),
(1015, 'Electrocardioscopy', 2050),
(1016, 'Endoscopy', 5500),
(1017, 'Lumber puncture', 5050),
(1018, 'Pathology', 650),
(1019, 'Angiography', 15000),
(1020, 'Polymerase chain reaction', 9500);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `health insurance`
--

CREATE TABLE `health insurance` (
  `id` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `hic_id` varchar(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `health insurance`
--

INSERT INTO `health insurance` (`id`, `pid`, `hic_id`, `type`) VALUES
(1, 1, 'GD4010120878837', 1),
(2, 3, 'HS4010120875337', 1),
(3, 6, 'CN3020120878837', 2),
(4, 8, 'TE3030120878832', 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `medicinemaster`
--

CREATE TABLE `medicinemaster` (
  `mid` int(11) NOT NULL,
  `mname` varchar(20) DEFAULT NULL,
  `qavailable` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `medicinemaster`
--

INSERT INTO `medicinemaster` (`mid`, `mname`, `qavailable`, `price`) VALUES
(101, 'Levothyroxine', 50, 25),
(102, 'Lisinopril', 145, 100),
(103, 'Atorvastatin', 25, 50),
(104, 'Metformin', 200, 35),
(105, 'Amlodipine', 500, 150),
(106, 'Metroprolol', 100, 75),
(107, 'Omeprazol', 1980, 250),
(108, 'Simvastatin', 150, 7),
(109, 'Losartan', 75, 5),
(110, 'Albuterol', 49, 10),
(111, 'Gabapentine', 100, 100),
(112, 'Furosemide', 25, 250),
(113, 'Amoxicillin ', 500, 100),
(114, 'Citalopram', 200, 150),
(115, 'Tamsulosin', 65, 65),
(116, 'Meloxicam', 600, 500),
(117, 'Aspirin', 450, 100),
(118, 'Glipizide', 50, 8),
(119, 'Duloxetine', 75, 12),
(120, 'Ranitidine', 15, 6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `medicines`
--

CREATE TABLE `medicines` (
  `id` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `mname` varchar(20) DEFAULT NULL,
  `mid` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `medicines`
--

INSERT INTO `medicines` (`id`, `pid`, `mname`, `mid`, `price`, `quantity`, `date`) VALUES
(2, 7, 'Lisinopril', 102, 100, 2, '2020-07-01 19:58:15'),
(3, 7, 'Lisinopril', 102, 100, 3, '2020-07-02 14:05:14'),
(4, 13, 'Albuterol', 110, 10, 1, '2020-07-02 14:37:07'),
(5, 13, 'Omeprazol', 107, 250, 20, '2020-07-02 14:38:16');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `patients`
--

CREATE TABLE `patients` (
  `pid` int(11) NOT NULL,
  `cic_id` int(11) DEFAULT NULL,
  `pname` varchar(20) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `tbed` varchar(20) DEFAULT NULL,
  `address` varchar(20) DEFAULT NULL,
  `phone_number` int(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `patients`
--

INSERT INTO `patients` (`pid`, `cic_id`, `pname`, `age`, `Gender`, `date`, `tbed`, `address`, `phone_number`, `status`) VALUES
(1, 34531184, 'Đặng Tuấn Anh', 24, 'male', '2022-07-01 18:00:33', 'General Ward', 'Hải Phòng', 345311847, 'Active'),
(2, 56635384, 'Hoàng Đức Anh', 24, 'male', '2022-07-01 18:01:21', 'General Ward', 'Hà Giang', 566353841, 'Discharged'),
(3, 32578023, 'Lưu Trang Anh', 15, 'female', '2022-07-01 18:45:40', 'Semi Sharing', 'Cao Bằng', 325780238, 'Active'),
(4, 91984550, 'Phạm Hoàng Anh', 35, 'female', '2022-07-01 18:46:58', 'General Ward', 'Tuyên Quang', 919845505, 'Discharged'),
(5, 32578023, 'Đỗ Hoàng Gia Bảo', 50, 'male', '2022-07-01 18:47:57', 'Single Room', 'Lào Cai', 325780238, 'Discharged'),
(6, 90870143, 'Tăng Phương Chi', 62, 'female', '2022-07-01 18:48:55', 'Single Room', 'Điện Biên', 908701435, 'Active'),
(7, 97190903, 'Phạm Tiến Dũng', 41, 'male', '2022-07-01 18:49:45', 'General Ward', 'Hà Nội', 765113157, 'Active'),
(8, 94401919, 'Nguyễn Thái Dương', 12, 'male', '2022-07-01 18:50:57', 'Semi Sharing', 'Thái Nguyên', 961302917, 'Discharged'),
(9, 76511315, 'Trần An Dương', 19, 'male', '2022-07-01 18:52:56', 'Single Room', 'Quảng Ninh', 971909035, 'Active'),
(10, 36690174, 'Mạc Trung Đức', 22, 'male', '2022-07-01 18:53:50', 'General Ward', 'Hà Nội', 765113157, 'Discharged'),
(11, 36690174, 'Vũ Hương Giang', 36, 'female', '2022-07-01 18:54:47', 'General Ward', 'Hà Nội', 944019196, 'Active'),
(12, 89999313, 'Nguyễn Thị Ngân Hà', 6, 'female', '2022-07-01 18:56:17', 'General Ward', 'Hà Nội', 949952776, 'Discharged'),
(13, 87108899, 'Nguyễn Lê Hiếu', 74, 'male', '2022-07-01 18:57:12', 'Single Room', 'Hà Nội', 366901741, 'Active'),
(14, 94995277, 'Nguyễn Mạnh Hùng', 44, 'male', '2022-07-01 18:58:33', 'Single Room', 'Nam Định', 396543251, 'Discharged'),
(15, 39654325, 'Nguyễn Vũ Gia Hưng', 13, 'male', '2022-07-01 18:59:27', 'General War', 'Nam Định', 871088999, 'Active'),
(16, 89999313, 'Phạm Gia Minh', 26, 'male', '2022-07-01 19:00:16', 'Semi Sharing', 'Nam Định', 899993139, 'Discharged'),
(17, 89995663, 'Đỗ Quang Ngọc', 30, 'male', '2022-07-01 19:01:13', 'Single Room', 'Nam Định', 899956631, 'Active'),
(18, 45678670, 'Đàm Yến Nhi', 8, 'female', '2022-07-01 19:02:12', 'General Ward', 'Nam Định', 456786707, 'Active'),
(19, 49999612, 'Nguyễn Hương Thảo', 21, 'female', '2022-07-01 19:03:35', 'Semi Sharing', 'Hải Dương', 499996129, 'Discharged'),
(20, 85678380, 'Vũ Phương Thảo', 8, 'female', '2022-07-01 19:04:36', 'Single Room', 'Hải Dương', 856783804, 'Active'),
(21, 89995001, 'Trịnh Thiên Trường', 17, 'male', '2022-07-01 19:05:38', 'Semi Sharing', 'Nghệ An', 899950012, 'Active'),
(22, 49995986, 'Ngô Gia Minh', 15, 'male', '2022-07-01 19:06:57', 'Semi Sharing', 'Thanh Hóa', 499959860, 'Discharged');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `age` varchar(20) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `birth` datetime DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `cic_id` int(11) DEFAULT NULL,
  `address` varchar(20) DEFAULT NULL,
  `phone_number` int(20) DEFAULT NULL,
  `degree` varchar(20) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `staff`
--

INSERT INTO `staff` (`id`, `name`, `age`, `Gender`, `birth`, `role`, `cic_id`, `address`, `phone_number`, `degree`, `salary`) VALUES
(1, 'Phạm Tiến Dũng', '41', 'male', '1981-07-01 00:00:00', 'doctor', 97190903, 'Hà Nội', 765113157, 'PhD', 500000000),
(2, 'Nguyễn Thái Dương', '29', 'male', '1993-07-01 00:00:00', 'doctor', 94401919, 'Thái Nguyên', 961302917, 'MA', 300000000),
(3, 'Trần An Dương', '19', 'male', '2002-07-01 00:00:00', 'nurse', 76511315, 'Quảng Ninh', 971909035, 'BA', 120000000),
(4, 'Mạc Trung Đức', '22', 'male', '2000-07-01 00:00:00', 'nurse', 36690174, 'Hà Nội', 765113157, 'MA', 200000000),
(5, 'Vũ Hương Giang', '36', 'female', '1986-07-01 00:00:00', 'doctor', 36690174, 'Hà Nội', 944019196, 'PhD', 400000000),
(6, 'Nguyễn Thị Ngân Hà', '25', 'female', '1998-07-01 00:00:00', 'nurse', 89999313, 'Hà Nội', 949952776, 'BA', 240000000),
(7, 'Nguyễn Lê Hiếu', '54', 'male', '1968-07-01 00:00:00', 'doctor', 87108899, 'Hà Nội', 366901741, 'PhD', 700000000),
(8, 'Nguyễn Mạnh Hùng', '44', 'male', '2078-07-01 00:00:00', 'doctor', 94995277, 'Nam Định', 396543251, 'MA', 400000000),
(9, 'Nguyễn Vũ Gia Hưng', '31', 'male', '1991-07-01 00:00:00', 'doctor', 39654325, 'Nam Định', 871088999, 'MA', 350000000),
(10, 'Phạm Gia Minh', '26', 'male', '1996-07-01 19:00:16', 'nurse', 89999313, 'Nam Định', 899993139, 'BA', 240000000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `userstore`
--

CREATE TABLE `userstore` (
  `id` int(11) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `userstore`
--

INSERT INTO `userstore` (`id`, `username`, `password`, `email`, `role`) VALUES
(1, 'test', 'dung512002', 'dinh4998@gmail.com', 'Doctor');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `diagnostics`
--
ALTER TABLE `diagnostics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tid` (`tid`),
  ADD KEY `pid` (`pid`);

--
-- Chỉ mục cho bảng `diagnosticsmaster`
--
ALTER TABLE `diagnosticsmaster`
  ADD PRIMARY KEY (`tid`);

--
-- Chỉ mục cho bảng `health insurance`
--
ALTER TABLE `health insurance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Chỉ mục cho bảng `medicinemaster`
--
ALTER TABLE `medicinemaster`
  ADD PRIMARY KEY (`mid`);

--
-- Chỉ mục cho bảng `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mid` (`mid`),
  ADD KEY `pid` (`pid`);

--
-- Chỉ mục cho bảng `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`pid`);

--
-- Chỉ mục cho bảng `userstore`
--
ALTER TABLE `userstore`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `userstore`
--
ALTER TABLE `userstore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `diagnostics`
--
ALTER TABLE `diagnostics`
  ADD CONSTRAINT `diagnostics_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `diagnosticsmaster` (`tid`),
  ADD CONSTRAINT `diagnostics_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`);

--
-- Các ràng buộc cho bảng `health insurance`
--
ALTER TABLE `health insurance`
  ADD CONSTRAINT `health insurance_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`);

--
-- Các ràng buộc cho bảng `medicines`
--
ALTER TABLE `medicines`
  ADD CONSTRAINT `medicines_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`),
  ADD CONSTRAINT `mid` FOREIGN KEY (`mid`) REFERENCES `medicinemaster` (`mid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
