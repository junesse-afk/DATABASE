use hr;

-- [실습]

-- 1번
select last_name, salary
from employees
where salary >= 12000;

-- 2번
select last_name, department_id
from employees
where department_id = 176;

-- 3번
select last_name, salary
from employees
where salary between 5000 and 12000;

-- 4번
select last_name, job_id, hire_date
from employees
where last_name in ('Matos', 'Taylor')
order by hire_date;

-- 5번
select last_name, department_id
from employees
where department_id in (20, 50)
order by department_id;

-- 6번
select last_name AS "Employee", salary as "Monthly Salary"
from employees
where salary between 5000 and 12000;

-- 7번
select last_name, job_id
from employees
where department_id is null;

-- 8번
select last_name, salary, commission_pct
from employees
order by COMMISSION_PCT desc;

-- 9번
select last_name
from employees
where last_name like '__a%';

-- 10번
select last_name
from employees
where last_name like ('%a%' '%e%');

-- 11번
select last_name as "Employee", salary as "Monthly Salary", commission_pct
from employees
where commission_pct = 0.20
and last_name like  '%y%';