
/*
        저장프로시저의 장점
            1. PL/SQL을 사용가능하다. 자동화
            2. 성능이 빠르다
                일반적인 SQL 구문 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 ->컴파일 -> 실행
                저장프로시저 처음실행 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 ->컴파일 -> 실행
                저장프로시저   두번쨰 실행부터 : 컴파일  -> 실행
            3. 입력 매개변수 , 출력 매개변수를 사용할 수 있다
            4. 일련의 작업을 묶어서 저장 ( 모듈화된 프로그래밍이 가능하다 ) .
*/


--  저장 프로시저 생성

create procedure sp_salary
is 
    v_salary employee.salary%type;  -- 저장프로시저는 is 블락에서 변수선언
begin 
    select salary into v_salary
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line('SCOTT의 급여는 : ' || v_salary || '입니다');
       
end;
/


/*저장프로시저 정보를 확인하는 데이터 사전*/
select * from user_source
where name = 'SP_SALARY';


-- 저장프로시저 실행
execute sp_salary; --전체이름
exec sp_salary;     -- 약식이름


-- 저장프로시저 수정
create or replace procedure sp_salary  -- 존재하지않으면 생성 , 존재하면 수정
is 
    v_salary employee.salary%type;  -- 저장프로시저는 is 블락에서 변수선언
    v_commission employee.commission%type;
begin 
    select salary , commission into v_salary , v_commission
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line('SCOTT의 급여는 : ' || v_salary || '입니다  '  || '보너스 :' || v_commission || '입니다' );
       
end;
/


-- 저장 프로시저 삭제
drop procedure sp_salary;


--------------<< 인풋 매개변수를 처리하는 저장 프로시저 >> -----------------------------
create or replace procedure sp_salary_ename (   -- 입력 매개변수 (in)  , 출력 매개변수 (out)으로 정의
    v_ename in employee.ename%type      -- 변수명 in 자료형     !주의 : 여기는 ; 쓰면 안됨!
)
is 
    v_salary employee.salary%type;
    
begin 
    select salary into v_salary     -- 변수
    from employee
    where ename = v_ename;         --인풋 매개변수
    
    dbms_output.put_line( v_ename || ' 의 급여는 ' || v_salary || '입니다');
end;
/

exec sp_salary_ename ('SCOTT');
exec sp_salary_ename ('SMITH');




-- 부서번호 인풋 문제
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


