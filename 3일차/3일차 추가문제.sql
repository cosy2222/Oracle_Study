-- 8번문제 : 사원번호 , [사원번호 2자리만 출력 나머지는 *가림] as "가린번호" ,
--          이름 , [이름의 첫자만 출력 총네자리 , 세자리는* 가림]
select eno , rpad(substr(eno ,1,2) ,4 ,'*') as 가린번호
      , ename , rpad(substr(ename,1,1) ,4,'*') as 가린이름  
from employee;



--9번문제 : 주민번호를  123456-1****** 출력하도록 , 전화번호 : 010-11******* 출력
SELECT rpad(substr('123456-1111111',1,8) , length('123456-1111111') , '*') as 주민번호,
       rpad(substr('010-1111-1111',1,6) ,length('010-1111-1111') , '*') as 전화번호
from dual;



-- 10번 문제  : 사원번호 , 사원명 , 직속상관 , 
      --  직송상관의 번호가 없을경우 : 0000
      --  직송상관의 번호 앞2자리가 75일 경우 : 5555
      --  직송상관의 번호 앞2자리가 76일 경우 : 6666
      --  직송상관의 번호 앞2자리가 77일 경우 : 7777
      --  직송상관의 번호 앞2자리가 78일 경우 : 8888
      --  그외는 그대로 출력
      
select eno , ename , manager , 

decode( substr(manager,1,2) , null , '0000',
                              75 , 5555,
                              76 , 6666,
                              77 , 7777,
                              78 , 8888,
                              manager)  as 수정
                                         
from employee;                                         
      

