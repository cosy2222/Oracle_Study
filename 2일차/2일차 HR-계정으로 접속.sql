-- 2���� : DQL : Select

-- desc ���̺��  : ���̺��� ������ Ȯ��
desc department;

select * FROM department;

/*
Select ������ ��ü �ʵ� ���� 

Select    <== �÷���
Distinct  <== �÷����� ���� �ߺ��� �����ض� 
From      <== ���̺�� ,���
Where     <== ����
Group By  <== Ư�� ���� �׷���
Having    <== �׷����� ���� ����
Order by  <== ���� �����ؼ� ���
*/

desc employee;
select *
from employee;

-- Ư�� �÷��� ����ϱ�
select eno, ename from employee;

-- Ư�� �÷��� ������ ���
select eno , ename ,eno , ename , ename from employee;

SELECT eno , ename , salary from employee;

-- �÷��� ������ ������ �� �ִ�
select eno , ename ,salary , salary * 12 from employee;

-- �÷��� �˸��( Alias )
    --�÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������
Select eno , ename , salary , salary * 12 as ���� from employee;
select eno as �����ȣ  , ename as ����� , salary as ���� , salary *12 as ���� from employee;

    -- as ��������
select eno  �����ȣ  , ename  ����� , salary  ���� , salary *12  ���� from employee;

    -- �����̳� Ư�����ڰ� ������ "" ���� ó���ؾ� �Ѵ�
select eno  "��� ��ȣ"  , ename  "���?��" , salary  ���� , salary *12  ���� from employee;


-- nvl �Լ� : ����ÿ� null �� ó���ϴ� �Լ� 
select * from employee;

-- nvl �Լ��� ������� �ʰ� ��ü ������ ��� (null �� ���Ե� �÷��� ������ �ϸ� null�� ��� ) 
    -- null �� 0���� ó���ؼ� �����ؾ���
select eno �����ȣ , ename ����� , salary ���� , commission ���ʽ�, salary*12 ����,
salary *12 + commission ��ü����    -- ��ü ����
from employee;


--nvl �Լ��� ����ؼ� ���� 
select eno �����ȣ , ename ����� , salary ���� , commission ���ʽ�, salary*12 ����,
salary *12 + nvl(commission, 0) ��ü����    -- ��ü ����
from employee;

-- Ư�� �÷��� ������ �ߺ� ������ ���
select * from employee;
select dno from employee;
select DISTINCT dno from employee;

-- ������ ����ؼ� �˻� ( where )
select * from employee;
select eno �����ȣ , ename ����� , job ��å , manager ���ӻ�� , hiredate �Ի糯¥ , 
    salary ���� , commission ���ʽ� , dno �μ���ȣ
from employee;

-- ��� ��ȣ�� 7788�� ����� �̸��� �˻� 
select * from employee
where eno = 7788;

select ename from employee
where eno = 7788;

-- �����ȣ�� 7788�� ����� �μ���ȣ ,���� , �Ի糯¥ �˻�
SELECT  dno  , salary  , hiredata 
from employee
where eno = 7788;

select *
from employee
where ename = 'SMITH';

-- ���ڵ带 �����Ë� 
    -- number �ϋ��� '' �� ������ �ʴ´�
    -- ���ڵ����� (char, varchar2)�� ��¥(data) �� �����Ë��� '' �� ó�� 
    -- ��ҹ��ڸ� ���� 

-- �Ի糯¥�� '81/12/03' �� ������
SELECT ename , hiredate
from employee
where hiredate = '81/12/03';


-- �μ��ڵ尡 10�� ��� ������� ���
select ename , eno
from employee
where dno = 10;

SELECT * FROM employee;

-- ������ 3000 �̻��� ����� �̸� , �μ� , �Ի糯¥ ���
select ename , dno , hiredate , salary
from employee 
where salary >= 3000;

-- null �˻� : is Ű���� ���      <==  !���� :  = �� ����ϸ� �ȵȴ� 
select *
from employee
where commission is null;

-- commission �� 300 �̻��� ����� �̸� , ��å , ���� ���
select ename , job , salary , commission
from employee 
where commission >= 300;

-- commission �� ���� ����̸� ���
select ename 
from employee 
where commission is null;

