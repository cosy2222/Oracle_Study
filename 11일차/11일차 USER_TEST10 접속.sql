create table test10tbl (
    a number not null ,
    b varchar2(50) null );
    

-- user_test10���� hr�� �������� employee ���̺� �����Ҷ�  ��ü�� ���ٱ����� �ʿ��ϴ�
-- �ٸ� ������� ���̺�� �տ� �����ָ� �����ϸ� �ȵȴ� 
select * from hr.employee;
-- �⺻������ �ڽ��� ��ü�� ����Ҷ� ������ �������� 

-- �ٸ� ����� ���̺� insert ���� 
select * from hr.emp_copy1;
desc hr.emp_copy1;

insert into hr.emp_copy1 (eno)
values ( 3333);


-- with grant option �ο����� 
grant select on hr.employee to user_test11;



select * from hr.dept_copy1;
grant select on hr.dept_copy1 to user_test11;
























