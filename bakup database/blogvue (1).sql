-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2020 at 06:34 PM
-- Server version: 10.3.16-MariaDB
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
-- Database: `blogvue`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2020_03_20_130441_create_roles_table', 1),
(4, '2020_03_20_131107_add_user_id_column_users', 1),
(6, '2020_03_31_130008_create_profiles_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'images/no_image.png',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `user_id`, `photo`, `created_at`, `updated_at`) VALUES
(3, 4, 'images/c2ZsmGdUzZny5AINztLn.jpeg', NULL, '2020-04-03 03:47:57'),
(5, 6, 'images/HBaGcJ89Tda57Vh7VWmZ.jpeg', NULL, '2020-04-03 06:38:18'),
(6, 7, 'images/lbbnqN9zpGrv7VCCB6pe.jpeg', NULL, '2020-04-03 03:47:15'),
(11, 12, 'images/End3id9SAHNXTfei61aK.jpeg', '2020-04-03 06:43:11', '2020-04-03 06:45:18'),
(12, 13, 'images/no_image.png', '2020-04-03 06:43:41', '2020-04-03 06:43:41');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', '2020-03-24 08:47:35', '2020-03-24 08:47:35'),
(2, 'Editor', '2020-03-25 07:31:30', '2020-03-25 07:31:30'),
(3, 'Guest', '2020-03-31 03:15:30', '2020-03-31 03:15:30'),
(61, 'Manager', '2020-04-02 09:40:30', '2020-04-02 09:40:30'),
(62, 'Sales', '2020-04-02 09:40:39', '2020-04-02 09:40:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`, `role_id`) VALUES
(4, 'Amzad Hossain', 'amzad@gmail.com', NULL, '$2y$10$shECa8/0bjVv7kvbUZToEOzrfpadvaYPxJGWAqSkIyGu/8pA6S2Sy', '4iAN2FmRqq9R7EaBEa6454mfJM4M68nl8Fw3NWAzza2kpDBUh60tbcpPw0XbTH1Y1jhA1D22c368XWLF', NULL, '2020-04-01 07:38:27', '2020-04-03 02:15:35', 1),
(6, 'Zad Isain', 'zad@gmail.com', NULL, '$2y$10$oz6bVP.EMap7pilA.Ui0k.k7znyEmsss.ONInRu0iww0o8UwCe6Km', '$2y$10$g2xccG8X3Pjk8DeMslFoEeE4EirWFEWiAkfvdMDlfNuwu4EUiS20S', NULL, '2020-04-01 07:40:52', '2020-04-02 10:18:49', 2),
(7, 'Khan hossain', 'khan@gmail.com', NULL, '$2y$10$IUIpyFfl9wCOJ8fgMcfWTOziNNk4SsmO4oCccZUGoOUcqbee2Tn0y', '$2y$10$sw..qd3c/naUb3vA7AYSWeOL5oKXGdA9G2uELm681ydwRIo6oFu12', NULL, '2020-04-01 07:42:06', '2020-04-02 09:40:48', 61),
(12, 'Foisal Hossain', 'admin@gmail.com', NULL, '$2y$10$2cQslX3U/Jdbc646.yF98e35SiH69Oldln.QWzCN9dv2vPOJ8/UAO', 'OlSVJtMJ60150MkugkHAFLW3dujQ0K1HMigpLGU2iQyCJj3oP7tMOCZ966L8z2lo1FER6xJZXiE5oVgO', NULL, '2020-04-03 06:43:11', '2020-04-03 07:46:25', 1),
(13, 'Arif hasan', 'arif@gmail.com', NULL, '$2y$10$h2Sjewvk0P/AexOwZOJTveKDdUhLlAo7JAVh7EJqf7mwR1Uokobzm', NULL, NULL, '2020-04-03 06:43:41', '2020-04-03 07:58:14', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
