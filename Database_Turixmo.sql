
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

-- insercion de datos basicos
-- roles o actores del sistema
INSERT INTO rol VALUES (1,"Propietario"),(2,"Administrador"),(3,"Turista");

INSERT INTO tipodocumento VALUES (1,"Cédula de ciudadania"),(2,"Cédula de extranjeria");

INSERT INTO estadoreserva VALUES (1,"En procéso",null),(2,"Finalizada",null),(3,"Cancelada",null);

INSERT INTO pais VALUES (1,"Colombia","Colombiano/a");

INSERT INTO departamento VALUES(1,1,"Amazonas"),(2,1,"Antioquia"),(3,1,"Arauca"),(4,1,"Atlántico"),
								(5,1,"Bolívar"),(6,1,"Boyacá"),(7,1,"Caldas"),(8,1,"Caquetá"),
                                (9,1,"Casanare"),(10,1,"Cauca"),(11,1,"Cesar"),(12,1,"Chocó"),
                                (13,1,"Córdoba"),(14,1,"Cundinamarca"),(15,1,"Guainía"),(16,1,"Guaviare"),
                                (17,1,"Huila"),(18,1,"La Guajira"),(19,1,"Magdalena"),(20,1,"Meta"),
                                (21,1,"Nariño"),(22,1,"Norte de Santander"),(23,1,"Putumayo"),(24,1,"Quindío"),
                                (25,1,"Risaralda"),(26,1,"San Andrés y Providencia"),(27,1,"Santander"),(28,1,"Sucre"),
							    (29,1,"Tolima"),(30,1,"Valle del Cauca"),(31,1,"Vaupés"),(32,1,"Vichada");
                                
INSERT INTO ciudad VALUES (1,1,"Leticia"),(2,2,"Medellin"),(3,3,"Arauca"),(4,4,"Barranquilla"),
							(5,5,"Cartagena"),(6,6,"Tunja"),(7,7,"Manizales"),(8,8,"Florencia"),
							(9,9,"Yopal"),(10,10,"Popayán"),(11,11,"Valledupar"),(12,12,"Quibdó"),
							(13,13,"Montería"),(14,14,"Bogotá D.C"),(15,15,"Inírida"),(16,16,"San Jose del Guaviare"),
							(17,17,"Neiva"),(18,18,"Riohacha"),(19,19,"Santa Marta"),(20,20,"Villavicencio"),
							(33,20,"Acacias"),(34,20,"Guamal"),(35,20,"Granada"),(36,20,"San Martín"),
							(21,21,"Pasto"),(22,22,"Cúcuta"),(23,23,"Mocoa"),(24,24,"Armenia"),
							(25,25,"Pereira"),(26,26,"San Andrés"),(27,27,"Bucaramanga"),(28,28,"Sincelejo"),
							(29,29,"Ibagué"),(30,30,"Cali"),(31,31,"Mitú"),(32,32,"Puerto Carreño");

INSERT INTO tipohabitacion VALUES 	(1,"Individual Sencilla","Una habitación asignada a una persona. Solo tiene una cama."),
									(2,"Individual","Una habitación asignada a una persona. Puede tener una o más camas."),
									(3,"Doble"," Una habitación asignada a dos personas. Puede tener una o más camas."),
                                    (4,"Triple","Una habitación asignada a tres personas. Puede tener dos o más camas."),
                                    (5,"Quad","Una sala asignada a cuatro personas. Puede tener dos o más camas."),
                                    (6,"Queen","Una habitación con una cama de matrimonio. Puede ser ocupado por una o más personas."),
                                    (7,"King","Una habitación con una cama king-size. Puede ser ocupado por una o más personas"),
                                    (8,"Estudio","una habitación con una cama de estudio, un sofá que se puede convertir en una cama. También puede tener una cama adicional.");

INSERT INTO estadoreserva VALUES (1,"Consulta",""),
								 (2,"Solicitud de reservacion",""),
                                 (3,"Pendiente",""),
                                 (4,"Confirmada",""),
                                 (5,"Rechazada",""),
                                 (6,"Caducada",""),
                                 (7,"Cancelada",""),
                                 (8,"Cerrada",""),
                                 (9,"Finalizada","");

-- v_hoteles_habitacions_disponibles agrupados por sitio 
-- filtros (precio-lugar-etc-serviciosexistentes)
-- sp_seria un proceso del modelo?
