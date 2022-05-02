--sys ���� 

-- autication ( ���� ) : credential ( ID + pass )
create user user_test10 identified by 1234; --sys�������� �ؾߵ�


-- Authorization ( �㰡) : system ���� �Ҵ� 
grant create session , create table , create view to user_test10;

-- ������ �����ϸ� system ���̺� �����̽��� ����Ѵ� .  <== �����ڸ� ����Ҽ� �ִ� ���̺� �����̽� 
-- ���̺� �����̽� �ٲٱ�  ( USERS )
alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- �뷮 �Ҵ�
ALTER USER "USER_TEST10" QUOTA UNLIMITED ON "USERS";


-- Ư�� �������� ��ü�� �����ϸ�  Ư�������� ��ü�� �����ϰ� �ȴ� 

select * from dba_tables
where owner in ( 'HR' , 'USER_TEST10');


-- �ٸ� ������� ���̺� �����ҷ��� ������ �������Ѵ� 
-- grant  : ���Ѻο�
grant select on hr.employee to user_test10;

grant select on hr.emp_copy1 to user_test10;
grant insert , update , delete on hr.emp_copy1 to user_test10;

--revoke : ���� ����
revoke insert , update , delete on hr.emp_copy1 from user_test10;


-- with grant option  : Ư�� �������� ������ �ο��ϸ鼭 �ش������ �ٸ�����ڿ��� �ο��� �� �ִ� ���� 
grant select on hr.employee to user_test10 with grant option;
        -- user_test10 ������ hr.employee ���̺� ���ؼ� �ٸ�����ڿ��� select ���� �ο� ���� 

grant select on hr.dept_copy1 to user_test10 with grant option;


/* Public : ��� ����ڿ��� ������ �ο��ϴ� ��. */

--hr�������� ���̺� ����
CREATE TABLE emp_copy56
as
SELECT * FROM employee;

--HR �������� Public �ɼ�(��� ����ڿ��� ���Ѻο�)
GRANT SELECT, INSERT, DELETE on hr.emp_copy56 to PUBLIC;

--USER_TEST10,--USER_TEST11 (�Ѵ� ����)
SELECT * FROM hr.emp_copy56;

/* �� (Role) : ���� ����ϴ� �������� ������ ���� ���� �� 

    1. dba : �ý����� ��� ������ ����� role, --sys(�ְ� ������ ����)
    2. connect : 
    3. resource : 
*/

-- ����� ���� Role ���� : ���� ����ϴ� ���ѵ��� ��� role�� ����
--1.�� ���� :
CREATE ROLE roletest1;
    
--2.�ѿ� ���ֻ���ϴ� ������ ����
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE TRIGGER
to roletest1;
    
--3. ������ ���� �������� ����
GRANT roletest1 to user_test10;

/*���� ���ӵ� ����ڿ��� �ο��� Role Ȯ��*/
SELECT * FROM user_role_privs;

/*�ѿ� �ο��� ���� ���� Ȯ��*/
SELECT * FROM role_sys_privs
WHERE role like 'DBA';

SELECT * FROM role_sys_privs
WHERE role like 'ROLETEST1';

/* ��ü ������ role �� �ο��ϱ� */
create role roletest2;

grant select on hr.employee to roletest2; -- �������� ��ü������ �����Ѱ��� �ƴ϶� role�� ����

grant roletest2 to user_test10;


-- �ǽ� 
create role roletest3;
grant select , insert , delete on hr.dept_copy57 to roletest3;
grant roletest3 to user_test10;










