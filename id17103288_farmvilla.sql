-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 06, 2021 at 08:05 AM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id17103288_farmvilla`
--
CREATE DATABASE IF NOT EXISTS `id17103288_farmvilla` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `id17103288_farmvilla`;

-- --------------------------------------------------------

--
-- Table structure for table `guard`
--

DROP TABLE IF EXISTS `guard`;
CREATE TABLE `guard` (
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `guard`
--

INSERT INTO `guard` (`email`, `password`) VALUES
('dax@gmail.com', 'Neha@123');

-- --------------------------------------------------------

--
-- Table structure for table `Guests`
--

DROP TABLE IF EXISTS `Guests`;
CREATE TABLE `Guests` (
  `email` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Guest` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `Status` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Guests`
--

INSERT INTO `Guests` (`email`, `Guest`, `Status`) VALUES
('dax@gmail.com', 'daksh', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
  `email` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL,
  `fname` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `lname` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `property` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `photo` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`email`, `password`, `fname`, `lname`, `mobile`, `property`, `photo`) VALUES
('dax@gmail.com', 'Neha@123', 'krutarth', 'shah', '9920936169', '15', 'image_picker2530513994936505055.jpg'),
('dax@yahoo.com', 'D@ksh123', 'dax', 'vatyani', '9537607666', '11', 'image_picker972370691539480604.jpg'),
('neha@123.c', 'neha', 'ne', 'ns', 'n', 'n', 'image_picker3986666809737636951.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Guests`
--


--
-- Indexes for table `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`email`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Guests`
--
ALTER TABLE `Guests`
  ADD CONSTRAINT `Guests_ibfk_1` FOREIGN KEY (`email`) REFERENCES `profile` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
