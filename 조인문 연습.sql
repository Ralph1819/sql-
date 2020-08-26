#ex.1 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체이름을 출력하세요 .
###################################################################
##(1.2)개별쿼리로 해결 -> 안좋은 방법(절대 하지 말 것,한번으로 가능하면 한번으로 입력 ) 
select b.dept_no
from employees a , dept_emp b
where a.emp_no = b.emp_no
and b.to_date= '9999-01-01'
and concat(a.first_name,' ',a.last_name) = 'Fai Bale';

##(1.3)
select a.emp_no,  concat(first_name,' ',last_name)
from employees a ,dept_emp b
where a.emp_no = b.emp_no
and b.to_date= '9999-01-01'
and b.dept_no = 'd004';
###################################################################

##################서브 쿼리를 이용해서 한방에 끝내기// 쿼리 2개씩 날리지말고 ##################
#ex1-sol.1
select a.emp_no,  concat(first_name,' ',last_name)
from employees a ,dept_emp b
where a.emp_no = b.emp_no
and b.to_date= '9999-01-01'
and b.dept_no = (select b.dept_no
				from employees a , dept_emp b
				where a.emp_no = b.emp_no
				and b.to_date= '9999-01-01'
				and concat(a.first_name,' ',a.last_name) = 'Fai Bale');
##################                        끝                      ##################

# 단일행인 경우 
# =, !=, >, <, <=, >=

#ex2 현재 전체 사원의 평균연봉 보다 적은 급여를 받는 사원의 이름과 급여를 출력해라.

SELECT 
    a.first_name, b.salary
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.salary < (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01')
order by b.salary desc;   


#다중행인 경우 
#in : 
#any : =any(= 'in') 어떤 거라도 한개만 같으면 된다 , >any, <any, <>any(= '!=any'), <=any , >=any
#all : =all 모두다 같아야 한다 , >all , <all , <>all(= '!=all, = 'not in'), <=all, >=all 


#ex3. 현재 급여가 50000 이상인 직원 이름 출력 
#sol3.1 join으로 해결 
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.salary > 50000;

#sol3.2 서브쿼리로 해결
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no, b.salary) > any(select emp_no, salary
					from salaries
                    where to_date='9999-01-01'
                    and salary > 50000)
                    ;
                    
                    
#sol3.4
select a.first_name, b.salary
from employees a,
     (select emp_no, salary
					from salaries
                    where to_date='9999-01-01'
                    and salary > 50000) b
where a.emp_no = b.emp_no;

# ex.4 현재 가장 적은 평균 급여의 직책과 평균 급여를 출력해보세요 
select min(avg_salary)




#sol4.2 topk

select a.title, avg(b.salary) as avg_salary
from titles a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.title
order by avg_salary asc
limit 0,1;


#ex5. 각 부서별로 최고 급여를 받는 직원의 이름과 급여를 출력하세요 .
select a.dept_no,  max(b.salary)
  from dept_emp a, salaries b
  where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
  group by a.dept_no;


#sol5.1 where절 subquery
select a.first_name, b.dept_no, d.dept_name, c.salary
  from employees a, dept_emp b, salaries c, departments d
where a.emp_no = b.emp_no
  and b.emp_no = c.emp_no
  and b.dept_no = d.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and (b.dept_no, c.salary) = any (select a.dept_no,  max(b.salary)
								     from dept_emp a, salaries b
									where a.emp_no = b.emp_no
								      and a.to_date = '9999-01-01'
									  and b.to_date = '9999-01-01'
								 group by a.dept_no)
order by c.salary desc;



#sol 5.2

select a.first_name, b.dept_no, d.dept_name, c.salary
  from employees a,
       dept_emp b,
       salaries c,
       departments d,
       ( select a.dept_no,  max(b.salary) as max_salary
  from dept_emp a, salaries b
  where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
	group by a.dept_no) e
where a.emp_no = b.emp_no
  and b.emp_no = c.emp_no
  and b.dept_no = d.dept_no
  and b.dept_no = e.dept_no
  and c.salary = e.max_salary
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01';
  
  
  #다음 쿼리를 짜서 위에 from에 붙여줄 수 있음 .
select a.dept_no,  max(b.salary) as max_salary
  from dept_emp a, salaries b
  where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
	group by a.dept_no;