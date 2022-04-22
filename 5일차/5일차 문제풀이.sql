-- 7�� ���� 
select e.eno �����ȣ , e.ename ����̸� , e.manager "������ ��ȣ" , m.ename "������ �̸�" 
from employee e  , employee m 
where e.manager = m.eno;

-- 8�� ����
select e.eno, e.ename , m.ename
from employee e , employee m
where e.manager = m.eno(+)
order by eno ;

-- 9�� ����
select e.ename �̸� , e.dno �μ���ȣ , m.ename ����
from employee e , employee m 
where e.ename = 'SCOTT' and e.dno = m.dno;

-- 10�� ����
select m.ename , m.hiredate
from employee e , employee m
where e.ename = 'WARD' and e.hiredate < m.hiredate;

-- 11�� ���� 
select e.ename ����� , e.hiredate ����Ի��� , m.ename �������̸� , m.hiredate �������Ի���
from employee e , employee m 
where e.manager = m.eno and e.hiredate < m.hiredate ;



--   subquery ���� 

-- 1�� ���� 
select ename , job
from employee  
where job = (select job from employee where eno = '7788') ;
                
-- 2�� ����
select ename , job , salary
from employee 
where salary > (select salary from employee where eno = '7499');

-- 3�� ����
select ename  , job , salary
from employee 
where salary in (select min(salary) from employee group by job);

--4�� ���� 
select ename , job , salary ���� 
from employee
where salary in (select min(salary) from employee group by job);

-- 5�� ���� 
select ename , salary , dno 
from employee
where salary in (select min(salary) from employee group by dno);

-- 6�� ����
select eno , ename , job , salary
from employee
where salary < all ( select salary from employee where job = 'ANALYST') and job <> 'ANALYST';

-- 7�� ����
select ename 
from employee 
where not eno in (select manager from employee where manager is not null);

-- 8�� ����
select ename
from employee
where eno in ( select manager from employee );

-- 9�� ���� 
select ename , hiredate
from employee
where dno = (select dno from employee where ename = 'BLAKE');

--10�� ����
select ename , salary
from employee
where salary > (select avg(salary) from employee )
order by salary ;

-- 11�� ����
select eno , ename , dno
from employee
where dno in (select dno from employee  where ename like '%K%');

-- 12�� ����
select ename , e.dno ,job , loc
from employee e, department d
where e.dno = d.dno and loc = (select loc from department where loc = 'DALLAS');

-- 13�� ���� 
select ename , salary
from employee
where manager = ( select eno from employee where ename = 'KING');



-- 14�� ����
select dno , ename , job
from employee 
where eno in ( select eno  
               from employee natural join department 
               where dname = 'RESEARCH');

-- 15�� ����
select eno , ename , salary
from employee
where salary > (select avg(salary) from employee ) 
        and dno in (select dno from employee where ename like '%M%');

-- 16�� ����
select job 
from employee 
group by job
having avg(salary) = ( select min(avg(salary)) from employee group by job);

-- 17�� ����
select ename
from employee
where dno in ( select dno from employee where job = 'MANAGER');




