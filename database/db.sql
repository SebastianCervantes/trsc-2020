CREATE DATABASE trascendencias;

USE trascendencias;

CREATE TABLE Taller1(
nt1 VARCHAR(100) NOT NULL,
capt1 int NOT NULL,
dispt1 int NOT NULL,
PRIMARY KEY (nt1)
);

CREATE TABLE Taller2(
nt2 VARCHAR(100) NOT NULL,
capt2 int NOT NULL,
dispt2 int NOT NULL,
PRIMARY KEY (nt2)
);

CREATE TABLE Visita(
nv VARCHAR(100) NOT NULL,
capv int NOT NULL,
dispv int NOT NULL,
PRIMARY KEY (nv)
);

CREATE TABLE usuario ( 
nombre VARCHAR(40) NOT NULL,
apellidos VARCHAR(60) NOT NULL,
correo VARCHAR(80) NOT NULL,
telefono VARCHAR(10) NOT NULL,
edad int NOT NULL,
sexo VARCHAR(1) NOT NULL,
carrera VARCHAR(100) NOT NULL,
campus VARCHAR(20) NOT NULL,
sem int NOT NULL,
talla VARCHAR(3) NOT NULL,
alergias VARCHAR(100),
veget VARCHAR(2) NOT NULL,
tipo_pago VARCHAR(10) NOT NULL,
taller1 VARCHAR(100),
taller2 VARCHAR(100),
visita VARCHAR(50),
PRIMARY KEY (correo)
);

CREATE TABLE Pago(
tipo VARCHAR(10) NOT NULL,
fecha DATETIME NOT NULL,
cantidad int NOT NULL,
deuda int NOT NULL,
correoU VARCHAR(80) NOT NULL,
estatus VARCHAR(15) NOT NULL,
FOREIGN KEY(correoU) REFERENCES Usuario(correo),
PRIMARY KEY(tipo, fecha, cantidad, correoU)
);
