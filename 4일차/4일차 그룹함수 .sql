-- 4���� 
/*
    �׷� �Լ� : ������ �������ؼ� �׷����ؼ� ó���ϴ� �Լ�
        group by ���� Ư¡ �÷��� ���� �� ��� , �ش� �÷��� ������ ������ �׷����ؼ� ������ ����
        
    �����Լ� : 
        - SUM : �׷��� �հ�
        - AVG : �׷��� ���
        - MAX : �׷��� �ִ밪
        - MIN : �׷��� �ּҰ�
        - COUNT : �׷��� �� ���� ( ���ڵ�� , �ο��) 
*/

select sum (salary) , avg(salary) , max (salary ) , min (salary) 
from employee;

-- !���� : �����Լ��� ó���ҋ� , ����÷��� ���ϰ����� ������ �÷��� ����
select sum(salary) , ename
from employee;


-- �����Լ��� null���� ó���ؼ� �����Ѵ�
select sum(commission) , avg(commission) , max(commission) , min(commission)
from employee;

-- count () : ���ڵ�� , �ο��
    -- null�� ó������ �ʴ´�
    -- ���̺��� ��ü ���ڵ� ���� ������ ��� : count (*) �Ǵ� not null �÷��� count()
select count(eno)
from employee;

select commission from employee;
select count(commission) from employee;

select count(*) from employee;

-- ��ü ���ڵ� ī��Ʈ
select count(*) from employee;
select count(eno) from employee;

-- �ߺ����� �ʴ� ������ ���� 
select job from employee;

select count (DISTINCT job) from employee;

-- �μ��� ����
select count (DISTINCT dno) from employee;

-- Group by : Ư�� �÷��� ���� �׷��� �Ѵ� , �ַ� �����Լ��� select ������ ���� ����մϴ�

/*
    select �÷��� , �����Լ�ó�����÷�
    from  ���̺�
    where ����
    group by �÷���
    having ���� ( group by�� ����� ���� )
    order by ���� 
*/

-- �μ��� ��� �޿�
select dno �μ� , avg(salary) ��ձ޿�
from employee
group by dno;  -- dno�÷��� �ߺ��Ȱ��� �׷���


-- ��ü ��� �޿�
select avg(salary)
from employee;

--group by�� ����ϸ鼭 select ���� ������ �÷��� �� �����ؾ��Ѵ�
select dno , count (dno) , sum(salary) , ename
from employee
group by dno;


-- ������ ��å�� �׷����ؼ� ������ ��� , �հ� , �ִ밪 , �ּҰ��� ���
select job , avg(salary) , sum(salary) , max(salary) , min(salary)
from employee
group by job;

-- �����÷��� �׷��� �ϱ� . 
select dno , job , count(*) , sum (salary)
from employee
group by dno ,job;  -- �� �÷� ��� ��ġ�ϴ� ���� �׷��� 

select dno , job 
from employee
where dno = 20 and job ='CLERK';

-- having : group by ���� ���� ����� �������� ó���Ҷ� 

-- �μ��� ������ �հ谡 9000�̻��ΰ͸� ���
select dno , count(*) , sum (salary) , avg(salary)
from employee
group by dno 
having sum (salary)> 9000;

-- where �� having ���� ���� ���Ǵ� ���
    -- where : ���� ���̺��� �������� �˻�
    -- having : group by ����� ���ؼ� ������ ó��

select dno , avg(salary)
from employee
where not salary <1500
group by dno
having avg(salary) >2500;

--CUBE 
    -- group by ������ ����ϴ� Ư���� �Լ�
    -- ���� �÷��� ���� �� �� �ִ�
    -- group by ���� �ڼ��� ������ ���
    
select dno , count(*) , sum(salary) , round(avg(salary))
from employee
group by rollup (dno)
order by dno;

-- cube : �μ��� �հ�� ����� ��� �� , ������ ���ο� ��ü �հ� ���
select dno , count(*) , sum(salary) , round(avg(salary))
from employee
group by cube (dno)
order by dno;

-- rollup : ���÷��̻�
select dno,job , count(*) , max(salary) , sum(salary) , avg(salary)
from employee
group by rollup (dno , job);


