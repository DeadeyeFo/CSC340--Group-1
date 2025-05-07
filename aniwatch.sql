-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 07, 2025 at 03:08 AM
-- Server version: 8.0.39
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aniwatch`
--

-- --------------------------------------------------------

--
-- Table structure for table `anime`
--

CREATE TABLE `anime` (
  `id` bigint NOT NULL,
  `alternate_title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mal_id` bigint NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `anime`
--

INSERT INTO `anime` (`id`, `alternate_title`, `mal_id`, `image_url`, `title`) VALUES
(1, 'カウボーイビバップ', 1, 'https://cdn.myanimelist.net/images/anime/4/19644l.webp', 'Cowboy Bebop'),
(2, 'カウボーイビバップ 天国の扉', 5, 'https://cdn.myanimelist.net/images/anime/1439/93480l.webp', 'Cowboy Bebop: Tengoku no Tobira'),
(3, 'トライガン', 6, 'https://cdn.myanimelist.net/images/anime/1130/120002l.webp', 'Trigun'),
(4, 'Witch Hunter ROBIN (ウイッチハンターロビン)', 7, 'https://cdn.myanimelist.net/images/anime/10/19969l.webp', 'Witch Hunter Robin'),
(5, '冒険王ビィト', 8, 'https://cdn.myanimelist.net/images/anime/7/21569l.webp', 'Bouken Ou Beet'),
(6, 'アイシールド21', 15, 'https://cdn.myanimelist.net/images/anime/1079/133529l.webp', 'Eyeshield 21'),
(7, 'ハチミツとクローバー', 16, 'https://cdn.myanimelist.net/images/anime/1301/133577l.webp', 'Hachimitsu to Clover'),
(8, 'ハングリーハート Wild Striker', 17, 'https://cdn.myanimelist.net/images/anime/12/49655l.webp', 'Hungry Heart: Wild Striker'),
(9, '頭文字〈イニシャル〉D FOURTH STAGE', 18, 'https://cdn.myanimelist.net/images/anime/9/10521l.webp', 'Initial D Fourth Stage'),
(10, 'モンスター', 19, 'https://cdn.myanimelist.net/images/anime/10/18793l.webp', 'Monster'),
(11, 'ナルト', 20, 'https://cdn.myanimelist.net/images/anime/1141/142503l.webp', 'Naruto'),
(12, 'ONE PIECE', 21, 'https://cdn.myanimelist.net/images/anime/1244/138851l.webp', 'One Piece'),
(13, 'テニスの王子様', 22, 'https://cdn.myanimelist.net/images/anime/6/21624l.webp', 'Tennis no Oujisama'),
(14, 'リングにかけろ１', 23, 'https://cdn.myanimelist.net/images/anime/1146/124743l.webp', 'Ring ni Kakero 1'),
(15, 'スクールランブル', 24, 'https://cdn.myanimelist.net/images/anime/1465/142014l.webp', 'School Rumble'),
(16, '砂ぼうず', 25, 'https://cdn.myanimelist.net/images/anime/6/75536l.webp', 'Sunabouzu'),
(17, 'TEXHNOLYZE', 26, 'https://cdn.myanimelist.net/images/anime/1027/131977l.webp', 'Texhnolyze'),
(18, 'トリニティ・ブラッド', 27, 'https://cdn.myanimelist.net/images/anime/10/24649l.webp', 'Trinity Blood'),
(19, '焼きたて!! ジャぱん', 28, 'https://cdn.myanimelist.net/images/anime/3/76432l.webp', 'Yakitate!! Japan'),
(20, 'ジパング', 29, 'https://cdn.myanimelist.net/images/anime/13/75740l.webp', 'Zipang');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` bigint NOT NULL,
  `avatar_src` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `dislikes` int DEFAULT NULL,
  `likes` int DEFAULT NULL,
  `text` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_comment_id` bigint DEFAULT NULL,
  `watchlist_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `avatar_src`, `created_at`, `dislikes`, `likes`, `text`, `username`, `parent_comment_id`, `watchlist_id`) VALUES
