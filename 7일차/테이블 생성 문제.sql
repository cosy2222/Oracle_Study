-- 1번
create table DEPT1(
    DNO number(2) not null,
    DNAME varchar2(14),
    LOC varchar2(13) 
);

-- 2번
create table EMP(
    ENO number(4) not null,
    ENAME varchar2(10),
    DNO number(2) 
);

-- 3번
alter table EMP
modify ENAME varchar(25);

-- 4번
create table employee2
as
select eno EMP_ID ,ename NAME , salary SAL ,dno DEPT_ID 
from employee;

--5번
drop table EMP;

--6번
rename employee2 to EMP;

--7번
alter table DEPT1
drop column DNAME;

-- 8번

alter table DEPT1
set unused (LOC);

-- 9번
alter table DEPT1
drop unused column;

commit;

-- 데이터 조작과 트랜잭션 문제
--===================================================
-- 1번
create table EMP_INSERT
as
select * from EMP
where 0=1;

alter table EMP_INSERT
add ( HIREDATE  date);

-- 2번
insert into EMP_INSERT ( EMP_ID , NAME , SAL , DEPT_ID , HIREDATE)
values (111 , '강성민' , 100 , 22 , sysdate);

-- 3번
insert into EMP_INSERT ( EMP_ID , NAME , SAL , DEPT_ID , HIREDATE)
values (222 , '강성민2' , 200 , 33 , sysdate-1);

-- 4번 
create table EMP_COPY
as
select * from employee;

-- 5번
update EMP_COPY
set dno = 10
where eno = 7788;


--6번
update EMP_COPY
set job = (select job from EMP_COPY where eno=7499),
    salary = (select salary from EMP_COPY where eno=7499)
where eno = 7788;

--7번
update EMP_COPY
set dno = (select dno from EMP_COPY where eno=7369)
where job = ( select job from EMP_COPY where eno = 7369);


--8번
create table DEPT_COPY
as
select * from department;

--9번
delete DEPT_COPY
where dname = 'RESEARCH';

-- 10번
delete DEPT_COPY
where dno in (10,40);


commit;
