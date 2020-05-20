-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 20, 2020 at 08:01 AM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trascendencias`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `dashboard_queries` ()  BEGIN
SELECT 
    (SELECT COUNT(*) FROM usuario) AS cantidad,
    (SELECT COUNT(p.estatus) FROM Pago AS p WHERE p.estatus="Pagado") AS liquidados,
    (SELECT SUM(cantidad) FROM pago) AS ingresos,
    (SELECT COUNT(u.campus) FROM usuario AS u WHERE u.campus='CetysMxl') AS campus_mxl,
    (SELECT COUNT(u.campus) FROM usuario AS u WHERE u.campus='CetysTj') AS campus_tj,
    (SELECT COUNT(u.campus) FROM usuario AS u WHERE u.campus='CetysEns') AS campus_ens,
    (SELECT COUNT(u.campus) FROM usuario AS u WHERE u.campus='Prepatoria') AS preparatoria,
    (SELECT COUNT(u.campus) FROM usuario AS u WHERE u.campus='Otro') AS otro,
    (SELECT COUNT(u.talla) FROM usuario AS u WHERE u.talla='XS') AS talla_xs,
    (SELECT COUNT(u.talla) FROM usuario AS u WHERE u.talla='S') AS talla_s,
    (SELECT COUNT(u.talla) FROM usuario AS u WHERE u.talla='M') AS talla_m,
    (SELECT COUNT(u.talla) FROM usuario AS u WHERE u.talla='L') AS talla_l,
    (SELECT COUNT(u.talla) FROM usuario AS u WHERE u.talla='XL') AS talla_xl,
    (SELECT COUNT(u.talla) FROM usuario AS u WHERE u.talla='XXL') AS talla_xxl,
    (SELECT COUNT(u.veget) FROM usuario AS u WHERE u.veget='no') AS veget_no,
    (SELECT COUNT(u.veget) FROM usuario AS u WHERE u.veget='si') AS veget_si
   ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro` (`nombre_u` VARCHAR(40), `apellidos_u` VARCHAR(60), `correo_u` VARCHAR(80), `telefono_u` VARCHAR(12), `edad_u` INT, `sexo_u` VARCHAR(1), `carrera_u` VARCHAR(100), `campus_u` VARCHAR(20), `sem_u` INT, `talla_u` VARCHAR(3), `veget_u` VARCHAR(2), `alergias_u` VARCHAR(100), `tipo_p` VARCHAR(10), `fecha_p` DATETIME, `cantidad_p` INT, `deuda_p` INT, `estatus_p` VARCHAR(15))  BEGIN
DECLARE id_pago INT;
INSERT IGNORE INTO usuario(nombre, apellidos, correo, telefono, edad, sexo, carrera, campus, sem, talla, veget, alergias)VALUES(nombre_u, apellidos_u, correo_u, telefono_u, edad_u, sexo_u, carrera_u, campus_u, sem_u, talla_u, veget_u, alergias_u);
SELECT id_usuario INTO id_pago FROM usuario WHERE correo = correo_u;
INSERT IGNORE INTO pago(tipo, fecha, cantidad, deuda, id_u, estatus)VALUES(tipo_p, fecha_p, cantidad_p, deuda_p, id_pago, estatus_p);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pago`
--

CREATE TABLE `pago` (
  `tipo` varchar(10) NOT NULL,
  `fecha` datetime NOT NULL,
  `cantidad` int(11) NOT NULL,
  `deuda` int(11) NOT NULL,
  `id_u` int(11) NOT NULL,
  `estatus` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pago`
--

