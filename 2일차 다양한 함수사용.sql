------ 다양한 함수 사용하기 
/*
    1. 문자를 처리하는 함수
        - UPPER : 대문자로 변환
        - LOWER : 소문자로 변환
        - INITCAP : 첫자는 대문자로 나머지는 소문자로 변환
        
        dual 테이블 : 하나의 결과를 출력 하도록 하는 테이블
*/

select '안녕하세요' as 안녕
from dual;


select 'Oracle mania' , upper ('Oracle mania') , Lower ('Oracle mania') , initcap('Oracle mania')
from dual;

select ename , lower (ename) , initcap(ename) , upper (ename)
from employee;

select * from employee
where ename = 'allen';    -- 검색이 안됨

select * from employee
where lower(ename) = 'allen';

select ename , initcap(ename) from employee
where initcap(ename) = 'Allen';

-- 문자 길이를 출력 하는 함수 
    -- length : 문자의 길이를 반환
    -- lengthb : 문자의 길이를 반환 |   영문 : 1byte , 한글 : 3byte로 반환 
    
select length ('Oracle mania') , length ('오라클 매니아') from dual;    
    
select lengthb ('Oracle mania') , lengthb ('오라클 매니아') from dual;   

SELECT ename , length (ename) , job , length(job)  from EMPLOYEE;

-- 문자 조작 함수 
    -- concat : 문자와 문자를 연결해서 출력
    
    -- substr : 문자를 특정위치에서 잘라오는 함수 
    -- substrb : 문자를 특정위치에서 잘라오는 함수  영문은 1byte  한글은 3byte 로 처리 
    
    -- instr   : 문자의 특정 위치의 인덱스 값을 반환
    -- instr   : 문자의 특정 위치의 인덱스 값을 반환  영문은 1byte  한글은 3byte 로 처리 
    
    -- lpad , rpad : 입력 받은 문자열에서 특수한 문자를 적용
    
    -- trm  : 잘라내고 남은 문자를 반환 
    
select 'Oracle' , 'mania', concat ('Oracle' , 'mania') from dual;

select concat (ename ,' ' || job) from employee;

select '이름은 : ' || ename || ' 이고 , 직책은 : ' || job || '입니다'
from employee;

select '이름은 : ' || ename || ' 이고 , 직속상관사번 : ' || manager || '입니다'  직속상관출력
from employee;

select 'Oracle mania' , substr ('Oracle mania' , 4,3) , substr ('오라클 매니아' , 2,4)
from dual;
    
select 'Oracle mania' , substr ('Oracle mania' , -4,3) , substr ('오라클 매니아' , -6,4)
from dual;    
    
select ename , substr (ename , 2,3) , substr (ename , -5,2) from employee;

select 'Oracle mania' , substrb ('Oracle mania' , 3,3) , substrb ('오라클 매니아' , 4,6)
from dual;


-- 이름이 N으로 끝나는 사원들 출력하기 (substr 함수를 사용)
select ename from employee
where substr (ename, -1 , 1) = 'N';


-- 87년도 입사한 사원들 출력하기 (substr 함수를 사용)
select hiredate from employee
where substr (hiredate , 1 , 2) = '87';


-- instr ( 대상 , 찾을 글자 , 시작위치 , 몇번쨰 발견 ) : 대생에서 찾을 글자의 인덱스값을 추력
select 'Oracle mania' , instr ('Oracle mania' , 'O') from dual;

select 'Oracle mania' , instr ('Oracle mania' , 'a' , 5,2) from dual;   

select 'Oracle mania' , instr ('Oracle mania' , 'a' , -5,1) from dual;   

select instr ( job , 'A' , 1,1)   from employee
where lower(job) = 'manager';


-- lpad , rpad : 특정 길이만큼 문자열을 지정해서 왼쪽 , 오른쪽에 공백을 특정 문자로 처리 
    -- lpad ( 대상 ,  늘려줄 문자열 크기 ,  특수문자 적용 ) 
SELECT lpad (1234 , 10 , '#') from dual;
SELECT rpad (1234 , 10 , '@') from dual;


-- TRIM : 공백 제거 , 특정 문자도 제거
 -- LTRIM  : 왼쪽 공백 제거
 -- RTRIM  : 오른 쪽 공백 제거
 -- TRIM :  왼쪽 ,오른쪽 공백 제거
 
 select ltrim ( '     Oracle mania       ') , rtrim ( '     Oracle mania       ') , trim ( '     Oracle mania       ') as trim
 from dual;
    
    
    
    
    
