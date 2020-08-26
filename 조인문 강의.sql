select *from depart;

insert into emp values(null,'둘리',1);
insert into emp values(null,'마이콜',2);
insert into emp values(null,'또치',1);
insert into emp values(null,'도우넛',4);
insert into emp values(null,'희동이',3);
insert into emp values(null,'길동이',null);

select *from emp;
#join on
select a.name, b.name
from emp a
join depart b on a.depart_no = b.no; #길동이 출력이 안되는데 길동이는 왼쫀 컬럼에 있으니까 left 조인 

#left join

select a.name, ifnull(b.name,'없음')
from emp a
left join depart b on a.depart_no = b.no;

#right join
select a.name, b.name
from emp a
right join depart b on a.depart_no = b.no
group by b.name

;
##부서별 사원수


select m.name,ifnull(n.cnt,0) as '사원수'
	from depart m
   left join (	select b.no, count(*) as cnt
    from emp a
    join depart b on a.depart_no =b.no
    group by b.no) n on m.no = n.no;

select b.name, count(*)
from emp a
join depart b on a.depart_no = b.no #길동이 출력이 안되는데 길동이는 왼쫀 컬럼에 있으니까 left 조인 필요
group by b.name;



#sub 쿼리 where절이나 from 절이나 select 절에 들어가는 것 
