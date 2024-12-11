-- [SQL문법] 8. 데이터조작어(DML)
use hr;

-- 데이터조작어(DML)란?
-- 테이블에 데이터를 삽입/수정/삭제하는 명령어
-- DML종류 : insert, update, delete

-- 8-1. 데이터삽입(insert)
-- [문법] insert into 테이블명 [(칼럼1, 칼럼2, 칼럼3, ...)]
--              values(값1, 값2, 값3, ...);
-- 테이블명 뒤에 컬럼 쓸경우 값도 동일하게 써줘야 함 컬럼없을 경우 values 뒤에서 기본 컬럼 순서대로 작성
insert into departments
value(280, 'JAVA', 107, 1700);

select *
from departments
order by department_id desc;

-- 테이블명 뒤에 컬럼리스트 작성 시에는 values절 뒤의 값리스트와 동일해야함
insert into departments (department_name, location_id, manager_id, department_id)
values ('JSP', 1700, 108, 290);

select *
from departments
order by department_id desc;

-- null값을 자동으로(암시적) 삽입하는 방법
insert into departments (department_id, department_name)
values (300, 'MYSQL');

select *
from departments
order by department_id desc;

-- null값을 수동으로(명시적) 삽입하는 방법
insert into departments
values (310, 'ORACLE', null, null);

select *
from departments
order by department_id desc;

-- 다중행 삽입하기
insert into departments
values (320, 'HTML', null, 1700), (330, 'CSS', 200, null);

select *
from departments
order by department_id desc;

-- insert + 서브쿼리 예제
-- 다른 테이블로부터 데이터를 복사해서 삽입하는 작업을 의미함.
-- copy_emp 테이블 생성하기(employees 테이블과 동일 구조를 가져야함.)

create table copy_emp
select *
from employees
where 1=2;

desc copy_emp;
select *
from copy_emp;

-- copy_emp 테이블에 employees 테이블에 있는 107명의 사원 정보 동일하게 삽입하기
insert into copy_emp
select *
from employees;

desc copy_emp;
desc employees;

select *
from copy_emp;