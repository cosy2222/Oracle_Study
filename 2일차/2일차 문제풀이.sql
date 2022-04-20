-- 1번 문제 
select ename , salary , salary+300 인상된급여
from employee;

-- 2번 문제
select ename , salary , (salary*12)+100
from employee
order by (salary*12)+100 desc;

--3번 문제
select ename , salary
from employee
where salary > 2000 
order by salary desc;

--4번 문제
select ename , dno
from employee
where eno = 7788;

--5번 문제
select ename , salary
from employee
where not salary between 2000 and 3000;

--6번 문제
select ename , job , hiredate
from employee
where hiredate BETWEEN '81/02/20' and '81/05/01';

--7번 문제
select ename  , dno
from employee
where dno in (20,30)
order by ename desc;

--8번 문제
select ename salary , dno
from employee
where salary BETWEEN 2000 AND 3000 and dno in (20,30)
order by ename;

--9번 문제
select ename , hiredate
from employee
where hiredate like '81%';

--10번 문제
select ename , job
from employee
where  manager is null;

--11번 문제
select ename , salary , commission
from employee
where not commission is null
order by salary desc, commission desc;

-- 12번 문제
select ename 
from employee
where ename like '__R%';

--13번 문제
select ename
from employee
where ename like '%A%' and ename like '%E%';

--14번 문제
select ename ,job , salary
from employee
where job = 'CLERK' and not salary in (1600,950,1300)
      or job = 'SALESMAN' and not salary in (1600,950,1300);
      
-- 15번 문제 
select ename , salary , commission
from employee
where commission >= 500;


