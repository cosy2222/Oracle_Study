/*
    ����� , �μ��� , �μ���ġ , ������ ����ϴ� 

*/


declare
    v_ename employee.ename%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
    v_salary employee.salary%type;
    
    cursor c1
    is
    select ename , dname , loc , salary
    from employee e , department d
    where e.dno = d.dno;
    
begin

    dbms_output.put_line( '�����    �μ���     �μ���ġ    ����');
    dbms_output.put_line( '------------------------------------');
    open c1;
    loop
        fetch c1 into v_ename  , v_dname , v_loc , v_salary;
        exit when c1%notfound;
        dbms_output.put_line( v_ename ||'   '|| v_dname ||'   '|| v_loc ||'   '|| v_salary);
    end loop;
    close c1;

end;
/
