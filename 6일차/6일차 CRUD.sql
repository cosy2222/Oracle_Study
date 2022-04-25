-- 6일차 - CRUD ( Create , Read , Update , Delete )

-- object ( 객체 ) : DataBase 의 존재 ( XE , <= Express edition (무료버젼),
--                                   stadard edition(유료) , enterprice edition (유료))
    -- 1. 테이블 , 2. 뷰  , 3. 저장프로시져  4. 트리거 , 5. 인덱스  , 6.함수 , 7. 시퀀스 <== DDL (create,alter,drop)

-- 테이블 생성 (Create)

/*
    create table 테이블명(
        컬럼명 자료형 널허용여부 [제약조건],
        컬럼명 자료형 널허용여부 [제약조건],
        컬럼명 자료형 널허용여부 [제약조건],
    )        
*/


create table dept(
    dno number(2) not null , 
    dname varchar2(14) not null,
    loc varchar2(13) null
    );
    
    
select * from dept;

-- DML : 테이블의 값(레코드 , 로우 )을 넣고(insert) , 수정(update) , 삭제 (delete)
        -- 트랜잭션을 발생 시킴 : log 에 기록을 먼저 하고 database 에 적용한다 
    
--begin transaction;    -- 트랜 잭션 시작   ( insert , update , delete 구문이 시작되면 자동으로 시작) 
--rollback;             -- 트랜 잭션을 롤백 ( RAM에 적용된 트랜잭션을 삭제)
--commit;               -- 트랜 잭션을 적용 ( 실제 Database에 영원히 적용)
    
/*
    insert into 테이블명 ( 컬럼명 , 컬렴명 , 컬럼명)
    values ( 값1 , 값2 , 값3 ) 
*/

insert into dept ( dno , dname , loc)
values ( 10 , 'MANAGER' , 'SEOUL');
    
    -- insert , update , delete 구문은 자동으로 트랜잭션이 시작   - RAM에만 적용되어 있는 상태
    
rollback ;         
commit;


/*  insert 시 컬럼명을 생략
    
    insert into dept
    values ( 값1 , 값2 , 값3)
    
*/

insert into dept 
values (20 , 'ACCOUNTING' , 'BUSAN');

commit;

/* null 허용 컬럼에 값을 넣지 않기 */
insert into dept( dno , dname )
values (30 , 'RESEARCH');

-- 데이터 유형에 맞지 않는 값을 넣으면 오류 발생 
insert into dept ( dno , dname , loc)
values ( 300 , 'SALES' , 'DAEGUE');   



-- 자료형 ( 문자 자료형) 
    -- char (10)   : 고정크기 10바이트 , 3바이트만 넣을 경우  빈공간 7바이트 생김 , 성능이 빠름 , 하드공간낭비 
            -- 자릿수를 알수 있는 고정크기 컬럼 ( 주민번호 , 전화번호)
     -- varchar2 (10) : 가변크기 10바이트 , 3바이트만 넣을경우 3바이트만 공간할당 , 성능이 느리고 , 하드공간낭비가 없음 
          -- 자릿수를 알수 없는 가변크기 컬럼  (주소, 메일주소)

    -- Nchar ( 10 ) : 유니코드 10자  ( 한글 , 중국어 , 일본어...) 
    -- Nvarchar2 (10) : 유니코드 10자 ( 한글 , 중국어 , 일본어...) 


-- 자료형 (숫자 자료형)
    -- number (2) : 정수 2자리만 입력 가능
    -- number ( 7,3 ) : 전체 7자리 , 소숫점 3자리까지 저장이됨 
    

create table test1_tbl (
    a number (3,2) not null,
    b number (7,5) not null,
    c char (6) null , 
    d varchar2 (10) null,
    e nchar (6) null ,
    f nvarchar2 (10) null
);

desc test1_tbl;
select * from test1_tbl;
insert into test1_tbl ( a,b,c,d,e,f)
values (3.22 , 77.55555 , 'aa' , 'aaa' , '한글여섯자까' , '안녕하세요반갑습니다');

