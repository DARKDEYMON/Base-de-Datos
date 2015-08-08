create table clientes(
  ci int primary key,
  nombre varchar(50) not null,
  apellido_paterno varchar(50) not null,
  apellido_materno varchar(50) not null,
  sexo varchar(1) default('N') check(sexo in('F','M','N')) not null,
  direccion varchar(50),
  telefono int unique
);

create table articulo(
  id_art int primary key,
  nombre varchar(60) not null,
  descripcion varchar(4000),
  precio_unitario float check(precio_unitario>=10) not null,
  existencias int check(existencias>=0) not null,
  fecha date not null
);

CREATE SEQUENCE sec_art
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;
 
create or replace procedure insert_cliente(cii in INTEGER,nombree in varchar, apellido_paternoo in varchar , apellido_maternoo in varchar ,sexoo in varchar, direccionn in varchar, telefonoo in integer )
as
begin
  insert into clientes values(cii,nombree,apellido_paternoo,apellido_maternoo,sexoo,direccionn,telefonoo);
end;

execute insert_cliente(6672252,'Reynaldo','Pereira','Heredia','M','H. Varagas 828',72435587);

select * from clientes;

create or replace procedure insert_art(nombree in varchar, descripcionn in varchar, precio_unitarioo in integer, existenciass in integer)
as
begin
  insert into articulo values(sec_art.NextVal,nombree,descripcionn,precio_unitarioo,existenciass,sysdate);
end;

create or replace procedure aumento_art_ex(aumento in float)
as
begin
  if aumento<0 or aumento>1 then 
    return;
  end if;
  update articulo set PRECIO_UNITARIO=PRECIO_UNITARIO+PRECIO_UNITARIO*aumento;
end;
execute aumento_art_ex(0.3);
select * from ARTICULO;

create or replace procedure aumento_art(aumento in float)
as
begin
  update articulo set PRECIO_UNITARIO=PRECIO_UNITARIO+PRECIO_UNITARIO*aumento;
end;
execute AUMENTO_ART(0.2);

execute insert_art('Clavos','Venta es por volsa',10,100);
execute insert_art('Martillo','Venta por unidad',100,50);
select * from articulo;

declare
 noenrango exception;
 va FLOAT:=8;
begin
  if(va<0 or va>1)then
    raise noenrango;
  else
    aumento_art_ex(va);
    dbms_output.put_line('yes');
  end if;
  exception when noenrango then 
    dbms_output.put_line('no');
end;
select * from ARTICULO;
raise_application_error(-20004, dbms_utility.format_error_backtrace);