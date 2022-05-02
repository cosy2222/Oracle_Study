--sys 계정 

-- autication ( 인증 ) : credential ( ID + pass )
create user user_test10 identified by 1234; --sys계정으로 해야됨


-- Authorization ( 허가) : system 권한 할당 
grant create session , create table , create view to user_test10;

-- 계정을 생성하면 system 테이블 스페이스를 사용한다 .  <== 관리자만 사용할수 있는 테이블 스페이스 
-- 테이블 스페이스 바꾸기  ( USERS )
alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- 용량 할당
ALTER USER "USER_TEST10" QUOTA UNLIMITED ON "USERS";


-- 특정 계정에서 객체를 생성하면  특정계정이 객체를 소유하게 된다 

select * from dba_tables
where owner in ( 'HR' , 'USER_TEST10');


-- 다른 사용자의 테이블에 접근할려면 권한을 가져야한다 
-- grant  : 권한부여
grant select on hr.employee to user_test10;

grant select on hr.emp_copy1 to user_test10;
grant insert , update , delete on hr.emp_copy1 to user_test10;

--revoke : 권한 해제
revoke insert , update , delete on hr.emp_copy1 from user_test10;


-- with grant option  : 특정 계정에게 권한을 부여하면서 해당권한을 다른사용자에게 부여할 수 있는 권한 
grant select on hr.employee to user_test10 with grant option;
        -- user_test10 계정은 hr.employee 테이블에 대해서 다른사용자에게 select 권한 부여 가능 

grant select on hr.dept_copy1 to user_test10 with grant option;


/* Public : 모든 사용자에게 권한을 부여하는 것. */

--hr계정에서 테이블 생성
CREATE TABLE emp_copy56
as
SELECT * FROM employee;

--HR 계정에서 Public 옵션(모든 사용자에게 권한부여)
GRANT SELECT, INSERT, DELETE on hr.emp_copy56 to PUBLIC;

--USER_TEST10,--USER_TEST11 (둘다 가능)
SELECT * FROM hr.emp_copy56;

/* 롤 (Role) : 자주 사용하는 여러개의 권한을 묶어 놓은 것 

    1. dba : 시스템의 모둔 권한이 적용된 role, --sys(최고 관리자 권한)
    2. connect : 
    3. resource : 
*/

-- 사용자 정의 Role 생성 : 자주 사용하는 권한들을 묶어서 role을 생성
--1.롤 생성 :
CREATE ROLE roletest1;
    
--2.롤에 자주사용하는 권한을 적용
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE TRIGGER
to roletest1;
    
--3. 생성된 롤을 계정에게 적용
GRANT roletest1 to user_test10;

/*현재 접속된 사용자에게 부여된 Role 확인*/
SELECT * FROM user_role_privs;

/*롤에 부여된 권한 정보 확인*/
SELECT * FROM role_sys_privs
WHERE role like 'DBA';

SELECT * FROM role_sys_privs
WHERE role like 'ROLETEST1';

/* 객체 권한을 role 에 부여하기 */
create role roletest2;

grant select on hr.employee to roletest2; -- 계정에게 객체권한을 적용한것이 아니라 role에 적용

grant roletest2 to user_test10;


-- 실습 
create role roletest3;
grant select , insert , delete on hr.dept_copy57 to roletest3;
grant roletest3 to user_test10;










