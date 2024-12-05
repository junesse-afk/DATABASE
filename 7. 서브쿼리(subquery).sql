-- [SQL문법] 7. 서브쿼리(subquery)
use hr;

-- 서브쿼리란?
-- 쿼리구문 안에 또 다시 쿼리구문이 들어가 있는 형태
-- 서브쿼리를 먼저 실행하고 -> 메인쿼리가 실행됨
-- 서브쿼리 작성될 수 있는 곳 : group by절을 제외한 select구문에 작성 가능
--                        DML(insert, update, delete), DDL(create, alter 등) 작성 가능함

-- [문법] where절에 서브쿼리가 사용된 경우
-- 		select 컬럼1, 컬럼2, 컬럼3
--      from 테이블명
--      where 컬럼명 비교연산자 (서브쿼리 select 컬럼명
--                           from 테이블명
-- 							 where 조건문);
-- 전체는 메인 쿼리 / (select ~~ ) => subquery = inner query

-- 서브쿼리 유형 : 단일행 서브쿼리, 다중행 서브쿼리

-- 7-1. 단일행 서브쿼리
-- 서브쿼리로부터 메인쿼리로 단일행(단일값)이 반환되는 유형
-- 메인쿼리에 우변에 단일 값이 올 수 있는 단일행 비교연산자 사용하면됨.
-- 단일행 비교연산자 : =, >, >=, <, <=, <>, !=

-- employees 테이블에서 last_name이 'able'인 사원보다 급여를 더 많이
-- 받는 사원을 출력하시오.
select employee_id, last_name, salary
from employees
where salary > (select salary
				from employees
                where last_name = 'abel');
                
-- 141번사원 잡아이디(ST_CLERK)와 같은 사람들은 누구?
select last_name, job_id
from employees
where job_id = (select job_id
				from employees
                where employee_id = 141);

-- 가장 낮은 월급을 받는사람은 누구?
select last_name, job_id, salary
from employees
where salary = (select min(salary)
				from employees);
                
select last_name, job_id, salary
from employees
where job_id = (select job_id
				from employees
				where last_name = 'Lee')
and salary > (select salary
			from employees
            where last_name ='Lee');

SELECT 	department_id, MIN(salary)
from employees
WHERE department_id is not null
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary)
					  FROM employees
                      WHERE department_id = 30);

-- 서브쿼리로부터 여러 행이 반환되는 예제
-- 오류수정 : = -> in (다중행 비교연산자 사용해야함)
SELECT employee_id, last_name
 FROM employees
 WHERE salary in (SELECT MIN(salary)
                 FROM employees
                 GROUP BY department_id);
                 
SELECT last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
				FROM employees
                WHERE last_name = 'Haas');
                
-- 결과가 나오지 않는 이유? Haas 직원이 존재하지 않음
-- 서브쿼리가 메인으로 넘어갈때 null 값이 넘어감
-- 단일행 서브쿼리로부터 null 값이 반환된 경우 메인쿼리 결과도 null이다!

select last_name, job_id
from employees
where last_name = 'Lee';

-- 7-2. 다중행 서브쿼리
-- 서브쿼리로부터 메인쿼리로 여러 행(다중값)이 반환되는 유형
-- 메인쿼리에는 우변에 값리스트가 올 수 있는 다중행 비교연산자 사용해야함.
-- 다중행 비교연산자 : in=, OR), not in(<>, AND), any(OR), all(AND)
-- IN : (=, OR)
-- NOT IN : (<>, AND)
-- =any (=,or) == IN    -- =all (=,and)
-- >any (>,or)     -- >all (>,and)
-- >=any (>=,or)   -- >=all (>=,and)
-- <any  (<,or)    -- <all (<,and)
-- <=any (<=,or)   -- <=all(<=,and)
-- <>any (<>, or)  -- <>all(<>,and) == NOT IN

SELECT EMPLOYEE_ID, LAST_NAME, MANAGER_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID
					 FROM employees
                     WHERE EMPLOYEE_ID IN (174, 141))
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
					FROM EMPLOYEES
                    WHERE EMPLOYEE_ID IN (174, 141))
AND EMPLOYEE_ID NOT IN(174, 141);