(6, '/pics/default-profile.jpg', '2025-05-04 20:57:13.003662', 0, 0, 'INCREDIBILKE', 'admin', NULL, 3),
(7, '/pics/default-profile.jpg', '2025-05-04 20:57:16.078563', 0, 0, 'adsdw222', 'admin', NULL, 3),
(8, '/pics/default-profile.jpg', '2025-05-04 20:57:20.094544', 0, 0, 'oppa', 'admin', NULL, 3),
(9, '/pics/default-profile.jpg', '2025-05-04 20:57:33.532076', 0, 0, '[Comment deleted by user]', 'admin', NULL, 2),
(10, '/pics/default-profile.jpg', '2025-05-04 20:57:35.194421', 0, 0, '[Comment deleted by user]', 'admin', NULL, 2),
(11, '/pics/default-profile.jpg', '2025-05-04 20:57:37.475491', 0, 0, 'sdasdff', 'admin', 10, 2),
(13, '/pics/default-profile.jpg', '2025-05-04 20:57:48.757052', 0, 0, 'ANOTHNY\nAD', 'admin', 9, 2),
(14, '/pics/default-profile.jpg', '2025-05-04 20:57:52.267618', 0, 0, 'wewe', 'admin', 13, 2),
(20, '/pics/default-profile.jpg', '2025-05-06 02:02:26.566207', 0, 0, 'Best everrrrrrrrrr', 'prov2', NULL, 5),
(21, '/pics/default-profile.jpg', '2025-05-06 02:02:30.201425', 0, 0, 'HAHAHA', 'prov2', NULL, 5),
(22, '/pics/default-profile.jpg', '2025-05-06 02:02:36.299702', 0, 1, '=OOLLLLLTTTTTE', 'prov2', NULL, 5),
(23, '/pics/default-profile.jpg', '2025-05-06 02:03:09.605072', 2, 3, 'HOT MOMS IN THE AREA CLICK THIS LINK https://www.calculatorsoup.com/calculators/discretemathematics/fibonacci-calculator.php', 'prov2', NULL, 5),
(24, '/pics/default-profile.jpg', '2025-05-06 02:05:10.013943', 0, 0, 'Dog water fr fr', 'billybob', NULL, 5),
(25, '/pics/default-profile.jpg', '2025-05-06 02:05:25.833525', 0, 0, 'Say less', 'billybob', 23, 5),
(26, '/pics/default-profile.jpg', '2025-05-06 02:05:32.645975', 0, 0, 'This is a scam', 'billybob', 25, 5),
(27, '/pics/default-profile.jpg', '2025-05-06 02:05:43.155354', 0, 0, 'TRASHHHHH', 'billybob', 20, 5),
(28, '/uploads/profiles/d16bc82a-aab6-458d-90e7-19e22d70f25b_GUTS_SMILE.jpg', '2025-05-06 14:28:49.909769', 7, 1, 'I hate cinammon', 'billybob', NULL, 6),
(29, '/uploads/profiles/d16bc82a-aab6-458d-90e7-19e22d70f25b_GUTS_SMILE.jpg', '2025-05-06 14:29:02.019501', 1, 8, 'ALL HAIL MADARA', 'billybob', NULL, 6),
(30, '/uploads/profiles/d16bc82a-aab6-458d-90e7-19e22d70f25b_GUTS_SMILE.jpg', '2025-05-06 14:29:22.848141', 0, 7, 'NO ALL SHALL KNOW MY PAINN', 'billybob', 29, 6),
(31, '/pics/default-profile.jpg', '2025-05-06 14:31:03.440229', 0, 0, 'Thanks Man', 'prov2', 29, 6),
(32, '/pics/default-profile.jpg', '2025-05-06 14:31:35.496309', 0, 0, 'no way', 'prov2', 30, 6),
(33, '/uploads/profiles/1ab207cd-fd8c-4c40-acc9-ee4545217cb3_bakugo.jpg', '2025-05-06 15:44:53.813440', 0, 0, 'Madara sucks , and naruto rocks', 'billybobinfinite', NULL, 6);

-- --------------------------------------------------------

--
-- Table structure for table `providers`
--

