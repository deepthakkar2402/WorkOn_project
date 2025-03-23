-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 23, 2025 at 07:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `workon`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_master`
--

CREATE TABLE `admin_master` (
  `admin_id` int(3) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `area_master`
--

CREATE TABLE `area_master` (
  `area_id` int(3) NOT NULL,
  `area_name` varchar(40) NOT NULL,
  `city_id` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_master`
--

CREATE TABLE `booking_master` (
  `booking_id` int(10) NOT NULL,
  `customer_id` int(4) NOT NULL,
  `worker_id` int(6) NOT NULL,
  `description` varchar(200) NOT NULL,
  `contact` bigint(10) NOT NULL,
  `address` varchar(250) NOT NULL,
  `booking_date` date NOT NULL,
  `status` enum('pending','completed','cancelled') NOT NULL DEFAULT 'pending',
  `skill_id` int(6) NOT NULL,
  `otp` int(7) NOT NULL,
  `is_self_booking` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_master`
--

CREATE TABLE `bookmark_master` (
  `bookmark_id` int(10) NOT NULL,
  `customer_id` int(4) NOT NULL,
  `worker_id` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_master`
--

CREATE TABLE `chat_master` (
  `chat_id` int(10) NOT NULL,
  `sender_id` int(6) NOT NULL,
  `receiver_id` int(6) NOT NULL,
  `message` varchar(255) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `city_master`
--

CREATE TABLE `city_master` (
  `city_id` int(3) NOT NULL,
  `city_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_master`
--

CREATE TABLE `customer_master` (
  `customer_id` int(4) NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact` bigint(15) NOT NULL,
  `address` text NOT NULL,
  `city_id` int(3) NOT NULL,
  `area_id` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rate`
--

CREATE TABLE `rate` (
  `rate_id` int(4) NOT NULL,
  `customer_id` int(4) NOT NULL,
  `worker_id` int(6) NOT NULL,
  `rating` tinyint(1) NOT NULL CHECK (`rating` between 1 and 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skill_list`
--

CREATE TABLE `skill_list` (
  `skill_id` int(6) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `worker_master`
--

CREATE TABLE `worker_master` (
  `worker_id` int(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  `gender` varchar(6) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact` bigint(10) NOT NULL,
  `address` varchar(250) NOT NULL,
  `city_id` int(3) NOT NULL,
  `area_id` int(3) NOT NULL,
  `skill_id` int(6) NOT NULL,
  `experience` int(3) NOT NULL,
  `profile_picture` varchar(100) DEFAULT NULL,
  `aadhar_number` bigint(14) NOT NULL,
  `identity_doc` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `is_blocked` tinyint(1) NOT NULL DEFAULT 0,
  `visit_charges` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_master`
--
ALTER TABLE `admin_master`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `area_master`
--
ALTER TABLE `area_master`
  ADD PRIMARY KEY (`area_id`),
  ADD UNIQUE KEY `unique_area_city` (`area_name`,`city_id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `booking_master`
--
ALTER TABLE `booking_master`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `worker_id` (`worker_id`),
  ADD KEY `skill_id` (`skill_id`);

--
-- Indexes for table `bookmark_master`
--
ALTER TABLE `bookmark_master`
  ADD PRIMARY KEY (`bookmark_id`),
  ADD UNIQUE KEY `unique_bookmark` (`customer_id`,`worker_id`),
  ADD KEY `worker_id` (`worker_id`);

--
-- Indexes for table `chat_master`
--
ALTER TABLE `chat_master`
  ADD PRIMARY KEY (`chat_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `city_master`
--
ALTER TABLE `city_master`
  ADD PRIMARY KEY (`city_id`),
  ADD UNIQUE KEY `city_name` (`city_name`);

--
-- Indexes for table `customer_master`
--
ALTER TABLE `customer_master`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indexes for table `rate`
--
ALTER TABLE `rate`
  ADD PRIMARY KEY (`rate_id`),
  ADD UNIQUE KEY `unique_rating` (`customer_id`,`worker_id`),
  ADD KEY `worker_id` (`worker_id`);

--
-- Indexes for table `skill_list`
--
ALTER TABLE `skill_list`
  ADD PRIMARY KEY (`skill_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `worker_master`
--
ALTER TABLE `worker_master`
  ADD PRIMARY KEY (`worker_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `area_id` (`area_id`),
  ADD KEY `skill_id` (`skill_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_master`
--
ALTER TABLE `admin_master`
  MODIFY `admin_id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `area_master`
--
ALTER TABLE `area_master`
  MODIFY `area_id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking_master`
--
ALTER TABLE `booking_master`
  MODIFY `booking_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookmark_master`
--
ALTER TABLE `bookmark_master`
  MODIFY `bookmark_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_master`
--
ALTER TABLE `chat_master`
  MODIFY `chat_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `city_master`
--
ALTER TABLE `city_master`
  MODIFY `city_id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_master`
--
ALTER TABLE `customer_master`
  MODIFY `customer_id` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rate`
--
ALTER TABLE `rate`
  MODIFY `rate_id` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `skill_list`
--
ALTER TABLE `skill_list`
  MODIFY `skill_id` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_master`
--
ALTER TABLE `worker_master`
  MODIFY `worker_id` int(6) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `area_master`
--
ALTER TABLE `area_master`
  ADD CONSTRAINT `area_master_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city_master` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `booking_master`
--
ALTER TABLE `booking_master`
  ADD CONSTRAINT `booking_master_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer_master` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_master_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `worker_master` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_master_ibfk_3` FOREIGN KEY (`skill_id`) REFERENCES `skill_list` (`skill_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bookmark_master`
--
ALTER TABLE `bookmark_master`
  ADD CONSTRAINT `bookmark_master_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer_master` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookmark_master_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `worker_master` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `chat_master`
--
ALTER TABLE `chat_master`
  ADD CONSTRAINT `chat_master_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `customer_master` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chat_master_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `worker_master` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_master`
--
ALTER TABLE `customer_master`
  ADD CONSTRAINT `customer_master_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city_master` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customer_master_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `area_master` (`area_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rate`
--
ALTER TABLE `rate`
  ADD CONSTRAINT `rate_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer_master` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rate_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `worker_master` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `worker_master`
--
ALTER TABLE `worker_master`
  ADD CONSTRAINT `worker_master_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city_master` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `worker_master_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `area_master` (`area_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `worker_master_ibfk_3` FOREIGN KEY (`skill_id`) REFERENCES `skill_list` (`skill_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
