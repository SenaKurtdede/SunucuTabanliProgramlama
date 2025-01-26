-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 05 Oca 2025, 12:00:49
-- Sunucu sürümü: 9.1.0
-- PHP Sürümü: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `arcanus`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `aylar`
--

DROP TABLE IF EXISTS `aylar`;
CREATE TABLE IF NOT EXISTS `aylar` (
  `ay_id` varchar(50) NOT NULL,
  `ay_siralaması` int NOT NULL,
  PRIMARY KEY (`ay_id`),
  KEY `ay_siralaması` (`ay_siralaması`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `aylar`
--

INSERT INTO `aylar` (`ay_id`, `ay_siralaması`) VALUES
('Ocak', 1),
('Şubat', 2),
('Mart', 3),
('Nisan', 4),
('Mayıs', 5),
('Haziran', 6),
('Temmuz', 7),
('Ağustos', 8),
('Eylül', 9),
('Ekim', 10),
('Kasım', 11),
('Aralık', 12);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `doluluk`
--

DROP TABLE IF EXISTS `doluluk`;
CREATE TABLE IF NOT EXISTS `doluluk` (
  `doluluk_orani` int NOT NULL,
  `ay_id` varchar(50) NOT NULL,
  `ay_siralaması` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ay_siralaması`),
  KEY `ay_id` (`ay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `doluluk`
--

INSERT INTO `doluluk` (`doluluk_orani`, `ay_id`, `ay_siralaması`) VALUES
(65, 'Ocak', 1),
(70, 'Şubat', 2),
(68, 'Mart', 3),
(74, 'Nisan', 4),
(71, 'Mayıs', 5),
(69, 'Haziran', 6);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `gelir`
--

DROP TABLE IF EXISTS `gelir`;
CREATE TABLE IF NOT EXISTS `gelir` (
  `gelir_miktari` int NOT NULL,
  `ay_id` int NOT NULL,
  `ay_siralaması` int NOT NULL,
  `gelir_id` int NOT NULL,
  PRIMARY KEY (`gelir_id`),
  KEY `ay_id` (`ay_id`),
  KEY `ay_siralaması` (`ay_siralaması`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hizmetler`
--

DROP TABLE IF EXISTS `hizmetler`;
CREATE TABLE IF NOT EXISTS `hizmetler` (
  `ay_id` varchar(50) NOT NULL,
  `hizmet_adi` varchar(50) NOT NULL,
  `kullanim_sayisi` int NOT NULL,
  PRIMARY KEY (`kullanim_sayisi`),
  KEY `ay_id` (`ay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `hizmetler`
--

INSERT INTO `hizmetler` (`ay_id`, `hizmet_adi`, `kullanim_sayisi`) VALUES
('Subat', 'Restoran Hizmetleri', 300),
('Şubat', 'Restoran Hizmetleri', 471),
('Ocak', 'Restoran Hizmetleri', 500),
('Ocak', 'Havuz Hizmetleri', 541),
('Şubat', 'Havuz Hizmetleri', 548),
('Subat', 'Spa hizmetleri', 600),
('Ocak', 'Oda servisi', 625),
('Mart', 'Spa Hizmetleri', 650),
('Mart', 'Oda Servisi', 700),
('Mart', 'Havuz Hizmetleri', 900),
('Ocak', 'Spa hizmetleri', 1000),
('Mart', 'Restoran Hizmetleri', 1100);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `irklar`
--

DROP TABLE IF EXISTS `irklar`;
CREATE TABLE IF NOT EXISTS `irklar` (
  `irk_adi` varchar(50) NOT NULL,
  `irk numarasi` int NOT NULL,
  PRIMARY KEY (`irk_adi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `irklar`
--

INSERT INTO `irklar` (`irk_adi`, `irk numarasi`) VALUES
('alman', 3),
('diger', 5),
('ingiliz', 4),
('rus', 1),
('turk', 2);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kullanicilar`
--

DROP TABLE IF EXISTS `kullanicilar`;
CREATE TABLE IF NOT EXISTS `kullanicilar` (
  `kullanici_id` int DEFAULT NULL,
  `kullanici_adi` varchar(50) NOT NULL,
  `sifre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `kullanicilar`
--

INSERT INTO `kullanicilar` (`kullanici_id`, `kullanici_adi`, `sifre`) VALUES
(1, 'admin', '1234');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `misafir_analizi`
--

DROP TABLE IF EXISTS `misafir_analizi`;
CREATE TABLE IF NOT EXISTS `misafir_analizi` (
  `irk_adi` varchar(50) NOT NULL,
  `ay_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `irk_miktari` int NOT NULL,
  `islem_id` int NOT NULL,
  PRIMARY KEY (`islem_id`),
  KEY `irk_adi` (`irk_adi`),
  KEY `ay_adi` (`ay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `misafir_analizi`
--

INSERT INTO `misafir_analizi` (`irk_adi`, `ay_id`, `irk_miktari`, `islem_id`) VALUES
('alman', 'Ocak', 162, 1),
('diger', 'Ocak', 61, 2),
('ingiliz', 'Ocak', 57, 3),
('rus', 'Ocak', 560, 4),
('turk', 'Ocak', 154, 5),
('alman', 'Şubat', 126, 6),
('diger', 'Şubat', 100, 7),
('ingiliz', 'Şubat', 200, 8),
('rus', 'Şubat', 100, 9),
('turk', 'Şubat', 150, 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `oda_tipi_doluluk`
--

DROP TABLE IF EXISTS `oda_tipi_doluluk`;
CREATE TABLE IF NOT EXISTS `oda_tipi_doluluk` (
  `oda_tipi` varchar(50) NOT NULL,
  `ay_id` varchar(50) NOT NULL,
  `ay_siralaması` int NOT NULL,
  `doluluk_orani` int NOT NULL,
  KEY `ay_id` (`ay_id`),
  KEY `ay_siralaması` (`ay_siralaması`),
  KEY `doluluk_orani` (`doluluk_orani`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `oda_tipi_doluluk`
--

INSERT INTO `oda_tipi_doluluk` (`oda_tipi`, `ay_id`, `ay_siralaması`, `doluluk_orani`) VALUES
('süit', 'Ocak', 0, 0),
('süit', 'Şubat', 0, 0),
('süit', 'Mart', 0, 0),
('süit', 'Nisan', 0, 0),
('süit', 'Mayıs', 0, 0),
('süit', 'Haziran', 0, 0),
('süit', 'Temmuz', 0, 0),
('süit', 'Ağustos', 0, 0),
('süit', 'Eylül', 0, 0),
('süit', 'Ekim', 0, 0),
('süit', 'Kasım', 0, 0),
('süit', 'Aralık', 0, 0),
('Aile Odası', 'Ocak', 0, 0),
('Aile Odası', 'Şubat', 0, 0),
('Aile Odası', 'Mart', 0, 0),
('Aile Odası', 'Nisan', 0, 0),
('Aile Odası', 'Mayıs', 0, 0),
('Aile Odası', 'Haziran', 0, 0),
('Aile Odası', 'Temmuz', 0, 0),
('Aile Odası', 'Ağustos', 0, 0),
('Aile Odası', 'Eylül', 0, 0),
('Aile Odası', 'Ekim', 0, 0),
('Aile Odası', 'Kasım', 0, 0),
('Aile Odası', 'Aralık', 0, 0),
('Standart Oda', 'Ocak', 0, 0),
('Standart Oda', 'Şubat', 0, 0),
('Standart Oda', 'Mart', 0, 0),
('Standart Oda', 'Nisan', 0, 0),
('Standart Oda', 'Mayıs', 0, 0),
('Standart Oda', 'Haziran', 0, 0),
('Standart Oda', 'Temmuz', 0, 0),
('Standart Oda', 'Ağustos', 0, 0),
('Standart Oda', 'Eylül', 0, 0),
('Standart Oda', 'Ekim', 0, 0),
('Standart Oda', 'Kaıs', 0, 0),
('Standart Oda', '', 0, 0),
('süit', 'Ocak', 0, 0),
('süit', 'Şubat', 0, 0),
('süit', 'Mart', 0, 0),
('süit', 'Nisan', 0, 0),
('süit', 'Mayıs', 0, 0),
('süit', 'Haziran', 0, 0),
('süit', 'Temmuz', 0, 0),
('süit', 'Ağustos', 0, 0),
('süit', 'Eylül', 0, 0),
('süit', 'Ekim', 0, 0),
('süit', 'Kasım', 0, 0),
('süit', 'Aralık', 0, 0),
('Aile Odası', 'Ocak', 0, 0),
('Aile Odası', 'Şubat', 0, 0),
('Aile Odası', 'Mart', 0, 0),
('Aile Odası', 'Nisan', 0, 0),
('Aile Odası', 'Mayıs', 0, 0),
('Aile Odası', 'Haziran', 0, 0),
('Aile Odası', 'Temmuz', 0, 0),
('Aile Odası', 'Ağustos', 0, 0),
('Aile Odası', 'Eylül', 0, 0),
('Aile Odası', 'Ekim', 0, 0),
('Aile Odası', 'Kasım', 0, 0),
('Aile Odası', 'Aralık', 0, 0),
('Standart Oda', 'Ocak', 0, 0),
('Standart Oda', 'Şubat', 0, 0),
('Standart Oda', 'Mart', 0, 0),
('Standart Oda', 'Nisan', 0, 0),
('Standart Oda', 'Mayıs', 0, 0),
('Standart Oda', 'Haziran', 0, 0),
('Standart Oda', 'Temmuz', 0, 0),
('Standart Oda', 'Ağustos', 0, 0),
('Standart Oda', 'Eylül', 0, 0),
('Standart Oda', 'Ekim', 0, 0),
('Standart Oda', 'Kaıs', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0),
('Standart Oda', '', 0, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sezonsal_doluluk`
--

DROP TABLE IF EXISTS `sezonsal_doluluk`;
CREATE TABLE IF NOT EXISTS `sezonsal_doluluk` (
  `doluluk_orani` int NOT NULL,
  `ay_id` int NOT NULL,
  `mevsim_adi` varchar(50) NOT NULL,
  PRIMARY KEY (`mevsim_adi`),
  KEY `ay_id` (`ay_id`),
  KEY `doluluk_miktari` (`doluluk_orani`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `sezonsal_doluluk`
--

INSERT INTO `sezonsal_doluluk` (`doluluk_orani`, `ay_id`, `mevsim_adi`) VALUES
(75, 0, 'İlkbahar'),
(55, 0, 'Kış'),
(70, 0, 'Sonbahar'),
(95, 0, 'Yaz');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yas`
--

DROP TABLE IF EXISTS `yas`;
CREATE TABLE IF NOT EXISTS `yas` (
  `cocuk_sayisi` int NOT NULL,
  `yetiskin_sayisi` int NOT NULL,
  `ay_id` varchar(50) NOT NULL,
  PRIMARY KEY (`ay_id`),
  KEY `ay_id` (`ay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `yas`
--

INSERT INTO `yas` (`cocuk_sayisi`, `yetiskin_sayisi`, `ay_id`) VALUES
(265, 198, 'Ağustos'),
(60, 10, 'Aralık'),
(50, 10, 'Ekim'),
(75, 82, 'Eylül'),
(35, 45, 'Haziran'),
(90, 10, 'Kasım'),
(20, 25, 'Mart'),
(30, 35, 'Mayıs'),
(25, 30, 'Nisan'),
(10, 15, 'Ocak'),
(15, 20, 'Şubat'),
(45, 85, 'Temmuz');

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `doluluk`
--
ALTER TABLE `doluluk`
  ADD CONSTRAINT `doluluk_ibfk_1` FOREIGN KEY (`ay_id`) REFERENCES `aylar` (`ay_id`);

--
-- Tablo kısıtlamaları `hizmetler`
--
ALTER TABLE `hizmetler`
  ADD CONSTRAINT `hizmetler_ibfk_1` FOREIGN KEY (`ay_id`) REFERENCES `aylar` (`ay_id`);

--
-- Tablo kısıtlamaları `misafir_analizi`
--
ALTER TABLE `misafir_analizi`
  ADD CONSTRAINT `misafir_analizi_ibfk_1` FOREIGN KEY (`ay_id`) REFERENCES `aylar` (`ay_id`),
  ADD CONSTRAINT `misafir_analizi_ibfk_2` FOREIGN KEY (`irk_adi`) REFERENCES `irklar` (`irk_adi`);

--
-- Tablo kısıtlamaları `yas`
--
ALTER TABLE `yas`
  ADD CONSTRAINT `yas_ibfk_1` FOREIGN KEY (`ay_id`) REFERENCES `aylar` (`ay_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
