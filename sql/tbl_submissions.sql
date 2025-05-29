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
-- Table structure for table `tbl_submissions`
--

CREATE TABLE `tbl_submissions` (
  `id` int(11) NOT NULL,
  `work_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL,
  `submission_text` text NOT NULL,
  `submitted_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_submissions`
--

INSERT INTO `tbl_submissions` (`id`, `work_id`, `worker_id`, `submission_text`, `submitted_at`) VALUES
(1, 1, 1, 'Task completed successfully.', '2025-05-28 22:20:17'),
(2, 1, 1, 'Task completed successfully.', '2025-05-29 01:15:48'),
(3, 1, 1, 'Task completed successfully.', '2025-05-29 02:24:34'),
(4, 1, 1, 'Task completed successfully.', '2025-05-29 02:24:50'),
(5, 21, 1, 'prepare material a', '2025-05-29 10:36:19'),
(6, 21, 1, 'submit', '2025-05-29 11:00:00'),
(7, 21, 1, 'done', '2025-05-29 11:03:48'),
(8, 21, 1, 'done', '2025-05-29 11:10:16'),
(9, 22, 2, 'complete', '2025-05-29 11:16:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_submissions`
--
ALTER TABLE `tbl_submissions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_submissions`
--
ALTER TABLE `tbl_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
