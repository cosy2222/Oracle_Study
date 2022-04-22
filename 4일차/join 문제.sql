-- 1번 문제 
select ename , e.dno , dname 
from employee e , department d
where e.dno = d.dno
and ename = 'SCOTT';

-- 2번 문제 
select ename , dname , loc
from employee e join department d
on e.dno = d.dno;

-- 3번문제 
-- JOIN에서 USING를 사용하는 경우 : 
    -- NATURAL JOIN : 공통 키 컮럼을 Oracle 내부에서 자동 처리
            -- 반드시 두테이블의 공통키 컬럼의 데이터 타입이 같아야 한다
    -- 두테이블의 공통 키 컬럼의 데이터 타입이 다른경우 USING를 사용한다 
    -- 두테이블의 공통 키 컬럼이 여러개인 경우 USING를 사용한다 
select dno , job, loc 
from employee e inner join department e
using (dno)
where dno = 10;


--4번 문제
select ename , dname , loc 
from employee natural join department
where  commission is not null;

--5번 문제
select ename , dname
from employee e , department d
where e.dno = d.dno
and ename like '%A%';

--6번 문제
select ename , job , dno , dname , loc 
from employee e natural join department d
where loc = 'NEW YORK';