-- ���ǿ��� and , or , not

-- ������ 500 �̻� 2500 �̸��� ������� �̸� , �����ȣ , �Ի糯¥ , ������ ���
select ename , dno , hiredate , salary
from employee
where salary >=500 and salary <2500 ; 


-- ��å�� salesman �̰ų�  �μ��ڵ尡 20�� ����̸� , ��å , ����, �μ��ڵ带 ���

select ename , job , salary , dno 
from employee
where job = 'SALESMAN' or dno = 20;

-- Ŀ�Լ��� ���� ������߿� �μ��ڵ尡 20�� ������� �̸� , �μ��ڵ� , �Ի糯¥ ���
select ename , dno , hiredate
from employee
where commission is null and dno = 20;

-- Ŀ�Լ��� null �� �ƴ� ������� �̸� , �Ի糯¥ , ����
select ename , hiredate , salary 
from employee
where not commission is null;

-- ��¥ �˻� 

--  1982/1/1 ~ 1983/12/31 ���̿� �Ի��� ����� �̸� , ��å , �Ի糯¥
Select ename , job , hiredate
from employee
where hiredate >= '1982/1/1' and hiredate < '1983/12/31';

-- 1981�⵵�� �Ի��� ����� ����� �̸� , ��å, �Ի糯¥
select ename , job , hiredate
from employee
where hiredate >= '1981/1/1' and hiredate <= '1981/12/31';

-- between A and b : A�̻� B����
select ename , job , hiredate
from employee
where hiredate BETWEEN '1981/1/1' and '1981/12/31';

-- IN ������

-- Ŀ�Լ��� 300,500,1400 �� ����� �̸� ,��å ,�Ի���
select ename , job , hiredate
from employee
where commission = 300 or commission = 500 or commission = 1400;

SELECT ename, job  ,hiredate
from employee
where commission in (300,500,1400);


-- like : �÷����� Ư���� ���ڿ��� �˻�   <== �� �˻������ ����ҋ�
    -- % : �ڿ� ����ڰ� �͵� ������� 
    -- _ : �ѱ��ڰ� ����� �͵� �������
    
-- F�� �����ϴ� �̸��� ���� ����� ��� �˻��ϱ�
select * from employee
where ename like 'F%';

--�̸��� ES�� ������ ����� �˻��ϱ�
select ename from employee
where ename like '%ES';

-- J�� ���۵ǰ�  J�ڿ� �α��ڴ� �������  ES�� ������ ���
select ename
from employee
where ename like 'J__ES';

-- ������ ���ڰ� R�� ������ ���
select ename
from employee
where ename like '%R';

-- MAN �� �� ��å
SELECT job
from employee
where job like '%MAN%';

-- 81�⵵�� �Ի��� ��� 
select *
from employee
where hiredate >= '81/1/1' and hiredate <= '81/12/31';

SELECT *
from employee
where hiredate BETWEEN '81/1/1' and '81/12/31';

select *
from employee
where hiredate like '81%';

-- 81�� 2���� �Ի��� ���
SELECT *
from employee
where hiredate like '81/02%';


-- ���� : order by      , asc ( ������������):�⺻�� , desc(������������)

SELECT *
from employee
order by eno asc ;     -- asc �� �⺻���̶�  ��������


SELECT *
from employee
order by eno DESC ; 


-- �̸��÷��� ����
Select *
from employee
order by ename ;      -- �����ϸ� �⺻������ asc

Select *
from employee
order by ename desc;

-- ��¥ ����
select *
from employee
order by hiredate ;

select *
from employee
order by hiredate desc ;


-- �����亯�� �Խ��ǿ��� �ַ� ��� , �ΰ��̻��� �÷��� �����Ҷ� 

select * from employee
order by dno desc;

-- �ΰ��� �÷��� ���� : ���� ó�� �÷��� ������ �ϰ� , ������ ���� ���ؼ� �ι��� �÷��� ���� 
select dno , ename
from employee
order by dno , ename;

select dno , ename
from employee
order by dno desc , ename ;


-- where ����  order by ���� ���� ���ɋ�
select *
from employee
where commission is null 
order by ename;




























