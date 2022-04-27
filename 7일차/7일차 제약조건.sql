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


/*
    Foreign Key로 참조되는 테이블 삭제시
        1. 자식 테이블을 먼저 삭제 후 부모 테이블 삭제
        2. Foreign Key 제약 조건을 모두 제거후 테이블 삭제
        3. cascade constraints 옵션으로 테이블을 강제 삭제

*/


-- 테이블 삭제시 주의 사항 : 다른 테이블에서 Foreign key로 자신의 테이블을 참조하고 있으면 삭제가 안된다.
    -- 다른 테이블이 참조 하고 있더라도 강제로 삭제하는 옵션 : cascade
drop table orders;
drop table member;       -- 오류 발생 : orders 테이블의 id 컬럼이 member 테이블의 id 컬럼을 참조하고 있다.
drop table tb_zipcode;   -- 오류 발생 : member 테이블의 zipcode 컬럼이 tb_zipcode 테이블의 zipcode 컬럼을 참조하고 있다.
drop table products;

-- 제약 조건 제거후에 테이블 삭제. (Foreign Key)
alter table member
drop constraint FK_MEMBER_ID_TB_ZIPCODE;

alter table orders
drop constraint FK_ORDERS_ID_MEMBER;

alter table orders
drop constraint FK_ORDERS_PRODUCT_CODE;

-- 제약 조건 확인
select * from user_constraints
where table_name = 'ORDERS';


drop table member ;

-- cascade constraints 옵션을 사용해서 삭제, <== Foreign Key 제약 조건을 먼저 제거후 삭제.

drop table member cascade constraints ;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table Orders cascade constraints;



-- 테이블 생성시(Foreign Key) : 부모테이블 (FK 참조 테이블) 을 먼저 생성해야 한다. 자식테이블 생성.
    -- 자식 테이블을 생성할 때 FK를 넣지 않고 생성 후, 부모테이블 생성후, Alter table 을 사용해서 나중에 FK를 넣어준다.
    

----------테이블 설계 ------------
CREATE TABLE tb_zipcode(
    zipcode VARCHAR2(7) NOT NULL CONSTRAINT PK_tb_zipcode_zipcode PRIMARY KEY,
    sido VARCHAR2(30),
    gugum VARCHAR2(30),
    dong VARCHAR2(30),
    bungi VARCHAR2(30)
    );
    
    
CREATE TABLE member(
    id VARCHAR(20) NOT NULL CONSTRAINT PK_member_id PRIMARY KEY,
    pwd VARCHAR(20),
    name VARCHAR(20),
    zipcode VARCHAR(7), CONSTRAINT FK_member_zipcode_tb_zipcode FOREIGN KEY (zipcode) REFERENCES tb_zipcode(zipcode)
    );

CREATE TABLE products (
    product_code VARCHAR2(20) NOT NULL CONSTRAINT PK_products_product_code PRIMARY KEY,
    product_name VARCHAR2(100),
    product_kind CHAR(1),
    product_price1 VARCHAR2(10),
    product_price2 VARCHAR2(10),
    product_content VARCHAR2(1000),
    product_image VARCHAR2(50),
    sizeSt VARCHAR2(5),
    sizeEt VARCHAR2(5),
    product_quantity VARCHAR2(5),
    useyn CHAR(1),
    indate DATE
    );
    
    CREATE TABLE orders(
    o_seq NUMBER(10) NOT NULL CONSTRAINT PK_orders_o_seq PRIMARY KEY,
    product_code VARCHAR2(20), CONSTRAINT FK_orders_product_code FOREIGN KEY (product_code) REFERENCES products(product_code),
    id VARCHAR2(16), CONSTRAINT FK_orders_id_member FOREIGN KEY (id) REFERENCES member(id),
    product_size VARCHAR2(5),
    quantity VARCHAR2(5),
    result CHAR(1),
    indate DATE
    );
    
    
    
    
-- zip.sql 적용시 실제 테이블과 다른 점을 수정해서 insert 하시오.

-- 트랜잭션 발생 : DML : insert, update, delete  <== commit

select * from tb_zipcode;

-- 1. 누락 컬럼 추가
alter table tb_zipcode
add zip_seq varchar2(30);

-- 2. 컬럼 이름 변경.
alter table tb_zipcode
rename column bungi to bunji;

alter table tb_zipcode
rename column gugum to gugun;

--3. 부족한 자리수 늘려주기
alter table tb_zipcode
modify ZIPCODE varchar2(100);

alter table tb_zipcode
modify DONG varchar2(100);

-- 제약 조건 잠시 비활성화 하기. (잠시 비활성화)  
    --      ==> Bulk Insert (대량으로 Insert) : 제약 조건으로 인해서 insert 되는 속도가 굉장히 느림.
    
    
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode    -- 오류 발생 : member 테이블의 zipcode 컬럼이 참조하고 있다.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;    -- Member 테이블의 FK 가 적용된 제약조건도 함께 disable

