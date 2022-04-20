-- 1�� ���� 
select ename ,substr(hiredate ,1,5) as �Ի�
from employee;


-- 2�� ����
select ename , hiredate 
from employee
where substr (hiredate ,4,2) = '04';


-- 3�� ����
select ename , manager
from employee
where not mod(manager , 2) = 0;

-- 3-1�� ����
select ename , salary
from employee
where mod (salary , 3) =0;

-- 4�� ����
select to_char(hiredate , 'yy mon dd dy' )
from employee;

--5�� ����
select trunc( sysdate - to_date('20220101' , 'yyyymmdd') )
from dual;

--5-1�� ����
select trunc( sysdate - to_date('19980129' , 'yyyymmdd') )
from dual;

--5-2�� ����
select trunc( months_between(sysdate , to_date('19980129','yyyymmdd')) )
from dual;

--6�� ����
select ename ,nvl2(manager ,manager , 0)
from employee;

--7�� ����
select ename ,job,salary, decode( job , 'ANALYST' , salary+200,
                             'SALESMAN' , salary+180,
                             'MANAGER' , salary+150,
                             'CLERK'   , salary+100
                             ,salary
                             ) "�λ�� �޿�"
from employee;                             




