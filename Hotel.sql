create database hotel;
use hotel;
create table habitaciones
(
	num_habit BIGINT,
	exterior varchar(60) check(exterior='si' or exterior='no'),
	bano varchar(60) check(bano='si' or bano='no'),
	tipo varchar(60) check(tipo='Simple' or tipo='Suite' or tipo='Doble' or tipo='Triple'),
	estado varchar(60) check(estado='Reservada' or estado='Libre' or estado='Ocupada' or estado='En Obra'),
	precio_temp_alta BIGINT,
	precio_temp_baja BIGINT primary key(num_habit)
);

create table clientes
(
	dni varchar(60) primary key(dni),
	nombre varchar(60),
	apellidos varchar(60),
	movil BIGINT
);

create table reservas
(
	num_habit BIGINT foreign key references habitaciones(num_habit),
	dni varchar(60) foreign key references clientes(dni),
	fecha_entrega date,
	fecha_salida date,
	pagada varchar(60) check(pagada='si' or pagada='no')
);