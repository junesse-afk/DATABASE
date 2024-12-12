-- [SQL문법] 9. 데이터정의어(DDL) - TABLE
use hr;

-- 데이터정의어(DDL)란?
-- 객체(Object - table, view, index, function 등등)를 생성/수정/삭제하는 명령어
-- TABLE 관련 DDL : create table, alter table,
--                 drop table, truncate table

-- 9-1. 테이블 생성(create table)
-- 요구사항 정의서 -> 필요한 자료 종합 -> 테이블 설계서(컬럼 구성) -> 화면 설계서
-- [문법] create table 테이블명
--       (컬럼명1 데이터타입(컬럼사이즈),
--        컬럼명2 데이터타입(컬럼사이즈) [제약조건],
--        컬럼명3 데이터타입(컬람사이즈) [default 기본값],
--        컬럼명n 데이터타입(컬럼사이즈));
--        테이블명, 컬럼명은 _, #, $ 이정도만 특수문자허용

-- (1) 데이터타입
-- 문자    - 고정형 : char | 가변형 : varchar
--     a char(10 [byte]) | b varchar(10 [byte])
-- 자리 xyz -> xyz0000000 | xyz -> xyz
-- 장점 [성능 좋음]         | 공간효율이 좋음
-- 단점 공간 효율이 안좋음    | 몇 바이트인지 확인 후 공간 확보 순으로 진행 [성능 떨어짐]

-- 숫자 - 정수형 : int, bigint | 실수형 : float, double
-- 날짜 - 년/월/일 : date      | 년/월/일/시/분/초 : datetime

create table dept(
deptno int,
dname varchar(14),
loc varchar(13),
create_date datetime default now());

desc dept; -- 테이블 생성 후 구조 확인 필수

insert into dept
values (1, "홍길동", "A100", "2024-12-12 15:00:00");

-- 자동으로 default값 삽입하는 방법
insert into dept(deptno, dname)
values (2, "이순신");

-- 수동으로 default값 삽입하는 방법
insert into dept
values (3, "강감찬", "C100", default);

-- default값이 없으면 default 넣을때 null값으로 삽입됨
insert into dept
values (4, "을지문덕", default, default);

select *
from dept;

-- (2) 제약조건
-- 테이블의 특정 컬럼에 부적합한 데이터가 삽입/수정/삭제되는 것을 막아주는 역할
-- 제약조건 종류 : not null, unique, primary key, foreign key, check

-- [not null] 제약조건
-- 컬럼에 null 값이 삽입/수정되는 것을 막아주는 제약조건
-- 필수 컬럼에 선언함

create table test1 (
id int not null,
name varchar(30) not null,
jumin varchar(13) not null,
job varchar(20),
email varchar(20),
phone varchar(20) not null,
start_date date );

desc test1;

-- [unique] 제약조건
-- 컬럼에 중복된 데이터가 삽입/수정되는 것을 막아주는 제약조건
-- 고유값(주민번호, 전화번호, 이메일 등)이 들어와야 하는 컬럼에 선언함.

-- 컬럼 레벨 문법
CREATE TABLE test2 (
id int not null unique,
name varchar(30) not null,
jumin varchar(13) not null unique,
job varchar(20),
email varchar(20) unique,
phone varchar(20) not null unique,
start_date date );

-- 테이블명 레벨 문법 (컬럼명 레벨 문법을 많이 쓰긴함)
-- foreign key는 테이블명 레벨 문법을 많이 씀
CREATE TABLE test3 (
id int not null unique,
name varchar(30) not null,
jumin varchar(13) not null unique,
job varchar(20),
email varchar(20) unique,
phone varchar(20) not null unique,
start_date date,
unique(id),
unique(jumin),
unique(phone));

desc test2;

-- [primary key] 제약조건
-- 기본키 제약조건으로 not null과 unique의 성격을 모두 가지는 제약조건
-- pk 제약조건이 선언된 칼럼에는 null값도 안되고, 중복값도 안됨.
-- 단, 테이블당 한번만 선언 가능함.
-- 보안때문에 id번호 등으로 pk를 줌

create table test4 (
id int primary key,
name varchar(30) not null,
jumin varchar(13) not null unique,
job varchar(20),
email varchar(20) unique,
phone varchar(20) not null unique,
start_date date );

desc test4;

-- [foreign key] 제약조건
-- 외래키 제약조건으로 자기 자신 테이블이나 다른 테이블의 특정 컬럼(pk, uk)을 참조하는 제약조건
-- foregin key가 걸려져 있는 곳이 자식 컬럼 반대는 부모 컬럼(pk, uk)
-- 자식 컬럼에는 부모 컬럼의 값 중 하나만 삽입/수정될 수 있는 제약조건

CREATE TABLE test5 (
t_num int primary key,
t_id int, -- fk 컬럼 레벨 선언할때는 > references test2(id) <
title varchar(20) not null,
story varchar(100) not null,
foreign key(t_id) references test2(id));

desc test5;

-- [check] 제약조건
-- 해당 컬럼이 만족해야하는 조건문을 자유롭게 지정할 수 있는 제약조건
-- (예1) salary int check(salary > 0)
-- (예2) junmin char(13) check(length(jumim)=13)
-- (예3) grade int check(grade between 1 and 4)

create table test6 (
id int(10) primary key,
name varchar(30) not null,
jumin varchar(13) not null unique check(length(jumin)=13),
job varchar(20),
email varchar(20) unique,
phone varchar(20) not null unique,
start_date date check(start_date >= '2005-01-01'));

desc test6;

-- (3) DB사전을 사용해서 TABLE의 제약 정보 조회하기

show databases;
-- DB 사전으로 전환하기
use information_schema;

-- DB 사전 목록 확인하기
show tables;

-- table_constraints 조회하기
select *
from table_constraints
where table_name = 'test6';

-- check_constraints 조회하기
select *
from check_constraints;

-- key_column_usage 조회하기
select *
from key_column_usage
where table_name = 'employees';



