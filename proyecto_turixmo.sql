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

-- creacion de vistas
create view v_usuario as
select * from usuario where inhabilitado = 0;

create view v_hotel as 
select * from hotel where inhabilitado = 0; ;

create view v_habitacion as 
select * from habitacion where inhabilitado = 0;

-- creacion de procedimientos almacenados
-- insercion de usuario
create procedure sp_insertarusuario( idusuario int, idtipodocumento int, numerodocumento varchar(100),
									idpais int, idrol int,nombre varchar(100) ,apellido varchar(100),
                                    correo varchar(100),contrasena varchar(100),celular varchar(100),
                                    genero boolean,token varchar(100),imagen varchar(200),
                                    fechanacimiento date,fecharegistro datetime, inhabilidado boolean )
insert into v_usuario values(idusuario,idtipodocumento,numerodocumento,idpais,
                             idrol,nombre,apellido,correo,contrasena, celular,
                             genero,token,imagen,fechanacimiento,fecharegistro,inhabilitado); 
-- actualizar el usuario
create procedure sp_actualizarusuario(idtipodocumento int,idpais int,nombre varchar(100),apellido varchar(100),
									correo varchar(100),celular varchar(100),genero boolean, 
                                    imagen varchar(100),fechanacimiento date,idusuario int)
update v_usuario as u set idtipodocumento = idtipodocumento, idpais = idpais,nombre = nombre,
				     apellido = apellido,correo = correo,celular = celular,genero = genero,
                     imagen = imagen ,fechanacimiento = fechanacimiento
			where u.idusuario = idusuario;
-- inhabilitar el usuario
create procedure sp_inhabilitarusuario (idusuario int)
		update v_usuario as u set inhabilitado = 1 where u.idusuario = idusuario;
        
-- insercion de hotel
create procedure sp_insertarhotel(idhotel int,idusuario int,idciudad int,estrella int,
								  nombre varchar(100),direccion varchar(100),telefono varchar(100),
								  celular varchar(100),correo varchar(100),sitioweb varchar(100),
								  descripcion mediumtext,fecharegistro datetime,inhabilitado boolean)
insert into v_hotel values(idhotel,idusuario,idciudad,estrella,nombre,direccion,
							telefono,celular,correo,sitioweb,descripcion,fecharegistro,inhabilitado);
-- actualizar hotel
create procedure sp_actualizarhotel(idciudad int,estrella int, nombre varchar(100),direccion varchar(100),
									telefono varchar(100), celular varchar(100),
                                    correo varchar(100),sitioweb varchar(100),descripcion mediumtext,idhotel int,idusuario int)
update v_hotel as h set h.idciudad = idciudad,h.estrella = estrella,h.nombre = nombre,h.direccion = direccion,
						h.telefono = telefono,h.celular = celular,h.correo = correo,h.sitioweb = sitioweb,h.descripcion =descripcion
		where h.idhotel = idhotel and h.idusuario = idusuario;
        
-- inhabilitar el hotel
create procedure sp_inhabilitarhotel (idhotel int,idusuario int)
		update v_hotel as h set inhabilitado = 1 where h.idhotel = idhotel and h.idusuario = idusuario;
        
-- insercion de habitacion
create procedure sp_insertarhabitacion(idhabitacion int,idtipohabitacion int,idhotel int,numerohabitacion varchar(50),
									   cantidadmaxpersonas int,cantidadminpersonas int,precionochepersona float,
                                       preciobase float,numeropiso varchar(50),descripcion mediumtext,disponibilidad boolean,
                                       fecharegistro datetime,inhabilitado boolean)
insert into v_habitacion values(idhabitacion,idtipohabitacion,idhotel,numerohabitacion,cantidadmaxpersonas,
								cantidadminpersonas,precionochepersona,preciobase,numeropiso,descripcion,
                                disponibilidad,fecharegistro,inhabilitado);

-- BBDD Demo
INSERT INTO rol VALUES (1,"Propietario"),(2,"Administrador"),(3,"Turista");

INSERT INTO servicio (idservicio, nombre, descripcion) values
                      (1, 'Parqueadero', 'Lugar para estacionar los vehiculos'),
                      (2, 'Restaurante', 'Capacidad de mesas y comidas que ofrece '),
                      (3, 'Piscina', 'Cantidad y medidas de la/s piscinas'),
                      (4, 'Piscina con tobogan', 'Especificacion de tobogan'),
                      (5, 'Area de juegos', 'Juegos y/o atracciones'),
                      (6, 'Zona verde', 'Cantidad de zona verde'),
                      (7, 'Limpieza a la habitacion', 'Servicio que prestan las empleadas domesticas'),
                      (8, 'Recibir comida', 'Llevar comida hasta la habitacion');
