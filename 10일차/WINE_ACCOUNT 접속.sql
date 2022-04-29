
-- grade_pt_rade 테이블
create table grade_pt_rade(
    mem_grade varchar2(20) not null constraint mem_grade_PK primary key, --회원등급
    grade_pt_rate number(3,2)   -- 등급별 마일리지율
);



insert into grade_pt_rade
values ( '실버' , 1);

insert into grade_pt_rade
values ( '골드' , 3);

insert into grade_pt_rade
values ( '플래티넘' , 5);
--------------------------------------------------------------------------

-- member 테이블
create table member ( 
    mem_id varchar2(6) not null constraint member_id_PK primary key,  --아이디
    mem_grade varchar2(20),     -- 회원등급
    constraint mem_grade_FK foreign key (mem_grade) references grade_pt_rade (mem_grade),
    mem_pw varchar2(20) not null,   -- 비밀번호
    mem_birth date default sysdate not null,    --생년월일
    mem_tel varchar2(20),       -- 전화번호
    mem_pt varchar2(10) default 0  not null     --마일리지 
);
select * from member;

insert into member
values ( 'aa' , '실버' , '1234' , default , '010-0000-0000' , '1000');

insert into member
values ( 'bb' , '골드' , '1234' , '200101' , '010-1111-1111' , '2000');

insert into member
values ( 'cc' , '플래티넘' , '1234' , '050505' , '010-2222-2222' , '3000');

--------------------------------------------------------------------------

-- today 테이블
create table today(
    today_code varchar2(6) constraint today_code_PK  primary key not null, -- 오늘의 와인코드 
    today_sens_values number(3),    -- 감성지수
    today_intell_values number(3),  -- 지성지수
    today_phy_values number(3)      -- 신체지수
);

insert into today
values( '1' , 1 , 11 , 111);

insert into today
values( '2' , 2 , 22 , 222);

insert into today
values( '3' , 3 , 33 , 333);

--------------------------------------------------------------------------


-- nation 테이블
create table nation (
     nation_code varchar2(26) NOT NULL constraint nation_code_PK primary key,  -- 국가코드
     nation_name varchar2 (50) NOT NULL   --국가 이름
);
insert into nation
values  ( '1'  , 'KOR' ) ;

insert into nation
values  ( '2'  , 'KOR' ) ;

insert into nation
values  ( '3'  , 'KOR' ) ;

--------------------------------------------------------------------------


--wine_type 테이블
create table wine_type(
    wine_type_code varchar2(6) NOT NULL constraint wine_type_code_PK primary key, --종류 코드
    wine_type_name varchar2(50)   --와인 종류 이름
);

insert into wine_type
values ( '1' , '와인1');

insert into wine_type
values ( '2' , '와인2');

insert into wine_type
values ( '3' , '와인3');

--------------------------------------------------------------------------


-- theme 테이블
create table theme(
    theme_code varchar2(6) NOT NULL primary key ,  --테마 코드
    theme_name varchar2(50) NOT NULL  -- 테마 이름
);

insert into theme
values ( '1' , '테마1');

insert into theme
values ( '2' , '테마2');

insert into theme
values ( '3' , '테마3');

--------------------------------------------------------------------------


-- wine 테이블
create table wine(
    wine_code varchar2(26) NOT NULL constraint wine_code_PK primary key, -- 와인 코드
    wine_name varchar2(100) NOT NULL,     --와인 이름
    wine_url blob,   -- 와인 사진저장
    nation_code varchar2(6) ,  --국가 코드
    constraint nation_code_FK foreign key (nation_code) references nation(nation_code),
    wine_type_code varchar2(6) ,  -- 종류 코드
    constraint wine_type_FK foreign key (wine_type_code) references wine_type(wine_type_code),
    wine_sugar_code number(2),    --당도별
    wine_price number(15) default 0 NOT NULL ,    --가격
    wine_vintage date ,      --생산년도
    theme_code varchar2(6) ,      --테마코드
    constraint theme_code_FK foreign key (theme_code) references theme(theme_code),
    today_code varchar2(6) ,    --오늘의 와인코드
    constraint today_code_FK foreign key (today_code) references today(today_code)
);

insert into wine 
values( '1' , '와인이름1' , 'a' , '1' , '1'  , 3 , 10000 , '19500101' , 1 , 1);

insert into wine 
values( '2' , '와인이름2' , 'b' , '2' , '2'  , 5 , 30000 , '19300501' , 2 , 2);

insert into wine 
values( '3' , '와인이름2' , 'c' , '2' , '3'  , 7 , 50000 , '19100301' , 3 , 3);


--------------------------------------------------------------------------


-- sale 테이블
create table sale (
    sale_date date default sysdate constraint sale_date_PK  primary key not null  , -- 판매날짜
    wine_code varchar2(6) not null ,    -- 와인코드
    constraint wine_code_FK foreign key(wine_code ) references wine (wine_code)  , 
    mem_id varchar2(30) not null,   -- 아이디
    constraint mem_id_FK foreign key(mem_id) references member(mem_id) ,
    sale_amount varchar2(5)  default 0 not null,    --판매수량
    sale_price varchar2(6)  default 0 not null,     -- 판매단가
    sale_tot_price varchar2(15)  default 0 not null     -- 판매수량
);

insert into sale
values ( default , 1 , 'aa' , default , default , default  );

insert into sale
values ( '20220420' , 2 , 'bb' , 5 ,  50000 , 0);

insert into sale
values ( '20220410' , 3 , 'cc' , 3 ,  150000 , 0);


--------------------------------------------------------------------------

--manager 테이블
create table manager(
   manager_id varchar2(30) NOT NULL constraint manager_id_PK primary key, -- 아이디
    manager_pwd varchar2(20) NOT NULL,  -- 비밀번호
    manager_tel varchar2(20)    -- 전화번호 
);

insert into manager
values ( 'id1' , '1111' , '010-1111-1111');

insert into manager
values ( 'id2' , '2222' , '010-2222-2222');

insert into manager
values ( 'id3' , '3333' , '010-3333-3333');

--------------------------------------------------------------------------


-- wine_db 테이블
create table wine_db(
    stock_code varchar2(6) NOT NULL constraint stock_code_PK primary key,     --재고 코드
    wine_code varchar2(6) ,    --와인 코드
    constraint wine_code_FK_wineDB foreign key (wine_code) references wine (wine_code),
    manager_id varchar2(30),       --아이디
    constraint manager_id_FK foreign key (manager_id) references manager (manager_id),
    ware_date date  default sysdate  NOT NULL ,   --입고일
    stock_amount number(5)  default 0 NOT NULL    -- 재고량
);

insert into wine_db
values( '1' , '1' , 'id1' , default , 100 );

insert into wine_db
values( '2' , '2' , 'id2' , '20220325' , 23 );

insert into wine_db
values( '3' , '3' , 'id3' , '20220402' , 56 );






































