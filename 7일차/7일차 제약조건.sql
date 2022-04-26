-- 7����   ��������

-- ���̺� ���� : ���̺��� ��ü�� ������ 
    -- ���̺��� �����ϸ� , �÷��� ���ڵ常 ���簡��
    -- ���̺��� �Ҵ�� ���������� ���� ���� �ʴ´�. ( Alter table �� ����ؼ� �Ҵ� �ؾ� �Ѵ�)
    -- ���� ���� : �÷��� �Ҵ�Ǿ� �ִ� 
        -- not null , primary key , foreign key , check

-- ���̺��� ��ü���ڵ带 ����
create table dept_copy
as
select * from department;

select * from dept_copy;

create table emp_copy
as
select * from employee;

select * from emp_copy;


-- ���̺� ���� : Ư�� �÷��� ���� 
create table emp_second
as
select eno , ename , salary , dno from employee;

select * from emp_second;


-- ���̺� ���� : ������ ����ؼ� ���̺� ����
create table emp_third
as
select eno , ename , salary
from employee
where salary > 2000;

select * from emp_third;

-- ���̺� ���� : �÷����� �ٲپ ����
create table emp_forth
as
select eno �����ȣ , ename ����� , salary ����
from employee;

select �����ȣ,�����,���� from emp_forth;  -- ���̺�� , �÷����� ������� ����


-- ���̺� ���� : ������ �̿��ؼ� ���̺� ���� : �ݵ�� ��Ī �̸��� ����ؾ� �Ѵ� 
create table emp_fifth
as
select eno , ename , salary * 12 as salary from employee;

select * from emp_fifth;


-- ���̺� ���� : ���̺� ������ ���� , ���ڵ�� �������� �ʴ´� 
create table emp_six
as
select * from employee
where 0=1;           -- where ���� : false�� ���� 

select * from emp_six;
desc emp_six;


-- ���̺� ���� : alter table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- ������ ���̺��� �÷��� �߰���  : �ݵ�� �߰��� �÷��� null�� ����ؾ� �Ѵ� 
alter table dept20
add (birth date);

alter table dept20
add ( email varchar2 (100) not null);  -- not null ������ ����


-- �÷��� �ڷ����� ���� : modify
alter table dept20
modify dname varchar2 (100);

desc dept20;


-- Ư�� �÷��� ���� : ���ϰ� ���� �ɸ��� �ִ�
alter table dept20
drop column birth;

select * from dept20;

-- �÷��� �����ÿ� ���ϱ� ���� �߻��̵� 
        -- set unused : Ư�� �÷��� ��� ���� 
alter table dept20
set UNUSED (loc);
        
desc dept20;

alter table dept20
drop unused column;  -- ������� �ʴ� �÷� ����

-- �÷� �̸� ����
alter table dept20
rename column DNO to ddd;

-- ���̺� �̸� ����
rename dept20 to dept30;

desc dept30;


/*
    DDL : create(����) , alter(����)  ,drop(����)
        <<��ü>>
            ���̺� , ��  , �ε��� , Ʈ���� , ������ , �Լ� , �������ν���....
            
    DML : insert ( ���ڵ� �߰� ) , update (���ڵ� ����) , Delete(���ڵ� ����)
        << ���̺��� �� (���ڵ� , �ο�) >>
            
    DQL : select
    
    
    ���̺��� ��ü �����̳� ���̺� ������
    1. delete   : ���̺��� ���ڵ带 ���� , where �� ������� ������ ��� ���ڵ� ����
    2. truncate : ���̺��� ���ڵ带 ���� , �ӵ��� ������ ����
    3. drop     : ���̺� ��ü�� ���� 
            
*/

create table emp30 
as
select * from employee;

select * from emp20;

-- emp 10 : delete ���
delete emp10;
commit;

-- emp 20 : truncate ���
truncate table emp20;

-- emp 30 : drop ���
drop table emp30;





/*
    ������ ���� : �ý����� ���� ������ ����� �ִ� ���̺�
      user_   : �ڽ��� ������ ���� ��ü������ ���
      all_    : �ڽ��� ������ ������ ��ü�� ������ �ο� ���� ��ü ������ ���
      dba_    : ������ ���̽� �����ڸ� ���� ������ ��ü ������ ���.
*/

