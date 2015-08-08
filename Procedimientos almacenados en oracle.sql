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
 -- creamos las tablas e inceratmos unos cuanto datos
 insert into CLIENTES values(6672252,'Reynaldo','Pereira','Heredia','M','H. Varagas 828',72435587);
 insert into CLIENTES values(7826668,'Sandra','Condori','Condori','F','Hernadez 450',72435588);
 insert into CLIENTES values(7826669,'Andrea','Veliz','Marin','F','Bustillos 450',72335588);
 -- creamo el proceso almacenado que para selexionar un cliente por su ci
 create or replace procedure clie_pro (cii in integer ,prc out sys_refcursor)
 as
 begin
  open prc for select * from clientes where CI=cii;
 end;
 -- provamos el proceso almacenado
var rc refcursor;
execute clie_pro(6672252,:rc);
print rc;


-- creamos una secuencia para la tabla articulo
CREATE SEQUENCE sec_art
START WITH     1
INCREMENT BY   1
NOCACHE
NOCYCLE;

-- creamos el proceso almacenado para insertar un articulo en el cual rellenamos de antemano el id con la secuencia y el campo date con la funcion sysdate  
create or replace procedure insert_art(nombree in varchar, descripcionn in varchar, precio_unitarioo in integer, existenciass in integer)
as
begin
  insert into articulo values(sec_art.NextVal,nombree,descripcionn,precio_unitarioo,existenciass,sysdate);
end;
-- llenamos algunos datos con el proceso almacenado
execute insert_art('Clavos','Venta es por volsa',10,100);
execute insert_art('Martillo','Venta por unidad',100,50);
select * from articulo;

-- creamos un proceso amacenado para aumentar un determinado porcentaje el precio de los articulos
create or replace procedure aumento_art(aumento in float)
as
begin
  update articulo set PRECIO_UNITARIO=PRECIO_UNITARIO+PRECIO_UNITARIO*aumento;
end;
-- ejecutamos el proceso almacenado aumentando un 20% el precio de los aritulos
execute AUMENTO_ART(0.2);

-- activamos el Dbms_Output.Put_Line
SET SERVEROUTPUT ON
 
BEGIN
 Dbms_Output.Put_Line(Systimestamp);
 Dbms_Output.Put_Line(sysdate);
END;

 create or replace procedure select_ci(cii in INTEGER,cl out clientes%rowtype)
 as
 begin
  select * into cl from clientes where CI=cii; 
 end;
 
 DECLARE
  rc clientes%rowtype;
 begin
  select_ci(6672252,rc);
  dbms_output.put_line('CI: '||rc.ci||'Nombre: '||rc.nombre);
 end;
 
create or replace procedure aumento_art_ex(aumento in float)
as
begin
  if aumento<0 or aumento>=1 then 
    return;
  end if;
  update articulo set PRECIO_UNITARIO=PRECIO_UNITARIO+PRECIO_UNITARIO*aumento;
end;
select * from articulo;
execute aumento_art_ex(0.2);

declare
 noenrango exception;
 va FLOAT:=0.2;
begin
  if(va<0 or va>=1)then
    raise noenrango;
  else
    aumento_art_ex(va);
    dbms_output.put_line('Ejecutado con exito!!!');
  end if;
  exception when noenrango then 
    dbms_output.put_line('No esta en el rango');
end;

create or replace procedure aumento_art_ex_ini(aumento in float)
is
  noenrango exception;
begin
  if aumento<0 or aumento>=1 then 
    raise noenrango;
  else
    update articulo set PRECIO_UNITARIO=PRECIO_UNITARIO+PRECIO_UNITARIO*aumento;
  end if;
  exception when noenrango then 
    dbms_output.put_line('El valor no esta en el rango permitido');
end;
execute aumento_art_ex_ini(0.3);

declare
  n integer;
  e integer:=8;
  f integer:=9;
  res integer;
begin
   res:=COALESCE (n, f, e);
   dbms_output.put_line(res);
end;

declare
  b INTEGER;
begin
  select count(*) into b  from clientes where ci = 6672253;
  if(b>0) then
    dbms_output.put_line('si');
  else
    dbms_output.put_line('no');
  end if;
end;