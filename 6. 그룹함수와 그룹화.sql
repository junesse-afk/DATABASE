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

select avg(ifnull(commission_pct,0)) as 'avg_comm'
from employees;