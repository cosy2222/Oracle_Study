-- 계정생성
create user usertest02 IDENTIFIED by 1234;

--접속 권한
grant create session to usertest02;

-- 테이블 생성 권한
grant create table to usertest02;

-- 테이블 스페이스 변경
alter user usertest02
default tablespace users
temporary tablespace temp;

-- 공간 할당 
alter user usertest02
quota 2m on users;


select * from all_tables -- 테이블의 소유주를 출력해 준다 , 계정별로 소유한 테이블을 출력 할 수 있다
where owner in ( 'HR' , 'USERTEST01' , 'USERTEST01');



