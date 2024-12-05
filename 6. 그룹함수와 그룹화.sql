-- [SQL 문법] 6. 그룹함수와 그룹화
use hr;

-- 그룹함수란?
-- 행그룹을 조작해서 하나의 결과값을 반환함.
-- 그룹함수 종류 : sum, avg, min, max, count
-- 그룹함수 특징 : null값은 제외하고 작업함!

-- min(행그룹) : 행그룹에서 최소값을 반환함.
-- max(행그룹) : 행그룹에서 최대값을 반환함.

select min(salary), max(salary)
from employees;

select min(hire_date), max(hire_date)
from employees;

select min(last_name), max(last_name)
from employees;

-- sum(행그룹) : 행그룹의 합계를 구해주는 함수
-- avg(행그룹) : 행그룹의 평균을 구해주는 함수
select sum(salary) as "급여합계", avg(salary) as "평균 급여"
from employees;
-- where job_id like '%REP%';

-- count(행그룹)　：　행그룹에서　행의　개수를　반환함

select count(*)
from employees; -- 전직원수를 출력하시오.

select count(employee_id) 
from employees; -- 전직원수를 출력하시오.

select count(last_name)
from employees; -- 전직원수를 출력하시오.

select count(comission_pct)
from employees; -- 커미션을 받는 직원 수를 출력하시오.

-- 예제 employees 테이블에서 전체 직원의 커미션 평균을 출력하시오.
-- 출력 avg_comm
-- 

select avg (round(ifnull(commission_pct,0),2)) as 'avg_comm'
from employees;


-- 6-2 group by절
-- 테이블 안에서 또다시 다른 작은 그룹화를 나눠주는 구문
-- [문법] *select 컬럼1, 컬럼2, 컬럼3
--       *from 테이블명
--       [ where 조건문 ]
--       [ group by 컬럼명 ]
--       [ order by 컬럼명 ] [ asc | desc ];
-- (★) 그룹함수와 group by절이 사용되는 구문 작성 시 규칙!
-- select 절의 컬럼리스트 중 그룹함수에 포함된 컬럼과
-- 그룹함수에 포함되지 않은 컬럼이 같이 출력되려면
-- 그룹함수에 포함되지 않은 컬럼은 빠짐없이 group by절에
-- 포함되어야 문법 오류가 발생되지 않음!

-- employees 테이블에서 부서별 급여의 평균을 출력하시오.
select department_id, AVG(salary)
from employees
group by department_id;

-- employees 테이블에서 부서 내 업무별 평균 급여를 출력하시오.
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id;

select department_id, job_id, sum(salary)
from employees
where department_id > 40
group by department_id, job_id
order by department_id;

-- 부서별 사원의 수를 출력하시오.
select department_id, count(last_name)
from employees
group by department_id;

-- 부서 내 업무별 사원의 수를 출력하시오.
select department_id, job_id, count(last_name)
from employees
group by department_id, job_id
order by department_id;

-- 6-3. having절 
-- [문법] *select 컬럼1, 컬럼2, 컬럼3
--       *from 테이블명
--       [ where 조건문 ]     --> 행을 제한하는 조건문
--       [ group by 컬럼명 ]
--       [  having 조건문  ]  --> 행그룹을 제한하는 조건문(그룹함수 포함 조건문)
--       [ order by 컬럼명 ] [ asc | desc ];

select job_id, SUM(salary) PAYROLL
from employees
where job_id NOT LIKE '%REP%'
group by job_id
having PAYROLL > 13000 -- 원래는 안되는 데 버전업데이트의 경우 사용 가능한가 봄
order by PAYROLL;

-- <연습문제>
-- 1. 예제
select round(avg(ifnull(commission_pct,0)),2) as 'avg_comm'
from employees;

-- 2. 예제
select job_id, round(max(salary),0) "Maximum", round(min(salary),0) "Minimum", round(sum(salary),0) "SUM", round(avg(salary),0) "Average"
from employees
group by job_id;

-- 3. 예제
select job_id, count(last_name)
from employees
group by job_id;

-- 4. 예제
select manager_id, min(salary)
from employees
where manager_id IS NOT NULL
group by manager_id
having min(salary) > 6000
order by min(salary) desc;

-- 5. 예제
select max(salary)-min(salary) as DIFFERENCE
from employees;

-- 6. 예제
select count(last_name) as total, sum(year(hire_date) = '1995') as '1995', sum(year(hire_date) = '1996') as '1996', sum(year(hire_date) = '1997') as '1997', sum(year(hire_date) = '1998') as '1998'
from employees;

select count(last_name) total,
	count(if(year(hire_date)=1995, 1, null)) "1995",
	count(if(year(hire_date)=1996, 1, null)) "1996",
	count(if(year(hire_date)=1997, 1, null)) "1997",
	count(if(year(hire_date)=1998, 1, null)) "1998"
from employees;