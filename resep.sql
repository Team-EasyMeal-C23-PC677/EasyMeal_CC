-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Bulan Mei 2023 pada 09.45
-- Versi server: 10.4.21-MariaDB
-- Versi PHP: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `resep`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `favorite`
--

CREATE TABLE `favorite` (
  `user_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `is_favorite` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `ingredient`
--

CREATE TABLE `ingredient` (
  `ing_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `ing_name` varchar(100) NOT NULL,
  `ing_category` varchar(50) NOT NULL,
  `ing_img_url` varchar(100) NOT NULL
  -- `qty` int(11) NOT NULL,
  -- `unit` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pantry`
--

CREATE TABLE `pantry` (
  `user_id` int(11) NOT NULL,
  `ing_id` int(11) NOT NULL,
  `is_pantry` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `resep`
--

CREATE TABLE `resep` (
  `recipe_id` int(11) NOT NULL,
  `recipe_title` varchar(100) NOT NULL,
  `recipe_description` text NOT NULL,
  `recipe_total_time` int(11) NOT NULL,
  `recipe_serving` int(11) NOT NULL,
  `recipe_img_url` varchar(100) NOT NULL,
  `recipe_category` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `shopping_list`
--

CREATE TABLE `shopping_list` (
  `user_id` int(11) NOT NULL,
  `ing_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `is_have` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `step`
--

CREATE TABLE `step` (
  `step_id` int(11) NOT NULL,
  `step_no` int(11) NOT NULL,
  `step_description` text NOT NULL,
  `recipe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `userrecipe`
--

CREATE TABLE `userrecipe` (
  `user_id` int(11) NOT NULL,
  `nama_profil` varchar(100) NOT NULL,
  `img_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`user_id`,`recipe_id`),
  ADD KEY `fk_favorite_recipe_id` (`recipe_id`);

--
-- Indeks untuk tabel `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`ing_id`),
  ADD KEY `fk_ingredient_recipe_id` (`recipe_id`);

--
-- Indeks untuk tabel `pantry`
--
ALTER TABLE `pantry`
  ADD PRIMARY KEY (`user_id`,`ing_id`),
  ADD KEY `fk_pantry_ing_id` (`ing_id`);

--
-- Indeks untuk tabel `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`recipe_id`);

--
-- Indeks untuk tabel `shopping_list`
--
ALTER TABLE `shopping_list`
  ADD PRIMARY KEY (`user_id`,`ing_id`);

--
-- Indeks untuk tabel `step`
--
ALTER TABLE `step`
  ADD PRIMARY KEY (`step_id`),
  -- ADD UNIQUE KEY `step_no` (`step_no`),
  ADD KEY `fk_step_recipe_id` (`recipe_id`);

--
-- Indeks untuk tabel `userrecipe`
--
ALTER TABLE `userrecipe`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `step`
--
-- ALTER TABLE `step`
--   MODIFY `step_no` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `fk_favorite_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`),
  ADD CONSTRAINT `fk_favorite_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `fk_ingredient_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`);


ALTER TABLE 'shopping_list'
  ADD CONSTRAINT `fk_shopping_list_ing_id` FOREIGN KEY (`ing_id`) REFERENCES `ingredient` (`ing_id`),
  ADD CONSTRAINT `fk_shopping_list_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);
-- Ketidakleluasaan untuk tabel `pantry`
--
ALTER TABLE `pantry`
  ADD CONSTRAINT `fk_pantry_ing_id` FOREIGN KEY (`ing_id`) REFERENCES `ingredient` (`ing_id`),
  ADD CONSTRAINT `fk_pantry_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `step`
--
ALTER TABLE `step`
  ADD CONSTRAINT `fk_step_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`);
COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
