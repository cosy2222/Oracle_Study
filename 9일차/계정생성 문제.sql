-- ��������
create user usertest02 IDENTIFIED by 1234;

--���� ����
grant create session to usertest02;

-- ���̺� ���� ����
grant create table to usertest02;

-- ���̺� �����̽� ����
alter user usertest02
default tablespace users
temporary tablespace temp;

-- ���� �Ҵ� 
alter user usertest02
quota 2m on users;


select * from all_tables -- ���̺��� �����ָ� ����� �ش� , �������� ������ ���̺��� ��� �� �� �ִ�
where owner in ( 'HR' , 'USERTEST01' , 'USERTEST01');



