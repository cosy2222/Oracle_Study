-- 1�� ����
select  max (salary) �ְ�� , min(salary) ������ , sum (salary) �Ѿ� , round(avg(salary)) ���
from employee;

-- 2�� ����
select job, max (salary) �ְ�� , min(salary) ������ , sum (salary) �Ѿ� , round(avg(salary)) ���
from employee
group by job;

select job, max (salary) �ְ�� , min(salary) ������ , sum (salary) �Ѿ� , round(avg(salary)) ���
from employee
group by rollup(job);

--3�� ���� 
select job , count(*)
from employee
group by job;



-- 4�� ���� 
select manager, count(*) �����ڼ�
from employee
where not manager is null
group by manager;


--5�� ����
select max(salary) - min(salary) DIFFERENCE
from employee;

--6�� ����
select job , min(salary)  �����޿�
from employee
where not manager is null
group by job 
having  min(salary) >=2000
order by min(salary) desc;

--7�� ����
select dno �μ���ȣ ,count(dno) ����� , round(avg(salary) ,1)
from employee
group by dno;

--8�� ����
select decode (dno , 10 , 'SALES'
                   , 20 , 'RESERCH'
                   , 30 , 'ACCOUNTING' ) as dname ,
                   
        decode (dno , 10 , 'CHICAGO'
                    , 20 , 'DALLS'
                    , 30 , 'NEW YORK' ) as location ,            
       
        count(dno) as "Number of People" , round(avg(salary)) as Salary
                   
from employee
group by dno;









