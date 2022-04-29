show user;

-- 최고 관리자 계정 (sys) : 계정을 생성할 수 있는 권한을 가지고 있다
-- 아이디 : usertest01 , 암호 : 1234
create user usertest01  identified by 1234;

-- 계정과 암호를 생성하고  오라클에 접속할 수 있는 권한을 부여 받아야 접속 가능

--system privileges:
    -- create session : 오라클에 접속 할 수 있는 권한
    -- create table   : 오라클에서 테이블을 생성 할 수 있는 권한.
    -- create sequence  : 시퀀스 생성할 수 있는 권한 
    -- create view : 뷰를 생성 할 수 있는 권한 
    

DDL : 객체 생성 ( Create , Alter , drop )
DML : 레코드 조작 ( INSERT , UPDATE , DELETE)
DQL : 레코드 검색 ( SELECT)
DTL : 트랜잭션 ( BEGIN transaction , rollback , commit)
DCL : 권한 관리 ( GRANT , REVOKE , DENY )

-- 생성한 계정에게 오라클에 접속할 수 있는 create session 권한을 부여
-- grant 부여할권한 to 계정명
grant create session to usertest01;

-- 오라클에 접속해도 테이블접근권한은 없다  테이블 접근권한 부여해줘야됨 
grant create table to usertest01;


/*
    테이블 스페이스 : 객체를 저장하는 공간
        - 관리자 계정에서 각 사용자별 테이블 스페이스를 확인 
    system : dba ( 관리자 계정에서만 접근 가능) 
*/

select * from dba_users ;   -- dba_ : sys (최고 관리자 계정에서 확인)

select username , default_tablespace as dataFile ,  temporary_tablespace as Logfile
from dba_users
where username in ( 'HR' , 'USERTEST01');

-- 계정에게 테이블 스페이스 변경 ( SYSTEM == > USERS) 변경
alter user usertest01
default tablespace users        -- dataFIle 저장 : 객체를 저장하는 공간
temporary tablespace temp;      -- log 를 저장 : DML

-- 테이블 스페이스 : 객체와 log를 저장하는 물리적인 파일
    -- DATAFILE : 객체를 저장하고 있다
    -- log      : transaction log 를 저장 
    
    -- DataFile 과 log 파일은 물리적으로 다른 하드공간에 저장해야 성능을 높일수 있음 
        -- RAID된 공간에 저장하면 성능을 높일 수 있다 

-- 계정에게 users 테이블 스페이스를 사용할수 있는 공간 할당 ( users 테이블 스페이스에 2mb 사용 공간 할당 
alter user usertest01
quota 2m on users;








