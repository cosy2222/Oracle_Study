show user;

-- �ְ� ������ ���� (sys) : ������ ������ �� �ִ� ������ ������ �ִ�
-- ���̵� : usertest01 , ��ȣ : 1234
create user usertest01  identified by 1234;

-- ������ ��ȣ�� �����ϰ�  ����Ŭ�� ������ �� �ִ� ������ �ο� �޾ƾ� ���� ����

--system privileges:
    -- create session : ����Ŭ�� ���� �� �� �ִ� ����
    -- create table   : ����Ŭ���� ���̺��� ���� �� �� �ִ� ����.
    -- create sequence  : ������ ������ �� �ִ� ���� 
    -- create view : �並 ���� �� �� �ִ� ���� 
    

DDL : ��ü ���� ( Create , Alter , drop )
DML : ���ڵ� ���� ( INSERT , UPDATE , DELETE)
DQL : ���ڵ� �˻� ( SELECT)
DTL : Ʈ����� ( BEGIN transaction , rollback , commit)
DCL : ���� ���� ( GRANT , REVOKE , DENY )

-- ������ �������� ����Ŭ�� ������ �� �ִ� create session ������ �ο�
-- grant �ο��ұ��� to ������
grant create session to usertest01;

-- ����Ŭ�� �����ص� ���̺����ٱ����� ����  ���̺� ���ٱ��� �ο�����ߵ� 
grant create table to usertest01;


/*
    ���̺� �����̽� : ��ü�� �����ϴ� ����
        - ������ �������� �� ����ں� ���̺� �����̽��� Ȯ�� 
    system : dba ( ������ ���������� ���� ����) 
*/

select * from dba_users ;   -- dba_ : sys (�ְ� ������ �������� Ȯ��)

select username , default_tablespace as dataFile ,  temporary_tablespace as Logfile
from dba_users
where username in ( 'HR' , 'USERTEST01');

-- �������� ���̺� �����̽� ���� ( SYSTEM == > USERS) ����
alter user usertest01
default tablespace users        -- dataFIle ���� : ��ü�� �����ϴ� ����
temporary tablespace temp;      -- log �� ���� : DML

-- ���̺� �����̽� : ��ü�� log�� �����ϴ� �������� ����
    -- DATAFILE : ��ü�� �����ϰ� �ִ�
    -- log      : transaction log �� ���� 
    
    -- DataFile �� log ������ ���������� �ٸ� �ϵ������ �����ؾ� ������ ���ϼ� ���� 
        -- RAID�� ������ �����ϸ� ������ ���� �� �ִ� 

-- �������� users ���̺� �����̽��� ����Ҽ� �ִ� ���� �Ҵ� ( users ���̺� �����̽��� 2mb ��� ���� �Ҵ� 
alter user usertest01
quota 2m on users;








