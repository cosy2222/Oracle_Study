-- 2일차 : DQL : Select

-- desc 테이블명  : 테이블의 구조를 확인
desc department;

select * FROM department;

/*
Select 구문의 전체 필드 내용 

Select    <== 컬럼명
Distinct  <== 컬럼내의 값의 중복을 제거해라 
From      <== 테이블명 ,뷰명
Where     <== 조건
Group By  <== 특정 값을 그룹핑
Having    <== 그룹핑한 값을 정렬
Order by  <== 값을 정렬해서 출력
*/

desc employee;
select *
from employee;

-- 특정 컬럼만 출력하기
select eno, ename from employee;

-- 특정 컬럼을 여러번 출력
select eno , ename ,eno , ename , ename from employee;

SELECT eno , ename , salary from employee;

-- 컬럼에 연산을 적용할 수 있다
select eno , ename ,salary , salary * 12 from employee;

-- 컬럼명 알리어스( Alias )
    --컬럼에 연산을 하거나 함수를 사용하면 컬럼명이 없어진다
Select eno , ename , salary , salary * 12 as 연봉 from employee;
select eno as 사원번호  , ename as 사원명 , salary as 월급 , salary *12 as 연봉 from employee;

    -- as 생략가능
select eno  사원번호  , ename  사원명 , salary  월급 , salary *12  연봉 from employee;

    -- 공백이나 특수문자가 들어갈떄는 "" 으로 처리해야 한다
select eno  "사원 번호"  , ename  "사원?명" , salary  월급 , salary *12  연봉 from employee;


-- nvl 함수 : 연산시에 null 을 처리하는 함수 
select * from employee;

-- nvl 함수를 사용하지 않고 전체 연봉을 계산 (null 이 포함된 컬럼에 연산을 하면 null이 출력 ) 
    -- null 을 0으로 처리해서 연산해야함
select eno 사원번호 , ename 사원명 , salary 월급 , commission 보너스, salary*12 연봉,
salary *12 + commission 전체연봉    -- 전체 연봉
from employee;


--nvl 함수를 사용해서 연산 
select eno 사원번호 , ename 사원명 , salary 월급 , commission 보너스, salary*12 연봉,
salary *12 + nvl(commission, 0) 전체연봉    -- 전체 연봉
from employee;

-- 특정 컬럼의 내용을 중복 제거후 출력
select * from employee;
select dno from employee;
select DISTINCT dno from employee;

-- 조건을 사용해서 검색 ( where )
select * from employee;
select eno 사원번호 , ename 사원명 , job 직책 , manager 직속상관 , hiredate 입사날짜 , 
    salary 월급 , commission 보너스 , dno 부서번호
from employee;

-- 사원 번호가 7788인 사원의 이름을 검색 
select * from employee
where eno = 7788;

select ename from employee
where eno = 7788;

-- 사원번호가 7788인 사원의 부서번호 ,월급 , 입사날짜 검색
SELECT  dno  , salary  , hiredata 
from employee
where eno = 7788;

select *
from employee
where ename = 'SMITH';

-- 레코드를 가져올떄 
    -- number 일떄는 '' 를 붙이지 않는다
    -- 문자데이터 (char, varchar2)나 날짜(data) 를 가져올떄는 '' 를 처리 
    -- 대소문자를 구분 

-- 입사날짜가 '81/12/03' 인 사원출력
SELECT ename , hiredate
from employee
where hiredate = '81/12/03';


-- 부서코드가 10인 모든 사원들을 출력
select ename , eno
from employee
where dno = 10;

SELECT * FROM employee;

-- 월급이 3000 이상인 사원의 이름 , 부서 , 입사날짜 출력
select ename , dno , hiredate , salary
from employee 
where salary >= 3000;

-- null 검색 : is 키워드 사용      <==  !주의 :  = 를 사용하면 안된다 
select *
from employee
where commission is null;

-- commission 이 300 이상인 사원의 이름 , 직책 , 월급 출력
select ename , job , salary , commission
from employee 
where commission >= 300;

