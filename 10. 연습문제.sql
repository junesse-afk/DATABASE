use hr;

-- 연습문제 1번
select COUNT(last_name) as 'COUNT(*)'
  from employees
 where last_name like '%n';
 
 -- 연습문제 2번
 select d.department_id, d.department_name, d.location_id, COUNT(e.employee_id) as 'COUNT(E.EMPLOYEE_ID)'
 from departments d left join employees e
 on d.department_id = e.department_id
 group by d.department_id, d.department_name, d.location_id;
 
 -- 연습문제 3번
 select last_name, hire_date
 from employees
 where day(hire_date) < 16;
 
 create table stu (
 stu_no varchar(10) not null primary key,
 stu_name varchar(20) not null);
 
 create table grades (
 stu_no varchar(10) null,
 subject varchar(10) null,
 score int null);
 
insert into stu
values ('A0001', '홍길동');

insert into stu
values ('A0002', '이소니');

insert into stu
values ('A0003', '김사라');

select *
from stu;

insert into grades
values ('A0001', '국어', 84);

insert into grades
values ('A0001', '수학', 91);

insert into grades
values ('A0003', '국어', 72);

insert into grades
values ('A0003', '수학', 82);

select *
from grades;

select s.stu_no as '학번', s.stu_name as '이름', g.subject as '과목', g.score as '성적'
from stu s left join grades g
on s.stu_no = g.stu_no
order by s.stu_no;

select s.stu_no as '학번', s.stu_name as '이름', g.subject as '과목', g.score as '성적'
from stu s join grades g
on s.stu_no = g.stu_no
where g.score > 80 and g.subject like '국어';

select s.stu_no as '학번', s.stu_name as '이름', g.subject as '과목', g.score as '성적'
from stu s left join grades g
on s.stu_no = g.stu_no
where g.subject is null;
                            
select stu_no as '학번', stu_name as '이름'
from stu
where stu_no not in (select stu_no
				       from grades);

select subject as '과목', truncate(avg(score),0) as '평균'-- avg() 이미 그룹함수라서 밑에 넣을 필요없음
from grades
group by subject; -- 그룹함수가 아닌 것들을 그룹바이절에 넣어야한다.