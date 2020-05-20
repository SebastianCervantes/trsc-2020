-- CREACIÓN DE BASE DE DATOS

CREATE DATABASE trascendencias;
USE trascendencias;

CREATE TABLE taller(
id_taller int NOT NULL,
nombreT VARCHAR(100) NOT NULL,
capacidadT int NOT NULL,
disp1 int NOT NULL,
disp2 int NOT NULL,
PRIMARY KEY (id_taller)
);

CREATE TABLE visita(
id_visita int NOT NULL,
nombreV VARCHAR(100) NOT NULL,
capacidadV int NOT NULL,
dispV int NOT NULL,
PRIMARY KEY (id_visita)
);

CREATE TABLE usuario
(id_usuario int NOT NULL, 
nombre VARCHAR(40) NOT NULL,
apellidos VARCHAR(60) NOT NULL,
correo VARCHAR(80) NOT NULL,
telefono VARCHAR(12) NOT NULL,
edad int NOT NULL,
sexo VARCHAR(1) NOT NULL,
carrera VARCHAR(100) NOT NULL,
campus VARCHAR(20) NOT NULL,
sem int NOT NULL,
talla VARCHAR(3) NOT NULL,
veget VARCHAR(2) NOT NULL,
alergias VARCHAR(100),
visita_usuario int,
PRIMARY KEY (id_usuario),
FOREIGN KEY(visita_usuario) REFERENCES visita(id_visita),
UNIQUE (correo)
);

CREATE TABLE pago(
tipo VARCHAR(10) NOT NULL,
fecha DATETIME NOT NULL,
cantidad int NOT NULL,
deuda int NOT NULL,
id_u int NOT NULL,
estatus VARCHAR(15) NOT NULL,
FOREIGN KEY(id_u) REFERENCES usuario(id_usuario),
PRIMARY KEY(tipo, fecha, cantidad, id_u)
);

CREATE TABLE participa(
id_u int NOT NULL,
id_t int NOT NULL,
dia int NOT NULL,
FOREIGN KEY(id_u) REFERENCES usuario(id_usuario),
FOREIGN KEY(id_t) REFERENCES taller(id_taller),
PRIMARY KEY(id_u, id_t)
);


-- LLENADO DE TABLAS

INSERT INTO taller
VALUES
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

INSERT INTO visita
VALUES
(5001, 'Bosch', 30, 28),
(5002, 'Gameloft', 20, 17),
(5003, 'Gulfstream', 40, 36),
(5004, 'Honeywell', 40, 39),
(5005, 'Kenworth', 35, 35),
(5006, 'Collins Aerospace', 15, 15),
(5007, 'Skyworks', 45, 45);

INSERT INTO usuario (nombre, apellidos, correo, telefono, edad, sexo, carrera, campus, sem, talla, veget, alergias, visita_usuario)
VALUES 
('Mariana', 'García Ruiz', 'marianar@cetys.edu.mx', '6862090795', 22, 'F', 'IDGD', 'CetysMxl', 8, 'M', 'Si', 'No', 5002),
('Sebastian', 'Cervantes Villavicencio', 'sebastian.cervantes@cetys.edu.mx', '6862090795', 22, 'M', 'IDGD', 'CetysMxl', 8, 'M', 'No', 'No', 5002),
('Fabiola', 'Nuñez Zamorano', 'fabiola.nunez@cetys.edu.mx', '6862090795', 22, 'F', 'IDGD', 'CetysMxl', 8, 'M', 'No', 'Sulfas', 5002),
('Andrea', 'Armenta García', 'andrea.armenta@cetys.edu.mx', '6862090795', 22, 'F', 'IER', 'CetysTj', 8, 'L', 'No', 'No', 5001),
('Jose', 'Fernández Mercado', 'jose.fernandez@cetys.edu.mx', '6862090795', 22, 'M', 'IM', 'CetysMxl', 6, 'S', 'No', 'No', 5003),
('Fernando', 'Romo Hurtado', 'trasce-rey@gmail.com', '6862090795', 22, 'M', 'IMEX', 'CetysEns', 7, 'L', 'No', 'No', 5003),
('Nancy', 'Avila Magaña', 'nancysroom@gmail.com', '6862090795', 22, 'F', 'IM', 'CetysEns', 4, 'L', 'Si', 'No', 5003),
('Cristiano', 'Ronaldo Messi', 'cr7.messi@hotmail.com', '6862090795', 22, 'M', 'LAE', 'CetysEns', 5, 'XL', 'No', 'No', 5003),
('Carlos', 'Vizcarra Tío', 'sharleight@gmail.com', '6862090795', 22, 'M', 'IIND', 'CetysMxl', 7, 'L', 'No', 'No', 5004),
( 'Paola', 'Gutierrez Sonora', 'paola-gs@gmail.com', '6862090795', 22, 'F', 'ICC', 'Otro', 8, 'S', 'No', 'No', 5001);

