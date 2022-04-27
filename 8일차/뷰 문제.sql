-- 1�� ����
create table emp_sample
as
select * from employee;

alter table emp_sample
add constraint my_emp_pk primary key (eno);

-- 2�� ����
create table dept_sample
as
select * from department;

alter table dept_sample
add constraint my_dept_pk primary key (dno);

--3�� ����
alter table emp_sample
add constraint my_emp_dept_fk foreign key(dno) references dept_sample (dno);

--4�� ����
update emp_sample
set commission = 0
where commission  is null;

alter table emp_sample
add constraint CK_emp_sample_com check ( commission >= 0);

-- 5�� ����
alter table emp_sample
modify salary  default 1000;

-- 6�� ���� 
alter table emp_sample
add constraint UQ_emp_sample_ename  unique (ename);

-- 7�� ����
alter table emp_sample
modify  commission constraint NN_emp_sample_com not null;

-- 8�� ����
alter table emp_sample
drop constraint MY_EMP_PK ;

alter table emp_sample
drop constraint MY_EMP_DEPT_FK cascade ;

alter table emp_sample
drop constraint CK_EMP_SAMPLE_COM ;

alter table emp_sample
drop constraint UQ_EMP_SAMPLE_ENAME ;

alter table emp_sample
drop constraint NN_EMP_SAMPLE_COM ;

alter table emp_sample
modify salary default null;

alter table dept_sample
drop constraint MY_DEPT_PK;

-----------------------------------------------------------------------

-- �� ����
-- 1�� ����
create view v_em_dno
as
select eno , ename , dno
from employee
where dno = 20;

-- 2��  ���� 
create or replace view v_em_dno
as
select eno , ename , dno , salary
from employee
where dno = 20;

-- 3�� ����
drop view v_em_dno;


-- 4�� ����
create view v_sal_emp
as
select min(salary) �ּҰ� , max(salary) �ִ밪 , round(avg(salary),2) ��� , sum(salary) ����
from employee 
group by dno ;


-- 5�� ����
create or replace view v_em_dno
as
select eno , ename , dno , salary
from employee
where dno = 20
with read only ;







