DROP DATABASE IF EXISTS proyecto_turixmo;

CREATE DATABASE proyecto_turixmo;
USE proyecto_turixmo;

CREATE TABLE pais(
idpais INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(100)  NOT NULL,
nacionalidad varchar(100) NOT NULL,
primary key(idpais)
);

CREATE TABLE departamento(
iddepartamento INT NOT NULL AUTO_INCREMENT,
idpais INT NOT NULL,
nombre VARCHAR(100)  NOT NULL,
primary key ( iddepartamento ),
foreign key (idpais) references pais(idpais)
);

CREATE TABLE ciudad(
idciudad INT NOT NULL AUTO_INCREMENT,
iddepartamento INT NOT NULL,
nombre VARCHAR(100)  NOT NULL,
primary key(idciudad),
foreign key (iddepartamento) references departamento(iddepartamento)
);

CREATE TABLE tipodocumento(
idtipodocumento INT NOT NULL AUTO_INCREMENT,
nombre varchar(50)  NOT NULL,
primary key(idtipodocumento)
);

CREATE TABLE rol(
idrol INT NOT NULL AUTO_INCREMENT,
nombre varchar(50)  NOT NULL,
primary key(idrol)
);

CREATE TABLE usuario(
idusuario INT NOT NULL AUTO_INCREMENT,
idtipodocumento INT  NOT NULL,
numerodocumento VARCHAR(100)  NOT NULL UNIQUE,
idpais INT  NOT NULL,
idrol INT  NOT NULL,
nombre VARCHAR(100)  NOT NULL,
apellido VARCHAR(100)  NOT NULL,
correo VARCHAR(100)  NOT NULL UNIQUE,
contrasena VARCHAR(100)  NOT NULL,
celular VARCHAR(100)  NOT NULL UNIQUE,
genero boolean NULL , -- null ->Indefinido 1->Hombre  0-> Mujer
token VARCHAR(100) NULL, -- recuperar contrasena
imagen varchar(200) NULL,
fechanacimiento DATE NULL,
fecharegistro DATETIME  NOT NULL,
inhabilitado BOOLEAN NOT NULL,
primary key(idusuario),
foreign key (idtipodocumento) references tipodocumento (idtipodocumento),
foreign key (idrol) references rol (idrol)
);

CREATE TABLE servicio (
idservicio INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
descripcion varchar(200) NULL,
primary key (idservicio)
);

CREATE TABLE estadoreserva (
idestadoreserva INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
descripcion varchar(200) NULL,
primary key (idestadoreserva)
);

CREATE TABLE tipohabitacion (
idtipohabitacion INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
descripcion varchar(200) NULL,
primary key (idtipohabitacion)
);

CREATE TABLE hotel(
idhotel INT NOT NULL AUTO_INCREMENT,
idusuario INT NOT NULL , 
idciudad INT NULL,
estrella INT NULL,
nombre VARCHAR(100) NOT NULL,
direccion VARCHAR(100) NOT NULL,
telefono VARCHAR(100) NULL,
celular VARCHAR(100) NOT NULL,
correo VARCHAR(100) NOT NULL,
sitioweb VARCHAR(100) NULL,
descripcion MEDIUMTEXT NULL,
fecharegistro DATETIME NOT NULL,
inhabilitado BOOLEAN NOT NULL,
primary key (idhotel),
foreign key (idusuario) references usuario (idusuario),
foreign key (idciudad) references ciudad (idciudad)
);

CREATE TABLE habitacion(
idhabitacion INT NOT NULL AUTO_INCREMENT,
idtipohabitacion INT NOT NULL ,
idhotel INT NOT NULL , 
numerohabitacion VARCHAR(50) NULL,
cantidadmaxpersonas INT NOT NULL,
cantidadminpersonas INT NOT NULL,
precionochepersona FLOAT NOT NULL,
preciobase FLOAT  NOT NULL,
numeropiso VARCHAR(50) NULL,
descripcion mediumtext NULL,
disponibilidad BOOLEAN NOT NULL,
fecharegistro DATETIME NOT NULL,
inhabilitado BOOLEAN NOT NULL,
primary key (idhabitacion),
foreign key (idtipohabitacion) references tipohabitacion (idtipohabitacion),
foreign key (idhotel) references hotel (idhotel)
);

CREATE TABLE habitacionservicio (
idhabitacionservicio INT NOT NULL AUTO_INCREMENT,
idhabitacion INT NOT NULL,
idservicio INT NOT NULL,
precio FLOAT NOT NULL,
primary key (idhabitacionservicio),
foreign key (idhabitacion) references habitacion (idhabitacion),
foreign key (idservicio) references servicio (idservicio)
);


CREATE TABLE reserva(
idreserva  INT NOT NULL AUTO_INCREMENT,
idusuario INT NOT NULL, 
idestadoreserva INT NOT NULL,
preciototal FLOAT NOT NULL,
descripcion TEXT NULL,
fechaentrada DATETIME  NOT NULL,
fechasalida DATETIME  NOT NULL,
fechareserva DATETIME  NOT NULL,
inhabilitado BOOLEAN NOT NULL,
primary key(idreserva),
foreign key (idusuario) references usuario (idusuario),
foreign key (idestadoreserva) references estadoreserva (idestadoreserva)
);

CREATE TABLE imagen (
idimagen INT NOT NULL AUTO_INCREMENT,
idhabitacion INT NOT NULL,
titulo varchar(100) NULL,
url varchar(500) NOT NULL,
fecharegistro DATETIME NOT NULL,
primary key (idimagen),
foreign key (idhabitacion) references habitacion (idhabitacion)
);

CREATE TABLE reservahabitacion (
idreservahabitacion INT NOT NULL AUTO_INCREMENT,
idhabitacion INT NOT NULL,
idreserva INT NOT NULL,
precio FLOAT NOT NULL,
descuento FLOAT NOT NULL,
fecharegistro DATETIME NOT NULL,
primary key (idreservahabitacion),
foreign key (idhabitacion) references habitacion (idhabitacion),
foreign key (idreserva) references reserva (idreserva)
);

CREATE TABLE puntuacion (
idpuntuacion INT NOT NULL AUTO_INCREMENT,
idhabitacion INT NOT NULL,
idusuario INT NOT NULL,
puntuacion INT NOT NULL,
fecharegistro DATETIME NOT NULL,
primary key (idpuntuacion),
foreign key (idhabitacion) references habitacion (idhabitacion)
);

CREATE TABLE favorito (
idfavorito INT NOT NULL AUTO_INCREMENT,
idusuario INT NOT NULL,
idhabitacion INT NOT NULL,
fecharegistro DATETIME NOT NULL,
primary key (idfavorito),
foreign key (idusuario) references usuario (idusuario)
);

CREATE TABLE comentario (
idcomentario INT NOT NULL AUTO_INCREMENT,
idhabitacion INT NOT NULL,
idusuario INT NOT NULL,
comentario MEDIUMTEXT NOT NULL,
fecharegistro DATETIME NOT NULL,
primary key (idcomentario),
foreign key (idhabitacion) references habitacion (idhabitacion)
);