show user;
select * from user_tables;        -- ����ڰ� ������ ���̺� ���� ���
select table_name from user_tables;
select * from user_views;         -- ����ڰ� ������ �信 ���� ���� ���
select * from user_indexes;       -- ����ڰ� ������ �ε��� ����
select * from user_constraints;   -- ���� ���� Ȯ��

select * from user_constraints
where table_name = 'EMPLOYEE';
select * from user_sequences;

select * from all_tables;
select * from all_views;

select * from dba_tables;   -- ������ ���������� ���� ����

/*
    ���� ���� : ���̺��� ���Ἲ�� Ȯ�� �ϱ� ���ؼ� �÷��� �ο��Ǵ� ��Ģ.
            1. primary key
            2. unique 
            3.not null 
            4. check
            5. foreign key
            6. default
*/


--1 : primary key : �ߺ��� ���� ������ ����

 -- a. ���̺� ������ �÷��� �ο�
    -- ���������̸��� �������� ���� ���  oracle���� ������ �̸����� ����
        -- ���������� �����ҋ� ���������̸��� ���
    create table customer01(
        id varchar2(20) not null  constraint pk_customer01_id primary key,
        pwd varchar2(20) constraint NN_customer01_pwd not null ,
        name varchar2(20) constraint NN_customer01_name not null ,
        phone varchar2(30) null,
        address varchar2(100) null
    );
    
    select * from user_constraints
    where table_name = 'CUSTOMER01';
    
    
-- ���̺��� �÷� ������ ���� ���� �Ҵ�
    create table customer02(
        id varchar2(20) not null  ,
        pwd varchar2(20) constraint NN_customer02_pwd not null ,
        name varchar2(20) constraint NN_customer02_name not null ,
        phone varchar2(30) null,
        address varchar2(100) null,
        constraint pk_customer02_id primary key (id)
    );


/*
    foreign key ( ����Ű ) : �ٸ� ���̺�(�θ�)�� primary key , unique �÷��� �����ؼ� ���� �Ҵ�
    check : �÷��� ���� �Ҵ��Ҷ� check �� �´� ���� �Ҵ�
*/

-- �θ� ���̺�
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
values ('������' , 30 , 'M' ,1);

insert into parentTbl
values ('������' , 300 , 'a' ,1);  -- ���� �߻�  : 300 (check) , K (ckeck) ,  1 (primary key) 

insert into parentTbl
values ('����' , 40 , 'M' ,2);

-- �ڽ� ���̺�
create table ChileTbl(
    id varchar2 (40) constraint PK_ChildTbl_id primary key,
    pw varchar2(40) ,
    infono number ,
    constraint FK_ChildTbl_infono foreign key (infono) references ParentTbl(infono)
);

insert into ChileTbl 
values ('aaa' , '1234' , 3);  --  3  foreign key ����

insert into ChileTbl 
values ('aaa' , '1234' , 1);

insert into ChileTbl 
values ('bbb' , '1234' , 2);

select * from chiletbl;



--�θ� ���̺�
create table parenttbl2 (
    dno number(2) not null primary key ,
    dname varchar2(50) ,
    loc varchar2 (50)
);

insert into parenttbl2
values ( 10 , 'SALES' , 'SEOUL');


-- �ڽ����̺�
create table childTbl2 (
    no number not null,
    ename varchar2(50),
    dno number(2) not null ,
    foreign key (dno) reference parenttbl2 (dno)
    );
insert into childtbl2
values (1, 'PARK' , 20);


-- default ���� ���� : ���� �Ҵ� ���� ������ default ���� �Ҵ�

create table emp_sample01 (
    eno number(4) not null primary key ,
    ename varchar(50),
    salary number(7,2) default 1000
);

-- default �÷��� ���� �Ҵ��� ���
insert into emp_sample01
values ( 1111 , '������' , 1500);

-- default �÷��� ���� �Ҵ����� ���� ���  , default�� �Ҵ�� ���� ����
insert into emp_sample01 (eno , ename)
values (2222, '������');



insert into emp_sample01
values (3333, '������' , default);

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
values ( 1 ,'������' , default , 25 , 'M' , 10);

insert into member10
values ( 2 ,'������2' , default , 25 , 'M' , 20);

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





