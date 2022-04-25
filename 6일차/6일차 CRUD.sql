-- 6���� - CRUD ( Create , Read , Update , Delete )

-- object ( ��ü ) : DataBase �� ���� ( XE , <= Express edition (�������),
--                                   stadard edition(����) , enterprice edition (����))
    -- 1. ���̺� , 2. ��  , 3. �������ν���  4. Ʈ���� , 5. �ε���  , 6.�Լ� , 7. ������ <== DDL (create,alter,drop)

-- ���̺� ���� (Create)

/*
    create table ���̺��(
        �÷��� �ڷ��� ����뿩�� [��������],
        �÷��� �ڷ��� ����뿩�� [��������],
        �÷��� �ڷ��� ����뿩�� [��������],
    )        
*/


create table dept(
    dno number(2) not null , 
    dname varchar2(14) not null,
    loc varchar2(13) null
    );
    
    
select * from dept;

-- DML : ���̺��� ��(���ڵ� , �ο� )�� �ְ�(insert) , ����(update) , ���� (delete)
        -- Ʈ������� �߻� ��Ŵ : log �� ����� ���� �ϰ� database �� �����Ѵ� 
    
--begin transaction;    -- Ʈ�� ��� ����   ( insert , update , delete ������ ���۵Ǹ� �ڵ����� ����) 
--rollback;             -- Ʈ�� ����� �ѹ� ( RAM�� ����� Ʈ������� ����)
--commit;               -- Ʈ�� ����� ���� ( ���� Database�� ������ ����)
    
/*
    insert into ���̺�� ( �÷��� , �÷Ÿ� , �÷���)
    values ( ��1 , ��2 , ��3 ) 
*/

insert into dept ( dno , dname , loc)
values ( 10 , 'MANAGER' , 'SEOUL');
    
    -- insert , update , delete ������ �ڵ����� Ʈ������� ����   - RAM���� ����Ǿ� �ִ� ����
    
rollback ;         
commit;


/*  insert �� �÷����� ����
    
    insert into dept
    values ( ��1 , ��2 , ��3)
    
*/

insert into dept 
values (20 , 'ACCOUNTING' , 'BUSAN');

commit;

/* null ��� �÷��� ���� ���� �ʱ� */
insert into dept( dno , dname )
values (30 , 'RESEARCH');

-- ������ ������ ���� �ʴ� ���� ������ ���� �߻� 
insert into dept ( dno , dname , loc)
values ( 300 , 'SALES' , 'DAEGUE');   



-- �ڷ��� ( ���� �ڷ���) 
    -- char (10)   : ����ũ�� 10����Ʈ , 3����Ʈ�� ���� ���  ����� 7����Ʈ ���� , ������ ���� , �ϵ�������� 
            -- �ڸ����� �˼� �ִ� ����ũ�� �÷� ( �ֹι�ȣ , ��ȭ��ȣ)
     -- varchar2 (10) : ����ũ�� 10����Ʈ , 3����Ʈ�� ������� 3����Ʈ�� �����Ҵ� , ������ ������ , �ϵ�������� ���� 
          -- �ڸ����� �˼� ���� ����ũ�� �÷�  (�ּ�, �����ּ�)

    -- Nchar ( 10 ) : �����ڵ� 10��  ( �ѱ� , �߱��� , �Ϻ���...) 
    -- Nvarchar2 (10) : �����ڵ� 10�� ( �ѱ� , �߱��� , �Ϻ���...) 


-- �ڷ��� (���� �ڷ���)
    -- number (2) : ���� 2�ڸ��� �Է� ����
    -- number ( 7,3 ) : ��ü 7�ڸ� , �Ҽ��� 3�ڸ����� �����̵� 
    

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
values (3.22 , 77.55555 , 'aa' , 'aaa' , '�ѱۿ����ڱ�' , '�ȳ��ϼ���ݰ����ϴ�');

commit;

-- �ѱ� 1�ڴ� 3byte�� �����Ѵ�

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
values ( 1, 'aaaa' , 'asdf' , '������' , '010-1111-1111' , '��� �ǿ�' , sysdate , 'aaa@aaa.com');
 
commit;

-- ������ ���� ( update : ������ ������ commit ; )
        -- �ݵ�� where ������ ����ؾ� �Ѵ� , �׷��� ������ ��� ���ڵ尡 ������ 
        
/*
    update ���̺��
    set �÷��� = �����Ұ�
    where �÷���  = ��
*/        

update member1
set name = '�μ���'
where no = 1;

commit;

update member1 
set name = '������' , id = 'abcd' , mdate = to_date('20220101' , 'yyyymmdd') , email = 'abcd@abcd.com'
where no = 1;

commit;

-- ���ڵ� ( �ο� ) , ���� ( delete  : �ݵ�� where ������ ����ؾ��� ) 

/*
    delete ���̺��
    where �÷��� = ��
*/

delete member1 
where no = 1;

commit;

/*
    update , delete �� �ݵ�� where ������ ����ؾ� �Ѵ�  ,   Ʈ������� ���� ( rollback ,commit)
    
    update , delete �� where  ���� ���Ǵ� �÷��� ������ �÷��̾�� �Ѵ� 
    �׷��� ������ ���� �÷��� ������Ʈ �ǰų� ������ �� �ִ�
*/

-- �ߺ��� ���� ���� �� �ٲ� 
update member1 
set name = '�ƾƾ�'
where no = 1;   -- 1�� ����� �̸��� �� �ٲ�

-- �������� :  �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� ��� , ���Ἲ : ���Ծ��� ������ ( �� , ���ϴ� �����͸� ���� 
    -- Primary Key
        -- �ϳ��� ���̺� �ѹ��� ���
        -- not null  �� �ڵ����� ����    not null �������� 
        
create table member3 (
 no number  (10) not null primary key,
 id varchar2 (50) not null,
 passws varchar2(50) not null,
 name Nvarchar2 (6) not null ,
 phone varchar2 (50) null,
 addres varchar2 (100) null,
 mdate date not null,
 email varchar2 (50) null );        

-- primary key�� ����ؼ� no �� �ߺ��� ���� ������ ���� 
insert into member3 ( no , id , passws , name , phone , addres , mdate  , email)
values ( 1, 'aaaa' , 'asdf' , '������' , '010-1111-1111' , '��� �ǿ�' , sysdate , 'aaa@aaa.com');

/*
    ��������
        -- UNIQUE : �ߺ����� �ʴ� ������ ���� ���� . �ϳ��� ���̺��� ���� �÷��� ���� �� �� �ִ�.
                -- null �� ����� , null�� �ѹ��� ������ �� �ִ� 
*/

create table member4 (
 no number  (10) not null primary key, -- �ߺ��� ���� ������ ����  
 id varchar2 (50)  null UNIQUE, -- �ߺ��� ���� ���� �� ���� 
 passws varchar2(50) not null,
 name Nvarchar2 (6) not null ,
 phone varchar2 (50) null,
 addres varchar2 (100) null,
 mdate date not null,
 email varchar2 (50) null );    
 
 select * from member4;

insert into member4 ( no , id , passws , name , phone , addres , mdate  , email)
values ( 1, 'aaaa' , 'asdf' , '������' , '010-1111-1111' , '��� �ǿ�' , sysdate , 'aaa@aaa.com');

insert into member4 ( no , id , passws , name , phone , addres , mdate  , email)
values ( 2, 'bbbb' , 'asdf' , '������' , '010-1111-1111' , '��� �ǿ�' , sysdate , 'aaa@aaa.com');    
    







