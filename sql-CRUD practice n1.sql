-- pet table 생성
create table pets(
name varchar(20),
owner varchar(20),
species varchar(20),
gender char(1),
birth date,
death date
);

-- table shceme(구조) 확인

desc pets;

-- insert
insert into pets values('성탄이','Ralph',
'dog','M','2010-12-25',null);

-- select
select * from pets;
select name, birth from pets;
select name, birth from pets order by birth desc;
insert into pets values('해피','Ralph','cat','F','2011-12-20',null);
select * from pets;
select count(*) from pets;

-- delete
delete from pets where death is not null;

#update
update pets set owner='green' where name = '성탄이';


load data local infile "pet.txt" into table pet;

