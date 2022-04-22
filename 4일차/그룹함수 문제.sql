-- 1번 문제
select  max (salary) 최고액 , min(salary) 최저액 , sum (salary) 총액 , round(avg(salary)) 평균
from employee;

-- 2번 문제
select job, max (salary) 최고액 , min(salary) 최저액 , sum (salary) 총액 , round(avg(salary)) 평균
from employee
group by job;

select job, max (salary) 최고액 , min(salary) 최저액 , sum (salary) 총액 , round(avg(salary)) 평균
from employee
group by rollup(job);

--3번 문제 
select job , count(*)
from employee
group by job;



-- 4번 문제 
select manager, count(*) 관리자수
from employee
where not manager is null
group by manager;


--5번 문제
select max(salary) - min(salary) DIFFERENCE
from employee;

--6번 문제
select job , min(salary)  최저급여
from employee
where not manager is null
group by job 
having  min(salary) >=2000
order by min(salary) desc;

--7번 문제
select dno 부서번호 ,count(dno) 사원수 , round(avg(salary) ,1)
from employee
group by dno;

--8번 문제
select decode (dno , 10 , 'SALES'
                   , 20 , 'RESERCH'
                   , 30 , 'ACCOUNTING' ) as dname ,
                   
        decode (dno , 10 , 'CHICAGO'
                    , 20 , 'DALLS'
                    , 30 , 'NEW YORK' ) as location ,            
       
        count(dno) as "Number of People" , round(avg(salary)) as Salary
                   
from employee
group by dno;









