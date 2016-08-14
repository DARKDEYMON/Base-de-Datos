--prubas en branch 1 otra ves
create table usuario(
  ci integer primary key,
  nombre varchar(50)
);

drop table bitacora;
create table bitacora(
  ci integer,
  operacion varchar(50)
);
create or replace trigger tr_bitarcora
before insert or update or delete
on usuario
for each row
begin
  if INSERTING then
    insert into bitacora values(:new.ci,'Insertado');
  end if;
  if DELETING then
    insert into bitacora values(:old.ci,'Borrado');
  end if;
  if UPDATING then
    insert into bitacora values(:new.ci,'Actualisado');
  end if;
end;

insert into usuario values(6672252,'Sandra');
update usuario set ci=6672254 where ci=6672252;
delete usuario where ci=6672254;
select * from usuario;
select * from bitacora;


create table libros(
  idd integer primary key,
  nombre varchar(50),
  cantidad integer
);
create table prestamo(
  ci integer,
  idd_libro integer,
  cantidad integer,
  constraint fore foreign key (idd_libro) references libros(idd) on delete cascade,
  constraint fore1 foreign key (ci) references usuario(ci) on delete cascade
);
create or replace trigger prestamo
before insert
on prestamo
for each row
begin
  if :new.cantidad <= 0 then
    RAISE_APPLICATION_ERROR(-20000,'La cantidad no puede ser cero o menor');
  else
    update libros set cantidad=cantidad-:new.cantidad where idd=:new.idd_libro;
  end if;
end;

create or replace trigger borrado
before delete
on prestamo
for each row
begin
  update libros set cantidad=cantidad+:old.cantidad where IDD=:old.idd_libro;
end;

create or replace trigger cant_libros
before insert or update
on libros
for each row
begin
  if(:new.cantidad<0)then
     RAISE_APPLICATION_ERROR(-20001,'La cantidad no puede ser negativa');
  end if;
end;

insert into libros values(1,'Charly y amigos',0);
insert into libros values(2,'Charly 2',50);
insert into libros values(3,'Charly 3',10);
select * from libros;
select * from prestamo;
insert into prestamo values(6672252,1,1);
insert into prestamo values(6672252,2,25);
delete from prestamo where ci=6672252;