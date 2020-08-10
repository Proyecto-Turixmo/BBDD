-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-08-2020 a las 23:33:11
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_turixmo`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarhotel` (`idciudad` INT, `estrella` INT, `nombre` VARCHAR(100), `direccion` VARCHAR(100), `telefono` VARCHAR(100), `celular` VARCHAR(100), `correo` VARCHAR(100), `sitioweb` VARCHAR(100), `descripcion` MEDIUMTEXT, `idhotel` INT, `idusuario` INT)  update v_hotel as h set h.idciudad = idciudad,h.estrella = estrella,h.nombre = nombre,h.direccion = direccion,
						h.telefono = telefono,h.celular = celular,h.correo = correo,h.sitioweb = sitioweb,h.descripcion =descripcion
		where h.idhotel = idhotel and h.idusuario = idusuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarusuario` (`idtipodocumento` INT, `idpais` INT, `nombre` VARCHAR(100), `apellido` VARCHAR(100), `correo` VARCHAR(100), `celular` VARCHAR(100), `genero` BOOLEAN, `imagen` VARCHAR(100), `fechanacimiento` DATE, `idusuario` INT)  update v_usuario as u set idtipodocumento = idtipodocumento, idpais = idpais,nombre = nombre,
				     apellido = apellido,correo = correo,celular = celular,genero = genero,
                     imagen = imagen ,fechanacimiento = fechanacimiento
			where u.idusuario = idusuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inhabilitarhotel` (`idhotel` INT, `idusuario` INT)  update v_hotel as h set inhabilitado = 1 where h.idhotel = idhotel and h.idusuario = idusuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inhabilitarusuario` (`idusuario` INT)  update v_usuario as u set inhabilitado = 1 where u.idusuario = idusuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarhabitacion` (`idhabitacion` INT, `idtipohabitacion` INT, `idhotel` INT, `numerohabitacion` VARCHAR(50), `cantidadmaxpersonas` INT, `cantidadminpersonas` INT, `precionochepersona` FLOAT, `preciobase` FLOAT, `numeropiso` VARCHAR(50), `descripcion` MEDIUMTEXT, `disponibilidad` BOOLEAN, `fecharegistro` DATETIME, `inhabilitado` BOOLEAN)  insert into v_habitacion values(idhabitacion,idtipohabitacion,idhotel,numerohabitacion,cantidadmaxpersonas,
								cantidadminpersonas,precionochepersona,preciobase,numeropiso,descripcion,
                                disponibilidad,fecharegistro,inhabilitado)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarhotel` (`idhotel` INT, `idusuario` INT, `idciudad` INT, `estrella` INT, `nombre` VARCHAR(100), `direccion` VARCHAR(100), `telefono` VARCHAR(100), `celular` VARCHAR(100), `correo` VARCHAR(100), `sitioweb` VARCHAR(100), `descripcion` MEDIUMTEXT, `fecharegistro` DATETIME, `inhabilitado` BOOLEAN)  insert into v_hotel values(idhotel,idusuario,idciudad,estrella,nombre,direccion,
							telefono,celular,correo,sitioweb,descripcion,fecharegistro,inhabilitado)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarusuario` (`idusuario` INT, `idtipodocumento` INT, `numerodocumento` VARCHAR(100), `idpais` INT, `idrol` INT, `nombre` VARCHAR(100), `apellido` VARCHAR(100), `correo` VARCHAR(100), `contrasena` VARCHAR(100), `celular` VARCHAR(100), `genero` BOOLEAN, `token` VARCHAR(100), `imagen` VARCHAR(200), `fechanacimiento` DATE, `fecharegistro` DATETIME, `inhabilidado` BOOLEAN)  insert into v_usuario values(idusuario,idtipodocumento,numerodocumento,idpais,
                             idrol,nombre,apellido,correo,contrasena, celular,
                             genero,token,imagen,fechanacimiento,fecharegistro,inhabilitado)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `idciudad` int(11) NOT NULL,
  `iddepartamento` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ciudad`
--

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `idcomentario` int(11) NOT NULL,
  `idhabitacion` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `comentario` mediumtext NOT NULL,
  `fecharegistro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `iddepartamento` int(11) NOT NULL,
  `idpais` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `departamento`
