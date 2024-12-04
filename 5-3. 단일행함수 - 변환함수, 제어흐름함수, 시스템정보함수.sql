use hr;

-- [SQL문법] 5-3. 단일행함수 - 변환함수, 제어흐름함수, 시스템정보함수

-- (1) 변환함수
-- date_format(날짜, 형식) : 날짜를 형식에 맞게 출력하는 함수
select employee_id, last_name,
		date_format(hire_date, '%y-%c-%e %W') as "입사일"
from employees;

-- cast(값 as 데이터타입) : 값을 지정된 데이터타입으로 변환하는 함수
select cast('123' as signed);
select cast('2022@03@18' as date);

-- (2) 제어함수
-- if(조건문, 참일때 값, 거짓일떄 값) : 조건문이 참일때 두번째 인수,
--								거짓일때 세번째 인수를 반환함
select employee_id, last_name, salary,
		if(salary > 10000, '1등급', '2등급') as "급여 등급"
from employees;

-- ifnull(인수1, 인수2) : 인수1이 null이 아니면 인수1이 반환되고,
--                      인수1이 null이면 인수2가 반환됨.
--                      null값을 실제값으로 변환해 주는 함수

select employee_id, last_name, salary, commission_pct, 
		(12*salary)+(12*salary*ifnull(commission_pct, 0)) as "ann_sal"
 from employees;
 
 -- nullif(인수1, 인수2) : 인수1과 인수2가 같으면 null을 반환되고,
 --                     인수1과 인수2가 다르면 인수1을 반환함.
 
select nullif(100, 100) as "결과1", nullif(100, 200) as "결과2";
 
select employee_id, first_name, last_name, 
      nullif(length(first_name), length(last_name)) as "결과"
 from employees;
 
 -- case식 : SQL구문에 if-then-else의 논리를 적용할 수 있는 연산자
 -- [문법] case 비교값 when 값1 then 결과1
 --                 [when 값2 then 결과2
 --                 when 값3 then 결과3
 --                 else 기본값]
 --       end
 
select employee_id, last_name, department_id,
		case department_id when 10 then '부서 10'
						   when 50 then '부서 50'
                           when 100 then '부서 100'
                           when 150 then '부서 150'
                           when 200 then '부서 200'
                           else '기타부서'
		end as "부서 정보"
from employees;

-- (3) 시스템 정보 함수
-- user() = current_user() = session_user() : 현재 사용자 정보를 반환하는 함수
select user(), current_user(), session_user();

-- database() = schema() : 현재 데이터베이스 또는 스키마 정보를 반환하는 함수
select database(), schema();

-- version() : 현재 MySQL 버전을 반환하는 함수
select version();

-- <연습문제>

-- 예제1
select last_name, ifnull(commission_pct, 'No Comission') as "COMM"
from employees;

-- 예제2
select job_id,
	case job_id when 'AD_PRES' then 'A'
				when 'ST_MAN' then 'B'
				when 'IT_PROG' then 'C'
                when 'SA_REP' then 'D'
                when 'ST_CLERK' then 'E'
                else '0'
end as "GRADE"
from employees;