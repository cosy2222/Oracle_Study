/*
    시퀀스 : 자동 번호 발생기
        -- 번호가 자동 발생이 되면 뒤로 되돌릴 수 없다  ( 삭제후 다시생성 해야됨)
        -- primary key 컬럼에 번호를 자동으로 발생시키키 위해서 사용

*/

-- 초기값 : 10 , 증가값 : 10
create sequence sample_seq
    increment by 10         -- 증가값
    start with 10 ;         -- 초기값
    
--시퀀스의 정보를 출력하는 데이터 사전
select * from user_sequences;

select sample_seq.nextval from dual ;   -- 시퀀스의 다음 값을 출력
select sample_seq.currval from dual ;   -- 현재 시퀀스의 값을 출력


-- 초기값 : 2 , 증가값 : 2
create sequence sample_seq2
    INCREMENT by 2
    start with 2
    nocache ;         --캐쉬를 사용하지 않겠다   
    
select sample_seq2.nextval from dual ;  
select sample_seq2.currval from dual ;  

-- 시퀀스를 primary key 에 적용하기

create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;

create sequence dept_seq
    INCREMENT by 10
    start with 10
    nocache;
    
    /*
        sequence 에 cache를ㄹ 사용하는 경우 , 사용하지 않는 경우
        -- cache : 서버의 성능을 향상하기 위해서 사용 ( 기본값 : 20 개)
        -- 서버가 다운된 경우 : 캐쉬된 넘버링이 모두 날라감 . 새로운 값을 할당 받는다 
    */

insert into dept_copy80 (dno,dname,loc)
values ( dept_seq.nextval , 'HR' , 'SEOUL');



create sequence emp_seq_no
    INCREMENT by 1
    start with 1
    nocache ;
    
create table emp_copy80
as
select * from employee
where 0=1;

select * from emp_copy80;

-- 시퀀스를 테이블의 특정 컬럼에 적용
insert into emp_copy80
values ( emp_seq_no.nextval , 'SMITH' , 'SALESMAN' , 2222 , sysdate , 3000 , 0 , 10);


-- 기존의 시퀀스 수정
select * from user_sequences;

alter sequence emp_seq_no
    maxvalue 1000;      -- 최대값
    
alter sequence emp_seq_no
    cycle ;   -- 최대값이 적용되고 다시 처음부터 순환
-- nocycle  : cycle 비활성화 

drop sequence  sample_seq;    -- 시퀀스 삭제

    
/*
    INDEX : 테이블의 컬럼에 생성 , 특정컬럼의 검색을 빠르게 사용할 수 있도록 한다
        - index page  : 컬럼의 중요 키워드를 걸러서 위치 정보를 담아놓는 페이지를 index page라고 한다
            -- DB공간의 10% 정도 
        - 색인(index) : 책의 색인 , 책의 내용의 중요 키워드를 수집해서 위치를 알려줌
        - 테이블 스캔 : 레코드의 처음 ~ 마지막 까지 검색 ( 검색 속도가 느리다 ) . 인덱스를 사용하지 않고 검색
                - index가 생성되어있지 않는 컬럼은 테이블스캔을 한다 
        - primary key , unique 가 적용된 컬럼은 index page 가 생성되어 검색을 빠르게 한다
        - where 절에서 자주 검색을 하는 컬럼에 index를 생성 
        - 테이블의 검색을 자주하는 컬럼에 index생성 , 테이블 스캔을 하지않고 index page를 검색해서 위치를 빠르게 찾는다
        - index 를 생성할떄 부하가 많이 걸린다 

*/

-- index정보가 저장되어 있는 데이터 사전 . 
    -- user_columns ,  user_ind_columns
    
select * from user_tab_columns;
select * from user_ind_columns;
    
select index_name , table_name , column_name
from user_ind_columns
where table_name in ( 'EMPLOYEE' , 'DEPARTMENT');
    
select * from employee;  -- eno 컬럼에 primary key  <== 자동으로 index가 생성됨

/*
    index 자동 생성 , ( primary key , unique )  컬럼에는 index page가 자동으로 생성된다 
*/

create table tbl1 (
    a number (4) constraint PK_tbl1_a primary key,
    b number (4) ,
    c number (4) 
);

