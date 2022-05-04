
/*
        �������ν����� ����
            1. PL/SQL�� ��밡���ϴ�. �ڵ�ȭ
            2. ������ ������
                �Ϲ����� SQL ���� : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ ->������ -> ����
                �������ν��� ó������ : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ ->������ -> ����
                �������ν���   �ι��� ������� : ������  -> ����
            3. �Է� �Ű����� , ��� �Ű������� ����� �� �ִ�
            4. �Ϸ��� �۾��� ��� ���� ( ���ȭ�� ���α׷����� �����ϴ� ) .
*/


--  ���� ���ν��� ����

create procedure sp_salary
is 
    v_salary employee.salary%type;  -- �������ν����� is ������� ��������
begin 
    select salary into v_salary
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line('SCOTT�� �޿��� : ' || v_salary || '�Դϴ�');
       
end;
/


/*�������ν��� ������ Ȯ���ϴ� ������ ����*/
select * from user_source
where name = 'SP_SALARY';


-- �������ν��� ����
execute sp_salary; --��ü�̸�
exec sp_salary;     -- ����̸�


-- �������ν��� ����
create or replace procedure sp_salary  -- �������������� ���� , �����ϸ� ����
is 
    v_salary employee.salary%type;  -- �������ν����� is ������� ��������
    v_commission employee.commission%type;
begin 
    select salary , commission into v_salary , v_commission
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line('SCOTT�� �޿��� : ' || v_salary || '�Դϴ�  '  || '���ʽ� :' || v_commission || '�Դϴ�' );
       
end;
/


-- ���� ���ν��� ����
drop procedure sp_salary;


--------------<< ��ǲ �Ű������� ó���ϴ� ���� ���ν��� >> -----------------------------
create or replace procedure sp_salary_ename (   -- �Է� �Ű����� (in)  , ��� �Ű����� (out)���� ����
    v_ename in employee.ename%type      -- ������ in �ڷ���     !���� : ����� ; ���� �ȵ�!
)
is 
    v_salary employee.salary%type;
    
begin 
    select salary into v_salary     -- ����
    from employee
    where ename = v_ename;         --��ǲ �Ű�����
    
    dbms_output.put_line( v_ename || ' �� �޿��� ' || v_salary || '�Դϴ�');
end;
/

exec sp_salary_ename ('SCOTT');
exec sp_salary_ename ('SMITH');




-- �μ���ȣ ��ǲ ����
create or replace procedure  sp1 (
    v_dno employee.dno%type
)
is
v_emp employee%rowtype;
cursor c1
is 
   select * into v_emp
    from employee
    where dno = v_dno;

begin
    for v_emp in c1 loop
    dbms_output.put_line( v_emp.ename || '    ' || v_emp.job || '    ' || v_emp.dno);
    end loop;
end;
/
exec sp1 ( 30);