INSERT INTO pago
VALUES
('Efectivo', '2020-09-27 10:20:35', 950, 0, 1, 'Pagado'),
('Efectivo', '2020-09-28 10:20:36', 950, 0, 2, 'Pagado'),
('Paypal', '2020-09-29 10:20:37', 950, 0, 3, 'Pagado'),
('Deposito', '2020-09-30 10:20:38', 550, 400, 4, 'Abono'),
('Efectivo', '2020-09-30 10:20:39', 950, 0, 5, 'Pagado'),
('Efectivo', '2020-09-30 10:20:40', 550, 400, 6, 'Abono'),
('Deposito', '2020-09-30 10:20:41', 950, 0, 7, 'Pagado'),
('Deposito', '2020-10-01 10:20:42', 0, 950, 8, 'Pagado'),
('Deposito', '2020-10-03 10:20:42', 550, 400, 10, 'Abono');

INSERT INTO participa
VALUES
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
(6, 4015, 1),
(6, 4004, 2),
(7, 4015, 1),
(7, 4012, 2),
(8, 4004, 1),
(8, 4011, 2),
(10, 4001, 1),
(10, 4002, 2);

-- Storage Procedures
DELIMITER //
CREATE PROCEDURE registro(nombre_u VARCHAR(40), apellidos_u VARCHAR(60), correo_u VARCHAR(80), telefono_u VARCHAR(12), edad_u int, sexo_u VARCHAR(1), carrera_u VARCHAR(100), campus_u VARCHAR(20), sem_u int, talla_u VARCHAR(3), veget_u VARCHAR(2), alergias_u VARCHAR(100), tipo_p VARCHAR(10), fecha_p DATETIME, cantidad_p int, deuda_p int, estatus_p VARCHAR(15))
BEGIN
DECLARE id_pago INT;
INSERT IGNORE INTO usuario(nombre, apellidos, correo, telefono, edad, sexo, carrera, campus, sem, talla, veget, alergias)VALUES(nombre_u, apellidos_u, correo_u, telefono_u, edad_u, sexo_u, carrera_u, campus_u, sem_u, talla_u, veget_u, alergias_u);
SELECT id_usuario INTO id_pago FROM usuario WHERE correo = correo_u;
INSERT IGNORE INTO pago(tipo, fecha, cantidad, deuda, id_u, estatus)VALUES(tipo_p, fecha_p, cantidad_p, deuda_p, id_pago, estatus_p);
END
//

DELIMITER //  
CREATE PROCEDURE dashboard_queries() 
BEGIN
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
END
//


CALL registro('Kiara', 'Lucatero', 'kiara@gmail.com', '6862387628', '22', 'F', 'Aeroespacial', 'Otro', 4, 'XS', 'No', 'Almendras', 'dep/efec', '2020-10-03T10:20:42', 0, 950, 'Pendiente');

-- QUERIES

-- Búsqueda de participante por nombre, seleccionando todas las tuplas

SELECT u.*, p.estatus
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.nombre='input' and u.apellidos='input';

-- Listado de participantes por campus, seleccionando solo nombre, apellidos, correo y estatus de pago

-- Preparatoria
SELECT u.nombre, u.apellidos, u.correo, p.estatus
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Preparatoria';

-- Mexicali
SELECT u.nombre, u.apellidos, u.correo, p.estatus
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Mexicali';

-- Tijuana
SELECT u.nombre, u.apellidos, u.correo, p.estatus
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Tijuana';

-- Ensenada
SELECT u.nombre, u.apellidos, u.correo, p.estatus
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Ensenada';

-- Otros
SELECT u.nombre, u.apellidos, u.correo, p.estatus
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Otro';




