create database tarea1;
go
use tarea1;
go
create table departamento(
	id int primary key,
	descripcion varchar(60),
	ubicacion varchar(60),
	npiso int
);

create table empleados(
	id int primary key,
	apellidos varchar(60),
	nombres varchar(60),
	profesion varchar(60),
	salario int,
	id_departamento int
	foreign key (id_departamento) references departamento(id)
);

create table dependientes(
	id int primary key,
	apellidos varchar(60),
	nombres varchar(60),
	fechan date,
	idempleado int
	foreign key (idempleado) references empleados(id)
);
insert into departamento values (1,'sistemas','este',1);
insert into departamento values (2,'contabilidad','oeste',2);
insert into departamento values (3,'caja','este',3);
insert into departamento values (4,'bienes','sur',2);
--
insert into empleados values (100,'Montero Vargas','Jose','Ingeniero',4000,1);
insert into empleados values (101,'Ramos Cossio','Mirian','Analista',3000,1);
insert into empleados values (102,'Rojas Miller','Lucia','Secretaria',1000,3);
insert into empleados values (103,'Corona Leon','Jessica','Secretaria',800,2);
insert into empleados values (104,'Hernadez Ala','Manuel','Conatador',3000,2);
insert into empleados values (105,'Tunez Cosh','Alberto','Ingeniero',3800,1);
insert into empleados values (106,'Fioreto Lima','Gerardo','Auditor',3000,4);
insert into empleados values (107,'Rivas Guzman','Magali','Contador',2500,3);
insert into empleados values (108,'Miranda Copa','Ricardo','Auditor',3000,4);

insert into dependientes values (10,'Montero Flores','Rosaura','05/05/2006',100);
insert into dependientes values (11,'Ramos Fita','Cecilia','04/01/2004',101);
insert into dependientes values (12,'Ramos Fita','Gustavo','05/12/2004',101);
insert into dependientes values (13,'Coronado Navarro','Luis','08/10/2000',103);
insert into dependientes values (14,'Fioreto Estrada','Marisol','30/01/2005',106);
insert into dependientes values (15,'Fioreto Estrada','Maribel','30/08/2007',106);
insert into dependientes values (16,'Miranda Jimenez','Raul','10/07/2000',108);
insert into dependientes values (17,'Miranda Jimenes','Alejandra','15/02/2002',108);
insert into dependientes values (18,'Miaranda Jimenez','Anabel','12/12/2007',108);


select distinct(e.id),e.nombres from empleados as e where  e.id not in (select d.idempleado from dependientes as d);
--select distinct e.*,d.* from empleados as e, dependientes as d where  e.id=d.idempleado; 
select e.nombres from empleados as e ,dependientes as d where e.id=d.idempleado group by e.id,e.nombres having COUNT(d.idempleado)=1
select distinct (e.id), e.nombres from empleados as e, dependientes as d where e.id=d.idempleado;
select de.* from empleados as e, departamento as d, dependientes as de where e.id_departamento=d.id and e.id=de.idempleado and d.npiso=2;
select d.* from dependientes as d where nombres like'%[a]%' and nombres like'%[l]%';
select e.profesion, AVG(e.salario) as promedio from empleados as e group by e.profesion;
select d.descripcion, COUNT(e.id_departamento) as numero_de_empleados from departamento as d, empleados as e where d.id=e.id_departamento group by d.descripcion;
select e.* from empleados as e order by salario desc;
select d.descripcion, e.profesion, AVG(e.salario) as promedio_salario from departamento as d, empleados as e where d.id=e.id_departamento group by e.profesion, d.descripcion;
select d.descripcion, avg(e.salario) as media_mayores_2000 from empleados as e, departamento as d where e.id_departamento=d.id and e.salario>2000 group by d.descripcion;
select d.descripcion,COUNT(e.id_departamento) as numero_de_empleados from departamento as d, empleados as e where d.id=e.id_departamento group by d.descripcion having  COUNT(e.id_departamento)>2;
select count(distinct e.salario) from empleados as e;
select d.descripcion, sum(e.salario) as suma, AVG(e.salario) as promedio, MIN(e.salario) as salario_min, MAX(e.salario) as salario_max from departamento as d,empleados as e where d.id=e.id_departamento group by d.descripcion;
update empleados set salario=salario+salario*0.2 where id_departamento in(select d.id from departamento as d where d.npiso=1);

--pruevas

select e.nombres,e.apellidos from empleados as e left join dependientes as d on e.id=d.idempleado where d.idempleado is NULL;
select e.*, d.* from empleados as e inner join dependientes as d on e.id=d.idempleado;
select e.*, d.* from empleados as e full outer join dependientes as d on e.id=d.idempleado;
select e.*, d.* from empleados as e left outer join dependientes as d on e.id=d.idempleado;
select e.*, d.* from empleados as e right outer join dependientes as d on e.id=d.idempleado;
select e.*, d.* from empleados as e cross join dependientes as d;
SELECT EVENTDATA().value;
go
create trigger hola
on departamento
for insert,delete
as
