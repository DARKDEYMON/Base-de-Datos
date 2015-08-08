create table usuario
(
	ci character varying(7) check(ci similar to('[0-9]{7,7}')),
	correo character varying(40) not null check(correo similar to ('[A-Za-z0-9._-]+@[A-Za-z0-9]+.[A-Za-z]+')),
	contrasena character varying(20) not null check(contrasena similar to('[^ ]+')),
	nombres character varying(40) not null check(nombres similar to('[a-zA-Z ]+')),
	apellidos character varying(40) not null check(apellidos similar to('[a-zA-Z ]+')),
	direccion character varying(20) check(direccion similar to('[a-zA-Z0-9. ]+')),
	telefono character varying(15) check(telefono similar to('[0-9+ ]+')),
	fecha_de_registro date not null,
	primary key(ci)
)
insert into usuario values ('7832111','estrellitas_alex@hotmail.com','pelotas','Alex Marvin','Fuentes Ramos','J. Arias sn','78866696',current_date)

create sequence de_im
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;

create table demanda_inmueble
(
	id_demanda int default(nextval('de_im')),
	zona_ref character varying(20) not null check(zona_ref similar to('[a-zA-Z. ]+')),
	fecha_registro date not null,
	tipo_inmueble text not null,
	descripcion text not null,
	presupuesto decimal(6,2) not null,
	estado text not null,
	primary key(id_demanda)
)
create sequence id_a
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;

create table administrador
(
	id_adm int default(nextval('id_a')),
	nick unique character varying(20) not null check(nick similar to('[a-zA-Z0-9]+')),
	contrasena character varying(20) not null check(contrasena similar to('[^ ]+')),
	primary key(id_adm)
)
insert into administrador(nick,contrasena)values ('DARKDEYMON','nadaesreal')

create sequence id_b
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;

create table bitacora
(
	id_bita int default(nextval('id_b')),
	operacion character varying(20) not null check(operacion='Compra' or operacion='Venta'),
	fecha date,
	id_admin int,
	primary key (id_bita),
	foreign key (id_admin) references administrador(id_adm)
	on delete cascade on update cascade
)
create sequence id_i
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;

create table inmueble
(
	cod int default(nextval('id_i')),
	direccion character varying(20) not null check(direccion similar to('[a-zA-Z0-9. ]+')),
	zona_ref character varying(20) not null check(zona_ref similar to('[a-zA-Z. ]+')),
	sup_cubierta int not null,
	sup_total int not null,
	fecha_registro date not null,
	tipo_inmueble text not null,
	descripcion text not null,
	precio decimal(6,2) not null,
	estado text not null,
	imagen character varying(100),
	id_adm int,
	primary key (cod),
	foreign key (id_adm) references administrador(id_adm),
	ci_usuario character varying(7),
	foreign key (ci_usuario) references usuario(ci)
)
insert into inmueble(direccion,zona_ref,sup_cubierta,sup_total,fecha_registro,tipo_inmueble,descripcion,precio,estado,id_adm,ci_usuario)values ('H. vargas 828','calvario',100,200,current_date,'Casucha','Bonita',100.20,'buen estado',2,7832111)

create sequence id_c
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;
drop table compra

create table compra
(
	id_compra int default(nextval('id_c')),
	fecha_compra date not null,
	ci_usuario character varying(20),
	cod_inmueble int,
	primary key (id_compra),
	foreign key (ci_usuario) references usuario(ci) on delete cascade on update cascade,
	foreign key (cod_inmueble) references inmueble(cod) on delete cascade on update cascade
)
create sequence id_co
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;
create table contado
(
	id_contado int default(nextval('id_co')),
	item_notario character varying(7) not null check(item_notario similar to('[0-9]{7,7}')),
	id_compra int,
	primary key (id_contado),
	foreign key (id_compra) references compra(id_compra) on delete cascade on update cascade
)
create sequence id_cr
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;
create table credito
(
	id_credito int default(nextval('id_cr')),
	total_pagado decimal(6,2) not null,
	cant_pagos int not null,
	id_compra int,
	primary key (id_credito),
	foreign key (id_compra) references compra(id_compra) on delete cascade on update cascade
)
create or replace function control_credito() returns trigger as $$
begin
	if (new.total_pagado=0 or new.cant_pagos=0)
	then
		if not exists (select * from credito where id_compra=new.id_compra)
		then
			raise exception 'no se puede insertar o el pago ya se cumplio';
		end if;
			delete from credito where id_compra=new.id_compra;
	end if;
	return new;
end;
$$ language plpgsql;

create trigger t_control_credito
before insert or update
on credito
FOR EACH ROW EXECUTE PROCEDURE control_credito();



create or replace function precio() returns trigger as $precio$
begin
	if (NEW.precio<1000)
	then
		raise exception 'precio menor';
	end if;
	return new;
end;
$precio$ language plpgsql;


create trigger c_precio
before insert
on inmueble
FOR EACH ROW EXECUTE PROCEDURE precio();

