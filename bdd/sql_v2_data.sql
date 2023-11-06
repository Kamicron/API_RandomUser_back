-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 24, 2023 at 09:04 PM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apocalypse_reborn`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateRandomPNJ` ()   BEGIN
    DECLARE randomGenderID INT;
    DECLARE randomEthnicityID INT;
    DECLARE randomFirstname VARCHAR(45);
    DECLARE randomLastname VARCHAR(45);
    DECLARE randomPhotoID INT;
    DECLARE randomWorkID INT;

    -- Choisir un genre aléatoirement
    SET randomGenderID = (SELECT id_gender FROM gender ORDER BY RAND() LIMIT 1);

    -- Choisir une ethnie aléatoirement
    SET randomEthnicityID = (SELECT id_ethnicity FROM ethnicity ORDER BY RAND() LIMIT 1);

    -- Choisir un prénom en fonction de l'ethnie et du genre
    -- Remarque: Vous devrez ajuster cette requête en fonction de la structure réelle de votre base de données
    SET randomFirstname = (SELECT firstname FROM your_table_with_firstnames WHERE gender_id = randomGenderID AND ethnicity_id = randomEthnicityID ORDER BY RAND() LIMIT 1);

    -- Choisir un nom en fonction de l'ethnie
    -- Remarque: Vous devrez ajuster cette requête en fonction de la structure réelle de votre base de données
    SET randomLastname = (SELECT lastname FROM your_table_with_lastnames WHERE ethnicity_id = randomEthnicityID ORDER BY RAND() LIMIT 1);

    -- Choisir une photo en fonction de l'ethnie et du genre
    SET randomPhotoID = (SELECT id_photo FROM photo WHERE gender_id = randomGenderID AND ethnicity_id = randomEthnicityID ORDER BY RAND() LIMIT 1);

    -- Choisir un métier aléatoirement
    SET randomWorkID = (SELECT id_work FROM work ORDER BY RAND() LIMIT 1);

    -- Insérer le nouveau PNJ dans la table 'pnj'
    INSERT INTO pnj (firstname, lastname, gender_id_gender, ethnicity_id_ethnicity, photo_id_photo, work_id_work)
    VALUES (randomFirstname, randomLastname, randomGenderID, randomEthnicityID, randomPhotoID, randomWorkID);
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ethnicdistributionbynationality`
--

CREATE TABLE `ethnicdistributionbynationality` (
  `nationality_id_nationnality` int(11) NOT NULL,
  `ethnicity_id_ethnicity` int(11) NOT NULL,
  `percentage` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ethnicdistributionbynationality`
--

INSERT INTO `ethnicdistributionbynationality` (`nationality_id_nationnality`, `ethnicity_id_ethnicity`, `percentage`) VALUES
(1, 1, 85),
(1, 2, 3),
(1, 3, 2),
(1, 4, 7),
(1, 5, 2),
(1, 6, 0.9),
(1, 7, 0.1),
(2, 1, 1),
(2, 2, 1),
(2, 3, 0.2),
(2, 4, 97.5),
(2, 5, 0.1),
(2, 6, 0.1),
(2, 7, 0.1),
(4, 1, 10),
(4, 2, 1),
(4, 3, 5),
(4, 4, 1),
(4, 5, 1),
(4, 6, 81),
(4, 7, 0.1);

-- --------------------------------------------------------

--
-- Table structure for table `ethnicity`
--

