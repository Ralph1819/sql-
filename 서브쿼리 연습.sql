#문제1.
#현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(a.emp_no) 
from employees a , salaries b 
where a.emp_no = b.emp_no
and b.to_date='9999-01-01'
and b.salary > (select avg(salary) from salaries c
where c.to_date='9999-01-01' )
;

select a.salary, b.salary, c.salary
  from salaries a, salaries b, salaries c;
;
#문제2. 
#현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select *
from dept.emp a, departments b, salaries c
where a.emp_no = c.emp_no
and a.dept_no = b.dept_no
;

#문제3.
#현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select a.emp_no , concat(a.first_name,' ',a.last_name)
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.salary > (select avg(b.salary)
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01')
;

#문제4.
#현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select a.emp_no, concat(a.first_name,' ',a.last_name),
from employees a, dept_manager b, dept_emp c, departments d
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and c.dept_no = d.dept_no
and b.to_date='9999-01-01'
and c.to_date='9999-01-01'
;
#문제5.
#현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select x.emp_no ,concat(x.first_name,' ',x.last_name),y.title,t.salary,d.dept_no
  from(
       select max(avg_salary) ,ads.dept_no as dept_no
         from (select avg(b.salary) as avg_salary ,a.dept_no
				 from dept_emp a, salaries b
                where a.emp_no = b.emp_no
                  and b.to_date='9999-01-01'
                  and a.to_date='9999-01-01'
			 group by a.dept_no) as ads
) as z ,dept_emp d, employees x ,titles y,salaries t
where d.emp_no = x.emp_no
and x.emp_no = y.emp_no
and x.emp_no = t.emp_no
and d.dept_no = z.dept_no
and d.to_date = '9999-01-01'
and y.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
;



#문제6.
#평균 연봉이 가장 높은 부서는? 

#문제7.
#평균 연봉이 가장 높은 직책?

#문제8.
#현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
#부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
