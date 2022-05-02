create table test10tbl (
    a number not null ,
    b varchar2(50) null );
    

-- user_test10에서 hr이 소유주인 employee 테이블에 접근할때  객체의 접근권한이 필요하다
-- 다른 사용자의 테이블명 앞에 소유주를 생략하면 안된다 
select * from hr.employee;
-- 기본적으로 자신의 객체를 출력할때 소유주 생략가능 

-- 다른 사용자 테이블 insert 권한 
select * from hr.emp_copy1;
desc hr.emp_copy1;

insert into hr.emp_copy1 (eno)
values ( 3333);


-- with grant option 부여받음 
grant select on hr.employee to user_test11;



select * from hr.dept_copy1;
grant select on hr.dept_copy1 to user_test11;
























