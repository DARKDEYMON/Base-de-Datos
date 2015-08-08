create table clientes(
  ci int primary key,
  nombre varchar(50) not null,
  apellido_paterno varchar(50) not null,
  apellido_materno varchar(50) not null,
  sexo varchar(1) default('N') check(sexo in('F','M','N')) not null,
  direccion varchar(50),
  telefono int unique,
  fecha date
);

SET SERVEROUTPUT ON

select to_number(to_char(sysdate,'YYYY')) from dual;
select to_number(to_char(sysdate,'MM')) from dual;
select to_number(to_char(sysdate,'DD')) from dual;

create or replace trigger fecha
before insert or delete or update on clientes
for each row
begin
  dbms_output.put_line(:new.fecha);
  if (:old.fecha is not null) then
    dbms_output.put_line(:old.fecha||' no es bacio');
  end if; 
end;

create or replace trigger variables
before insert on clientes
for each row
declare
  hola date;
begin
  hola:=:new.fecha;
  dbms_output.put_line(hola);
end;

create or replace trigger no_diciembre
before insert on clientes
for each row
begin
  if(to_char(:new.fecha,'MM')='12')then
    RAISE_APPLICATION_ERROR(-20506,'¡No en dicimbre!');
  end if;
end;

insert into CLIENTES values(6672252,'Reynaldo','Pereira','Heredia','M','H. Varagas 828',72435587,TO_DATE('2013-06-03', 'yyyy/mm/dd '));
insert into CLIENTES values(7826668,'Sandra','Condori','Condori','F','Hernadez 450',72435588,TO_DATE('2013-06-03', 'yyyy/mm/dd '));
insert into CLIENTES values(7826669,'Andrea','Veliz','Marin','F','Bustillos 450',72335588,TO_DATE('2013-10-12', 'yyyy/mm/dd '));
insert into CLIENTES values(7826667,'Andrea','Veliz','Marin','F','Bustillos 450',72335588,TO_DATE('2013-12-12', 'yyyy/mm/dd '));

select * from clientes;
delete from clientes where CI=6672252;
delete from clientes where CI=7826668;
delete from clientes where CI=7826669;