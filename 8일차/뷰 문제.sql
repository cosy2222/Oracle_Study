-- 1번 문제
create table emp_sample
as
select * from employee;

alter table emp_sample
add constraint my_emp_pk primary key (eno);

-- 2번 문제
create table dept_sample
as
select * from department;

alter table dept_sample
add constraint my_dept_pk primary key (dno);

--3번 문제
alter table emp_sample
add constraint my_emp_dept_fk foreign key(dno) references dept_sample (dno);

--4번 문제
update emp_sample
set commission = 0
where commission  is null;

alter table emp_sample
add constraint CK_emp_sample_com check ( commission >= 0);

-- 5번 문제
alter table emp_sample
modify salary  default 1000;

-- 6번 문제 
alter table emp_sample
add constraint UQ_emp_sample_ename  unique (ename);

-- 7번 문제
alter table emp_sample
modify  commission constraint NN_emp_sample_com not null;

-- 8번 문제
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

-- 뷰 문제
-- 1번 문제
create view v_em_dno
as
select eno , ename , dno
from employee
where dno = 20;

-- 2번  문제 
create or replace view v_em_dno
as
select eno , ename , dno , salary
from employee
where dno = 20;

-- 3번 문제
drop view v_em_dno;


-- 4번 문제
create view v_sal_emp
as
select min(salary) 최소값 , max(salary) 최대값 , round(avg(salary),2) 평균 , sum(salary) 총합
from employee 
group by dno ;


-- 5번 문제
create or replace view v_em_dno
as
select eno , ename , dno , salary
from employee
where dno = 20
with read only ;







