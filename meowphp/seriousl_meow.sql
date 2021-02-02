-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 02, 2021 at 04:46 PM
-- Server version: 10.3.27-MariaDB-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seriousl_meow`
--

-- --------------------------------------------------------

--
-- Table structure for table `CART`
--

CREATE TABLE `CART` (
  `EMAIL` varchar(50) NOT NULL,
  `PRODID` varchar(20) NOT NULL,
  `CQUANTITY` varchar(10) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CART`
--

INSERT INTO `CART` (`EMAIL`, `PRODID`, `CQUANTITY`, `DATE`) VALUES
('unregistered@meow.com', 'pasir3', '1', '2021-01-30 12:28:44');

-- --------------------------------------------------------

--
-- Table structure for table `CARTHISTORY`
--

CREATE TABLE `CARTHISTORY` (
  `EMAIL` varchar(100) NOT NULL,
  `ORDERID` varchar(100) NOT NULL,
  `BILLID` varchar(20) NOT NULL,
  `PRODID` varchar(30) NOT NULL,
  `CQUANTITY` varchar(10) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CARTHISTORY`
--

INSERT INTO `CARTHISTORY` (`EMAIL`, `ORDERID`, `BILLID`, `PRODID`, `CQUANTITY`, `DATE`) VALUES
('myname@gmail.com', 'yna-30-01-2021 05:29 PMKWe3Hb', 't7p0kujk', 'sangkar3', '1', '2021-01-30 17:29:18'),
('myname@gmail.com', 'yna-30-01-2021 05:29 PMKWe3Hb', 't7p0kujk', 'sangkar3', '1', '2021-01-30 17:29:18'),
('myname@gmail.com', 'yna-30-01-2021 05:29 PMKWe3Hb', 't7p0kujk', 'catFood2', '1', '2021-01-30 17:29:18'),
('myname@gmail.com', 'yna-30-01-2021 05:29 PMKWe3Hb', 't7p0kujk', 'catFood2', '1', '2021-01-30 17:29:18'),
('myname@gmail.com', 'yna-30-01-2021 06:13 PMF05s8x', 'zajy0bdq', 'cc1', '1', '2021-01-30 18:14:14'),
('myname@gmail.com', 'yna-30-01-2021 06:13 PMF05s8x', 'zajy0bdq', 'cc1', '1', '2021-01-30 18:14:14'),
('zamirul@gmail.com', 'ami-31-01-2021 12:51 AMS63780', '0qfdugtm', 'cc1', '1', '2021-01-31 00:52:15'),
('zamirul@gmail.com', 'ami-31-01-2021 12:51 AMS63780', '0qfdugtm', 'cc1', '1', '2021-01-31 00:52:15'),
('myname@gmail.com', 'yna-01-02-2021 02:19 AM0OTTB3', '6p51culj', 'sangkar2', '1', '2021-02-01 02:19:25'),
('rafiqa@gmail.com', 'afi-02-02-2021 01:41 PMK34CDU', '2tmomdyp', 'pasir', '1', '2021-02-02 13:41:59'),
('rafiqa@gmail.com', 'afi-02-02-2021 01:41 PMK34CDU', '2tmomdyp', 'sangkar2', '1', '2021-02-02 13:41:59'),
('iqa@gmail.com', 'qa@-02-02-2021 03:49 PMA23622', 'v6cgxy2p', 'cc3', '1', '2021-02-02 15:49:34'),
('iqa@gmail.com', 'qa@-02-02-2021 03:49 PMA23622', 'v6cgxy2p', 'catFood2', '3', '2021-02-02 15:49:34'),
('myname@gmail.com', 'yna-02-02-2021 04:11 PM25886J', 'obsfujlb', 'catFood1', '1', '2021-02-02 16:11:37'),
('myname@gmail.com', 'yna-02-02-2021 04:11 PM25886J', 'obsfujlb', 'catFood', '2', '2021-02-02 16:11:37'),
('myname@gmail.com', 'yna-02-02-2021 04:11 PM25886J', 'obsfujlb', 'sangkar1', '1', '2021-02-02 16:11:37'),
('myname@gmail.com', 'yna-02-02-2021 04:11 PM25886J', 'obsfujlb', 'sangkar2', '1', '2021-02-02 16:11:37'),
('myname@gmail.com', 'yna-02-02-2021 04:11 PM25886J', 'obsfujlb', 'cc', '1', '2021-02-02 16:11:37'),
('myname@gmail.com', 'yna-02-02-2021 04:13 PM7OVF1J', '03n0a5ou', 'cc1', '9', '2021-02-02 16:14:09'),
('myname@gmail.com', 'yna-02-02-2021 04:13 PM7OVF1J', '03n0a5ou', 'catFood1', '7', '2021-02-02 16:14:09'),
('myname@gmail.com', 'yna-02-02-2021 04:13 PM7OVF1J', '03n0a5ou', 'sangkar2', '5', '2021-02-02 16:14:09');

-- --------------------------------------------------------

--
-- Table structure for table `PAYMENT`
--

CREATE TABLE `PAYMENT` (
  `ORDERID` varchar(100) NOT NULL,
  `BILLID` varchar(10) NOT NULL,
  `TOTAL` varchar(10) NOT NULL,
  `USERID` varchar(100) NOT NULL,
  `DATE` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PAYMENT`
--

INSERT INTO `PAYMENT` (`ORDERID`, `BILLID`, `TOTAL`, `USERID`, `DATE`) VALUES
('yna-30-01-2021 05:29 PMKWe3Hb', 't7p0kujk', '250.00', 'myname@gmail.com', '2021-01-30 17:29:18.847628'),
('yna-30-01-2021 06:13 PMF05s8x', 'zajy0bdq', '259.80', 'myname@gmail.com', '2021-01-30 18:14:14.279414'),
('ami-31-01-2021 12:51 AMS63780', '0qfdugtm', '259.80', 'zamirul@gmail.com', '2021-01-31 00:52:15.065312'),
('yna-01-02-2021 02:19 AM0OTTB3', '6p51culj', '90.00', 'myname@gmail.com', '2021-02-01 02:19:25.550585'),
('afi-02-02-2021 01:41 PMK34CDU', '2tmomdyp', '105.00', 'rafiqa@gmail.com', '2021-02-02 13:41:59.132142'),
('qa@-02-02-2021 03:49 PMA23622', 'v6cgxy2p', '157.90', 'iqa@gmail.com', '2021-02-02 15:49:34.507767'),
('yna-02-02-2021 04:11 PM25886J', 'obsfujlb', '344.90', 'myname@gmail.com', '2021-02-02 16:11:37.622231'),
('yna-02-02-2021 04:13 PM7OVF1J', '03n0a5ou', '1129.10', 'myname@gmail.com', '2021-02-02 16:14:09.850343');

-- --------------------------------------------------------

--
-- Table structure for table `PRODUCT`
--

CREATE TABLE `PRODUCT` (
  `ID` varchar(30) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `PRICE` varchar(10) NOT NULL,
  `QUANTITY` varchar(10) NOT NULL,
  `SOLD` varchar(10) NOT NULL,
  `SIZE` varchar(3) NOT NULL,
  `TYPE` varchar(20) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PRODUCT`
--

INSERT INTO `PRODUCT` (`ID`, `NAME`, `PRICE`, `QUANTITY`, `SOLD`, `SIZE`, `TYPE`, `DATE`) VALUES
('catFood', 'Meow Mix', '25.00', '98', '2', 'M', 'Food', '2021-01-20 15:36:48'),
('catFood1', '9Lives', '20.00', '92', '8', 'M', 'Food', '2021-01-20 15:57:27'),
('catFood2', 'Pro Diet', '26.00', '97', '3', 'M', 'Food', '2021-01-20 15:57:27'),
('catFood3', 'Wilderness', '30.00', '100', '0', 'M', 'Food', '2021-01-20 15:57:27'),
('catFood5', 'Whiskas', '21.00', '100', '0', 'M', 'Food', '2021-01-20 15:57:27'),
('catFood6', 'Purina Friskies', '29.90', '100', '0', 'M', 'Food', '2021-01-20 15:57:27'),
('catFood7', 'Purina GoCat', '28.00', '100', '0', 'M', 'Food', '2021-01-20 15:57:27'),
('catFood8', 'Me-O', '18.00', '100', '0', 'M', 'Food', '2021-01-20 15:57:27'),
('catFood9', 'SayangKu', '22.50', '100', '0', 'M', 'Food', '2021-01-20 15:57:27'),
('cc', 'Home Carrier', '59.90', '99', '1', 'L', 'Carrier', '2021-01-20 15:57:27'),
('cc1', 'Home Carrier', '59.90', '91', '9', 'L', 'Carrier', '2021-01-20 16:34:38'),
('cc2', 'Sport Carrier', '49.90', '100', '0', 'M', 'Carrier', '2021-01-20 16:34:38'),
('cc3', 'Travel Carrier', '79.90', '99', '1', 'M', 'Carrier', '2021-01-20 16:34:38'),
('cc4', 'Folding Carrier', '49.90', '100', '6', 'S', 'Carrier', '2021-01-20 16:34:38'),
('pasir', 'Little Pets', '15.00', '99', '2', 'M', 'Cat Little', '2021-01-20 16:34:38'),
('pasir1', 'Apple', '18.00', '100', '0', 'M', 'Cat Little', '2021-01-20 16:34:38'),
('pasir2', 'Charcoal', '20.00', '100', '0', 'M', 'Cat Little', '2021-01-20 16:34:38'),
('pasir3', 'CatsPro', '15.50', '100', '0', 'M', 'Cat Little', '2021-01-20 16:34:38'),
('sangkar', 'Sangkar', '120.00', '100', '0', 'L', 'Cage', '2021-01-20 16:34:38'),
('sangkar1', 'Sangkar', '125.00', '99', '1', 'L', 'Cage', '2021-01-25 16:34:38'),
('sangkar2', 'Sangkar', '90.00', '92', '8', 'S', 'Cage', '2021-01-25 16:34:38'),
('sangkar3', 'Sangkar', '130.00', '100', '0', 'L', 'Cage', '2021-01-25 10:59:26');

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `NAME` varchar(50) NOT NULL,
  `PHONE` varchar(12) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(60) NOT NULL,
  `CREDIT` varchar(5) NOT NULL,
  `VERIFY` varchar(1) NOT NULL,
  `DATEREG` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`NAME`, `PHONE`, `EMAIL`, `PASSWORD`, `CREDIT`, `VERIFY`, `DATEREG`) VALUES
('unregistered', '0123456789', 'unregistered@meow.com', '123456789', '0', '0', '2021-01-29 16:42:11'),
('admin', '0123456789', 'admin@meow.com', '123456789', '0', '1', '2021-01-21 20:07:58'),
('Rudflina', '0123456789', 'seriouslaa2324@gmail.com', '123456789', '0', '1', '2021-01-22 09:29:16'),
('Rudflina Rafiqa', '0123456789', 'meoww981123@gmail.com', 'rudflina', '0', '0', '2021-01-16 12:13:29'),
('Rudflina Rafiqa', '0123456789', 'rafiqarudflina@gmail.com', 'rudflina', '0', '0', '2021-01-16 14:15:42'),
('Rudflinaaaa', '0123456789', 'myname@gmail.com', 'f43d25e128f0fc685a88b622b5ad716e64a494d2', '570', '0', '2021-01-30 01:11:38'),
('Zamirul', '0123456789', 'zamirul@gmail.com', '11817187f7ec8b60a81a9ff2b90c94fd0bddc314', '0', '0', '2021-01-31 00:50:37'),
('Rudflina', '0123456789', 'rudflina@gmail.com', '52541400323c0b2811006cc83824c9bfa2619472', '0', '0', '2021-02-02 13:15:09'),
('Rafiqa', '0123456789', 'rafiqa@gmail.com', '79fc4c7f5bb6ba81dacda767d541e992e95c79f2', '0', '7', '2021-02-02 13:39:38'),
('Iqaa', '0123456789', 'iqaa@gmail.com', '580b5feec637a8bbbc10cc2bf64650f0dd38532d', '0', '7', '2021-02-02 15:45:14'),
('Iqa', '0123456789', 'iqa@gmail.com', '490dbaac2152cfa7bf1b1ae761956464e1edaba3', '100', '7', '2021-02-02 15:47:09'),
('Rudflinaaa', '0134569852', 'rudflinaaa@gmail.com', '9da7deb595b6454379f859b2bffc2e2e6087de9b', '0', '2', '2021-02-02 15:57:31'),
('Rudflinaa', '01234567895', 'rudflinaa@gmail.com', 'aa99bb159ef5c9a3af4b62739918ca0a297af70a', '0', '9', '2021-02-02 16:02:04'),
('Rafiqaa', '0123654789', 'rafiqaa@gmail.com', '65c778311ff15fae61683af1dc60b0d0259f34f4', '0', '6', '2021-02-02 16:04:56'),
('meow	', '0123654987', 'meow1234@gmail.com', '982835ccb52be3ffb44325ec12fb7454bb2acea4', '0', '4', '2021-02-02 16:08:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `PRODUCT`
--
ALTER TABLE `PRODUCT`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`EMAIL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
