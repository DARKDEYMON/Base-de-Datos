select * from aq$_internet_agent_privs where regexp_like('hola9','^[a-z]+$');

create table departamentos(
  idd NUMBER GENERATED ALWAYS AS IDENTITY primary key,
  descripcion varchar(50),
  ubicacion varchar(50),
  npiso int
);
drop table departamentos;
drop table empleados;
drop table dependientes;
select to_char(sysdate, 'DD-Mon-YYYY') as "Current Time"
from dual;

CREATE TABLE empleados(
  ide NUMBER GENERATED ALWAYS AS IDENTITY primary key,
  apellidos  VARCHAR(50),
  nombres varchar(50),
  profesion varchar(50),
  salario int,
  id_departamento int,
  constraint fore foreign key (id_departamento) references departamentos(idd),
  constraint revi check( regexp_like(apellidos,'^[a-z ]+$'))
);
create table dependientes(
  idd NUMBER GENERATED ALWAYS AS IDENTITY primary key,
  apellidos  VARCHAR(50),
  nombres varchar(50),
  fecha date,
  id_empleado int,
  constraint fored foreign key (id_empleado) references empleados(ide)
);
insert into departamentos(descripcion,ubicacion,npiso) values('sistemas','este',1);
insert into departamentos(descripcion,ubicacion,npiso) values('contabilidad','oeste',2);
insert into departamentos(descripcion,ubicacion,npiso) values('caja','este',3);
insert into departamentos(descripcion,ubicacion,npiso) values('bienes','sur',2);
select * from departamentos;
insert into empleados(apellidos,nombres,profesion,salario,id_departamento) values('montero vargas','jose','ingeniero',4000,1);
insert into empleados(apellidos,nombres,profesion,salario,id_departamento) values('ramos cossio','mirian','analista',3000,1);
insert into empleados(apellidos,nombres,profesion,salario,id_departamento) values('rojas miller','lucia','secretaria',1000,3);
insert into empleados(apellidos,nombres,profesion,salario,id_departamento) values('corona leon','jessica','secretaria',800,2);
insert into empleados(apellidos,nombres,profesion,salario,id_departamento) values('hernadez ala','manuel','icontador',3000,2);
select * from empleados;
drop table empleados;