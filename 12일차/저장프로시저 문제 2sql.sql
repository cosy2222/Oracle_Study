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
/* 함수 ( Funtion ) : 값을 넣어서 하나의 값을 반환 받아온다.   <== SQL구문 내에서 사용가능
    -- 비교 ,  저장프로시저는 out 매개변수를 여러개 반환받아올수 있다 <== SQL구문 내애서는 사용불가
*/

create or replace function fn_salary_ename ( 
    v_ename in employee.ename%type
)
return number   -- 호출하는 곳으로 값을 던져줌  , 리턴할 자료형
is
    v_salary number(7,2);
begin
    select salary into v_salary 
    from employee 
    where ename = v_ename;
    return v_salary;
end;
/

-- 1. 함수사용
variable var_salary number;
exec :var_salary := fn_salary_ename ('SCOTT');
print var_salary;


-- 2. 함수사용 ( SQL 구문내에서 함수 사용 )
select ename , fn_salary_ename('SCOTT') 월급
from employee 
where ename = 'SCOTT';