INSERT INTO tipodocumento VALUES (1,"Cédula de ciudadania"),(2,"Cédula de extranjeria");

INSERT INTO estadoreserva VALUES (1,"Consulta"),
							                	 (2,"Solicitud de reservacion"),
                                 (3,"Pendiente"),
                                 (4,"Confirmada"),
                                 (5,"Rechazada"),
                                 (6,"Caducada"),
                                 (7,"Cancelada"),
                                 (8,"Cerrada"),
                                 (9,"Finalizada");

INSERT INTO pais VALUES (1,"Colombia","Colombiano/a");

INSERT INTO `departamento` (`iddepartamento`, `idpais`, `nombre`) VALUES
                        (1, 1, 'Amazonas'),
                        (2, 1, 'Antioquia'),
                        (3, 1, 'Arauca'),
                        (4, 1, 'Atlántico'),
                        (5, 1, 'Bolívar'),
                        (6, 1, 'Boyacá'),
                        (7, 1, 'Caldas'),
                        (8, 1, 'Caquetá'),
                        (9, 1, 'Casanare'),
                        (10, 1, 'Cauca'),
                        (11, 1, 'Cesar'),
                        (12, 1, 'Chocó'),
                        (13, 1, 'Córdoba'),
                        (14, 1, 'Cundinamarca'),
                        (15, 1, 'Guainía'),
                        (16, 1, 'Guaviare'),
                        (17, 1, 'Huila'),
                        (18, 1, 'La Guajira'),
                        (19, 1, 'Magdalena'),
                        (20, 1, 'Meta'),
                        (21, 1, 'Nariño'),
                        (22, 1, 'Norte de Santander'),
                        (23, 1, 'Putumayo'),
                        (24, 1, 'Quindío'),
                        (25, 1, 'Risaralda'),
                        (26, 1, 'San Andrés y Providencia'),
                        (27, 1, 'Santander'),
                        (28, 1, 'Sucre'),
                        (29, 1, 'Tolima'),
                        (30, 1, 'Valle del Cauca'),
                        (31, 1, 'Vaupés'),
                        (32, 1, 'Vichada');

INSERT INTO `ciudad` (`idciudad`, `iddepartamento`, `nombre`) VALUES
                    (1, 1, 'Leticia'),
                    (2, 2, 'Medellin'),
                    (3, 3, 'Arauca'),
                    (4, 4, 'Barranquilla'),
                    (5, 5, 'Cartagena'),
                    (6, 6, 'Tunja'),
                    (7, 7, 'Manizales'),
                    (8, 8, 'Florencia'),
                    (9, 9, 'Yopal'),
                    (10, 10, 'Popayán'),
                    (11, 11, 'Valledupar'),
                    (12, 12, 'Quibdó'),
                    (13, 13, 'Montería'),
                    (14, 14, 'Bogotá D.C'),
                    (15, 15, 'Inírida'),
                    (16, 16, 'San Jose del Guaviare'),
                    (17, 17, 'Neiva'),
                    (18, 18, 'Riohacha'),
                    (19, 19, 'Santa Marta'),
                    (20, 20, 'Villavicencio'),
                    (21, 21, 'Pasto'),
                    (22, 22, 'Cúcuta'),
                    (23, 23, 'Mocoa'),
                    (24, 24, 'Armenia'),
                    (25, 25, 'Pereira'),
                    (26, 26, 'San Andrés'),
                    (27, 27, 'Bucaramanga'),
                    (28, 28, 'Sincelejo'),
                    (29, 29, 'Ibagué'),
                    (30, 30, 'Cali'),
                    (31, 31, 'Mitú'),
                    (32, 32, 'Puerto Carreño'),
                    (33, 20, 'Acacias'),
                    (34, 20, 'Guamal'),
                    (35, 20, 'Granada'),
                    (36, 20, 'San Martín');

INSERT INTO tipohabitacion VALUES 	(1,"Individual Sencilla","Una habitación asignada a una persona. Solo tiene una cama."),
								                  	(2,"Individual","Una habitación asignada a una persona. Puede tener una o más camas."),
							                  		(3,"Doble"," Una habitación asignada a dos personas. Puede tener una o más camas."),
                                    (4,"Triple","Una habitación asignada a tres personas. Puede tener dos o más camas."),
                                    (5,"Quad","Una sala asignada a cuatro personas. Puede tener dos o más camas."),
                                    (6,"Queen","Una habitación con una cama de matrimonio. Puede ser ocupado por una o más personas."),
                                    (7,"King","Una habitación con una cama king-size. Puede ser ocupado por una o más personas"),
                                    (8,"Estudio","una habitación con una cama de estudio, un sofá que se puede convertir en una cama. También puede tener una cama adicional.");

