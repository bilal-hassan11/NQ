-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 12, 2025 at 12:38 PM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u148471732_poultryfarm`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `grand_parent_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `opening_balance` double(8,2) NOT NULL,
  `opening_date` date NOT NULL,
  `account_nature` enum('credit','debit') NOT NULL,
  `ageing` int(11) NOT NULL,
  `commission` tinyint(4) NOT NULL,
  `discount` tinyint(4) NOT NULL,
  `address` text DEFAULT NULL,
  `phone_no` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 means active and 0 means deactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `grand_parent_id`, `parent_id`, `name`, `opening_balance`, `opening_date`, `account_nature`, `ageing`, `commission`, `discount`, `address`, `phone_no`, `status`, `created_at`, `updated_at`) VALUES
(1, 3, 22, 'Waheed', 0.00, '2024-09-01', 'debit', 0, 0, 0, 'Hyd', NULL, 1, '2024-09-02 12:26:00', '2024-09-02 12:26:00'),
(2, 5, 24, 'Jadeed Chicks', 0.00, '2024-07-29', 'credit', 0, 0, 0, 'Lhr', NULL, 1, '2024-09-02 12:29:54', '2024-09-02 12:29:54'),
(3, 6, 25, 'A One Feeds', 0.00, '2024-07-22', 'credit', 0, 0, 0, 'Hyd', NULL, 1, '2024-09-02 12:31:37', '2024-09-02 12:31:37'),
(4, 7, 28, 'Cash in Hand', 0.00, '2020-09-12', 'debit', 0, 0, 0, NULL, NULL, 1, '2024-09-12 11:50:04', '2024-09-12 11:50:04');

-- --------------------------------------------------------

--
-- Table structure for table `account_ledger`
--

CREATE TABLE `account_ledger` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `shade_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('Purchase','Sale','Purchase Return','Sale Return','Adjust In','Adjust Out') DEFAULT NULL,
  `medicine_invoice_id` bigint(20) UNSIGNED DEFAULT NULL,
  `chick_invoice_id` int(11) DEFAULT NULL,
  `murghi_invoice_id` int(11) DEFAULT NULL,
  `feed_invoice_id` int(11) DEFAULT NULL,
  `other_invoice_id` int(11) DEFAULT NULL,
  `cash_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `expense_id` int(11) DEFAULT NULL,
  `debit` int(11) DEFAULT NULL,
  `credit` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `account_ledger`
--