commit;

-- 한글 1자는 3byte를 차지한다

create table member1 (
 no number  (10) not null,
 id varchar2 (50) not null,
 passws varchar2(50) not null,
 name Nvarchar2 (6) not null ,
 phone varchar2 (50) null,
 addres varchar2 (100) null,
 mdate date not null,
 email varchar2 (50) null );
 
 select * from member1;

insert into member1 ( no , id , passws , name , phone , addres , mdate  , email)
values ( 1, 'aaaa' , 'asdf' , '강성민' , '010-1111-1111' , '경기 의왕' , sysdate , 'aaa@aaa.com');
 
commit;

-- 데이터 수정 ( update : 데이터 수정후 commit ; )
        -- 반드시 where 조건을 사용해야 한다 , 그렇지 않으면 모든 레코드가 수정됨 
        
/*
    update 테이블명
    set 컬럼명 = 수정할갑
    where 컬럼명  = 값
*/        

update member1
set name = '민성강'
where no = 1;

commit;

update member1 
set name = '강성민' , id = 'abcd' , mdate = to_date('20220101' , 'yyyymmdd') , email = 'abcd@abcd.com'
where no = 1;

commit;

-- 레코드 ( 로우 ) , 삭제 ( delete  : 반드시 where 조건을 사용해야함 ) 

/*
    delete 테이블명
    where 컬럼명 = 값
*/

delete member1 
where no = 1;

commit;

/*
    update , delete 는 반드시 where 조건을 사용해야 한다  ,   트랜잭션을 종료 ( rollback ,commit)
    
    update , delete 시 where  절에 사용되는 컬럼은 고유한 컬럼이어야 한다 
    그렇지 않으면 여러 컬럼이 업데이트 되거나 삭제될 수 있다
*/

-- 중복된 값이 들어가면 다 바뀜 
update member1 
set name = '아아아'
where no = 1;   -- 1번 멤버는 이름이 다 바뀜

-- 제약조건 :  컬럼의 무결성을 확보하기 위해서 사용 , 무결성 : 결함없는 데이터 ( 즉 , 원하는 데이터만 저장 
    -- Primary Key
        -- 하나의 테이블에 한번만 사용
        -- not null  이 자동으로 적용    not null 생략가능 
        
create table member3 (
 no number  (10) not null primary key,
 id varchar2 (50) not null,
 passws varchar2(50) not null,
 name Nvarchar2 (6) not null ,
 phone varchar2 (50) null,
 addres varchar2 (100) null,
 mdate date not null,
 email varchar2 (50) null );        

-- primary key를 사용해서 no 에 중복된 값을 넣을수 없다 
insert into member3 ( no , id , passws , name , phone , addres , mdate  , email)
values ( 1, 'aaaa' , 'asdf' , '강성민' , '010-1111-1111' , '경기 의왕' , sysdate , 'aaa@aaa.com');

/*
    제약조건
        -- UNIQUE : 중복되지 않는 고유한 값을 저장 . 하나의 테이블에서 여러 컬럼에 지정 할 수 있다.
                -- null 을 허용함 , null은 한번만 저장할 수 있다 
*/

create table member4 (
 no number  (10) not null primary key, -- 중복된 값을 넣을수 없다  
 id varchar2 (50)  null UNIQUE, -- 중복된 값을 넣을 수 없다 
 passws varchar2(50) not null,
 name Nvarchar2 (6) not null ,
 phone varchar2 (50) null,
 addres varchar2 (100) null,
 mdate date not null,
 email varchar2 (50) null );    
 
 select * from member4;

insert into member4 ( no , id , passws , name , phone , addres , mdate  , email)
values ( 1, 'aaaa' , 'asdf' , '강성민' , '010-1111-1111' , '경기 의왕' , sysdate , 'aaa@aaa.com');

insert into member4 ( no , id , passws , name , phone , addres , mdate  , email)
values ( 2, 'bbbb' , 'asdf' , '강성민' , '010-1111-1111' , '경기 의왕' , sysdate , 'aaa@aaa.com');    
    