select index_name , table_name , column_name
from user_ind_columns
where table_name in ( 'TBL1', 'TBL2' , 'EMPLOYEE' , 'DEPARTMENT');

select * from tbl1;

create table tbl2(
    a number (4)  constraint PK_tbl2_a primary key,
    b number (4)  constraint UK_tbl2_b unique,
    c number (4)  constraint UK_tbl2_c unique,
    d number (4),
    e number (4)
);


create table emp_copy90
as
select * from employee;

select * from emp_copy90
where ename  = 'KING';  -- ename 컬럼에 index가 없으므로 king을 검색하기 위해서 테이블 스캔한다 

select * from emp_copy90
where job  = 'SALESMAN'; 
    
    
-- ename 컬럼에index 생성하기  ( 부하가 많이걸림 ) 

-- 컬럼에 index가 생성되어 있지 않으면 테이블 스캔을 한다 , 처음부터 하나하나 검색한다
-- 컬럼에 index가 생성되어 있으면 index page (책의 목차 ) 를 검색한다 
create index id_emp_ename
on emp_copy90(ename);
    
drop index id_emp_ename;    


/*
    index는 주기적으로 rebuild 해줘야 한다  ,
        index는 조각난다 ( insert , update , delete ) 빈번하게 일어나면
*/

-- index rebuild 를 해야하는 정보 얻기 : index의  tree깊이가 4이상인 경우가 조회가 되면 rebuild 할 필요가 있다
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild :
alter index  id_emp_ename rebuild;  -- index를 새롭게 빌드 

select * from emp_copy90;


/*
    index를 사용해야 하는 경우 
        1. 테이블의 행 ( 로우, 레코드 ) 의 갯수가 많은 경우  
        2. where 절에서 자주 사용되는 컬럼 
        3. join시 사용되는 키 컬럼
        4. 검색 결과가 원본 테이블 데이터의 2% ~ 4%정도 되는경우 
        5. 해당 컬럼이 null 을 포함하는 경우 ( 색인은 null을 제외)
        
    index를 사용하면 안좋은 경우
        1. 테이블의 행의 갯수가 적은 경우
        2. 검색 결과가 원본 테이블의 많은 비중을 차지하는 경우
        3. insert , update , delete 가 빈번하게 일어나는 컬럼
        
*/

/*
    index 종류
       1. 고유 인덱스 ( unique index ) : 컬럼의 중복되지 않는 고유한 값을 갖는 index ( primary key , unique )
       2. 단일 인덱스 ( single index ) : 한 컬럼에 부여되는 index
       3. 결합 인덱스 ( composite index ) : 여러 컬럼을 묶어서 생성한 index 
       4. 함수 인덱스 ( function base index ) : 함수를 적용한 컬럼에 생성한 index 
*/

select * from emp_copy90;

-- 단일 인덱스 생성
create index inx_emp_copy90_salary
on emp_copy90 ( salary) ;

-- 결합 인덱스 생성 : 두컬럼이상을 결합해서 인덱스 생성
create table dept_copy91
as
select * from department;

create index idx_dept_copy_dname_loc
on dept_copy91 (dname , loc);

select index_name , table_name , column_name
from user_ind_columns
where table_name in ( 'DEPT_COPY91');

-- 함수 기반 인덱스 : 함수를 적용한 컬럼에 부여되는 index 
create table emp_copy91
as 
select * from employee;

create index idx_empcopy91_allsal
on emp_copy91 (salary * 12);        -- 컬럼에 함수 , 계산식을 적용한 인덱스 

-- 인덱스 삭제 
drop index idx_empcopy91_allsal;


-- 권한 관리
/*
    사용권한  : DBMS는 여러명이 사용
        -- 각 사용자별로 계정을 생성 : DBMS에 접속할 수 있는 사용자를 생성
             인증 ( Authentication : Credential ( Identity + password) 확인 
             허가 ( Authorization : 인증된 사용자에게 oracle의 시스템 권한 , 객체 권한
                - system privileges : 오라클의 전반적인 권한 할당
                - Object privileges : 테이블 , 뷰 , 트리거 , 함수 ,저장프로시저 , 시퀀스 , 인덱스   접근권한
*/


-- oracle 에서 계정 생성  :  일반계정에서는 계정생성권한 없음 
create user usertest01  identified by 1234;


















