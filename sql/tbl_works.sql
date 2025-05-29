-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2025 at 05:39 AM
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
-- Database: `flutter_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_works`
--

CREATE TABLE `tbl_works` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `date_assigned` date NOT NULL,
  `due_date` date NOT NULL,
  `status` varchar(20) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_works`
--

INSERT INTO `tbl_works` (`id`, `title`, `description`, `assigned_to`, `date_assigned`, `due_date`, `status`) VALUES
(21, 'Prepare Material A', 'Prepare raw material A for assembly.', 1, '2025-05-25', '2025-05-28', 'completed'),
(22, 'Inspect Machine X', 'Conduct inspection for machine X.', 2, '2025-05-25', '2025-05-29', 'completed'),
(23, 'Clean Area B', 'Deep clean work area B before audit.', 3, '2025-05-25', '2025-05-30', 'pending'),
(24, 'Test Circuit Board', 'Perform unit test for circuit batch 4.', 4, '2025-05-25', '2025-05-28', 'pending'),
(25, 'Document Process', 'Write SOP for packaging unit.', 5, '2025-05-25', '2025-05-29', 'pending'),
(26, 'Paint Booth Check', 'Routine check on painting booth.', 1, '2025-05-25', '2025-05-30', 'pending'),
(27, 'Label Inventory', 'Label all boxes in section C.', 2, '2025-05-25', '2025-05-28', 'pending'),
(28, 'Update Database', 'Update inventory in MySQL system.', 3, '2025-05-25', '2025-05-29', 'pending'),
(29, 'Maintain Equipment', 'Oil and tune cutting machine.', 4, '2025-05-25', '2025-05-30', 'pending'),
(30, 'Prepare Report', 'Prepare monthly performance report.', 5, '2025-05-25', '2025-05-30', 'pending'),
(31, 'Prepare Material A', 'Prepare raw material A for assembly.', 2, '2025-05-25', '2025-05-28', 'pending'),
(32, 'Paint Booth Check', 'Routine check on painting booth.', 2, '2025-05-25', '2025-05-30', 'pending'),
(33, 'Prepare Material A', 'Prepare raw material A for assembly.', 3, '2025-05-25', '2025-05-28', 'pending'),
(34, 'Paint Booth Check', 'Routine check on painting booth.', 3, '2025-05-25', '2025-05-30', 'pending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_works`
--
ALTER TABLE `tbl_works`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_works`
--
ALTER TABLE `tbl_works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