-- join 
    -- department �� employee�� ���� �ϳ��� ���̺��̾����� �𵨸�(�ߺ����� , ������� ) �� ���ؼ� �� ���̺��� �и�
    -- �����̺��� ����Ű �÷� (dno) , employee ���̺��� dno �÷��� department ���̺��� dno �÷��� �����Ѵ� 
    -- �ΰ� �̻��� ���̺��� �÷��� join������ ����ؼ� ��� 
    
select * from department;   -- �μ������� ���� �ϴ� ���̺�
select * from employee;     -- ��������� �����ϴ� ���̺�

-- EQUI JOIN : ����Ŭ���� ���� ���� ����ϴ� join   ,  oracle ������ ��밡��
    -- from �� : ������ ���̺��� ","�� ó��
    -- where �� : �� ���̺��� ������ Ű �÷��� "=" �� ó��
            -- and �� : ������ ó��
    

select *
from employee , department
where department.dno = employee.dno;

            
--where �� : ���� Ű �÷��� ó���� ���
select *
from employee , department
where department.dno = employee.dno     -- ���� Ű ����
and job = 'MANAGER';                    -- ������ ó��



-- ANSI ȣȯ : INNER JOIN  <== ��� SQL ���� ��밡���� JOIN
-- on �� : ���� Ű �÷��� ó���� ���
    -- on�� : �� ���̺��� ������ Ű �÷��� "=" ���� ó��
            -- where �� : ������ ó��
select *
from employee  e join department d    -- on���� ����ҋ��� join
on e.dno  = d.dno
where job = 'MANAGER';                    
            


-- join�� ���̺� �˸��
select *
from employee e  , department d
where e.dno=d.dno
and salary > 1500;

-- select ������ ������ Ű �÷��� ��½ÿ� ��� ���̺��� �÷����� ��� : dno
select eno , job , e.dno , dname
from employee e , department d
where e.dno = d.dno;

--�� ���̺��� join �ؼ� �μ���[��] ����  ���� (salary) �� ���밪�� ����� ������
select dname , max(salary)
from employee e , department d
where e.dno = d.dno
group by dname;


-- NATUAL JOIN : Oracle 9i ����
    -- EQUI JOIN �� Where ���� ���� : �� ���̺��� ������ Ű �÷��� ���� " = "
    -- ������ Ű �÷��� Oracle ���������� �ڵ����� �����ؼ� ó��. 
    -- ���� Ű�÷��� ��Ī �̸��� ����ϸ� ������ �߻�
    
select eno , ename , dname , dno
from employee e  natural join department d;

-- ���� : select ���� ����Ű �÷��� ��½� ���̺���� ����ϸ� ���� �߻�

-- EQUI JOIN vs NATURAL JOIN  �� ���� Ű �÷� ó��
    -- EQUI JOIN : select ���� �ݵ�� ���� Ű�÷��� ��� �ҋ� ���̺���� �ݵ�� ���
    -- NATURAL JOIN : select ���� �ݵ�� ���� Ű�÷��� ��� �ҋ� ���̺����  ��� �ϸ� �ȵȴ�
            


--EQUI
select ename ,  salary , dname , e.dno   -- e.dno : EQUI JOIN ������ �ݵ�� ���
from employee e , department d 
where e.dno = e.dno 
and salary >2000;

--NATURAL
select ename , salary , dname , dno     -- dno : NATURAL JOIN ������ ���̺���� ����ϸ� �ȵȴ� 
from employee  natural join department d
where salary > 2000;

--ANSI ȣȯ�� INNER JOIN
select ename , salary , dname ,  e.dno
from employee e join department d
on e.dno = d.dno
where salary > 2000;


-- NON EQUI JOIN : EQUI JOIN ���� where ���� "=" �� ������� �ʴ� join

select * from salgrade ;  -- ������ ����� ǥ���ϴ� ���̺�

select ename , salary ,grade
from employee , salgrade
where salary between losal and hisal;

-- ���̺� 3�� ����
select ename , dname , salary , grade 
from employee e , department d , salgrade s
where e.dno = d.dno
and salary between losal and hisal;




