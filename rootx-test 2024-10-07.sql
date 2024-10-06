-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 06, 2024 at 03:43 PM
-- Server version: 10.4.16-MariaDB
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rootx-test`
--

-- --------------------------------------------------------

--
-- Table structure for table `businfo`
--

CREATE TABLE `businfo` (
  `BusID` int(10) NOT NULL,
  `BusRouteID` int(10) NOT NULL,
  `Start_Location` varchar(50) NOT NULL,
  `End_Location` varchar(50) NOT NULL,
  `Start_time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Bus_Number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `businfo`
--

INSERT INTO `businfo` (`BusID`, `BusRouteID`, `Start_Location`, `End_Location`, `Start_time`, `End_Time`, `Bus_Number`) VALUES
(1, 35, 'Makubura', 'Matara', '08:00:00', '09:00:00', 'NT-100'),
(2, 36, 'Makubura', 'Monaragala', '08:00:00', '09:00:00', 'NT-101'),
(3, 37, 'Mathara', 'Monaragala', '08:00:00', '09:00:00', 'NT-103'),
(4, 1, 'Colombo', 'Kandy', '06:00:00', '08:30:00', 'B101'),
(5, 2, 'Galle', 'Colombo', '07:00:00', '09:30:00', 'B102'),
(6, 3, 'Kandy', 'Nuwara Eliya', '08:00:00', '10:00:00', 'B103'),
(7, 4, 'Negombo', 'Colombo', '05:30:00', '06:30:00', 'B104'),
(8, 5, 'Jaffna', 'Vavuniya', '09:00:00', '11:00:00', 'B105'),
(9, 6, 'Colombo', 'Anuradhapura', '10:00:00', '12:30:00', 'B106'),
(10, 7, 'Matara', 'Colombo', '11:00:00', '13:00:00', 'B107'),
(11, 8, 'Colombo', 'Trincomalee', '12:00:00', '14:30:00', 'B108'),
(12, 9, 'Batticaloa', 'Colombo', '13:00:00', '15:00:00', 'B109'),
(13, 10, 'Kurunegala', 'Colombo', '14:00:00', '16:30:00', 'B110'),
(14, 11, 'Galle', 'Jaffna', '15:00:00', '17:30:00', 'B111'),
(15, 12, 'Kandy', 'Colombo', '16:00:00', '18:30:00', 'B112'),
(16, 13, 'Colombo', 'Polonnaruwa', '17:00:00', '19:00:00', 'B113'),
(17, 14, 'Colombo', 'Dambulla', '18:00:00', '20:00:00', 'B114'),
(18, 15, 'Anuradhapura', 'Colombo', '19:00:00', '21:30:00', 'B115'),
(19, 16, 'Kandy', 'Colombo', '20:00:00', '22:30:00', 'B116'),
(20, 17, 'Colombo', 'Nuwara Eliya', '21:00:00', '23:30:00', 'B117'),
(21, 18, 'Colombo', 'Hikkaduwa', '22:00:00', '00:30:00', 'B118'),
(22, 19, 'Kandy', 'Badulla', '23:00:00', '01:00:00', 'B119'),
(23, 20, 'Colombo', 'Matara', '00:00:00', '02:00:00', 'B120');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `phone`, `password`) VALUES
(2, 'asela@gmail.com', 'SASE', '0124578', '$2b$12$lPe3mCvdJCCYrwmagshh4.WVqJ.Ly0O2HEpmdv7lgVVUyis0yIkeC'),
(3, 'lasih@gmail.com', 'Lasith', '123', '$2b$12$o1lQI0QMfU.fsnu/f1XRHOxd7p8IoGjahClFm5noDMe8/Y/CAe/oO'),
(4, 'test@example.com', 'testuser', '1234567890', '$2b$12$DBfqjfMDUU2Ut2DP0id.6.Kj7dqizPs1Lzaodah.2UugH3VCjucbq'),
(5, '123@gmail.com', 'Asela', '0763146805', '$2b$12$bonDD0UAeKOdR6KYBkulzeMxu5gvjAXpGIpGTM1YeGaqerF8N6eMG'),
(6, 'rohana@gmail.com', 'rohana', '123', '$2b$12$IAlqllsb/S73ChfaYb5jh.BGrGK69i9iey/aQvx5FMD1DpPKsfvKy'),
(7, 'testuser@example.com', 'testuser', '1234567890', '$2b$12$sXiGgg6WYbLxIndCzLhEYewkSAJfNJ3RxXOcKByXv7PR56JCvDzmC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `businfo`
--
ALTER TABLE `businfo`
  ADD PRIMARY KEY (`BusID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `businfo`
--
ALTER TABLE `businfo`
  MODIFY `BusID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
