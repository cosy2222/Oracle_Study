/*
    ������ : �ڵ� ��ȣ �߻���
        -- ��ȣ�� �ڵ� �߻��� �Ǹ� �ڷ� �ǵ��� �� ����  ( ������ �ٽû��� �ؾߵ�)
        -- primary key �÷��� ��ȣ�� �ڵ����� �߻���ŰŰ ���ؼ� ���

*/

-- �ʱⰪ : 10 , ������ : 10
create sequence sample_seq
    increment by 10         -- ������
    start with 10 ;         -- �ʱⰪ
    
--�������� ������ ����ϴ� ������ ����
select * from user_sequences;

select sample_seq.nextval from dual ;   -- �������� ���� ���� ���
select sample_seq.currval from dual ;   -- ���� �������� ���� ���


-- �ʱⰪ : 2 , ������ : 2
create sequence sample_seq2
    INCREMENT by 2
    start with 2
    nocache ;         --ĳ���� ������� �ʰڴ�   
    
select sample_seq2.nextval from dual ;  
select sample_seq2.currval from dual ;  

-- �������� primary key �� �����ϱ�

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
        sequence �� cache���� ����ϴ� ��� , ������� �ʴ� ���
        -- cache : ������ ������ ����ϱ� ���ؼ� ��� ( �⺻�� : 20 ��)
        -- ������ �ٿ�� ��� : ĳ���� �ѹ����� ��� ���� . ���ο� ���� �Ҵ� �޴´� 
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

-- �������� ���̺��� Ư�� �÷��� ����
insert into emp_copy80
values ( emp_seq_no.nextval , 'SMITH' , 'SALESMAN' , 2222 , sysdate , 3000 , 0 , 10);


-- ������ ������ ����
select * from user_sequences;

alter sequence emp_seq_no
    maxvalue 1000;      -- �ִ밪
    
alter sequence emp_seq_no
    cycle ;   -- �ִ밪�� ����ǰ� �ٽ� ó������ ��ȯ
-- nocycle  : cycle ��Ȱ��ȭ 

drop sequence  sample_seq;    -- ������ ����

    
/*
    INDEX : ���̺��� �÷��� ���� , Ư���÷��� �˻��� ������ ����� �� �ֵ��� �Ѵ�
        - index page  : �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��Ƴ��� �������� index page��� �Ѵ�
            -- DB������ 10% ���� 
        - ����(index) : å�� ���� , å�� ������ �߿� Ű���带 �����ؼ� ��ġ�� �˷���
        - ���̺� ��ĵ : ���ڵ��� ó�� ~ ������ ���� �˻� ( �˻� �ӵ��� ������ ) . �ε����� ������� �ʰ� �˻�
                - index�� �����Ǿ����� �ʴ� �÷��� ���̺�ĵ�� �Ѵ� 
        - primary key , unique �� ����� �÷��� index page �� �����Ǿ� �˻��� ������ �Ѵ�
        - where ������ ���� �˻��� �ϴ� �÷��� index�� ���� 
        - ���̺��� �˻��� �����ϴ� �÷��� index���� , ���̺� ��ĵ�� �����ʰ� index page�� �˻��ؼ� ��ġ�� ������ ã�´�
        - index �� �����ҋ� ���ϰ� ���� �ɸ��� 

*/

-- index������ ����Ǿ� �ִ� ������ ���� . 
    -- user_columns ,  user_ind_columns
    
select * from user_tab_columns;
select * from user_ind_columns;
    
select index_name , table_name , column_name
from user_ind_columns
where table_name in ( 'EMPLOYEE' , 'DEPARTMENT');
    
select * from employee;  -- eno �÷��� primary key  <== �ڵ����� index�� ������

