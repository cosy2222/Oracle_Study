-- 1번 문제 
select ename , e.dno , dname 
from employee e , department d
where e.dno = d.dno
and ename = 'SCOTT';

-- 2번 문제 
select ename , dname , loc
from employee e join department d
on e.dno = d.dno;

--4번 문제
select ename , dname , loc
from employee natural join department
where  commission is not null;

--5번 문제
select ename , dname
from employee e , department d
where e.dno = d.dno
and ename like '%A%';

--6번 문제
select ename , job , dno , dname , loc 
from employee e natural join department d
where loc = 'NEW YORK';