CREATE TABLE `ethnicity` (
  `id_ethnicity` int(11) NOT NULL,
  `label` varchar(45) DEFAULT NULL,
  `display_name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ethnicity`
--

INSERT INTO `ethnicity` (`id_ethnicity`, `label`, `display_name`) VALUES
(1, 'european', 'Européen'),
(2, 'african', 'Africain'),
(3, 'chinese', 'Chinois'),
(4, 'arab', 'Nord Africaine'),
(5, 'hispanic', 'Hispanique'),
(6, 'slavique', 'Slave'),
(7, 'oceanian', 'Océanique');

-- --------------------------------------------------------

--
-- Table structure for table `firstname`
--

CREATE TABLE `firstname` (
  `id_firstname` int(11) NOT NULL,
  `label` varchar(45) DEFAULT NULL,
  `ethnicity_id_ethnicity` int(11) NOT NULL,
  `gender_id_gender` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `firstname`
--

INSERT INTO `firstname` (`id_firstname`, `label`, `ethnicity_id_ethnicity`, `gender_id_gender`) VALUES
(1, 'Marie', 1, 2),
(2, 'Sophie', 1, 2),
(3, 'Claire', 1, 2),
(4, 'Isabelle', 1, 2),
(5, 'Laura', 1, 2),
(6, 'Julie', 1, 2),
(7, 'Elodie', 1, 2),
(8, 'Chloé', 1, 2),
(9, 'Camille', 1, 2),
(10, 'Sarah', 1, 2),
(11, 'Lucie', 1, 2),
(12, 'Marine', 1, 2),
(13, 'Charlotte', 1, 2),
(14, 'Audrey', 1, 2),
(15, 'Pauline', 1, 2),
(16, 'Amandine', 1, 2),
(17, 'Emilie', 1, 2),
(18, 'Caroline', 1, 2),
(19, 'Anne', 1, 2),
(20, 'Céline', 1, 2),
(21, 'Justine', 1, 2),
(22, 'Alexandra', 1, 2),
(23, 'Aurélie', 1, 2),
(24, 'Margaux', 1, 2),
(25, 'Eva', 1, 2),
(26, 'Lisa', 1, 2),
(27, 'Laetitia', 1, 2),
(28, 'Léa', 1, 2),
(29, 'Clémence', 1, 2),
(30, 'Valentine', 1, 2),
(31, 'Jean', 1, 1),
(32, 'Pierre', 1, 1),
(33, 'Jacques', 1, 1),
(34, 'Paul', 1, 1),
(35, 'Nicolas', 1, 1),
(36, 'Guillaume', 1, 1),
(37, 'Lucas', 1, 1),
(38, 'Maxime', 1, 1),
(39, 'Julien', 1, 1),
(40, 'Benoit', 1, 1),
(41, 'Thomas', 1, 1),
(42, 'Laurent', 1, 1),
(43, 'Vincent', 1, 1),
(44, 'David', 1, 1),
(45, 'Sebastien', 1, 1),
(46, 'Olivier', 1, 1),
(47, 'Bruno', 1, 1),
(48, 'Patrick', 1, 1),
(49, 'Daniel', 1, 1),
(50, 'Alexandre', 1, 1),
(51, 'Frédéric', 1, 1),
(52, 'Christophe', 1, 1),
(53, 'Michel', 1, 1),
(54, 'Sylvain', 1, 1),
(55, 'Mathieu', 1, 1),
(56, 'Eric', 1, 1),
(57, 'Franck', 1, 1),
(58, 'Damien', 1, 1),
(59, 'Marc', 1, 1),
(60, 'Cédric', 1, 1),
(61, 'Abdoulaye', 2, 1),
(62, 'Babacar', 2, 1),
(63, 'Cheikh', 2, 1),
(64, 'Daouda', 2, 1),
(65, 'El Hadji', 2, 1),
(66, 'Fadel', 2, 1),
(67, 'Gorgui', 2, 1),
(68, 'Habib', 2, 1),
(69, 'Idrissa', 2, 1),
(70, 'Jamal', 2, 1),
(71, 'Karamoko', 2, 1),
(72, 'Lamine', 2, 1),
(73, 'Mamadou', 2, 1),
(74, 'Ndiaga', 2, 1),
(75, 'Omar', 2, 1),
(76, 'Papa', 2, 1),
(77, 'Quincy', 2, 1),
(78, 'Rachid', 2, 1),
(79, 'Samba', 2, 1),
(80, 'Tidiane', 2, 1),
(81, 'Usman', 2, 1),
(82, 'Vusumuzi', 2, 1),
(83, 'Wasiu', 2, 1),
(84, 'Wallid', 2, 1),
(85, 'Yaw', 2, 1),
(86, 'Zakaria', 2, 1),
(87, 'Alou', 2, 1),
(88, 'Bouba', 2, 1),
(89, 'Cisse', 2, 1),
(90, 'Diallo', 2, 1),
(91, 'Amina', 2, 2),
(92, 'Yasmina', 2, 2),
(93, 'Lina', 2, 2),
(94, 'Sofia', 2, 2),
(95, 'Amira', 2, 2),
(96, 'Nour', 2, 2),
(97, 'Leila', 2, 2),
(98, 'Hana', 2, 2),
(99, 'Sarah', 2, 2),
(100, 'Fatima', 2, 2),
(101, 'Zahra', 2, 2),
(102, 'Ines', 2, 2),
(103, 'Sana', 2, 2),
(104, 'Rania', 2, 2),
(105, 'Mariam', 2, 2),
(106, 'Aya', 2, 2),
(107, 'Malak', 2, 2),
(108, 'Asma', 2, 2),
(109, 'Salma', 2, 2),
(110, 'Houda', 2, 2),
(111, 'Jihane', 2, 2),
(112, 'Wafa', 2, 2),
(113, 'Meryem', 2, 2),
(114, 'Rim', 2, 2),
(115, 'Farah', 2, 2),
(116, 'Imene', 2, 2),
(117, 'Saida', 2, 2),
(118, 'Hayat', 2, 2),
(119, 'Samia', 2, 2),
(120, 'Sabrina', 2, 2),
(121, 'Kazuki', 3, 1),
(122, 'Hiroshi', 3, 1),
(123, 'Ryo', 3, 1),
(124, 'Takahiro', 3, 1),
(125, 'Haruki', 3, 1),
(126, 'Yuki', 3, 1),
(127, 'Kaito', 3, 1),
(128, 'Sho', 3, 1),
(129, 'Satoshi', 3, 1),
(130, 'Kenji', 3, 1),
(131, 'Taichi', 3, 1),
(132, 'Koji', 3, 1),
(133, 'Tatsuya', 3, 1),
(134, 'Hikaru', 3, 1),
(135, 'Masashi', 3, 1),
(136, 'Riku', 3, 1),
(137, 'Yusuke', 3, 1),
(138, 'Takumi', 3, 1),
(139, 'Akihiro', 3, 1),
(140, 'Yoshinori', 3, 1),
(141, 'Yuya', 3, 1),
(142, 'Kazuya', 3, 1),
(143, 'Shinji', 3, 1),
(144, 'Daisuke', 3, 1),
(145, 'Haru', 3, 1),
(146, 'Shota', 3, 1),
(147, 'Toshiro', 3, 1),
(148, 'Ryota', 3, 1),
(149, 'Shogo', 3, 1),
(150, 'Hiroki', 3, 1),
(151, 'Kazuhiko', 3, 1),
(152, 'Yumi', 3, 2),
(153, 'Mai', 3, 2),
(154, 'Aiko', 3, 2),
(155, 'Ayumi', 3, 2),
(156, 'Rina', 3, 2),
(157, 'Sakura', 3, 2),
(158, 'Hana', 3, 2),
(159, 'Yuna', 3, 2),
(160, 'Emi', 3, 2),
(161, 'Haruhi', 3, 2),
(162, 'Yoko', 3, 2),
(163, 'Miyuki', 3, 2),
(164, 'Natsumi', 3, 2),
(165, 'Kaori', 3, 2),
(166, 'Nana', 3, 2),
(167, 'Yui', 3, 2),
(168, 'Rika', 3, 2),
(169, 'Airi', 3, 2),
(170, 'Misaki', 3, 2),
(171, 'Sayuri', 3, 2),
(172, 'Yukiko', 3, 2),
(173, 'Ayaka', 3, 2),
(174, 'Eri', 3, 2),
(175, 'Akiko', 3, 2),
(176, 'Asuka', 3, 2),
(177, 'Nanami', 3, 2),
(178, 'Miki', 3, 2),
(179, 'Yuriko', 3, 2),
(180, 'Naomi', 3, 2),
(181, 'Miho', 3, 2),
(182, 'Yoshiko', 3, 2),
(183, 'Moana', 7, 2),
(184, 'Lea', 7, 2),
(185, 'Tia', 7, 2),
(186, 'Marama', 7, 2),
(187, 'Aroha', 7, 2),
(188, 'Kiri', 7, 2),
(189, 'Ataahua', 7, 2),
(190, 'Anahera', 7, 2),
(191, 'Mere', 7, 2),
(192, 'Tui', 7, 2),
(193, 'Ria', 7, 2),
(194, 'Ngaio', 7, 2),
(195, 'Wai', 7, 2),
(196, 'Hana', 7, 2),
(197, 'Whina', 7, 2),
(198, 'Tara', 7, 2),
(199, 'Huia', 7, 2),
(200, 'Awhina', 7, 2),
(201, 'Rui', 7, 2),
(202, 'Manaia', 7, 2),
(203, 'Aaria', 7, 2),
(204, 'Pania', 7, 2),
(205, 'Teuila', 7, 2),
(206, 'Iwa', 7, 2),
(207, 'Makere', 7, 2),
(208, 'Miru', 7, 2),
(209, 'Herewini', 7, 2),
(210, 'Raukura', 7, 2),
(211, 'Mahuika', 7, 2),
(212, 'Matiu', 7, 2),
(213, 'Whetu', 7, 2),
(214, 'Rau', 7, 2),
(215, 'Rina', 7, 2),
(216, 'Pare', 7, 2),
(217, 'Kara', 7, 2),
(218, 'Miri', 7, 2),
(219, 'Tiri', 7, 2),
(220, 'Tane', 7, 2),
(221, 'Tama', 7, 2),
(222, 'Piki', 7, 2),
(223, 'Tuhi', 7, 2),
(224, 'Koa', 7, 2),
(225, 'Miriama', 7, 2),
(226, 'Hinewai', 7, 2),
(227, 'Huhana', 7, 2),
(228, 'Ruiha', 7, 2),
(229, 'Tawhiri', 7, 2),
(230, 'Reka', 7, 2),
(231, 'Roma', 7, 2),
(232, 'Mareikura', 7, 2),
(233, 'Te Ata', 7, 2),
(234, 'Kai', 7, 1),
(235, 'Tane', 7, 1),
(236, 'Mana', 7, 1),
(237, 'Rangi', 7, 1),
(238, 'Iro', 7, 1),
(239, 'Ari', 7, 1),
(240, 'Mako', 7, 1),
(241, 'Tamati', 7, 1),
(242, 'Hemi', 7, 1),
(243, 'Wiremu', 7, 1),
(244, 'Hoani', 7, 1),
(245, 'Tama', 7, 1),
(246, 'Anaru', 7, 1),
(247, 'Rawiri', 7, 1),
(248, 'Piri', 7, 1),
(249, 'Tawhiri', 7, 1),
(250, 'Rongo', 7, 1),
(251, 'Matui', 7, 1),
(252, 'Kauri', 7, 1),
(253, 'Mikaere', 7, 1),
(254, 'Hare', 7, 1),
(255, 'Pita', 7, 1),
(256, 'Whetu', 7, 1),
(257, 'Teo', 7, 1),
(258, 'Koro', 7, 1),
(259, 'Rua', 7, 1),
(260, 'Waka', 7, 1),
(261, 'Kiri', 7, 1),
(262, 'Keanu', 7, 1),
(263, 'Manaia', 7, 1),
(264, 'Riki', 7, 1),
(265, 'Akarana', 7, 1),
(266, 'Rata', 7, 1),
(267, 'Hau', 7, 1),
(268, 'Rongo', 7, 1),
(269, 'Tama', 7, 1),
(270, 'Pono', 7, 1),
(271, 'Eruera', 7, 1),
(272, 'Tiki', 7, 1),
(273, 'Apera', 7, 1),
(274, 'Turi', 7, 1),
(275, 'Hemi', 7, 1),
(276, 'Manu', 7, 1),
(277, 'Aroha', 7, 1),
(278, 'Tahi', 7, 1),
(279, 'Rau', 7, 1),
(280, 'Toa', 7, 1),
(281, 'Kahurangi', 7, 1),
(282, 'Taika', 7, 1),
(283, 'Rui', 7, 1),
(284, 'Whiro', 7, 1),
(285, 'Ivan', 6, 1),
(286, 'Dmitri', 6, 1),
(287, 'Nikolai', 6, 1),
(288, 'Sergei', 6, 1),
(289, 'Pavel', 6, 1),
(290, 'Mikhail', 6, 1),
(291, 'Yuri', 6, 1),
(292, 'Vladimir', 6, 1),
(293, 'Aleksandr', 6, 1),
(294, 'Oleg', 6, 1),
(295, 'Alexei', 6, 1),
(296, 'Anatoly', 6, 1),
(297, 'Igor', 6, 1),
(298, 'Anton', 6, 1),
(299, 'Yaroslav', 6, 1),
(300, 'Konstantin', 6, 1),
(301, 'Valery', 6, 1),
(302, 'Andrei', 6, 1),
(303, 'Gennady', 6, 1),
(304, 'Roman', 6, 1),
(305, 'Kirill', 6, 1),
(306, 'Denis', 6, 1),
(307, 'Dmitry', 6, 1),
(308, 'Pyotr', 6, 1),
(309, 'Vyacheslav', 6, 1),
(310, 'Viktor', 6, 1),
(311, 'Vasili', 6, 1),
(312, 'Fyodor', 6, 1),
(313, 'Maxim', 6, 1),
(314, 'Stepan', 6, 1),
(315, 'Semyon', 6, 1),
(316, 'Ilya', 6, 1),
(317, 'Timur', 6, 1),
(318, 'Stanislav', 6, 1),
(319, 'Evgeny', 6, 1),
(320, 'Boris', 6, 1),
(321, 'Grigory', 6, 1),
(322, 'Filipp', 6, 1),
(323, 'Mark', 6, 1),
(324, 'Vladislav', 6, 1),
(325, 'Lev', 6, 1),
(326, 'Leonid', 6, 1),
(327, 'Nestor', 6, 1),
(328, 'Svyatoslav', 6, 1),
(329, 'Vsevolod', 6, 1),
(330, 'Miroslav', 6, 1),
(331, 'Vadim', 6, 1),
(332, 'Arseny', 6, 1),
(333, 'Iosif', 6, 1),
(334, 'Oskar', 6, 1),
(335, 'Rodion', 6, 1),
(336, 'Olga', 6, 2),
(337, 'Irina', 6, 2),
(338, 'Natalia', 6, 2),
(339, 'Ekaterina', 6, 2),
(340, 'Svetlana', 6, 2),
(341, 'Tatiana', 6, 2),
(342, 'Anastasia', 6, 2),
(343, 'Elena', 6, 2),
(344, 'Marina', 6, 2),
(345, 'Oksana', 6, 2),
(346, 'Anna', 6, 2),
(347, 'Lyudmila', 6, 2),
(348, 'Yulia', 6, 2),
(349, 'Maria', 6, 2),
(350, 'Alla', 6, 2),
(351, 'Sofia', 6, 2),
(352, 'Galina', 6, 2),
(353, 'Polina', 6, 2),
(354, 'Ksenia', 6, 2),
(355, 'Yana', 6, 2),
(356, 'Nadezhda', 6, 2),
(357, 'Alina', 6, 2),
(358, 'Vera', 6, 2),
(359, 'Larisa', 6, 2),
(360, 'Inna', 6, 2),
(361, 'Victoria', 6, 2),
(362, 'Yelena', 6, 2),
(363, 'Lilia', 6, 2),
(364, 'Valeria', 6, 2),
(365, 'Kristina', 6, 2),
(366, 'Alyona', 6, 2),
(367, 'Elizaveta', 6, 2),
(368, 'Nina', 6, 2),
(369, 'Olesya', 6, 2),
(370, 'Violetta', 6, 2),
(371, 'Raisa', 6, 2),
(372, 'Izabella', 6, 2),
(373, 'Daria', 6, 2),
(374, 'Karina', 6, 2),
(375, 'Mila', 6, 2),
(376, 'Margarita', 6, 2),
(377, 'Veronika', 6, 2),
(378, 'Vlada', 6, 2),
(379, 'Sonia', 6, 2),
(380, 'Albina', 6, 2),
(381, 'Lada', 6, 2),
(382, 'Anya', 6, 2),
(383, 'Valentina', 6, 2),
(384, 'Alevtina', 6, 2),
(385, 'Zinaida', 6, 2),
(386, 'Rada', 6, 2),
(387, 'Carlos', 5, 1),
(388, 'Juan', 5, 1),
(389, 'José', 5, 1),
(390, 'Miguel', 5, 1),
(391, 'Antonio', 5, 1),
(392, 'Javier', 5, 1),
(393, 'Francisco', 5, 1),
(394, 'Pedro', 5, 1),
(395, 'Alejandro', 5, 1),
(396, 'Diego', 5, 1),
(397, 'Fernando', 5, 1),
(398, 'Sergio', 5, 1),
(399, 'Ricardo', 5, 1),
(400, 'Manuel', 5, 1),
(401, 'Rafael', 5, 1),
(402, 'Mario', 5, 1),
(403, 'Enrique', 5, 1),
(404, 'Eduardo', 5, 1),
(405, 'Roberto', 5, 1),
(406, 'Jorge', 5, 1),
(407, 'Alberto', 5, 1),
(408, 'Ramón', 5, 1),
(409, 'Martín', 5, 1),
(410, 'Héctor', 5, 1),
(411, 'Luis', 5, 1),
(412, 'Guillermo', 5, 1),
(413, 'Oscar', 5, 1),
(414, 'Rubén', 5, 1),
(415, 'Daniel', 5, 1),
(416, 'Salvador', 5, 1),
(417, 'Ángel', 5, 1),
(418, 'Adrián', 5, 1),
(419, 'Andrés', 5, 1),
(420, 'Pablo', 5, 1),
(421, 'Alfonso', 5, 1),
(422, 'Julio', 5, 1),
(423, 'Cristian', 5, 1),
(424, 'Ivan', 5, 1),
(425, 'Gonzalo', 5, 1),
(426, 'Víctor', 5, 1),
(427, 'Emilio', 5, 1),
(428, 'Gabriel', 5, 1),
(429, 'Ignacio', 5, 1),
(430, 'Joaquín', 5, 1),
(431, 'Félix', 5, 1),
(432, 'Rodrigo', 5, 1),
(433, 'Isaac', 5, 1),
(434, 'Mauricio', 5, 1),
(435, 'Domingo', 5, 1),
(436, 'Tomás', 5, 1),
(437, 'Raul', 5, 1),
(438, 'Samuel', 5, 1),
(439, 'María', 5, 2),
(440, 'Ana', 5, 2),
(441, 'Isabel', 5, 2),
(442, 'Sofía', 5, 2),
(443, 'Laura', 5, 2),
(444, 'Patricia', 5, 2),
(445, 'Sara', 5, 2),
(446, 'Carmen', 5, 2),
(447, 'Teresa', 5, 2),
(448, 'Lucía', 5, 2),
(449, 'Paula', 5, 2),
(450, 'Pilar', 5, 2),
(451, 'Daniela', 5, 2),
(452, 'Rosa', 5, 2),
(453, 'Inés', 5, 2),
(454, 'Julia', 5, 2),
(455, 'Cristina', 5, 2),
(456, 'Elena', 5, 2),
(457, 'Natalia', 5, 2),
(458, 'Claudia', 5, 2),
(459, 'Silvia', 5, 2),
(460, 'Beatriz', 5, 2),
(461, 'Marta', 5, 2),
(462, 'Raquel', 5, 2),
(463, 'Irene', 5, 2),
(464, 'Noelia', 5, 2),
(465, 'Alicia', 5, 2),
(466, 'Esther', 5, 2),
(467, 'Carla', 5, 2),
(468, 'Rocío', 5, 2),
(469, 'Aurora', 5, 2),
(470, 'Gabriela', 5, 2),
(471, 'Olga', 5, 2),
(472, 'Sonia', 5, 2),
(473, 'Mónica', 5, 2),
(474, 'Victoria', 5, 2),
(475, 'Lorena', 5, 2),
(476, 'Susana', 5, 2),
(477, 'Yolanda', 5, 2),
(478, 'Adriana', 5, 2),
(479, 'Eva', 5, 2),
(480, 'Marina', 5, 2),
(481, 'Angela', 5, 2),
(482, 'Miriam', 5, 2),
(483, 'Blanca', 5, 2),
(484, 'Verónica', 5, 2),
(485, 'Dolores', 5, 2),
(486, 'Fátima', 5, 2),
(487, 'Juana', 5, 2),
(488, 'Gloria', 5, 2),
(489, 'Leticia', 5, 2),
(490, 'Mohamed', 4, 1),
(491, 'Ahmed', 4, 1),
(492, 'Ali', 4, 1),
(493, 'Abdel', 4, 1),
(494, 'Youssef', 4, 1),
(495, 'Omar', 4, 1),
(496, 'Tariq', 4, 1),
(497, 'Ismail', 4, 1),
(498, 'Nabil', 4, 1),
(499, 'Faisal', 4, 1),
(500, 'Khalid', 4, 1),
(501, 'Jamal', 4, 1),
(502, 'Rachid', 4, 1),
(503, 'Hassan', 4, 1),
(504, 'Samir', 4, 1),
(505, 'Amine', 4, 1),
(506, 'Karim', 4, 1),
(507, 'Mounir', 4, 1),
(508, 'Idris', 4, 1),
(509, 'Adel', 4, 1),
(510, 'Ibrahim', 4, 1),
(511, 'Mustafa', 4, 1),
(512, 'Walid', 4, 1),
(513, 'Sami', 4, 1),
(514, 'Hicham', 4, 1),
(515, 'Farid', 4, 1),
(516, 'Ayoub', 4, 1),
(517, 'Said', 4, 1),
(518, 'Abdou', 4, 1),
(519, 'Aziz', 4, 1),
(520, 'Anwar', 4, 1),
(521, 'Salim', 4, 1),
(522, 'Najib', 4, 1),
(523, 'Mahmoud', 4, 1),
(524, 'Faycal', 4, 1),
(525, 'Imad', 4, 1),
(526, 'Yassine', 4, 1),
(527, 'Mehdi', 4, 1),
(528, 'Zakaria', 4, 1),
(529, 'Ziad', 4, 1),
(530, 'Hakim', 4, 1),
(531, 'Bilal', 4, 1),
(532, 'Riyad', 4, 1),
(533, 'El-Hadj', 4, 1),
(534, 'Tahar', 4, 1),
(535, 'Rafik', 4, 1),
(536, 'Nacer', 4, 1),
(537, 'Mokhtar', 4, 1),
(538, 'Sofiane', 4, 1),
(539, 'Salah', 4, 1),
(540, 'Fatima', 4, 2),
(541, 'Aisha', 4, 2),
(542, 'Leila', 4, 2),
(543, 'Sarah', 4, 2),
(544, 'Nadia', 4, 2),
(545, 'Amira', 4, 2),
(546, 'Salma', 4, 2),
(547, 'Malika', 4, 2),
(548, 'Samira', 4, 2),
(549, 'Zahra', 4, 2),
(550, 'Houda', 4, 2),
(551, 'Lamia', 4, 2),
(552, 'Naima', 4, 2),
(553, 'Yasmine', 4, 2),
(554, 'Fatiha', 4, 2),
(555, 'Wafa', 4, 2),
(556, 'Rania', 4, 2),
(557, 'Meryem', 4, 2),
(558, 'Rachida', 4, 2),
(559, 'Hanan', 4, 2),
(560, 'Sana', 4, 2),
(561, 'Kenza', 4, 2),
(562, 'Loubna', 4, 2),
(563, 'Nawal', 4, 2),
(564, 'Saida', 4, 2),
(565, 'Souad', 4, 2),
(566, 'Nour', 4, 2),
(567, 'Asma', 4, 2),
(568, 'Sabrina', 4, 2),
(569, 'Widad', 4, 2),
(570, 'Fadila', 4, 2),
(571, 'Amina', 4, 2),
(572, 'Dalia', 4, 2),
(573, 'Imane', 4, 2),
(574, 'Nabila', 4, 2),
(575, 'Raja', 4, 2),
(576, 'Jamila', 4, 2),
(577, 'Hafida', 4, 2),
(578, 'Zineb', 4, 2),
(579, 'Selma', 4, 2),
(580, 'Khadija', 4, 2),
(581, 'Hajar', 4, 2),
(582, 'Mona', 4, 2),
(583, 'Afaf', 4, 2),
(584, 'Ilham', 4, 2),
(585, 'Soraya', 4, 2),
(586, 'Oumaima', 4, 2),
(587, 'Aziza', 4, 2),
(588, 'Rim', 4, 2),
(589, 'James', 1, 1),
(590, 'John', 1, 1),
(591, 'Robert', 1, 1),
(592, 'Michael', 1, 1),
(593, 'William', 1, 1),
(594, 'David', 1, 1),
(595, 'Richard', 1, 1),
(596, 'Joseph', 1, 1),
(597, 'Thomas', 1, 1),
(598, 'Charles', 1, 1),
(599, 'Henry', 1, 1),
(600, 'George', 1, 1),
(601, 'Paul', 1, 1),
(602, 'Edward', 1, 1),
(603, 'Peter', 1, 1),
(604, 'Christopher', 1, 1),
(605, 'Daniel', 1, 1),
(606, 'Matthew', 1, 1),
(607, 'Donald', 1, 1),
(608, 'Anthony', 1, 1),
(609, 'Mark', 1, 1),
(610, 'Andrew', 1, 1),
(611, 'Stephen', 1, 1),
(612, 'Brian', 1, 1),
(613, 'Kevin', 1, 1),
(614, 'Alexander', 1, 1),
(615, 'Nicholas', 1, 1),
(616, 'Philip', 1, 1),
(617, 'Simon', 1, 1),
(618, 'Patrick', 1, 1),
(619, 'Ian', 1, 1),
(620, 'Gregory', 1, 1),
(621, 'Timothy', 1, 1),
(622, 'Adam', 1, 1),
(623, 'Benjamin', 1, 1),
(624, 'Martin', 1, 1),
(625, 'Frederick', 1, 1),
(626, 'Jeremy', 1, 1),
(627, 'Graham', 1, 1),
(628, 'Jonathan', 1, 1),
(629, 'Adrian', 1, 1),
(630, 'Walter', 1, 1),
(631, 'Sean', 1, 1),
(632, 'Douglas', 1, 1),
(633, 'Nathan', 1, 1),
(634, 'Craig', 1, 1),
(635, 'Victor', 1, 1),
(636, 'Cameron', 1, 1),
(637, 'Keith', 1, 1),
(638, 'Bryan', 1, 1),
(639, 'Mary', 1, 2),
(640, 'Patricia', 1, 2),
(641, 'Jennifer', 1, 2),
(642, 'Linda', 1, 2),
(643, 'Elizabeth', 1, 2),
(644, 'Barbara', 1, 2),
(645, 'Susan', 1, 2),
(646, 'Margaret', 1, 2),
(647, 'Sarah', 1, 2),
(648, 'Jessica', 1, 2),
(649, 'Dorothy', 1, 2),
(650, 'Karen', 1, 2),
(651, 'Emily', 1, 2),
(652, 'Nancy', 1, 2),
(653, 'Sandra', 1, 2),
(654, 'Laura', 1, 2),
(655, 'Catherine', 1, 2),
(656, 'Christine', 1, 2),
(657, 'Stephanie', 1, 2),
(658, 'Rebecca', 1, 2),
(659, 'Sharon', 1, 2),
(660, 'Michelle', 1, 2),
(661, 'Melissa', 1, 2),
(662, 'Betty', 1, 2),
(663, 'Deborah', 1, 2),
(664, 'Anna', 1, 2),
(665, 'Janet', 1, 2),
(666, 'Kathleen', 1, 2),
(667, 'Amanda', 1, 2),
(668, 'Heather', 1, 2),
(669, 'Nicole', 1, 2),
(670, 'Virginia', 1, 2),
(671, 'Marie', 1, 2),
(672, 'Julia', 1, 2),
(673, 'Samantha', 1, 2),
(674, 'Alice', 1, 2),
(675, 'Diane', 1, 2),
(676, 'Angela', 1, 2),
(677, 'Rachel', 1, 2),
(678, 'Helen', 1, 2),
(679, 'Valerie', 1, 2),
(680, 'Gloria', 1, 2),
(681, 'Sylvia', 1, 2),
(682, 'Theresa', 1, 2),
(683, 'Amy', 1, 2),
(684, 'Hannah', 1, 2),
(685, 'Joan', 1, 2),
(686, 'Louise', 1, 2),
(687, 'Megan', 1, 2),
(688, 'Oliver', 1, 1),
(689, 'Oscar', 1, 1),
(690, 'Erik', 1, 1),
(691, 'Axel', 1, 1),
(692, 'Felix', 1, 1),
(693, 'Theo', 1, 1),
(694, 'Henrik', 1, 1),
(695, 'Carl', 1, 1),
(696, 'Simon', 1, 1),
(697, 'Anton', 1, 1),
(698, 'Otto', 1, 1),
(699, 'Sebastian', 1, 1),
(700, 'Karl', 1, 1),
(701, 'Gustav', 1, 1),
(702, 'Tobias', 1, 1),
(703, 'Emil', 1, 1),
(704, 'Max', 1, 1),
(705, 'Hans', 1, 1),
(706, 'Lukas', 1, 1),
(707, 'Leon', 1, 1),
(708, 'Benjamin', 1, 1),
(709, 'Martin', 1, 1),
(710, 'Daniel', 1, 1),
(711, 'Elias', 1, 1),
(712, 'Nils', 1, 1),
(713, 'Viktor', 1, 1),
(714, 'Johannes', 1, 1),
(715, 'Julian', 1, 1),
(716, 'Noah', 1, 1),
(717, 'Rasmus', 1, 1),
(718, 'Jakob', 1, 1),
(719, 'Stefan', 1, 1),
(720, 'Andreas', 1, 1),
(721, 'Adam', 1, 1),
(722, 'Samuel', 1, 1),
(723, 'Matthias', 1, 1),
(724, 'Alexander', 1, 1),
(725, 'Fabian', 1, 1),
(726, 'Liam', 1, 1),
(727, 'Jonathan', 1, 1),
(728, 'Leo', 1, 1),
(729, 'Arvid', 1, 1),
(730, 'Tim', 1, 1),
(731, 'Oskar', 1, 1),
(732, 'Finn', 1, 1),
(733, 'Sven', 1, 1),
(734, 'Tom', 1, 1),
(735, 'Jens', 1, 1),
(736, 'Jan', 1, 1),
(737, 'Linus', 1, 1),
(738, 'Lucas', 1, 1),
(739, 'Emma', 1, 2),
(740, 'Ella', 1, 2),
(741, 'Maja', 1, 2),
(742, 'Lilly', 1, 2),
(743, 'Alma', 1, 2),
(744, 'Hanna', 1, 2),
(745, 'Klara', 1, 2),
(746, 'Ida', 1, 2),
(747, 'Isabella', 1, 2),
(748, 'Alice', 1, 2),
(749, 'Sara', 1, 2),
(750, 'Sophia', 1, 2),
(751, 'Emilia', 1, 2),
(752, 'Eva', 1, 2),
(753, 'Mathilda', 1, 2),
(754, 'Lena', 1, 2),
(755, 'Amelia', 1, 2),
(756, 'Frida', 1, 2),
(757, 'Signe', 1, 2),
(758, 'Linn', 1, 2),
(759, 'Nora', 1, 2),
(760, 'Mia', 1, 2),
(761, 'Anna', 1, 2),
(762, 'Ingrid', 1, 2),
(763, 'Maria', 1, 2),
(764, 'Elise', 1, 2),
(765, 'Elsa', 1, 2),
(766, 'Selma', 1, 2),
(767, 'Agnes', 1, 2),
(768, 'Julia', 1, 2),
(769, 'Lea', 1, 2),
(770, 'Liv', 1, 2),
(771, 'Johanna', 1, 2),
(772, 'Stella', 1, 2),
(773, 'Astrid', 1, 2),
(774, 'Isabelle', 1, 2),
(775, 'Sophie', 1, 2),
(776, 'Clara', 1, 2),
(777, 'Victoria', 1, 2),
(778, 'Elisabeth', 1, 2),
(779, 'Karin', 1, 2),
(780, 'Marie', 1, 2),
(781, 'Laura', 1, 2),
(782, 'Greta', 1, 2),
(783, 'Louise', 1, 2),
(784, 'Lina', 1, 2),
(785, 'Ellen', 1, 2),
(786, 'Vera', 1, 2),
(787, 'Anne', 1, 2),
(788, 'Nina', 1, 2),
(789, 'Olivia', 1, 2),
(790, 'Adolf', 1, 1),
(791, 'Albert', 1, 1),
(792, 'Alfred', 1, 1),
(793, 'Arnold', 1, 1),
(794, 'Bernard', 1, 1),
(795, 'Bruno', 1, 1),
(796, 'Conrad', 1, 1),
(797, 'Dietrich', 1, 1),
(798, 'Erich', 1, 1),
(799, 'Ferdinand', 1, 1),
(800, 'Franz', 1, 1),
(801, 'Friedrich', 1, 1),
(802, 'Georg', 1, 1),
(803, 'Gottfried', 1, 1),
(804, 'Günter', 1, 1),
(805, 'Gustav', 1, 1),
(806, 'Hans', 1, 1),
(807, 'Heinrich', 1, 1),
(808, 'Helmut', 1, 1),
(809, 'Hermann', 1, 1),
(810, 'Horst', 1, 1),
(811, 'Karl', 1, 1),
(812, 'Klaus', 1, 1),
(813, 'Kurt', 1, 1),
(814, 'Ludwig', 1, 1),
(815, 'Manfred', 1, 1),
(816, 'Max', 1, 1),
(817, 'Otto', 1, 1),
(818, 'Rudolf', 1, 1),
(819, 'Rolf', 1, 1),
(820, 'Siegfried', 1, 1),
(821, 'Theodor', 1, 1),
(822, 'Ulrich', 1, 1),
(823, 'Uwe', 1, 1),
(824, 'Volker', 1, 1),
(825, 'Walter', 1, 1),
(826, 'Werner', 1, 1),
(827, 'Wilhelm', 1, 1),
(828, 'Wolfgang', 1, 1),
(829, 'Adalbert', 1, 1),
(830, 'Eduard', 1, 1),
(831, 'Gerd', 1, 1),
(832, 'Hugo', 1, 1),
(833, 'Joachim', 1, 1),
(834, 'Jürgen', 1, 1),
(835, 'Leonhard', 1, 1),
(836, 'Oskar', 1, 1),
(837, 'Reinhard', 1, 1),
(838, 'Sven', 1, 1),
(839, 'Torsten', 1, 1),
(840, 'Viktor', 1, 1),
(841, 'Adelheid', 1, 2),
(842, 'Agnes', 1, 2),
(843, 'Anneliese', 1, 2),
(844, 'Astrid', 1, 2),
(845, 'Beate', 1, 2),
(846, 'Bertha', 1, 2),
(847, 'Brigitte', 1, 2),
(848, 'Dagmar', 1, 2),
(849, 'Dorothea', 1, 2),
(850, 'Edith', 1, 2),
(851, 'Eleonore', 1, 2),
(852, 'Elisabeth', 1, 2),
(853, 'Erika', 1, 2),
(854, 'Frieda', 1, 2),
(855, 'Gerta', 1, 2),
(856, 'Gertrud', 1, 2),
(857, 'Gisela', 1, 2),
(858, 'Gretchen', 1, 2),
(859, 'Hedwig', 1, 2),
(860, 'Helga', 1, 2),
(861, 'Hilde', 1, 2),
(862, 'Ilse', 1, 2),
(863, 'Inge', 1, 2),
(864, 'Ingrid', 1, 2),
(865, 'Irmgard', 1, 2),
(866, 'Johanna', 1, 2),
(867, 'Käthe', 1, 2),
(868, 'Klara', 1, 2),
(869, 'Lieselotte', 1, 2),
(870, 'Lotte', 1, 2),
(871, 'Magda', 1, 2),
(872, 'Margarete', 1, 2),
(873, 'Maria', 1, 2),
(874, 'Marlene', 1, 2),
(875, 'Mathilde', 1, 2),
(876, 'Renate', 1, 2),
(877, 'Rosa', 1, 2),
(878, 'Sigrid', 1, 2),
(879, 'Sophie', 1, 2),
(880, 'Therese', 1, 2),
(881, 'Ursula', 1, 2),
(882, 'Vera', 1, 2),
(883, 'Waltraud', 1, 2),
(884, 'Wilhelmina', 1, 2),
(885, 'Elsa', 1, 2),
(886, 'Elke', 1, 2),
(887, 'Friederike', 1, 2),
(888, 'Hannelore', 1, 2),
(889, 'Lore', 1, 2),
(890, 'Petra', 1, 2),
(891, 'Ruth', 1, 2),
(892, 'Uta', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--

CREATE TABLE `gender` (
  `id_gender` int(11) NOT NULL,
  `label` varchar(45) DEFAULT NULL,
  `display_name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`id_gender`, `label`, `display_name`) VALUES
(1, 'man', 'Homme'),
(2, 'woman', 'Femme');

-- --------------------------------------------------------

--
-- Table structure for table `lastname`
--

CREATE TABLE `lastname` (
  `id_lastname` int(11) NOT NULL,
  `label` varchar(45) DEFAULT NULL,
  `ethnicity_id_ethnicity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lastname`
--

INSERT INTO `lastname` (`id_lastname`, `label`, `ethnicity_id_ethnicity`) VALUES
(1, 'Martin', 1),
(2, 'Bernard', 1),
(3, 'Dubois', 1),
(4, 'Thomas', 1),
(5, 'Robert', 1),
(6, 'Richard', 1),
(7, 'Petit', 1),
(8, 'Durand', 1),
(9, 'Leroy', 1),
(10, 'Moreau', 1),
(11, 'Simon', 1),
(12, 'Laurent', 1),
(13, 'Lefevre', 1),
(14, 'Michel', 1),
(15, 'Garcia', 1),
(16, 'David', 1),
(17, 'Bertrand', 1),
(18, 'Roux', 1),
(19, 'Vincent', 1),
(20, 'Fournier', 1),
(21, 'Morel', 1),
(22, 'Girard', 1),
(23, 'Andre', 1),
(24, 'Lefebvre', 1),
(25, 'Mercier', 1),
(26, 'Dupont', 1),
(27, 'Lambert', 1),
(28, 'Bonnet', 1),
(29, 'Francois', 1),
(30, 'Martinez', 1),
(31, 'Abdelaziz', 2),
(32, 'Ahmed', 2),
(33, 'Amari', 2),
(34, 'Ben Youssef', 2),
(35, 'Bouazizi', 2),
(36, 'Chaoui', 2),
(37, 'Djaber', 2),
(38, 'Fassi', 2),
(39, 'Gharbi', 2),
(40, 'Haddad', 2),
(41, 'Hamdi', 2),
(42, 'Kadri', 2),
(43, 'Lazrak', 2),
(44, 'Mansouri', 2),
(45, 'Ouaddi', 2),
(46, 'Rekik', 2),
(47, 'Saadi', 2),
(48, 'Taleb', 2),
(49, 'Zeroual', 2),
(50, 'Belkhir', 2),
(51, 'Chibani', 2),
(52, 'Dridi', 2),
(53, 'Guerrouj', 2),
(54, 'Hajjaj', 2),
(55, 'Kadiri', 2),
(56, 'Messaoudi', 2),
(57, 'Nasri', 2),
(58, 'Rahmouni', 2),
(59, 'Sassi', 2),
(60, 'Tounsi', 2),
(61, 'Tanaka', 3),
(62, 'Suzuki', 3),
(63, 'Takahashi', 3),
(64, 'Kim', 3),
(65, 'Li', 3),
(66, 'Chen', 3),
(67, 'Nguyen', 3),
(68, 'Tran', 3),
(69, 'Park', 3),
(70, 'Wang', 3),
(71, 'Lee', 3),
(72, 'Yang', 3),
(73, 'Liu', 3),
(74, 'Huang', 3),
(75, 'Chung', 3),
(76, 'Yamamoto', 3),
(77, 'Choi', 3),
(78, 'Shin', 3),
(79, 'Hasegawa', 3),
(80, 'Kato', 3),
(81, 'Lai', 3),
(82, 'Ma', 3),
(83, 'Wu', 3),
(84, 'Zhao', 3),
(85, 'Lin', 3),
(86, 'Chan', 3),
(87, 'Pham', 3),
(88, 'Sharma', 3),
(89, 'Shrestha', 3),
(90, 'Dhawan', 3),
(91, 'Moana', 7),
(92, 'Tane', 7),
(93, 'Ariki', 7),
(94, 'Marama', 7),
(95, 'Kai', 7),
(96, 'Mana', 7),
(97, 'Iwi', 7),
(98, 'Rangi', 7),
(99, 'Tama', 7),
(100, 'Aroha', 7),
(101, 'Whetu', 7),
(102, 'Mareikura', 7),
(103, 'Teina', 7),
(104, 'Tuhi', 7),
(105, 'Koro', 7),
(106, 'Kupe', 7),
(107, 'Awhina', 7),
(108, 'Whanau', 7),
(109, 'Kahurangi', 7),
(110, 'Pounamu', 7),
(111, 'Aotearoa', 7),
(112, 'Tahiti', 7),
(113, 'Haka', 7),
(114, 'Kiaora', 7),
(115, 'Tapu', 7),
(116, 'Hui', 7),
(117, 'Pakeha', 7),
(118, 'Tiki', 7),
(119, 'Karakia', 7),
(120, 'Moko', 7),
(121, 'Whare', 7),
(122, 'Nui', 7),
(123, 'Iti', 7),
(124, 'Roa', 7),
(125, 'Kotiro', 7),
(126, 'Tama', 7),
(127, 'Tangata', 7),
(128, 'Maori', 7),
(129, 'Kia', 7),
(130, 'Kaha', 7),
(131, 'Aro', 7),
(132, 'Nui', 7),
(133, 'Ora', 7),
(134, 'Waka', 7),
(135, 'Toa', 7),
(136, 'Mauri', 7),
(137, 'Hapu', 7),
(138, 'Maru', 7),
(139, 'Puku', 7),
(140, 'Reka', 7),
(141, 'Tahi', 7),
(142, 'Rua', 7),
(143, 'Toru', 7),
(144, 'Ivanov', 6),
(145, 'Smirnov', 6),
(146, 'Kuznetsov', 6),
(147, 'Popov', 6),
(148, 'Vasiliev', 6),
(149, 'Petrov', 6),
(150, 'Sokolov', 6),
(151, 'Mikhailov', 6),
(152, 'Novikov', 6),
(153, 'Fedorov', 6),
(154, 'Morozov', 6),
(155, 'Volkov', 6),
(156, 'Alekseev', 6),
(157, 'Lebedev', 6),
(158, 'Semenov', 6),
(159, 'Egorov', 6),
(160, 'Pavlov', 6),
(161, 'Kozlov', 6),
(162, 'Stepanov', 6),
(163, 'Nikolayev', 6),
(164, 'Orlov', 6),
(165, 'Andreev', 6),
(166, 'Makarov', 6),
(167, 'Nikitin', 6),
(168, 'Zakharov', 6),
(169, 'Zaytsev', 6),
(170, 'Soloviev', 6),
(171, 'Borodin', 6),
(172, 'Vorobyev', 6),
(173, 'Klimov', 6),
(174, 'Sergeyev', 6),
(175, 'Gerasimov', 6),
(176, 'Artemiev', 6),
(177, 'Romanov', 6),
(178, 'Zinoviev', 6),
(179, 'Grigoriev', 6),
(180, 'Kudryavtsev', 6),
(181, 'Safonov', 6),
(182, 'Efimov', 6),
(183, 'Lobanov', 6),
(184, 'Ozerov', 6),
(185, 'Sitnikov', 6),
(186, 'Sobolev', 6),
(187, 'Chernov', 6),
(188, 'Ermakov', 6),
(189, 'Nemov', 6),
(190, 'Kalinin', 6),
(191, 'Baranov', 6),
(192, 'Platonov', 6),
(193, 'Fadeev', 6),
(194, 'García', 5),
(195, 'Martínez', 5),
(196, 'Rodríguez', 5),
(197, 'Pérez', 5),
(198, 'Sánchez', 5),
(199, 'Fernández', 5),
(200, 'González', 5),
(201, 'López', 5),
(202, 'Hernández', 5),
(203, 'Jiménez', 5),
(204, 'Álvarez', 5),
(205, 'Moreno', 5),
(206, 'Romero', 5),
(207, 'Alonso', 5),
(208, 'Gutiérrez', 5),
(209, 'Navarro', 5),
(210, 'Torres', 5),
(211, 'Domínguez', 5),
(212, 'Vargas', 5),
(213, 'Gil', 5),
(214, 'Ramos', 5),
(215, 'Serrano', 5),
(216, 'Blanco', 5),
(217, 'Molina', 5),
(218, 'Morales', 5),
(219, 'Suárez', 5),
(220, 'Ortega', 5),
(221, 'Delgado', 5),
(222, 'Castro', 5),
(223, 'Ortiz', 5),
(224, 'Rubio', 5),
(225, 'Marín', 5),
(226, 'Santos', 5),
(227, 'Vega', 5),
(228, 'Vidal', 5),
(229, 'Garrido', 5),
(230, 'Medina', 5),
(231, 'Gallardo', 5),
(232, 'Carrasco', 5),
(233, 'Reyes', 5),
(234, 'Guerra', 5),
(235, 'Peña', 5),
(236, 'Cano', 5),
(237, 'Prieto', 5),
(238, 'Calvo', 5),
(239, 'Méndez', 5),
(240, 'Cruz', 5),
(241, 'Gallego', 5),
(242, 'Herrera', 5),
(243, 'León', 5),
(244, 'Vicente', 5),
(245, 'Campos', 5),
(246, 'El Amine', 4),
(247, 'Bouaziz', 4),
(248, 'Zidane', 4),
(249, 'Bennani', 4),
(250, 'El Khatib', 4),
(251, 'Benali', 4),
(252, 'Cherif', 4),
(253, 'Ait Ahmed', 4),
(254, 'El Ouafi', 4),
(255, 'Belkacem', 4),
(256, 'Boualem', 4),
(257, 'Mansouri', 4),
(258, 'Kaddour', 4),
(259, 'Benyoussef', 4),
(260, 'Larbi', 4),
(261, 'El Ghaoui', 4),
(262, 'Haddad', 4),
(263, 'Benyamina', 4),
(264, 'Dahmani', 4),
(265, 'Benzema', 4),
(266, 'El Kabir', 4),
(267, 'Touati', 4),
(268, 'Belhadj', 4),
(269, 'Rahmani', 4),
(270, 'Khalil', 4),
(271, 'Kaddour', 4),
(272, 'El Akkad', 4),
(273, 'Ammari', 4),
(274, 'Ben Said', 4),
(275, 'Mekki', 4),
(276, 'Moussa', 4),
(277, 'Guedioura', 4),
(278, 'El Jazouli', 4),
(279, 'Boukhari', 4),
(280, 'Hammoudi', 4),
(281, 'Benyahia', 4),
(282, 'El Ouahabi', 4),
(283, 'Omar', 4),
(284, 'Bensalem', 4),
(285, 'Jouini', 4),
(286, 'Fekir', 4),
(287, 'Boudjellal', 4),
(288, 'El Kebir', 4),
(289, 'Belkhir', 4),
(290, 'Lahmadi', 4),
(291, 'Makhloufi', 4),
(292, 'El Moussaoui', 4),
(293, 'Djebbari', 4),
(294, 'Lakhdar', 4),
(295, 'Smith', 1),
(296, 'Brown', 1),
(297, 'Johnson', 1),
(298, 'Williams', 1),
(299, 'Jones', 1),
(300, 'Davis', 1),
(301, 'Miller', 1),
(302, 'García', 1),
(303, 'Rodríguez', 1),
(304, 'Martínez', 1),
(305, 'Anderson', 1),
(306, 'Taylor', 1),
(307, 'Thomas', 1),
(308, 'Hernández', 1),
(309, 'Moore', 1),
(310, 'Martin', 1),
(311, 'Jackson', 1),
(312, 'Thompson', 1),
(313, 'García', 1),
(314, 'Martínez', 1),
(315, 'Robinson', 1),
(316, 'Clark', 1),
(317, 'Rodríguez', 1),
(318, 'Lewis', 1),
(319, 'Lee', 1),
(320, 'Walker', 1),
(321, 'Hall', 1),
(322, 'Allen', 1),
(323, 'Young', 1),
(324, 'King', 1),
(325, 'Wright', 1),
(326, 'Scott', 1),
(327, 'Green', 1),
(328, 'Adams', 1),
(329, 'Baker', 1),
(330, 'González', 1),
(331, 'Nelson', 1),
(332, 'Hill', 1),
(333, 'Ramírez', 1),
(334, 'Campbell', 1),
(335, 'Mitchell', 1),
(336, 'Roberts', 1),
(337, 'Carter', 1),
(338, 'Phillips', 1),
(339, 'Evans', 1),
(340, 'Turner', 1),
(341, 'Torres', 1),
(342, 'Pérez', 1),
(343, 'White', 1),
(344, 'Ríos', 1),
(345, 'Johansson', 1),
(346, 'Andersen', 1),
(347, 'Olsen', 1),
(348, 'Hansen', 1),
(349, 'Nilsen', 1),
(350, 'Pettersson', 1),
(351, 'Berg', 1),
(352, 'Sundberg', 1),
(353, 'Lund', 1),
(354, 'Bergström', 1),
(355, 'Jensen', 1),
(356, 'Svensson', 1),
(357, 'Lind', 1),
(358, 'Eriksson', 1),
(359, 'Nyström', 1),
(360, 'Holm', 1),
(361, 'Karlsson', 1),
(362, 'Virtanen', 1),
(363, 'Mäkinen', 1),
(364, 'Haavisto', 1),
(365, 'Laaksonen', 1),
(366, 'Korhonen', 1),
(367, 'Salminen', 1),
(368, 'Järvinen', 1),
(369, 'Nieminen', 1),
(370, 'Sjöberg', 1),
(371, 'Lindberg', 1),
(372, 'Hermansen', 1),
(373, 'Christiansen', 1),
(374, 'Rasmussen', 1),
(375, 'Lauritzen', 1),
(376, 'Jørgensen', 1),
(377, 'Ström', 1),
(378, 'Lindqvist', 1),
(379, 'Hellström', 1),
(380, 'Gustafsson', 1),
(381, 'Viklund', 1),
(382, 'Backman', 1),
(383, 'Ahlgren', 1),
(384, 'Forsberg', 1),
(385, 'Lindholm', 1),
(386, 'Söderberg', 1),
(387, 'Madsen', 1),
(388, 'Lindström', 1),
(389, 'Söderström', 1),
(390, 'Wallin', 1),
(391, 'Blomqvist', 1),
(392, 'Sundström', 1),
(393, 'Norberg', 1),
(394, 'Berglund', 1),
(395, 'Müller', 1),
(396, 'Schmidt', 1),
(397, 'Schneider', 1),
(398, 'Fischer', 1),
(399, 'Meyer', 1),
(400, 'Weber', 1),
(401, 'Wagner', 1),
(402, 'Becker', 1),
(403, 'Schulz', 1),
(404, 'Hoffmann', 1),
(405, 'Schäfer', 1),
(406, 'Koch', 1),
(407, 'Bauer', 1),
(408, 'Richter', 1),
(409, 'Klein', 1),
(410, 'Wolf', 1),
(411, 'Neumann', 1),
(412, 'Schwarz', 1),
(413, 'Krüger', 1),
(414, 'Braun', 1),
(415, 'Werner', 1),
(416, 'Gerlach', 1),
(417, 'Lange', 1),
(418, 'Schmitt', 1),
(419, 'Walter', 1),
(420, 'Köhler', 1),
(421, 'Maier', 1),
(422, 'Beck', 1),
(423, 'Böhm', 1),
(424, 'Frank', 1),
(425, 'Günther', 1),
(426, 'Berger', 1),
(427, 'Kunz', 1),
(428, 'Ebert', 1),
(429, 'Engel', 1),
(430, 'Horn', 1),
(431, 'Busch', 1),
(432, 'Bergmann', 1),
(433, 'Pohl', 1),
(434, 'Stein', 1),
(435, 'Jäger', 1),
(436, 'Otto', 1),
(437, 'Sommer', 1),
(438, 'Groß', 1),
(439, 'Seidel', 1),
(440, 'Heinrich', 1),
(441, 'Brandt', 1),
(442, 'Haas', 1),
(443, 'Schreiber', 1),
(444, 'Graf', 1),
(445, 'Schulte', 1),
(446, 'Dietrich', 1);

-- --------------------------------------------------------

--
-- Table structure for table `list_gender_work`
--

CREATE TABLE `list_gender_work` (
  `id_list_gender_work` int(11) NOT NULL,
  `work_name` varchar(45) DEFAULT NULL,
  `gender_id_gender` int(11) NOT NULL,
  `work_id_work` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `list_gender_work`
--

INSERT INTO `list_gender_work` (`id_list_gender_work`, `work_name`, `gender_id_gender`, `work_id_work`) VALUES
(1, 'Bûcheron', 1, 2),
(2, 'Bûcheronne', 2, 2),
(3, 'Cuisinier', 1, 1),
(4, 'Cuisininère', 2, 1),
(5, 'Policier', 1, 3),
(6, 'Policière', 2, 3),
(7, 'Artisan', 1, 4),
(8, 'Artisane', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `nationality`
--

CREATE TABLE `nationality` (
  `id_nationnality` int(11) NOT NULL,
  `label` varchar(45) DEFAULT NULL,
  `display_name_fr` varchar(45) DEFAULT NULL,
  `flag` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nationality`
--

INSERT INTO `nationality` (`id_nationnality`, `label`, `display_name_fr`, `flag`) VALUES
(1, 'french', 'Francais', 'France'),
(2, 'morocco', 'Maroc', 'Morocco'),
(4, 'russia', 'Russe', 'russia');

-- --------------------------------------------------------

--
-- Table structure for table `photo`
--

CREATE TABLE `photo` (
  `id_photo` int(11) NOT NULL,
  `src` varchar(45) DEFAULT NULL,
  `alt` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `photo`
--

INSERT INTO `photo` (`id_photo`, `src`, `alt`) VALUES
(1, '1', 'Photo'),
(2, '2', 'Photo');

-- --------------------------------------------------------

--
-- Table structure for table `pnj`
--

CREATE TABLE `pnj` (
  `id_pnj` int(11) NOT NULL,
  `level` int(11) DEFAULT NULL,
  `exp` int(11) DEFAULT NULL,
  `gender_id_gender` int(11) NOT NULL,
  `ethnicity_id_ethnicity` int(11) NOT NULL,
  `photo_id_photo` int(11) NOT NULL,
  `work_id_work` int(11) NOT NULL,
  `firstname_id_firstname` int(11) NOT NULL,
  `lastname_id_lastname` int(11) NOT NULL,
  `nationality_id_nationnality` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id_skills` int(11) NOT NULL,
  `strength` int(11) DEFAULT NULL,
  `agility` int(11) DEFAULT NULL,
  `stealth` int(11) DEFAULT NULL,
  `intelligence` int(11) DEFAULT NULL,
  `charisma` int(11) DEFAULT NULL,
  `accuracy` int(11) DEFAULT NULL,
  `perception` int(11) DEFAULT NULL,
  `survival` int(11) NOT NULL,
  `pnj_id_pnj` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_users` int(11) NOT NULL,
  `login` varchar(64) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `level` int(11) NOT NULL,
  `exp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `work`
--

CREATE TABLE `work` (
  `id_work` int(11) NOT NULL,
  `label` varchar(45) NOT NULL,
  `logo_work` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `work`
--

INSERT INTO `work` (`id_work`, `label`, `logo_work`) VALUES
(1, 'chef', 'hat-chef'),
(2, 'woodcutter', 'axe'),
(3, 'cop', 'user-police-tie'),
(4, 'craftsman', 'hammer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ethnicdistributionbynationality`
--
ALTER TABLE `ethnicdistributionbynationality`
  ADD PRIMARY KEY (`nationality_id_nationnality`,`ethnicity_id_ethnicity`),
  ADD KEY `fk_nationality_has_ethnicity_ethnicity1_idx` (`ethnicity_id_ethnicity`),
  ADD KEY `fk_nationality_has_ethnicity_nationality1_idx` (`nationality_id_nationnality`);

--
-- Indexes for table `ethnicity`
--
ALTER TABLE `ethnicity`
  ADD PRIMARY KEY (`id_ethnicity`);

--
-- Indexes for table `firstname`
--
ALTER TABLE `firstname`
  ADD PRIMARY KEY (`id_firstname`),
  ADD KEY `fk_firstname_ethnicity1_idx` (`ethnicity_id_ethnicity`),
  ADD KEY `fk_firstname_gender1_idx` (`gender_id_gender`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`id_gender`);

--
-- Indexes for table `lastname`
--
ALTER TABLE `lastname`
  ADD PRIMARY KEY (`id_lastname`,`ethnicity_id_ethnicity`),
  ADD KEY `fk_lastname_ethnicity1_idx` (`ethnicity_id_ethnicity`);

--
-- Indexes for table `list_gender_work`
--
ALTER TABLE `list_gender_work`
  ADD PRIMARY KEY (`id_list_gender_work`),
  ADD KEY `fk_liste_gender_work_gender1_idx` (`gender_id_gender`),
  ADD KEY `fk_liste_gender_work_work1_idx` (`work_id_work`);

--
-- Indexes for table `nationality`
--
ALTER TABLE `nationality`
  ADD PRIMARY KEY (`id_nationnality`);

--
-- Indexes for table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`id_photo`);

--
-- Indexes for table `pnj`
--
ALTER TABLE `pnj`
  ADD PRIMARY KEY (`id_pnj`),
  ADD KEY `fk_pnj_gender_idx` (`gender_id_gender`),
  ADD KEY `fk_pnj_ethnicity1_idx` (`ethnicity_id_ethnicity`),
  ADD KEY `fk_pnj_photo1_idx` (`photo_id_photo`),
  ADD KEY `fk_pnj_work1_idx` (`work_id_work`),
  ADD KEY `fk_pnj_firstname1_idx` (`firstname_id_firstname`),
  ADD KEY `fk_pnj_lastname1_idx` (`lastname_id_lastname`),
  ADD KEY `fk_pnj_nationality1_idx` (`nationality_id_nationnality`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id_skills`),
  ADD KEY `fk_skills_pnj1_idx` (`pnj_id_pnj`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`);

--
-- Indexes for table `work`
--
ALTER TABLE `work`
  ADD PRIMARY KEY (`id_work`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `firstname`
--
ALTER TABLE `firstname`
  MODIFY `id_firstname` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=893;

--
-- AUTO_INCREMENT for table `lastname`
--
ALTER TABLE `lastname`
  MODIFY `id_lastname` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=447;

--
-- AUTO_INCREMENT for table `list_gender_work`
--
ALTER TABLE `list_gender_work`
  MODIFY `id_list_gender_work` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `nationality`
--
ALTER TABLE `nationality`
  MODIFY `id_nationnality` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id_skills` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ethnicdistributionbynationality`
--
ALTER TABLE `ethnicdistributionbynationality`
  ADD CONSTRAINT `fk_nationality_has_ethnicity_ethnicity1` FOREIGN KEY (`ethnicity_id_ethnicity`) REFERENCES `ethnicity` (`id_ethnicity`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nationality_has_ethnicity_nationality1` FOREIGN KEY (`nationality_id_nationnality`) REFERENCES `nationality` (`id_nationnality`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `firstname`
--
ALTER TABLE `firstname`
  ADD CONSTRAINT `fk_firstname_ethnicity1` FOREIGN KEY (`ethnicity_id_ethnicity`) REFERENCES `ethnicity` (`id_ethnicity`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_firstname_gender1` FOREIGN KEY (`gender_id_gender`) REFERENCES `gender` (`id_gender`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `lastname`
--
ALTER TABLE `lastname`
  ADD CONSTRAINT `fk_lastname_ethnicity1` FOREIGN KEY (`ethnicity_id_ethnicity`) REFERENCES `ethnicity` (`id_ethnicity`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `list_gender_work`
--
ALTER TABLE `list_gender_work`
  ADD CONSTRAINT `fk_liste_gender_work_gender1` FOREIGN KEY (`gender_id_gender`) REFERENCES `gender` (`id_gender`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_liste_gender_work_work1` FOREIGN KEY (`work_id_work`) REFERENCES `work` (`id_work`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pnj`
--
ALTER TABLE `pnj`
  ADD CONSTRAINT `fk_pnj_ethnicity1` FOREIGN KEY (`ethnicity_id_ethnicity`) REFERENCES `ethnicity` (`id_ethnicity`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pnj_gender` FOREIGN KEY (`gender_id_gender`) REFERENCES `gender` (`id_gender`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pnj_nationality1` FOREIGN KEY (`nationality_id_nationnality`) REFERENCES `nationality` (`id_nationnality`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pnj_photo1` FOREIGN KEY (`photo_id_photo`) REFERENCES `photo` (`id_photo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pnj_work1` FOREIGN KEY (`work_id_work`) REFERENCES `work` (`id_work`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `skills`
--
ALTER TABLE `skills`
  ADD CONSTRAINT `fk_skills_pnj1` FOREIGN KEY (`pnj_id_pnj`) REFERENCES `pnj` (`id_pnj`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
