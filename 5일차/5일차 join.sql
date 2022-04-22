-- JOIN에서 USING를 사용하는 경우 : 
    -- NATURAL JOIN : 공통 키 컮럼을 Oracle 내부에서 자동 처리
            -- 반드시 두테이블의 공통키 컬럼의 데이터 타입이 같아야 한다
    -- 두테이블의 공통 키 컬럼의 데이터 타입이 다른경우 USING를 사용한다 
    -- 두테이블의 공통 키 컬럼이 여러개인 경우 USING를 사용한다    
    
    select dno , job, loc 
    from employee e inner join department e
    using (dno)
    where dno = 10;
 
-- Self join : 자기 자신의 테이블을 조인 한다  ( 주로 사원의 상사 정보를 출력할떄 사용함 )
    -- 별칭을 반드시 사용해야 한다 
    -- select 절에서 어느테이블에 있는 컬럼인지 반드시 명시해야한다 ( 별칭.컬럼명 ) 
    
select eno , ename , manager 
from employee
where manager = 7788;

-- self join 을 사용해서 사원의 직속상관 이름 출력

--- equi join 으로 self join 을 처리 
select e.eno 사원번호 , e.ename 사원이름 , e.manager 직속상관번호 , m.ename 직속상관이름 
from employee e  , employee m    -- self join
where e.manager = m.eno
order by e.ename;

select eno , ename , manager , eno , ename
from employee ;

-- ANSI 호환 : INNER JOIN 으로 처리
select e.eno 사원번호 , e.ename 사원이름 , e.manager 직속상관번호 , m.ename 직속상관이름 
from employee e join employee m
on e.manager = m.eno
order by e.ename;

--- equi join 으로 self join 을 처리 
select e.ename  || '의 직송상관은 ' || e.manager || '입니다' 
from employee e , employee m 
where e.manager = m.eno
order by e.ename ;

-- ANSI 호환 : INNER JOIN 으로 처리
select e.ename  || '의 직송상관은 ' || e.manager || '입니다' 
from employee e join employee m 
on e.manager = m.eno
order by e.ename ;


-- outer join : 
    -- 특정 컬럼의 두 테이블에서 공통적이지 않는 내용을 출력 해야 할때 
    -- 공적적이지 않는 컬럼은 null 출력
    -- + 기호를 사용해서 출력 : oracle
    -- OUTER JOIN 구문을 사용해서 출력  : ANSI 호환 
    
    -- oracle
    select e.ename , m.ename
    from employee e join employee m
    on e.manager = m.eno (+)
    order by e.ename ;

    -- ANSI 호환
        -- left outer join : 공통적인 부분이 없더라도  왼쪽은 무조건 모두 출력
        -- right outer join : 공통적인 부분이 없더라도  오른쪽은 무조건 모두 출력
        -- full outer join : 공통적인 부분이 없더라도 무조건 양쪽 모두 출력
    select e.ename , m.ename
    from employee e right outer join employee m 
    on e.manager = m.eno
    order by e.ename;


