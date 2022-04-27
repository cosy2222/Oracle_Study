/*
    뷰 ( view )  : 가상의 테이블을 뷰( view ) 라 한다
        -- 테이블은 데이터 값을 가지고 있따
        -- 뷰는 데이터 값을 가지지 않는다 , 실행코드만 들어가 있다
        -- 뷰를 사용하는 목적 :
            1. 보안을 위해서 : 실제 테이블의 특정 컬럼만 가져와서 실제 테이블의 중요 컬럼을 숨길수 있다 
            2. 복잡한 쿼리를 뷰를 생성해서 편리하게 사용할 수 있다 ( 복잡한 join 쿼리 ) 
        - 뷰는 일반적으로 select 구문이 온다
        - 뷰는 생성할떄 insert, update , delete 구문이 올수 없다 . 
        - 뷰에 값을 insert하면 실제 테이블에 저장된다 , 실제 테이블의 제약조건을 잘 만족해야 한다
        - 뷰에 값을 insert 할 경우 실제 테이블의 제약조간에 따라서 insert될수 있고  안될수도 있다
        - 그룹함수를 적용한 view에는 insert할 수 없다 
*/

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- 뷰 생성
create view v_emp_job
as
select eno , ename , dno , job
from emp_copy60
where job like 'SALESMAN';

-- 뷰 생성 확인
select * from user_views;

-- 뷰의 실행
select * from v_emp_job;


-- 복잡한 조인 쿼리를 뷰에 만들어 두기
create view v_join
as
select e.dno , ename , job , dname , loc
from employee e , department d
where e.dno = d.dno
and  job = 'SALESMAN';

select * from v_join;

-- 뷰를 사용해서 실제 테이블의 중요한 정보 숨기기. (보안)
select * from emp_copy60;

create view simple_emp
as
select ename  , job , dno
from emp_copy60;

select * from simple_emp;   -- view를 사용해서 실제 테이블의 중요 컬럼을 숨긴다

-- 뷰를 생성할떄 반드시 별칭 이름을 사용해야 하는 경우 , group by 할떄 

create view v_groupping
as 
select dno , count(*) groupCount , AVG(salary) avg , sum (salary) sum
from emp_copy60
group by dno;

select * from v_groupping;

-- 뷰를 생성할떄 as 하위에 select문이 와야한다   insert,update , delete 문은 올수 없다
create view v_error
as
insert into dno
values ( 60 , 'HR' , 'BUSAN');

-- view 에 값을 insert    컬럼의 제약 조건을 만족하면 view에도 값을 넣을수 있다
    -- 실제 테이블에 값이 insert 된다
create view v_dept
as
select dno , dname
from dept_copy60;

select * from v_dept;
select * from dept_copy60;

insert into  v_dept    -- view 에 값을 insert
values ( 70 , 'HR');


create or replace view v_dept    -- v_dept가 존재하지 않을 경우 : create , 존재할 경우 : replace(수정)
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


-- 읽기만 가능한 뷰를 생성 : 
create view v_readonly
as
select dno , dname , loc
from dept_copy60 with read only;

select * from v_readonly;

-- readonly 는 insert , update , delete 사용 불가
insert into v_readonly
values ( 88 , 'HR7' , 'BUSAN');

update v_readonly
set dname = 'HR 77' , loc = 'BUSAN77'
where dno = 88;

delete v_readonly
where dno = 88;






