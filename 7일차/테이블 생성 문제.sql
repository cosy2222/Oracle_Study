-- 1��
create table DEPT1(
    DNO number(2) not null,
    DNAME varchar2(14),
    LOC varchar2(13) 
);

-- 2��
create table EMP(
    ENO number(4) not null,
    ENAME varchar2(10),
    DNO number(2) 
);

-- 3��
alter table EMP
modify ENAME varchar(25);

-- 4��
create table employee2
as
select eno EMP_ID ,ename NAME , salary SAL ,dno DEPT_ID 
from employee;

--5��
drop table EMP;

--6��
rename employee2 to EMP;

--7��
alter table DEPT1
drop column DNAME;

-- 8��

alter table DEPT1
set unused (LOC);

-- 9��
alter table DEPT1
drop unused column;

commit;

-- ������ ���۰� Ʈ����� ����
--===================================================
-- 1��
create table EMP_INSERT
as
select * from EMP
where 0=1;

alter table EMP_INSERT
add ( HIREDATE  date);

-- 2��
insert into EMP_INSERT ( EMP_ID , NAME , SAL , DEPT_ID , HIREDATE)
values (111 , '������' , 100 , 22 , sysdate);

-- 3��
insert into EMP_INSERT ( EMP_ID , NAME , SAL , DEPT_ID , HIREDATE)
values (222 , '������2' , 200 , 33 , sysdate-1);

-- 4�� 
create table EMP_COPY
as
select * from employee;

-- 5��
update EMP_COPY
set dno = 10
where eno = 7788;


--6��
update EMP_COPY
set job = (select job from EMP_COPY where eno=7499),
    salary = (select salary from EMP_COPY where eno=7499)
where eno = 7788;

--7��
update EMP_COPY
set dno = (select dno from EMP_COPY where eno=7369)
where job = ( select job from EMP_COPY where eno = 7369);


--8��
create table DEPT_COPY
as
select * from department;

--9��
delete DEPT_COPY
where dname = 'RESEARCH';

-- 10��
delete DEPT_COPY
where dno in (10,40);


commit;
