-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2023 at 07:20 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ea`
--

-- --------------------------------------------------------

--
-- Table structure for table `categoris`
--

CREATE TABLE `categoris` (
  `id` int(11) NOT NULL,
  `categories_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categoris`
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
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `user_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES
(1, 1),
(1, 6),
(1, 9);

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

CREATE TABLE `ingredient` (
  `ing_id` int(11) NOT NULL,
  `ing_name` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ingredient`
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
(9, 'Garam', 14),
(10, 'Ayam', 1),
(11, 'Minyak Wijen', 8),
(12, 'Royco kaldu Ayam Spesial', 14),
(13, 'Merica putih', 7),
(14, 'Bawang Putih', 7),
(15, 'Jahe', 7),
(16, 'Daun bawang', 4),
(17, 'Babat Sapi', 1),
(18, 'Daun Salam', 14),
(19, 'Bawang Merah', 7),
(20, 'Lengkuas', 7),
(21, 'Serai', 7),
(22, 'Kecap Manis', 10),
(23, 'Kaldu Sapi', 14),
(24, 'Cabai Rawit Merah', 14),
(25, 'Cabai Merah Kriting', 14),
(26, 'Terasi Bakar', 7),
(27, 'Merica Bubuk', 7),
(28, 'Bawang Bombay', 7),
(29, 'Brokoli', 4),
(30, 'Saus Teriyaki Instan', 11),
(31, 'Filet Dada Ayam Tanpa Kulit', 1),
(32, 'Udang Segar', 2),
(33, 'Kaldu Jamur', 14),
(34, 'Tomat', 3),
(35, 'Tepung Tapioka', 6),
(36, 'Egg tofu/tahu sutera', 9),
(37, 'Cumi-cumi', 2),
(38, 'Wortel', 4),
(39, 'Jamur Merang', 9),
(40, 'Jamur Kuping', 9),
(41, 'Pakchoy', 4),
(42, 'Tepung Maizena', 6),
(43, 'Saus Tiram Instan', 11),
(44, 'Cabai Rawit Hijau', 14),
(45, 'Kencur', 7),
(46, 'Tempe', 9),
(47, 'Ceker Ayam', 1),
(48, 'Telur Ayam', 9),
(49, 'Taoge', 4),
(50, 'Cabai Merah Besar', 14),
(51, 'Kerupuk', 12),
(52, 'Jeruk Nipis', 3),
(53, 'Jeruk Limau', 3),
(54, 'Pisang Ambon', 3),
(55, 'Susu Cair Putih', 13),
(56, 'Gula Pasir Palem', 10),
(57, 'Kismis', 3),
(58, 'SariWangi Milk Tea Teh Tarik', 13),
(59, 'Tepung Terigu', 6),
(60, 'Baking Soda', 12),
(61, 'Choco Chips', 10);

-- --------------------------------------------------------

--
-- Table structure for table `pantry`
--

CREATE TABLE `pantry` (
  `user_id` int(11) NOT NULL,
  `ing_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pantry`
--

INSERT INTO `pantry` (`user_id`, `ing_id`) VALUES
(1, 3),
(1, 32),
(1, 48),
(1, 55);

-- --------------------------------------------------------

--
-- Table structure for table `recipe_ingredient`
--

CREATE TABLE `recipe_ingredient` (
  `recipe_id` int(11) NOT NULL,
  `ing_id` int(11) NOT NULL,
  `qty` float NOT NULL,
  `unit` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `recipe_ingredient`
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
(1, 9, 0.25, 'sdt'),
(2, 9, 2.5, 'gram'),
(2, 10, 500, 'gram'),
(2, 11, 1, 'sdm'),
(2, 12, 1, 'sdt'),
(2, 13, 2.5, 'sdt'),
(2, 14, 3, 'siung'),
(2, 15, 1, 'cm'),
(2, 16, 1, 'Batang'),
(3, 3, 3, 'sdm'),
(3, 6, 1, 'Liter'),
(3, 9, 2, 'sdm'),
(3, 14, 12, 'siung'),
(3, 15, 3, 'cm'),
(3, 17, 500, 'gram'),
(3, 18, 3, 'lembar'),
(3, 19, 10, 'siung'),
(3, 20, 2, 'cm'),
(3, 21, 1, 'batang'),
(3, 22, 6, 'sdm'),
(3, 23, 1, 'sdt'),
(3, 24, 8, 'buah'),
(3, 25, 5, 'buah'),
(3, 26, 1, 'sdt'),
(3, 27, 1, 'sdt'),
(4, 3, 4, 'sdm'),
(4, 9, 2.5, 'gram'),
(4, 14, 4, 'siung'),
(4, 27, 2.5, 'gram'),
(4, 28, 1, 'buah'),
(4, 29, 350, 'gram'),
(4, 30, 2, 'sdm'),
(4, 31, 500, 'gram'),
(5, 3, 3, 'sdm'),
(5, 6, 400, 'ml'),
(5, 7, 1, 'sdt'),
(5, 9, 1, 'sdt'),
(5, 14, 2, 'siung'),
(5, 15, 3, 'cm'),
(5, 16, 2, 'batang'),
(5, 22, 120, 'ml'),
(5, 27, 1, 'sdm'),
(5, 32, 500, 'gram'),
(5, 33, 2, 'sdt'),
(5, 34, 1, 'buah'),
(5, 35, 1, 'sdm'),
(6, 3, 3, 'sdm'),
(6, 6, 215, 'ml'),
(6, 9, 2.5, 'gram'),
(6, 11, 2, 'sdm'),
(6, 14, 3, 'siung'),
(6, 15, 3, 'cm'),
(6, 16, 1, 'batang'),
(6, 24, 3, 'buah'),
(6, 27, 2.5, 'gram'),
(6, 28, 50, 'gram'),
(6, 32, 150, 'gram'),
(6, 36, 2, 'bungkus'),
(6, 37, 150, 'gram'),
(6, 38, 200, 'gram'),
(6, 39, 150, 'gram'),
(6, 40, 100, 'gram'),
(6, 41, 150, 'gram'),
(6, 42, 1, 'sdm'),
(6, 43, 3, 'sdm'),
(7, 7, 2.5, 'gram'),
(7, 9, 5, 'gram'),
(7, 12, 5, 'gram'),
(7, 14, 5, 'siung'),
(7, 24, 4, 'buah'),
(7, 44, 9, 'buah'),
(7, 45, 5, 'cm'),
(7, 46, 200, 'gram'),
(8, 3, 2, 'sdm'),
(8, 6, 1, 'Liter'),
(8, 7, 2, 'sdt'),
(8, 9, 16.25, 'gram'),
(8, 12, 1.25, 'gram'),
(8, 14, 2, 'siung'),
(8, 19, 3, 'siung'),
(8, 22, 34, 'gram'),
(8, 24, 4, 'buah'),
(8, 41, 2, 'batang'),
(8, 45, 3, 'cm'),
(8, 47, 300, 'gram'),
(8, 48, 2, 'butir'),
(8, 49, 50, 'gram'),
(8, 50, 1, 'buah'),
(8, 51, 30, 'gram'),
(9, 3, 2, 'sdm'),
(9, 9, 1, 'sdm'),
(9, 12, 2, 'sdt'),
(9, 14, 6, 'siung'),
(9, 24, 12, 'buah'),
(9, 27, 2.5, 'gram'),
(9, 31, 600, 'gram'),
(9, 52, 4, 'buah'),
(9, 53, 2, 'buah'),
(10, 3, 80, 'ml'),
(10, 8, 1, 'sdt'),
(10, 48, 2, 'butir'),
(10, 54, 230, 'gram'),
(10, 55, 40, 'ml'),
(10, 56, 70, 'gram'),
(10, 57, 3, 'sdm'),
(10, 58, 2, 'bag'),
(10, 59, 125, 'gram'),
(10, 60, 1, 'sdt'),
(10, 61, 3, 'sdm');

-- --------------------------------------------------------

--
-- Table structure for table `resep`
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
-- Dumping data for table `resep`
--

INSERT INTO `resep` (`recipe_id`, `recipe_title`, `recipe_description`, `recipe_total_time`, `recipe_serving`, `recipe_img_url`) VALUES
(1, 'Pisang Goreng Crispy', 'Berbeda dengan pisang goreng biasa, tambahan wijen dalam adonannya akan menambah rasa dan juga tekstur lapisan adonan pisang. Selain itu, ada tambahan gula pasir dan kelapa kering pada lapisan crispy pisang yang bikin adonan tepungnya jadi legit dan gurih.', 60, 4, 'https://storage.googleapis.com/capstone-project677/pisang%20goreng%20krispi.jpg'),
(2, 'Ayam Kukus Bawang Putih', 'Selain merupakan sumber protein hewani, ayam kukus cenderung mudah diterima anak karena teksturnya yang lembut, mudah meresap dengan bumbu sehingga lezat, dan relatif aman untuk dikenalkan karena minim allergen. Sementara itu, sumber karbohidratnya bisa berasal dari nasi tim yang gurih dan lembut. ', 60, 4, 'https://storage.googleapis.com/capstone-project677/ayam_kukus_bawang_putih.jpeg'),
(3, 'Babat Gongso', 'Babat gongso merupakan hidangan legendaris khas semarang.', 60, 4, 'https://storage.googleapis.com/capstone-project677/resep-babat-gongso.jpeg'),
(4, 'Chicken Teriyaki', 'Teriyaki adalah teknik memasak klasik khas Jepang sejak abad ke-18 yang menggunakan saus tare. Saus ini tradisionalnya terdiri dari kecap asin, mirin, dan gula, yang dimasak atau dipanggang bersama protein hewani hingga meresap.', 30, 4, 'https://storage.googleapis.com/capstone-project677/chicken_teriyaki.jpeg'),
(5, 'Tumis Udang Kecap', 'Sajian seafood seperti tumis udang kecap adalah menu andalan yang memberimu banyak kemudahan. Bahan-bahannya mudah didapat, cara memasaknya pun tidak sulit.', 30, 4, 'https://storage.googleapis.com/capstone-project677/udang-kecap-20220615-183525.jpg'),
(6, 'Sapo Tahu Seafood', 'Menu Peranakan Cina ini dimasak dalam panci berbahan tanah liat atau claypot. Mengapa panci tanah liat ini digunakan sebagai alat masaknya? Selain karena menyerap panas lebih baik, hidangan juga akan hangat lebih lama. Kamu bisa mencoba resep ini sebagai menu makan malam praktis tanpa harus lagi memasak lauk lainnya. ', 70, 4, 'https://storage.googleapis.com/capstone-project677/sapo-tahu-saus-tiram.jpg'),
(7, 'Tempe Sambal Goang', 'Resep sambal goang adalah salah satu menu klasik khas Sunda yang pedasnya nampol dan rasanya enak banget. Sambal goang adalah sejenis sambal dengan bahan-bahan mentah yang bisa kamu sajikan secara cepat. ', 30, 4, 'https://storage.googleapis.com/capstone-project677/sambal-tempe-goang-devina-hermawan-foto-resep-utama.jpg'),
(8, 'Seblak Ceker', 'Resep seblak ceker adalah fenomena kekinian yang datang dari Jawa Barat.', 60, 4, 'https://storage.googleapis.com/capstone-project677/Seblak%20Ceker.jpeg'),
(9, 'Sate Taichan', 'Indonesia, negeri dengan perbendaharaan jenis sate yang begitu beragam ini belum lama menambahkan Sate Taichan sebagai salah satu koleksinya. Mungkin sekitar dua tahun sudah berlalu sejak dimulainya demam sate pedas yang satu ini dan hingga kini namanya tetap berkibar serta diminati segala kalangan.', 60, 3, 'https://storage.googleapis.com/capstone-project677/sate-taichan.jpg'),
(10, 'Bolu Pisang Kukus', 'Ingin ide manis dan bebas repot untuk menyambut waktunya berbuka puasa? Resep bolu pisang kukus tanpa mixer anti gagal dan tanpa oven ini cocok banget buat kamu. Bahan-bahannya sangat sederhana, yaitu pisang, gula palem, telur, dan minyak. Untuk alatnya, cukup siapkan whisk, spatula, dan loyang roti, loyang brownies, atau pinggan tahan panas yang ukurannya tidak lebih besar daripada diameter panci pengukus di dapurmu.', 75, 6, 'https://storage.googleapis.com/capstone-project677/bolu_pisang_kukus.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `shopping_list`
--

CREATE TABLE `shopping_list` (
  `user_id` int(11) NOT NULL,
  `ing_id` int(11) NOT NULL,
  `s_qty` float NOT NULL,
  `s_unit` varchar(50) NOT NULL,
  `is_bought` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shopping_list`
--

INSERT INTO `shopping_list` (`user_id`, `ing_id`, `s_qty`, `s_unit`, `is_bought`) VALUES
(1, 1, 5, 'buah', 0),
(1, 36, 600, 'gram', 0),
(1, 38, 100, 'gram', 0),
(1, 46, 300, 'gram', 0),
(1, 59, 1, 'kg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `step`
--

CREATE TABLE `step` (
  `step_id` int(11) NOT NULL,
  `step_no` int(11) NOT NULL,
  `step_description` text NOT NULL,
  `recipe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `step`
--

INSERT INTO `step` (`step_id`, `step_no`, `step_description`, `recipe_id`) VALUES
(1, 1, 'Kupas pisang tanduk, belah dua memanjang. Potong masing-masing menjadi 3-4 bagian.  Sisihkan.', 1),
(1, 1, 'Lumuri seluruh bagian daging ayam dengan minyak wijen, Royco Kaldu Ayam Spesial, garam, merica, bawang putih, jahe, dan daun bawang yang sudah di potong kasar hingga merata.', 2),
(1, 1, 'Siapkan Bumbu halus (8 buah cabai rawit merah, 5 buah cabai merah keriting, 7 siung bawang putih, 5 butir bawang merah, 1 sdt terasi bakar, 2 sdt garam, 1 sdt merica bubuk)', 3),
(1, 1, 'Cuci brokoli hingga bersih, siapkan air baru untuk rebus brokoli dengan garam. Tunggu hingga agak lembut. tiriskan', 4),
(1, 1, 'Siapkan Bumbu Perendam (1 sdm tepung tapioka, 1 sdt garam, 1 sdm merica putih bubuk). cuci udang yang sudah bersih. balurkan udang bersih kedalam bumbu perendam selama 10 menit', 5),
(1, 1, 'Siapkan bahan cincang (bawang putih). tahu sutera potong setebal 2 cm. cumi potong melintang 1 cm, jamur-jamuran dipotong sesuai ukuran masing-masing. daun bawang potong besar, jahe iris, dan bawang bombay iris', 6),
(1, 1, 'Tempe dipotong dadu setebal 2cm. balur tempe dadu dengan air garam. lalu goreng sebentar. tiriskan', 7),
(1, 1, 'Siapkan bumbu halus (blender 2 siung bawang putih, 3 butir bawang merah, 3 cm kencur, 1 buah cabai merah besar, 4 buah cabai rawit merah)', 8),
(1, 1, 'Siapkan Bahan Sambal di blender (12 buah cabai rawit merah, 2.5 gram garam, 2 buah perasan jeruk limau)', 9),
(1, 1, 'Haluskan pisang menggunakan garpu. Aduk rata bersama susu cair.', 10),
(2, 2, 'Adonan: Campur tepung beras , dan kelapa parut kering. Tuang air, gula, dan garam, aduk hingga tercampur rata. Tambahkan wijen, aduk rata.', 1),
(2, 2, 'Diamkan dalam kulkas minimal selama 2 jam agar bumbunya meresap. Keluarkan.', 2),
(2, 2, 'Rebus babat bersama garam, bawang putih potong melintang, jahe di geprek, dan daun salam hingga empuk. Angkat. Potong-potong kotak 3 cm. Sisihkan', 3),
(2, 2, 'Panaskan minyak, tumis bawang putih cincang dan potongan bawang bombay hingga harum. Masukkan daging ayam, saus teriyaki instan, dan merica, oseng hingga matang dan berwarna coklat.', 4),
(2, 2, 'Panaskan minyak, tumis bawang putih cincang dan jahe geprek hingga harum. Masukkan udang yang sudah dibalur dengan bumbu perendam, Kaldu Jamur, gula pasir, merica bubuk, Kecap Manis, dan air.', 5),
(2, 2, 'Siapkan bahan pengental (1 sdm tepung maizena dan 1 sdm air)', 6),
(2, 2, 'Siapkan bahan untuk membuat sambel Goang. Haluskan kencur bersama garam dan bawang putih. Tambahkan cabai rawit merah, cabai rawit hijau, dan Royco Kaldu Ayam. Ulek hingga cabai hancur dan tercampur rata bersama bahan lain.', 7),
(2, 2, 'Rebus kerupuk selama 10 menit. Rebus ceker bersama air sampai matang dan empuk. Ukur kaldunya 400 ml. Sisihkan.', 8),
(2, 2, 'Potong-potong ayam setebal 1.5 cm. Lumuri daging ayam dengan Royco Kaldu Ayam, bawang putih, merica dan perasan jeruk nipis secara merata. Diamkan dalam kulkas selama satu jam.', 9),
(2, 2, 'Kocok gula palem bersama telur dan SariWangi Milk Tea Teh Tarik hingga rata menggunakan whisk.', 10),
(3, 3, 'Celupkan potongan pisang ke dalam adonan tepung.', 1),
(3, 3, 'Kukus dalam dandang panas hingga matang. Angkat.', 2),
(3, 3, 'Panaskan minyak, tumis potongan bawang merah hingga kecokelatan. Masukkan bumbu halus, lengkuas, dan serai, tumis hingga harum.', 3),
(3, 3, 'Jika sudah sayuran sudah layu dan daging ayam telah matang. matikan kompor. siap disajikan dengan nasi panas', 4),
(3, 3, 'Masak hingga 1/2 matang, masukkan potongan daun bawang dan tomat, aduk rata hingga benar-benar matang', 5),
(3, 3, 'Panaskan minyak, goreng tahu di atas api besar tahu hingga kecokelatan. Tutup wajan saat menggoreng agar minyak tidak meletup keluar. Angkat dan tiriskan. Sisihkan.', 6),
(3, 3, 'Satukan tempe dadu goreng dengan sambal Goang. lalu di tumbuk dan aduk rata. siap disajikan', 7),
(3, 3, 'Tumis bumbu halus sampai harum. Sisihkan bumbu di sisi wajan. Masukkan telur. Aduk sampai berbutir. Tambahkan ceker dan kerupuk rebus. Aduk rata.', 8),
(3, 3, 'Tusukkan 3-4 potong daging ayam ke tusukan satai.', 9),
(3, 3, 'Masukkan campuran pisang, aduk. Tuang minyak sambil diaduk hingga rata', 10),
(4, 4, 'Panaskan minyak, goreng pisang hingga matang dan kecokelatan. Angkat dan tiriskan.', 1),
(4, 4, 'Sajikan bersama nasi', 2),
(4, 4, 'Masukkan babat yang sudah direbus, aduk rata. Tambahkan Kecap Manis Hitam Gurih, Royco Kaldu Sapi, dan air, masak hingga meresap dan airnya menyusut. Angkat. Sajikan.', 3),
(4, 4, 'Angkat dan siap disajikan', 5),
(4, 4, 'Panaskan minyak, tumis bawang putih, bawang bombay, dan jahe hingga harum. Masukkan udang, cumi, dan wortel, aduk sebentar. Tambahkan jamur dan Saus Tiram instan, tumis hingga layu.', 6),
(4, 4, 'Masukkan pakchoy dan taoge. Aduk sampai layu. Tuangkan air rebusan ceker. Aduk rata. Masukkan Kecap Manis. Aduk rata.', 8),
(4, 4, 'Panaskan wajan pemanggang, olesi dengan minyak. Panggang satai di atas grill pan sambil sesekali dibolak-balik hingga matang. Angkat, sisihkan.', 9),
(4, 4, 'Masukkan tepung, baking powder, dan baking soda ke dalam mangkuk isi adonan menggunakan saringan sambil diayak. Aduk rata. Tambahkan chocolate chips, aduk.', 10),
(5, 5, 'Siapkan piring, Makanan siap untuk di sajikan.', 1),
(5, 5, 'Tuang air, minyak wijen, garam, dan merica bubuk. Masak hingga mendidih. Tambahkan pakchoy, tahu, cabai, dan daun bawang, aduk.', 6),
(5, 5, 'berikan rasa dengan masukkan garam, Royco Kaldu Ayam, merica bubuk dan gula pasir. Aduk rata. Masak sampai matang. siap dihidangkan', 8),
(5, 5, 'Sajikan satai bersama sambal pelengkap.', 9),
(5, 5, 'Siapkan loyang persegi panjang yang sudah diolesi margarin, tuang adonan bolu ke dalamnya.', 10),
(6, 6, 'Tuang larutan bahan pengental, aduk hingga mengental. Angkat. Sajikan', 6),
(6, 6, 'Kukus dalam dandang panas hingga matang. Angkat. Keluarkan dari dalam loyang. Sajikan.', 10);

-- --------------------------------------------------------

--
-- Table structure for table `userrecipe`
--

CREATE TABLE `userrecipe` (
  `user_id` int(11) NOT NULL,
  `nama_profil` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userrecipe`
--

INSERT INTO `userrecipe` (`user_id`, `nama_profil`, `email`, `password`) VALUES
(1, 'admin', 'admin@gmail.com', 'password');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoris`
--
ALTER TABLE `categoris`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`user_id`,`recipe_id`),
  ADD KEY `favorite_recipe_id_resep_recipe_id` (`recipe_id`);

--
-- Indexes for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`ing_id`,`category_id`),
  ADD KEY `ingredient_category_id_categoris_id` (`category_id`);

--
-- Indexes for table `pantry`
--
ALTER TABLE `pantry`
  ADD PRIMARY KEY (`user_id`,`ing_id`),
  ADD KEY `pantry_ing_id_ingredient_ing_id` (`ing_id`);

--
-- Indexes for table `recipe_ingredient`
--
ALTER TABLE `recipe_ingredient`
  ADD PRIMARY KEY (`recipe_id`,`ing_id`),
  ADD KEY `recipe_ingredient_ing_id_ingredient_ing_id` (`ing_id`);

--
-- Indexes for table `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`recipe_id`);

--
-- Indexes for table `shopping_list`
--
ALTER TABLE `shopping_list`
  ADD PRIMARY KEY (`user_id`,`ing_id`),
  ADD KEY `shopping_list_ing_id_ingredient_ing_id` (`ing_id`);

--
-- Indexes for table `step`
--
ALTER TABLE `step`
  ADD PRIMARY KEY (`step_id`,`recipe_id`),
  ADD KEY `step_recipe_id_resep_recipe_id` (`recipe_id`);

--
-- Indexes for table `userrecipe`
--
ALTER TABLE `userrecipe`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `userrecipe`
--
ALTER TABLE `userrecipe`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_recipe_id_resep_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`),
  ADD CONSTRAINT `favorite_user_id_userrecipe_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);

--
-- Constraints for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `ingredient_category_id_categoris_id` FOREIGN KEY (`category_id`) REFERENCES `categoris` (`id`);

--
-- Constraints for table `pantry`
--
ALTER TABLE `pantry`
  ADD CONSTRAINT `pantry_ing_id_ingredient_ing_id` FOREIGN KEY (`ing_id`) REFERENCES `ingredient` (`ing_id`),
  ADD CONSTRAINT `pantry_user_id_userrecipe_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);

--
-- Constraints for table `recipe_ingredient`
--
ALTER TABLE `recipe_ingredient`
  ADD CONSTRAINT `recipe_ingredient_ing_id_ingredient_ing_id` FOREIGN KEY (`ing_id`) REFERENCES `ingredient` (`ing_id`),
  ADD CONSTRAINT `recipe_ingredient_recipe_id_resep_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`);

--
-- Constraints for table `shopping_list`
--
ALTER TABLE `shopping_list`
  ADD CONSTRAINT `shopping_list_ing_id_ingredient_ing_id` FOREIGN KEY (`ing_id`) REFERENCES `ingredient` (`ing_id`),
  ADD CONSTRAINT `shopping_list_user_id_userrecipe_user_id` FOREIGN KEY (`user_id`) REFERENCES `userrecipe` (`user_id`);

--
-- Constraints for table `step`
--
ALTER TABLE `step`
  ADD CONSTRAINT `step_recipe_id_resep_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `resep` (`recipe_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