--

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoreserva`
--

CREATE TABLE `estadoreserva` (
  `idestadoreserva` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estadoreserva`
--

INSERT INTO `estadoreserva` (`idestadoreserva`, `nombre`, `descripcion`) VALUES
(1, 'En procéso', NULL),
(2, 'Finalizada', NULL),
(3, 'Cancelada', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favorito`
--

CREATE TABLE `favorito` (
  `idfavorito` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idhabitacion` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `favorito`
--

INSERT INTO `favorito` (`idfavorito`, `idusuario`, `idhabitacion`, `fecharegistro`) VALUES
(1, 1, 1, '2020-08-06 04:30:16'),
(2, 2, 2, '2020-08-06 04:30:45'),
(3, 3, 3, '2020-08-06 04:31:00'),
(4, 4, 4, '2020-08-06 04:32:30'),
(5, 5, 5, '2020-08-06 04:32:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitacion`
--

CREATE TABLE `habitacion` (
  `idhabitacion` int(11) NOT NULL,
  `idtipohabitacion` int(11) NOT NULL,
  `idhotel` int(11) NOT NULL,
  `numerohabitacion` varchar(50) DEFAULT NULL,
  `cantidadmaxpersonas` int(11) NOT NULL,
  `cantidadminpersonas` int(11) NOT NULL,
  `precionochepersona` float NOT NULL,
  `preciobase` float NOT NULL,
  `numeropiso` varchar(50) DEFAULT NULL,
  `descripcion` mediumtext,
  `disponibilidad` tinyint(1) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  `inhabilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitacionservicio`
--

CREATE TABLE `habitacionservicio` (
  `idhabitacionservicio` int(11) NOT NULL,
  `idhabitacion` int(11) NOT NULL,
  `idservicio` int(11) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- inserciones Cristian Mesa
insert into 'habitacionservicio' ('idhabitacionservicio', 'idhabitacion', 'idservicio', 'precio') values
(1, 1, 1, 80.000),
(2, 2, 2, 100.000),
(3, 3, 3, 120.000),
(4, 4, 4, 150.000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hotel`
--

CREATE TABLE `hotel` (
  `idhotel` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idciudad` int(11) DEFAULT NULL,
  `estrella` int(11) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `celular` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `sitioweb` varchar(100) DEFAULT NULL,
  `descripcion` mediumtext,
  `fecharegistro` datetime NOT NULL,
  `inhabilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Inserciones Cristian Mesa
insert into hotel ('idhotel', 'idusuario', 'idciudad', 'estrella', 'nombre', 'direccion', 'telefono', 'celular', 'correo', 'sitioweb', 'descripcion', 'fecharegistro', 'inhabilitado') values
(1, 1, 14, 4, 'Hotel las delicias', 'Calle 24A #44A 65', '2034556', '3214567890', 'www.hotellasdelicias.com', 'Este hotel está muy bien situado en el distrito Teusaquillo de Bogotá, a 1 km del centro internacional de exposiciones Corferias y a 6 km de la plaza Bolívar. También cuenta con salón compartido, centro de negocios y WiFi gratuita en todas las instalaciones. El alojamiento ofrece recepción 24 horas, servicio de habitaciones y cambio de divisa.', '22/08/2015', ''),
(2, 2, 30, 3, 'Hotel del valle', 'Avenida 5 Norte 29 AN 48', '3065487', '3209807654', 'www.hoteldelvalle.com', 'a 3,7 km de la catedral de San Pedro, y ofrece alojamiento con restaurante, aparcamiento privado gratuito, bar y salón compartido. Ofrece habitaciones familiares y terraza. El alojamiento ofrece recepción 24 horas, servicio de traslado, mostrador de información turística y conexión WiFi gratuita en todo el establecimiento.', '10/09/2002', ''),
(3, 3, 20, 5, 'Hotel del cauca', 'Km 18 Vía Bolombolo', '7035506', '3124667920', 'www.hotelcauca.com', 'se encuentra en Jericó, a 30 minutos en coche del centro de la localidad, y cuenta con un jardín, una piscina cubierta, un restaurante y conexión Wi-Fi gratuita. Además, sirve un desayuno bufé.', '30/02/2010', ''),
(5, 4, 5, 4, 'Hotel de santamarta', 'Calle 115 # 2 - 39.', '9057812', '3116006130', 'www.hotelsantamarta.com', ' situado en Santa Marta, ofrece WiFi gratis y piscina al aire libre. Además, el establecimiento alberga terraza, centro de fitness y un bar. Hay aparcamiento privado.', '17/05/2008', ''),


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen`
--

CREATE TABLE `imagen` (
  `idimagen` int(11) NOT NULL,
  `idhabitacion` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `fecharegistro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `idpais` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `nacionalidad` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`idpais`, `nombre`, `nacionalidad`) VALUES
(1, 'Colombia', 'Colombiano/a');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntuacion`
--

CREATE TABLE `puntuacion` (
  `idpuntuacion` int(11) NOT NULL,
  `idhabitacion` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `puntuacion` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `idreserva` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idestadoreserva` int(11) NOT NULL,
  `preciototal` float NOT NULL,
  `descripcion` text,
  `fechaentrada` datetime NOT NULL,
  `fechasalida` datetime NOT NULL,
  `fechareserva` datetime NOT NULL,
  `inhabilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservahabitacion`
--

CREATE TABLE `reservahabitacion` (
  `idreservahabitacion` int(11) NOT NULL,
  `idhabitacion` int(11) NOT NULL,
  `idreserva` int(11) NOT NULL,
  `precio` float NOT NULL,
  `descuento` float NOT NULL,
  `fecharegistro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idrol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `nombre`) VALUES
(1, 'Propietario'),
(2, 'Administrador'),
(3, 'Turista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `idservicio` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- inseciones Cristian Mesa
insert into 'servicio' ('idservivio', 'nombre', 'descripcion') values
(1, 'Parqueadero', 'Lugar para estacionar los vehiculos'),
(2, 'Restaurante', 'Capacidad de mesas y comidas que ofrece '),
(3, 'Piscina', 'Cantidad y medidas de la/s piscinas'),
(4, 'Piscina con tobogan', 'Especificacion de tobogan'),
(5, 'Area de juegos', 'Juegos y/o atracciones')
(6, 'Zona verde', 'Cantidad de zona verde'),
(7, 'Limpieza a la habitacion', 'Servicio que prestan las empleadas domesticas'),
(8, 'Recibir comida', 'Llevar comida hasta la habitacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `idtipodocumento` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipodocumento`
--

INSERT INTO `tipodocumento` (`idtipodocumento`, `nombre`) VALUES
(1, 'Cédula de ciudadania'),
(2, 'Cédula de extranjeria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipohabitacion`
--

CREATE TABLE `tipohabitacion` (
  `idtipohabitacion` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipohabitacion`
--

INSERT INTO `tipohabitacion` (`idtipohabitacion`, `nombre`, `descripcion`) VALUES
(1, 'Individual Sencilla', 'Una habitación asignada a una persona. Solo tiene una cama.'),
(2, 'Individual', 'Una habitación asignada a una persona. Puede tener una o más camas.'),
(3, 'Doble', ' Una habitación asignada a dos personas. Puede tener una o más camas.'),
(4, 'Triple', 'Una habitación asignada a tres personas. Puede tener dos o más camas.'),
(5, 'Quad', 'Una sala asignada a cuatro personas. Puede tener dos o más camas.'),
(6, 'Queen', 'Una habitación con una cama de matrimonio. Puede ser ocupado por una o más personas.'),
(7, 'King', 'Una habitación con una cama king-size. Puede ser ocupado por una o más personas'),
(8, 'Estudio', 'una habitación con una cama de estudio, un sofá que se puede convertir en una cama. También puede tener una cama adicional.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `idtipodocumento` int(11) NOT NULL,
  `numerodocumento` varchar(100) NOT NULL,
  `idpais` int(11) NOT NULL,
  `idrol` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `celular` varchar(100) NOT NULL,
  `genero` tinyint(1) DEFAULT NULL,
  `token` varchar(100) DEFAULT NULL,
  `imagen` varchar(200) DEFAULT NULL,
  `fechanacimiento` date DEFAULT NULL,
  `fecharegistro` datetime NOT NULL,
  `inhabilitado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `idtipodocumento`, `numerodocumento`, `idpais`, `idrol`, `nombre`, `apellido`, `correo`, `contrasena`, `celular`, `genero`, `token`, `imagen`, `fechanacimiento`, `fecharegistro`, `inhabilitado`) VALUES
(1, 1, '1004567241', 1, 3, 'David Andres', 'Castro Gomez', 'Davida13@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3504942333', 1, NULL, NULL, '2002-03-24', '2020-08-06 04:22:12', 0),
(2, 1, '1004567458', 1, 2, 'Maria Fernanda', 'Gonzales Versalles', 'MariaF23@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3404567890', 0, NULL, NULL, '1996-01-01', '2020-08-06 04:16:43', 0),
(3, 1, '1004569145', 1, 1, 'Karol Andrea', 'Castillo Versalles', 'Karola13@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3456789090', 0, NULL, NULL, '1995-02-01', '2020-08-06 04:19:02', 0),
(4, 2, '1002567241', 1, 2, 'Juan David', 'Gomez Neira', 'Juanda13@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3403453434', 1, NULL, NULL, '1995-01-03', '2020-08-06 04:22:32', 0),
(5, 1, '10056781213', 1, 3, 'Karol Mariana', 'Torres Quijano', 'Karolm13@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3214563434', 0, NULL, NULL, '2000-03-24', '2020-08-06 04:24:15', 0),
(6, 1, '1003568251', 1, 1, 'Julian David', 'Paz Castellanos', 'Juliand@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '3445678989', 1, NULL, NULL, '1998-05-09', '2020-08-06 04:28:53', 0);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_habitacion`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_habitacion` (
`idhabitacion` int(11)
,`idtipohabitacion` int(11)
,`idhotel` int(11)
,`numerohabitacion` varchar(50)
,`cantidadmaxpersonas` int(11)
,`cantidadminpersonas` int(11)
,`precionochepersona` float
,`preciobase` float
,`numeropiso` varchar(50)
,`descripcion` mediumtext
,`disponibilidad` tinyint(1)
,`fecharegistro` datetime
,`inhabilitado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_hotel`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_hotel` (
`idhotel` int(11)
,`idusuario` int(11)
,`idciudad` int(11)
,`estrella` int(11)
,`nombre` varchar(100)
,`direccion` varchar(100)
,`telefono` varchar(100)
,`celular` varchar(100)
,`correo` varchar(100)
,`sitioweb` varchar(100)
,`descripcion` mediumtext
,`fecharegistro` datetime
,`inhabilitado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_usuario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_usuario` (
`idusuario` int(11)
,`idtipodocumento` int(11)
,`numerodocumento` varchar(100)
,`idpais` int(11)
,`idrol` int(11)
,`nombre` varchar(100)
,`apellido` varchar(100)
,`correo` varchar(100)
,`contrasena` varchar(100)
,`celular` varchar(100)
,`genero` tinyint(1)
,`token` varchar(100)
,`imagen` varchar(200)
,`fechanacimiento` date
,`fecharegistro` datetime
,`inhabilitado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `v_habitacion`
--
DROP TABLE IF EXISTS `v_habitacion`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_habitacion`  AS  select `habitacion`.`idhabitacion` AS `idhabitacion`,`habitacion`.`idtipohabitacion` AS `idtipohabitacion`,`habitacion`.`idhotel` AS `idhotel`,`habitacion`.`numerohabitacion` AS `numerohabitacion`,`habitacion`.`cantidadmaxpersonas` AS `cantidadmaxpersonas`,`habitacion`.`cantidadminpersonas` AS `cantidadminpersonas`,`habitacion`.`precionochepersona` AS `precionochepersona`,`habitacion`.`preciobase` AS `preciobase`,`habitacion`.`numeropiso` AS `numeropiso`,`habitacion`.`descripcion` AS `descripcion`,`habitacion`.`disponibilidad` AS `disponibilidad`,`habitacion`.`fecharegistro` AS `fecharegistro`,`habitacion`.`inhabilitado` AS `inhabilitado` from `habitacion` where (`habitacion`.`inhabilitado` = 0) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_hotel`
--
DROP TABLE IF EXISTS `v_hotel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_hotel`  AS  select `hotel`.`idhotel` AS `idhotel`,`hotel`.`idusuario` AS `idusuario`,`hotel`.`idciudad` AS `idciudad`,`hotel`.`estrella` AS `estrella`,`hotel`.`nombre` AS `nombre`,`hotel`.`direccion` AS `direccion`,`hotel`.`telefono` AS `telefono`,`hotel`.`celular` AS `celular`,`hotel`.`correo` AS `correo`,`hotel`.`sitioweb` AS `sitioweb`,`hotel`.`descripcion` AS `descripcion`,`hotel`.`fecharegistro` AS `fecharegistro`,`hotel`.`inhabilitado` AS `inhabilitado` from `hotel` where (`hotel`.`inhabilitado` = 0) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_usuario`
--
DROP TABLE IF EXISTS `v_usuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usuario`  AS  select `usuario`.`idusuario` AS `idusuario`,`usuario`.`idtipodocumento` AS `idtipodocumento`,`usuario`.`numerodocumento` AS `numerodocumento`,`usuario`.`idpais` AS `idpais`,`usuario`.`idrol` AS `idrol`,`usuario`.`nombre` AS `nombre`,`usuario`.`apellido` AS `apellido`,`usuario`.`correo` AS `correo`,`usuario`.`contrasena` AS `contrasena`,`usuario`.`celular` AS `celular`,`usuario`.`genero` AS `genero`,`usuario`.`token` AS `token`,`usuario`.`imagen` AS `imagen`,`usuario`.`fechanacimiento` AS `fechanacimiento`,`usuario`.`fecharegistro` AS `fecharegistro`,`usuario`.`inhabilitado` AS `inhabilitado` from `usuario` where (`usuario`.`inhabilitado` = 0) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`idciudad`),
  ADD KEY `iddepartamento` (`iddepartamento`);

--
-- Indices de la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD PRIMARY KEY (`idcomentario`),
  ADD KEY `idhabitacion` (`idhabitacion`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`iddepartamento`),
  ADD KEY `idpais` (`idpais`);

--
-- Indices de la tabla `estadoreserva`
--
ALTER TABLE `estadoreserva`
  ADD PRIMARY KEY (`idestadoreserva`);

--
-- Indices de la tabla `favorito`
--
ALTER TABLE `favorito`
  ADD PRIMARY KEY (`idfavorito`),
  ADD KEY `idusuario` (`idusuario`);

--
-- Indices de la tabla `habitacion`
--
ALTER TABLE `habitacion`
  ADD PRIMARY KEY (`idhabitacion`),
  ADD KEY `idtipohabitacion` (`idtipohabitacion`),
  ADD KEY `idhotel` (`idhotel`);

--
-- Indices de la tabla `habitacionservicio`
--
ALTER TABLE `habitacionservicio`
  ADD PRIMARY KEY (`idhabitacionservicio`),
  ADD KEY `idhabitacion` (`idhabitacion`),
  ADD KEY `idservicio` (`idservicio`);

--
-- Indices de la tabla `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`idhotel`),
  ADD KEY `idusuario` (`idusuario`),
  ADD KEY `idciudad` (`idciudad`);

--
-- Indices de la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD PRIMARY KEY (`idimagen`),
  ADD KEY `idhabitacion` (`idhabitacion`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`idpais`);

--
-- Indices de la tabla `puntuacion`
--
ALTER TABLE `puntuacion`
  ADD PRIMARY KEY (`idpuntuacion`),
  ADD KEY `idhabitacion` (`idhabitacion`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`idreserva`),
  ADD KEY `idusuario` (`idusuario`),
  ADD KEY `idestadoreserva` (`idestadoreserva`);

--
-- Indices de la tabla `reservahabitacion`
--
ALTER TABLE `reservahabitacion`
  ADD PRIMARY KEY (`idreservahabitacion`),
  ADD KEY `idhabitacion` (`idhabitacion`),
  ADD KEY `idreserva` (`idreserva`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`idservicio`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`idtipodocumento`);

--
-- Indices de la tabla `tipohabitacion`
--
ALTER TABLE `tipohabitacion`
  ADD PRIMARY KEY (`idtipohabitacion`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `numerodocumento` (`numerodocumento`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `celular` (`celular`),
  ADD KEY `idtipodocumento` (`idtipodocumento`),
  ADD KEY `idrol` (`idrol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `idciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
  MODIFY `idcomentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `iddepartamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `estadoreserva`
--
ALTER TABLE `estadoreserva`
  MODIFY `idestadoreserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `favorito`
--
ALTER TABLE `favorito`
  MODIFY `idfavorito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `habitacion`
--
ALTER TABLE `habitacion`
  MODIFY `idhabitacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `habitacionservicio`
--
ALTER TABLE `habitacionservicio`
  MODIFY `idhabitacionservicio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `hotel`
--
ALTER TABLE `hotel`
  MODIFY `idhotel` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `imagen`
--
ALTER TABLE `imagen`
  MODIFY `idimagen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pais`
--
ALTER TABLE `pais`
  MODIFY `idpais` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `puntuacion`
--
ALTER TABLE `puntuacion`
  MODIFY `idpuntuacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `idreserva` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservahabitacion`
--
ALTER TABLE `reservahabitacion`
  MODIFY `idreservahabitacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idrol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `idservicio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `idtipodocumento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipohabitacion`
--
ALTER TABLE `tipohabitacion`
  MODIFY `idtipohabitacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD CONSTRAINT `ciudad_ibfk_1` FOREIGN KEY (`iddepartamento`) REFERENCES `departamento` (`iddepartamento`);

--
-- Filtros para la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD CONSTRAINT `comentario_ibfk_1` FOREIGN KEY (`idhabitacion`) REFERENCES `habitacion` (`idhabitacion`);

--
-- Filtros para la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD CONSTRAINT `departamento_ibfk_1` FOREIGN KEY (`idpais`) REFERENCES `pais` (`idpais`);

--
-- Filtros para la tabla `favorito`
--
ALTER TABLE `favorito`
  ADD CONSTRAINT `favorito_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `habitacion`
--
ALTER TABLE `habitacion`
  ADD CONSTRAINT `habitacion_ibfk_1` FOREIGN KEY (`idtipohabitacion`) REFERENCES `tipohabitacion` (`idtipohabitacion`),
  ADD CONSTRAINT `habitacion_ibfk_2` FOREIGN KEY (`idhotel`) REFERENCES `hotel` (`idhotel`);

--
-- Filtros para la tabla `habitacionservicio`
--
ALTER TABLE `habitacionservicio`
  ADD CONSTRAINT `habitacionservicio_ibfk_1` FOREIGN KEY (`idhabitacion`) REFERENCES `habitacion` (`idhabitacion`),
  ADD CONSTRAINT `habitacionservicio_ibfk_2` FOREIGN KEY (`idservicio`) REFERENCES `servicio` (`idservicio`);

--
-- Filtros para la tabla `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`),
  ADD CONSTRAINT `hotel_ibfk_2` FOREIGN KEY (`idciudad`) REFERENCES `ciudad` (`idciudad`);

--
-- Filtros para la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD CONSTRAINT `imagen_ibfk_1` FOREIGN KEY (`idhabitacion`) REFERENCES `habitacion` (`idhabitacion`);

--
-- Filtros para la tabla `puntuacion`
--
ALTER TABLE `puntuacion`
  ADD CONSTRAINT `puntuacion_ibfk_1` FOREIGN KEY (`idhabitacion`) REFERENCES `habitacion` (`idhabitacion`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`),
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`idestadoreserva`) REFERENCES `estadoreserva` (`idestadoreserva`);

--
-- Filtros para la tabla `reservahabitacion`
--
ALTER TABLE `reservahabitacion`
  ADD CONSTRAINT `reservahabitacion_ibfk_1` FOREIGN KEY (`idhabitacion`) REFERENCES `habitacion` (`idhabitacion`),
  ADD CONSTRAINT `reservahabitacion_ibfk_2` FOREIGN KEY (`idreserva`) REFERENCES `reserva` (`idreserva`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idtipodocumento`) REFERENCES `tipodocumento` (`idtipodocumento`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;