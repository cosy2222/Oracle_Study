
-- grade_pt_rade ���̺�
create table grade_pt_rade(
    mem_grade varchar2(20) not null constraint mem_grade_PK primary key, --ȸ�����
    grade_pt_rate number(3,2)   -- ��޺� ���ϸ�����
);



insert into grade_pt_rade
values ( '�ǹ�' , 1);

insert into grade_pt_rade
values ( '���' , 3);

insert into grade_pt_rade
values ( '�÷�Ƽ��' , 5);
--------------------------------------------------------------------------

-- member ���̺�
create table member ( 
    mem_id varchar2(6) not null constraint member_id_PK primary key,  --���̵�
    mem_grade varchar2(20),     -- ȸ�����
    constraint mem_grade_FK foreign key (mem_grade) references grade_pt_rade (mem_grade),
    mem_pw varchar2(20) not null,   -- ��й�ȣ
    mem_birth date default sysdate not null,    --�������
    mem_tel varchar2(20),       -- ��ȭ��ȣ
    mem_pt varchar2(10) default 0  not null     --���ϸ��� 
);
select * from member;

insert into member
values ( 'aa' , '�ǹ�' , '1234' , default , '010-0000-0000' , '1000');

insert into member
values ( 'bb' , '���' , '1234' , '200101' , '010-1111-1111' , '2000');

insert into member
values ( 'cc' , '�÷�Ƽ��' , '1234' , '050505' , '010-2222-2222' , '3000');

--------------------------------------------------------------------------

-- today ���̺�
create table today(
    today_code varchar2(6) constraint today_code_PK  primary key not null, -- ������ �����ڵ� 
    today_sens_values number(3),    -- ��������
    today_intell_values number(3),  -- ��������
    today_phy_values number(3)      -- ��ü����
);

insert into today
values( '1' , 1 , 11 , 111);

insert into today
values( '2' , 2 , 22 , 222);

insert into today
values( '3' , 3 , 33 , 333);

--------------------------------------------------------------------------


-- nation ���̺�
create table nation (
     nation_code varchar2(26) NOT NULL constraint nation_code_PK primary key,  -- �����ڵ�
     nation_name varchar2 (50) NOT NULL   --���� �̸�
);
insert into nation
values  ( '1'  , 'KOR' ) ;

insert into nation
values  ( '2'  , 'KOR' ) ;

insert into nation
values  ( '3'  , 'KOR' ) ;

--------------------------------------------------------------------------


--wine_type ���̺�
create table wine_type(
    wine_type_code varchar2(6) NOT NULL constraint wine_type_code_PK primary key, --���� �ڵ�
    wine_type_name varchar2(50)   --���� ���� �̸�
);

insert into wine_type
values ( '1' , '����1');

insert into wine_type
values ( '2' , '����2');

insert into wine_type
values ( '3' , '����3');

--------------------------------------------------------------------------


-- theme ���̺�
create table theme(
    theme_code varchar2(6) NOT NULL primary key ,  --�׸� �ڵ�
    theme_name varchar2(50) NOT NULL  -- �׸� �̸�
);

insert into theme
values ( '1' , '�׸�1');

insert into theme
values ( '2' , '�׸�2');

insert into theme
values ( '3' , '�׸�3');

--------------------------------------------------------------------------


-- wine ���̺�
create table wine(
    wine_code varchar2(26) NOT NULL constraint wine_code_PK primary key, -- ���� �ڵ�
    wine_name varchar2(100) NOT NULL,     --���� �̸�
    wine_url blob,   -- ���� ��������
    nation_code varchar2(6) ,  --���� �ڵ�
    constraint nation_code_FK foreign key (nation_code) references nation(nation_code),
    wine_type_code varchar2(6) ,  -- ���� �ڵ�
    constraint wine_type_FK foreign key (wine_type_code) references wine_type(wine_type_code),
    wine_sugar_code number(2),    --�絵��
    wine_price number(15) default 0 NOT NULL ,    --����
    wine_vintage date ,      --����⵵
    theme_code varchar2(6) ,      --�׸��ڵ�
    constraint theme_code_FK foreign key (theme_code) references theme(theme_code),
    today_code varchar2(6) ,    --������ �����ڵ�
    constraint today_code_FK foreign key (today_code) references today(today_code)
);

insert into wine 
values( '1' , '�����̸�1' , 'a' , '1' , '1'  , 3 , 10000 , '19500101' , 1 , 1);

insert into wine 
values( '2' , '�����̸�2' , 'b' , '2' , '2'  , 5 , 30000 , '19300501' , 2 , 2);

insert into wine 
values( '3' , '�����̸�2' , 'c' , '2' , '3'  , 7 , 50000 , '19100301' , 3 , 3);


--------------------------------------------------------------------------


-- sale ���̺�
create table sale (
    sale_date date default sysdate constraint sale_date_PK  primary key not null  , -- �Ǹų�¥
    wine_code varchar2(6) not null ,    -- �����ڵ�
    constraint wine_code_FK foreign key(wine_code ) references wine (wine_code)  , 
    mem_id varchar2(30) not null,   -- ���̵�
    constraint mem_id_FK foreign key(mem_id) references member(mem_id) ,
    sale_amount varchar2(5)  default 0 not null,    --�Ǹż���
    sale_price varchar2(6)  default 0 not null,     -- �ǸŴܰ�
    sale_tot_price varchar2(15)  default 0 not null     -- �Ǹż���
);

insert into sale
values ( default , 1 , 'aa' , default , default , default  );

insert into sale
values ( '20220420' , 2 , 'bb' , 5 ,  50000 , 0);

insert into sale
values ( '20220410' , 3 , 'cc' , 3 ,  150000 , 0);


--------------------------------------------------------------------------

--manager ���̺�
create table manager(
   manager_id varchar2(30) NOT NULL constraint manager_id_PK primary key, -- ���̵�
    manager_pwd varchar2(20) NOT NULL,  -- ��й�ȣ
    manager_tel varchar2(20)    -- ��ȭ��ȣ 
);

insert into manager
values ( 'id1' , '1111' , '010-1111-1111');

insert into manager
values ( 'id2' , '2222' , '010-2222-2222');

insert into manager
values ( 'id3' , '3333' , '010-3333-3333');

--------------------------------------------------------------------------


-- wine_db ���̺�
create table wine_db(
    stock_code varchar2(6) NOT NULL constraint stock_code_PK primary key,     --��� �ڵ�
    wine_code varchar2(6) ,    --���� �ڵ�
    constraint wine_code_FK_wineDB foreign key (wine_code) references wine (wine_code),
    manager_id varchar2(30),       --���̵�
    constraint manager_id_FK foreign key (manager_id) references manager (manager_id),
    ware_date date  default sysdate  NOT NULL ,   --�԰���
    stock_amount number(5)  default 0 NOT NULL    -- ���
);

insert into wine_db
values( '1' , '1' , 'id1' , default , 100 );

insert into wine_db
values( '2' , '2' , 'id2' , '20220325' , 23 );

insert into wine_db
values( '3' , '3' , 'id3' , '20220402' , 56 );






































