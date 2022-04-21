-- 4일차 
/*
    그룹 함수 : 동일한 값에대해서 그룹핑해서 처리하는 함수
        group by 절에 특징 컬럼을 정의 할 경우 , 해당 컬럼의 동일한 값들을 그룹핑해서 연산을 적용
        
    집계함수 : 
        - SUM : 그룹의 합계
        - AVG : 그룹의 평균
        - MAX : 그룹의 최대값
        - MIN : 그룹의 최소값
        - COUNT : 그룹의 총 개수 ( 레코드수 , 로우수) 
*/

select sum (salary) , avg(salary) , max (salary ) , min (salary) 
from employee;

-- !주의 : 집계함수를 처리할떄 , 출력컬럼이 단일값으로 나오는 컬럼을 정의
select sum(salary) , ename
from employee;


-- 집계함수는 null값을 처리해서 연산한다
select sum(commission) , avg(commission) , max(commission) , min(commission)
from employee;

-- count () : 레코드수 , 로우수
    -- null은 처리되지 않는다
    -- 테이블의 전체 레코드 수를 가져올 경우 : count (*) 또는 not null 컬럼을 count()
select count(eno)
from employee;

select commission from employee;
select count(commission) from employee;

select count(*) from employee;

-- 전체 레코드 카운트
select count(*) from employee;
select count(eno) from employee;

-- 중복되지 않는 직업의 갯수 
select job from employee;

select count (DISTINCT job) from employee;

-- 부서의 갯수
select count (DISTINCT dno) from employee;

-- Group by : 특정 컬럼의 값을 그룹핑 한다 , 주로 집계함수를 select 절에서 같이 사용합니다

/*
    select 컬럼명 , 집계함수처리된컬럼
    from  테이블
    where 조건
    group by 컬럼명
    having 조건 ( group by한 결과의 조건 )
    order by 정렬 
*/

-- 부서별 평균 급여
select dno 부서 , avg(salary) 평균급여
from employee
group by dno;  -- dno컬럼의 중복된값을 그룹핑


-- 전체 평균 급여
select avg(salary)
from employee;

--group by를 사용하면서 select 절에 가져올 컬럼을 잘 지정해야한다
select dno , count (dno) , sum(salary) , ename
from employee
group by dno;


-- 동일한 직책을 그룹핑해서 월급의 평균 , 합계 , 최대값 , 최소값을 출력
select job , avg(salary) , sum(salary) , max(salary) , min(salary)
from employee
group by job;

-- 여러컬럼을 그룹핑 하기 . 
select dno , job , count(*) , sum (salary)
from employee
group by dno ,job;  -- 두 컬럼 모두 일치하는 것을 그룹핑 

select dno , job 
from employee
where dno = 20 and job ='CLERK';

-- having : group by 에서 나온 결과를 조건으로 처리할때 

-- 부서별 월급의 합계가 9000이상인것만 출력
select dno , count(*) , sum (salary) , avg(salary)
from employee
group by dno 
having sum (salary)> 9000;

-- where 와 having 절이 같이 사용되는 경우
    -- where : 실제 테이블의 조건으로 검색
    -- having : group by 결과에 대해서 조건을 처리

select dno , avg(salary)
from employee
where not salary <1500
group by dno
having avg(salary) >2500;

--CUBE 
    -- group by 절에서 사용하는 특수한 함수
    -- 여러 컬럼을 나열 할 수 있다
    -- group by 절의 자세한 정보를 출력
    
select dno , count(*) , sum(salary) , round(avg(salary))
from employee
group by rollup (dno)
order by dno;

-- cube : 부서별 합계와 평균을 출력 후 , 마지막 라인에 전체 합계 평균
select dno , count(*) , sum(salary) , round(avg(salary))
from employee
group by cube (dno)
order by dno;

-- rollup : 두컬럼이상
select dno,job , count(*) , max(salary) , sum(salary) , avg(salary)
from employee
group by rollup (dno , job);