INSERT INTO `usuario` (`idusuario`, `idtipodocumento`, `numerodocumento`, `idpais`, `idrol`, `nombre`, `apellido`, `correo`, `contrasena`, `celular`, `genero`, `token`, `imagen`, `fechanacimiento`, `fecharegistro`, `inhabilitado`) VALUES
                      (1, 1, '1004567241', 1, 3, 'David Andres', 'Castro Gomez', 'Davida13@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3504942333', 1, NULL, NULL, '2002-03-24', '2020-08-06 04:22:12', 0),
                      (2, 1, '1004567458', 1, 2, 'Maria Fernanda', 'Gonzales Versalles', 'MariaF23@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3404567890', 0, NULL, NULL, '1996-01-01', '2020-08-06 04:16:43', 0),
                      (3, 1, '1004569145', 1, 1, 'Karol Andrea', 'Castillo Versalles', 'Karola13@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3456789090', 0, NULL, NULL, '1995-02-01', '2020-08-06 04:19:02', 0),
                      (4, 2, '1002567241', 1, 2, 'Juan David', 'Gomez Neira', 'Juanda13@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3403453434', 1, NULL, NULL, '1995-01-03', '2020-08-06 04:22:32', 0),
                      (5, 1, '10056781213', 1, 3, 'Karol Mariana', 'Torres Quijano', 'Karolm13@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3214563434', 0, NULL, NULL, '2000-03-24', '2020-08-06 04:24:15', 0),
                      (6, 1, '1003568251', 1, 1, 'Julian David', 'Paz Castellanos', 'Juliand@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3445678989', 1, NULL, NULL, '1998-05-09', '2020-08-06 04:28:53', 0);

insert into hotel (idhotel, idusuario, idciudad, estrella, nombre, direccion, telefono, celular, correo, sitioweb, descripcion, fecharegistro, inhabilitado) values
                  (1, 1, 14, 4, 'Hotel las delicias', 'Calle 24A #44A 65', '2034556', '3214567890',"mihotel@gmail.com", 'www.hotellasdelicias.com', 'Este hotel está muy bien situado en el distrito Teusaquillo de Bogotá, a 1 km del centro internacional de exposiciones Corferias y a 6 km de la plaza Bolívar. También cuenta con salón compartido, centro de negocios y WiFi gratuita en todas las instalaciones. El alojamiento ofrece recepción 24 horas, servicio de habitaciones y cambio de divisa.', '2019-09-10 02:38:55', 0),
                  (2, 2, 30, 3, 'Hotel del valle', 'Avenida 5 Norte 29 AN 48', '3065487', '3209807654',"mihotel@gmail.com", 'www.hoteldelvalle.com', 'a 3,7 km de la catedral de San Pedro, y ofrece alojamiento con restaurante, aparcamiento privado gratuito, bar y salón compartido. Ofrece habitaciones familiares y terraza. El alojamiento ofrece recepción 24 horas, servicio de traslado, mostrador de información turística y conexión WiFi gratuita en todo el establecimiento.', '2019-09-10 02:38:55', 0),
                  (3, 3, 20, 5, 'Hotel del cauca', 'Km 18 Vía Bolombolo', '7035506', '3124667920',"mihotel@gmail.com", 'www.hotelcauca.com', 'se encuentra en Jericó, a 30 minutos en coche del centro de la localidad, y cuenta con un jardín, una piscina cubierta, un restaurante y conexión Wi-Fi gratuita. Además, sirve un desayuno bufé.', '2019-09-10 02:38:55', 0),
                  (4, 4, 5, 4, 'Hotel de santamarta', 'Calle 115 # 2 - 39.', '9057812', '3116006130',"mihotel@gmail.com", 'www.hotelsantamarta.com', ' situado en Santa Marta, ofrece WiFi gratis y piscina al aire libre. Además, el establecimiento alberga terraza, centro de fitness y un bar. Hay aparcamiento privado.', '2019-09-10 02:38:55', 0);


insert into habitacion VALUES (1, 1, 2, '203', '2', '1', 100000, 100000, '2', 'habitacón basica individual', '1', '2020-08-11 16:00:15', 0),
                              (2, 2, 3, '205', '2', '1', 100000, 100000, '2', 'habitacón basica individual', '1', '2020-08-11 16:00:15', 0),
                              (3, 2, 1, '102', '6', '3', 80000, 250000, '1', 'habitacón triple con posibilidad de servicios', '1', '2020-08-11 19:01:15', 0),
                              (4, 3, 2, '505', '6', '3', 90000, 250000, '5', 'habitacón triple con posibilidad de servicios', '1', '2020-08-11 19:02:20', 0),
                              (5, 4, 4, '305', '8', '4', 100000, 300000, '3', 'habitacón quad con servicio a la habitación', '1', '2020-08-11 20:15:56', 0);

