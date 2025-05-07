-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 07, 2025 at 10:46 AM
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
-- Database: `employee_leave`
--

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department_id`, `name`) VALUES
(1, 'HR'),
(2, 'Business'),
(3, 'FrontEnd'),
(4, 'BackEnd'),
(5, 'TechSupport'),
(15, 'fbdhh'),
(16, 'dfhfjk');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'inactive',
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `name`, `email`, `department_id`, `position`, `hire_date`, `status`, `password`) VALUES
(1, 'Soma', 'admin@gmail.com', 1, 'Manager', '2010-03-15', 'active', 'admin@123'),
(2, 'Bob Smith', 'bob@gmail.com', 2, 'Business Executive', '2021-07-10', 'active', 'bob@123'),
(3, 'Carol Lee', 'carolee@gmail.com', 3, 'Team Lead', '2023-01-05', 'active', 'lee@123'),
(4, 'Arjun', 'arjun@gmail.com', 4, 'Backend developer', '2025-05-05', 'active', 'arjun@123'),
(5, 'abcd', 'abcd@gmail.com', 3, 'Intern', '2025-05-06', 'active', 'abcd@123'),
(6, 'xyz', 'xyz@gmail.com', 5, 'Trainee', '2025-05-06', 'active', 'xyz@123'),
(7, 'asd', 'asd@gmail.com', 4, 'Developer', '2025-05-06', 'active', 'asd@123');

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `holiday_id` int(11) NOT NULL,
  `holiday_date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`holiday_id`, `holiday_date`, `description`) VALUES
(1, '2025-01-01', 'New Year\'s Day'),
(2, '2025-01-26', 'Republic Day'),
(3, '2025-03-08', 'International Women\'s Day'),
(4, '2025-04-14', 'Ambedkar Jayanti'),
(5, '2025-05-01', 'Labour Day'),
(6, '2025-08-15', 'Independence Day'),
(7, '2025-10-02', 'Gandhi Jayanti'),
(8, '2025-10-23', 'Diwali'),
(9, '2025-11-01', 'Kannada Rajyotsava'),
(10, '2025-12-25', 'Christmas Day'),
(11, '2025-05-13', 'KYUKHOU'),
(12, '2025-06-08', 'jfkfk');

-- --------------------------------------------------------

--
-- Table structure for table `leave_balances`
--

