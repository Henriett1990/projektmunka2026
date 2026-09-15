-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3306
-- Létrehozás ideje: 2026. Sze 15. 08:15
-- Kiszolgáló verziója: 8.4.7
-- PHP verzió: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `projectwebshop`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
CREATE TABLE IF NOT EXISTS `orderitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `orderitems`
--

INSERT INTO `orderitems` (`id`, `order_id`, `product_id`, `product_name`, `unit_price`, `quantity`) VALUES
(1, 1, 2, 'Vadgesztenyés krém', 1900, 1),
(2, 1, 1, 'Kecsketejes krém', 1900, 2),
(3, 1, 3, 'Kollagénes ránctalanító krém', 1900, 1),
(4, 1, 10, 'HŰSÍTŐ testbalzsam természetes kenderolajjal', 3500, 1),
(5, 2, 2, 'Vadgesztenyés krém', 1900, 3),
(6, 2, 3, 'Kollagénes ránctalanító krém', 1900, 1),
(7, 2, 11, 'Testbalzsam természetes kenderolajjal 5%', 3500, 1),
(8, 2, 15, 'Borz balzsam', 2500, 1),
(9, 2, 14, 'Kender + Probiotics Balzsam - nagyon száraz és viszkető bőr ápolására', 2500, 1),
(10, 3, 3, 'Kollagénes ránctalanító krém', 1900, 5),
(11, 3, 7, 'Csigás krém', 1900, 1),
(12, 3, 8, 'Körömvirágos krém', 1900, 1),
(13, 3, 9, 'Ginzenges krém', 1900, 1),
(14, 4, 19, 'Kenderolaj 100%', 2500, 1),
(15, 4, 16, 'Tigris balzsam', 2500, 1),
(16, 4, 17, 'Ajakápoló balzsam kendermagolajjal és E-vitaminnal', 800, 1),
(17, 4, 18, 'Ajakápoló balzsam aloe verával', 800, 1),
(18, 4, 13, 'Krém karbamiddal és kenderolajjal - nagyon száraz bőrre', 1800, 1),
(19, 4, 14, 'Kender + Probiotics Balzsam - nagyon száraz és viszkető bőr ápolására', 2500, 1),
(20, 5, 2, 'Vadgesztenyés krém', 1900, 1),
(21, 5, 5, 'Fenyőrügyes krém', 1900, 1),
(22, 5, 6, 'Orchideás-kollagénes krém', 1900, 1),
(23, 5, 10, 'HŰSÍTŐ testbalzsam természetes kenderolajjal', 3500, 1),
(24, 5, 11, 'Testbalzsam természetes kenderolajjal 5%', 3500, 1),
(25, 5, 12, 'Fekete nadálytő balzsam', 3500, 1),
(26, 5, 14, 'Kender + Probiotics Balzsam - nagyon száraz és viszkető bőr ápolására', 2500, 1),
(27, 6, 19, 'Kenderolaj 100%', 2500, 1),
(28, 6, 11, 'Testbalzsam természetes kenderolajjal 5%', 3500, 3),
(29, 6, 10, 'HŰSÍTŐ testbalzsam természetes kenderolajjal', 3500, 2),
(30, 6, 2, 'Vadgesztenyés krém', 1900, 1),
(31, 6, 12, 'Fekete nadálytő balzsam', 3500, 1),
(32, 7, 2, 'Vadgesztenyés krém', 1900, 1),
(33, 7, 3, 'Kollagénes ránctalanító krém', 1900, 1),
(34, 7, 1, 'Kecsketejes krém', 1900, 1),
(35, 7, 5, 'Fenyőrügyes krém', 1900, 1),
(36, 7, 6, 'Orchideás-kollagénes krém', 1900, 1),
(37, 7, 4, 'Kurkumás krém', 1900, 1),
(38, 8, 2, 'Vadgesztenyés krém', 1900, 1),
(39, 8, 3, 'Kollagénes ránctalanító krém', 1900, 1),
(40, 8, 1, 'Kecsketejes krém', 1900, 1),
(41, 8, 5, 'Fenyőrügyes krém', 1900, 1),
(42, 8, 6, 'Orchideás-kollagénes krém', 1900, 1),
(43, 8, 4, 'Kurkumás krém', 1900, 1),
(44, 9, 2, 'Vadgesztenyés krém', 1900, 2),
(45, 9, 3, 'Kollagénes ránctalanító krém', 1900, 2),
(46, 9, 1, 'Kecsketejes krém', 1900, 1),
(47, 9, 5, 'Fenyőrügyes krém', 1900, 2),
(48, 9, 6, 'Orchideás-kollagénes krém', 1900, 2),
(49, 9, 4, 'Kurkumás krém', 1900, 2),
(50, 10, 2, 'Vadgesztenyés krém', 1900, 3),
(51, 10, 3, 'Kollagénes ránctalanító krém', 1900, 3),
(52, 10, 1, 'Kecsketejes krém', 1900, 1),
(53, 10, 5, 'Fenyőrügyes krém', 1900, 3),
(54, 10, 6, 'Orchideás-kollagénes krém', 1900, 3),
(55, 10, 4, 'Kurkumás krém', 1900, 2),
(56, 10, 11, 'Testbalzsam természetes kenderolajjal 5%', 3500, 1),
(57, 10, 12, 'Fekete nadálytő balzsam', 3500, 1),
(58, 10, 10, 'HŰSÍTŐ testbalzsam természetes kenderolajjal', 3500, 1),
(59, 11, 2, 'Vadgesztenyés krém', 1900, 3),
(60, 11, 3, 'Kollagénes ránctalanító krém', 1900, 3),
(61, 11, 1, 'Kecsketejes krém', 1900, 1),
(62, 11, 5, 'Fenyőrügyes krém', 1900, 3),
(63, 11, 6, 'Orchideás-kollagénes krém', 1900, 3),
(64, 11, 4, 'Kurkumás krém', 1900, 2),
(65, 11, 11, 'Testbalzsam természetes kenderolajjal 5%', 3500, 2),
(66, 11, 12, 'Fekete nadálytő balzsam', 3500, 2),
(67, 11, 10, 'HŰSÍTŐ testbalzsam természetes kenderolajjal', 3500, 2),
(68, 11, 14, 'Kender + Probiotics Balzsam - nagyon száraz és viszkető bőr ápolására', 2500, 1),
(69, 11, 15, 'Borz balzsam', 2500, 1),
(70, 12, 2, 'Vadgesztenyés krém', 1900, 2),
(71, 12, 3, 'Kollagénes ránctalanító krém', 1900, 1),
(72, 12, 6, 'Orchideás-kollagénes krém', 1900, 1),
(73, 13, 1, 'Kecsketejes krém', 1900, 4),
(74, 13, 3, 'Kollagénes ránctalanító krém', 1900, 3),
(75, 14, 1, 'Kecsketejes krém', 1900, 4),
(76, 14, 3, 'Kollagénes ránctalanító krém', 1900, 3),
(77, 15, 2, 'Vadgesztenyés krém', 1900, 4),
(78, 15, 1, 'Kecsketejes krém', 1900, 1),
(79, 15, 3, 'Kollagénes ránctalanító krém', 1900, 1),
(80, 15, 6, 'Orchideás-kollagénes krém', 1900, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_price` int NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Új',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_price`, `status`, `created_at`) VALUES
(1, 3, 11100, 'Új', '2026-07-31 17:56:11'),
(2, 4, 16100, 'Új', '2026-07-31 22:27:24'),
(3, 3, 15200, 'Új', '2026-07-31 23:47:42'),
(4, 3, 10900, 'Új', '2026-08-13 17:13:20'),
(5, 3, 18700, 'Új', '2026-08-26 15:04:13'),
(6, 3, 25400, 'Új', '2026-09-04 16:55:03'),
(7, 3, 11400, 'Új', '2026-09-05 16:58:46'),
(8, 3, 11400, 'Új', '2026-09-05 16:58:58'),
(9, 3, 20900, 'Új', '2026-09-05 17:07:02'),
(10, 3, 39000, 'Új', '2026-09-05 17:14:17'),
(11, 3, 54500, 'Új', '2026-09-05 17:31:30'),
(12, 2, 7600, 'Új', '2026-09-10 16:23:39'),
(13, 2, 13300, 'Új', '2026-09-10 17:05:24'),
(14, 2, 13300, 'Új', '2026-09-10 17:05:28'),
(15, 2, 13300, 'Új', '2026-09-10 19:33:14');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `price` int NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `image` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `products`
--

