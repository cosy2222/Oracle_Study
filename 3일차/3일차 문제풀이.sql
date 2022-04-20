-- 1번 문제 
select ename ,substr(hiredate ,1,5) as 입사
from employee;


-- 2번 문제
select ename , hiredate 
from employee
where substr (hiredate ,4,2) = '04';


-- 3번 문제
select ename , manager
from employee
where not mod(manager , 2) = 0;

-- 3-1번 문제
select ename , salary
from employee
where mod (salary , 3) =0;

-- 4번 문제
select to_char(hiredate , 'yy mon dd dy' )
from employee;

--5번 문제
select trunc( sysdate - to_date('20220101' , 'yyyymmdd') )
from dual;

--5-1번 문제
select trunc( sysdate - to_date('19980129' , 'yyyymmdd') )
from dual;

--5-2번 문제
select trunc( months_between(sysdate , to_date('19980129','yyyymmdd')) )
from dual;

--6번 문제
select ename ,nvl2(manager ,manager , 0)
from employee;

--7번 문제
select ename ,job,salary, decode( job , 'ANALYST' , salary+200,
                             'SALESMAN' , salary+180,
                             'MANAGER' , salary+150,
                             'CLERK'   , salary+100
                             ,salary
                             ) "인상된 급여"
from employee;                             




