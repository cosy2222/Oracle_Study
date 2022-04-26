-- 7일차   제약조건

-- 테이블 복사 : 테이블의 전체를 복사함 
    -- 테이블을 복사하면 , 컬럼과 레코드만 복사가됨
    -- 테이블의 할당된 제약조건은 복사 되지 않는다. ( Alter table 을 사용해서 할당 해야 한다)
    -- 제약 조건 : 컬럼에 할당되어 있다 
        -- not null , primary key , foreign key , check

-- 테이블의 전체레코드를 복사
create table dept_copy
as
select * from department;

select * from dept_copy;

create table emp_copy
as
select * from employee;

select * from emp_copy;


-- 테이블 복사 : 특정 컬럼만 복사 
create table emp_second
as
select eno , ename , salary , dno from employee;

select * from emp_second;


-- 테이블 복사 : 조건을 사용해서 테이블 복사
create table emp_third
as
select eno , ename , salary
from employee
where salary > 2000;

select * from emp_third;

-- 테이블 복사 : 컬럼명을 바꾸어서 복사
create table emp_forth
as
select eno 사원번호 , ename 사원명 , salary 월급
from employee;

select 사원번호,사원명,월급 from emp_forth;  -- 테이블명 , 컬럼명은 영문사용 권장


-- 테이블 복사 : 계산식을 이용해서 테이블 복사 : 반드시 별칭 이름을 사용해야 한다 
create table emp_fifth
as
select eno , ename , salary * 12 as salary from employee;

select * from emp_fifth;


-- 테이블 복사 : 테이블 구조만 복사 , 레코드는 복사하지 않는다 
create table emp_six
as
select * from employee
where 0=1;           -- where 조건 : false를 리턴 

select * from emp_six;
desc emp_six;


-- 테이블 수정 : alter table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- 기존의 테이블에서 컬럼을 추가함  : 반드시 추가할 컬럼에 null을 허용해야 한다 
alter table dept20
add (birth date);

alter table dept20
add ( email varchar2 (100) not null);  -- not null 떄문에 오류


-- 컬럼의 자료형을 수정 : modify
alter table dept20
modify dname varchar2 (100);

desc dept20;


-- 특정 컬럼을 삭제 : 부하가 많이 걸릴수 있다
alter table dept20
drop column birth;

select * from dept20;

-- 컬럼을 삭제시에 브하기 많이 발생이됨 
        -- set unused : 특정 컬럼을 사용 중지 
alter table dept20
set UNUSED (loc);
        
desc dept20;

alter table dept20
drop unused column;  -- 사용하지 않는 컬럼 삭제

-- 컬럼 이름 변경
alter table dept20
rename column DNO to ddd;

-- 테이블 이름 변경
rename dept20 to dept30;

desc dept30;


/*
    DDL : create(생성) , alter(수정)  ,drop(삭제)
        <<객체>>
            테이블 , 뷰  , 인덱스 , 트리거 , 시퀀스 , 함수 , 저장프로시져....
            
    DML : insert ( 레코드 추가 ) , update (레코드 수정) , Delete(레코드 삭제)
        << 테이블의 값 (레코드 , 로우) >>
            
    DQL : select
    
    
    테이블의 전체 내용이나 테이블 삭제시
    1. delete   : 테이블의 레코드를 삭제 , where 를 사용하지 않을시 모든 레코드 삭제
    2. truncate : 테이블의 레코드를 삭제 , 속도가 굉장히 빠름
    3. drop     : 테이블 자체를 삭제 
            
*/

create table emp30 
as
select * from employee;

select * from emp20;

-- emp 10 : delete 사용
delete emp10;
commit;

-- emp 20 : truncate 사용
truncate table emp20;

-- emp 30 : drop 사용
drop table emp30;





/*
    데이터 사전 : 시스템의 각종 정보를 출력해 주는 테이블
      user_   : 자신의 계정에 속한 객체정보를 출력
      all_    : 자신의 계정이 소유한 객체나 권한을 부여 받은 객체 정보를 출력
      dba_    : 데이터 베이스 관리자만 접근 가능한 객체 정보를 출력.
*/

show user;
select * from user_tables;        -- 사용자가 생성한 테이블 정보 출력
select table_name from user_tables;
select * from user_views;         -- 사용자가 생성한 뷰에 대한 정보 출력
select * from user_indexes;       -- 사용자가 생성한 인덱스 정보
select * from user_constraints;   -- 제약 조건 확인

select * from user_constraints
where table_name = 'EMPLOYEE';
select * from user_sequences;

select * from all_tables;
select * from all_views;

select * from dba_tables;   -- 관리자 계정에서만 실행 가능

/*
    제약 조건 : 테이블의 무결성을 확보 하기 위해서 컬럼에 부여되는 규칙.
            1. primary key
            2. unique 
            3.not null 
            4. check
            5. foreign key
            6. default
*/


