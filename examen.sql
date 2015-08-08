create or replace procedure aguinaldo(cii in integer)
is
  fecha date;
  total_anios integer;
  total_meses integer;
  sueldo integer;
  calculo_porcentaje float;
begin
  select fecha_in into fecha from clientes where ci=cii;
  select salario into sueldo from clientes where ci=cii;
  total_anios:=TRUNC(months_between(sysdate,fecha)/12,0);
  --dbms_output.put_line(months_between(sysdate,fecha));
  --total_meses:=TRUNC(months_between(sysdate,fecha),0);
  total_meses:=months_between(sysdate,fecha);
  if(total_anios>0)then
    --dbms_output.put_line(total_anios);
    dbms_output.put_line(sueldo);
  else
	if(total_meses>3)then
		--calculo_porcentaje:=total_meses/3;
		--dbms_output.put_line(calculo_porcentaje);
		--calculo_porcentaje:=calculo_porcentaje*0.25;
		dbms_output.put_line((sueldo/12)*total_meses);
	else
		dbms_output.put_line('0');
	end if;
  end if;
end;

create table clientes(
  ci int primary key,
  nombre varchar(50) not null,
  apellido_paterno varchar(50) not null,
  apellido_materno varchar(50) not null,
  salario integer not null,
  fecha_in date not null
);
insert into CLIENTES values(6672252,'Reynaldo','Pereira','Heredia',100,TO_DATE('2013-06-03', 'yyyy/mm/dd '));
insert into CLIENTES values(7826668,'Sandra','Condori','Condori',2000,TO_DATE('2012-07-03', 'yyyy/mm/dd '));
insert into CLIENTES values(7826669,'Andrea','Veliz','Marin',4000,TO_DATE('2015-03-03', 'yyyy/mm/dd '));

SET SERVEROUTPUT ON;

execute aguinaldo(7826669);

declare
  date1 date:=TO_DATE('2015-03-03', 'yyyy/mm/dd ');
  date2 date:=sysdate;
  en_entero integer;
begin 
  dbms_output.put_line(date2-date1);
  en_entero:=TRUNC(date2-date1,0);
  dbms_output.put_line(en_entero);
end;