insert into puntuacion (idpuntuacion, idhabitacion, idusuario, puntuacion, fecharegistro) values
                      (1, 2, 3, 4, '2020-08-11 16:15:47'),
                      (2, 5, 4, 3, '2020-07-18 13:35:47'),
                      (3, 3, 1, 5, '2020-04-23 16:57:47'),
                      (4, 1, 2, 5, '2020-02-04 08:05:47'),
                      (5, 1, 4, 3, '2020-08-14 14:07:47');

insert into imagen (idimagen, idhabitacion, titulo, url, fecharegistro) values
                    (1, 2, 'Baño', 'https://www.hoteldos.com.co/img_b', '2020-08-11 16:15:47'),
                    (2, 5, 'Camas', 'https://www.hotelcinco.com.co/img_c', '2020-07-18 13:35:47'),
                    (3, 3, 'Baño', 'https://www.hoteltres.com.co/img_b', '2020-04-23 16:57:47'),
                    (4, 1, 'Vista-Ventana', 'https://www.hoteluno.com.co/img_v', '2020-02-04 08:05:47'),
                    (7, 1, 'Armario', 'https://www.hotelmax.com.co/img_a', '2020-08-14 14:07:47');

insert into comentario (idcomentario, idhabitacion, idusuario, comentario, fecharegistro) values
                   (1, 5, 1, 'Exclente servicio a la habitación', '2020-08-11 16:15:47'),
                   (2, 2, 3, 'Camas muy comodas', '2020-07-18 13:35:47'),
                   (3, 1, 5, 'Buen precio por buena calidad', '2020-04-23 16:57:47'),
                   (4, 3, 5, 'Ducha sin agua caliente', '2020-02-04 08:05:47'),
                   (7, 4, 1, 'Falta aire acondicionado', '2020-08-14 14:07:47');

INSERT INTO `favorito` (`idfavorito`, `idusuario`, `idhabitacion`, `fecharegistro`) VALUES
                              (1, 1, 1, '2020-08-06 04:30:16'),
                              (2, 2, 2, '2020-08-06 04:30:45'),
                              (3, 3, 3, '2020-08-06 04:31:00'),
                              (4, 4, 4, '2020-08-06 04:32:30'),
                              (5, 5, 5, '2020-08-06 04:32:27');

insert into habitacionservicio (idhabitacionservicio, idhabitacion, idservicio, precio) values
                              (1, 1, 1, 80000),
                              (2, 2, 2, 100000),
                              (3, 3, 3, 120000),
                              (4, 4, 4, 150000);

 INSERT INTO `reserva` (`idreserva`, `idusuario`, `idestadoreserva`, `preciototal`, `descripcion`, `fechaentrada`, `fechasalida`, `fechareserva`, `inhabilitado`) VALUES (NULL, '1', '2', '20000000', NULL, '2020-08-05 12:11:49', '2020-08-14 02:15:49', '2020-08-12 02:33:49', '0'),
                              (NULL, '2', '3', '8000000', NULL, '2020-10-14 13:33:49', '2020-08-12 14:33:49', '2020-08-04 02:33:49', '0'),
                              (NULL, '4', '1', '100000', NULL, '2020-10-14 02:33:49', '2020-10-31 02:33:49', '2020-08-05 02:33:49', '0'),
                              (NULL, '5', '1', '700000', NULL, '2020-09-17 02:33:49', '2020-09-19 02:33:49', '2020-06-09 02:33:49', '0'),
                              (NULL, '6', '1', '700000', NULL, '2020-02-04 02:33:49', '2020-03-11 02:33:49', '2019-06-19 02:33:49', '0');
 
 INSERT INTO `reservahabitacion` (`idreservahabitacion`, `idhabitacion`, `idreserva`, `precio`, `descuento`, `fecharegistro`) VALUES 
                              (NULL, '2', '3', '900000', '0', '2019-09-10 02:38:55'),
                              (NULL, '2', '5', '1100000', '0', '2020-02-21 02:38:55'), 
                              (NULL, '4', '3', '5000000', '100000', '2019-02-05 02:38:55'), 
                              (NULL, '3', '5', '300000', '20000', '2020-06-17 02:38:55'),
                              (NULL, '4', '2', '8000000', '10000', '2018-05-15 02:38:55');