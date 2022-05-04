 /*
    ����� , �μ��� , �μ���ġ , ������ ����ϴ� 

*/


declare
    v_ename employee.ename%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
    v_salary employee.salary%type;
    
    cursor c2
    is
    select ename , dname , loc , salary
    from employee e , department d
    where e.dno = d.dno;
    
begin

    dbms_output.put_line( '�����    �μ���     �μ���ġ    ����');
    dbms_output.put_line( '------------------------------------');
    open c2;
    loop
        fetch c2 into v_ename  , v_dname , v_loc , v_salary;
        exit when c2%notfound;
        dbms_output.put_line( v_ename ||'   '|| v_dname ||'   '|| v_loc ||'   '|| v_salary);
    end loop;
    close c2;

end;
/
