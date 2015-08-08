create database pruebas;
use pruebas;

create table libro(
	id_libro int identity primary key,
	nombre varchar(50),
	autor varchar(50)
);

create table venta(
	id_libro_v int,
	id_venta int identity primary key,
	precio int
	foreign key (id_libro_v) references libro(id_libro)
);
--drop view vendido_mas_de_dos;
create view Vendido
as
	select all l.id_libro,l.nombre from libro as l, venta as v where l.id_libro=v.id_libro_v group by l.nombre,l.id_libro having count(l.nombre)>=2
select * from Vendido;

select * from INFORMATION_SCHEMA.TABLES;
EXEC sp_databases;

create assembly RegExBase
from 'C:\Users\DARKDEYMON\Documents\Visual Studio 2013\Projects\RegExBase\RegExBase\obj\Debug\RegExBase.dll'
with permission_set =safe;

CREATE FUNCTION dbo.RegEx(@nombre1 nvarchar(max),@nombre2 nvarchar(max))
RETURNS bit
AS
EXTERNAL NAME RegExBase.[RegExBase].RegExMatch;

sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

select dbo.RegEx('^[a-z]+$','dag');
select libro.autor 
from libro 
where dbo.RegEx('^[a-zA-Z0-9_\-]+@([a-zA-Z0-9_\-]+\.)+(com|org|edu|nz|au)$', libro.autor) = 1

create table identi(
	id int identity,
	nombre varchar (50) check( dbo.RegEx('^[a-z]+$',nombre)=1)
);
insert into identi values('rey');