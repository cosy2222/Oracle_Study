-- dno 컬럼이 10번 부서일 경우 월급에서 + 300을 처리하고 ,  20 번 부서일 경우 월급에 +500
        -- 30번은 +700
select  ename , salary, dno ,decode ( dno , 10 , salary + 300,
                                            20 , salary + 500,
                                            30 , salary + 700) 부서별월급
from employee;