/*
    �� ( view )  : ������ ���̺��� ��( view ) �� �Ѵ�
        -- ���̺��� ������ ���� ������ �ֵ�
        -- ��� ������ ���� ������ �ʴ´� , �����ڵ常 �� �ִ�
        -- �並 ����ϴ� ���� :
            1. ������ ���ؼ� : ���� ���̺��� Ư�� �÷��� �����ͼ� ���� ���̺��� �߿� �÷��� ����� �ִ� 
            2. ������ ������ �並 �����ؼ� ���ϰ� ����� �� �ִ� ( ������ join ���� ) 
        - ��� �Ϲ������� select ������ �´�
        - ��� �����ҋ� insert, update , delete ������ �ü� ���� . 
        - �信 ���� insert�ϸ� ���� ���̺� ����ȴ� , ���� ���̺��� ���������� �� �����ؾ� �Ѵ�
        - �信 ���� insert �� ��� ���� ���̺��� ���������� ���� insert�ɼ� �ְ�  �ȵɼ��� �ִ�
        - �׷��Լ��� ������ view���� insert�� �� ���� 
*/

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- �� ����
create view v_emp_job
as
select eno , ename , dno , job
from emp_copy60
where job like 'SALESMAN';

-- �� ���� Ȯ��
select * from user_views;

-- ���� ����
select * from v_emp_job;


-- ������ ���� ������ �信 ����� �α�
create view v_join
as
select e.dno , ename , job , dname , loc
from employee e , department d
where e.dno = d.dno
and  job = 'SALESMAN';

select * from v_join;

-- �並 ����ؼ� ���� ���̺��� �߿��� ���� �����. (����)
select * from emp_copy60;

create view simple_emp
as
select ename  , job , dno
from emp_copy60;

select * from simple_emp;   -- view�� ����ؼ� ���� ���̺��� �߿� �÷��� �����

-- �並 �����ҋ� �ݵ�� ��Ī �̸��� ����ؾ� �ϴ� ��� , group by �ҋ� 

create view v_groupping
as 
select dno , count(*) groupCount , AVG(salary) avg , sum (salary) sum
from emp_copy60
group by dno;

select * from v_groupping;

-- �並 �����ҋ� as ������ select���� �;��Ѵ�   insert,update , delete ���� �ü� ����
create view v_error
as
insert into dno
values ( 60 , 'HR' , 'BUSAN');

-- view �� ���� insert    �÷��� ���� ������ �����ϸ� view���� ���� ������ �ִ�
    -- ���� ���̺� ���� insert �ȴ�
create view v_dept
as
select dno , dname
from dept_copy60;

select * from v_dept;
select * from dept_copy60;

insert into  v_dept    -- view �� ���� insert
values ( 70 , 'HR');


create or replace view v_dept    -- v_dept�� �������� ���� ��� : create , ������ ��� : replace(����)
as
select dname , loc
from dept_copy60;

insert into v_dept
values ('HR2' , 'BUSAN');

update dept_copy60
set dno=80
where dno is null;

alter table dept_copy60
add constraint PK_dept_copy60 primary key (dno) ;


create or replace view v_groupping
as
select dno , count(*) groupCount , round( AVG(salary),2) avg , sum (salary) sum
from emp_copy60
group by dno;

select * from v_groupping;

drop view v_groupping;


create view v_dept10
as
select dno , dname , loc 
from dept_copy60;

insert into v_dept10
values ( 90 , 'HR4' , 'BUSAN4');

select * from v_dept10;

update  v_dept10
set dname = 'HR5' , loc = 'BUSAN5'
where dno = 90;

delete v_dept10
where dno = 90;


-- �б⸸ ������ �並 ���� : 
create view v_readonly
as
select dno , dname , loc
from dept_copy60 with read only;

select * from v_readonly;

-- readonly �� insert , update , delete ��� �Ұ�
insert into v_readonly
values ( 88 , 'HR7' , 'BUSAN');

update v_readonly
set dname = 'HR 77' , loc = 'BUSAN77'
where dno = 88;

delete v_readonly
where dno = 88;






