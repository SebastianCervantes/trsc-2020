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


-- S T O R A G E - P R O C E D U R E S

-- Registro de usuarios
DELIMITER //
CREATE PROCEDURE registro(nombre_u VARCHAR(40), apellidos_u VARCHAR(60), correo_u VARCHAR(80), telefono_u VARCHAR(14), edad_u int, sexo_u VARCHAR(1), carrera_u VARCHAR(100), campus_u VARCHAR(20), sem_u INT, talla_u VARCHAR(3), veget_u VARCHAR(2), alergias_u VARCHAR(100), tipo_p VARCHAR(10), fecha_p DATETIME, cantidad_p int, deuda_p int, estatus_p VARCHAR(15))
BEGIN
DECLARE id_variable INT;
INSERT IGNORE INTO usuario(nombre, apellidos, correo, telefono, edad, sexo, carrera, campus, sem, talla, veget, alergias, visita_usuario)VALUES(nombre_u, apellidos_u, correo_u, telefono_u, edad_u, sexo_u, carrera_u, campus_u, sem_u, talla_u, veget_u, alergias_u, 5000);
SELECT id_usuario INTO id_variable FROM usuario WHERE correo = correo_u;
INSERT IGNORE INTO pago(tipo, fecha, cantidad, deuda, id_u, estatus)VALUES(tipo_p, fecha_p, cantidad_p, deuda_p, id_variable, estatus_p);
INSERT IGNORE INTO participa(id_u, id_t, dia)VALUES(id_variable, 8080, 1);
INSERT IGNORE INTO participa(id_u, id_t, dia)VALUES(id_variable, 8888, 2);
END
//


-- Datos de Dashboard
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
END
//

-- Listado de Participantes
DELIMITER //  
CREATE PROCEDURE listado_participantes() 
BEGIN
    SELECT u.id_usuario AS id, u.nombre AS nombre, u.apellidos AS apellidos, u.correo AS correo, p.estatus AS status
    FROM (Usuario AS u JOIN Pago AS p )
    WHERE u.id_usuario=p.id_u
    ORDER BY u.nombre, u.apellidos
    ;
END
//

-- Datos de Usuario para Vista Individual
DELIMITER // 
CREATE PROCEDURE datos_usuario( IN id INT) 
BEGIN
    SELECT u.id_usuario AS id, u.nombre AS nombre, u.apellidos AS apellidos, u.correo AS correo, u.telefono AS tel, u.edad AS edad, u.carrera AS carrera, u.campus AS campus, u.sem AS sem, u.talla, u.veget AS veget, u.alergias AS alergias, u.visita_usuario AS visita, p.tipo AS tipo, DATE_FORMAT(p.fecha,GET_FORMAT(DATE,'EUR')) AS fecha, p.cantidad AS cantidad, p.deuda AS deuda, p.estatus AS status, pt.id_t AS id_taller, pt.dia AS dia
    FROM usuario u
    JOIN pago as p ON u.id_usuario = p.id_u
    JOIN participa as pt ON p.id_u = pt.id_u
    WHERE u.id_usuario = id
    ;
END
//

-- Insercion de Pago y Actividades del Participante
DELIMITER // 
CREATE PROCEDURE insertar_pago_actividades(cantidad_p INT, deuda_p INT, visita_v INT, taller1_t INT, taller2_t INT, id_us INT, fecha_p DATETIME) 
BEGIN
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
END
//

-- Listado de Visitas para Seleccion en Vista Individual
DELIMITER // 
CREATE PROCEDURE selecciona_visita() 
BEGIN
    SELECT v.id_visita, v.nombreV, v.capacidadV, v.dispV
    FROM visita v
    ORDER BY v.nombreV
    ;
END
//

-- Listado de Talleres para Seleccion en Vista Individual
DELIMITER // 
CREATE PROCEDURE selecciona_taller() 
BEGIN
	SELECT t.id_taller, t.nombreT, t.capacidadT, t.disp1, t.disp2 
    FROM taller AS t
    ORDER BY t.nombret
    ;
END
//

-- Listado de Talleres
DELIMITER //  
CREATE PROCEDURE listado_talleres() 
BEGIN
    SELECT t.id_taller AS id, t.nombreT AS nombre, t.capacidadT AS capacidad, t.disp1 AS dia1, t.disp2 AS dia2
    FROM taller AS t
    ORDER BY t.nombreT
    ;
END
//

-- Listado de Visitas
DELIMITER //  
CREATE PROCEDURE listado_visitas() 
BEGIN
    SELECT v.id_visita AS id, v.nombreV AS nombre, v.capacidadV AS capacidad, v.dispV AS dia1
    FROM visita AS v
    ORDER BY v.nombreV
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
SELECT u.id_usuario, u.nombre, u.apellidos, u.correo, p.estatus
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