-- 테이블 이름 인풋문제
create or replace procedure  sp2 (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(100);     -- SQL쿼리를 저장하는 변수
begin 
    v_sql := 'create table ' || v_name || ' as select * from employee';
    cursor1 := dbms_sql.open_cursor;                        -- 커서사용
    dbms_sql.parse (cursor1 , v_sql , dbms_sql.v7);         -- 커서를 사용해서 sql 쿼리를 실행 
    dbms_sql.close_cursor(cursor1);                         -- 커서중지
end;
/

grant create table to public ;    -- sys계정에서 실행 

exec sp2 ('emp_copy33');

select * from emp_copy33;



---------------------- << 출력 매개변수 사용 >>------------------
/* 저장 프로시저 : 출력 매개변수가 지원 (여러개의) ,    함수 : 출력 매개변수를 하나만 가짐 
        -- out 키워드를 사용
        -- 저장 프로시저를 호출시 먼저 출력 매개변수가 변수선언후 호출이 가능 
        -- 호출시 출력매개변수 이름앞에  ':변수명(출력매개변수명)'
        -- 출력 매개변수를 출력하기 위해서 print명령문이나 PL/SQL을 사용해서 출력할 수 있다 

*/


create or replace procedure sp_salary_ename2(
    v_ename in employee.ename%type,   -- 입력매개변수
    v_salary out employee.salary%type
)
is

begin
    select salary into v_salary
    from employee
    where ename = v_ename;
end;
/


select * from user_source where name = 'SP_SALARY_ENAME2';  --데이터 사전에서 확인
-- 주석 오류 주의 !
variable var_salary varchar2(50);       -- 호출부에서 아웃풋 매개변수를 선언                                         
exec sp_salary_ename2 ('SCOTT' , :var_salary);
print var_salary;


-- out 파라미터를 여러개 가지는 저장프로시저  생성 및 출력 
-- 사원번호를 인풋 받아서 사원이름 , 급여 , 직책을 out파라미터에 넘겨주는 프로시저 
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

-- PL/SQL을 사용해서 저장프로시저 호출 
declare 
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    -- 익명 블록에서는 저장프로시저 호출시 exec를 붙이지 않는다 
    sel_empno( 7788,var_ename,var_sal,var_job); -- 저장프로시저 호출
    dbms_output.put_line('조회결과 : ' || var_ename || '   ' || var_sal || '   ' || var_job);
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



/*  트리거 (Trigger ) 
        - 테이블에 부착되어 있다
        - 테이블에 이벤트가 발생될떄 자동으로 작동되는 프로그램 코드 
        - 테이블에 발생되는 이벤트 ( Insert , Update , Delete )
        - 트리거에서 정의된 begin ~ end 사이의 문장이 실행됨 
        - before 트리거: 테이블에서 트리거를 먼저 실행후 insert , Update , Delete 가 적용
        - after 트리거 : insert , update , delete 가 실행후 trigger를 실행 
        -- 예) 주문 테이블에 값을 넣었을때 배송 테이블에 자동으로 저장
        -- 예) 중요 테이블의 로그를 남길때도 사용됨
        -- :new   가상의 임시테이블 , 트리거가 부착된 테이블에 새롭게 들어오는 레코드의 임시 테이블 
        -- :old   가상의 임시테이블 , 트리거가 부착된 테이블에서 삭제되는 레코드의 임시테이블 
        -- 트리거는 하나의 테이블에 총 3개까지 부착됨 ( insert , update , delete ) 
*/


create table dept_original 
as
select * from department
where 0 = 1;

create table dept_copy
as
select * from department
where 0 =1;


-- 트리거 생성 ( dept_original 테이블에 부착 ,insert 이벤트가 발생될떄 자동으로 작동) 

create or replace trigger tri_sample1
        -- 트리거가 부착될 테이블 , 이벤트 ( insert , update , delete ) , Before , After 
        after insert    -- insert 이벤트가 작동후 트리거가 작동 ( begin ~ end 사이의 코드 ) 
        on dept_original  -- on  부착될 테이블 
        for each row    -- 모든 row에 대해서 

begin             -- 트리거가 실행할 코드 

    if inserting then 
        dbms_output.put_line('Insert Trigger 발생 ');        
        insert into dept_copy 
        values ( :new.dno , :new.dname, :new.loc); -- new 가상 임시 테이블
    end if;
end;
/


-- 트리거 확인 데이터 사전
select * from user_source where name = 'TRI_SAMPLE1';

insert into dept_original 
values ( 13, 'PROGRAM2' , 'BUSAN2');

select * from dept_original;
select * from dept_copy;



-- delete 트리거 : dept_original 에서 제거 ===> dept_copy에서도 제거 
create or replace trigger  tri_del
    -- 트리거가 작동시킬 테이블 , 이벤트 
    after delete   -- 원본 테이블의 delete를 먼저실행하고 trigger 작동 
    on dept_original 
    for each row
begin
    dbms_output.put_line('delete trigger 발생 ');
    delete dept_copy
    where dept_copy.dno = :old.dno;
end;
/

delete dept_original
where dno = 13;

select * from dept_original;
select * from dept_copy;



-- update 트리거  : dept_original 에서 update하면 dept_copy에서도 update
create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_output.put_line(' update trigger 발생 ');
    update dept_copy
    set dept_copy.dname = :new.dname
    where dept_copy.dno = 12;
end;
/

update dept_original
set dname = 'ㅁㄴㅇ'
where dno = 12;

select * from dept_original;
select * from dept_copy;
















































