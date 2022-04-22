-- sub Query : select �� ���� select���� �ִ� Query
    -- where ������ : sub query
    -- having ������ : sub query

select ename , salary 
from employee;

select ename , salary 
from employee 
where ename = 'SCOTT';

-- scott�� ���޺��� ������ ���ų� ���� ����ڸ� ��� 

select ename , salary from employee where salary >= 3000;  --�������� ���x

select ename , salary 
from employee 
where salary >= ( select salary from employee where ename = 'SCOTT'); -- �������� ���O

-- SCOTT �� ������ �μ��� �ٹ��ϴ� ����� ���
select ename , dno
from employee
where dno = (select dno from employee where ename = 'SCOTT');

--�ּ� �޿��� �޴� ����� �̸� , ������ , �޿� ��� �ϱ�
select ename , job , salary
from employee
where salary = (select min(salary) from employee);


-- 30�� �μ�(dno) ���� �ּ� ������ �޴� ������� ���� ����� �̸� , �μ���ȣ , ����
select ename , dno , salary
from employee
where salary > (select min(salary)  from employee where dno =30) and dno = 30;


-- having������ sub query ����ϱ�

-- 30�� �μ��� �ּҿ��޺���  �ּҿ����� ū �μ�
select dno , min(salary ) , count(dno)
from employee 
group by dno
having min(salary) > (select min(salary) from employee where dno=30);

-- ������ �������� : sub query �� ��� ���� �� �ϳ��� ��� 
            -- ������ �� ������ :  > , = , >= , < , <= , <> 
-- ������ ��������  : sub query �� ��� ���� ������ ���
            -- ������ �������� ������ : IN, ANY , SOME , ALL , EXISTS
                -- IN : ���� ������ �� ���� ( '=' �����ڷ� ���� ��� ) �� ���������� ������߿� 
                --     �ϳ��� ��ġ�ϸ� true
                
                -- ANY , SMOE : ���� ������ �� ������ ���������� �˻� ����� �ϳ��̻� ��ġ�ϸ� true 
                
                -- ALL : ���� ������ �� ������ ���� ������ �˻������ ��� ���� ��ġ�ϸ�  true
                
                -- EXISTS : ���������� �������� ���������� ����� �߿��� �����ϴ� ���� �ϳ��� �����ϸ�true 
                
                
-- IN ������ ����ϱ�

--�μ����� �ּ� ������ �޴� ����ڵ� ����ϱ� 

select ename , dno , salary
from employee
where salary in (950 , 800 , 1300);

select ename , dno , salary
from employee
where salary in (select min(salary) from employee group by dno);


-- ANY ������ ��� 
  -- ���������� ��ȯ�ϴ� ������ ���� ����
  -- ' < any ' �� �ִ밪 ���� ������ ��Ÿ��
  -- ' > any ' �� �ּҰ� ���� ŭ�� ������
  -- ' =any ' �� in�� ������ 
  
  -- ������ salaeman �� �ƴϸ鼭 �޿��� ������ salesman ���� ���� ����� ���
  select ename , job , salary
  from employee
  where salary < any (select salary from employee where job = 'SALESMAN')
                    and  job<> 'SALESMAN' ;
  
-- ALL ������ 
        -- sub query �� ��ȯ�ϴ� ��� ���� ��
        -- ' > ALL ' �ִ밪 ���� ŭ
        -- ' < ALL ' �ּҰ����� ����
        
-- ��) ������SALESMAN �� �ƴϸ鼭 ������ SALESMAN�� ������� �޿��� ���� ����� ��� ���
         
select ename , job , salary
from employee
where salary < ALL (select salary from employee where job = 'SALESMAN') and job <> 'SALESMAN';

select job from employee ;

-- �������� �м����� ������� �޿��� �����鼭 ������ �м����� �ƴ� ����� ���
select ename , job , salary
from employee
where salary < all (select salary from employee where job = 'ANALYST') and job <> 'ANALYST';

-- �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ�� �ϵ� ��� �޿��� ���ؼ� �������� ���� �Ͻÿ�
select eno , ename , salary
from employee
where salary >  (select avg(salary) from employee ) 
order by salary desc;