drop trigger c_precio on inmueble
drop table usuario
SELECT regexp_matches('darkdey_alfa@hotmail.com', '[A-Za-z0-9._-]+@[A-Za-z0-9 -]+.[A-Za-z]+');

select current_date;
select '5912622 1238asd>%·' similar to('[^ ]+')
select 'darkdey_alfa@hotmail.com' similar to('[A-Za-z0-9._-]+@[A-Za-z0-9 -]+.[A-Za-z]+')


--funciones--
drop function usuario_entrada(ci character varying(7),correo character varying(40),contrasena character varying(20),nombres character varying(40),apellidos character varying(40),direccion character varying(20),telefono character varying(15));
create or replace function usuario_entrada(ci character varying(7),correo character varying(40),contrasena character varying(20),nombres character varying(40),apellidos character varying(40),direccion character varying(20),telefono character varying(15))
returns void AS
$$ 
begin
	ci=$1;
	correo=$2;
	contrasena=$3;
	nombres=$4;
	apellidos=$5;
	direccion=$6;
	telefono=$7;
	insert into usuario values ($1,$2,$3,$4,$5,$6,$7,current_date);
	return;
end;
$$ language plpgsql;

select usuario_entrada('7832178','estrs_alex@hotmail.com','pelotas','Alex Marvin','Fuentes Ramos','J. Arias sn','766696');

create or replace function demanda_inmueble_entrada(zona_ref character varying(20),tipo_inmueble text,descripcion text,presupuesto decimal(6,2),estado text)
returns void as
$$
begin
	zona_ref=$1;
	tipo_inmueble=$2;
	descripcion=$3;
	presupuesto=$4;
	estado=$5;
	insert into demanda_inmueble(zona_ref,fecha_registro,tipo_inmueble,descripcion,presupuesto,estado)values($1,current_date,$2,$3,$4,$5);
	return;
end; 
$$ language plpgsql;

select demanda_inmueble_entrada('Calvario','Alto','casa grande',50200.3,'nueva');

create or replace function administrador_entrada(nick character varying(20),contrasena character varying(20))
returns void as
$$
begin
	nick=$1;
	contrasena=$2;
	insert into administrador(nick,contrasena)values($1,$2);
	return;
end; 
$$ language plpgsql;

select administrador_entrada('reynaldo','nadaesreal');

create or replace function bitacora_entrada(operacion character varying(20),id_admin int)
returns void as
$$
begin
	operacion=$1;
	id_admin=$2;
	insert into bitacora(operacion,fecha,id_admin)values($1,current_date,$2);
	return;
end; 
$$ language plpgsql;

select bitacora_entrada('Venta',3);

create or replace function bitacora_entrada(direccion character varying(20),zona_ref character varying(20),sup_cubierta int,sup_total int,tipo_inmueble text, descripcion text, precio decimal(6,2),estado text, imagen character varying(20),id_adm int,ci_usuario int)
returns void as
$$
begin
	direccion=$1;
	zona_ref=$2;
	sup_cubierta=$3;
	sup_total=$4;
	tipo_inmueble=$5;
	descripcion=$6;
	precio=$7;
	estado=$8;
	imagen=$9;
	id_adm=$10;
	ci_usuario=$11;
	insert into inmueble(direccion,zona_ref,sup_cubierta,sup_total,fecha_registro,tipo_inmueble,descripcion,precio,estado,imagen,id_adm,ci_usuario)values ($1,$2,$3,$4,current_date,$5,$6,$7,$8,$9,$10,$11);
	return;
end; 
$$ language plpgsql;

select bitacora_entrada('H. vargas 828','calvario',100,200,'Casucha','Bonita',6000.45,'buen estado',null,2,7832111);

create or replace function compra_entrada(ci_usuario character varying(20),cod_inmueble int)
returns void as
$$
begin
	ci_usuario=$1;
	cod_inmueble=$2;
	insert into compra(fecha_compra,ci_usuario,cod_inmueble)values(current_date,$1,$2);
	return;
end; 
$$ language plpgsql;

select compra_entrada('7832111',36);

create or replace function contado_entrada(item_notario character varying(7),id_compra int)
returns void as
$$
begin
	item_notario=$1;
	id_compra=$2;
	insert into contado(item_notario,id_compra)values($1,$2);
	return;
end; 
$$ language plpgsql;

select contado_entrada('6672252',1)

create or replace function credito_entrada(total_pagado decimal(6,2),cant_pagos int,id_compra int)
returns void as
$$
begin
	total_pagado=$1;
	cant_pagos=$2;
	id_compra=$3;
	insert into credito(total_pagado,cant_pagos,id_compra)values($1,$2,$3);
	return;
end; 
$$ language plpgsql;

select credito_entrada(5000,9,1);

update credito set total_pagado=5000, cant_pagos=0 where id_compra=1
delete from credito where id_compra=1

create view vista_inmuebles
as
	select direccion,zona_ref,sup_cubierta,sup_total,tipo_inmueble,descripcion,precio,estado,id_adm,ci_usuario from inmueble

select * from vista_inmuebles