use hr;

desc my_employee;

select *
from my_employee;
-- 트랜잭션 시작
-- 3. insert 삽입하기
insert into my_employee
values (1, "Patel", "Ralph", "rpatel", 895), (2, "Dancs", "Betty", "bdancs", 860),
 (3, "Biri", "Ben", "bbiri", 1100), (4, "Newman", "Chad", "cnewman", 750);
-- 4. select 추가한 내용 확인
select *
from my_employee;
-- 5. commit(저장)
commit;
-- 트랜잭션 종료
-- 트랜잭션 시작
-- 6. update
update my_employee
set  last_name = "Drexler"
where id = 3;
-- 7. update
update my_employee
set salary = 1000
where salary < 900;
-- 8. select(미리보기)
select *
from my_employee;
-- 9. delete
delete from my_employee
where last_name = "Dancs" and first_name = "Betty";
-- 10. select
select *
from my_employee;
-- 11. commit (저장)
commit;
-- 트랜잭션 시작
-- 12. insert
insert into my_employee
values (5, "Ropeburn", "Audrey", "aropebur", 1550);
-- 13. select
select *
from my_employee;
-- 14. savepoint
savepoint tt;
-- 15. delete
delete from my_employee;
-- 16. select
select *
from my_employee;
-- 17. rollback to
rollback to tt;
-- 18. select
select *
from my_employee;
-- 19. commit
commit;