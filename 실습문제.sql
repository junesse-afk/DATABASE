use hr;
SET foreign_key_checks=0;
create table student(
sno int primary key,
sname varchar(20) not null);

desc student;

create table course(
cno varchar(20) primary key,
cname varchar(20));

desc course;

create table enrol(
sno int,
cno varchar(20),
credit varchar(10),
primary key(sno, cno),
foreign key(sno) references student(sno),
foreign key(cno) references course(cno));

desc enrol;

insert into student
values(11002, "이홍근");

insert into student
values(24036, "김순미");

select sno, sname
from student;

insert into course
values("CS310", "데이터베이스");

insert into course
values("CS313", "운영체제");

insert into course
values("CS345", "자료구조");

select cno, cname
from course;

insert into enrol
values(11002, "CS310", "A0");

insert into enrol
values(11002, "CS313", "B+");

insert into enrol
values(24036, "CS345", "B0");

insert into enrol
values(24036, "CS310", "A+");

select sno, cno, credit
from enrol;

select *
from student;

select sno, sname
from student
where sname = '김순미';

select s.sno, s.sname, count(e.cno)
from student s right join enrol e
on s.sno = e.sno
where s.sname = "이홍근"
group by s.sno, s.sname;

select sname
from student;

select sname, cname
from course join student
where cname = "데이터베이스";

select c.cname, count(distinct e.sno)
from course c join enrol e
group by c.cname;

select s.sno, COUNT(e.cno)
from student s left join enrol e 
on s.sno = e.sno AND e.credit = 'A+'
GROUP BY s.sno;