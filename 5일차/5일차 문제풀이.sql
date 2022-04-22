-- 7번 문제 
select e.eno 사원번호 , e.ename 사원이름 , e.manager "관리자 번호" , m.ename "관리자 이름" 
from employee e  , employee m 
where e.manager = m.eno;

-- 8번 문제
select e.eno, e.ename , m.ename
from employee e , employee m
where e.manager = m.eno(+)
order by eno ;

-- 9번 문제
select e.ename 이름 , e.dno 부서번호 , m.ename 동료
from employee e , employee m 
where e.ename = 'SCOTT' and e.dno = m.dno;

-- 10번 문제
select m.ename , m.hiredate
from employee e , employee m
where e.ename = 'WARD' and e.hiredate < m.hiredate;

-- 11번 문제 
select e.ename 사원명 , e.hiredate 사원입사일 , m.ename 관리자이름 , m.hiredate 관리자입사일
from employee e , employee m 
where e.manager = m.eno and e.hiredate < m.hiredate ;



--   subquery 문제 

-- 1번 문제 
select ename , job
from employee  
where job = (select job from employee where eno = '7788') ;
                
-- 2번 문제
select ename , job , salary
from employee 
where salary > (select salary from employee where eno = '7499');

-- 3번 문제
select ename  , job , salary
from employee 
where salary in (select min(salary) from employee group by job);

--4번 문제 
select ename , job , salary 월급 
from employee
where salary in (select min(salary) from employee group by job);

-- 5번 문제 
select ename , salary , dno 
from employee
where salary in (select min(salary) from employee group by dno);

-- 6번 문제
select eno , ename , job , salary
from employee
where salary < all ( select salary from employee where job = 'ANALYST') and job <> 'ANALYST';

-- 7번 문제
select ename 
from employee 
where not eno in (select manager from employee where manager is not null);

-- 8번 문제
select ename
from employee
where eno in ( select manager from employee );

-- 9번 문제 
select ename , hiredate
from employee
where dno = (select dno from employee where ename = 'BLAKE');

--10번 문제
select ename , salary
from employee
where salary > (select avg(salary) from employee )
order by salary ;

-- 11번 문제
select eno , ename , dno
from employee
where dno in (select dno from employee  where ename like '%K%');

-- 12번 문제
select ename , e.dno ,job , loc
from employee e, department d
where e.dno = d.dno and loc = (select loc from department where loc = 'DALLAS');

-- 13번 문제 
select ename , salary
from employee
where manager = ( select eno from employee where ename = 'KING');



-- 14번 문제
select dno , ename , job
from employee 
where eno in ( select eno  
               from employee natural join department 
               where dname = 'RESEARCH');

-- 15번 문제
select eno , ename , salary
from employee
where salary > (select avg(salary) from employee ) 
        and dno in (select dno from employee where ename like '%M%');

-- 16번 문제
select job 
from employee 
group by job
having avg(salary) = ( select min(avg(salary)) from employee group by job);

-- 17번 문제
select ename
from employee
where dno in ( select dno from employee where job = 'MANAGER');