--1 : primary key : 중복된 값을 넣을수 없다

 -- a. 테이블 생성시 컬럼에 부여
    -- 제약조건이름을 지정하지 않을 경우  oracle에서 랜던함 이름으로 생성
        -- 제약조건을 수정할떄 제약조건이름을 사용
    create table customer01(
        id varchar2(20) not null  constraint pk_customer01_id primary key,
        pwd varchar2(20) constraint NN_customer01_pwd not null ,
        name varchar2(20) constraint NN_customer01_name not null ,
        phone varchar2(30) null,
        address varchar2(100) null
    );
    
    select * from user_constraints
    where table_name = 'CUSTOMER01';
    
    
-- 테이블의 컬럼 생성후 제약 조건 할당
    create table customer02(
        id varchar2(20) not null  ,
        pwd varchar2(20) constraint NN_customer02_pwd not null ,
        name varchar2(20) constraint NN_customer02_name not null ,
        phone varchar2(30) null,
        address varchar2(100) null,
        constraint pk_customer02_id primary key (id)
    );


/*
    foreign key ( 참조키 ) : 다른 테이블(부모)의 primary key , unique 컬럼을 참조해서 값을 할당
    check : 컬럼에 값을 할당할때 check 에 맞는 값을 할당
*/

-- 부모 테이블
create table parentTbl(
    name varchar2 (20),
    age number(3) constraint CK_ParentTbl_age check (age > 0 and age < 200),
    gender varchar(3) constraint CK_ParentTbl_gender check ( gender in ('M' , 'W')),
    infono number constraint PK_ParenTbl_infono primary key
);

desc parentTbl;
select * from user_constraints
where table_name = 'PARENTTBL';

select * from parenttbl;

insert into parentTbl
values ('강성민' , 30 , 'M' ,1);

insert into parentTbl
values ('강성민' , 300 , 'a' ,1);  -- 오류 발생  : 300 (check) , K (ckeck) ,  1 (primary key) 

insert into parentTbl
values ('강성' , 40 , 'M' ,2);

-- 자식 테이블
create table ChileTbl(
    id varchar2 (40) constraint PK_ChildTbl_id primary key,
    pw varchar2(40) ,
    infono number ,
    constraint FK_ChildTbl_infono foreign key (infono) references ParentTbl(infono)
);

insert into ChileTbl 
values ('aaa' , '1234' , 3);  --  3  foreign key 위반

insert into ChileTbl 
values ('aaa' , '1234' , 1);

insert into ChileTbl 
values ('bbb' , '1234' , 2);

select * from chiletbl;



--부모 테이블
create table parenttbl2 (
    dno number(2) not null primary key ,
    dname varchar2(50) ,
    loc varchar2 (50)
);

insert into parenttbl2
values ( 10 , 'SALES' , 'SEOUL');


-- 자식테이블
create table childTbl2 (
    no number not null,
    ename varchar2(50),
    dno number(2) not null ,
    foreign key (dno) reference parenttbl2 (dno)
    );
insert into childtbl2
values (1, 'PARK' , 20);


-- default 제약 조건 : 값을 할당 하지 않으면 default 값이 할당

create table emp_sample01 (
    eno number(4) not null primary key ,
    ename varchar(50),
    salary number(7,2) default 1000
);

-- default 컬럼에 값을 할당한 경우
insert into emp_sample01
values ( 1111 , 'ㅁㄴㅇ' , 1500);

-- default 컬럼에 값을 할당하지 않은 경우  , default에 할당된 값이 적용
insert into emp_sample01 (eno , ename)
values (2222, 'ㅂㅈㄷ');



insert into emp_sample01
values (3333, 'ㅁㄴㅇ' , default);

create table emp_sample02 (
    eno number(4) not null primary key ,
    ename varchar(50) default 'aaa' ,
    salary number(7,2) default 1000
);

insert into emp_sample02 (eno)
values (10);

select * from emp_sample02;

insert into emp_sample02 
values ( 20 , default , default ) ;

/*
    primary key , foreign key , unique , check , default , not null
*/

create table member10 (
    no number not null constraint PK_member10_no primary key,
    name varchar2(50) constraint  NN_member10_name not null,
    birthday date default sysdate,
    age number (3) check ( age > 0 and age <150),
    gender char (1) check ( gender in ('M' , 'W')),
    dno number(2) unique
);

insert into member10
values ( 1 ,'강성민' , default , 25 , 'M' , 10);

insert into member10
values ( 2 ,'강성민2' , default , 25 , 'M' , 20);

select * from member10;


create table orders10 (
    no number not null primary key, 
    p_no varchar(100) not null,
    p_name varchar(100) not null,
    price number check (price > 10),
    phone varchar (100) default '010-0000-0000',
    dno number(2) not null , 
    foreign key (dno) references member10(dno)
);





