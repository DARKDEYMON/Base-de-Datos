SELECT 'darkdey_alfa@hotmail.com' REGEXP '^[A-Za-z0-9._-]+@[A-Za-z0-9 -]+.[A-Za-z]+$';
select 'hola1' regexp '^[A-Za-z]+$';
SELECT '999.168.1.1' REGEXP '^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){2}(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]))$';
SELECT '9.9.9.9' REGEXP '^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]).([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]).{2}(.[1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$' as ip;
SELECT '+591 72435587' REGEXP '^[+][0-9]{3,3} [0-9]{8,8}$';
select current_date;
select '255.255.255.128' regexp '^(((255\.){3}(255|254|252|248|240|224|192|128|0+))|((255\.){2}(255|254|252|248|240|224|192|128|0+)\.0)|((255\.)(255|254|252|248|240|224|192|128|0+)(\.0+){2})|((255|254|252|248|240|224|192|128|0+)(\.0+){3}))$';
select  '0.0.0.0' regexp '^((255.){3}(255|254|252|248|240|224|192|128|0))|((255.){2}(255|254|252|248|240|224|192|128|0)(.0))|((255.)(255|254|252|248|240|224|192|128|0)(.0){2})|((255|254|252|248|240|224|192|128|0)(.0){3})$';

create database pizzeria;
use pizzeria;
drop table cliente;
drop table recibo;
drop table producto;
drop table detalle_recibo;

create table cliente(
	id integer auto_increment primary key,
    nit integer,
    ci integer,
    nombre varchar(60) not null check(nombre regexp('^^[A-Za-z]+$')),
    apellido_p varchar(60) not null check(nombre regexp('^[A-Za-z]+$')),
    apellido_m varchar(60) not null check(nombre regexp('^[A-Za-z]+$')),
	calle varchar(60) not null,
    telefono integer not null check(nombre regexp('^[+][0-9]{3,3} [0-9]{8,8}$'))
);

insert into cliente(nit,ci,nombre,apellido_p,apellido_m,calle,telefono) values(1,6672252,'Reynaldo','Pereira','Heredia','H.vargas 828', 26221238);
select * from cliente;

create table recibo(
	id integer auto_increment primary key,
    id_c integer,
    total float,
    foreign key (id_c) references cliente(id)
);

create table producto(
	id integer auto_increment primary key,
    nombre varchar(60) not null,
    precio float not null
);

create table detalle_recibo(
	id_r integer,
    id_p integer,
    foreign key (id_r) references recibo(id),
    foreign key (id_p) references recibo(id)
);

create table pidzas(
	id integer auto_increment primary key,
    nombre varchar(60) not null check(nombre regexp('^^[A-Za-z]+$')),
    img varchar(150) not null,
    precio varchar(10)
);