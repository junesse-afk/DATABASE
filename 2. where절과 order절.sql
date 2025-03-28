-- [SQL문법] 2. where절과 order by절

use hr;

-- 2-1. where절(조건절)
-- [문법] select * : 전체컬럼 | 특정 컬럼 : 컬럼명1, 컬럼명2, 컬럼명3
-- from 테이블명;
-- where 좌변(컬럼명) =(비교연산자) 우변(값)-숫자, '문자', '날짜(년-월-일)';

-- 90번 부서에 소속된 사원들을 출력하시오.
select employee_id, last_name, salary, department_id
from employees
where DEPARTMENT_ID = 90;

-- last_name이 whalen인 사원 출력하시오.
select last_name
from employees
where last_name = 'whalen';

-- 입사일이 1996년 2월 17일인 사원을 출력하시오.
select last_name
from employees
where HIRE_DATE = '1996-02-17';

-- [비교연산자]
-- 단일행 비교연산자 : =, >, >=, <, <=, <>, !=
-- 추가 비교연산자 : between, in, like, is null
-- [비교연산자1] between A and B
-- A(하한값 이상 B(상한값) 이하의 값을 비교해 주는 연산자로 범위 검색 시 활용됨.

select employee_id, last_name, salary, job_id
from employees
where salary between 2500 and 3500;

select employee_id, last_name, hire_date, department_id
from employees
where hire_date between '1996-01-01' and '1997-12-31';

select employee_id, last_name, department_id
from employees
where last_name between 'abel' and 'dehaan';

-- [비교연산자2] in
-- 우변에 값리스트가 올 수 있는 다중행 비교연산자
-- 우변에 있는 값리스트와 비교해서 하나이상 동일하면 만족이 되는 연산자
-- (=, or)의 성격을 내포하고 있음

select employee_id, last_name, job_id, department_id
from employees
where DEPARTMENT_ID in (20, 50, 100);

select employee_id, last_name, job_id
from employees
where job_id in ('ad_vp', 'sa_rep');

select employee_id, last_name, hire_date, salary
from employees
where hire_date in ('1996-02-17', '1999-09-20');

select employee_id, last_name, job_id, department_id
from employees
where DEPARTMENT_ID = 20
or last_name = 'abel';

-- [비교연산자3] like
-- 패턴 일치여부를 비교해 주는 연산자
-- like 연산자와 함께 사용되는 기호
-- 1) % : 0개 또는 여러 개의 문자가 올 수 있음
-- 2) _ : 반드시 1개의 문자가 와야함.
-- a로 시작되는 문자열 : 'a%'
-- a가 포함된 문자열 : '%a%'
-- a로 끝나는 문자열 : '%a'
-- 두번째 문자가 a인 문자열 : '_a%'
-- 끝에서 세번째 문자가 a인 문자열 : '%a__'

-- last_name이 'a'로 시작되는 사원들을 출력하시오.

select *
from employees
where last_name like 'a%';

-- last_name이 'a'로 시작해서 'n'으로 끝나는 사원들 출력하시오.
select *
from employees
where last_name like 'a%n';

-- 1996년에 입사한 사원들 출력하시오.
select *
from employees
where hire_date like '1996-01%';

-- [비교연산자4] is null
-- 값이 null인지를 비교해 주는 연산자
-- 커미션을 받지 않는 사원들 출력하시오

select *
from employees
where commission_pct is null
or last_name like 'a%';

-- 부서가 없는 신입사원의 정보를 출력하시오.

select *
from employees
where department_id is null;

-- 매니저가 없는 사장의 정보를 출력하시오.

select *
from employees
where MANAGER_ID is null;

-- [논리연산자]
-- 논리연산자 종류 : and, or, not
-- where절에 여러 조건문 작성 시 and, or로 나열해야함.
--
select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
and job_id like '%man%';

-- where절에 and, or가 함께 사용된 예제
-- 우선순위 : and (높) >> o(낮)
-- 우선 순위를 지정하고자 할 경우 괄호를 사용해야함.

select employee_id, last_name, salary, department_id
from employees
where (department_id = 80
or department_id = 30)
and salary >= 10000;

-- (==)
select employee_id, last_name, salary, department_id
from employees
where department_id in (80, 30)
and salary >= 10000;


-- [논리연산자3] not
-- 비교연산자와 조합으로 활용 시 반대의미의 비교연산자로 활용 가능함.
-- 비교연산자 정리
-- = <->  > !=
-- >, >= > <= <
--

select employee_id, last_name, salary
from employees
where salary not between 5000 and 20000;

select employee_id, last_name, job_id
from employees
where job_id not in ('sa_rep', 'it_prog', 'st_man');

-- 2-2. order by절(정렬)
-- [문법] select * | 컬럼1, 컬럼2, 컬럼3
-- 		from 테이블명
-- 		[where 조건문]
-- 		[order by 컬럼명 [asc(오름차순) | desc(내림차순)]] | 생략하면 오름차순
-- 컬럼 사용시
select last_name, job_id, department_id, hire_date
from employees
order by hire_date desc;
-- 엘리아스 사용
select EMPLOYEE_ID, LAST_NAME, salary*12 annsal
from employees
order by salary*12;
-- (==)
select EMPLOYEE_ID, LAST_NAME, salary*12 annsal
from employees
order by annsal;
-- 정렬 시 위치표기법 사용 예제
select last_name, job_id, department_id, hire_date
from employees
order by 3 desc;

-- 여러 컬럼을 기준으로 정렬하는 예제
select employee_id, last_name, department_id, salary
from employees
order by department_id, salary desc;


-- 연습문제

select last_name, hire_date
from employees
where hire_date between '2000-01-01' and '2000-12-31';

select last_name, hire_date
from employees
where hire_date like '2000%';

select last_name, salary, commission_pct
from employees
where COMMISSION_PCT is null
order by salary desc;

