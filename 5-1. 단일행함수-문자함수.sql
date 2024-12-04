-- [ SQL 문법 ] 5.1 단일행함수 - 문자함수
use hr;

-- 함수란?
-- 인수를 받아서 정해진 조작을 한 후 반드시 하나의 값을 반환함.
-- SQL함수 유형 : 단일행함수, 다중행함수(=그룹함수)

-- 단일행함수 : 행 당 하나의 결과값을 반환함.
-- 단일행함수 유형 : 문자함수, 숫자함수, 날짜함수,
--               변환함수, 제어흐름함수, 시스템정보함수

-- 문자함수
-- ascii(문자) : 문자의 아스키코드값을 반환함. 
-- char(숫자) : 숫자(아스키코드값)에 해당되는 문자를 반환함.

select ascii('A'), ascii('a'), char(66)
from dual; 
-- 단순 계산할 때 불러올 테이블이 없기에 DBMS에서 지원하는 dual씀
-- MY SQL에서만 select ascii('A'), ascii('a'); 해도 출력 가능
-- 출력결과가 BLOB 뜨는 건 워크벤치 버그임 > Open Value in Viewer로 확인

-- length(문자열) : 문자열에 byte수를 반환함.
-- bit_length(문자열) : 문자열의 bit수를 반환함.
-- char_length(문자열) : 문자열의 문자의 개수를 반환해주는 함수

select employee_id, last_name, length(last_name) as "byte수",
	   bit_length(last_name) as "bit수",
       char_length(last_name) as "문자의 개수"
from employees;

select length('아이티윌'), bit_length('아이티윌'), char_length('아이티윌');

-- concat(인수1, 인수2, ..., 인수n) : n개의 인수를 연결해서 반환함.
-- concat_ws(구분자, 인수1, ..., 인수n) : 구분자와 함께 n개의 인수를 연결해서 반환함. 

select employee_id, concat(first_name, last_name) as "이름",
	   job_id, email
from employees;

select employee_id, concat_ws('--', last_name, job_id, email, salary, department_id) as emp_info
from employees;

-- instr(문자열, 특정문자) : 문자열로부터 특정 문자의 "첫번째 위치값"을 반환함.

select employee_id, last_name, instr(last_name, 'a')
from employees;

-- upper(문자열) : 문자열을 대문자로 변환해 주는 함수
-- lower(문자열) : 문자열을 소문자로 변환해 주는 함수

select employee_id, upper(last_name) as "대문자", lower(email) as "소문자"
from employees;

-- left(문자열, 반환할 문자 숫자) : 문자열의 왼쪽에서부터 숫자만큼 반환함.
-- right(문자열, 숫자) : 문자열의 오른쪽에서부터 숫자만큼 반환함.
-- substr(문자열, 시작위치, 숫자) : 문자열을 시작부터 숫자만큼 반환함.

select first_name, left(first_name, 5), last_name, right(last_name, 2), salary, substr(salary, 1, 3)
from employees;

-- lpad(문자열, 전체자리수, 채울문자) : 문자열을 전체 자리수만큼 늘려서 출력하되
--                              남는 공간이 있다면 채울 문자로 채워주는 함수
--                              오른쪽 정렬할때 주로 사용됨.
-- rpad(문자열, 전체자리수, 채울문자) : 문자열을 전체 자리수만큼 늘려서 출력하되
--                              남는 공간이 있다면 채울 문자로 채워주는 함수
--                              왼쪽 정렬할때 주로 사용됨

select lpad(last_name, 20, '_') as "L-name", rpad(first_name, 20, '_') as "F-name"
from employees;

-- ltrim(문자열) : 문자열의 왼쪽 공백을 제거함.
-- rtrim(문자열) : 문자열의 오른쪽 공백을 제거함.
-- trim(문자열) : 문자열의 앞/뒤 공백을 제거함.
-- trim(방향 특정문자 from 문자열) : 방향 - leading(앞), trailing(뒤), both(양쪽)
--                             문자열로부터 특정문자가 해당 방향에 있으면 제거함.
select ltrim('       SQL   문법    '), rtrim('       SQL   문법    '), trim('       SQL   문법    ');

select trim(both '_' from '__SQL_문법___');

select trim(trailing '0' from salary)
from employees;

-- replace(문자열, 특정문자, 다른문자) : 문자열에서 특정문자를 다른문자로 교체해주는 함수

select employee_id, last_name, email, replace(phone_number, ".", "-") as phone
from employees;

-- space(길이) : 길이만큼 공백을 반환함.
select concat('MySQL', space(10), 'DBMS');

-- <연습문제 1>
select last_name, char_length(last_name) as length
from employees
where last_name like 'j%'
or last_name like 'a%'
or last_name like'm%'
order by last_name;

select last_name as "Name", length(last_name) as "Length"
from employees
where substr(last_name, 1, 1) in ('j', 'm', 'a')
order by last_name;

select last_name as "Name", length(last_name) as "Length"
from employees
where left(last_name, 1) in ('j', 'm', 'a')
order by last_name;

-- <연습문제 2>
select last_name as LAST_NAME, lpad(salary, 15, '$') as SALARY
from employees;

select substr("대한민국만세", 3, 2);
