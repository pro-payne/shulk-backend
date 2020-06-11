-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 11, 2020 at 06:46 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shulk_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `street` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `town` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `street`, `address2`, `town`, `zip_code`, `customer_id`, `created_at`, `updated_at`) VALUES
(2, '4758 Polar Park', 'Dimbaza', 'Alice', '5671', 24, '2019-10-23 00:35:38', '2019-10-23 00:35:38'),
(3, '4758 Polar Park', 'Dimbaza', 'Alice', '5671', 18, '2019-10-31 10:12:08', '2019-10-31 10:12:08'),
(4, '4758 Polar Park', 'Dimbaza', 'Alice', '5693', 24, '2019-10-31 10:32:04', '2019-10-31 10:32:04'),
(5, '4758 Polar Park', 'Dimbaza', 'Alice', '5645', 25, '2019-11-03 21:57:25', '2019-11-03 21:57:25'),
(7, 'Mat021', 'Dimbaza', 'Alice', '5671', 27, '2019-11-04 16:05:37', '2019-11-04 16:05:37'),
(8, 'Kuhle Street', 'Dimbaza', 'Alice', '5671', 27, '2019-11-04 17:53:46', '2019-11-04 17:53:46'),
(9, '4758 Polar Park', '', 'Alice', '5671', 4, '2019-11-21 21:49:05', '2019-11-21 21:49:05'),
(10, '4758 Polar Park', 'Dimbaza', 'Alice', '5617', 20, '2019-11-29 20:38:22', '2019-11-29 20:38:22'),
(11, 'Mat 1021', 'Dimbaza', 'King William\'s Town', '5200', 20, '2019-11-29 20:53:37', '2019-12-02 09:56:23');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `first_name`, `last_name`, `username`, `email`, `number`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Kuhle', 'Hanisi', 'kuhle-hanisi', 'hanisi@gmail.com', '0781361395', NULL, '$2y$10$vCmuLPBRE85rSObss9hV..Z.0974hVnP1j6mv4z8YGVi6O2IVZrh2', NULL, '2019-11-16 15:45:22', '2019-12-12 19:12:10');

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `holder` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cvv` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_date` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `customer_id`, `holder`, `number`, `cvv`, `expiry_date`, `created_at`, `updated_at`) VALUES
(1, 18, 'Kuhle Hanisi', '5214 1548 654633 778', '123', '15/25', '2019-11-03 23:29:32', '2019-11-03 23:29:32'),
(2, 27, 'Kuhle Hanisi', '5245 3135 4987 9798`', '123', '05/25', '2019-11-04 20:12:29', '2019-11-04 20:12:29'),
(3, 27, 'Kuhle Hanisi', '5245 6491 8918 5662', '123', '12/25', '2019-11-04 20:46:41', '2019-11-04 20:46:41'),
(4, 20, 'Kuhle Hanisi', '5214 1548 654633 778', '123', '15/25', '2019-12-02 13:55:29', '2019-12-02 13:55:29');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `customer_id`, `product_id`, `quantity`, `note`, `created_at`, `updated_at`) VALUES
(1, 4, 37, 2, 'test', '2019-11-20 21:16:07', '2019-11-20 21:16:26'),
(10, 20, 45, 1, '', '2019-12-10 20:45:20', '2019-12-10 20:45:20'),
(11, 20, 37, 1, '', '2019-12-10 21:13:27', '2019-12-10 21:13:27'),
(12, 20, 44, 1, '', '2019-12-10 21:13:28', '2019-12-10 21:13:28');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `picture` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `picture`, `created_at`, `updated_at`) VALUES
(1, 'Supermarket', 'https://lorempixel.com/300/300/?43873', '2019-09-05 13:47:13', '2019-09-05 13:47:13'),
(2, 'Butcher', 'https://lorempixel.com/300/300/?21240', '2019-09-05 13:47:14', '2019-09-05 13:47:14'),
(3, 'Clothing Store', 'https://lorempixel.com/300/300/?88003', '2019-09-05 13:47:14', '2019-09-05 13:47:14'),
(4, 'Flea Market', 'https://lorempixel.com/300/300/?81077', '2019-09-05 13:47:14', '2019-09-05 13:47:14'),
(5, 'Music Store', 'https://lorempixel.com/300/300/?30832', '2019-09-05 13:47:14', '2019-09-05 13:47:14'),
(6, 'Pharmacy', 'https://lorempixel.com/300/300/?77183', '2019-09-05 13:47:14', '2019-09-05 13:47:14'),
(7, 'Retail Store', 'https://lorempixel.com/300/300/?28297', '2019-09-05 13:47:14', '2019-09-05 13:47:14'),
(8, 'Book Store', 'https://lorempixel.com/300/300/?99013', '2019-09-05 13:47:14', '2019-09-05 13:47:14'),
(9, 'Movies Store', NULL, '2019-11-06 23:54:51', '2019-11-06 23:54:51');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT '0',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `first_name`, `last_name`, `username`, `email`, `number`, `verified`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Soledad', 'Lemke', 'eaque', 'kay@gmail.com', '1-634-555-5774', 0, '2019-10-15 20:53:44', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2019-10-15 20:53:44', '2019-10-15 20:53:44'),
(2, 'Hank', 'Boyle', 'impedit', 'strosin.gerson@example.com', '436.935.8416 x859', 0, '2019-10-15 20:53:44', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2019-10-15 20:53:44', '2019-10-15 20:53:44'),
(3, 'Eloy', 'Hoeger', 'aut', 'jspencer@example.net', '776.579.8268 x9890', 0, '2019-10-15 20:53:44', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2019-10-15 20:53:44', '2019-10-15 20:53:44'),
(4, 'Jazlyn', 'Rosenbaum', 'voluptatibus', 'daisy.hoppe@example.org', '1-959-559-6273', 0, '2019-10-15 20:53:44', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2019-10-15 20:53:44', '2019-10-15 20:53:44'),
(5, 'Annamarie', 'Powlowski', 'in', 'golden63@example.com', '774-307-4121', 0, '2019-10-15 20:53:44', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2019-10-15 20:53:44', '2019-10-15 20:53:44'),
(18, 'Kuhle', 'Hanisi', 'kuhlehanisi', 'hanisi@gmail.com', '0781361395', 0, NULL, '$2y$10$AKQZB0By7mx7lm.OwVPrveE2TZJgnlwLD2IWTk4URck0mLvL1bD4.', NULL, '2019-10-19 09:10:38', '2019-10-19 09:10:38'),
(20, 'Kuhle', 'Hanisi', 'kuhle-hanisi', '201414798@ufh.ac.za', '0781333656', 0, NULL, '$2y$10$Zw0q0d4n6v7.JEX7bUBy/On8SWpIejqIplEwY.YfyqLsIw8pCJdim', NULL, '2019-10-20 16:14:32', '2019-11-29 18:44:15'),
(21, 'tau', 'jaho', 'taujaho', 'taugcanga@gmail.com', '0671347002', 0, NULL, '$2y$10$Q7ob2QSLmuKZDEyZmIwzQutM9EMXyV15UX.hyiIloYH1z7rLm8Bwq', NULL, '2019-10-20 19:15:52', '2019-10-20 19:15:52'),
(24, 'Kuhle', 'Hanisi', 'kuhlehanisi', 'manisikuhle@gmail.com', '0781361395', 0, NULL, '$2y$10$3Z0C7AuXuhk1Hal7oTmEeOmZ2sWZTFsPTUiCauHxbUDtSXmbGtwE.', NULL, '2019-10-23 00:35:35', '2019-10-23 00:35:35'),
(25, 'Kuhle', 'Hanisi', 'kuhlehanisi', 'kanisikuhle@gmail.com', '0781361395', 0, NULL, '$2y$10$COkLJzj8gj8PUU.Tknn.d.k32tgX3MjK6AvrUjYTZC4oGTolBqob6', NULL, '2019-11-03 21:57:24', '2019-11-03 21:57:24'),
(27, 'Sakhi', 'Hanisi', 'sakhihanisi', 'kuhle@gmail.com', '0781361395', 0, NULL, '$2y$10$aV8UX4dlsD9N14dOQNJLauvF2.dlgy5LRRDBHaHm9GvV80vLixpjm', NULL, '2019-11-04 16:05:35', '2019-11-04 16:05:35');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `customer_id`, `product_id`, `created_at`, `updated_at`) VALUES
(1, 1, 37, '2020-02-26 13:30:39', '2020-02-26 13:30:39');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(17, '2014_10_12_100000_create_password_resets_table', 1),
(18, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(19, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(20, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(21, '2016_06_01_000004_create_oauth_clients_table', 1),
(22, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(23, '2019_08_20_205032_create_customers_table', 1),
(24, '2019_08_20_205099_create_categories_table', 1),
(25, '2019_08_20_205100_create_sub_categories_table', 1),
(26, '2019_08_20_205342_create_shops_table', 1),
(27, '2019_08_20_205637_create_addresses_table', 1),
(28, '2019_08_20_210546_create_roles_table', 1),
(30, '2019_08_20_212015_create_products_table', 1),
(32, '2019_08_20_212140_create_admins_table', 1),
(36, '2019_10_15_193910_create_carts_table', 2),
(37, '2019_10_16_120104_create_favorites_table', 3),
(38, '2019_08_20_210547_create_shop_managers_table', 4),
(40, '2019_11_04_011429_cards', 6),
(41, '2019_08_20_212016_create_orders_table', 7),
(43, '2019_11_07_022814_create_subcategory_products_table', 8),
(44, '2019_11_15_061340_create_partners_table', 9),
(45, '2019_11_15_164934_create_notifications_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender` bigint(20) NOT NULL,
  `receiver` bigint(20) NOT NULL,
  `message_group` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unread',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('00884dea805324420f583c5852ea80c8f4693a68a6f95022a80c0c7a394bd33a1ee84043c74da2ba', 20, 1, 'Personal Access Token', '[]', 1, '2019-10-22 11:11:22', '2019-10-22 11:11:22', '2019-10-29 13:11:23'),
('00ac0c313597c9751eb58e73a49f2847f20295a820d0a3f242179f9fcdcf54afd1a523241de7d57f', 26, 1, 'Personal Access Token', '[]', 1, '2019-11-04 15:52:39', '2019-11-04 15:52:39', '2019-11-11 17:52:40'),
('051ab76310a85fe22fb6a6898e2e08906ba2d48ce99b06e694814350d61d0c42d3fda01b8b1719a7', 1, 1, 'Personal Access Token', '[]', 0, '2019-12-12 18:59:37', '2019-12-12 18:59:37', '2019-12-19 20:59:38'),
('0846e51d37b79c6a3a8e407c18cc88dee281d518d83f33132c7b5aa76e92910ec0a3ecc4a19afbf2', 21, 1, 'Personal Access Token', '[]', 0, '2019-10-20 19:15:53', '2019-10-20 19:15:53', '2019-10-27 21:15:53'),
('0f38883ad987d3ca87a46a8b09b8c7cf95665d048a2f04c954ac3d210ec91c099b6da500073a2b6e', 20, 1, 'Personal Access Token', '[]', 1, '2019-12-14 11:48:11', '2019-12-14 11:48:11', '2019-12-21 13:48:11'),
('11518859f5a23e9a7d47766bccf108a8e65c877f6e7848c5bb3f6fc4720a83afd64baf0359cac6f4', 20, 1, 'Personal Access Token', '[]', 0, '2019-12-10 11:04:59', '2019-12-10 11:04:59', '2019-12-17 13:05:00'),
('1413667a1860e8a771998697c2db762eabec2f9e3d0b8848d6d36fe331711ec3cfb72cc894b047f7', 11, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:22:58', '2019-10-18 09:22:58', '2019-10-25 11:22:59'),
('16006e95ba928c48b17e359feae62a89919406d53e3dc4a6982fe0bfcdf00e808e7eea193ca08184', 12, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:25:43', '2019-10-18 09:25:43', '2019-10-25 11:25:44'),
('17674e5557c61e442166378f86e3dbaecc00573ccfb1954a8d01cc5bf55c3bf921c83d712283e285', 4, 1, 'Personal Access Token', '[]', 1, '2019-11-29 00:02:46', '2019-11-29 00:02:46', '2019-12-06 02:02:47'),
('208d993165735334f69239684c82b6e7b253b97bc475fc3ad7a247c65a3813d484f325d98e5709f6', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-19 09:22:51', '2019-10-19 09:22:51', '2019-10-26 11:22:51'),
('21376458d4878c6d8253d3bc33e20c3a6801f68f0606b4855cbadbbe2c68de09d3fc3027f5e0749e', 22, 1, 'Personal Access Token', '[]', 0, '2019-10-22 23:49:54', '2019-10-22 23:49:54', '2019-10-30 01:49:56'),
('26285f9a15aa0bbf7f5798775e9d593e81ce2c47c0f59423991424c12023a9f831b01587bbf30890', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-20 16:17:18', '2019-10-20 16:17:18', '2019-10-27 18:17:19'),
('28e8849fca399cf19bd8f8d47d815a5511c642cf670eb8ce957613b0681923340bf040790d661003', 12, 1, 'Personal Access Token', '[]', 1, '2019-10-18 10:17:02', '2019-10-18 10:17:02', '2019-10-25 12:17:03'),
('2b17c51d415407eea66e36d11119baa0682e6c92cc354d97759c03afa5d74f4df3e3937ab7323153', 27, 1, 'Personal Access Token', '[]', 1, '2019-11-04 16:05:36', '2019-11-04 16:05:36', '2019-11-11 18:05:37'),
('2bb2bba7e8307456a02da640074fed653e3b34c636f1b921fc92a019686ce8acfc768e2b7179048f', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-19 09:17:16', '2019-10-19 09:17:16', '2019-10-26 11:17:18'),
('2c54e33f3ba9a255947231dc02664ee5fbf782e99db793524dc1cfccd7345f52093a54557bf53a7c', 2, 1, 'Personal Access Token', '[]', 0, '2019-10-19 09:47:09', '2019-10-19 09:47:09', '2019-10-26 11:47:10'),
('2e82af25417acad56030c81b30cecd9c683fe4cff8b241276197b06c7b8237e2dc2e1557334666a3', 1, 1, 'Personal Access Token', '[]', 1, '2019-12-12 20:37:15', '2019-12-12 20:37:15', '2019-12-19 22:37:15'),
('332fafcb5bfa64c863c7b41264db7a9b77c7c300c759c98d36687dc28dee7c0036eefc57eda1d014', 9, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:14:42', '2019-10-18 09:14:42', '2020-10-18 11:14:42'),
('35e513632e45b7123aac1678acc4eb265857667222d6f5389c6101119f27b6132c06a3bfa7ad385b', 2, 1, 'Personal Access Token', '[]', 0, '2019-10-19 12:03:09', '2019-10-19 12:03:09', '2019-10-26 14:03:09'),
('37f6946f7ad0153cda7671f9fe1720e09c629c7d1cb20f7e5218ed0539cb231eb6dd8900c35af031', 4, 1, 'Personal Access Token', '[]', 1, '2019-12-05 14:29:02', '2019-12-05 14:29:02', '2019-12-12 16:29:03'),
('37f8a287cc73dc97b6c8e841e34b00365f0fc03141e371a2b7fd773a8a992a99e2cf623b3189bc76', 10, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:21:19', '2019-10-18 09:21:19', '2019-10-25 11:21:19'),
('3c86ba1290a1dd133bc28e8aa424ef71352318474c2684ee77b69ab7922e96321736d0374dd58a65', 20, 1, 'Personal Access Token', '[]', 1, '2019-10-22 18:37:46', '2019-10-22 18:37:46', '2019-10-29 20:37:46'),
('3e28979546fc591089fcd3646f99e8cfafa3c2e7cefabe6ce33aace39b3ddd5c211fa1b6a0ee5201', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-22 09:50:05', '2019-10-22 09:50:05', '2019-10-29 11:50:06'),
('4358fdf7bd1e33d589129b583382a8acc0919f9a1faec6823ac3fcdb9c7a32b6883db27f379fc09e', 20, 1, 'Personal Access Token', '[]', 1, '2019-11-05 20:57:54', '2019-11-05 20:57:54', '2019-11-12 22:57:56'),
('43a37515319cb0fee4debdd65dee001c7ce0f8d846a3b723b4a1e8ab39c43966b5d0fc87fe12f331', 18, 1, 'Personal Access Token', '[]', 0, '2019-11-29 18:22:38', '2019-11-29 18:22:38', '2019-12-06 20:22:39'),
('4611f959fe36397989153cfbc45d63df282eb2391edc005dd84844dce99005f0908b369a88575597', 7, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:11:31', '2019-10-18 09:11:31', '2019-10-25 11:11:31'),
('470deb6461ab015bdbafcb6cb6532b794957f5e7c2315ef3ef8dacbca31609e7def5e42c0bb048b7', 4, 1, 'Personal Access Token', '[]', 1, '2019-11-24 18:05:47', '2019-11-24 18:05:47', '2019-12-01 20:05:47'),
('4bd6e5e38ba2cae074122be88c16908adcb09835493f68a18acc9568ad4809f49eb294a9fac2401f', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-20 18:24:12', '2019-10-20 18:24:12', '2019-10-27 20:24:12'),
('51ca1f98d9fe9542ef80fd9dafff098560e63882c076614cebb2fc5cdc4d75584870d1ea427f2a78', 4, 1, 'Personal Access Token', '[]', 1, '2019-11-29 00:10:40', '2019-11-29 00:10:40', '2019-12-06 02:10:41'),
('53957033954321a38c626f45d3c9c2336fbc13246eb88f7565a5526eb1442623d6451de70a7e165b', 4, 1, 'Personal Access Token', '[]', 1, '2019-11-18 15:03:47', '2019-11-18 15:03:47', '2019-11-25 17:03:50'),
('54ad48f5e887493d8482423cf87e49e1909b7deffddd6b388fcc233a4ef02be405640eefe33efb7a', 25, 1, 'Personal Access Token', '[]', 0, '2019-11-03 21:57:25', '2019-11-03 21:57:25', '2019-11-10 23:57:25'),
('5756d8618302e70b32bc05673ea51331f45f4c5acdc7569cb5da1d8530e2f8b82e1f6ca12c274061', 1, 2, NULL, '[]', 0, '2019-10-16 14:39:01', '2019-10-16 14:39:01', '2020-10-16 16:39:01'),
('5a74929994a0b08ffd951783a9d22c7eb8f08d67e058dd79b718d2162ea04ca779b3f1589337afed', 20, 1, 'Personal Access Token', '[]', 1, '2019-10-22 18:50:32', '2019-10-22 18:50:32', '2019-10-29 20:50:33'),
('5d8960546a74fb303fa87fe4ba8198efbc21867e2252a160c19691612e1ecd32d967ba55f68e18d1', 20, 1, 'Personal Access Token', '[]', 1, '2019-12-05 14:33:28', '2019-12-05 14:33:28', '2019-12-12 16:33:29'),
('5f49b203f0cb638b8221e9475663ee2efb42f0d6e4e068170c8c906db89d076b7f8cbfedecb83572', 20, 1, 'Personal Access Token', '[]', 1, '2019-11-29 00:34:44', '2019-11-29 00:34:44', '2019-12-06 02:34:44'),
('5f733c0dc5bf4b9199316c4e88ce929fa10ec83bc2886d82ba435a1437a085662ec614965977634f', 4, 1, 'Personal Access Token', '[]', 1, '2019-11-29 00:54:21', '2019-11-29 00:54:21', '2019-12-06 02:54:21'),
('65d64ce1f0ba7532070b19077979a8f9f3a0ac8e3eb14b9c9afeeb44fb1c6d9414959f8b1091e2f8', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-17 22:47:24', '2019-11-17 22:47:24', '2019-11-25 00:47:24'),
('681c603154385c867528c738ecb5a61a329aa9600493dbc91b28f7fa77e06549d38be50b245c4ea6', 12, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:40:57', '2019-10-18 09:40:57', '2019-10-25 11:40:58'),
('68f23405c8e54f8a281698991b422df2e52ac5a802d8b763d1028189dbedccb3861bd6c5d5b872bf', 18, 1, 'Personal Access Token', '[]', 1, '2019-10-22 12:17:24', '2019-10-22 12:17:24', '2019-10-29 14:17:25'),
('6c1a3c3029779afb5737ccfbf1848af0137c138ad7170853c0dc1cd207c139774de39f9db5e228c1', 20, 1, 'Personal Access Token', '[]', 0, '2019-12-14 12:06:20', '2019-12-14 12:06:20', '2019-12-21 14:06:21'),
('732a10da86717b0bb638a701112ec7101d99ecf0faa251c2382a150079d62a06ae1713ed761e2f7a', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-24 18:09:41', '2019-11-24 18:09:41', '2019-12-01 20:09:41'),
('74c118ddf82c1a433d86c9793c0d2a3ec3954edf0909acbf1f9aaff7ad62244f60be343334e5797c', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-31 10:06:54', '2019-10-31 10:06:54', '2019-11-07 12:06:54'),
('778dca9e93fe4a41eda020fb8c226c880ad59de953ab2bd164c6e9f262481d2feafac80e82ea5306', 1, 1, 'Personal Access Token', '[]', 1, '2019-12-12 18:00:54', '2019-12-12 18:00:54', '2019-12-19 20:00:55'),
('77cd3ca8c4b3ca1b061b1721004d49abfaf31ae38f913e3b03d54e951b60fd953aac2c393d8b24fd', 20, 1, 'Personal Access Token', '[]', 1, '2019-11-29 16:19:50', '2019-11-29 16:19:50', '2019-12-06 18:19:50'),
('7851c7de3eaf01cd1698c654ad283cd7d9518fec1ab755b1d4b2ed2fda7caedd6a0db5e1e204f3cc', 4, 1, 'Personal Access Token', '[]', 1, '2019-12-02 12:35:29', '2019-12-02 12:35:29', '2019-12-09 14:35:30'),
('7f507427cf1a4438aa8137adadfca6ca5828a79a65f5e40b37d70afb1cb5b887ba91b6dd8bf357fb', 1, 1, 'Personal Access Token', '[]', 0, '2019-11-16 16:03:21', '2019-11-16 16:03:21', '2019-11-23 18:03:22'),
('7f533cc42df7b3e8fbdd025f26db09cd7572e5a6f80a38bc27f03eafcafd4a4f04af487be6032f10', 4, 1, 'Personal Access Token', '[]', 1, '2019-12-02 12:21:11', '2019-12-02 12:21:11', '2019-12-09 14:21:12'),
('84cf1b034010d574af07a64993e92fea6f4e6753ff83f657a8d5b3e93c397930111c6d2d4e997573', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-20 16:12:35', '2019-10-20 16:12:35', '2019-10-27 18:12:36'),
('8505cec49ca2cb0e2202ee9974cb3acd6dedadd70b7b67baa462b3705a0c246aed3e6ba5373bb4d9', 1, 1, 'Personal Access Token', '[]', 0, '2019-12-14 12:01:38', '2019-12-14 12:01:38', '2019-12-21 14:01:38'),
('85eaf493e953dc0e705d7860958f7826c22eeb26981dfc6442caae09ae5e55772c120ebeb8c28d76', 20, 1, 'Personal Access Token', '[]', 1, '2019-10-22 18:10:12', '2019-10-22 18:10:12', '2019-10-29 20:10:13'),
('8788933d0d77d7eac561fa8694bba316399a186cae2290c8e92c2b2207cf70aa6d7df20a892daa30', 20, 1, 'Personal Access Token', '[]', 1, '2019-11-05 22:47:23', '2019-11-05 22:47:23', '2019-11-13 00:47:25'),
('88b05d0e3a32b6c0552b8ca1618b7a0a1f4011fbd28d98ae008701ce5ad081a540b3368d241cadb0', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-31 10:08:35', '2019-10-31 10:08:35', '2019-11-07 12:08:35'),
('897e404be59457e4e02015927909b877fbdeaa332285ef49eeac5c7944da665aec8f06de0702db2d', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-24 18:09:07', '2019-11-24 18:09:07', '2019-12-01 20:09:07'),
('8998d65bd7f6b38338d083af9c816b66d2be677508716c0fc546ff4c1ca1a2903fec458cca7afa7c', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-20 20:18:48', '2019-10-20 20:18:48', '2019-10-27 22:18:49'),
('8d11a84c98753f0c1e715da6f95139627c16c5a2c2c3a7d37129011de0d23931e3496b493d8fe717', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-19 12:03:56', '2019-10-19 12:03:56', '2019-10-26 14:03:56'),
('8dc77d61271c91bec1dc4b6a78c1a6c29341ebcf9b0a8324ad67dad8c9b05f6d126dbacb9d3c47e8', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-20 18:27:53', '2019-10-20 18:27:53', '2019-10-27 20:27:53'),
('8deebfe2f8387729d6ae0042880e10603dd82131cab66285c5e82bfe80848d780f7d167d4f8b8e26', 12, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:51:05', '2019-10-18 09:51:05', '2019-10-25 11:51:05'),
('8feabbb13b9d4606984bbe756679f5acef62f4ee584eb531975d1ff5a91c9cd184c6020c2b0b0c54', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-18 17:08:17', '2019-11-18 17:08:17', '2019-11-25 19:08:19'),
('93e3606464a8ccc8bcdc57e05d58fe67686f964d6e95fb6b298b50f7171121342909acedd1f3dbb5', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-20 20:20:21', '2019-10-20 20:20:21', '2019-10-27 22:20:21'),
('95c5496146d8aab27a77ecc2d217e9a17b2a707600644039a62468fc645cc24c4c8310b9cda230ee', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-20 16:14:32', '2019-10-20 16:14:32', '2019-10-27 18:14:33'),
('9b06fdb63d2bb431c94ac7ed7fda93b017f391f10d066efa5c9aa5a2bc334499882bcfb175a86892', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-17 22:42:28', '2019-11-17 22:42:28', '2019-11-25 00:42:29'),
('a84ebd9a57ec8bbb36a5af68cc72232182544246fc241b3b73b56132f1973280b548ddc9d5340a2f', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-24 18:06:57', '2019-11-24 18:06:57', '2019-12-01 20:06:58'),
('b736ee53943359254bdb22c2c947d171572e230e24fa9959a758df8a242203038a0b08605e1377d2', 20, 1, 'Personal Access Token', '[]', 0, '2019-12-02 09:12:56', '2019-12-02 09:12:56', '2019-12-09 11:12:57'),
('b866f6671509aa9c0ffe112daa0910b343390354d8dbf03e4d53fd8b174e21d6f5987bae483d7279', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-22 18:22:43', '2019-10-22 18:22:43', '2019-10-29 20:22:44'),
('b91c2c49dc2673b1f4e8c49ffefae19c7df5d2cfd6188557054c4f3df5153d2df1564634bbc35501', 19, 1, 'Personal Access Token', '[]', 0, '2019-10-19 19:47:32', '2019-10-19 19:47:32', '2019-10-26 21:47:34'),
('bf38ac285e3461d4d616d29d45a57b57a577d534812ade4c87594cb02f223b07e08d6bc4f6df095b', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-29 10:02:13', '2019-11-29 10:02:13', '2019-12-06 12:02:14'),
('c32df26b5a95927ea3c2b4ddb80f03ed77cbb2f104d58f32ca8cfab97d19495c62ec30b648607f75', 4, 1, 'Personal Access Token', '[]', 1, '2019-11-24 18:13:57', '2019-11-24 18:13:57', '2019-12-01 20:13:57'),
('c5a24686433c0371ce1fce75240b50a84af96b94687684fe50be2456d9a4d4fb916e072b57a7fe97', 6, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:03:24', '2019-10-18 09:03:24', '2019-10-25 11:03:26'),
('c7e86c131caae478bcd4036b75cb5223b1e6aec16d99f1bebe8b10d0d1a45f30f88a1c5fdb34217d', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-22 10:37:02', '2019-10-22 10:37:02', '2019-10-29 12:37:03'),
('c845d336a1e94a64762bd1abaca5a7363fdc23f85e0a60dee26620e2391eeac3629da8ffa2b71081', 20, 1, 'Personal Access Token', '[]', 1, '2019-12-02 12:31:03', '2019-12-02 12:31:03', '2019-12-09 14:31:04'),
('cafbb791d77bfdc3ca3c2e414bb046f5b3f57178cdb49eaefff46ea1f3ca22686dd6338a840e09de', 24, 1, 'Personal Access Token', '[]', 1, '2019-10-23 00:35:37', '2019-10-23 00:35:37', '2019-10-30 02:35:38'),
('d1316b7a3cbed1c805044d2cd2bb7ef967910fa20de77ae2a2018e8f572fbc7244c709fb72e643cc', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-18 09:43:00', '2019-11-18 09:43:00', '2019-11-25 11:43:01'),
('d1be5e0e2454e69f925d74edcaf1be56cba2dbcddf6c925eb22e721e29e4c994ae9f67b970a8582c', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-20 16:06:42', '2019-10-20 16:06:42', '2019-10-27 18:06:44'),
('d674b5e3920ecd6ac15273f2245fbe1d98e6f14aec147508ec8f4cf3b7d6e8b85e0b1d0692f97c4a', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-17 22:41:40', '2019-11-17 22:41:40', '2019-11-25 00:41:42'),
('d7d6754bef9d1497db183a1dfca1d8976e15fa821e676ce88da1e17b40af2e982562adb5620bab62', 20, 1, 'Personal Access Token', '[]', 0, '2019-10-20 20:25:40', '2019-10-20 20:25:40', '2019-10-27 22:25:40'),
('dbfeaec9cab3e87b8e3fa678641eaf21fc8d84d6a518e59d0432dcc3ed72a3357d4c2dde6ffc7c5b', 20, 1, 'Personal Access Token', '[]', 1, '2019-12-02 12:40:12', '2019-12-02 12:40:12', '2019-12-09 14:40:12'),
('dc98b8381ac5dde5db205d76afb6064da2497db573f0eb388b489acf4d6e91ef6be8a0de93556525', 4, 1, 'Personal Access Token', '[]', 1, '2019-11-29 00:45:13', '2019-11-29 00:45:13', '2019-12-06 02:45:14'),
('dd304611f60511cb0bc73ed8e934acf133f5f9157deda2b955d6d872f1ee3713caf55866e9f177cd', 20, 1, 'Personal Access Token', '[]', 1, '2019-11-15 00:58:20', '2019-11-15 00:58:20', '2019-11-22 02:58:21'),
('e07f2b2edf88fe8cc4238467b8b65b021a239e5db55e842aed67732b5caf1131c9cd58bc3104c16f', 12, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:50:15', '2019-10-18 09:50:15', '2019-10-25 11:50:16'),
('e4f4ba7f7a9eb133dd2a6d2699baccc6b9ad38c69e62bca49662c67623adbdcc8bb71e2ce8e6db8b', 20, 1, 'Personal Access Token', '[]', 1, '2019-10-22 18:30:23', '2019-10-22 18:30:23', '2019-10-29 20:30:24'),
('e50abf4a009eb491713bb906dd40de3bc75e71b51459588cae56da5e45ab2ba04e6a18e591210192', 23, 1, 'Personal Access Token', '[]', 0, '2019-10-22 23:51:15', '2019-10-22 23:51:15', '2019-10-30 01:51:16'),
('e9c08f750bd7108b9a13c3ed23db253c74e68a996f772b4915b82812bf3639d5f2b63f4e5311d523', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-24 18:06:30', '2019-11-24 18:06:30', '2019-12-01 20:06:30'),
('eb955382b4a070eb7717697efdc4942ce6985bedaa46396af962d634ff0b2a30a74c379df36c764f', 1, 1, 'Personal Access Token', '[]', 1, '2019-12-12 18:27:25', '2019-12-12 18:27:25', '2019-12-19 20:27:26'),
('f3ca8d7bb4a893883568d30a20ba9f792d142d6d15b4d549d3ecbe655fa55fb4e8dd59ec15855010', 18, 1, 'Personal Access Token', '[]', 0, '2019-10-20 16:10:16', '2019-10-20 16:10:16', '2019-10-27 18:10:16'),
('f9dee68d96b0a648e0d39e6593bca62ef668cf732069fab5f45f8f4b627e13c25820f60df5e9d631', 20, 1, 'Personal Access Token', '[]', 0, '2019-11-05 15:20:54', '2019-11-05 15:20:54', '2019-11-12 17:20:56'),
('fb08ec8da2b43acbe263c4d63f543ec7bc37b44734ce2bb961e0cf316938b8e96a2a667b9e9a2d89', 4, 1, 'Personal Access Token', '[]', 0, '2019-11-24 18:12:53', '2019-11-24 18:12:53', '2019-12-01 20:12:53'),
('fe6073f14b90caa97b97adda838d6677eb030044fa18013cd7da58106b8a1292fc4f3a090ef642d5', 8, 1, 'Personal Access Token', '[]', 0, '2019-10-18 09:13:40', '2019-10-18 09:13:40', '2019-10-25 11:13:40');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Shulk Personal Access Client', '4wd93WgCE3O2HDmbt3Wxx4fB5A4AaALJbTEY9jwx', 'http://localhost', 1, 0, 0, '2019-10-16 14:22:21', '2019-10-16 14:22:21'),
(2, NULL, 'Shulk Password Grant Client', 'wLr6M9fd3lQhUzlv3hqQfZdx3alXHNvTiV26mKtN', 'http://localhost', 0, 1, 0, '2019-10-16 14:22:21', '2019-10-16 14:22:21');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-10-16 14:22:21', '2019-10-16 14:22:21');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
('96adab7525a6561ee7bbacc51ce6a71fe53d7cbdc8d3f065700a5922b9a71669644a5fb34e63936c', '5756d8618302e70b32bc05673ea51331f45f4c5acdc7569cb5da1d8530e2f8b82e1f6ca12c274061', 0, '2020-10-16 16:39:01');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `address_id` bigint(20) UNSIGNED NOT NULL,
  `order_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `reference`, `customer_id`, `address_id`, `order_data`, `order_status`, `created_at`) VALUES
(3, '', 27, 8, '{\"delivery_address\":{\"street\":\"Kuhle Street\",\"address2\":\"Dimbaza\",\"city\":\"Alice\",\"zip\":\"5671\"},\"products\":[{\"product\":10,\"quantity\":2,\"note\":\"\"}]}', 'canceled', '2019-12-18 15:40:01'),
(4, '', 20, 10, '{\"delivery_address\":{\"street\":\"4758 Polar Park\",\"address2\":\"Dimbaza\",\"city\":\"Alice\",\"zip\":\"5617\"},\"products\":[{\"product\":37,\"quantity\":3,\"note\":\"test\"}]}', 'processing', '2019-12-18 13:34:06');

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `request_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `request_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `request_token` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `picture` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `brand_name`, `price`, `quantity`, `description`, `picture`, `shop_id`, `sub_category_id`, `created_at`, `updated_at`) VALUES
(1, 'Hintz Inc', NULL, 776, 4, 'Similique aut accusantium id ut quis laboriosam nesciunt. Et error aut itaque qui possimus ut. Veritatis qui amet consectetur labore sequi eum mollitia. Hic maiores ut magnam omnis.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?91390\"]', 4, 13, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(2, 'Becker, Romaguera and Wuckert', NULL, 413, 6, 'Numquam accusantium quia quos vel et enim suscipit. Inventore aut minima ea laudantium quaerat consectetur corrupti molestias. Provident ut enim doloremque ipsam dolore soluta adipisci.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?98456\"]', 4, 3, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(3, 'Rolfson Ltd', NULL, 1661, 5, 'Accusantium voluptatibus nihil sed facilis quibusdam. Perferendis quia repellat deleniti voluptas omnis sunt alias. Reiciendis sed sunt dolor iusto ea.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?53436\"]', 15, 13, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(4, 'Kuhn, Schmitt and Glover', NULL, 885, 4, 'Natus iusto hic fuga quia quia ipsa distinctio. Incidunt cumque amet et dicta veniam eum aut atque. Dolorem enim aut architecto mollitia.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?37093\"]', 18, 12, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(5, 'Senger-Hane', NULL, 1141, 9, 'Et ipsum est animi id. Voluptatem repudiandae dolores consectetur quo at perspiciatis. In debitis eveniet maiores officiis et et. Sed at saepe nemo illo.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?93965\"]', 11, 13, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(6, 'Keeling Group', NULL, 1931, 6, 'Vel facere sed nihil vel. Odio nobis sint corporis placeat velit. Delectus fuga dignissimos delectus commodi sequi.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?39073\"]', 4, 13, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(7, 'Kulas, Prohaska and Morissette', NULL, 1735, 8, 'Aperiam debitis iusto architecto commodi doloribus aut porro. Consectetur aliquid ipsa reprehenderit dicta aut. Quae nihil voluptas velit inventore.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?29508\"]', 3, 9, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(8, 'Labadie-Wiza', NULL, 903, 6, 'Nemo voluptas qui rerum expedita reprehenderit sit modi. Minus aut sit quis at in voluptatem quidem. Error nemo ex corrupti dolores aliquam dolorem. Laudantium repellat assumenda iure dolor magnam ut.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?29851\"]', 15, 7, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(9, 'Bergstrom-Buckridge', NULL, 516, 7, 'Veritatis cupiditate qui dolor ea praesentium possimus. Aut atque non pariatur quam consequuntur.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?98485\"]', 20, 14, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(10, 'Prosacco Ltd', NULL, 1152, 5, 'Non sunt qui eius. Iste quasi corporis enim quidem aperiam praesentium sit. Est iste cumque similique vel cupiditate voluptatem.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?74589\"]', 18, 3, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(11, 'Rippin-Kozey', NULL, 958, 8, 'Quia in atque sit iusto excepturi officia. Et nam ratione aut ad vero debitis reprehenderit. Eos necessitatibus praesentium consequatur voluptas aut at quia.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?10839\"]', 5, 6, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(12, 'Haley-Corkery', NULL, 1151, 1, 'Dicta vel sed voluptatem voluptatem. Perspiciatis magni praesentium excepturi sed repellendus facere placeat. Nihil suscipit repellendus cupiditate est nesciunt illo.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?67047\"]', 5, 6, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(13, 'Haag and Sons', NULL, 1571, 3, 'Aspernatur aut consequuntur et occaecati. Magnam ea est aut sapiente. Enim et iusto alias.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?57060\"]', 20, 8, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(14, 'Langosh-Adams', NULL, 574, 9, 'Eum mollitia vitae ex qui modi. Voluptas sit optio inventore in totam. Debitis architecto saepe tempore esse voluptate ea.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?67093\"]', 7, 11, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(15, 'Ondricka, Rogahn and Denesik', NULL, 799, 3, 'Vel et tempora quasi voluptates est. Enim consequatur quo ipsam deserunt. Dignissimos ducimus veritatis quia vel incidunt. Recusandae reiciendis quisquam ipsam magnam hic aut.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?43586\"]', 4, 3, '2019-11-07 07:53:12', '2019-11-07 07:53:12'),
(16, 'Kassulke, Schroeder and Ward', NULL, 286, 2, 'Et error distinctio illum dolor ducimus architecto. Deserunt nihil dolor quisquam qui incidunt sequi non. Repellat corrupti sit voluptatibus.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?64912\"]', 12, 7, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(17, 'Glover-Cartwright', NULL, 561, 4, 'Impedit in ut aperiam vero assumenda numquam sed. Aut esse nisi ad iste. Consequatur non similique illum quaerat rerum eius reiciendis.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?65941\"]', 19, 6, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(18, 'Mohr and Sons', NULL, 983, 2, 'Maxime perferendis laboriosam in excepturi repellat. Ipsum iste veniam dicta velit vero vitae. Saepe dolores dolorem qui delectus et fugiat recusandae. Eos velit qui magnam aperiam.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?79214\"]', 6, 10, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(19, 'Witting-Ullrich', NULL, 163, 3, 'Placeat nesciunt consequatur inventore. Cumque voluptas aspernatur dolorem quod nemo. Voluptatem quia vitae culpa odio dolorum pariatur. Non fuga reiciendis pariatur vel ut quis at. Ducimus est ut consequatur dicta sed iusto amet consequatur.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?35427\"]', 17, 3, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(20, 'Hansen, Hintz and Douglas', NULL, 929, 8, 'Voluptatem dolorum velit mollitia dolor nam sed fugit. Quidem ipsum eum aut ea aut est officia.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?10332\"]', 16, 5, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(21, 'Mohr, Mraz and Cruickshank', NULL, 1420, 1, 'Ab maiores dicta quis tempore autem facere. Quasi eligendi doloremque sit repudiandae repellat similique. Sunt deserunt id deserunt. Sed nulla temporibus accusantium culpa. Cupiditate impedit quam aperiam aspernatur impedit.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?46292\"]', 19, 10, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(22, 'Hoppe, Gulgowski and Kilback', NULL, 1075, 2, 'Fuga exercitationem amet ut saepe vel. Perspiciatis quis sunt sit sit iste fuga quia. Eos atque tempore laudantium voluptatibus tempora qui.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?55791\"]', 10, 1, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(23, 'Balistreri-Schaden', NULL, 1956, 2, 'Dolor esse est voluptatum provident voluptatem aliquid. Explicabo ut non repellat at iste. Expedita quos recusandae autem praesentium eaque. Natus eos modi consectetur perspiciatis nihil sed sit.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?61813\"]', 17, 3, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(24, 'Lind-Kautzer', NULL, 1705, 9, 'Possimus velit nesciunt inventore voluptatum id. Ab excepturi voluptatem eaque iusto qui cum cumque. Dolorem veniam modi unde dolorum rerum. Inventore sit qui fugiat quas magnam eius nihil.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?12799\"]', 12, 12, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(25, 'Sanford-Konopelski', NULL, 699, 6, 'Nobis aut enim doloribus neque quis ea harum a. Laboriosam nostrum distinctio dolore. Iste eius quis quo. Maxime placeat velit tempora pariatur cum.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?13541\"]', 10, 3, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(26, 'Wiza-Grant', NULL, 506, 7, 'Enim rerum a dolorem in sit. Debitis qui enim sed vel reiciendis. Odio reiciendis qui officia unde et neque consequatur. Repellat vel aut quisquam quas aut porro at tenetur. Totam totam eum magni dignissimos id.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?47704\"]', 14, 14, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(27, 'Legros, Reichel and Larson', NULL, 1872, 2, 'Qui consequatur eaque similique amet provident ratione. Id a rem dolor quaerat alias. Repellendus dolor enim qui ipsa. Rem et eveniet nam architecto atque et quidem.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?84625\"]', 20, 10, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(28, 'Jacobson Ltd', NULL, 1571, 7, 'Vel dolore consequatur cupiditate fuga. Harum dignissimos eveniet similique id.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?95002\"]', 12, 14, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(29, 'Crona-Langosh', NULL, 196, 3, 'Et rerum voluptates sed eius ea qui ut. Vitae molestias et laudantium ea ratione. Ipsum est dolor sunt excepturi eos nam consequatur ipsum. Placeat et atque eveniet inventore placeat omnis expedita. A sunt occaecati nihil facilis blanditiis.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?55037\"]', 18, 13, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(30, 'Yundt, Macejkovic and Leffler', NULL, 657, 3, 'Maiores omnis est voluptatibus odit quidem veniam sit. Recusandae ducimus dolorem nesciunt autem qui soluta assumenda. Quos recusandae ut dolorum aliquam earum maiores. Eos reprehenderit quam est omnis quis odio itaque.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?12062\"]', 7, 12, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(31, 'Reynolds-Ondricka', NULL, 537, 9, 'Et accusamus consequatur facilis accusamus sed. Voluptatum provident delectus omnis delectus qui perspiciatis rerum. Et ducimus eligendi quibusdam praesentium.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?85645\"]', 13, 9, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(32, 'Stracke and Sons', NULL, 1439, 2, 'Quia nihil maxime provident aut aut. Voluptates accusantium ut non qui debitis quia. Quisquam qui quia aut provident harum.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?96917\"]', 3, 2, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(33, 'Turcotte-Smitham', NULL, 823, 6, 'Aut mollitia repellendus voluptatem et doloribus laborum est laboriosam. Quasi minima voluptates provident ut nisi. Delectus vel dicta ipsa in itaque dolor. Inventore dolor dolor quo totam aut illo rem.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?49341\"]', 14, 6, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(34, 'Reynolds, Hansen and Vandervort', NULL, 1410, 9, 'Natus et vitae tempora voluptas dolorem exercitationem. Harum dignissimos fugiat labore. Magni iusto earum officiis. Non excepturi dolorum et consequatur aut optio voluptatibus.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?37061\"]', 20, 6, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(35, 'Monahan Group', NULL, 126, 1, 'Consequuntur velit qui incidunt fugiat atque. Ex quod voluptatem ex rerum. Vel molestiae impedit quas eos rerum aut minima sit.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?27735\"]', 1, 2, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(36, 'Kreiger, Ullrich and McClure', NULL, 1740, 1, 'Ea quia libero neque molestias provident. Necessitatibus voluptas eaque ipsum voluptatem deserunt minus. Hic quam sit et.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?37426\"]', 6, 8, '2019-11-07 07:53:13', '2019-11-07 07:53:13'),
(37, 'Fahey PLC', NULL, 211, 4, 'Ex non alias rerum aliquid accusantium. Illum sed voluptatem quis velit veritatis.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?35501\"]', 12, 4, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(38, 'Prohaska-Williamson', NULL, 189, 1, 'Non laboriosam quae debitis qui ut. Placeat eos consequatur et aut molestiae fugit deserunt.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?77393\"]', 5, 3, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(39, 'Eichmann Inc', NULL, 1271, 4, 'Dolorum et voluptates earum quia recusandae. Deleniti minus enim voluptas qui sed architecto ratione sequi. Provident eveniet mollitia rerum blanditiis fuga sit. Labore incidunt harum sapiente fuga et.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?81680\"]', 1, 1, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(40, 'Hilpert Inc', NULL, 1063, 9, 'Et reiciendis eveniet recusandae repellendus. A doloribus sequi non dolores aliquam. Nihil harum laudantium rem ut.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?95766\"]', 12, 11, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(41, 'Padberg, Schiller and Berge', NULL, 1744, 2, 'Tempore accusantium aut dolores a sed qui. Qui facilis autem neque sint inventore tenetur sunt. Ut eum aut quia fugit. Et molestiae aut non soluta modi. Autem esse et omnis sit inventore.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?28441\"]', 9, 14, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(42, 'Roberts-Stamm', NULL, 1212, 5, 'Voluptatem veniam sint incidunt nobis temporibus ad. Atque amet eos ad dolores autem recusandae. Omnis expedita vitae iure dolorum.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?74026\"]', 16, 12, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(43, 'Nicolas, Dare and Goyette', NULL, 145, 9, 'Et iure sed dolore modi adipisci hic praesentium reprehenderit. Ratione assumenda voluptatibus adipisci dolores illum. Ut explicabo qui ratione nihil impedit. Eveniet nesciunt totam deserunt dolores.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?64130\"]', 17, 12, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(44, 'Kuhn, Stokes and Rodriguez', NULL, 255, 8, 'Numquam ea reprehenderit sapiente qui repellendus officiis officiis. Incidunt perspiciatis rem aliquam. Ipsam necessitatibus aut eos dolore non autem et perferendis. Ratione qui quasi rerum sint doloremque non non.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?52078\"]', 13, 4, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(45, 'Dare-Armstrong', NULL, 851, 3, 'Suscipit et accusantium perspiciatis. Voluptate praesentium incidunt sed ut. Possimus eveniet maiores culpa omnis ullam labore. Quam et earum dolor.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?84455\"]', 6, 5, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(46, 'Schumm Group', NULL, 454, 3, 'Quae aut id aut consequatur. Tenetur quae non enim accusantium consequatur quo. Necessitatibus similique est beatae voluptate. Ut esse molestiae aspernatur.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?37179\"]', 10, 8, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(47, 'Steuber Group', NULL, 525, 1, 'Minima assumenda dolorum autem unde cupiditate reiciendis nam. Est ut quaerat eius dolorem qui doloremque officiis. Quo ut maiores aliquam veniam porro quidem.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?36276\"]', 8, 10, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(48, 'Kunde-Casper', NULL, 211, 1, 'Cupiditate et animi architecto voluptates et debitis dolor. Velit hic molestiae aut ab ea. Atque aut nam sunt veniam qui autem repellat.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?35936\"]', 15, 14, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(49, 'Lang-Brekke', NULL, 962, 1, 'Labore esse ut ullam consequatur a. Quam qui corrupti nobis necessitatibus reprehenderit. Eum vitae consequatur vitae ipsa sit. Necessitatibus ut dolorem sint velit laborum dolores adipisci.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?46195\"]', 16, 14, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(50, 'Toy-Shields', NULL, 1019, 9, 'Hic ducimus eius culpa voluptates ipsa ut. Sunt dolor fuga aliquid odio. Et voluptas suscipit esse cumque fuga rerum.', '[\"https:\\/\\/lorempixel.com\\/300\\/300\\/?47181\"]', 13, 11, '2019-11-07 07:53:14', '2019-11-07 07:53:14'),
(53, 'Snacks', 'Simba', 15, NULL, 'Cranchy chips', '[]', 20, 5, '2019-11-26 20:05:15', '2019-11-26 20:05:15');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2019-10-19 09:36:27', '2019-10-19 09:36:27'),
(2, 'editor', '2019-10-19 09:36:27', '2019-10-19 09:36:27');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `location` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `picture` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `name`, `username`, `description`, `location`, `picture`, `cover`, `number`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Spencer Group', 'spencer-group', 'Vel rerum inventore culpa nesciunt. Voluptates sed quod optio sed exercitationem. Perspiciatis dicta ut quia eligendi amet nulla cumque. Ullam aliquid illum quaerat illum explicabo voluptates dolores. Cumque voluptatem ullam a sed eaque quia.', '64180 Rebeca Passage\nLake Cleta, NJ 98369-1796', 'https://lorempixel.com/300/300/cats/?99703', 'https://lorempixel.com/800/600/?48746', '+2293035912442', 3, '2019-11-07 08:13:26', '2019-11-07 12:59:30'),
(2, 'Berge LLC', 'berge-llc', 'Temporibus optio excepturi et quo est. Quasi soluta ea officia qui. Ut aut voluptate libero ab. Aut inventore cum qui cupiditate.', '282 Bergnaum Gateway Apt. 636\nPort Gastonland, DC 06561-8973', 'https://lorempixel.com/300/300/cats/?65517', 'https://lorempixel.com/800/600/?74866', '+2253040093299', 3, '2019-11-07 08:13:26', '2019-11-07 12:59:30'),
(3, 'Schmidt, Becker and Hudson', 'schmidt-beck', 'Qui reiciendis laborum vel repellendus adipisci qui in. Cumque eligendi aliquid et. Nobis sint quia soluta repellendus ea. Quos aut nulla ipsam labore.', '7801 Serenity Green\nFrederikhaven, KS 87880-1556', 'https://lorempixel.com/300/300/cats/?93768', 'https://lorempixel.com/800/600/?68482', '+6688207396388', 4, '2019-11-07 08:13:26', '2019-11-07 12:59:30'),
(4, 'Wunsch PLC', 'wunsch-plc', 'Minus repudiandae minus quod. Consequatur qui ut aut sit eum accusamus cumque sit.', '415 Baumbach Mills\nEast Normashire, TN 63315-0835', 'https://lorempixel.com/300/300/cats/?53609', 'https://lorempixel.com/800/600/?59971', '+3004540794062', 3, '2019-11-07 08:13:26', '2019-11-07 12:59:31'),
(5, 'Bernhard LLC', 'bernhard-llc', 'Repellat aut numquam odit corporis. Magnam ea itaque excepturi eaque. Repudiandae eum perferendis id ad culpa aut. Minus dolorem voluptatum error rerum officiis aperiam qui ipsam.', '147 Marvin Bridge\nSouth Luciohaven, AR 73968-4168', 'https://lorempixel.com/300/300/cats/?37474', 'https://lorempixel.com/800/600/?80961', '+2550383716457', 6, '2019-11-07 08:13:26', '2019-11-07 12:59:31'),
(6, 'VonRueden, Lockman and Quigley', 'vonrueden-lo', 'Libero qui illo mollitia vel rem dolore sint. Totam harum odit facere eos et aliquid. Voluptas iusto sit quia maxime in possimus.', '4079 King Trafficway Apt. 883\nNew Irwin, GA 55937', 'https://lorempixel.com/300/300/cats/?55472', 'https://lorempixel.com/800/600/?46462', '+2421791985541', 4, '2019-11-07 08:13:26', '2019-11-07 12:59:31'),
(7, 'Considine, Smitham and Hamill', 'considine-sm', 'Quaerat omnis natus nostrum qui. Sit molestias consectetur eveniet eos. Labore quis tenetur facilis tempora et. Qui possimus animi corporis et animi nulla.', '541 Toy Crossroad Suite 325\nNorth Jordon, CT 15702-1095', 'https://lorempixel.com/300/300/cats/?70530', 'https://lorempixel.com/800/600/?44174', '+5279391341541', 4, '2019-11-07 08:13:26', '2019-11-07 12:59:31'),
(8, 'Eichmann Ltd', 'eichmann-ltd', 'Dolores ab qui quia aut quidem et et. Sit mollitia sed placeat dolores minima.', '386 Wiza Trace\nLake Myrna, MN 30570-3537', 'https://lorempixel.com/300/300/cats/?69540', 'https://lorempixel.com/800/600/?77436', '+2050464355716', 1, '2019-11-07 08:13:26', '2019-11-07 12:59:31'),
(9, 'Boyle PLC', 'boyle-plc', 'Asperiores velit et consequatur dolor reiciendis. Nemo ab suscipit molestiae repellat assumenda error. Id asperiores enim est vero.', '41064 Mallie Mission Suite 970\nDaytonview, RI 27424-9142', 'https://lorempixel.com/300/300/cats/?24176', 'https://lorempixel.com/800/600/?67735', '+6320751334018', 7, '2019-11-07 08:13:26', '2019-11-07 12:59:31'),
(10, 'Paucek Inc', 'paucek-inc', 'Qui voluptatem eveniet vel qui aut ducimus tempora. Et magni impedit nostrum repellendus. Et repellat sequi fugit dolorum tempora excepturi voluptas. Sequi omnis et quis laborum tenetur qui. Aut voluptate eos sunt ab quia est ut.', '88639 Quinten Cove\nNorth Ernestine, IL 68538', 'https://lorempixel.com/300/300/cats/?51310', 'https://lorempixel.com/800/600/?57000', '+6997911183041', 1, '2019-11-07 08:13:27', '2019-11-07 12:59:31'),
(11, 'Bashirian, Dickens and Wuckert', 'bashirian-di', 'Odio non quia ea dignissimos sit cum repudiandae delectus. Aut enim quasi cupiditate nam voluptatem est ea. Enim enim iusto quo quibusdam nihil atque error modi. Maiores dolorum magnam et molestias sunt et facere.', '27883 Ondricka Junction Apt. 453\nNelsport, PA 09654', 'https://lorempixel.com/300/300/cats/?61932', 'https://lorempixel.com/800/600/?56798', '+7845305252246', 8, '2019-11-07 08:13:27', '2019-11-07 12:59:31'),
(12, 'Wiza-Franecki', 'wiza-franecki', 'Praesentium eos voluptatem recusandae ipsam vitae. Quos qui vitae cumque placeat. Nobis rerum illo voluptatem voluptatem eaque. Accusamus voluptatum totam reiciendis aut culpa. Modi fugiat officia similique vitae dicta.', '1739 Tillman Rapids Apt. 858\nParisianton, AL 04366-6009', 'https://lorempixel.com/300/300/cats/?70757', 'https://lorempixel.com/800/600/?14579', '+2064273423677', 9, '2019-11-07 08:13:27', '2019-11-07 12:59:31'),
(13, 'Hegmann-Crist', 'hegmann-crist', 'Esse ullam ad voluptas adipisci ea. Facere aut quae corporis voluptatem harum inventore sint. Quis placeat eveniet odio voluptas amet sed voluptatem neque. Fugit consequuntur consequatur rerum soluta. Dolor et est omnis molestias quasi maxime doloribus iste.', '11718 Cathryn Trace\nWest Queenburgh, NE 17450', 'https://lorempixel.com/300/300/cats/?80412', 'https://lorempixel.com/800/600/?86032', '+7282810396707', 2, '2019-11-07 08:13:27', '2019-11-07 12:59:31'),
(14, 'Spinka Group', 'spinka-group', 'Dolores itaque ut odio incidunt qui. Necessitatibus numquam ex perspiciatis dolor similique. Nihil enim praesentium est.', '867 Ignacio Run\nWest Shyannemouth, OH 38013-8751', 'https://lorempixel.com/300/300/cats/?73529', 'https://lorempixel.com/800/600/?13781', '+2502468815448', 9, '2019-11-07 08:13:27', '2019-11-07 12:59:31'),
(15, 'Orn-Nikolaus', 'orn-nikolaus', 'Et vero laboriosam ut dolor et vel optio dolores. Odio in corporis quia harum quidem temporibus. Aperiam quia ratione ipsam accusamus magnam quisquam suscipit omnis.', '5893 Santiago Tunnel Suite 371\nWymanton, DE 19547', 'https://lorempixel.com/300/300/cats/?27196', 'https://lorempixel.com/800/600/?51694', '+7121942488002', 6, '2019-11-07 08:13:27', '2019-11-07 12:59:32'),
(16, 'Ward and Sons', 'ward-and-sons', 'Velit quibusdam temporibus voluptatem eius vitae ut. Consequatur quo voluptas possimus. Omnis culpa odio in. Eos nam et et corporis.', '503 Clark Plaza\nMohrbury, MD 57304-3223', 'https://lorempixel.com/300/300/cats/?64015', 'https://lorempixel.com/800/600/?91872', '+8516491202254', 8, '2019-11-07 08:13:27', '2019-11-07 12:59:32'),
(17, 'Tillman Ltd', 'tillman-ltd', 'Tempora doloribus voluptatem pariatur molestiae nemo. Aut omnis laudantium et at impedit doloremque. Dolor fugit vitae rerum quas. Repellendus neque at distinctio et aspernatur sunt.', '2138 Eileen Bypass\nDahliabury, DE 80890', 'https://lorempixel.com/300/300/cats/?76175', 'https://lorempixel.com/800/600/?75295', '+9592927890996', 5, '2019-11-07 08:13:27', '2019-11-07 12:59:32'),
(18, 'Kuvalis-Streich', 'kuvalis-strei', 'Suscipit rerum explicabo fugiat sapiente sit. Corporis quod vitae sed voluptate commodi dolorum omnis. At laboriosam ut maiores tempora.', '5574 Chelsea Point\nLake Agnesborough, SC 47221', 'https://lorempixel.com/300/300/cats/?20507', 'https://lorempixel.com/800/600/?12255', '+4882971471101', 4, '2019-11-07 08:13:27', '2019-11-07 12:59:32'),
(19, 'Schmeler Ltd', 'schmeler-ltd', 'Repudiandae quidem ducimus id molestiae ipsa. Quo quia debitis hic totam. Distinctio dicta quaerat voluptatem commodi est minima. Harum culpa voluptas consectetur. Voluptates sit autem autem blanditiis sit explicabo.', '72385 Satterfield Drives\nSchmelerville, RI 67472-9583', 'https://lorempixel.com/300/300/cats/?16316', 'https://lorempixel.com/800/600/?86554', '+4823592848114', 6, '2019-11-07 08:13:27', '2019-11-07 12:59:32'),
(20, 'Wunsch PLC', 'wunsch-plc', 'Minus repudiandae minus quod. Consequatur qui ut aut sit eum accusamus cumque sit.', '415 Baumbach Mills\nEast Normashire, TN 63315-0835', 'https://lorempixel.com/300/300/cats/?65563', 'https://lorempixel.com/800/600/?73225', '0781361395', 1, '2019-11-07 08:13:27', '2019-11-29 16:11:02'),
(23, 'Uber', 'uber', NULL, '4758 Polar Park, Dimbaza, 5671', NULL, NULL, NULL, NULL, '2019-11-17 21:43:32', '2019-11-17 21:43:32');

-- --------------------------------------------------------

--
-- Table structure for table `shop_managers`
--

CREATE TABLE `shop_managers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT '0',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` bigint(20) UNSIGNED NOT NULL,
  `shop_id` bigint(20) UNSIGNED DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shop_managers`
--

INSERT INTO `shop_managers` (`id`, `first_name`, `last_name`, `username`, `email`, `number`, `verified`, `email_verified_at`, `password`, `role`, `shop_id`, `remember_token`, `created_at`, `updated_at`) VALUES
(4, 'Kuhle', 'Hanisi', 'kuhle-hanisi', 'hanisi@gmail.com', '0781361395', 0, NULL, '$2y$10$LyB6gSc2e5tnj5RxxbNlUeuwWNdpJXO8wbATb.4Z4PNoSTp/XZLxm', 1, 20, NULL, '2019-11-17 21:43:32', '2019-11-29 13:11:29');

-- --------------------------------------------------------

--
-- Table structure for table `subcategory_products`
--

CREATE TABLE `subcategory_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `products` text COLLATE utf8mb4_unicode_ci,
  `subcategory_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subcategory_products`
--

INSERT INTO `subcategory_products` (`id`, `name`, `products`, `subcategory_id`, `created_at`, `updated_at`) VALUES
(1, 'Accessories', '[\"Watches\",\"Socks\",\"Hair Accessories\",\"Hats & Caps\",\"Bags & Wallets\",\"Gloves & Scarves\",\"Pacifiers\",\"Bibs\"]', 1, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(2, 'Beauty', '[\"Nappies & Wipes\",\"Body, Bath & Shower\",\"Skin Care\",\"Nail Care\"]', 1, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(3, 'Clothing', '[\"T-shirts, Vests & Polo\'s\",\"Trousers & Leggings\",\"Sweatshirts\",\"Coats, Jackets & Gilets\",\"Babygrows & Sets\",\"Underwear & Baselayers\",\"Dresses\",\"Tops\"]', 1, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(4, 'Shoes', '[\"Sneakers & Canvas\",\"Boots\",\"Casual Shoes\",\"Formal Shoes\",\"Slippers\",\"Sandals\",\"School Shoes\"]', 1, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(5, 'Accessories', '[\"Hats & Caps\",\"Bags & Wallets\",\"Sunglasses & Eyewear\",\"Watches\",\"Belts\",\"Socks\",\"Formal Accessories\",\"Jewellery\"]', 2, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(6, 'Clothing', '[\"T-shirts, Vests & Polo\'s\",\"Shirts\",\"Shorts\",\"Jeans\",\"Trousers & Chinos\",\"Swimwear\",\"Sweatshirts\",\"Coats, Jackets & Gilets\"]', 2, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(7, 'Grooming', '[\"Fragrances\",\"Shaving\",\"Skincare\",\"Body, Bath & Shower\",\"Hair Care\",\"Nailcare\",\"Personal Health\"]', 2, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(8, 'Shoes', '[\"Sneakers & Canvas\",\"Formal Shoes\",\"Casual Shoes\",\"Sandals\",\"Boots\",\"Shoe Care & Accessories\"]', 2, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(9, 'Sports', '[\"Sports Shoes\",\"Sports Clothing\",\"Sports Accessories & Equipment\"]', 2, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(10, 'Accessories', '[\"Bags & Wallets\",\"Watches\",\"Sunglasses & Eyewear\",\"Hats & Caps\",\"Gloves & Scarves\",\"Jewellery\",\"Socks\",\"Cosmetics\",\"Hair Accessories\",\"Hosiery\"]', 3, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(11, 'Beauty', '[\"Fragrances\",\"Make-up\",\"Hair Care\",\"Body, Bath & Shower\",\"Nail Care\",\"Skin Care\",\"Personal Health\",\"Grooming\"]', 3, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(12, 'Clothing', '[\"Dresses\",\"Playsuits, Jumpsuits & Dungarees\",\"Tops\",\"Shorts\",\"Jeans\",\"Skirts\",\"Swimwear\",\"Coats, Jackets & Gilets\"]', 3, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(13, 'Maternity', '[\"Dresses\",\"View All Maternity Wear\",\"Tops\",\"Bottoms\"]', 3, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(14, 'Shoes', '[\"Heels\",\"Sneakers & Canvas\",\"Wedges\",\"Sandals\",\"Flats\",\"Platforms\",\"Boots\",\"Shoe Care & Accessories\"]', 3, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(15, 'Baby Accessories', '[\"Combs, Brushes, Clippers\",\"Soothers & Teethers\",\"Baby Toys\"]', 4, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(16, 'Baby Bath & Hygiene', '[\"Baby Laundry\",\"Baby Bath\",\"Baby Creams & Lotions\",\"Baby Oil & Shampoo\",\"Baby Powder\",\"Baby Oral Care\",\"Baby Buds\",\"Baby Gift Sets\",\"Baby Health\"]', 4, '2019-11-07 07:40:45', '2019-11-07 07:40:45'),
(17, 'Baby Food & Formula', '[\"Infant Formula\",\"Baby Food\",\"Organic Baby Food\"]', 4, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(18, 'Diapers & Wipes', '[\"Diapers\",\"Baby Wipes\",\"Nappies & Rash Cream\"]', 4, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(19, 'Feeding & Nursing', '[\"Sippers & Bottles\",\"Nursing Tools\",\"Bibs & Napkins\",\"Baby Dishes & Utensils\"]', 4, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(20, 'Mothers & Maternity', '[\"Maternity Health Supplements\",\"Maternity Personal Care\"]', 4, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(21, 'Bakery Snacks', '[\"Bread Sticks & Lavash\",\"Cheese & Garlic Bread\",\"Puffs, Patties, Sandwiches\",\"Organic & Free From\",\"Breadcrumbs & Croutons\"]', 5, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(22, 'Breads & Buns', '[\"Brown, Wheat & Multigrain\",\"Milk, White & Sandwich\",\"Buns, Pavs & Pizza Base\"]', 5, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(23, 'Cakes & Pastries', '[\"Tea Cakes & Slice Cakes\",\"Muffins & Cup Cakes\",\"Pastries & Brownies\",\"Doughnuts & Mousses\",\"Birthday & Party Cakes\"]', 5, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(24, 'Cookies, Rusk & Khari', '[\"Khari & Cream Rolls\",\"Rusks\",\"Premium Cookies\",\"Bakery Biscuits, Cookies\"]', 5, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(25, 'Dairy', '[\"Paneer, Tofu & Cream\",\"Milk\",\"Butter & Margarine\",\"Curd\",\"Buttermilk & Lassi\",\"Condensed, Powdered Milk\",\"Cheese\",\"Flavoured, Soya Milk\",\"Yogurt & Shrikhand\"]', 5, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(26, 'Gourmet Breads', '[\"Croissants, Bagels\",\"Gourmet Bread\",\"Panini, Focaccia & Pita\",\"Bagels & Baguette\"]', 5, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(27, 'Ice Creams & Desserts', '[\"Ice Creams\"]', 5, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(28, 'Bath & Hand Wash', '[\"Hand Wash & Sanitizers\",\"Bathing Bars & Soaps\",\"Shower Gel & Body Wash\",\"Talcum Powder\",\"Bathing Accessories\",\"Body Scrubs & Exfoliants\",\"Bath Salts & Oils\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(29, 'Feminine Hygiene', '[\"Sanitary Napkins\",\"Panty Liners\",\"Intimate Wash & Care\",\"Hair Removal\",\"Tampons & Menstrual Cups\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(30, 'Fragrances & Deos', '[\"Gift Sets\",\"Perfume\",\"Women\'s Deodorants\",\"Men\'s Deodorants\",\"Eau De Parfum\",\"Body Sprays & Mists\",\"Eau De Toilette\",\"Attar\",\"Eau De Cologne\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(31, 'Hair Care', '[\"Hair Oil & Serum\",\"Shampoo & Conditioner\",\"Hair Color\",\"Hair & Scalp Treatment\",\"Dry Shampoo & Conditioner\",\"Hair Styling\",\"Tools & Accessories\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(32, 'Health & Medicine', '[\"Antiseptics & Bandages\",\"Cotton & Ear Buds\",\"Everyday Medicine\",\"Sexual Wellness\",\"Slimming Products\",\"Adult Diapers\",\"Supplements & Proteins\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(33, 'Makeup', '[\"Lips\",\"Nails\",\"Face\",\"Eyes\",\"Makeup Accessories\",\"Makeup Kits & Gift Sets\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(34, 'Men\'s Grooming', '[\"Bath & Shower\",\"Shaving Care\",\"Face & Body\",\"Combos & Gift Sets\",\"Deodorant\",\"Hair Care & Styling\",\"Moustache & Beard Care\",\"Talc\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(35, 'Oral Care', '[\"Mouthwash\",\"Toothpaste\",\"Toothbrush\",\"Floss & Tongue Cleaner\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(36, 'Skin Care', '[\"Lip Care\",\"Body Care\",\"Face Care\",\"Eye Care\",\"Aromatherapy\"]', 6, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(37, 'Coffee', '[\"Ground Coffee\",\"Instant Coffee\"]', 7, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(38, 'Energy & Soft Drinks', '[\"Soda & Cocktail Mix\",\"Cold Drinks\",\"Sports & Energy Drinks\",\"Non Alcoholic Drinks\"]', 7, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(39, 'Fruit Juices & Drinks', '[\"Unsweetened, Cold Press\",\"Juices\",\"Syrups & Concentrates\"]', 7, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(40, 'Health Drink, Supplement', '[\"Children (2-5 Yrs)\",\"Kids (5+yrs)\",\"Men & Women\",\"Glucose Powder, Tablets\"]', 7, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(41, 'Tea', '[\"Leaf & Dust Tea\",\"Green Tea\",\"Tea Bags\",\"Exotic & Flavoured Tea\"]', 7, '2019-11-07 07:40:46', '2019-11-07 07:40:46'),
(42, 'Water', '[\"Packaged Water\",\"Spring Water\"]', 7, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(43, 'All Purpose Cleaners', '[\"Toilet Cleaners\",\"Kitchen, Glass & Drain\",\"Floor & Other Cleaners\",\"Imported Cleaners\",\"Metal, Furniture Cleaner\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(44, 'Bins & Bathroom Ware', '[\"Hangers, Clips & Rope\",\"Dustbins\",\"Buckets & Mugs\",\"Laundry, Storage Baskets\",\"Soap Cases & Dispensers\",\"Bath Stool, Basin & Sets\",\"Other Plastic Ware\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(45, 'Car & Shoe Care', '[\"Shoe Polish\",\"Car Freshener\",\"Shoe Shiners & Brushes\",\"Car Polish & Cleaners\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(46, 'Detergents & Dishwash', '[\"Dishwash Liquids & Pastes\",\"Detergent Powder, Liquid\",\"Fabric Pre, Post Wash\",\"Dishwash Bars & Powders\",\"Detergent Bars\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(47, 'Disposables, Garbage Bag', '[\"Wet Wipe, Pocket Tissues\",\"Kitchen Rolls\",\"Aluminium Foil, Clingwrap\",\"Garbage Bags\",\"Toilet Paper\",\"Paper Napkin, Tissue Box\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(48, 'Fresheners & Repellents', '[\"Mosquito Repellent\",\"Insect Repellent\",\"Air Freshener\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(49, 'Mops, Brushes & Scrubs', '[\"Utensil Scrub-pad, Glove\",\"Dust Cloth & Wipes\",\"Brooms & Dust Pans\",\"Toilet & Other Brushes\",\"Mops, Wipers\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(50, 'Party & Festive Needs', '[\"Rakhi\",\"Disposable Cups & Plates\",\"Caps, Balloons & Candles\",\"Decorations\",\"Gift Wraps & Bags\",\"Seasonal Accessories\",\"Holi Colours & Pichkari\",\"Gifts\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(51, 'Pooja Needs', '[\"Lamp & Lamp Oil\",\"Camphor & Wicks\",\"Other Pooja Needs\",\"Pooja Thali & Bells\",\"Candles & Match Box\",\"Agarbatti, Incense Sticks\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(52, 'Stationery', '[\"Notebooks, Files, Folders\",\"Pen, Pencils\",\"Scissor, Glue & Tape\",\"Exam Pads & Pencil Box\",\"Colours & Crayons\",\"Erasers & Sharpeners\"]', 8, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(53, 'Eggs', '[\"Farm Eggs\",\"Protein Eggs\",\"Country Eggs\",\"Other Eggs\",\"Organic Eggs\"]', 9, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(54, 'Fish & Seafood', '[\"Dry Fish\",\"Frozen Fish & Seafood\",\"Canned Seafood\",\"Fresh Fish\",\"Other Seafood\",\"Prawns & Shrimps\"]', 9, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(55, 'Marinades', '[\"Marinated Meat\"]', 9, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(56, 'Mutton & Lamb', '[\"Frozen Mutton\",\"Fresh Mutton\"]', 9, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(57, 'Pork & Other Meats', '[\"Fresh & Frozen Pork\",\"Beef\"]', 9, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(58, 'Poultry', '[\"Frozen Chicken\",\"Fresh Chicken\",\"Turkey\"]', 9, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(59, 'Sausages, Bacon & Salami', '[\"Pork & Ham\",\"Chicken Sausages\",\"Lamb\",\"Turkey & Duck\"]', 9, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(60, 'Atta, Flours & Sooji', '[\"Atta Whole Wheat\",\"Sooji, Maida & Besan\",\"White Flour\",\"Rice & Other Flours\"]', 10, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(61, 'Dals & Pulses', '[\"Toor, Channa & Moong Dal\",\"Cereals & Millets\",\"Urad & Other Dals\"]', 10, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(62, 'Dry Fruits', '[\"Almonds\",\"Raisins\",\"Cashews\",\"Other Dry Fruits\",\"Mukhwas\"]', 10, '2019-11-07 07:40:47', '2019-11-07 07:40:47'),
(63, 'Edible Oils & Ghee', '[\"Blended Cooking Oils\",\"Sunflower, Rice Bran Oil\",\"Ghee & Vanaspati\",\"Soya & Mustard Oils\",\"Gingelly Oil\",\"Other Edible Oils\",\"Olive & Canola Oils\",\"Gingelly, Groundnut Oils\"]', 10, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(64, 'Masalas & Spices', '[\"Whole Spices\",\"Powdered Spices\",\"Cooking Pastes\",\"Herbs & Seasoning\",\"Blended Masalas\"]', 10, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(65, 'Organic Staples', '[\"Organic Dals & Pulses\",\"Organic Sugar, Jaggery\",\"Organic Dry Fruits\",\"Organic Flours\",\"Organic Rice, Other Rice\",\"Organic Edible Oil, Ghee\",\"Organic Masalas & Spices\"]', 10, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(66, 'Rice & Rice Products', '[\"Raw Rice\",\"Poha, Sabudana & Murmura\",\"Basmati Rice\",\"Boiled & Steam Rice\"]', 10, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(67, 'Salt, Sugar & Jaggery', '[\"Sugar & Jaggery\",\"Salts\",\"Sugarfree Sweeteners\"]', 10, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(68, 'Cuts & Sprouts', '[\"Cut Fruit, Tender Coconut\",\"Cut & Peeled Veggies\",\"Fresh Salads & Sprouts\",\"Recipe Packs\"]', 11, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(69, 'Exotic Fruits & Veggies', '[\"Exotic Vegetables\",\"Exotic Fruits\"]', 11, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(70, 'Flower Bouquets, Bunches', '[\"Marigold\",\"Other Flowers\",\"Roses\"]', 11, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(71, 'Fresh Fruits', '[\"Banana, Sapota & Papaya\",\"Apples & Pomegranate\",\"Kiwi, Melon, Citrus Fruit\",\"Fruit Baskets\",\"Seasonal Fruits\",\"Mangoes\"]', 11, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(72, 'Fresh Vegetables', '[\"Potato, Onion & Tomato\",\"Cucumber & Capsicum\",\"Leafy Vegetables\",\"Root Vegetables\",\"Cabbage & Cauliflower\",\"Gourd, Pumpkin, Drumstick\",\"Beans, Brinjals & Okra\",\"Specialty\"]', 11, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(73, 'Herbs & Seasonings', '[\"Lemon, Ginger & Garlic\",\"Indian & Exotic Herbs\"]', 11, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(74, 'Organic Fruits & Vegetables', '[\"Organic Vegetables\",\"Organic Fruits\"]', 11, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(75, 'Cereals & Breakfast', '[\"Imported Oats & Porridge\",\"Cereal & Granola Bars\",\"Muesli & Rice Cakes\",\"Gourmet Flakes\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(76, 'Chocolates & Biscuits', '[\"Crackers & Digestive\",\"Luxury Chocolates, Gifts\",\"International Chocolates\",\"Cookies, Biscotti, Wafer\",\"Marshmallow, Candy, Jelly\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(77, 'Cooking & Baking Needs', '[\"Cooking Chocolate, Cocoa\",\"Curry Paste, Coconut Milk\",\"Exotic Sugar & Salt\",\"Baking, Cake Decorations\",\"Flours & Pre-mixes\",\"Quinoa & Grains\",\"Herbs, Seasonings & Rubs\",\"Baking Accessories\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(78, 'Dairy & Cheese', '[\"Flavoured & Greek Yogurt\",\"Tofu\",\"Milk & Soya Drinks\",\"International Cheese\",\"Gourmet Ice Cream\",\"Cream & Cheese Spreads\",\"Butter & Cream\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(79, 'Drinks & Beverages', '[\"Aerated, Still, Sparkling\",\"Health Drinks\",\"Non-alcoholic Beer, Wine\",\"Coffee & Pre-mix\",\"Gourmet Juices & Drinks\",\"Cocktail Mixes\",\"Gourmet Tea & Tea Bags\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(80, 'Oil & Vinegar', '[\"Extra Virgin Olive Oil\",\"Pure, Pomace Olive Oil\",\"Canola & Rapeseed Oil\",\"Balsamic & Cider Vinegar\",\"Regular & White Vinegar\",\"Flavoured & Other Oils\",\"Organic & Cold Press Oil\",\"Wine & Rice Vinegar\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(81, 'Pasta, Soup & Noodles', '[\"Pastas & Spaghetti\",\"Imported Noodles\",\"Imported Soups\",\"Jasmine & Sushi Rice\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(82, 'Sauces, Spreads & Dips', '[\"Chocolate, Peanut Spread\",\"Honey & Maple Syrup\",\"Jams, Marmalade, Spreads\",\"Hummus, Cheese, Salsa Dip\",\"Mustard & Cheese Sauces\",\"Thai & Asian Sauces\",\"Salad Dressings\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(83, 'Snacks, Dry Fruits, Nuts', '[\"Nachos & Chips\",\"Gourmet Popcorn\",\"Dry Fruits & Berries\",\"Roasted Seeds & Nuts\",\"Healthy, Baked Snacks\",\"Trail & Cocktail Mixes\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(84, 'Tinned & Processed Food', '[\"Beans & Pulses\",\"Fruits & Pulps\",\"Olive, Jalapeno, Gherkin\",\"Fish & Tuna\",\"Tomatoes & Vegetables\"]', 12, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(85, 'Appliances & Electricals', '[\"Battery & Electrical\",\"Cfl & Led Bulbs\"]', 13, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(86, 'Bakeware', '[\"Baking Tools & Brushes\",\"Bakeware Accessories\",\"Bakeware Moulds, Cutters\"]', 13, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(87, 'Cookware & Non Stick', '[\"Pressure Cookers\",\"Gas Stove\",\"Tawa & Sauce Pan\",\"Cook And Serve\",\"Cookware Sets\",\"Kadai & Fry Pans\",\"Microwavable Cookware\"]', 13, '2019-11-07 07:40:48', '2019-11-07 07:40:48'),
(88, 'Crockery & Cutlery', '[\"Dinner Sets\",\"Glassware\",\"Cups, Mugs & Tumblers\",\"Plates & Bowls\",\"Cutlery, Spoon & Fork\"]', 13, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(89, 'Flask & Casserole', '[\"Vacuum Flask\",\"Casserole\",\"Lunch Boxes & Bottles\"]', 13, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(90, 'Gardening', '[\"Fertilizers & Pesticides\",\"Pots, Planters & Trays\",\"Gardening Tools\",\"Seeds & Sapling\"]', 13, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(91, 'Kitchen Accessories', '[\"Lighters\",\"Choppers & Graters\",\"Kitchen Tools & Other Accessories\",\"Knives & Peelers\",\"Strainer, Ladle, Spatula\"]', 13, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(92, 'Pet Food & Accessories', '[\"Pet Meals & Treats\",\"Health Supplements\",\"Pet Cleaning & Grooming\",\"Pet Feeding Support\",\"Pet Collars & Leashes\",\"Pet Toys\"]', 13, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(93, 'Steel Utensils', '[\"Steel Lunch Boxes\",\"Steel Storage Containers\",\"Plates & Tumblers\",\"Copper Utensils\",\"Bowls & Vessels\"]', 13, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(94, 'Storage & Accessories', '[\"Water & Fridge Bottles\",\"Wall Hooks & Hangers\",\"Umbrella\",\"Containers Sets\",\"Racks & Holders\",\"Lunch Boxes\",\"Cloth Dryer & Iron Table\"]', 13, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(95, 'Biscuits & Cookies', '[\"Marie, Health, Digestive\",\"Salted Biscuits\",\"Glucose & Milk Biscuits\",\"Cream Biscuits & Wafers\",\"Cookies\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(96, 'Breakfast Cereals', '[\"Oats & Porridge\",\"Kids Cereal\",\"Muesli\",\"Flakes\",\"Granola & Cereal Bars\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(97, 'Chocolates & Candies', '[\"Chocolates\",\"Toffee, Candy & Lollypop\",\"Mints & Chewing Gum\",\"Gift Boxes\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(98, 'Frozen Veggies & Snacks', '[\"Frozen Vegetables\",\"Frozen Veg Snacks\",\"Frozen Indian Breads\",\"Frozen Non-veg Snacks\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(99, 'Indian Mithai', '[\"Fresh Sweets\",\"Chikki & Gajjak\",\"Tinned, Packed Sweets\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(100, 'Noodle, Pasta, Vermicelli', '[\"Instant Noodles\",\"Hakka Noodles\",\"Instant Pasta\",\"Vermicelli\",\"Cup Noodles\",\"Pasta & Macaroni\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(101, 'Pickles & Chutney', '[\"Chutney Powder\",\"Lime & Mango Pickle\",\"Other Veg Pickle\",\"Non Veg Pickle\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(102, 'Ready To Cook & Eat', '[\"Breakfast & Snack Mixes\",\"Soups\",\"Heat & Eat Ready Meals\",\"Papads, Ready To Fry\",\"Dessert Mixes\",\"Home Baking\",\"Canned Food\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(103, 'Snacks & Namkeen', '[\"Chips & Corn Snacks\",\"Namkeen & Savoury Snacks\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(104, 'Spreads, Sauces, Ketchup', '[\"Choco & Nut Spread\",\"Honey\",\"Mayonnaise\",\"Tomato Ketchup & Sauces\",\"Chilli & Soya Sauce\",\"Jam, Conserve, Marmalade\",\"Vinegar\",\"Dips & Dressings\"]', 14, '2019-11-07 07:40:49', '2019-11-07 07:40:49'),
(105, 'Sports', '[\"Sports Shoes\",\"Sports Clothing\",\"Sports Accessories & Equipment\"]', 3, '2019-11-07 07:42:26', '2019-11-07 07:42:26');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `name`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Kids', 3, '2019-11-07 00:48:11', '2019-11-07 00:48:11'),
(2, 'Men', 3, '2019-11-07 00:48:11', '2019-11-07 00:48:11'),
(3, 'Women', 3, '2019-11-07 00:48:11', '2019-11-07 00:48:11'),
(4, 'Baby Care', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(5, 'Bakery, Cakes & Dairy', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(6, 'Beauty & Hygiene', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(7, 'Beverages', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(8, 'Cleaning & Household', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(9, 'Eggs, Meat & Fish', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(10, 'Foodgrains, Oil & Masala', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(11, 'Fruits & Vegetables', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(12, 'Gourmet & World Food', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(13, 'Kitchen, Garden & Pets', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02'),
(14, 'Snacks & Branded Foods', 1, '2019-11-07 00:50:02', '2019-11-07 00:50:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cards_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_customer_id_foreign` (`customer_id`),
  ADD KEY `cart_product_id_foreign` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_email_unique` (`email`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `favorites_customer_id_foreign` (`customer_id`),
  ADD KEY `favorites_product_id_foreign` (`product_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_customer_id_foreign` (`customer_id`),
  ADD KEY `orders_address_id_foreign` (`address_id`);

--
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_shop_id_foreign` (`shop_id`),
  ADD KEY `products_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shops_category_id_foreign` (`category_id`);

--
-- Indexes for table `shop_managers`
--
ALTER TABLE `shop_managers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shop_managers_email_unique` (`email`),
  ADD KEY `shop_managers_role_foreign` (`role`),
  ADD KEY `shop_managers_shop_id_foreign` (`shop_id`);

--
-- Indexes for table `subcategory_products`
--
ALTER TABLE `subcategory_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subcategory_products_subcategory_id_foreign` (`subcategory_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `partners`
--
ALTER TABLE `partners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `shop_managers`
--
ALTER TABLE `shop_managers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `subcategory_products`
--
ALTER TABLE `subcategory_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `cards_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `cart_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `favorites_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_address_id_foreign` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  ADD CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`),
  ADD CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`);

--
-- Constraints for table `shops`
--
ALTER TABLE `shops`
  ADD CONSTRAINT `shops_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `shop_managers`
--
ALTER TABLE `shop_managers`
  ADD CONSTRAINT `shop_managers_role_foreign` FOREIGN KEY (`role`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `shop_managers_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`);

--
-- Constraints for table `subcategory_products`
--
ALTER TABLE `subcategory_products`
  ADD CONSTRAINT `subcategory_products_subcategory_id_foreign` FOREIGN KEY (`subcategory_id`) REFERENCES `sub_categories` (`id`);

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
