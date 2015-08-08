create table clientes(
  ci int primary key,
  nombre varchar(50) not null,
  apellido_paterno varchar(50) not null,
  apellido_materno varchar(50) not null,
  sexo varchar(1) default('N') check(sexo in('F','M','N')) not null,
  direccion varchar(50),
  telefono int unique
);
drop table clientes;
create table articulo(
  id_art int primary key,
  nombre varchar(60) not null,
  descripcion varchar(4000),
  precio_unitario float check(precio_unitario>=10) not null,
  existencias int check(existencias>=0) not null
);
drop table articulo;
 create table ventas(
  id_venta int primary key,
  ci_cliente int,
  num_factura int unique not null,
  fecha date not null,
  constraint fore_ve_cli_ven foreign key (ci_cliente) references clientes(ci)
 );
 drop table ventas;
 create table detalle_ventas(
  id_venta int,
  id_art int,
  cantidad int check(cantidad>0) not null,
  constraint fore_deta_ven_deta foreign key (id_venta) references ventas(id_venta),
  constraint fore_deta_art_deta foreign key (id_art) references articulo(id_art)
 );
 drop table detalle_ventas;
 insert into CLIENTES values(6672252,'Reynaldo','Pereira','Heredia','M','H. Varagas 828',72435587);
 insert into CLIENTES values(7826668,'Sandra','Condori','Condori','F','Hernadez 450',72435588);
 insert into CLIENTES values(7826669,'Andrea','Veliz','Marin','F','Bustillos 450',72335588);
 select *from clientes;
 insert into articulo values(1,'Clavos','Venta es por volsa',10,100);
 insert into articulo values(2,'Martillo','Venta por unidad',100,50);
 insert into articulo values(3,'Flexo','Venta por unidad',15,100);
 insert into articulo values(4,'Escuadra','Venta es por juego',70,200);
 select * from articulo;
 select current_date from dual;
 insert into ventas values(1,6672252,123456,(select current_date from dual));
 insert into ventas values(2,7826668,123457,(select current_date from dual));
 insert into ventas values(3,7826669,123458,(select current_date from dual));
 insert into ventas values(4,6672252,123459,(select current_date from dual));
 insert into ventas values(5,7826668,123460,(select current_date from dual));
 select * from ventas;
 insert into detalle_ventas values(1,1,20);
 insert into detalle_ventas values(1,2,2);
 insert into detalle_ventas values(2,2,3);
 insert into detalle_ventas values(2,4,3);
 insert into detalle_ventas values(3,3,5);
 insert into detalle_ventas values(3,4,8);
 insert into detalle_ventas values(4,1,3);
 insert into detalle_ventas values(5,2,6);
 insert into detalle_ventas values(5,3,10);
 insert into detalle_ventas values(5,4,4);
 select * from detalle_ventas;
 
 create view cliente_view 
 as select c.ci
 from clientes c;
 SELECT * FROM CLIENTE_VIEW;
 
 drop view deuda_total;
 create view deuda_total
 as
  select c.ci,c.NOMBRE,sum(a.PRECIO_UNITARIO*dv.CANTIDAD) as total from clientes c, articulo a,ventas v, detalle_ventas dv where c.CI=v.CI_CLIENTE and v.ID_VENTA=dv.ID_VENTA and a.ID_ART=dv.ID_ART group by c.CI,c.NOMBRE;
 select * from DEUDA_TOTAL;

 CREATE SEQUENCE customers_seq
 START WITH     1000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 create or replace procedure clie_pro (cii in integer ,prc out sys_refcursor)
 is
 begin
  open prc for select * from clientes where CI=cii;
 end;
 
var rc refcursor;
execute clie_pro(6672252,:rc);
print rc;

 
 create or replace procedure select_ci(cii in INTEGER,cl out clientes%rowtype)
 as
 begin
  select * into cl from clientes where CI=cii; 
 end;
 
 DECLARE
  rc clientes%rowtype;
 begin
  select_ci(6672252,rc);
  dbms_output.put_line('Name is '||rc.ci);
 end;
 
 
--no da este 
declare
  c1 sys_refcursor;
begin
  open c1 for select * from clientes;
  DBMS_SQL.RETURN_RESULT(c1);
end;


SELECT 
to_date('2008-08-05','YYYY-MM-DD')-to_date('2008-08-04','YYYY-MM-DD') 
AS DiffDate from dual;

todays_day = @COMPUTE (@DATEDIFF ('DD', '2011-01-01', @DATENOW ()) +1);
declare
  ll integer
begin
  ll=@DATEDIFF ('DD', '2011-01-01', @DATENOW ());
  dbms_output.put_line(ll);
end;

select 
  dt1, dt2,
  trunc( months_between(dt2,dt1) ) mths, 
  dt2 - add_months( dt1, trunc(months_between(dt2,dt1)) ) days
from
(
    select date '2012-01-01' dt1, date '2012-03-25' dt2 from dual union all
    select date '2012-01-01' dt1, date '2013-01-01' dt2 from dual union all
    select date '2012-01-01' dt1, date '2012-01-01' dt2 from dual union all
    select date '2012-02-28' dt1, date '2012-03-01' dt2 from dual union all
    select date '2013-02-28' dt1, date '2013-03-01' dt2 from dual union all
    select date '2013-02-28' dt1, date '2013-04-01' dt2 from dual union all
    select trunc(sysdate-1)  dt1, sysdate               from dual
);