-- Listado de participantes por campus

-- Preparatoria
SELECT u.nombre, u.apellidos, u.correo, u.sem, u.carrera, p.cantidad
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Preparatoria';

-- Mexicali
SELECT u.nombre, u.apellidos, u.correo, u.sem, u.carrera, p.cantidad
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Mexicali';

-- Tijuana
SELECT u.nombre, u.apellidos, u.correo, u.sem, u.carrera, p.cantidad
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Tijuana';

-- Ensenada
SELECT u.nombre, u.apellidos, u.correo, u.sem, u.carrera, p.cantidad
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Ensenada';

-- Otros
SELECT u.nombre, u.apellidos, u.correo, u.sem, u.carrera, p.cantidad
FROM (Usuario AS u JOIN Pago AS p ON u.id_usuario=p.id_usu)
WHERE u.campus='Otro';

-- Modificación de Datos de Participante

UPDATE Usuario 
SET atributo_que_se_cambiara='input'
WHERE correoU='input';

-- Actualización de Pago o Abono, Fecha y Hora y deuda

UPDATE Pago 
SET cantidad='input', deuda='input', fecha='input', estatus='input'
WHERE correoU='input';

-- Ingreso de Taller

INSERT INTO Taller
VALUES ('id','nombre','capacidad','disponibilidad')

-- Ingreso de Visita

INSERT INTO Visita
VALUES ('id','nombre','capacidad','disponibilidad')

-- Listado de participantes por taller 1

SELECT u.nombre, u.apellidos, u.correo
FROM (Usuario AS u JOIN (Participa AS p JOIN Taller AS t ON p.id_t=t.id_taller) ON  u.id_usuario=p.id_u)
WHERE t.id_taller='id_del_taller_aqui' and p.dia='1';

-- Listado de participantes por taller 2

SELECT u.nombre, u.apellidos, u.correo
FROM (Usuario AS u JOIN (Participa AS p JOIN Taller AS t ON p.id_t=t.id_taller) ON  u.id_usuario=p.id_u)
WHERE t.id_taller='id_del_taller_aqui' and p.dia='2';

-- Listado de participantes por visita

SELECT u.nombre, u.apellidos, u.correo
FROM (Usuario AS u JOIN Visita AS v ON u.visita=v.id_visita)
WHERE id_visita='id_de_visita_aqui';




-- Dashboard QUERIES

-- Participantes registrados
SELECT COUNT(*)
FROM Usuario;

-- Carnets pagados
SELECT COUNT(p.estatus)
FROM Pago AS p
WHERE p.estatus='Pagado';

-- Participantes registrados por campus
-- Prepa
SELECT COUNT(u.campus)
FROM Usuario AS u
WHERE u.campus='Preparatoria';

-- Mexicali
SELECT COUNT(u.campus)
FROM Usuario AS u
WHERE u.campus='Mexicali';

-- Tijuana
SELECT COUNT(u.campus)
FROM 	Usuario AS u
WHERE u.campus='Tijuana';

-- Ensenada
SELECT COUNT(u.campus)
FROM Usuario AS u
WHERE u.campus='Ensenada';

-- Otro
SELECT COUNT(u.campus)
FROM Usuario AS u
WHERE u.campus='Otro';

-- Cantidad de camisetas solicitadas por talla
-- XS
SELECT COUNT(u.talla) AS 
FROM Usuario AS u
WHERE u.talla='XS';

-- S
SELECT COUNT(u.talla)
FROM Usuario AS u
WHERE u.talla='S';

-- M
SELECT COUNT(u.talla)
FROM Usuario AS u
WHERE u.talla='M';

-- L
SELECT COUNT(u.talla)
FROM Usuario AS u
WHERE u.talla='L';

-- XL
SELECT COUNT(u.talla)
FROM Usuario AS u
WHERE u.talla='XL';

-- XXL
SELECT COUNT(u.talla)
FROM Usuario AS u
WHERE u.talla='XXL';

-- Cantidad de personas vegetarianas y no vegetarianas
-- Vegetarianas
SELECT COUNT(u.veget)
FROM Usuario AS u
WHERE u.veget='si';

-- No vegetarianas
SELECT COUNT(u.veget)
FROM Usuario AS u
WHERE u.veget='no';