INSERT INTO `pago` (`tipo`, `fecha`, `cantidad`, `deuda`, `id_u`, `estatus`) VALUES
('dep/efec', '2020-10-03 10:20:42', 0, 950, 14, 'Pendiente'),
('Deposito', '2020-09-30 10:20:38', 550, 400, 4, 'Abono'),
('Deposito', '2020-09-30 10:20:41', 950, 0, 7, 'Pagado'),
('Deposito', '2020-10-01 10:20:42', 0, 950, 8, 'Pagado'),
('Deposito', '2020-10-03 10:20:42', 550, 400, 10, 'Abono'),
('Efectivo', '2020-09-27 10:20:35', 950, 0, 1, 'Pagado'),
('Efectivo', '2020-09-28 10:20:36', 950, 0, 2, 'Pagado'),
('Efectivo', '2020-09-30 10:20:39', 950, 0, 5, 'Pagado'),
('Efectivo', '2020-09-30 10:20:40', 550, 400, 6, 'Abono'),
('Paypal', '2020-09-29 10:20:37', 950, 0, 3, 'Pagado');

-- --------------------------------------------------------

--
-- Table structure for table `participa`
--

CREATE TABLE `participa` (
  `id_u` int(11) NOT NULL,
  `id_t` int(11) NOT NULL,
  `dia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `participa`
--

INSERT INTO `participa` (`id_u`, `id_t`, `dia`) VALUES
(1, 4004, 1),
(1, 4012, 2),
(2, 4004, 1),
(2, 4012, 2),
(3, 4004, 1),
(3, 4012, 2),
(4, 4001, 1),
(4, 4011, 2),
(5, 4008, 1),
(5, 4015, 2),
(6, 4004, 2),
(6, 4015, 1),
(7, 4012, 2),
(7, 4015, 1),
(8, 4004, 1),
(8, 4011, 2),
(10, 4001, 1),
(10, 4002, 2);

-- --------------------------------------------------------

--
-- Table structure for table `taller`
--

CREATE TABLE `taller` (
  `id_taller` int(11) NOT NULL,
  `nombreT` varchar(100) NOT NULL,
  `capacidadT` int(11) NOT NULL,
  `disp1` int(11) NOT NULL,
  `disp2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `taller`
--

INSERT INTO `taller` (`id_taller`, `nombreT`, `capacidadT`, `disp1`, `disp2`) VALUES
(4001, 'Lego robotica', 20, 18, 20),
(4002, 'Animacion', 15, 15, 14),
(4003, 'Makey makey', 24, 24, 24),
(4004, 'Como ser un rey', 13, 9, 12),
(4005, 'Mercadotecnia', 20, 20, 20),
(4006, 'Modelado 3D', 10, 10, 10),
(4007, 'Futbolito robotico', 15, 15, 15),
(4008, 'Matematicas financieras', 14, 13, 14),
(4009, 'Videojuegos', 10, 10, 10),
(4010, 'Arduino', 20, 20, 20),
(4011, 'Animación de Flyers', 24, 24, 22),
(4012, 'Stop Motion', 11, 11, 7),
(4013, 'Carro autonomo', 22, 22, 22),
(4014, 'Creacion de guion', 13, 13, 13),
(4015, 'Como ser guapo', 15, 13, 14);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `correo` varchar(80) NOT NULL,
  `telefono` varchar(12) NOT NULL,
  `edad` int(11) NOT NULL,
  `sexo` varchar(1) NOT NULL,
  `carrera` varchar(100) NOT NULL,
  `campus` varchar(20) NOT NULL,
  `sem` int(11) NOT NULL,
  `talla` varchar(3) NOT NULL,
  `veget` varchar(2) NOT NULL,
  `alergias` varchar(100) DEFAULT NULL,
  `visita_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `apellidos`, `correo`, `telefono`, `edad`, `sexo`, `carrera`, `campus`, `sem`, `talla`, `veget`, `alergias`, `visita_usuario`) VALUES
(1, 'Mariana', 'García Ruiz', 'marianar@cetys.edu.mx', '6862090795', 22, 'F', 'IDGD', 'CetysMxl', 8, 'M', 'Si', 'No', 5002),
(2, 'Sebastian', 'Cervantes Villavicencio', 'sebastian.cervantes@cetys.edu.mx', '6862090795', 22, 'M', 'IDGD', 'CetysMxl', 8, 'M', 'No', 'No', 5002),
(3, 'Fabiola', 'Nuñez Zamorano', 'fabiola.nunez@cetys.edu.mx', '6862090795', 22, 'F', 'IDGD', 'CetysMxl', 8, 'M', 'No', 'Sulfas', 5002),
(4, 'Andrea', 'Armenta García', 'andrea.armenta@cetys.edu.mx', '6862090795', 22, 'F', 'IER', 'CetysTj', 8, 'L', 'No', 'No', 5001),
(5, 'Jose', 'Fernández Mercado', 'jose.fernandez@cetys.edu.mx', '6862090795', 22, 'M', 'IM', 'CetysMxl', 6, 'S', 'No', 'No', 5003),
(6, 'Fernando', 'Romo Hurtado', 'trasce-rey@gmail.com', '6862090795', 22, 'M', 'IMEX', 'CetysEns', 7, 'L', 'No', 'No', 5003),
(7, 'Nancy', 'Avila Magaña', 'nancysroom@gmail.com', '6862090795', 22, 'F', 'IM', 'CetysEns', 4, 'L', 'Si', 'No', 5003),
(8, 'Cristiano', 'Ronaldo Messi', 'cr7.messi@hotmail.com', '6862090795', 22, 'M', 'LAE', 'CetysEns', 5, 'XL', 'No', 'No', 5003),
(9, 'Carlos', 'Vizcarra Tío', 'sharleight@gmail.com', '6862090795', 22, 'M', 'IIND', 'CetysMxl', 7, 'L', 'No', 'No', 5004),
(10, 'Paola', 'Gutierrez Sonora', 'paola-gs@gmail.com', '6862090795', 22, 'F', 'ICC', 'Otro', 8, 'S', 'No', 'No', 5001),
(14, 'Kiara', 'Lucatero', 'kiara@gmail.com', '6862387628', 22, 'F', 'Aeroespacial', 'Otro', 4, 'XS', 'No', 'Almendras', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `visita`
--

CREATE TABLE `visita` (
  `id_visita` int(11) NOT NULL,
  `nombreV` varchar(100) NOT NULL,
  `capacidadV` int(11) NOT NULL,
  `dispV` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visita`
--

INSERT INTO `visita` (`id_visita`, `nombreV`, `capacidadV`, `dispV`) VALUES
(5001, 'Bosch', 30, 28),
(5002, 'Gameloft', 20, 17),
(5003, 'Gulfstream', 40, 36),
(5004, 'Honeywell', 40, 39),
(5005, 'Kenworth', 35, 35),
(5006, 'Collins Aerospace', 15, 15),
(5007, 'Skyworks', 45, 45);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`tipo`,`fecha`,`cantidad`,`id_u`),
  ADD KEY `id_u` (`id_u`);

--
-- Indexes for table `participa`
--
ALTER TABLE `participa`
  ADD PRIMARY KEY (`id_u`,`id_t`),
  ADD KEY `id_t` (`id_t`);

--
-- Indexes for table `taller`
--
ALTER TABLE `taller`
  ADD PRIMARY KEY (`id_taller`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `visita_usuario` (`visita_usuario`);

--
-- Indexes for table `visita`
--
ALTER TABLE `visita`
  ADD PRIMARY KEY (`id_visita`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_u`) REFERENCES `usuario` (`id_usuario`);

--
-- Constraints for table `participa`
--
ALTER TABLE `participa`
  ADD CONSTRAINT `participa_ibfk_1` FOREIGN KEY (`id_u`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `participa_ibfk_2` FOREIGN KEY (`id_t`) REFERENCES `taller` (`id_taller`);

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`visita_usuario`) REFERENCES `visita` (`id_visita`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
