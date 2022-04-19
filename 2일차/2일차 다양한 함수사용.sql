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
    -- lengthb : 문자의 길이를 반환 , 한글 3byte로 반환 