CREATE TABLE `leave_balances` (
  `balance_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `leave_type_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `total_allocated` int(11) DEFAULT NULL,
  `used` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leave_balances`
--

INSERT INTO `leave_balances` (`balance_id`, `employee_id`, `leave_type_id`, `year`, `total_allocated`, `used`) VALUES
(1, 1, 1, 2025, 12, 2),
(2, 1, 2, 2025, 6, 1),
(3, 1, 3, 2025, 6, 0),
(4, 2, 1, 2025, 12, 2),
(5, 2, 2, 2025, 6, 2),
(6, 2, 3, 2025, 6, 0),
(7, 3, 1, 2025, 12, 4),
(8, 3, 2, 2025, 6, 2),
(9, 3, 3, 2025, 6, 1),
(10, 4, 1, 2025, 12, 12),
(11, 4, 2, 2025, 6, 9),
(12, 4, 3, 2025, 6, 2);

-- --------------------------------------------------------

--
-- Table structure for table `leave_requests`
--

CREATE TABLE `leave_requests` (
  `request_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `leave_type_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('draft','submitted','approved','rejected') DEFAULT 'draft',
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leave_requests`
--

INSERT INTO `leave_requests` (`request_id`, `employee_id`, `leave_type_id`, `start_date`, `end_date`, `reason`, `status`, `requested_at`, `reviewed_at`, `reviewed_by`) VALUES
(1, 2, 1, '2025-04-10', '2025-04-12', 'Family function', 'approved', '2025-04-01 05:00:00', '2025-04-02 03:30:00', 1),
(2, 2, 2, '2025-05-10', '2025-05-11', 'Fever', 'rejected', '2025-05-01 05:45:00', '2025-05-06 05:04:17', 1),
(3, 3, 3, '2025-03-05', '2025-03-05', 'Worked on weekend', 'rejected', '2025-03-01 03:50:00', '2025-03-02 09:00:00', 1),
(4, 3, 1, '2025-05-20', '2025-05-21', 'Personal work', 'approved', '2025-05-05 06:30:00', '2025-05-06 03:15:00', 1),
(6, 4, 2, '2025-05-06', '2025-05-07', 'cold', 'approved', '2025-05-06 08:40:53', '2025-05-06 05:38:18', 1),
(8, 4, 3, '2025-05-23', '2025-05-24', 'leave1', 'rejected', '2025-05-06 09:04:34', '2025-05-06 05:38:22', 1),
(11, 4, 1, '2025-05-14', '2025-05-17', 'ggg', 'approved', '2025-05-06 09:45:37', '2025-05-06 06:15:54', 1),
(12, 4, 1, '2025-05-23', '2025-05-24', 'qwerty', 'rejected', '2025-05-06 10:06:08', '2025-05-07 02:58:15', 1),
(13, 4, 2, '2025-05-08', '2025-05-10', 'qwe', '', '2025-05-06 11:48:43', NULL, NULL),
(14, 4, 1, '2025-06-01', '2025-06-03', 'egdryrj', 'approved', '2025-05-07 05:27:14', '2025-05-07 02:58:08', 1),
(15, 4, 2, '2025-06-08', '2025-06-09', 'ethtk', 'approved', '2025-05-07 06:24:44', '2025-05-07 02:58:13', 1),
(17, 4, 2, '2025-05-14', '2025-05-15', 'xfdhdgmhm', '', '2025-05-07 07:14:51', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `leave_types`
--

CREATE TABLE `leave_types` (
  `leave_type_id` int(11) NOT NULL,
  `type_name` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `max_days_per_year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leave_types`
--

INSERT INTO `leave_types` (`leave_type_id`, `type_name`, `description`, `max_days_per_year`) VALUES
(1, 'Casual Leave', 'Casual leaves are granted for personal matters or urgent work.', 12),
(2, 'Sick Leave', 'Sick leaves are allowed for health-related issues or recovery.', 6),
(3, 'Comp Off Leave', 'Compensatory off for working on holidays or weekends.', 6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`holiday_id`);

--
-- Indexes for table `leave_balances`
--
ALTER TABLE `leave_balances`
  ADD PRIMARY KEY (`balance_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `leave_type_id` (`leave_type_id`);

--
-- Indexes for table `leave_requests`
--
ALTER TABLE `leave_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `leave_type_id` (`leave_type_id`),
  ADD KEY `reviewed_by` (`reviewed_by`);

--
-- Indexes for table `leave_types`
--
ALTER TABLE `leave_types`
  ADD PRIMARY KEY (`leave_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `holiday_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `leave_balances`
--
ALTER TABLE `leave_balances`
  MODIFY `balance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `leave_requests`
--
ALTER TABLE `leave_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `leave_types`
--
ALTER TABLE `leave_types`
  MODIFY `leave_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`);

--
-- Constraints for table `leave_balances`
--
ALTER TABLE `leave_balances`
  ADD CONSTRAINT `leave_balances_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`),
  ADD CONSTRAINT `leave_balances_ibfk_2` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`leave_type_id`);

--
-- Constraints for table `leave_requests`
--
ALTER TABLE `leave_requests`
  ADD CONSTRAINT `leave_requests_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`),
  ADD CONSTRAINT `leave_requests_ibfk_2` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`leave_type_id`),
  ADD CONSTRAINT `leave_requests_ibfk_3` FOREIGN KEY (`reviewed_by`) REFERENCES `employees` (`employee_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