INSERT INTO `products` (`id`, `category`, `name`, `unit`, `price`, `description`, `image`, `stock`, `created_at`) VALUES
(1, 'Soft', 'Kecsketejes krém', '150 ml', 1900, 'Száraz kezekre, sarokra, ekcéma, pikkelysömör, zsíroxidációs azaz (öregségi) foltokra, égésre, \nműtéti hegekre, babapopsira. A kecsketej magas elektrolit tartalmának köszönhetően kiválóan alkalmas a gyulladt, irritált bőr megnyugtatására, a bőrallergia, ekcéma és kiütések enyhítésére. A kecsketej különösen finoman bánik a bőrrel. Kalcium tartalmával egészségesebbé, puhábbá tesz a bőrt.', 'KEPEK/1_Kecsketejes krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(2, 'Soft', 'Vadgesztenyés krém', '150 ml', 1900, 'Visszerekre, fájós lábakra, az érfalak rugalmasságának megőrzésére, rozáceás bőrre.', 'KEPEK/2_Vadgesztenyés krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(3, 'Soft', 'Kollagénes ránctalanító krém', '150 ml', 1900, 'Feszesítő, hidratáló. Segít megelőzni a bőr kiszáradását, valamint nyugtatja az irritált bőrt.', 'KEPEK/3_Kollagénes ránctalanító krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(4, 'Soft', 'Kurkumás krém', '150 ml', 1900, 'Ízületi kopás, gyulladás és fájdalom ellen, bőrnyugtató, kollagén termelést segítő, \nsegíti a kötőszövet képződést, a kurkumin segíti a véráramlást.', 'KEPEK/4_Kurkumás krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(5, 'Soft', 'Fenyőrügyes krém', '150 ml', 1900, 'Ásványi anyagokban, vitaminokban (C-, B2-, K-vitamin) karotinoidokban, illóolajokban gazdag. \n Enyhítheti a reumás fájdalmakat. Antibakteriális, gyulladáscsökkentő. Repedezett sarokra, bőrkeményedésekre is jó lehet.', 'KEPEK/5_Fenyőrügyes krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(6, 'Soft', 'Orchideás-kollagénes krém', '150 ml', 1900, 'Regenerálja a környezeti és a hormonális változások okozta bőrkárosodást. \nSegíti a sejtmegújulást, csökkenti az öregedést, a bőrnek vitalitást, feszességet biztosít.', 'KEPEK/6_Orchideás-kollagénes krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(7, 'Soft', 'Csigás krém', '150 ml', 1900, 'Csiganyálka, allantoin hatóanyaggal. Hatására a bőrsejtekben protein képződik, és a bőr regenerálódik. \nÁpolja az érett bőrt, csökkenti a ráncokat, bőrfeszesítő hatású, kiváló szemkörnyék ápoló. Megújítja a bőrsejteket, gyógyítja a sebeket, eltünteti a műtéti és az égési sérülések hegeit, a bőrt puhítja, a sebeket nem engedi elfertőződni.  ', 'KEPEK/7_Csigás krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(8, 'Soft', 'Körömvirágos krém', '150 ml', 1900, 'Magas antioxidáns tartalmú, segíthet megakadályozni a szabad gyökök okozta bőrkárosodásokat, gyulladásgátló és antibakteriális. Száraz bőrre, sebgyógyulásra. A krémet használhatjuk, hogy megnyugtassuk az irritált bőrt, a vörös foltokat, az ekcémát. a pikkelysömört.', 'KEPEK/8_Körömvirágos krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(9, 'Soft', 'Ginzenges krém', '150 ml', 1900, 'Bőrpuhító és regeneráló. Hatékonyan táplálja a száraz bőrt, Megelőzhető a bőrkeményedés, a könyök, a kéz, a lábszár, és a sarok kiszáradása. Elősegíti a kollagéntermelést a bőr középső rétegében, így a bőr stabilabbá válik. Semlegesíti a szabad gyököket a bőrben.  Bőrtápláló anyagokban gazdag. ', 'KEPEK/9_Ginzenges krém 150 ml.jpg', 200, '2026-07-10 17:04:32'),
(10, 'Kender', 'HŰSÍTŐ testbalzsam természetes kenderolajjal', '220 g', 3500, 'Hűsítő hatású testbalzsam. Természetes növényi összetevőkkel gazdagított testbalzsam, amelyek ellazítják az izmokat, enyhítik a görcsöket és megszüntetik a fáradtságot a megerőltető edzés után.\nA balzsam hatóanyagai:\n•  Kenderolaj – enyhíti az ízületi fájdalmakat és az izomduzzanatot.\n•  Eukaliptuszolaj – fájdalomcsillapító hatású és elősegíti a vérkeringést.\n•  Szegfűszegolaj – érzéstelenítő hatású, enyhíti a fájdalmat és az izomfeszültséget.\n•  Panthenol – enyhíti az irritációkat és gyorsítja a sebgyógyulást.\n•  Mentol – hűsít és segít enyhíteni az izomfájdalmat.\n•  Feketenadálytő levél kivonat – gyorsítja a sebgyógyulást és nyugtató hatású.', 'KEPEK/10_Hűsítő testbalzsam természetes kenderolajjal 220g.jpg', 300, '2026-07-10 17:04:32'),
(11, 'Kender', 'Testbalzsam természetes kenderolajjal 5%', '220 g', 3500, 'Csillapítja az izomfeszültséget és az ízületi fájdalmakat. Masszázsra ajánlott, fizikai fáradtság, idegi feszültség és reumás betegségek esetén. Rendszeres használata feszesíti a testet, hidratálja a száraz bőrt.', 'KEPEK/11_Testbalzsam természetes kenderolajjal 5% 220g.jpg', 200, '2026-07-10 17:04:32'),
(12, 'Egyéb', 'Fekete nadálytő balzsam', '230 g', 3500, 'A fáradt és száraz bőr mindennapos ápolására. Felgyorsítja a bőrszövet regenerálódását, segíti a zúzódások, és duzzanatok csillapítását. A shea vaj összetételéből adódóan még a nagyon száraz bőrt is ápolja és táplálja. Alkalmazása után a bőr láthatóan hidratált, táplált, és sima lesz.', 'KEPEK/12_Fekete nadálytő balzsam.jpg', 200, '2026-07-10 17:04:32'),
(13, 'Kender', 'Krém karbamiddal és kenderolajjal - nagyon száraz bőrre', '195 ml', 1800, 'Intenzíven hidratáló és ápoló krém karbamiddal és kenderolajjal. Még a nagyon száraz bőr ápolására is szolgál, \nbeleértve a keratinizálódásra hajlamos bőrt is (sarok, könyök és térd).\nKarbamid – intenzív hidratálást és puhítást biztosít, valamint felgyorsítja a bőrkeményedés hámlását.\nKenderolaj – nyugtatja, regenerálja, rugalmassá teszi és helyreállítja a bőr természetes védőrétegét. \nAz első alkalmazás után a bőr sima és puha tapintású marad.\nIntenzíven hidratáló és ápoló karbamiddal és kenderolajjal. A nagyon száraz bőr tökéletes ápolása,\nbeleértve a keratosisra hajlamos bőrt is (sarok, könyök és térd). A karbamid jelenléte intenzív hidratálást és\nlágyítást biztosít, valamint felgyorsítja a hámlasztást. A krém formula kenderolajjal dúsított, amely ezenkívül \nnyugtatja, regenerálja, tonizálja és helyreállítja a bőr természetes védőgátját. A bőr sima és puha tapintású \nmarad az első alkalmazás után.', 'KEPEK/13_Krém karbamiddal és kenderolajjal.jpg', 200, '2026-07-10 17:04:32'),
(14, 'Kender', 'Kender + Probiotics Balzsam - nagyon száraz és viszkető bőr ápolására', '50 g', 2500, 'A bőr intenzív hidratálása egész nap. A balzsamban található aktív összetevőket úgy tervezték, hogy megvédjék a bőr mikrobiomját. Balzsam nagyon száraz és viszkető bőr ápolására.\nA kenderolajban és probiotikumokban gazdag innovatív formula intenzíven hidratál, enyhítve a száraz, viszkető \nés hámló bőrt. Jelenleg a készítmény bioaktív posztbiotikus molekulákat tartalmaz, amelyek helyreállítják a \nnormál mikroflórát, javítják a bőrgát integritását a fehérje- és lipidszerkezetek termelésének fokozásával, \nvalamint felgyorsítják az epidermális megújulás ütemét.\n• Kenderolaj - intenzíven hidratál és táplál, gyulladáscsökkentő és antioxidáns tulajdonságokkal rendelkezik, megelőzi a kiszáradást és lerövidíti a sérült bőr gyógyulási idejét.\n• Probiotikumok és kenderolaj - erősíti a bőr természetes védőgátját, fenntartja a bőr túlzott kiszáradásának és viszketésének megszüntetéséhez szükséges optimális hidratáltsági szintet.', 'KEPEK/14_Kender+Probiotics balzsam 50g.jpg', 200, '2026-07-10 17:04:32'),
(15, 'Egyéb', 'Borz balzsam', '50 g', 2500, 'A gyógyhatása és értékes gyulladáscsökkentő és immunerősítő hatása összetevőiből ered, ilyenek például a kortikoszteroidok. A többszörösen telítetlen Omega 3 és Omega 6 zsírsavak kiegészítő forrása. A készítmény ezen felül A-vitamint és E-vitamint is tartalmaz.\nÉrelmeszesedés, tüdő- és légzőszervi betegségek, csökkent immunitás és zavart anyagcsere esetén alkalmazandó. Felvitel után gyorsan felszabadulnak a hatóanyagok, amelyek jótékony hatással vannak a légzési problémákra, segítik a légutak ellazulását, fokozzák a bőr vérkeringését az alkalmazás helyén és segítik a fájó izmok ellazulását.', 'KEPEK/15_Borz balzsam 50g.jpg', 200, '2026-07-10 17:04:32'),
(16, 'Egyéb', 'Tigris balzsam', '50 g', 2500, 'Nyugtató és lazító hatású. Javítja a vérkeringést, jó izomfájdalmakra. Nyugtatja a szúnyogcsípéseket, enyhíti a reumás fájdalmat, megszünteti az izzadságszagot, megnyugtatja a fájó torkot, enyhíti a fejfájást, segít orrdugulás ellen.\nGyógynövényes balzsam, amelynek receptjét a hagyományos tigriskrém összetétele ihlette, olyan illóolajok összetételét tartalmazza, mint a szegfűszegolaj, a fahéjolaj és az eukaliptuszolaj.\nEzek az összetevők gyulladáscsökkentő és fájdalomcsillapító hatást mutatnak. A balzsamban található kámfor felmelegít és javítja a vérkeringést. A mentol frissítő, hűsítő és inhalációs tulajdonságokkal rendelkezik. Gyulladáscsökkentő tulajdonságokkal rendelkezik és enyhíti a fájdalmakat. \n• Mentol - frissítő, nyugtató és nyákoldó hatású a légutakra.\n• Kámfor - gyulladáscsökkentő, melegítő és nyugtató tulajdonságokkal rendelkezik, és segít a légutak tehermentesítésében.\n• Borsmenta kivonat - hűsítő, frissítő, nyugtató és gyulladáscsökkentő hatású.\n• Eukaliptuszolaj - fertőtlenítő, gyulladáscsökkentő és frissítő.', 'KEPEK/16_Tigris balzsam 50g.jpg', 200, '2026-07-10 17:04:32'),
(17, 'Kender', 'Ajakápoló balzsam kendermagolajjal és E-vitaminnal', '4,5 g', 800, 'Intenzíven ápolja és táplálja a száraz, kirepedezett ajkakat. Természetes összetevőinek köszönhetően mélyen hidratálja az érzékeny ajkakat, miközben segít visszaadni puhaságukat és rugalmasságukat.', 'KEPEK/17_Ajakápoló balzsam kendermagolajjal.jpg', 200, '2026-07-10 17:04:32'),
(18, 'Egyéb', 'Ajakápoló balzsam aloe verával', '4,5 g', 800, 'Az aloe vera kiválóan alkalmas a száraz, kicserepesedett ajkak ápolására. Gyulladáscsökkentő, hidratáló és hűsítő hatásának köszönhetően elősegíti a berepedezett bőr regenerációját.', 'KEPEK/18_Ajakápoló védő rúzs aloe verával.jpg', 200, '2026-07-10 17:04:32'),
(19, 'Kender', 'Kenderolaj 100%', '30 ml', 2500, '100 % kenderolaj - kendermag (Cannabis Sativa) préselésével nyerik. A tiszta olaj önmagában természetes kozmetikum lehet a test- és \nhajápoláshoz. Ideális kiegészítő a késztermékek gazdagításához. A kenderolaj értékes tulajdonságai közvetlenül annak összetételéből adódnak. Csaknem 80 %-ban esszenciális zsírsavakból, Omega 3 és Omega 6 zsírsavakból áll. Az olaj A-, E- és K-vitamin, valamint B-vitaminok, ásványi anyagok (kalcium, magnéziuk, cink és foszfor), aminosavak és fitoszterolok gazdag forrása. A rengeteg hasznos összetevő a kenderolajat multifunkcionális termékké teszi a test és a haj mindennapi ápolásában. A kenderolaj főbb tulajdonságai:\n• Regeneráló hatás és az öregedés korai jeleinek ellensúlyozása.\n• Hidratáló hatás és a bőr rugalmasságának javítás. \n• A bőr külső tényezőkkel szembeni ellenállóképességének javítása (szél, fagy, napsütés).\n• A bőrgyulladás enyhítése.\n• A bőrfelület puhítása és simítása.\n• Az arc faggyúkiválasztásának szabályozása.\n• A haj töredezettségének csökkentése.\n•  A fejbőr irritációjának csökkentése.\n• Visszaállítja a haj rugalmasságát és fényét, és stimulálja a haj növekedését.\n', 'KEPEK/19_100%-os kenderolaj 30ml.jpg', 200, '2026-07-10 17:04:32');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsAdmin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `createdat`, `updatedat`, `IsAdmin`) VALUES
(1, 'tesztelek', 'teszt@example.com', '$2a$11$fqIIPWyHKbFrHGWu70ezHOAJr.oawVhDCNEuABgapYN4debLlUcam', '2026-07-16 15:18:45', '2026-07-16 15:18:45', 1),
(2, 'zsuzsa', 'teszt@teszt.com', '$2a$11$QGfBCjM/7m/55l3C73z/ju1QqSKChbwaNYi5XrkJgIJEk0AXgLhl.', '2026-07-17 16:11:17', '2026-07-17 16:11:17', 0),
(3, 'Heni', 'teszt2@example.com', '$2a$11$.7VKS88v2iSg9oG/AOuHZ.OAfk3AIvvdQnTYqWCmB/ny0Vu1G/yvW', '2026-07-31 14:49:10', '2026-07-31 14:49:10', 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