-- ���̺� �̸� ��ǲ����
create or replace procedure  sp2 (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(100);     -- SQL������ �����ϴ� ����
begin 
    v_sql := 'create table ' || v_name || ' as select * from employee';
    cursor1 := dbms_sql.open_cursor;                        -- Ŀ�����
    dbms_sql.parse (cursor1 , v_sql , dbms_sql.v7);         -- Ŀ���� ����ؼ� sql ������ ���� 
    dbms_sql.close_cursor(cursor1);                         -- Ŀ������
end;
/

grant create table to public ;    -- sys�������� ���� 

exec sp2 ('emp_copy33');

select * from emp_copy33;



---------------------- << ��� �Ű����� ��� >>------------------
/* ���� ���ν��� : ��� �Ű������� ���� (��������) ,    �Լ� : ��� �Ű������� �ϳ��� ���� 
        -- out Ű���带 ���
        -- ���� ���ν����� ȣ��� ���� ��� �Ű������� ���������� ȣ���� ���� 
        -- ȣ��� ��¸Ű����� �̸��տ�  ':������(��¸Ű�������)'
        -- ��� �Ű������� ����ϱ� ���ؼ� print��ɹ��̳� PL/SQL�� ����ؼ� ����� �� �ִ� 

*/


create or replace procedure sp_salary_ename2(
    v_ename in employee.ename%type,   -- �Է¸Ű�����
    v_salary out employee.salary%type
)
is

begin
    select salary into v_salary
    from employee
    where ename = v_ename;
end;
/


select * from user_source where name = 'SP_SALARY_ENAME2';  --������ �������� Ȯ��
-- �ּ� ���� ���� !
variable var_salary varchar2(50);       -- ȣ��ο��� �ƿ�ǲ �Ű������� ����                                         
exec sp_salary_ename2 ('SCOTT' , :var_salary);
print var_salary;


-- out �Ķ���͸� ������ ������ �������ν���  ���� �� ��� 
-- �����ȣ�� ��ǲ �޾Ƽ� ����̸� , �޿� , ��å�� out�Ķ���Ϳ� �Ѱ��ִ� ���ν��� 
create or replace procedure sel_empno(
    v_eno in number,
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
)
is

begin
    select ename , salary , job into v_ename , v_sal , v_job
    from employee
    where eno = v_eno;
end;
/

-- PL/SQL�� ����ؼ� �������ν��� ȣ�� 
declare 
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    -- �͸� ��Ͽ����� �������ν��� ȣ��� exec�� ������ �ʴ´� 
    sel_empno( 7788,var_ename,var_sal,var_job); -- �������ν��� ȣ��
    dbms_output.put_line('��ȸ��� : ' || var_ename || '   ' || var_sal || '   ' || var_job);
end;
/



/* �Լ� ( Funtion ) : ���� �־ �ϳ��� ���� ��ȯ �޾ƿ´�.   <== SQL���� ������ ��밡��
    -- �� ,  �������ν����� out �Ű������� ������ ��ȯ�޾ƿü� �ִ� <== SQL���� ���ּ��� ���Ұ�
*/

create or replace function fn_salary_ename ( 
    v_ename in employee.ename%type
)
return number   -- ȣ���ϴ� ������ ���� ������  , ������ �ڷ���
is
    v_salary number(7,2);
begin
    select salary into v_salary 
    from employee 
    where ename = v_ename;
    return v_salary;
end;
/

-- 1. �Լ����
variable var_salary number;
exec :var_salary := fn_salary_ename ('SCOTT');
print var_salary;


-- 2. �Լ���� ( SQL ���������� �Լ� ��� )
select ename , fn_salary_ename('SCOTT') ����
from employee 
where ename = 'SCOTT';



/*  Ʈ���� (Trigger ) 
        - ���̺� �����Ǿ� �ִ�
        - ���̺� �̺�Ʈ�� �߻��ɋ� �ڵ����� �۵��Ǵ� ���α׷� �ڵ� 
        - ���̺� �߻��Ǵ� �̺�Ʈ ( Insert , Update , Delete )
        - Ʈ���ſ��� ���ǵ� begin ~ end ������ ������ ����� 
        - before Ʈ����: ���̺��� Ʈ���Ÿ� ���� ������ insert , Update , Delete �� ����
        - after Ʈ���� : insert , update , delete �� ������ trigger�� ���� 
        -- ��) �ֹ� ���̺� ���� �־����� ��� ���̺� �ڵ����� ����
        -- ��) �߿� ���̺��� �α׸� ���涧�� ����
        -- :new   ������ �ӽ����̺� , Ʈ���Ű� ������ ���̺� ���Ӱ� ������ ���ڵ��� �ӽ� ���̺� 
        -- :old   ������ �ӽ����̺� , Ʈ���Ű� ������ ���̺��� �����Ǵ� ���ڵ��� �ӽ����̺� 
        -- Ʈ���Ŵ� �ϳ��� ���̺� �� 3������ ������ ( insert , update , delete ) 
*/


create table dept_original 
as
select * from department
where 0 = 1;

create table dept_copy
as
select * from department
where 0 =1;


-- Ʈ���� ���� ( dept_original ���̺� ���� ,insert �̺�Ʈ�� �߻��ɋ� �ڵ����� �۵�) 

create or replace trigger tri_sample1
        -- Ʈ���Ű� ������ ���̺� , �̺�Ʈ ( insert , update , delete ) , Before , After 
        after insert    -- insert �̺�Ʈ�� �۵��� Ʈ���Ű� �۵� ( begin ~ end ������ �ڵ� ) 
        on dept_original  -- on  ������ ���̺� 
        for each row    -- ��� row�� ���ؼ� 

begin             -- Ʈ���Ű� ������ �ڵ� 

    if inserting then 
        dbms_output.put_line('Insert Trigger �߻� ');        
        insert into dept_copy 
        values ( :new.dno , :new.dname, :new.loc); -- new ���� �ӽ� ���̺�
    end if;
end;
/


-- Ʈ���� Ȯ�� ������ ����
select * from user_source where name = 'TRI_SAMPLE1';

insert into dept_original 
values ( 13, 'PROGRAM2' , 'BUSAN2');

select * from dept_original;
select * from dept_copy;



-- delete Ʈ���� : dept_original ���� ���� ===> dept_copy������ ���� 
create or replace trigger  tri_del
    -- Ʈ���Ű� �۵���ų ���̺� , �̺�Ʈ 
    after delete   -- ���� ���̺��� delete�� ���������ϰ� trigger �۵� 
    on dept_original 
    for each row
begin
    dbms_output.put_line('delete trigger �߻� ');
    delete dept_copy
    where dept_copy.dno = :old.dno;
end;
/

delete dept_original
where dno = 13;

select * from dept_original;
select * from dept_copy;



-- update Ʈ����  : dept_original ���� update�ϸ� dept_copy������ update
create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_output.put_line(' update trigger �߻� ');
    update dept_copy
    set dept_copy.dname = :new.dname
    where dept_copy.dno = 12;
end;
/

update dept_original
set dname = '������'
where dno = 12;

select * from dept_original;
select * from dept_copy;
















