INSERT INTO `account_ledger` (`id`, `date`, `account_id`, `shade_id`, `type`, `medicine_invoice_id`, `chick_invoice_id`, `murghi_invoice_id`, `feed_invoice_id`, `other_invoice_id`, `cash_id`, `payment_id`, `expense_id`, `debit`, `credit`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-09-02', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 2000, 0, 'Jul 24', NULL, '2024-09-02 12:47:46', '2024-09-02 12:47:46'),
(2, '2024-09-02', 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3000, 0, 'Paid HESCO Bill m/o Aug 24', NULL, '2024-09-02 12:48:15', '2024-09-12 12:00:56'),
(3, '2024-09-02', 2, 1, 'Purchase', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100000, 'Invoice #: 24090001, Item: Chick, Qty: 1000, Rate: 100', NULL, '2024-09-02 12:51:13', '2024-09-02 12:51:13'),
(4, '2024-07-01', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 500, 0, 'Purchase Veccination', NULL, '2024-09-02 13:08:59', '2024-09-02 13:08:59'),
(5, '2024-09-02', 3, 1, 'Purchase', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1470040, 'Invoice #: 24090001, Item: 09, Qty: 220, Rate: 6682', '2024-09-12 11:56:04', '2024-09-02 13:20:01', '2024-09-12 11:56:04'),
(6, '2024-09-12', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 10000, 0, ' Account #[4]Cash in Hand,  Paid Ammount 10000', NULL, '2024-09-12 11:50:57', '2024-09-12 11:50:57'),
(7, '2024-09-12', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 10000, ' Account #[1]Waheed,  Paid Ammount 10000', NULL, '2024-09-12 11:50:57', '2024-09-12 11:50:57'),
(8, '2024-09-02', 3, 1, 'Purchase', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, 0, 1470040, 'Invoice #: 24090001, Item: 09, Qty: 220.00, Rate: 6682.00', '2024-11-07 14:15:18', '2024-09-12 11:56:04', '2024-11-07 14:15:18'),
(9, '2024-09-02', 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 100000, 0, 'Paid Salaries to Staff m/o Aug 24', NULL, '2024-09-12 12:03:08', '2024-09-12 12:03:08'),
(10, '2024-09-12', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, 2000, 0, ' Account #[3]A One Feeds,  Paid Ammount 2000', NULL, '2024-09-12 12:08:50', '2024-09-12 12:08:50'),
(11, '2024-09-12', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, 0, 2000, ' Account #[4]Cash in Hand,  Paid Ammount 2000', NULL, '2024-09-12 12:08:50', '2024-09-12 12:08:50'),
(12, '2024-09-18', 4, 3, 'Purchase', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 0, 176715, 'Invoice #: 24090001, Item: Murghi, Qty: 765.00, Rate: 231', NULL, '2024-09-18 12:17:29', '2024-09-18 12:17:29'),
(13, '2024-09-18', 1, 1, 'Purchase', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 0, 768, 'Invoice #: 24090001, Item: Murghi, Qty: 768.00, Rate: 1', NULL, '2024-09-18 12:20:47', '2024-09-18 12:20:47'),
(14, '2024-09-18', 1, 1, 'Purchase', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, 334848, 'Invoice #: 24090001, Item: Murghi, Qty: 768.00, Rate: 436', NULL, '2024-09-18 12:21:21', '2024-09-18 12:21:21'),
(15, '2024-09-18', 2, 2, 'Purchase', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, 12000000, 'Invoice #: 24090002, Item: Chick, Qty: 60000, Rate: 200', NULL, '2024-09-18 12:39:28', '2024-09-18 12:39:28'),
(16, '2024-09-02', 3, 1, 'Purchase', NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, 0, 1470040, 'Invoice #: 24090001, Item: 09, Qty: 220.00, Rate: 6682.00', '2024-11-07 14:15:30', '2024-11-07 14:15:18', '2024-11-07 14:15:30'),
(17, '2024-09-02', 3, 1, 'Purchase', NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, 0, 1470040, 'Invoice #: 24090001, Item: 09, Qty: 220.00, Rate: 6682.00', NULL, '2024-11-07 14:15:30', '2024-11-07 14:15:30'),
(18, '2024-09-26', 3, 2, 'Purchase', NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, 0, 1470040, 'Invoice #: 24110001, Item: 09, Qty: 220, Rate: 6682.00', NULL, '2024-11-07 14:16:50', '2024-11-07 14:16:50'),
(19, '2025-08-12', 3, 2, 'Purchase', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8100000, 'Invoice #: 25080001, Item: Chick, Qty: 100000, Rate: 81', NULL, '2025-08-12 16:05:09', '2025-08-12 16:05:09');

-- --------------------------------------------------------

--
-- Table structure for table `account_types`
--

CREATE TABLE `account_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `account_types`
--

INSERT INTO `account_types` (`id`, `parent_id`, `name`, `created_at`, `updated_at`) VALUES
(3, NULL, 'Arti', NULL, NULL),
(4, NULL, 'Farmer', NULL, NULL),
(5, NULL, 'Chicks Companies', NULL, NULL),
(6, NULL, 'Feed Companies', NULL, NULL),
(7, NULL, 'Bank Accounts', NULL, NULL),
(13, NULL, 'Farm Staff Salary Accounts', NULL, NULL),
(22, 3, 'Add Arti Account', NULL, NULL),
(23, 4, 'Add Farmer Account', NULL, NULL),
(24, 5, 'Add Chicks Companies Account', NULL, NULL),
(25, 6, 'Add Feed Companies Account', NULL, NULL),
(28, 7, 'Add Bank Account', NULL, NULL),
(34, 13, 'Add Farm Staff Salary Account', NULL, NULL),
(51, NULL, 'Medicine Companies', NULL, NULL),
(52, 51, 'Add Medicine Companies Account', NULL, NULL),
(53, NULL, 'Zakat & Dobat Account', NULL, NULL),
(54, 53, 'Add Zakat & Dobat Account', NULL, NULL),
(57, NULL, 'Others Account', NULL, NULL),
(58, 57, 'Add Others Account', NULL, NULL),
(59, NULL, 'Capital Account', NULL, NULL),
(60, 59, 'Add Capital Account', NULL, NULL),
(63, NULL, 'Expense Account', NULL, NULL),
(64, 63, 'Add Expense Account', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(180) DEFAULT NULL,
  `username` varchar(80) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` varchar(255) DEFAULT 'normal',
  `user_permissions` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `remember_token` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `username`, `email`, `password`, `user_type`, `user_permissions`, `is_active`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1412, NULL, 'shayan', 'admin1421@admin.com', '$2y$10$rLcR4ZsU.2UemvEGKZDbB.a3N7R.UtMkHX2WDkCs7AhRtJYTFBiMa', '1', NULL, 1, '', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cash_book`
--

CREATE TABLE `cash_book` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entry_date` date NOT NULL,
  `account_id` int(11) NOT NULL,
  `narration` text NOT NULL,
  `bil_no` text NOT NULL,
  `payment_ammount` int(11) DEFAULT NULL,
  `receipt_ammount` int(11) DEFAULT NULL,
  `status` enum('payment','receipt') NOT NULL,
  `remarks` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 means active 0 means deactive',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(2, 'Chick', 1, NULL, '2024-06-09 12:06:20', '2024-06-09 12:06:20'),
(3, 'Feed', 1, NULL, '2024-06-09 12:06:20', '2024-06-09 12:06:20'),
(4, 'Medicine', 1, NULL, '2024-06-09 12:06:20', '2024-06-09 12:06:20'),
(5, 'Other', 1, NULL, '2024-06-09 12:06:20', '2024-06-09 12:06:20'),
(8, 'Murghi', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `chick_invoices`
--

CREATE TABLE `chick_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shade_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invoice_no` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ref_no` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_price` decimal(16,2) NOT NULL,
  `sale_price` decimal(16,2) NOT NULL,
  `quantity` decimal(16,2) NOT NULL DEFAULT 0.00,
  `amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `discount_in_rs` decimal(16,2) NOT NULL DEFAULT 0.00,
  `discount_in_percent` decimal(16,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(16,2) NOT NULL DEFAULT 0.00,
  `net_amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `expiry_date` date DEFAULT NULL,
  `type` enum('Purchase','Sale','Purchase Return','Sale Return','Adjust In','Adjust Out') DEFAULT NULL,
  `stock_type` enum('In','Out') NOT NULL DEFAULT 'In',
  `is_draft` enum('1','0') NOT NULL DEFAULT '0',
  `whatsapp_status` enum('Sent','Not Sent') NOT NULL DEFAULT 'Sent',
  `remarks` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chick_invoices`
--

INSERT INTO `chick_invoices` (`id`, `date`, `shade_id`, `invoice_no`, `account_id`, `ref_no`, `description`, `item_id`, `purchase_price`, `sale_price`, `quantity`, `amount`, `discount_in_rs`, `discount_in_percent`, `total_cost`, `net_amount`, `expiry_date`, `type`, `stock_type`, `is_draft`, `whatsapp_status`, `remarks`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-09-02', 1, 24090001, 2, '3344', '4343', 2, 100.00, 0.00, 1000.00, 100000.00, 0.00, 0.00, 0.00, 100000.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2024-09-02 12:51:13', '2024-09-02 12:51:13'),
(2, '2024-09-18', 2, 24090002, 2, NULL, NULL, 2, 200.00, 0.00, 60000.00, 12000000.00, 0.00, 0.00, 0.00, 12000000.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2024-09-18 12:39:28', '2024-09-18 12:39:28'),
(3, '2025-08-12', 2, 25080001, 3, NULL, NULL, 2, 81.00, 0.00, 100000.00, 8100000.00, 0.00, 0.00, 0.00, 8100000.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2025-08-12 16:05:09', '2025-08-12 16:05:09');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone_no` text DEFAULT NULL,
  `status` enum('enable','disable') NOT NULL,
  `address` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `category_id`, `name`, `phone_no`, `status`, `address`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 3, 'A One Feeds', '0', 'enable', 'Hyd', NULL, '2024-09-02 13:11:32', '2024-09-02 13:11:32');

-- --------------------------------------------------------

--
-- Table structure for table `expensecategories`
--

CREATE TABLE `expensecategories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 means active 0 means deactive',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expensecategories`
--

INSERT INTO `expensecategories` (`id`, `name`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Electricity Equipment Expense', 1, NULL, '2024-07-02 07:13:08', '2024-07-02 07:17:35'),
(2, 'ELECTRICITY BILL EXPENSE', 1, NULL, '2024-09-02 12:34:25', '2024-09-02 12:34:25'),
(3, 'MEDICIEN EXPENSE', 1, NULL, '2024-09-02 13:08:16', '2024-09-02 13:08:16'),
(4, 'SALARIES TO STAFF', 1, NULL, '2024-09-12 12:02:18', '2024-09-12 12:02:18');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shade_id` bigint(20) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `ammount` int(11) NOT NULL,
  `remarks` varchar(250) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `date`, `shade_id`, `category_id`, `ammount`, `remarks`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-09-02', 1, 2, 2000, 'Jul 24', NULL, '2024-09-02 12:47:46', '2024-09-02 12:47:46'),
(2, '2024-09-02', 2, 2, 3000, 'Paid HESCO Bill m/o Aug 24', NULL, '2024-09-02 12:48:15', '2024-09-12 12:00:56'),
(3, '2024-07-01', 1, 3, 500, 'Purchase Veccination', NULL, '2024-09-02 13:08:59', '2024-09-02 13:08:59'),
(4, '2024-09-02', 3, 4, 100000, 'Paid Salaries to Staff m/o Aug 24', NULL, '2024-09-12 12:03:08', '2024-09-12 12:03:08');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feed_invoices`
--

CREATE TABLE `feed_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shade_id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ref_no` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_price` decimal(16,2) NOT NULL,
  `sale_price` decimal(16,2) NOT NULL,
  `quantity` decimal(16,2) NOT NULL DEFAULT 0.00,
  `amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `discount_in_rs` decimal(16,2) NOT NULL DEFAULT 0.00,
  `discount_in_percent` decimal(16,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(16,2) NOT NULL DEFAULT 0.00,
  `net_amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `expiry_date` date DEFAULT NULL,
  `type` enum('Purchase','Sale','Purchase Return','Sale Return','Adjust In','Adjust Out') DEFAULT NULL,
  `stock_type` enum('In','Out') NOT NULL DEFAULT 'In',
  `is_draft` enum('1','0') NOT NULL DEFAULT '0',
  `whatsapp_status` enum('Sent','Not Sent') NOT NULL DEFAULT 'Sent',
  `remarks` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feed_invoices`
--

INSERT INTO `feed_invoices` (`id`, `date`, `shade_id`, `invoice_no`, `account_id`, `ref_no`, `description`, `item_id`, `purchase_price`, `sale_price`, `quantity`, `amount`, `discount_in_rs`, `discount_in_percent`, `total_cost`, `net_amount`, `expiry_date`, `type`, `stock_type`, `is_draft`, `whatsapp_status`, `remarks`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-09-02', 1, 24090001, 3, NULL, NULL, 12, 6682.00, 0.00, 220.00, 1470040.00, 0.00, 0.00, 0.00, 1470040.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, '2024-09-12 11:56:04', '2024-09-02 13:20:01', '2024-09-12 11:56:04'),
(2, '2024-09-02', 1, 24090001, NULL, NULL, NULL, 12, 0.00, 6000.00, -220.00, 1320000.00, 0.00, 0.00, 0.00, 1320000.00, NULL, 'Sale', 'Out', '0', 'Not Sent', NULL, NULL, '2024-09-02 13:21:57', '2024-09-02 13:21:57'),
(3, '2024-09-02', 1, 24090001, 3, NULL, NULL, 12, 6682.00, 0.00, 220.00, 1470040.00, 0.00, 0.00, 0.00, 1470040.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, '2024-11-07 14:15:18', '2024-09-12 11:56:04', '2024-11-07 14:15:18'),
(4, '2024-09-02', 1, 24090001, 3, NULL, NULL, 12, 6682.00, 0.00, 220.00, 1470040.00, 0.00, 0.00, 0.00, 1470040.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, '2024-11-07 14:15:30', '2024-11-07 14:15:18', '2024-11-07 14:15:30'),
(5, '2024-09-02', 1, 24090001, 3, NULL, NULL, 12, 6682.00, 0.00, 220.00, 1470040.00, 0.00, 0.00, 0.00, 1470040.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2024-11-07 14:15:30', '2024-11-07 14:15:30'),
(6, '2024-09-26', 2, 24110001, 3, NULL, 'Feed Purchsaed', 12, 6682.00, 0.00, 220.00, 1470040.00, 0.00, 0.00, 0.00, 1470040.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2024-11-07 14:16:50', '2024-11-07 14:16:50');

-- --------------------------------------------------------

--
-- Table structure for table `flocks`
--

CREATE TABLE `flocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shade_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` enum('active','not_active') NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flocks`
--

INSERT INTO `flocks` (`id`, `shade_id`, `start_date`, `name`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(2, 2, '2024-07-07', 'Flock # 1', 'active', NULL, '2024-09-07 03:30:40', '2024-09-07 03:30:40'),
(3, 2, '2024-07-07', 'Flock # 12', 'active', NULL, '2024-09-07 03:35:13', '2024-09-07 03:35:13'),
(4, 3, '2024-12-12', 'Flock-8', 'active', NULL, '2024-09-12 11:46:36', '2024-09-12 11:46:36');

-- --------------------------------------------------------

--
-- Table structure for table `general_categories`
--

CREATE TABLE `general_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 means active 0 means deactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `primary_unit` varchar(255) NOT NULL,
  `price` double(10,2) NOT NULL,
  `discount` double(10,2) NOT NULL,
  `purchase_price` double(10,2) NOT NULL,
  `sale_price` double(10,2) NOT NULL,
  `opening_stock` double(10,2) NOT NULL,
  `stock_qty` double(10,2) NOT NULL,
  `type` enum('purchase','sale') NOT NULL,
  `stock_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 means enabled 0 means disabled',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 means active 0 means deactive',
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `category_id`, `company_id`, `name`, `unit`, `primary_unit`, `price`, `discount`, `purchase_price`, `sale_price`, `opening_stock`, `stock_qty`, `type`, `stock_status`, `status`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 8, 1, 'Murghi', 'kg', 'kg', 100.00, 10.00, 90.00, 110.00, 0.00, 50.00, 'sale', 1, 1, 'Remark for item 1', '2024-06-09 12:06:20', '2024-06-09 12:06:20'),
(2, 2, 2, 'Chick', 'liters', 'liters', 200.00, 5.00, 180.00, 220.00, 0.00, 100.00, 'sale', 1, 1, 'Remark for item 2', '2024-06-09 12:06:20', '2024-06-09 12:06:20'),
(12, 3, 1, '09', 'Bags', 'Bags', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'purchase', 1, 1, NULL, '2024-09-02 13:14:23', '2024-09-02 13:14:23'),
(13, 4, 0, 'Lysovet', 'kg', '0', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'purchase', 1, 1, NULL, '2024-09-18 11:29:34', '2024-09-18 11:29:34');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_invoices`
--

CREATE TABLE `medicine_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shade_id` bigint(20) DEFAULT NULL,
  `invoice_no` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ref_no` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transport_name` varchar(255) DEFAULT NULL,
  `vehicle_no` varchar(255) DEFAULT NULL,
  `driver_name` varchar(255) DEFAULT NULL,
  `contact_no` varchar(255) DEFAULT NULL,
  `builty_no` varchar(255) DEFAULT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_price` decimal(18,2) NOT NULL,
  `sale_price` decimal(18,2) NOT NULL,
  `quantity` decimal(18,2) NOT NULL DEFAULT 0.00,
  `amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `discount_in_rs` decimal(18,2) NOT NULL DEFAULT 0.00,
  `discount_in_percent` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(18,2) NOT NULL DEFAULT 0.00,
  `net_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `expiry_date` date DEFAULT NULL,
  `type` enum('Purchase','Sale','Purchase Return','Sale Return','Adjust Stock') DEFAULT NULL,
  `stock_type` enum('In','Out') NOT NULL DEFAULT 'In',
  `is_draft` enum('1','0') NOT NULL DEFAULT '0',
  `whatsapp_status` enum('Sent','Not Sent') NOT NULL DEFAULT 'Sent',
  `remarks` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicine_invoices`
--

INSERT INTO `medicine_invoices` (`id`, `date`, `shade_id`, `invoice_no`, `account_id`, `ref_no`, `description`, `transport_name`, `vehicle_no`, `driver_name`, `contact_no`, `builty_no`, `item_id`, `purchase_price`, `sale_price`, `quantity`, `amount`, `discount_in_rs`, `discount_in_percent`, `total_cost`, `net_amount`, `expiry_date`, `type`, `stock_type`, `is_draft`, `whatsapp_status`, `remarks`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-08-30', 2, 24080001, 12, '121', 'medicine purchase for shade 45', NULL, NULL, NULL, NULL, NULL, 11, 2300.00, 0.00, 1240.00, 2852000.00, 0.00, 0.00, 2852000.00, 2852000.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2024-08-30 16:24:22', '2024-08-30 16:24:22');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2024_05_12_000000_create_failed_jobs_table', 1),
(3, '2024_05_12_000000_create_users_table', 1),
(4, '2024_05_12_011900_create_general_categories_table', 1),
(6, '2024_05_12_081707_create_admins_table', 1),
(7, '2024_05_12_100000_create_password_resets_table', 1),
(8, '2024_05_12_161609_cash_book', 1),
(9, '2024_05_12_162435_create_permissions_table', 1),
(10, '2024_05_12_174657_paymentbook', 1),
(11, '2024_05_12_193523_create_items_table', 1),
(12, '2024_05_12_201659_create_account_types_table', 1),
(13, '2024_05_12_210756_create_accounts_table', 1),
(14, '2024_05_13_191024_categories', 1),
(15, '2024_05_13_191439_expensecategories', 1),
(16, '2024_05_13_191557_expensebook', 1),
(18, '2024_05_17_140833_medicine_invoices', 1),
(21, '2024_06_02_154647_companies', 1),
(22, '2024_06_04_225542_create_other_invoices_table', 1),
(23, '2024_06_14_030130_add_columns_to_medicine_invoices_table', 2),
(25, '2024_07_27_233923_mortality', 4),
(26, '2024_07_27_230126_shade', 5),
(28, '2024_05_17_140909_chick_invoices', 6),
(29, '2024_05_12_081648_account_ledger', 7),
(30, '2024_05_17_141023_murghi_invoices', 8),
(31, '2024_05_17_140807_feed_invoices', 9);

-- --------------------------------------------------------

--
-- Table structure for table `mortality`
--

CREATE TABLE `mortality` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shade_id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `murghi_invoices`
--

CREATE TABLE `murghi_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shade_id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `ref_no` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_price` decimal(16,2) NOT NULL DEFAULT 0.00,
  `sale_price` decimal(16,2) NOT NULL DEFAULT 0.00,
  `weight` decimal(16,2) NOT NULL,
  `weight_detection` decimal(16,2) NOT NULL,
  `quantity` decimal(16,2) NOT NULL DEFAULT 0.00,
  `amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(16,2) NOT NULL DEFAULT 0.00,
  `net_amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `expiry_date` date DEFAULT NULL,
  `type` enum('Purchase','Sale','Purchase Return','Sale Return','Adjust In','Adjust Out') DEFAULT NULL,
  `stock_type` enum('In','Out') NOT NULL DEFAULT 'In',
  `is_draft` enum('1','0') NOT NULL DEFAULT '0',
  `whatsapp_status` enum('Sent','Not Sent') NOT NULL DEFAULT 'Sent',
  `remarks` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `murghi_invoices`
--

INSERT INTO `murghi_invoices` (`id`, `date`, `shade_id`, `invoice_no`, `account_id`, `ref_no`, `description`, `item_id`, `purchase_price`, `sale_price`, `weight`, `weight_detection`, `quantity`, `amount`, `total_cost`, `net_amount`, `expiry_date`, `type`, `stock_type`, `is_draft`, `whatsapp_status`, `remarks`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-09-02', 1, 0, 2, '3344', '4343', 1, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2024-09-02 12:51:13', '2024-09-02 12:51:13'),
(2, '2024-09-18', 3, 24090001, 4, '11', '11', 1, 0.00, 231.00, 780.00, 12.00, -765.00, 176715.00, 0.00, 176715.00, NULL, 'Sale', 'Out', '0', 'Not Sent', NULL, NULL, '2024-09-18 12:17:29', '2024-09-18 12:17:29'),
(3, '2024-09-18', 1, 24090001, 1, NULL, NULL, 1, 0.00, 1.00, 780.00, 12.00, -768.00, 768.00, 0.00, 768.00, NULL, 'Sale', 'Out', '0', 'Not Sent', NULL, NULL, '2024-09-18 12:20:47', '2024-09-18 12:20:47'),
(4, '2024-09-18', 1, 24090001, 1, NULL, NULL, 1, 0.00, 436.00, 780.00, 12.00, -768.00, 334848.00, 0.00, 334848.00, NULL, 'Sale', 'Out', '0', 'Not Sent', NULL, NULL, '2024-09-18 12:21:21', '2024-09-18 12:21:21'),
(5, '2024-09-18', 2, 0, 2, NULL, NULL, 1, 0.00, 0.00, 0.00, 0.00, 60000.00, 0.00, 0.00, 0.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2024-09-18 12:39:28', '2024-09-18 12:39:28'),
(6, '2025-08-12', 2, 0, 3, NULL, NULL, 1, 0.00, 0.00, 0.00, 0.00, 100000.00, 0.00, 0.00, 0.00, NULL, 'Purchase', 'In', '0', 'Not Sent', NULL, NULL, '2025-08-12 16:05:09', '2025-08-12 16:05:09');

-- --------------------------------------------------------

--
-- Table structure for table `other_invoices`
--

CREATE TABLE `other_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `invoice_no` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `ref_no` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) NOT NULL,
  `quantity` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_in_rs` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_in_percent` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(8,2) NOT NULL DEFAULT 0.00,
  `net_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `expiry_date` date DEFAULT NULL,
  `type` enum('Purchase','Sale','Purchase Return','Sale Return','Adjust In','Adjust Out') DEFAULT NULL,
  `stock_type` enum('In','Out') NOT NULL DEFAULT 'In',
  `is_draft` enum('1','0') NOT NULL DEFAULT '0',
  `whatsapp_status` enum('Sent','Not Sent') NOT NULL DEFAULT 'Sent',
  `remarks` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_book`
--

CREATE TABLE `payment_book` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `creditor_account_id` int(11) NOT NULL,
  `credit_ammount` int(11) NOT NULL,
  `debtor_account_id` int(11) NOT NULL,
  `debtor_ammount` int(11) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_book`
--

INSERT INTO `payment_book` (`id`, `date`, `creditor_account_id`, `credit_ammount`, `debtor_account_id`, `debtor_ammount`, `remarks`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-09-12', 1, 10000, 4, 10000, NULL, NULL, '2024-09-12 11:50:57', '2025-03-06 14:22:17'),
(2, '2024-09-12', 4, 2000, 3, 2000, NULL, NULL, '2024-09-12 12:08:50', '2025-03-06 14:22:00');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission_types`
--

CREATE TABLE `permission_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shades`
--

CREATE TABLE `shades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `status` enum('active','not_active') NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shades`
--

INSERT INTO `shades` (`id`, `date`, `name`, `address`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '2024-07-01', 'Abdullah Farm', 'Tando Allahyar', 'active', NULL, '2024-09-02 12:45:00', '2024-09-07 03:35:58'),
(2, '2024-08-01', 'KHADIJAH FARM', 'Tando Fazal', 'active', NULL, '2024-09-02 12:46:55', '2024-09-07 03:35:34'),
(3, '2023-12-12', 'Ebadullah Farm', 'Hyd', 'active', NULL, '2024-09-12 11:45:57', '2024-09-12 11:45:57');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `weightdata`
--

CREATE TABLE `weightdata` (
  `srno` int(23) NOT NULL,
  `vno` varchar(50) NOT NULL,
  `vtype` int(23) DEFAULT NULL,
  `vehicle_name` varchar(50) DEFAULT NULL,
  `party_id` int(23) DEFAULT NULL,
  `party_name` varchar(100) DEFAULT NULL,
  `material_id` int(23) DEFAULT NULL,
  `material_name` varchar(50) DEFAULT NULL,
  `container` varchar(50) DEFAULT NULL,
  `qty` int(10) NOT NULL DEFAULT 0,
  `charges` int(10) NOT NULL,
  `fwet` int(6) NOT NULL DEFAULT 0,
  `fdate` date NOT NULL,
  `ftime` time NOT NULL,
  `fdatetime` datetime NOT NULL,
  `swet` int(6) DEFAULT NULL,
  `nwet` int(6) DEFAULT NULL,
  `sdate` date DEFAULT NULL,
  `stime` time DEFAULT NULL,
  `sdatetime` datetime DEFAULT NULL,
  `munds` char(10) NOT NULL DEFAULT '',
  `munds2` char(10) NOT NULL DEFAULT '',
  `shift` varchar(20) DEFAULT NULL,
  `shift2` varchar(20) DEFAULT NULL,
  `status` enum('ON','OFF') DEFAULT 'ON',
  `driver` varchar(50) NOT NULL,
  `avg` float DEFAULT 0,
  `operator` varchar(50) NOT NULL,
  `client_id` int(1) NOT NULL DEFAULT 1,
  `client_name` varchar(100) DEFAULT NULL,
  `client_add` varchar(200) DEFAULT NULL,
  `MundsValue` char(200) NOT NULL DEFAULT '',
  `KgValue` char(200) NOT NULL DEFAULT '',
  `Narration` char(150) NOT NULL DEFAULT '',
  `Station` char(100) NOT NULL DEFAULT '',
  `whatsapp_no` char(20) NOT NULL DEFAULT '',
  `carrat_qty` int(10) NOT NULL DEFAULT 0,
  `shade_no` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `weightdata`
--

INSERT INTO `weightdata` (`srno`, `vno`, `vtype`, `vehicle_name`, `party_id`, `party_name`, `material_id`, `material_name`, `container`, `qty`, `charges`, `fwet`, `fdate`, `ftime`, `fdatetime`, `swet`, `nwet`, `sdate`, `stime`, `sdatetime`, `munds`, `munds2`, `shift`, `shift2`, `status`, `driver`, `avg`, `operator`, `client_id`, `client_name`, `client_add`, `MundsValue`, `KgValue`, `Narration`, `Station`, `whatsapp_no`, `carrat_qty`, `shade_no`) VALUES
(1, 'FDSF', NULL, 'DEFAULT', NULL, 'TRET', NULL, 'CHICKEN', '', 0, 0, 0, '2024-07-12', '19:32:06', '2024-07-12 19:32:06', 10, 10, '2024-07-12', '19:35:36', '2024-07-12 19:35:36', '0.10', '0.10', '', NULL, 'OFF', 'Without Driver', 0, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '0', '10', '', '', '923461315205', 0, ''),
(2, 'DSDSF', NULL, 'DEFAULT', NULL, 'YAR MUHAMMAD MATIARI', NULL, 'COTTON SEEDS', '', 0, 0, 10, '2024-07-12', '19:51:43', '2024-07-12 19:51:43', 10, 0, '2024-07-12', '19:55:51', '2024-07-12 19:55:51', '0.0', '0.0', '', NULL, 'OFF', 'Without Driver', 0, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '0', '0', '', '', '', 0, ''),
(3, 'TKV-855', NULL, 'DEFAULT', NULL, 'HAJI KHAIR MUHAMMAD C/O TARIQ CHOHAN', NULL, 'MURGHI', '', 2424, 0, 0, '2024-07-15', '17:59:06', '2024-07-15 17:59:06', 5370, 5370, '2024-07-15', '17:59:06', '2024-07-15 17:59:06', '134.10', '143.5', '', NULL, 'OFF', 'Without Driver', 2.21535, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '134', '10', '', '', '', 0, ''),
(4, 'JZ-9206', NULL, 'DEFAULT', NULL, 'SULTAN BALOCHISTAN C/O TARIQ CHOHAN', NULL, 'MURGHI', '', 1191, 0, 0, '2024-07-15', '18:03:19', '2024-07-15 18:03:19', 0, 0, '2024-07-15', '18:03:19', '2024-07-15 18:03:19', '0.0', '0.0', '', NULL, 'OFF', 'Without Driver', 0, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '0', '0', '', '', '', 0, ''),
(5, 'JZ-9206', NULL, 'DEFAULT', NULL, 'SULTAN BALOCHISTAN C/O TARIQ CHOHAN', NULL, 'MURGHI', '', 1191, 0, 0, '2024-07-15', '18:04:57', '2024-07-15 18:04:57', 2495, 2495, '2024-07-15', '18:04:57', '2024-07-15 18:04:57', '62.15', '66.16', '', NULL, 'OFF', 'Without Driver', 2.09488, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '62', '15', '', '', '', 0, ''),
(6, 'JY 4050', NULL, 'DEFAULT', NULL, 'POLTRY FARM', NULL, 'MURGHI', '', 0, 0, 55, '2024-07-15', '18:43:14', '2024-07-15 18:43:14', 85, 30, '2024-07-15', '18:45:08', '2024-07-15 18:45:08', '0.30', '0.30', '', NULL, 'OFF', 'Without Driver', 0.272727, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '0', '30', '', '', '923701101942', 0, ''),
(7, 'SS7298', NULL, 'DEFAULT', NULL, 'UMER BABLO', NULL, 'MURGHI', '', 0, 0, 4600, '2024-07-16', '03:38:15', '2024-07-16 03:38:15', 8140, 3540, '2024-07-16', '05:56:01', '2024-07-16 05:56:01', '88.20', '94.25', '', NULL, 'OFF', 'Without Driver', 2.20698, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '88', '20', '', '', '923163735876', 0, ''),
(8, 'PAA804', NULL, 'DEFAULT', NULL, 'SOHAIL BHAI', NULL, 'MURGHI', '', 0, 0, 1950, '2024-07-16', '03:46:47', '2024-07-16 03:46:47', 3315, 1365, '2024-07-16', '05:33:07', '2024-07-16 05:33:07', '34.5', '36.33', '', NULL, 'OFF', 'Without Driver', 2.2377, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '34', '5', '', '', '923701101942', 0, ''),
(9, 'G0136', NULL, 'DEFAULT', NULL, 'HAJI ZOHAIB SOHAIL BHAI', NULL, 'MURGHI', '', 0, 0, 1970, '2024-07-16', '03:53:13', '2024-07-16 03:53:13', 3595, 1625, '2024-07-16', '05:37:53', '2024-07-16 05:37:53', '40.25', '43.34', '', NULL, 'OFF', 'Without Driver', 2.27273, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '40', '25', '', '', '', 0, ''),
(10, 'KM0454', NULL, 'DEFAULT', NULL, 'SHARIF TAWOR', NULL, 'MURGHI', '', 0, 0, 2035, '2024-07-16', '03:59:30', '2024-07-16 03:59:30', 4010, 1975, '2024-07-16', '06:32:35', '2024-07-16 06:32:35', '49.15', '52.14', '', NULL, 'OFF', 'Without Driver', 2.14674, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '49', '15', '', '', '923701101942', 0, ''),
(11, 'KP3283', NULL, 'DEFAULT', NULL, 'SOHAIL BHAI FAISAL TAWOR', NULL, 'MURGHI', '', 0, 0, 2505, '2024-07-16', '04:07:50', '2024-07-16 04:07:50', 4810, 2305, '2024-07-16', '06:27:17', '2024-07-16 06:27:17', '57.25', '61.11', '', NULL, 'OFF', 'Without Driver', 2.24878, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '57', '25', '', '', '923701101942', 0, ''),
(12, 'KC9886', NULL, 'DEFAULT', NULL, 'JAWAID QURAISHI', NULL, 'MURGHI', '', 0, 0, 2015, '2024-07-16', '04:12:55', '2024-07-16 04:12:55', 3135, 1120, '2024-07-16', '05:49:00', '2024-07-16 05:49:00', '28.0', '30.10', '', NULL, 'OFF', 'Without Driver', 2.33333, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '28', '0', '', '', '923701101942', 0, ''),
(13, 'CL9886', NULL, 'DEFAULT', NULL, 'SHABIR', NULL, 'MURGHI', '', 0, 0, 1940, '2024-07-16', '04:19:29', '2024-07-16 04:19:29', 3685, 1745, '2024-07-16', '06:09:42', '2024-07-16 06:09:42', '43.25', '46.6', '', NULL, 'OFF', 'Without Driver', 0.275106, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '43', '25', '', '', '923701101942', 0, ''),
(14, 'KM9357', NULL, 'DEFAULT', NULL, 'JAWAID QURSHI', NULL, 'MURGHI', '', 0, 0, 2390, '2024-07-16', '04:25:35', '2024-07-16 04:25:35', 4125, 1735, '2024-07-16', '06:18:48', '2024-07-16 06:18:48', '43.15', '46.33', '', NULL, 'OFF', 'Without Driver', 2.16875, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '43', '15', '', '', '923701101942', 0, ''),
(15, '01', NULL, 'DEFAULT', NULL, 'JUMA', NULL, 'MURGHI', '', 0, 0, 0, '2024-07-16', '18:41:15', '2024-07-16 18:41:15', 85, 85, '2024-07-16', '18:42:33', '2024-07-16 18:42:33', '2.5', '2.11', '', NULL, 'OFF', 'Without Driver', 85, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '2', '5', '', '', '923701101942', 0, 'Shade No 2'),
(16, '120', NULL, 'DEFAULT', NULL, 'JUMA', NULL, 'MURGHI', '', 0, 0, 0, '2024-07-16', '19:04:07', '2024-07-16 19:04:07', 0, 0, '2024-07-16', '19:04:57', '2024-07-16 19:04:57', '0.0', '0.0', '', NULL, 'OFF', 'Without Driver', 0, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '0', '0', '', '', '923701101942', 1, 'Shade No 2'),
(17, 'TM621', NULL, 'DEFAULT', NULL, 'SHAIR MUHMAD', NULL, 'MURGHI', '', 0, 0, 11055, '2024-07-16', '20:24:34', '2024-07-16 20:24:34', 18270, 7215, '2024-07-16', '22:34:45', '2024-07-16 22:34:45', '180.15', '193.0', '', NULL, 'OFF', 'Without Driver', 2.22685, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '180', '15', '', '', '923701101942', 120, 'Shade No 2'),
(18, 'TKS482', NULL, 'DEFAULT', NULL, 'SHAIR MUHMAD', NULL, 'MURGHI', '', 0, 0, 11515, '2024-07-16', '20:35:11', '2024-07-16 20:35:11', 20045, 8530, '2024-07-16', '22:19:00', '2024-07-16 22:19:00', '213.10', '228.20', '', NULL, 'OFF', 'Without Driver', 2.66563, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '213', '10', '', '', '923701101942', 120, 'Shade No 2'),
(19, 'TAN468', NULL, 'DEFAULT', NULL, 'SHAIR MUHAMMAD', NULL, 'MURGHI', '', 0, 0, 11500, '2024-07-16', '20:51:48', '2024-07-16 20:51:48', 19255, 7755, '2024-07-17', '00:16:24', '2024-07-17 00:16:24', '193.35', '207.22', '', NULL, 'OFF', 'Without Driver', 2.2094, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '193', '35', '', '', '923701101942', 115, 'Shade No 2'),
(20, 'TEST2', NULL, 'DEFAULT', NULL, 'YAR MUHAMMAD MATIARI', NULL, 'MURGHI', '', 205, 0, 0, '2024-07-16', '22:45:10', '2024-07-16 22:45:10', 0, 0, '2024-07-16', '22:45:29', '2024-07-16 22:45:29', '0.0', '0.0', '', NULL, 'OFF', 'Without Driver', 0, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '0', '0', 'HYK', 'HYDERABAD', '923003025291', 155, 'Shade No 1'),
(21, 'HDS1', NULL, 'DEFAULT', NULL, 'YAR MUHAMMAD MATIARI', NULL, 'KITTY', '', 3200, 0, 0, '2024-07-16', '22:47:31', '2024-07-16 22:47:31', 8250, 8250, '2024-07-16', '22:47:31', '2024-07-16 22:47:31', '206.10', '221.36', '', NULL, 'OFF', 'Without Driver', 2.57813, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '206', '10', 'hyd', '', '923003025291', 120, 'Shade No 1'),
(22, 'KQ0324', NULL, 'DEFAULT', NULL, 'AMEEN BAROHI', NULL, 'MURGHI', '', 0, 0, 2255, '2024-07-17', '03:39:46', '2024-07-17 03:39:46', 3925, 1670, '2024-07-17', '05:40:17', '2024-07-17 05:40:17', '41.30', '44.5', '', NULL, 'OFF', 'Without Driver', 2.33566, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '41', '30', '', '', '923701101942', 70, 'Shade No 2'),
(23, 'KH9118', NULL, 'DEFAULT', NULL, 'KHUROM HYD', NULL, 'MURGHI', '', 0, 0, 2135, '2024-07-17', '03:45:41', '2024-07-17 03:45:41', 4025, 1890, '2024-07-17', '05:47:21', '2024-07-17 05:47:21', '47.10', '50.3', '', NULL, 'OFF', 'Without Driver', 2.45455, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '47', '10', '', '', '923701101942', 70, 'Shade No 2'),
(24, 'JY6450', NULL, 'DEFAULT', NULL, 'JAMEEL SHAHZAD PUR', NULL, 'MURGHI', '', 0, 0, 3885, '2024-07-17', '03:51:49', '2024-07-17 03:51:49', 6725, 2840, '2024-07-17', '05:14:42', '2024-07-17 05:14:42', '71.0', '76.28', '', NULL, 'OFF', 'Without Driver', 0.234323, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '71', '0', '', '', '923701101942', 1120, 'Shade No 2'),
(25, 'KH3283', NULL, 'DEFAULT', NULL, 'SOHAIL BHAI', NULL, 'MURGHI', '', 0, 0, 2400, '2024-07-17', '03:58:44', '2024-07-17 03:58:44', 3785, 1385, '2024-07-17', '05:36:25', '2024-07-17 05:36:25', '34.25', '37.16', '', NULL, 'OFF', 'Without Driver', 2.40451, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '34', '25', '', '', '923701101942', 64, 'Shade No 2'),
(26, 'CL3356', NULL, 'DEFAULT', NULL, 'SHABEER', NULL, 'MURGHI', '', 0, 0, 1940, '2024-07-17', '04:05:20', '2024-07-17 04:05:20', 3635, 1695, '2024-07-17', '05:44:27', '2024-07-17 05:44:27', '42.15', '45.30', '', NULL, 'OFF', 'Without Driver', 2.32192, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '42', '15', '', '', '923701101942', 56, 'Shade No 2'),
(27, 'JY9516', NULL, 'DEFAULT', NULL, 'JAHZEEB', NULL, 'MURGHI', '', 0, 0, 4455, '2024-07-17', '04:12:26', '2024-07-17 04:12:26', 7295, 2840, '2024-07-17', '05:57:08', '2024-07-17 05:57:08', '71.0', '76.28', '', NULL, 'OFF', 'Without Driver', 2.36667, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '71', '0', '', '', '923701101942', 180, 'Shade No 2'),
(28, 'KV2841', NULL, 'DEFAULT', NULL, 'JAHZEEB TND ALLAH YAAR', NULL, 'MURGHI', '', 0, 0, 1270, '2024-07-17', '04:16:53', '2024-07-17 04:16:53', 2085, 815, '2024-07-17', '06:31:35', '2024-07-17 06:31:35', '20.15', '21.1', '', NULL, 'OFF', 'Without Driver', 2.4697, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '20', '15', '', '', '923701101942', 42, 'Shade No 2'),
(29, 'KM9357', NULL, 'DEFAULT', NULL, 'JAVEED TMK', NULL, 'MURGHI', '', 0, 0, 2405, '2024-07-18', '03:27:37', '2024-07-18 03:27:37', 4155, 1750, '2024-07-18', '06:05:32', '2024-07-18 06:05:32', '43.30', '46.11', '', NULL, 'OFF', 'Without Driver', 2.1875, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '43', '30', '', '', '923701101942', 80, 'Shade No 2'),
(30, 'KF1147', NULL, 'DEFAULT', NULL, 'YASER TMK', NULL, 'MURGHI', '', 0, 0, 2050, '2024-07-18', '03:36:47', '2024-07-18 03:36:47', 3460, 1410, '2024-07-18', '06:08:43', '2024-07-18 06:08:43', '35.10', '37.4', '', NULL, 'OFF', 'Without Driver', 2.20313, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '35', '10', '', '', '923701101942', 64, 'Shade No 2'),
(31, 'KN2296', NULL, 'DEFAULT', NULL, 'SOHAIL MEMAN', NULL, 'MURGHI', '', 0, 0, 2365, '2024-07-18', '03:44:36', '2024-07-18 03:44:36', 4275, 1910, '2024-07-18', '06:15:45', '2024-07-18 06:15:45', '47.30', '51.23', '', NULL, 'OFF', 'Without Driver', 2.15819, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '47', '30', '', '', '923701101942', 70, 'Shade No 2'),
(32, 'KB6593', NULL, 'DEFAULT', NULL, 'SHABEER', NULL, 'MURGHI', '', 0, 0, 1240, '2024-07-18', '03:48:54', '2024-07-18 03:48:54', 2485, 1245, '2024-07-18', '05:51:22', '2024-07-18 05:51:22', '31.5', '33.24', '', NULL, 'OFF', 'Without Driver', 2.37143, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '31', '5', '', '', '923701101942', 42, 'Shade No 2'),
(33, 'KU2439', NULL, 'DEFAULT', NULL, 'SOHAIL MEMAN', NULL, 'MURGHI', '', 0, 0, 1175, '2024-07-18', '03:54:20', '2024-07-18 03:54:20', 2065, 890, '2024-07-18', '05:38:59', '2024-07-18 05:38:59', '22.10', '23.2', '', NULL, 'OFF', 'Without Driver', 2.34211, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '22', '10', '', '', '923701101942', 42, 'Shade No 2'),
(34, 'KS4957', NULL, 'DEFAULT', NULL, 'SOHAIL MEMAN', NULL, 'MURGHI', '', 0, 0, 1105, '2024-07-18', '03:57:28', '2024-07-18 03:57:28', 1865, 760, '2024-07-18', '05:54:56', '2024-07-18 05:54:56', '19.0', '20.20', '', NULL, 'OFF', 'Without Driver', 2.2029, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '19', '0', '', '', '923701101942', 38, 'Shade No 2'),
(35, 'G0136', NULL, 'DEFAULT', NULL, 'SOHAL MEMAN', NULL, 'MURGHI', '', 0, 0, 1865, '2024-07-18', '04:03:59', '2024-07-18 04:03:59', 2760, 895, '2024-07-18', '05:45:45', '2024-07-18 05:45:45', '22.15', '23.7', '', NULL, 'OFF', 'Without Driver', 2.2375, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '22', '15', '', '', '923701101942', 42, 'Shade No 2'),
(36, 'KP0618', NULL, 'DEFAULT', NULL, 'IFTAKHAR TNDJ', NULL, 'MURGHI', '', 0, 0, 2320, '2024-07-18', '04:08:15', '2024-07-18 04:08:15', 4150, 1830, '2024-07-18', '07:22:02', '2024-07-18 07:22:02', '45.30', '49.17', '', NULL, 'OFF', 'Without Driver', 2.07955, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '45', '30', '', '', '923701101942', 80, 'Shade No 2'),
(37, 'JY0566', NULL, 'DEFAULT', NULL, 'IFTAKHAR TNDJ', NULL, 'MURGHI', '', 0, 0, 4645, '2024-07-18', '04:13:45', '2024-07-18 04:13:45', 8075, 3430, '2024-07-18', '06:02:15', '2024-07-18 06:02:15', '85.30', '91.26', '', NULL, 'OFF', 'Without Driver', 2.21148, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '85', '30', '', '', '923701101942', 141, 'Shade No 2'),
(38, 'JZ9326', NULL, 'DEFAULT', NULL, 'IFTAKHAR TNDJ', NULL, 'MURGHI', '', 0, 0, 4650, '2024-07-18', '04:18:40', '2024-07-18 04:18:40', 8680, 4030, '2024-07-18', '05:59:02', '2024-07-18 05:59:02', '100.30', '107.34', '', NULL, 'OFF', 'Without Driver', 2.31609, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '100', '30', '', '', '923701101942', 160, 'Shade No 2'),
(39, 'KH9118', NULL, 'DEFAULT', NULL, 'SOHAIL MEMAN', NULL, 'MURGHI', '', 0, 0, 2130, '2024-07-19', '05:35:19', '2024-07-19 05:35:19', 3880, 1750, '2024-07-19', '06:39:58', '2024-07-19 06:39:58', '43.30', '46.11', '', NULL, 'OFF', 'Without Driver', 2.08333, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '43', '30', '', '', '923701101942', 70, 'Shade No 2'),
(40, 'KP6470', NULL, 'DEFAULT', NULL, 'NADEEM BABA VIP', NULL, 'MURGHI', '', 0, 0, 1145, '2024-07-19', '05:39:00', '2024-07-19 05:39:00', 1875, 730, '2024-07-19', '06:56:01', '2024-07-19 06:56:01', '18.10', '19.27', '', NULL, 'OFF', 'Without Driver', 1.52083, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '18', '10', '', '', '923701101942', 32, 'Shade No 2'),
(41, 'SGQ8865', NULL, 'DEFAULT', NULL, 'TARIQ SAKHAR', NULL, 'MURGHI', '', 0, 0, 12750, '2024-07-21', '19:53:11', '2024-07-21 19:53:11', 20915, 8165, '2024-07-21', '22:12:12', '2024-07-21 22:12:12', '204.5', '218.25', '', NULL, 'OFF', 'Without Driver', 2.57734, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '204', '5', '', '', '923701101942', 144, 'Shade No 1'),
(42, 'TKT544', NULL, 'DEFAULT', NULL, 'TARIQ SAKHAR', NULL, 'MURGHI', '', 0, 0, 7565, '2024-07-21', '20:06:46', '2024-07-21 20:06:46', 11840, 4275, '2024-07-21', '21:14:25', '2024-07-21 21:14:25', '106.35', '114.20', '', NULL, 'OFF', 'Without Driver', 2.67188, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '106', '35', '', '', '923701101942', 100, 'Shade No 1'),
(43, 'TAM621', NULL, 'DEFAULT', NULL, 'TARIQ SAKHAR', NULL, 'MURGHI', '', 0, 0, 11135, '2024-07-21', '20:43:13', '2024-07-21 20:43:13', 17700, 6565, '2024-07-21', '22:06:44', '2024-07-21 22:06:44', '164.5', '175.16', '', NULL, 'OFF', 'Without Driver', 2.58465, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '164', '5', '', '', '923701101942', 120, 'Shade No 1'),
(44, 'TAN279', NULL, 'DEFAULT', NULL, 'TARIQ SAKHAR', NULL, 'MURGHI', '', 0, 0, 11105, '2024-07-21', '20:50:37', '2024-07-21 20:50:37', 17730, 6625, '2024-07-21', '23:29:34', '2024-07-21 23:29:34', '165.25', '177.2', '', NULL, 'OFF', 'Without Driver', 2.59194, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '165', '25', '', '', '923701101942', 142, 'Shade No 1'),
(45, 'JZ9326', NULL, 'DEFAULT', NULL, 'IFTAKHAR TND JAM', NULL, 'MURGHI', '', 0, 0, 4450, '2024-07-22', '04:12:15', '2024-07-22 04:12:15', 7585, 3135, '2024-07-22', '05:21:19', '2024-07-22 05:21:19', '78.15', '83.27', '', NULL, 'OFF', 'Without Driver', 2.72135, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '78', '15', '', '', '923701101942', 128, 'Shade No 1'),
(46, 'JY0566', NULL, 'DEFAULT', NULL, 'IFTAKHAR TND JAM', NULL, 'MURGHI', '', 0, 0, 4655, '2024-07-22', '04:16:31', '2024-07-22 04:16:31', 7740, 3085, '2024-07-22', '05:32:30', '2024-07-22 05:32:30', '77.5', '82.14', '', NULL, 'OFF', 'Without Driver', 2.67795, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '77', '5', '', '', '923701101942', 128, 'Shade No 1'),
(47, 'JV6795', NULL, 'DEFAULT', NULL, 'HAJI ABDUI SHAKOR', NULL, 'MURGHI', '', 0, 0, 12380, '2024-07-22', '19:10:15', '2024-07-22 19:10:15', 21160, 8780, '2024-07-22', '20:43:32', '2024-07-22 20:43:32', '219.20', '235.11', '', NULL, 'OFF', 'Without Driver', 2.59456, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '219', '20', '', '', '923701101942', 144, 'Shade No 1'),
(48, 'KP8462', NULL, 'DEFAULT', NULL, 'HARIF TAWAR', NULL, 'MURGHI', '', 0, 0, 2340, '2024-07-23', '03:12:38', '2024-07-23 03:12:38', 4385, 2045, '2024-07-23', '04:53:14', '2024-07-23 04:53:14', '51.5', '54.10', '', NULL, 'OFF', 'Without Driver', 2.63531, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '51', '5', '', '', '923701101942', 70, 'Shade No 1'),
(49, 'JZ9326', NULL, 'DEFAULT', NULL, 'IFTAKHAR TND JAM', NULL, 'MURGHI', '', 0, 0, 4700, '2024-07-23', '03:35:21', '2024-07-23 03:35:21', 8550, 3850, '2024-07-23', '05:19:16', '2024-07-23 05:19:16', '96.10', '103.2', '', NULL, 'OFF', 'Without Driver', 2.56667, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '96', '10', '', '', '923701101942', 160, 'Shade No 1'),
(50, 'KP0618', NULL, 'DEFAULT', NULL, 'IFTKHAR TND JAM', NULL, 'MURGHI', '', 0, 0, 2320, '2024-07-23', '03:41:39', '2024-07-23 03:41:39', 4160, 1840, '2024-07-23', '05:14:19', '2024-07-23 05:14:19', '46.0', '49.27', '', NULL, 'OFF', 'Without Driver', 2.55556, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '46', '0', '', '', '923701101942', 80, 'Shade No 1'),
(51, 'KP8462', NULL, 'DEFAULT', NULL, 'SHARIF TOWER', NULL, 'MURGHI', '', 0, 0, 2320, '2024-07-24', '03:08:20', '2024-07-24 03:08:20', 4395, 2075, '2024-07-24', '04:55:34', '2024-07-24 04:55:34', '51.35', '55.3', '', NULL, 'OFF', 'Without Driver', 2.39607, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '51', '35', '', '', '923701121942', 70, 'Shade No 1'),
(52, 'KP2187', NULL, 'DEFAULT', NULL, 'SHARIF TOWER', NULL, 'MURGHI', '', 0, 0, 2320, '2024-07-24', '03:11:46', '2024-07-24 03:11:46', 4335, 2015, '2024-07-24', '05:29:45', '2024-07-24 05:29:45', '50.15', '53.17', '', NULL, 'OFF', 'Without Driver', 2.28977, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '50', '15', '', '', '923701101942', 72, 'Shade No 1'),
(53, 'AL-1418', NULL, 'DEFAULT', NULL, 'SHABEER HYDERABAD', NULL, 'MURGHI', '', 376, 0, 0, '2024-09-16', '19:23:37', '2024-09-16 19:23:37', 780, 780, '2024-09-16', '19:23:37', '2024-09-16 19:23:37', '19.20', '20.3', '', NULL, 'OFF', 'Without Driver', 2.07447, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '19', '20', '', '', '923461315205', 24, 'Shade No 1'),
(54, 'AL-1418', NULL, 'DEFAULT', NULL, 'SHABEER HYDERABAD', NULL, 'MURGHI', '', 376, 0, 0, '2024-09-16', '19:34:26', '2024-09-16 19:34:26', 780, 780, '2024-09-16', '19:34:26', '2024-09-16 19:34:26', '19.20', '20.3', '', NULL, 'OFF', 'Without Driver', 2.07447, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '19', '20', '', '', '923461315205', 24, 'Shade No 2'),
(55, 'JY2879', NULL, 'DEFAULT', NULL, 'YASER KARACHI', NULL, 'MURGHI', '', 0, 0, 5385, '2024-09-17', '01:32:18', '2024-09-17 01:32:18', 10920, 5535, '2024-09-17', '03:45:31', '2024-09-17 03:45:31', '138.15', '148.22', '', NULL, 'OFF', 'Without Driver', 1.98103, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '138', '15', '', '', '923017650988', 194, 'Shade No 2'),
(56, 'JU7323', NULL, 'DEFAULT', NULL, 'FAROOQ KORANGI', NULL, 'MURGHI', '', 0, 0, 7330, '2024-09-17', '01:35:57', '2024-09-17 01:35:57', 13190, 5860, '2024-09-17', '03:39:43', '2024-09-17 03:39:43', '146.20', '157.14', '', NULL, 'OFF', 'Without Driver', 1.95725, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '146', '20', '', '', '923017650988', 0, 'Shade No 2'),
(57, 'TAV013', NULL, 'DEFAULT', NULL, 'ALI KAMAL ATHAR ', NULL, 'MURGHI', '', 0, 0, 4250, '2024-09-17', '01:41:26', '2024-09-17 01:41:26', 6600, 2350, '2024-09-17', '03:07:50', '2024-09-17 03:07:50', '58.30', '62.19', '', NULL, 'OFF', 'Without Driver', 2.07965, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '58', '30', '', '', '923017650988', 100, 'Shade No 1'),
(58, 'KC9886', NULL, 'DEFAULT', NULL, 'JAVEED TMK', NULL, 'MURGHI', '', 0, 0, 2085, '2024-09-17', '02:02:46', '2024-09-17 02:02:46', 3340, 1255, '2024-09-17', '03:58:56', '2024-09-17 03:58:56', '31.15', '33.34', '', NULL, 'OFF', 'Without Driver', 2.24107, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '31', '15', '', '', '923017650988', 56, 'Shade No 2'),
(59, 'JZ3987', NULL, 'DEFAULT', NULL, 'JAVEED AJMAIREE', NULL, 'MURGHI', '', 0, 0, 4370, '2024-09-17', '02:08:14', '2024-09-17 02:08:14', NULL, NULL, '2024-09-17', '02:08:14', '2024-09-17 02:08:14', '', '', '', NULL, 'ON', 'Without Driver', 0, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '', '', '', '', '923017650988', 0, 'Shade No 1'),
(60, 'JY9516', NULL, 'DEFAULT', NULL, 'JAHZEEB TND ALLAH YAAR', NULL, 'MURGHI', '', 0, 0, 4470, '2024-09-17', '02:42:21', '2024-09-17 02:42:21', NULL, NULL, '2024-09-17', '02:42:21', '2024-09-17 02:42:21', '', '', '', NULL, 'ON', 'Without Driver', 0, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '', '', '', '', '923017650988', 0, 'Shade No 1'),
(61, 'LA3877', NULL, 'DEFAULT', NULL, 'AMEEN BAROHI', NULL, 'MURGHI', '', 0, 0, 995, '2024-09-17', '03:52:07', '2024-09-17 03:52:07', NULL, NULL, '2024-09-17', '03:52:07', '2024-09-17 03:52:07', '', '', '', NULL, 'ON', 'Without Driver', 0, 'Admin', 1, 'ABDULLAH POULTRY FARM', 'TANDO SOOMRO CHACHAR BOUNDRI PH: 0335-2692501', '', '', '', '', '923017650988', 0, 'Shade No 1');

-- --------------------------------------------------------

--
-- Table structure for table `weightdata1`
--

CREATE TABLE `weightdata1` (
  `srno` int(23) NOT NULL,
  `vno` varchar(50) NOT NULL,
  `vtype` int(23) DEFAULT NULL,
  `vehicle_name` varchar(50) DEFAULT NULL,
  `party_id` int(23) DEFAULT NULL,
  `party_name` varchar(100) DEFAULT NULL,
  `material_id` int(23) DEFAULT NULL,
  `material_name` varchar(50) DEFAULT NULL,
  `container` varchar(50) DEFAULT NULL,
  `qty` int(10) NOT NULL DEFAULT 0,
  `charges` int(10) NOT NULL,
  `fwet` int(6) NOT NULL DEFAULT 0,
  `fdate` date NOT NULL,
  `ftime` time NOT NULL,
  `fdatetime` datetime NOT NULL,
  `swet` int(6) DEFAULT NULL,
  `nwet` int(6) DEFAULT NULL,
  `sdate` date DEFAULT NULL,
  `stime` time DEFAULT NULL,
  `sdatetime` datetime DEFAULT NULL,
  `munds` char(10) NOT NULL DEFAULT '',
  `munds2` char(10) NOT NULL DEFAULT '',
  `shift` varchar(20) DEFAULT NULL,
  `shift2` varchar(20) DEFAULT NULL,
  `status` enum('ON','OFF') DEFAULT 'ON',
  `driver` varchar(50) NOT NULL,
  `avg` float DEFAULT 0,
  `operator` varchar(50) NOT NULL,
  `client_id` int(1) NOT NULL DEFAULT 1,
  `client_name` varchar(100) DEFAULT NULL,
  `client_add` varchar(200) DEFAULT NULL,
  `MundsValue` char(200) NOT NULL DEFAULT '',
  `KgValue` char(200) NOT NULL DEFAULT '',
  `Narration` char(150) NOT NULL DEFAULT '',
  `Station` char(100) NOT NULL DEFAULT '',
  `whatsapp_no` char(20) NOT NULL DEFAULT '',
  `carrat_qty` int(10) NOT NULL DEFAULT 0,
  `shade_no` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_ledger`
--
ALTER TABLE `account_ledger`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_username_unique` (`username`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `cash_book`
--
ALTER TABLE `cash_book`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chick_invoices`
--
ALTER TABLE `chick_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expensecategories`
--
ALTER TABLE `expensecategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `feed_invoices`
--
ALTER TABLE `feed_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flocks`
--
ALTER TABLE `flocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_categories`
--
ALTER TABLE `general_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medicine_invoices`
--
ALTER TABLE `medicine_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mortality`
--
ALTER TABLE `mortality`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `murghi_invoices`
--
ALTER TABLE `murghi_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `other_invoices`
--
ALTER TABLE `other_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payment_book`
--
ALTER TABLE `payment_book`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permission_types`
--
ALTER TABLE `permission_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `shades`
--
ALTER TABLE `shades`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `weightdata`
--
ALTER TABLE `weightdata`
  ADD PRIMARY KEY (`srno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `account_ledger`
--
ALTER TABLE `account_ledger`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `account_types`
--
ALTER TABLE `account_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1413;

--
-- AUTO_INCREMENT for table `cash_book`
--
ALTER TABLE `cash_book`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `chick_invoices`
--
ALTER TABLE `chick_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expensecategories`
--
ALTER TABLE `expensecategories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feed_invoices`
--
ALTER TABLE `feed_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `flocks`
--
ALTER TABLE `flocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `general_categories`
--
ALTER TABLE `general_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `medicine_invoices`
--
ALTER TABLE `medicine_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `mortality`
--
ALTER TABLE `mortality`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `murghi_invoices`
--
ALTER TABLE `murghi_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `other_invoices`
--
ALTER TABLE `other_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_book`
--
ALTER TABLE `payment_book`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permission_types`
--
ALTER TABLE `permission_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shades`
--
ALTER TABLE `shades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weightdata`
--
ALTER TABLE `weightdata`
  MODIFY `srno` int(23) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
