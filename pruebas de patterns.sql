use hotel;
select * from clientes;
SELECT 'IN' WHERE 'A' NOT IN ('B',NULL);

select getdate();

select 'darkdey_alfa@hotmail.com' as 'hola' check(hola like'[A-Za-z0-9._-]+@[A-Za-z0-9 -]+.[A-Za-z]+');

select 'darkdey_alfa@hotmail.com' like('[A-Za-z0-9._-]+@[A-Za-z0-9 -]+.[A-Za-z]+')

select 'darkdey_alfa@hotmail.com' check('hola' or 'tu');


 if object_id('libros')is not null
   drop table libros;
  create table libros(
   codigo VARCHAR(50) check(codigo like('[a-z]%@[a-z]%.[a-z]%')),
  );
  insert into libros values('dark-hola@hola.com')
  select * from libros