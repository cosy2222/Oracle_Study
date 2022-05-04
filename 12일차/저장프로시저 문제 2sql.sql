-- 10번 문제

create or replace procedure p11(
    v_ename in varchar2,
    v_ename2 out varchar2,
    v_sal out number,
    v_dno out number,
    v_dname out varchar2,
    v_loc out varchar2
)
is
begin
    select ename , salary ,e.dno , dname , loc  into v_ename2 , v_sal , v_dno, v_dname, v_loc
    from employee e , department d
    where ename = v_ename and e.dno = d.dno;
end;
/


declare
    var_ename  varchar2(50);
    var_sal  number;
    var_dno  number;
    var_dname  varchar2(50);
    var_loc  varchar2(50);
begin
    p11('KING' , var_ename , var_sal , var_dno, var_dname, var_loc);
    dbms_output.put_line('조회결과 : ' || var_ename || '   ' || var_sal || '   ' || var_dno 
                           || '   ' || var_dname || '   '|| var_loc);
end;
/

--------------------------------------------------------------------------------

-- 11번 문제

create or replace procedure p12(
    v_eno in number,
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2,
    v_dname out varchar2,
    v_loc out varchar2
)
is
begin
    select ename , salary ,job , dname , loc  into v_ename , v_sal , v_job, v_dname, v_loc
    from employee e , department d
    where eno = v_eno and e.dno = d.dno;
end;
/


declare
    var_ename  varchar2(50);
    var_sal  number;
    var_job  varchar2(50);
    var_dname  varchar2(50);
    var_loc  varchar2(50);
begin
    p12(7788 , var_ename , var_sal , var_job, var_dname, var_loc);
    dbms_output.put_line('조회결과 : ' || var_ename || '   ' || var_sal || '   ' || var_job 
                           || '   ' || var_dname || '   '|| var_loc);
end;
/


