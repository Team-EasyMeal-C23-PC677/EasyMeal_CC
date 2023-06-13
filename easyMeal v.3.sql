-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Jun 2023 pada 03.55
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
-- Database: `ressep`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `categoris`
--

CREATE TABLE `categoris` (
  `id` int(11) NOT NULL,
  `categories_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `categoris`
--

INSERT INTO `categoris` (`id`, `categories_name`) VALUES
(1, 'Daging'),
(2, 'Ikan dan Makanan Laut'),
(3, 'Buah-buahan'),
(4, 'Sayuran'),
(5, 'Produk Susu'),
(6, 'Bahan Kering'),
(7, 'Bumbu dan rempah-rempah'),
(8, 'Minyak dan lemak'),
(9, 'Sumber Protein Nabati'),
(10, 'Bahan Manis'),
(11, 'Saus dan Sambal'),
(12, 'Roti dan Bahan Panggang'),
(13, 'Minuman'),
(14, 'Bahan Umum');

-- --------------------------------------------------------

--
-- Struktur dari tabel `favorite`
--

CREATE TABLE `favorite` (
  `user_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `favorite`
--

INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES
('1', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `ingredient`
--

CREATE TABLE `ingredient` (
  `ing_id` int(11) NOT NULL,
  `ing_name` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `ingredient`
--

INSERT INTO `ingredient` (`ing_id`, `ing_name`, `category_id`) VALUES
(1, 'Pisang tanduk', 3),
(2, 'Wijen putih', 6),
(3, 'Minyak', 8),
(4, 'Tepung beras', 6),
(5, 'Kelapa parut kering', 6),
(6, 'Air', 13),
(7, 'Gula pasir', 10),
(8, 'Baking powder', 12),
(9, 'Garam', 14);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pantry`
--

CREATE TABLE `pantry` (
  `user_id` int(11) NOT NULL,
  `ing_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pantry`
--

INSERT INTO `pantry` (`user_id`, `ing_id`) VALUES
('1', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `recipe_ingredient`
--

CREATE TABLE `recipe_ingredient` (
  `recipe_id` int(11) NOT NULL,
  `ing_id` int(11) NOT NULL,
  `qty` float NOT NULL,
  `unit` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `recipe_ingredient`
--

INSERT INTO `recipe_ingredient` (`recipe_id`, `ing_id`, `qty`, `unit`) VALUES
(1, 1, 2, 'buah'),
(1, 2, 2, 'sdm'),
(1, 3, 250, 'ml'),
(1, 4, 100, 'gram'),
(1, 5, 3, 'sdm'),
(1, 6, 130, 'ml'),
(1, 7, 3, 'sdm'),
(1, 8, 0.25, 'sdt'),
(1, 9, 0.25, 'sdt');

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
  `recipe_img_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `resep`
--

INSERT INTO `resep` (`recipe_id`, `recipe_title`, `recipe_description`, `recipe_total_time`, `recipe_serving`, `recipe_img_url`) VALUES
(1, 'Pisang Goreng Crispy', 'Berbeda dengan pisang goreng biasa, tambahan wijen dalam adonannya akan menambah rasa dan juga tekstur lapisan adonan pisang. Selain itu, ada tambahan gula pasir dan kelapa kering pada lapisan crispy pisang yang bikin adonan tepungnya jadi legit dan gurih.', 60, 4, 'https://storage.googleapis.com/capstone-project677/pisang%20goreng%20krispi.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `shopping_list`
--

CREATE TABLE `shopping_list` (
  `user_id` int(11) NOT NULL,
  `ing_id` int(11) NOT NULL,
  `s_qty` float NOT NULL,
  `s_unit` varchar(50) NOT NULL,
  `is_bought` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `shopping_list`
--

INSERT INTO `shopping_list` (`user_id`, `ing_id`, `s_qty`, `s_unit`, `is_bought`) VALUES
('1', 1, 5, 'buah', 0);

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

--
-- Dumping data untuk tabel `step`
--

INSERT INTO `step` (`step_id`, `step_no`, `step_description`, `recipe_id`) VALUES
(1, 1, 'Kupas pisang tanduk, belah dua memanjang. Potong masing-masing menjadi 3-4 bagian.  Sisihkan.', 1),
(2, 2, 'Adonan: Campur tepung beras , dan kelapa parut kering. Tuang air, gula, dan garam, aduk hingga tercampur rata. Tambahkan wijen, aduk rata.', 1),
(3, 3, 'Celupkan potongan pisang ke dalam adonan tepung.', 1),
(4, 4, 'Panaskan minyak, goreng pisang hingga matang dan kecokelatan. Angkat dan tiriskan.', 1),
(5, 5, 'Siapkan piring, Makanan siap untuk di sajikan.', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `userrecipe`
--

CREATE TABLE `userrecipe` (
  `user_id` int(11) NOT NULL,
  `nama_profil` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `userrecipe`
--

INSERT INTO `userrecipe` (`user_id`, `nama_profil`, `email`, `password`) VALUES
('1', 'admin', 'admin@gmail.com', 'password');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `categoris`
--
ALTER TABLE `categoris`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`user_id`,`recipe_id`),
  ADD KEY `favorite_recipe_id_resep_recipe_id` (`recipe_id`);

--
-- Indeks untuk tabel `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`ing_id`,`category_id`),
  ADD KEY `ingredient_category_id_categoris_id` (`category_id`);

--
-- Indeks untuk tabel `pantry`
--
ALTER TABLE `pantry`
  ADD PRIMARY KEY (`user_id`,`ing_id`),
  ADD KEY `pantry_ing_id_ingredient_ing_id` (`ing_id`);

--
-- Indeks untuk tabel `recipe_ingredient`
--
ALTER TABLE `recipe_ingredient`
  ADD PRIMARY KEY (`recipe_id`,`ing_id`),
  ADD KEY `recipe_ingredient_ing_id_ingredient_ing_id` (`ing_id`);

--
-- Indeks untuk tabel `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`recipe_id`);

--
-- Indeks untuk tabel `shopping_list`
--
ALTER TABLE `shopping_list`
  ADD PRIMARY KEY (`user_id`,`ing_id`),
  ADD KEY `shopping_list_ing_id_ingredient_ing_id` (`ing_id`);

--
-- Indeks untuk tabel `step`
--
ALTER TABLE `step`
  ADD PRIMARY KEY (`step_id`,`recipe_id`),
  ADD KEY `step_recipe_id_resep_recipe_id` (`recipe_id`);

--
-- Indeks untuk tabel `userrecipe`
--
ALTER TABLE `userrecipe`
  MODIFY id INT AUTO_INCREMENT PRIMARY KEY (`user_id`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_recipe_id_resep_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`),
  ADD CONSTRAINT `favorite_user_id_userrecipe_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `ingredient_category_id_categoris_id` FOREIGN KEY (`category_id`) REFERENCES `categoris` (`id`);

--
-- Ketidakleluasaan untuk tabel `pantry`
--
ALTER TABLE `pantry`
  ADD CONSTRAINT `pantry_ing_id_ingredient_ing_id` FOREIGN KEY (`ing_id`) REFERENCES `ingredient` (`ing_id`),
  ADD CONSTRAINT `pantry_user_id_userrecipe_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `recipe_ingredient`
--
ALTER TABLE `recipe_ingredient`
  ADD CONSTRAINT `recipe_ingredient_ing_id_ingredient_ing_id` FOREIGN KEY (`ing_id`) REFERENCES `ingredient` (`ing_id`),
  ADD CONSTRAINT `recipe_ingredient_recipe_id_resep_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`);

--
-- Ketidakleluasaan untuk tabel `shopping_list`
--
ALTER TABLE `shopping_list`
  ADD CONSTRAINT `shopping_list_ing_id_ingredient_ing_id` FOREIGN KEY (`ing_id`) REFERENCES `ingredient` (`ing_id`),
  ADD CONSTRAINT `shopping_list_user_id_userrecipe_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `step`
--
ALTER TABLE `step`
  ADD CONSTRAINT `step_recipe_id_resep_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