-- commission 이 없는 사원이름 출력
select ename 
from employee 
where commission is null;

-- 조건에서 and , or , not

-- 월급이 500 이상 2500 미만인 사원들의 이름 , 사원번호 , 입사날짜 , 월급을 출력
select ename , dno , hiredate , salary
from employee
where salary >=500 and salary <2500 ; 


-- 직책이 salesman 이거나  부서코드가 20인 사원이름 , 직책 , 월급, 부서코드를 출력

select ename , job , salary , dno 
from employee
where job = 'SALESMAN' or dno = 20;

-- 커밋션이 없는 사용자중에 부서코드가 20인 사용자의 이름 , 부서코드 , 입사날짜 출력
select ename , dno , hiredate
from employee
where commission is null and dno = 20;

-- 커밋션이 null 이 아닌 사용자의 이름 , 입사날짜 , 월급
select ename , hiredate , salary 
from employee
where not commission is null;

-- 날짜 검색 

--  1982/1/1 ~ 1983/12/31 사이에 입사한 사원의 이름 , 직책 , 입사날짜
Select ename , job , hiredate
from employee
where hiredate >= '1982/1/1' and hiredate < '1983/12/31';

-- 1981년도에 입사한 사원들 사원의 이름 , 직책, 입사날짜
select ename , job , hiredate
from employee
where hiredate >= '1981/1/1' and hiredate <= '1981/12/31';

-- between A and b : A이상 B이하
select ename , job , hiredate
from employee
where hiredate BETWEEN '1981/1/1' and '1981/12/31';

-- IN 연산자

-- 커밋션이 300,500,1400 인 사원의 이름 ,직책 ,입사일
select ename , job , hiredate
from employee
where commission = 300 or commission = 500 or commission = 1400;

SELECT ename, job  ,hiredate
from employee
where commission in (300,500,1400);


-- like : 컬럼내의 특정한 문자열을 검색   <== 글 검색기능을 사용할떄
    -- % : 뒤에 어떤글자가 와도 상관없다 
    -- _ : 한글자가 어떤값이 와도 상관없다
    
-- F로 시작하는 이름을 가진 사원을 모두 검색하기
select * from employee
where ename like 'F%';

--이름이 ES로 끝나는 사원을 검색하기
select ename from employee
where ename like '%ES';

-- J로 시작되고  J뒤에 두글자는 상관없고  ES로 끝나는 사원
select ename
from employee
where ename like 'J__ES';

-- 마지막 글자가 R로 끝나는 사원
select ename
from employee
where ename like '%R';

-- MAN 이 들어간 직책
SELECT job
from employee
where job like '%MAN%';

-- 81년도에 입사한 사원 
select *
from employee
where hiredate >= '81/1/1' and hiredate <= '81/12/31';

SELECT *
from employee
where hiredate BETWEEN '81/1/1' and '81/12/31';

select *
from employee
where hiredate like '81%';

-- 81년 2월에 입사한 사원
SELECT *
from employee
where hiredate like '81/02%';


-- 정렬 : order by      , asc ( 오름차순정렬):기본값 , desc(내림차순정렬)

SELECT *
from employee
order by eno asc ;     -- asc 는 기본값이라서  생략가능


SELECT *
from employee
order by eno DESC ; 


-- 이름컬럼을 정렬
Select *
from employee
order by ename ;      -- 생략하면 기본적으로 asc

Select *
from employee
order by ename desc;

-- 날짜 정렬
select *
from employee
order by hiredate ;

select *
from employee
order by hiredate desc ;


-- 질문답변형 게시판에서 주로 사용 , 두개이상의 컬럼을 정렬할때 

select * from employee
order by dno desc;

-- 두개의 컬럼이 정렬 : 제일 처음 컬럼이 정렬을 하고 , 동일한 값에 대해서 두번쨰 컬럼을 정렬 
select dno , ename
from employee
order by dno , ename;

select dno , ename
from employee
order by dno desc , ename ;


-- where 절과  order by 절이 같이 사용될떄
select *
from employee
where commission is null 
order by ename;




























