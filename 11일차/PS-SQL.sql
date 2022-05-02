-- PL / SQL : ����Ŭ���� ���α׷��� ��Ҹ� ������ SQL        �����ϰ� ó���ؼ� ���
--      SQL : ����ȭ�� ���Ǿ��     ���� : ������ ���α׷��� ����� ������ �� ����

set serveroutput on  -- PL/SQL�� ����� Ȱ��ȭ 


/* PL SQL�� �⺻ �ۼ� ���� */

begin 
    -- PL/SQL ���� 
end ;
/


-- PL/SQL ���� �⺻ ���
set serveroutput on
begin 
    dbms_output.put_line ('welcome to Oracle');
end;
/


-- PL / SQL ���� ���� ���� �ϱ� 

    -- ������ := ��
    
    /* �ڷ��� ����
        1. oracle �� �ڷ����� ���
        2. �����ڷ��� : ���̺��� �÷��� ����� �ڷ����� �����ؼ� ��� 
            %type : ���̺��� Ư���÷��� �ڷ����� �����ؼ� ��� .  (���̺��� �÷��ϳ� ) 
            %rowtype : ���̺� ��ü�÷��� �ڷ����� ��� �����ؼ� ��� 
        
    */


set serveroutput on
declare    -- ���� ���� (���� �����) 
    v_eno number(4) ;               -- ����Ŭ�� �ڷ���
    v_ename employee.ename%type;    -- ���� �ڷ��� : ���̺��� �÷��� �ڷ����� �����ؼ� ���
begin 
    v_eno := 7788;
    v_ename := 'SCOTT';
    
    dbms_output.put_line('�����ȣ   ����̸�');
    dbms_output.put_line('---------------------------');
    dbms_output.put_line(v_eno || '    '  || v_ename);
    
end;
/

/* �����ȣ�� ����̸� ��� �ϱ� */

    declare 
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        
    begin
    
        dbms_output.put_line('�����ȣ   ����̸�');
        dbms_output.put_line('---------------------------');
        
        select eno , ename  into v_eno ,  v_ename
        from employee
        where ename = 'SCOTT' ;
        
        dbms_output.put_line(v_eno || '    '  || v_ename);
    
    end;
    /

    /* PL/sql ���� ��� ����ϱ� */
    
    /* if ~ end if �� */
    declare 
        v_employee employee%rowtype;  -- rowtype : ���̺��� ����÷��� ����
                                    
        annsal number (7,2) ;
    begin 
        select * into v_employee
        from employee 
        where ename = 'SCOTT';
        
        if ( v_employee.commission is null ) then
            v_employee.commission := 0;
        end if;
        
        annsal := v_employee.salary *12 + v_employee.commission;
        
        dbms_output.put_line ( ' �����ȣ   ����̸�    ����');
        dbms_output.put_line ( '-------------------------------');
        dbms_output.put_line (v_employee.eno ||'     '|| v_employee.ename|| '     ' || annsal);
        
    end;
    /
    


declare
    v_department department%rowtype;
    
begin 
    select * into v_department
    from department
    where dno = 20;
    
    dbms_output.put_line ( ' �μ���ȣ   �μ��̸�    ����');
    dbms_output.put_line ( v_department.dno|| '       ' || v_department.dname|| '   ' || 
                            v_department.loc );

end;
/


declare 
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
    
 begin 
    select dno , dname , loc into v_dno , v_dname , v_loc
    from department
    where dno = 20;
    
    dbms_output.put_line ( ' �μ���ȣ   �μ��̸�    ����');
    dbms_output.put_line ( v_dno || '   '|| v_dname || '   '|| v_loc );

end;
/       


/* if ~ elsif ~ end if */

declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null;

begin
    select eno , ename , dno into v_eno , v_ename , v_dno
    from employee
    where ename = 'SCOTT';
    
    if (v_dno = 10) then 
        v_dname := 'ACCOUNT';
    elsif (v_dno = 20) then 
        v_dname := 'RESEARCH';
    elsif (v_dno = 30) then 
        v_dname := 'SALES';
    elsif (v_dno = 40) then 
        v_dname := 'OPERATOR';
    end if ;
    
    dbms_output.put_line ( '�����ȣ   �����    �μ���');
    dbms_output.put_line ( '-------------------------------');
    dbms_output.put_line ( v_eno || '   ' || v_ename || '   ' || v_dname);
end;
/

-- %type ���
declare 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
    
begin
    select eno , ename , salary , dno into v_eno , v_ename ,v_salary ,v_dno
    from employee
    where commission = 1400;
    
    dbms_output.put_line ( '�����ȣ   �����    �޿�    �μ���');
    dbms_output.put_line ( '-------------------------------');
     dbms_output.put_line ( v_eno || '   ' || v_ename || '   '||v_salary||'    ' || v_dno);
end;
/


-- %rowtype ���
declare
    v_employee employee%rowtype;
    
begin
    select * into v_employee
    from employee
    where commission = 1400;
    
    dbms_output.put_line ( '�����ȣ   �����    �޿�    �μ���');
    dbms_output.put_line ( '-------------------------------');
    dbms_output.put_line ( v_employee.eno || '   ' || v_employee.ename 
                            || '   '||v_employee.salary||'    ' || v_employee.dno);
end;
/
        
        

--  Ŀ�� (cursor) :  PL/SQL���� select �� ����� ���Ϸ��ڵ尡 �ƴ϶� ���ڵ� ���� ��� , Ŀ���� �ʿ��ϴ� 

/*
declare
    cursor Ŀ����                  1. Ŀ������
    is
    Ŀ���� ������ select ����

begin

    open Ŀ����                    2. Ŀ������
    loop                          
        fetch ����                 3. Ŀ���� �̵��ϰ� ��� 
    end loop
    close Ŀ���� ;                  4. Ŀ���� ����

end;
/
    
*/    
    
-- Ŀ���� ����ؼ� department ���̺��� ��� ������ ����ϱ� 

declare
    v_dept department%rowtype;

    cursor c1                      -- 1. Ŀ�� ���� 
    is
    select * from department;
begin

    dbms_output.put_line(' �μ���ȣ    �μ���    �μ���ġ');
    dbms_output.put_line('---------------------------------');
    open c1;                        -- 2. Ŀ������
    loop
        fetch c1 into v_dept.dno , v_dept.dname , v_dept.loc;
        exit when c1%notfound;
        dbms_output.put_line(v_dept.dno || '   '||v_dept.dname || '    '|| v_dept.loc);
    end loop ;
    close c1;                       -- 4. Ŀ�� ����

end;
/
    
    
 /* Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ��� 
  Ŀ����%notfound : Ŀ���������� ����ڷᰡ fetch�Ǿ��ٸ� true 
  Ŀ����%found    : Ŀ����������  fetch���� �����ڷᰡ �����ϸ� true 
  Ŀ����%isopen   : Ŀ���� ���µǾ��ٸ� true
  Ŀ����%rowcount : Ŀ���� ���� ���ڵ� ���� 
*/