/*
    index �ڵ� ���� , ( primary key , unique )  �÷����� index page�� �ڵ����� �����ȴ� 
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
where ename  = 'KING';  -- ename �÷��� index�� �����Ƿ� king�� �˻��ϱ� ���ؼ� ���̺� ��ĵ�Ѵ� 

select * from emp_copy90
where job  = 'SALESMAN'; 
    
    
-- ename �÷���index �����ϱ�  ( ���ϰ� ���̰ɸ� ) 

-- �÷��� index�� �����Ǿ� ���� ������ ���̺� ��ĵ�� �Ѵ� , ó������ �ϳ��ϳ� �˻��Ѵ�
-- �÷��� index�� �����Ǿ� ������ index page (å�� ���� ) �� �˻��Ѵ� 
create index id_emp_ename
on emp_copy90(ename);
    
drop index id_emp_ename;    


/*
    index�� �ֱ������� rebuild ����� �Ѵ�  ,
        index�� �������� ( insert , update , delete ) ����ϰ� �Ͼ��
*/

-- index rebuild �� �ؾ��ϴ� ���� ��� : index��  tree���̰� 4�̻��� ��찡 ��ȸ�� �Ǹ� rebuild �� �ʿ䰡 �ִ�
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild :
alter index  id_emp_ename rebuild;  -- index�� ���Ӱ� ���� 

select * from emp_copy90;


/*
    index�� ����ؾ� �ϴ� ��� 
        1. ���̺��� �� ( �ο�, ���ڵ� ) �� ������ ���� ���  
        2. where ������ ���� ���Ǵ� �÷� 
        3. join�� ���Ǵ� Ű �÷�
        4. �˻� ����� ���� ���̺� �������� 2% ~ 4%���� �Ǵ°�� 
        5. �ش� �÷��� null �� �����ϴ� ��� ( ������ null�� ����)
        
    index�� ����ϸ� ������ ���
        1. ���̺��� ���� ������ ���� ���
        2. �˻� ����� ���� ���̺��� ���� ������ �����ϴ� ���
        3. insert , update , delete �� ����ϰ� �Ͼ�� �÷�
        
*/

/*
    index ����
       1. ���� �ε��� ( unique index ) : �÷��� �ߺ����� �ʴ� ������ ���� ���� index ( primary key , unique )
       2. ���� �ε��� ( single index ) : �� �÷��� �ο��Ǵ� index
       3. ���� �ε��� ( composite index ) : ���� �÷��� ��� ������ index 
       4. �Լ� �ε��� ( function base index ) : �Լ��� ������ �÷��� ������ index 
*/

select * from emp_copy90;

-- ���� �ε��� ����
create index inx_emp_copy90_salary
on emp_copy90 ( salary) ;

-- ���� �ε��� ���� : ���÷��̻��� �����ؼ� �ε��� ����
create table dept_copy91
as
select * from department;

create index idx_dept_copy_dname_loc
on dept_copy91 (dname , loc);

select index_name , table_name , column_name
from user_ind_columns
where table_name in ( 'DEPT_COPY91');

-- �Լ� ��� �ε��� : �Լ��� ������ �÷��� �ο��Ǵ� index 
create table emp_copy91
as 
select * from employee;

create index idx_empcopy91_allsal
on emp_copy91 (salary * 12);        -- �÷��� �Լ� , ������ ������ �ε��� 

-- �ε��� ���� 
drop index idx_empcopy91_allsal;


-- ���� ����
/*
    ������  : DBMS�� �������� ���
        -- �� ����ں��� ������ ���� : DBMS�� ������ �� �ִ� ����ڸ� ����
             ���� ( Authentication : Credential ( Identity + password) Ȯ�� 
             �㰡 ( Authorization : ������ ����ڿ��� oracle�� �ý��� ���� , ��ü ����
                - system privileges : ����Ŭ�� �������� ���� �Ҵ�
                - Object privileges : ���̺� , �� , Ʈ���� , �Լ� ,�������ν��� , ������ , �ε���   ���ٱ���
*/


-- oracle ���� ���� ����  :  �Ϲݰ��������� ������������ ���� 
create user usertest01  identified by 1234;


















