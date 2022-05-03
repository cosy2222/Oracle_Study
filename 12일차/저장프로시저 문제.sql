-- 1번문제 
create or replace procedure p1
is 
    v_dno employee.dno%type;
    v_min employee.salary%type;
    v_max employee.salary%type;
    v_avg employee.salary%type;
    
    cursor c1 
    is 
    select dno , min(salary) , max(salary) , avg(salary) 
    from employee
    group by dno;

begin
    open c1;
        loop
          fetch c1 into v_dno , v_min , v_max , v_avg;
          exit when c1%notfound;
          dbms_output.put_line('부서번호       최소급여         최대급여       평균급여');
          dbms_output.put_line(v_dno || '             ' || v_min || '          ' || v_max ||'         '|| v_avg);
        end loop;
    close c1;
end;
/
exec p1;
-----------------------------------------------------------------------------




-- 2번 문제
create or replace procedure p2
is 
    v_eno employee.eno%type ;
    v_ename employee.ename%type;
    v_dname department.dname%type;
    v_loc   department.loc%type;
    
    cursor c2 
    is
    select eno , ename , dname , loc
    from employee e, department d
    where e.dno = d.dno;
    
begin
    open c2;
        loop
          fetch c2 into  v_eno,v_ename,v_dname,v_loc   ;
          exit when c2%notfound;
          dbms_output.put_line(v_eno ||'     '|| v_ename||'     '||v_dname||'      '||v_loc);
        end loop;
    close c2;
end;
/
exec p2;
-----------------------------------------------------------------------------




-- 3번 문제 
create procedure sp_salary_b(
    v_salary employee.salary%type
    )
is
    v_emp employee%rowtype;
    
    cursor c3
    is
    select * from employee 
    where salary > v_salary;
    
begin 

    for v_emp in c3 loop
        dbms_output.put_line(v_emp.ename || '    ' || v_emp.salary || '    '|| v_emp.job);
    end loop ;

end;
/
exec sp_salary_b(2800);
-----------------------------------------------------------------------------


-- 4번문제 
create or replace procedure sp_copy_table (
    emp_name varchar,
    dept_name varchar
)
is
    cursor1 INTEGER;
    emp_sql varchar2(100);
    dept_sql varchar2(100);
begin
    emp_sql := 'create table ' || emp_name || ' as select * from employee';
    dept_sql := 'create table ' || dept_name || ' as select * from department';
    cursor1 := dbms_sql.open_cursor;  
    dbms_sql.parse (cursor1 , emp_sql , dbms_sql.v7);
    dbms_sql.parse (cursor1 , dept_sql , dbms_sql.v7);
    dbms_sql.close_cursor(cursor1);   
end;
/
exec sp_copy_table ('emp_c10' , 'dept_c10');
-----------------------------------------------------------------------------


--5번 문제
create or replace procedure p5(
    p_dno number,
    p_dname varchar2,
    p_loc varchar2
)
is
begin
    insert into dept_c10
    values (p_dno , p_dname , p_loc);
end;
/
exec p5 (50 , 'HR' , 'SEOUL');
exec p5 (60 , 'HR2' , 'BUSAN');
-----------------------------------------------------------------------------



-- 6번 문제 
create or replace procedure p6(
    p_eno number,
    p_ename varchar2,
    p_job in  varchar2,
    p_manager number,
    p_hiredate date,
    p_salary number,
    p_commission number,
    p_dno number
)
is
begin
    insert into emp_c10
    values (p_eno , p_ename , p_job , p_manager , p_hiredate , p_salary , p_commission , p_dno);
end;
/
exec p6 (8000 , 'SONG'  ,  'PROGRAMER' , 7788 , sysdate , 4500 , 1000 , 50 );

---------------------------------------------------------------------------------



-- 7번 문제
create or replace procedure p7(
    p_dno dept_c10.dno%type,
    p_dname varchar2
)
is
begin
    update dept_c10
    set dname = p_dname
    where dno = p_dno;
end;
/
exec p7 (50 , 'PROGRAM');

-----------------------------------------------------------------

-- 8번문제 
create or replace procedure p8(
    p_eno emp_c10.eno%type,
    p_salary number
)
is
begin
    update emp_c10
    set salary = p_salary
    where eno = p_eno;
end;
/

exec p8 ( 8000 , 6000);



-----------------------------------------------------------------
-- 9번 문제
create or replace procedure p9(
    tname1 user_tables.table_name%type,
    tname2 user_tables.table_name%type
)   
is
    cursor1 INTEGER;
    dt1 varchar2(100);
    dt2 varchar2(100);
begin
    dt1 := 'drop table ' || tname1 ;
    dt2 := 'drop table ' || tname2 ;
    cursor1 := dbms_sql.open_cursor;  
    dbms_sql.parse (cursor1 , dt1 , dbms_sql.v7);
    dbms_sql.parse (cursor1 , dt2 , dbms_sql.v7);
    dbms_sql.close_cursor(cursor1);  
end;
/

exec p9 ( 'emp_c10' , 'dept_c10');