select constraint_name, table_name, status  from user_constraints
where table_name in ('MEMBER' , 'TB_ZIPCODE');

select * from tb_zipcode;

truncate table tb_zipcode;  -- 기존의 레코드만 모두 제거 (빠르게 모든 레코드 삭제)

delete tb_zipcode;      -- 기존의 레코드만 모두 제거 (삭제가 느리다 - 대량일 경우)
commit;


-- zip_seq 컬럼의 정렬이 제대로 안된 이유
    -- 문자 정렬형식으로 출력됨 , to_number로 숫자로 형변환후 정렬 
    
    
-- 제약 조건 수정 ( alter table) : 기존의 테이블에 제약 조건을 수정

create table emp_copy50
as
select * from employee;

create table dept_copy50
as
select * from department;


select * from emp_copy50;
select * from dept_copy50;

select * from user_constraints
where table_name in ( 'EMPLOYEE' , 'DEPARTMENT');

select * from user_constraints
where table_name in ( 'EMP_COPY50' , 'DEPT_COPY50');


-- 테이블을 복사하면 레코드만 복사가된다 . 테이블의 제약 조건은 복사되어 오지 않는다 
-- alter table을 사용해서 제약조건을 적용한다 
alter table emp_copy50
add constraint PK_EMP_COPY50_eno primary key (eno);

alter table dept_copy50
add constraint PK_DEPT_COPY50_dno primary key (dno);

alter table emp_copy50
add constraint FK_EMP_COPY50_dno foreign key (dno) references dept_copy50 (dno);

-- not null 제역 조건 추가 
    -- add 대신 modify를 사용 

-- not null을 넣지 않았지만 , primary key 제약 조건은 not null을 반드시 할당 
desc employee;
desc emp_copy50;
desc department;
desc dept_copy50;

-- 기존에 null이 들어가있는 곳에는 not null컬럼으로 지정할 수 없다
select ename from emp_copy50
where ename is null;

alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null;

-- commission 컬럼에 not null 할당하기
alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null ;  -- null이 있어서 오류

update emp_copy50
set commission = 0
where commission is null;    -- null을 없앤다 

-- Unique 제약 조건 추가 : 컬럼에 중복된 값이 있으면 할당하지 못한다
select ename , count(*)
from emp_copy50
group by ename
having count(*) >2;

alter table emp_copy50
add constraint UK_emp_copy50_ename unique (ename);


--check 제약 조건 추가

alter table emp_copy50
add constraint CK_emp_copy50_salary check (salary > 0 and salary < 30000);


-- default 제약 조건 추가 < 제약조건이 아님 : 제약조건 이름을 할당할 수 없다 >
    -- 값을 넣지 않을경우 default로 설정된 값이 들어간다
alter table emp_copy50
modify salary default 1000;

alter table emp_copy50
modify hiredate  default sysdate;

desc emp_copy50;
insert into emp_copy50 (eno,ename ,commission)
values (9998,'adff',100);

select * from emp_copy50;

insert into emp_copy50
values (8888 , 'qwer' , null , null , default , default, 1500, null);

-- 제약 조건 제거
alter table emp_copy50  -- 오류없이 제거됨
drop primary key ; 

alter table dept_copy50 -- 오류발생 : foreign key가 참조하고 있기 떄문에 삭제 안됨
drop primary key;

alter table dept_copy50 -- foreign key 를 먼저 제거하고 primary key 제거
drop primary key cascade;

select * from user_constraints
where table_name in ('EMP_COPY50' , 'DEPT_COPY50');

-- not null 컬럼 제거 하기 : 제약 조건 이름으로 삭제
alter table emp_copy50
drop constraints NN_EMP_COPY50_ENAME ; 

alter table emp_copy50
drop constraints NN_EMP_COPY50_COMMISSION ; 

-- unique , chect 제약조건 제거 <제약조건 이름으로 제거>
alter table emp_copy50
drop constraints UK_EMP_COPY50_ENAME ;

alter table emp_copy50
drop constraints CK_EMP_COPY50_SALARY ;

-- default 는 null 허용 컬럼은 default null 로 셋팅 : default 제약 조건을 제거 하는것 
alter table emp_copy50
modify hiredate default null;


/* 제약 조건 disable / enable
    - 제약조건을 잠시 중지 시킴
    - 대량(bulk insert ) 으로 값을 테이블에 추가할떄 부하가 많이 걸린다 
    - index를 생성시 부하가 많이 걸린다 
*/

alter table dept_copy50
add constraints PK_dept_copy50_dno primary key (dno);

alter table emp_copy50
add constraints PK_emp_copy50_eno primary key (eno);

alter table emp_copy50
add constraints FK_emp_copy50_dno foreign key (dno) references dept_copy50 (dno);

alter table emp_copy50
disable constraint FK_emp_copy50_dno;

insert into emp_copy50 (eno , ename ,  dno)
values (8989,'aaaa',50);

insert into dept_copy50
values (50,'HR','SEOUL');

alter table emp_copy50
enable constraint FK_emp_copy50_dno;