-- join 
    -- department 와 employee는 원래 하나의 테이블이었으나 모델링(중복제거 , 성능향상 ) 을 통해서 두 테이블을 분리
    -- 두테이블의 공통키 컬럼 (dno) , employee 테이블의 dno 컬럼은 department 테이블의 dno 컬럼을 참조한다 
    -- 두개 이상의 테이블의 컬럼을 join구문을 사용해서 출력 
    
select * from department;   -- 부서정보를 저장 하는 테이블
select * from employee;     -- 사원정보를 저장하는 테이블

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 join   ,  oracle 에서만 사용가능
    -- from 절 : 조인할 테이블을 ","로 처리
    -- where 절 : 두 테이블의 공통의 키 컬럼을 "=" 로 처리
            -- and 절 : 조건을 처리
    

select *
from employee , department
where department.dno = employee.dno;

            
--where 절 : 공통 키 컬럼을 처리한 경우
select *
from employee , department
where department.dno = employee.dno     -- 공통 키 적용
and job = 'MANAGER';                    -- 조건을 처리



-- ANSI 호환 : INNER JOIN  <== 모든 SQL 에서 사용가능한 JOIN
-- on 절 : 공통 키 컬럼을 처리한 경우
    -- on절 : 두 테이블의 공통의 키 컬럼을 "=" 으로 처리
            -- where 절 : 조건을 처리
select *
from employee  e join department d    -- on절을 사용할떄는 join
on e.dno  = d.dno
where job = 'MANAGER';                    
            


-- join시 테이블 알리어스
select *
from employee e  , department d
where e.dno=d.dno
and salary > 1500;

-- select 절에서 공통의 키 컬럼을 출력시에 어느 테이블의 컬럼인지 명시 : dno
select eno , job , e.dno , dname
from employee e , department d
where e.dno = d.dno;

--두 테이블을 join 해서 부서별[명] 으로  월급 (salary) 의 쵀대값을 출력해 보세요
select dname , max(salary)
from employee e , department d
where e.dno = d.dno
group by dname;


-- NATUAL JOIN : Oracle 9i 지원
    -- EQUI JOIN 의 Where 절을 없앰 : 두 테이블의 공통의 키 컬럼을 정의 " = "
    -- 공통의 키 컬럼을 Oracle 내부적으로 자동으로 감지해서 처리. 
    -- 공통 키컬럼을 별칭 이름을 사용하면 오류가 발생
    
select eno , ename , dname , dno
from employee e  natural join department d;

-- 주의 : select 절의 공통키 컬럼을 출력시 테이블명을 명시하면 오류 발생

-- EQUI JOIN vs NATURAL JOIN  의 공통 키 컬럼 처리
    -- EQUI JOIN : select 에서 반드시 공통 키컬럼을 출력 할떄 테이블명을 반드시 명시
    -- NATURAL JOIN : select 에서 반드시 공통 키컬럼을 출력 할떄 테이블명을  명시 하면 안된다
            


--EQUI
select ename ,  salary , dname , e.dno   -- e.dno : EQUI JOIN 에서는 반드시 명시
from employee e , department d 
where e.dno = e.dno 
and salary >2000;

--NATURAL
select ename , salary , dname , dno     -- dno : NATURAL JOIN 에서는 테이블명을 명시하면 안된다 
from employee  natural join department d
where salary > 2000;

--ANSI 호환의 INNER JOIN
select ename , salary , dname ,  e.dno
from employee e join department d
on e.dno = d.dno
where salary > 2000;


-- NON EQUI JOIN : EQUI JOIN 에서 where 절의 "=" 를 사용하지 않는 join

select * from salgrade ;  -- 월급의 등급을 표시하는 테이블

select ename , salary ,grade
from employee , salgrade
where salary between losal and hisal;

-- 테이블 3개 조인
select ename , dname , salary , grade 
from employee e , department d , salgrade s
where e.dno = d.dno
and salary between losal and hisal;