CREATE TABLE `providers` (
  `provider_id` bigint NOT NULL,
  `created_at` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_bio` text COLLATE utf8mb4_general_ci,
  `provider_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_profile_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `public_active_watchlists` bit(1) NOT NULL,
  `public_subscribed_watchlists` bit(1) NOT NULL,
  `verified` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `providers`
--

INSERT INTO `providers` (`provider_id`, `created_at`, `provider_bio`, `provider_email`, `provider_profile_image`, `provider_username`, `public_active_watchlists`, `public_subscribed_watchlists`, `verified`) VALUES
(1, '2025-05-04', '', 'provider1@gmail.com', '/uploads/profiles/7e0917a0-4e9f-4a5f-a484-a61c2e47147d_Assault.png', 'provider1', b'1', b'1', b'0'),
(2, '2025-05-06', NULL, 'gg8@gmail.com', '/pics/default-profile.jpg', 'prov2', b'1', b'1', b'0'),
(3, '2025-05-06', NULL, 'Provider@gmail.com', '/pics/default-profile.jpg', 'Provider', b'1', b'1', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `reported_comments`
--

CREATE TABLE `reported_comments` (
  `id` bigint NOT NULL,
  `is_resolved` bit(1) NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `reported_at` datetime(6) NOT NULL,
  `reported_by` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `resolution_notes` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `resolved_at` datetime(6) DEFAULT NULL,
  `resolved_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `comment_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reported_comments`
--

INSERT INTO `reported_comments` (`id`, `is_resolved`, `reason`, `reported_at`, `reported_by`, `resolution_notes`, `resolved_at`, `resolved_by`, `comment_id`) VALUES
(1, b'0', 'Spam or misleading', '2025-05-06 02:05:56.427854', 'billybob', NULL, NULL, NULL, 23);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint NOT NULL,
  `subscribed_at` datetime(6) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `watchlist_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `subscribed_at`, `user_id`, `watchlist_id`) VALUES
(8, '2025-05-06 14:28:31.091002', 3, 6),
(10, '2025-05-06 15:44:22.847191', 6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint NOT NULL,
  `bio` text COLLATE utf8mb4_general_ci,
  `enabled` bit(1) NOT NULL,
  `join_date` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `profile_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_id` bigint DEFAULT NULL,
  `public_subscribed_watchlists` bit(1) NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `bio`, `enabled`, `join_date`, `password`, `profile_image`, `provider_id`, `public_subscribed_watchlists`, `username`) VALUES
(1, NULL, b'1', '2025-05-02', '$2a$10$SLT0maCdrA2NGrus9hJPzOGcSxsdi2y8zsJFoXZMaA7vzGsPkDDj.', '/pics/default-profile.jpg', NULL, b'1', 'admin'),
(2, NULL, b'1', '2025-05-04', '$2a$10$sZYSdAaFtU0T4zexs8fkpehKftGHTH/wuewqxUeZahAndT62F0/JW', NULL, 1, b'1', 'provider1'),
(3, 'I am KIABA', b'1', '2025-05-04', '$2a$10$3dAIMdtBmVFfkEkZpwSadeUCuFsq58TwJdNU5i26jzoVtVYyzaPkq', '/uploads/profiles/d16bc82a-aab6-458d-90e7-19e22d70f25b_GUTS_SMILE.jpg', NULL, b'1', 'billybob'),
(4, 'I love Angel Beats!', b'0', '2025-05-06', '$2a$10$lObMn0yZADO3V4qllv/Q3.ja1.lw5SL/XBZTVzgpVU04KYPClILYa', '/uploads/profiles/e617d0c8-d475-4f37-b7af-9c154ffccf30_Kirishima.jpg', NULL, b'1', 'angelbeat'),
(5, NULL, b'1', '2025-05-06', '$2a$10$Zf9Twdc1kRgk6919Gv4VQu1oLKNNuEaeh4e81KUESFMId3dZ.XTBm', NULL, 2, b'1', 'prov2'),
(6, 'Im cooler than u', b'1', '2025-05-06', '$2a$10$Tu6BReXYkZ436MWXlRbn0ereYrt2iIm25MQFUNPFq1C1OvoWyLV5m', '/uploads/profiles/1ab207cd-fd8c-4c40-acc9-ee4545217cb3_bakugo.jpg', NULL, b'1', 'billybobinfinite'),
(7, NULL, b'1', '2025-05-06', '$2a$10$H6LMS2yv5/KEXDT77zCXHOPewjSioCyXXFGAzzdl97Oy5f2cQmXSa', NULL, 3, b'1', 'Provider');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role`) VALUES
(1, 'ADMIN'),
(2, 'PROVIDER'),
(3, 'USER'),
(4, 'USER'),
(5, 'PROVIDER'),
(6, 'USER'),
(7, 'PROVIDER');

-- --------------------------------------------------------

--
-- Table structure for table `watchlists`
--

CREATE TABLE `watchlists` (
  `watchlist_id` bigint NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `num_ratings` int DEFAULT NULL,
  `provider_id` bigint NOT NULL,
  `provider_username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `rating` double DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `views` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `watchlists`
--

INSERT INTO `watchlists` (`watchlist_id`, `avatar`, `description`, `num_ratings`, `provider_id`, `provider_username`, `rating`, `thumbnail`, `title`, `views`) VALUES
(2, '/uploads/profiles/7e0917a0-4e9f-4a5f-a484-a61c2e47147d_Assault.png', 'Run run', 1, 1, 'provider1', 2, '/uploads/watchlists/35229c16-a1a6-4e55-a936-ee10f71b8d27_Set your heart a blaze.jpg', 'Best sports anime', 10),
(3, '/uploads/profiles/7e0917a0-4e9f-4a5f-a484-a61c2e47147d_Assault.png', 'asasd', 1, 1, 'provider1', 4, '/uploads/watchlists/4da6aaa5-efb1-4de5-9b9c-62a927365903_GUTS SMILE.jpg', 'asdasd', 9),
(5, '/pics/default-profile.jpg', 'Best anime youll ever see.', 1, 2, 'prov2', 5, '/uploads/watchlists/bf254b64-bfae-4f5b-9ec5-ae436873c73b_Goku.gif', 'Anime ever', 8),
(6, '/pics/default-profile.jpg', 'Sportsssssss', 2, 2, 'prov2', 2.5, '/uploads/watchlists/c1fab887-a86a-43b1-bf8e-ddb367cdedde_blueexorcistcharacters-231371.jpg', 'Sportttsssssss', 7),
(7, '/pics/default-profile.jpg', 'A curated list of top action animes', 0, 3, 'Provider', 0, '/uploads/watchlists/93a1e08b-8e06-4826-ab1c-853019289825_BLue exorcist.jpg', 'Top action animes this season', 3);

-- --------------------------------------------------------

--
-- Table structure for table `watchlist_anime`
--

CREATE TABLE `watchlist_anime` (
  `anime_id` bigint NOT NULL,
  `watchlist_id` bigint NOT NULL,
  `added_at` datetime(6) DEFAULT NULL,
  `display_order` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `watchlist_anime`
--

INSERT INTO `watchlist_anime` (`anime_id`, `watchlist_id`, `added_at`, `display_order`) VALUES
(1, 3, '2025-05-04 20:20:28.349957', 0),
(1, 7, '2025-05-06 15:52:52.530290', 0),
(2, 3, '2025-05-04 20:20:28.359931', 1),
(2, 7, '2025-05-06 15:52:52.538264', 1),
(4, 5, '2025-05-06 02:02:01.366810', 0),
(5, 3, '2025-05-04 20:20:28.366912', 2),
(5, 7, '2025-05-06 15:52:52.548242', 2),
(6, 3, '2025-05-04 20:20:28.374892', 3),
(6, 6, '2025-05-06 14:32:49.082651', 0),
(6, 7, '2025-05-06 15:52:52.556216', 3),
(7, 3, '2025-05-04 20:20:28.381874', 4),
(7, 7, '2025-05-06 15:52:52.563200', 4),
(8, 6, '2025-05-06 14:32:49.092629', 1),
(8, 7, '2025-05-06 15:53:03.967808', 10),
(9, 6, '2025-05-06 14:32:49.098608', 2),
(13, 5, '2025-05-06 02:02:01.376783', 1),
(13, 6, '2025-05-06 14:32:49.107586', 3),
(16, 5, '2025-05-06 02:02:01.382767', 2),
(18, 5, '2025-05-06 02:02:01.388754', 3),
(19, 6, '2025-05-06 14:32:49.114566', 4),
(20, 5, '2025-05-06 02:02:01.398724', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anime`
--
ALTER TABLE `anime`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK4nu588bu4b5ybh2reaovgpuu2` (`mal_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `FK7h839m3lkvhbyv3bcdv7sm4fj` (`parent_comment_id`),
  ADD KEY `FKi1wm7dx3pbkw76pqjedcsql2v` (`watchlist_id`);

--
-- Indexes for table `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`provider_id`),
  ADD UNIQUE KEY `UK6f4r88qnyy0ggyis55oe27pws` (`provider_username`);

--
-- Indexes for table `reported_comments`
--
ALTER TABLE `reported_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKi35c3qm5dguy5fat2lr3kr1nx` (`comment_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK6yrskghxudkxp3e4c7jyirwq` (`user_id`,`watchlist_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD KEY `FKhfh9dx7w3ubf1co1vdev94g3f` (`user_id`);

--
-- Indexes for table `watchlists`
--
ALTER TABLE `watchlists`
  ADD PRIMARY KEY (`watchlist_id`);

--
-- Indexes for table `watchlist_anime`
--
ALTER TABLE `watchlist_anime`
  ADD PRIMARY KEY (`anime_id`,`watchlist_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anime`
--
ALTER TABLE `anime`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `providers`
--
ALTER TABLE `providers`
  MODIFY `provider_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reported_comments`
--
ALTER TABLE `reported_comments`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `watchlists`
--
ALTER TABLE `watchlists`
  MODIFY `watchlist_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `FK7h839m3lkvhbyv3bcdv7sm4fj` FOREIGN KEY (`parent_comment_id`) REFERENCES `comments` (`comment_id`),
  ADD CONSTRAINT `FKi1wm7dx3pbkw76pqjedcsql2v` FOREIGN KEY (`watchlist_id`) REFERENCES `watchlists` (`watchlist_id`);

--
-- Constraints for table `reported_comments`
--
ALTER TABLE `reported_comments`
  ADD CONSTRAINT `FKi35c3qm5dguy5fat2lr3kr1nx` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `FKhfh9dx7w3ubf1co1vdev94g3f` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
