-- sub Query : select 문 내에 select문이 있는 Query
    -- where 조건절 : sub query
    -- having 조건절 : sub query

select ename , salary 
from employee;

select ename , salary 
from employee 
where ename = 'SCOTT';

-- scott의 월급보다 월급이 같거나 많은 사용자를 출력 

select ename , salary from employee where salary >= 3000;  --서브쿼리 사용x

select ename , salary 
from employee 
where salary >= ( select salary from employee where ename = 'SCOTT'); -- 서브쿼리 사용O

-- SCOTT 과 동일한 부서에 근무하는 사원들 출력
select ename , dno
from employee
where dno = (select dno from employee where ename = 'SCOTT');

--최소 급여를 받는 사원의 이름 , 담당업무 , 급여 출력 하기
select ename , job , salary
from employee
where salary = (select min(salary) from employee);


-- 30번 부서(dno) 에서 최소 월급을 받는 사원보다 많은 사원들 이름 , 부서번호 , 월급
select ename , dno , salary
from employee
where salary > (select min(salary)  from employee where dno =30) and dno = 30;


-- having절에서 sub query 사용하기

-- 30번 부서의 최소월급보다  최소월급이 큰 부서
select dno , min(salary ) , count(dno)
from employee 
group by dno
having min(salary) > (select min(salary) from employee where dno=30);

-- 단일행 서브쿼리 : sub query 의 결과 값이 단 하나만 출력 
            -- 단일행 비교 연산자 :  > , = , >= , < , <= , <> 
-- 다중행 서브쿼리  : sub query 의 결과 같이 여러개 출력
            -- 다중행 서브쿼리 연산자 : IN, ANY , SOME , ALL , EXISTS
                -- IN : 메인 쿼리의 비교 조건 ( '=' 연산자로 비교할 경우 ) 이 서브쿼리의 결과값중에 
                --     하나라도 일치하면 true
                
                -- ANY , SMOE : 메인 쿼리의 비교 조건이 서브쿼리의 검색 결과와 하나이상 일치하면 true 
                
                -- ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 검색결과와 모든 값이 일치하면  true
                
                -- EXISTS : 메인쿼리의 비교조건이 서브쿼리의 결과값 중에서 만족하는 값이 하나라도 존재하면true 
                
                
-- IN 연산자 사용하기

--부서별로 최소 월급을 받는 사용자들 출력하기 

select ename , dno , salary
from employee
where salary in (950 , 800 , 1300);

select ename , dno , salary
from employee
where salary in (select min(salary) from employee group by dno);


-- ANY 연산자 사용 
  -- 서브쿼리가 반환하는 각각의 값과 비교함
  -- ' < any ' 는 최대값 보다 작음을 나타냄
  -- ' > any ' 는 최소값 보다 큼을 나나탬
  -- ' =any ' 는 in과 동일함 
  
  -- 직급이 salaeman 이 아니면서 급여가 임의의 salesman 보다 작은 사원을 출력
  select ename , job , salary
  from employee
  where salary < any (select salary from employee where job = 'SALESMAN')
                    and  job<> 'SALESMAN' ;
  
-- ALL 연산자 
        -- sub query 의 반환하는 모든 값과 비교
        -- ' > ALL ' 최대값 보다 큼
        -- ' < ALL ' 최소값보다 작음
        
-- 예) 직급이SALESMAN 이 아니면서 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력
         
select ename , job , salary
from employee
where salary < ALL (select salary from employee where job = 'SALESMAN') and job <> 'SALESMAN';

select job from employee ;

-- 담당업무가 분석가인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들 출력
select ename , job , salary
from employee
where salary < all (select salary from employee where job = 'ANALYST') and job <> 'ANALYST';

-- 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시 하되 결과 급여에 대해서 오름차순 정렬 하시오
select eno , ename , salary
from employee
where salary >  (select avg(salary) from employee ) 
order by salary desc;












