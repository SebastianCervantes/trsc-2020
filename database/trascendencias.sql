-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 04, 2020 at 04:45 PM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

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
    (SELECT COUNT(u.campus) FROM usuario AS u WHERE u.campus='Preparatoria') AS preparatoria,
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `datos_usuario` (IN `id` INT)  BEGIN
    SELECT u.id_usuario AS id, u.nombre AS nombre, u.apellidos AS apellidos, u.correo AS correo, u.telefono AS tel, u.edad AS edad, u.carrera AS carrera, u.campus AS campus, u.sem AS sem, u.talla, u.veget AS veget, u.alergias AS alergias, u.visita_usuario AS visita, p.tipo AS tipo, DATE_FORMAT(p.fecha,GET_FORMAT(DATE,'EUR')) AS fecha, p.cantidad AS cantidad, p.deuda AS deuda, p.estatus AS status, pt.id_t AS id_taller, pt.dia AS dia
    FROM usuario u
    JOIN pago as p ON u.id_usuario = p.id_u
    JOIN participa as pt ON p.id_u = pt.id_u
    WHERE u.id_usuario = id
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_pago_actividades` (`cantidad_p` INT, `deuda_p` INT, `visita_v` INT, `taller1_t` INT, `taller2_t` INT, `id_us` INT, `fecha_p` DATETIME)  BEGIN
  DECLARE old_visita INT;
  DECLARE old_taller1 INT;
  DECLARE old_taller2 INT;
  	-- SELECCION DE VISITA Y TALLERES ANTERIORES
    SELECT visita_usuario INTO old_visita FROM usuario WHERE id_usuario = id_us;
    SELECT id_t INTO old_taller1 FROM participa WHERE id_u = id_us AND dia = 1;
    SELECT id_t INTO old_taller2 FROM participa WHERE id_u = id_us AND dia = 2;
	-- CAMBIO DE DISPONIBILIDAD EN VISITA Y TALLERES ANTERIORES
	UPDATE visita SET dispV = dispV + 1 WHERE id_visita = old_visita;
    UPDATE taller SET disp1 = disp1 + 1 WHERE id_taller = old_taller1;
    UPDATE taller SET disp2 = disp2 + 1 WHERE id_taller = old_taller2;
    -- ACTUALIZACION DE VISITA Y TALLERES
	UPDATE usuario SET visita_usuario = visita_v WHERE id_usuario = id_us;
	UPDATE visita SET dispV = dispV - 1 WHERE id_visita = visita_v;
    UPDATE participa SET id_t = taller1_t WHERE id_u = id_us AND dia = 1;
    UPDATE participa SET id_t = taller2_t WHERE id_u = id_us AND dia = 2;
    UPDATE taller SET disp1 = disp1 - 1 WHERE id_taller = taller1_t;
    UPDATE taller SET disp2 = disp2 - 1 WHERE id_taller = taller2_t;
    -- ACTUALIZACION DE DATOS DE PAGO
     UPDATE pago SET fecha = fecha_p WHERE id_u = id_us;
     UPDATE pago SET cantidad = cantidad_p WHERE id_u = id_us;
     UPDATE pago SET deuda = deuda_p WHERE id_u = id_us;
     UPDATE pago SET estatus = 'Pendiente' WHERE id_u = id_us AND cantidad = 0;
     UPDATE pago SET estatus = 'Abono' WHERE id_u = id_us AND cantidad > 0;
     UPDATE pago SET estatus = 'Pagado' WHERE id_u = id_us AND deuda = 0
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_participantes` ()  BEGIN
    SELECT u.id_usuario AS id, u.nombre AS nombre, u.apellidos AS apellidos, u.correo AS correo, p.estatus AS status
    FROM (Usuario AS u JOIN Pago AS p )
    WHERE u.id_usuario=p.id_u
    ORDER BY u.nombre, u.apellidos
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_talleres` ()  BEGIN
    SELECT t.id_taller AS id, t.nombreT AS nombre, t.capacidadT AS capacidad, t.disp1 AS dia1, t.disp2 AS dia2
    FROM taller AS t
    ORDER BY t.nombreT
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_visitas` ()  BEGIN
    SELECT v.id_visita AS id, v.nombreV AS nombre, v.capacidadV AS capacidad, v.dispV AS dia1
    FROM visita AS v
    ORDER BY v.nombreV
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (`user_u` VARCHAR(50))  BEGIN
    SELECT s.usuario AS usuario, s.psw AS password
    FROM staff s
    WHERE s.usuario = user_u
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro` (IN `nombre_u` VARCHAR(40), IN `apellidos_u` VARCHAR(60), IN `correo_u` VARCHAR(80), IN `telefono_u` VARCHAR(14), IN `edad_u` INT, IN `sexo_u` VARCHAR(1), IN `carrera_u` VARCHAR(100), IN `campus_u` VARCHAR(20), IN `sem_u` INT, IN `talla_u` VARCHAR(3), IN `veget_u` VARCHAR(2), IN `alergias_u` VARCHAR(100), IN `tipo_p` VARCHAR(10), IN `fecha_p` DATETIME, IN `cantidad_p` INT, IN `deuda_p` INT, IN `estatus_p` VARCHAR(15))  BEGIN
DECLARE id_variable INT;
INSERT IGNORE INTO usuario(nombre, apellidos, correo, telefono, edad, sexo, carrera, campus, sem, talla, veget, alergias, visita_usuario)VALUES(nombre_u, apellidos_u, correo_u, telefono_u, edad_u, sexo_u, carrera_u, campus_u, sem_u, talla_u, veget_u, alergias_u, 5000);
SELECT id_usuario INTO id_variable FROM usuario WHERE correo = correo_u;
INSERT IGNORE INTO pago(tipo, fecha, cantidad, deuda, id_u, estatus)VALUES(tipo_p, fecha_p, cantidad_p, deuda_p, id_variable, estatus_p);
INSERT IGNORE INTO participa(id_u, id_t, dia)VALUES(id_variable, 8080, 1);
INSERT IGNORE INTO participa(id_u, id_t, dia)VALUES(id_variable, 8888, 2);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selecciona_taller` ()  BEGIN
	SELECT t.id_taller, t.nombreT, t.capacidadT, t.disp1, t.disp2 
    FROM taller AS t
    ORDER BY t.nombret
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selecciona_visita` ()  BEGIN
    SELECT v.id_visita, v.nombreV, v.capacidadV, v.dispV
    FROM visita v
    ORDER BY v.nombreV
    ;
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
('dep/efec', '2020-05-25 18:39:55', 0, 950, 15, 'Pendiente'),
('dep/efec', '2020-05-26 21:58:38', 0, 950, 18, 'Pendiente'),
('dep/efec', '2020-05-26 21:58:38', 100, 850, 19, 'Abono'),
('dep/efec', '2020-05-27 09:55:26', 500, 450, 14, 'Abono'),
('dep/efec', '2020-05-27 10:54:07', 950, 0, 16, 'Pagado'),
('dep/efec', '2020-05-31 17:46:26', 700, 250, 17, 'Abono'),
('dep/efec', '2020-06-03 19:05:03', 0, 950, 22, 'Pendiente'),
('dep/efec', '2020-06-03 19:16:59', 0, 950, 23, 'Pendiente'),
('dep/efec', '2020-06-03 19:16:59', 0, 950, 24, 'Pendiente'),
('dep/efec', '2020-06-03 19:57:42', 0, 950, 25, 'Pendiente'),
('dep/efec', '2020-06-03 20:08:32', 0, 950, 26, 'Pendiente'),
('dep/efec', '2020-06-03 21:31:12', 0, 950, 27, 'Pendiente'),
('dep/efec', '2020-06-03 21:31:12', 0, 950, 28, 'Pendiente'),
('dep/efec', '2020-06-03 21:31:12', 0, 950, 29, 'Pendiente'),
('dep/efec', '2020-06-04 00:58:46', 0, 950, 32, 'Pendiente'),
('Deposito', '2020-05-25 18:39:55', 0, 950, 10, 'Pendiente'),
('Deposito', '2020-05-26 21:58:38', 0, 950, 7, 'Pendiente'),
('Deposito', '2020-05-27 11:19:49', 100, 850, 8, 'Abono'),
('Deposito', '2020-05-27 13:51:17', 950, 0, 4, 'Pagado'),
('Efectivo', '2020-05-25 18:39:55', 0, 950, 2, 'Pendiente'),
('Efectivo', '2020-05-25 18:39:55', 0, 950, 6, 'Pendiente'),
('Efectivo', '2020-05-26 21:58:38', 500, 450, 1, 'Abono'),
('Efectivo', '2020-05-26 21:58:38', 500, 450, 5, 'Abono'),
('Paypal', '2020-05-25 18:39:55', 0, 950, 3, 'Pendiente'),
('paypal', '2020-06-03 14:10:07', 0, 950, 20, 'Pendiente'),
('paypal', '2020-06-03 14:10:07', 0, 950, 21, 'Pendiente'),
('paypal', '2020-06-04 00:58:46', 0, 950, 33, 'Pendiente'),
('paypal', '2020-06-04 01:05:28', 950, 0, 34, 'Pagado');

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
(1, 8080, 1),
(1, 8888, 2),
(2, 8080, 1),
(2, 8888, 2),
(3, 8080, 1),
(3, 8888, 2),
(4, 8080, 1),
(4, 8888, 2),
(5, 8080, 1),
(5, 8888, 2),
(6, 8080, 1),
(6, 8888, 2),
(7, 8080, 1),
(7, 8888, 2),
(8, 8080, 1),
(8, 8888, 2),
(10, 8080, 1),
(10, 8888, 2),
(14, 8080, 1),
(14, 8888, 2),
(15, 4002, 1),
(15, 8888, 2),
(16, 8080, 1),
(16, 8888, 2),
(17, 8080, 1),
(17, 8888, 2),
(18, 8080, 1),
(18, 8888, 2),
(19, 8080, 1),
(19, 8888, 2),
(20, 8080, 1),
(20, 8888, 2),
(21, 8080, 1),
(21, 8888, 2),
(22, 8080, 1),
(22, 8888, 2),
(23, 8080, 1),
(23, 8888, 2),
(24, 8080, 1),
(24, 8888, 2),
(25, 8080, 1),
(25, 8888, 2),
(26, 8080, 1),
(26, 8888, 2),
(27, 8080, 1),
(27, 8888, 2),
(28, 8080, 1),
(28, 8888, 2),
(29, 8080, 1),
(29, 8888, 2),
(32, 8080, 1),
(32, 8888, 2),
(33, 8080, 1),
(33, 8888, 2),
(34, 8080, 1),
(34, 8888, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('RYh9trqBlrLJqWK7R4GdEVrIZt5q-tcP', 1591310520, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"cart\":{\"items\":{},\"session\":null,\"sessionKey\":\"Session20T\"}}'),
('i2CRS705sBU9XU9bpdZNYGw2ODPAq3UA', 1591374039, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"cart\":{\"nombre\":\"Lia Navidad\",\"apellidos\":\"Sandoval Cervantes\",\"correo\":\"lia.navid@gmail.com\",\"telefono\":\"(686) 234 0932\",\"edad\":\"24\",\"sexo\":\"F\",\"carrera\":\"IDGD\",\"campus\":\"CetysMxl\",\"sem\":\"7\",\"talla\":\"M\",\"veget\":\"Si\",\"alergias\":\"No\",\"tipo\":\"dep/efec\"}}'),
('qYDrGS5V8zAivmO_-081DSZ4VgbXg3FW', 1591334416, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"cart\":{\"items\":{\"0\":\"16\"},\"session\":\"Session20T\",\"sessionKey\":\"Session20T\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `usuario` varchar(50) NOT NULL,
  `psw` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`usuario`, `psw`) VALUES
('Admin20T', 'ad990fdf82a09571bc5c7a718ace77cfd4cb79b238006b764ede5b7dfe1d2831');

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
(4001, 'Lego robotica', 20, 20, 20),
(4002, 'Animacion', 15, 15, 15),
(4003, 'Makey makey', 24, 24, 24),
(4004, 'Como ser un rey', 13, 13, 13),
(4005, 'Mercadotecnia', 20, 20, 20),
(4006, 'Modelado 3D', 10, 10, 10),
(4007, 'Futbolito robotico', 15, 15, 15),
(4008, 'Matematicas financieras', 14, 14, 14),
(4009, 'Videojuegos', 10, 10, 10),
(4010, 'Arduino', 20, 20, 20),
(4011, 'Animación de Flyers', 24, 24, 24),
(4012, 'Stop Motion', 11, 11, 11),
(4013, 'Carro autonomo', 22, 22, 22),
(4014, 'Creacion de guion', 13, 13, 13),
(4015, 'Como ser guapo', 15, 15, 15),
(8080, 'Default1', 5000, 4997, 5000),
(8888, 'Default2', 5000, 5000, 4998);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `correo` varchar(80) NOT NULL,
  `telefono` varchar(14) NOT NULL,
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
(1, 'Mariana', 'García Ruiz', 'marianar@cetys.edu.mx', '6862090795', 22, 'F', 'IDGD', 'CetysMxl', 8, 'M', 'Si', 'No', 5000),
(2, 'Sebastian', 'Cervantes Villavicencio', 'sebastian.cervantes@cetys.edu.mx', '6862090795', 22, 'M', 'IDGD', 'CetysMxl', 8, 'M', 'No', 'No', 5000),
(3, 'Fabiola', 'Nuñez Zamorano', 'fabiola.nunez@cetys.edu.mx', '6862090795', 22, 'F', 'IDGD', 'CetysMxl', 8, 'M', 'No', 'Sulfas', 5000),
(4, 'Andrea', 'Armenta García', 'andrea.armenta@cetys.edu.mx', '6862090795', 22, 'F', 'IER', 'CetysTj', 8, 'L', 'No', 'No', 5000),
(5, 'Jose', 'Fernández Mercado', 'jose.fernandez@cetys.edu.mx', '6862090795', 22, 'M', 'IM', 'CetysMxl', 6, 'S', 'No', 'No', 5000),
(6, 'Fernando', 'Romo Hurtado', 'trasce-rey@gmail.com', '6862090795', 22, 'M', 'IMEX', 'CetysEns', 7, 'L', 'No', 'No', 5000),
(7, 'Nancy', 'Avila Magaña', 'nancysroom@gmail.com', '6862090795', 22, 'F', 'IM', 'CetysEns', 4, 'L', 'Si', 'No', 5000),
(8, 'Cristiano', 'Ronaldo Messi', 'cr7.messi@hotmail.com', '6862090795', 22, 'M', 'LAE', 'CetysEns', 5, 'XL', 'No', 'No', 5000),
(9, 'Carlos', 'Vizcarra Tío', 'sharleight@gmail.com', '6862090795', 22, 'M', 'IIND', 'CetysMxl', 7, 'L', 'No', 'No', 5004),
(10, 'Paola', 'Gutierrez Sonora', 'paola-gs@gmail.com', '6862090795', 22, 'F', 'ICC', 'Otro', 8, 'S', 'No', 'No', 5000),
(14, 'Kiara', 'Lucatero', 'kiara@gmail.com', '6862387628', 22, 'F', 'Aeroespacial', 'Otro', 4, 'XS', 'No', 'Almendras', 5000),
(15, 'Maribel Guadalupe', 'Villavicencio Castillon', 'maribel.g@gmail.com', '(567) 890 2355', 21, 'F', 'LDG', 'Otro', 3, 'XL', 'Si', 'No', 5000),
(16, 'Alejandra', 'Marcial Burciaga', 'ale.mar@cetys.edu.mx', '(686) 190 2455', 18, 'F', 'Ninguna', 'Preparatoria', 6, 'S', 'No', 'No', 5000),
(17, 'Fernando', 'Mendieta Gonzales', 'fernandomendieta@hotmail.com', '(686) 120 0317', 22, 'M', 'Mercadotecnia', 'CetysMxl', 7, 'M', 'Si', 'Sulfas', 5000),
(18, 'Andree Leonardo', 'Villegas Magallanes', 'andree.villegas@cetys.edu.mx', '(686) 456 8890', 22, 'M', 'IDGD', 'CetysMxl', 7, 'L', 'No', 'penicilina, amoxicilina, quilolonas', 5000),
(19, 'Gianelli', 'Cervantes Villavicencio', 'gianelli_cervantes@uabc.edu.mx', '(664) 268 5525', 25, 'M', 'Medicina', 'Otro', 8, 'L', 'No', 'No', 5000),
(20, 'Jason', 'Derulo', 'sb-pjztm1918638@business.example.com', '(686) 900 2120', 22, 'M', 'IMD', 'Otro', 5, 'XL', 'Si', 'No', 5000),
(21, 'Josefina', 'Vazques Mota', 'sb-6esjh1372265@personal.example.com', '(664) 268 5525', 23, 'F', 'Medicina', 'Otro', 6, 'L', 'Si', 'No', 5000),
(22, 'Gilberto', 'Jimenez Spriu', 'gilberto_j@gmail.com', '(686) 555 0988', 18, 'M', 'IER', 'Otro', 3, 'XS', 'Si', 'No', 5000),
(23, 'Johana', 'Padilla Solano', 'johana_25@gmail.com', '(686) 344 2684', 19, 'F', 'ICC', 'CetysMxl', 2, 'S', 'No', 'No', 5000),
(24, 'Elisa ', 'Loaiza Martinez', 'eli.loa@hotmail.com', '(686) 443 9765', 18, 'F', 'IR', 'Otro', 5, 'S', 'No', 'No', 5000),
(25, 'Mariana ', 'Guzman', 'mariana.guzman@gmail.com', '(686) 239 9861', 19, 'F', 'LDG', 'CetysTj', 4, 'XL', 'No', 'No', 5000),
(26, 'Lupita', 'Dalecio Arriaga', 'dalecio@yahoo.com', '(664) 277 9764', 20, 'F', 'Medicina', 'Otro', 5, 'XXL', 'Si', 'penicilina, amoxicilina, quilolonas', 5000),
(27, 'Daniela', 'Fainus Kellerman', 'cuatro_daniela@gmail.com', '(567) 890 2355', 22, 'F', 'IMEC', 'CetysEns', 8, 'S', 'Si', 'No', 5000),
(28, 'Gaston', 'Durango Crispin', 'duroduro@hotmail.com', '(686) 534 6613', 19, 'M', 'ICE', 'CetysTj', 2, 'M', 'No', 'Almendras', 5000),
(29, 'Viviana', 'Cervantes Villavicencio', 'v_viviana@gmail.com', '(686) 765 9987', 19, 'F', 'ICC', 'CetysMxl', 4, 'M', 'No', 'No', 5000),
(30, '', '', '', '', 0, '', '', '', 0, '', '', NULL, 5000),
(32, 'Zaida', 'Martinez Milan', 'z.aida_24@outlook.com', '(664) 268 5525', 19, 'F', 'IM', 'CetysEns', 3, 'M', 'Si', 'No', 5000),
(33, 'Leonardo', 'Barraza Vildosola', 'loe.barr@yahoo.com', '(567) 890 2355', 22, 'M', 'IDGD', 'CetysMxl', 4, 'M', 'No', 'No', 5000),
(34, 'Cristina', 'Curiel', 'cristina.curiel@uabc.edu.mx', '(664) 268 5525', 22, 'F', 'Medicina', 'Otro', 5, 'S', 'Si', 'No', 5000);

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
(5000, 'Default', 5000, 4996),
(5001, 'Bosch', 30, 30),
(5002, 'Gameloft', 20, 20),
(5003, 'Gulfstream', 40, 40),
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
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`usuario`,`psw`);

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
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

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
