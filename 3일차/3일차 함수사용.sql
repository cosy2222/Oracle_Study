-- ���� �Լ� 
/*
    ROUND : Ư�� �ڸ������� �ݿø�.
    TRUNC : Ư�� �ڸ������� �߶󳽴� 
    MOD   : �Է¹��� ���� ���� �������� ��� 
*/

-- round ( ��� ) : �Ҽ��� ù��°�ڸ����� �ݿø�
-- round ( ��� , �Ҽ����ڸ��� ) : 
    -- �Ҽ��� �ڸ����� ����϶� �Ҽ��� ���� ���������� �ڸ�����ŭ �̵��ϰ� �� �ڸ��� �ڿ��� �ݿø�
    -- �Ҽ��� �ڸ����� �����϶� �Ҽ��� ���� ��������  �ڸ�����ŭ �̵��ϰ� �� �ڸ������� �ݿø�
select 98.7654  , round (98.7654) , round (98.7654 , 2) , round (98.7654 , -1) , round (98.7654 , -2)
            , round (98.7654 , -3) ,round (98.7654 , 3)
from dual ;

select 12345.6789 , round(12345.6789) , round(12345.6789 , -3)
from dual;


select 98.7654 , trunc (98.7654) , trunc (98.7654 , 2) , trunc (98.7654 ,-1)
from dual;

--mod (��� , �����¼�) : ����� ����� �������� ���
select mod (31 , 2 )  , mod (31,5) , mod (31,8)
from dual;

select salary , mod (salary , 300)
from employee;

-- employee ���̺��� �����ȣ�� ¦���� ����鸸 ���

select ename , eno 
from employee
where mod(eno , 2) = 0;

/*   ��¥ �Լ�
    sysdate : �ý��ۿ� ����� ���� ��¥�� ��� 
    months_between : �� ��¥ ������ �� ���������� ��ȯ
    add_months     : Ư�� ��¥�� �������� ���Ѵ� 
    next_day       : Ư�� ��¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥�� ��ȯ 
    last_day       : ���� ������ ��¥�� ��ȯ
    round          : ���ڷ� ���� ��¥�� Ư�� �������� �ݿø� 
    trunc          : ���ڷ� ���� ��¥�� Ư�� �������� ���� 
*/

-- �ڽ��� �ý����� ��¥ ���
select sysdate
from dual ;

select sysdate -1 as ������¥ , sysdate as ���ó�¥  , sysdate +1 as ���ϳ�¥
from dual;

select * from employee
order by hiredate asc;

select hiredate , hiredate -1 , hiredate + 11
from employee;


-- �Ի��Ͽ��� ���� ��������� �ٹ��ϼ��� ���
select round(sysdate - hiredate) as "�� �ٹ� �ϼ�"
from employee;

select trunc(sysdate - hiredate) as "�� �ٹ� �ϼ�"
from employee;


-- Ư�� ��¥���� ��(month)�� �������� ������¥ ���ϱ�
select hiredate , trunc (hiredate , 'MONTH')
from employee;

-- �� ������� �ٹ��� ������ ���ϱ� 
select ename , sysdate , hiredate , trunc (MONTHS_BETWEEN(SYSDATE,hiredate)) as �ٹ�������
from employee;

-- add Months (date1 , ������ )  : date1 ��¥�� 6���� ���ϱ� 
-- �Ի����� 6������ ���������� ��� 
select hiredate , add_MONTHS(hiredate , 6)
from employee;

-- �Ի��� �� 100���� ���� ������ ��¥
select hiredate , hiredate+100
from employee;

-- next_day (date , '����') : date�� �����ϴ� ���Ͽ� ���� ��¥�� ����ϴ� �Լ� 
select sysdate , next_day (sysdate , '�����') as "�̹����� ����� ��¥"
from dual;

-- last_day (date) : date�� �� ���� ��������
select hiredate , last_day(hiredate) 
from employee;

-- �� ��ȯ �Լ� <== �߿�
/*
    TO_CHAR  : ��¥�� �Ǵ� �������� ���������� ��ȯ
    TO_DATE  : �������� ��¥������ ��ȯ 
    TO_NUMBER : �������� ���������� ��ȯ 
*/

-- ��¥ �Լ� ����ϱ� 

--TO_CHAR ( date , 'yyyymmdd')
select ename , hiredate , to_char(hiredate , 'yyyymmdd') , to_char (hiredate , 'yymm') ,
       to_char(hiredate , 'yyyymmdd day') , to_char (hiredate , 'yyyymmdd dy')
from employee;

-- ���ó�¥�� ����ϰ� �ð� �ʱ��� ���

select sysdate ,  to_char (sysdate , 'yyyymmdd hh:mi:ss dy')
from dual;

desc employee;

select hiredate , to_char(hiredate , 'yyyy_mm_dd hh:MI:ss day')
from employee;

-- to_char ���� ���ڿ� ���õ� ����
/*
    0 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� 0���� ä�� 
    9 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� ä���� �ʽ��ϴ� 
    L : �� ������ ��ȭ ��ȣ�� ���
    . : �Ҽ������� ǥ�� 
    , : õ������ ������ 
*/

select ename ,salary, to_char(salary ,'L999,999') , to_char(salary , 'L000,000')
from employee;

-- to_date ('char' , 'fromat' ) : ��¥�������� ��ȯ
-- �����߻� : data -char 
select sysdate , sysdaye - '20000101'
from dual;

-- 2000��01��01�� ���� ���ñ����� �ϼ� 
select sysdate , sysdate - to_date('20000101' , 'yyyymmdd')
from dual;

select sysdate ,to_date('02/10/10','yy/mm/dd'), trunc (sysdate - to_date('021010' , 'yymmdd')) as "��¥�� ��"
from dual ;

select ename , hiredate
from employee
where hiredate = '81/02/22';

select ename , hiredate
from employee
where hiredate = to_date('19810222' , 'yyyymmdd');

select ename , hiredate 
from employee
where hiredate = to_date('1981-02-22' , 'yyyy-mm-dd');

-- 2000�� 12�� 25�Ϻ��� ���ñ��� �� �� ���� �������� ���
SELECT trunc(MONTHS_BETWEEN(SYSDATE,to_date('20001225' , 'yyyymmdd')))
from dual;

-- to_number : number ������ Ÿ������ ��ȯ , 
SELECT 100000 - 50000
from dual;

--����
select '100,000' - '50,000'
from dual;

select to_number('100,000' , '999,999')  - to_number('50,000' , '999,999')
from dual;

-- NVL �Լ� : null�� �ٸ� ������ ġȯ
    -- nvl (expr1, expr2) : expr1 ���� null�� expr2�� ġȯ

select commission
from employee;

select nvl( commission,0)
from employee;

select manager , nvl(manager , 1111) 
from employee;

-- NVL2 �Լ� 
    --NVL2 (expr1 ,expr2 , expr3 ) : expr1 �� null�� �ƴϸ� expr2�� ��� , expr1�� null�̸� expr3�� ���
    
select salary , commission
from employee;

--NVL �Լ��� ���� ����ϱ� 
select salary *12 + nvl(commission , 0)  as ����
from employee;



--NVL2 �Լ��� ���� ����ϱ� 
select salary ,commission , nvl2 ( commission , salary*12+commission , salary*12) as ����
from employee;


-- nullif : �� ǥ������ ���ؼ� ������ ��� null�� ��ȯ�ϰ� �������� �ʴ°�� ù��° ǥ������ ��ȯ
select nullif ('A','A') , nullif('A','B')
from dual;

-- coalesce �Լ� 
-- coalesce (expr1 , expr2 , expr3 ...... expr-n) : 
           -- expr1 �� null�� �ƴϸ� expr1�� ��ȯ 
           -- expr1 �� null�̸�  expr2�� null�� �ƴϸ� expr2�� ��ȯ 
           -- expr1 �� null�̰� exprr2�� null�̸� expr3�� null�� �ƴϸ� expr3�� ��ȯ  ....... 
           
select coalesce ('abc' , 'bcd' , 'def','efg','fgi')
from dual;

select coalesce (null , 'bcd' , 'def','efg','fgi')
from dual;

select coalesce (null , null , 'def','efg','fgi')
from dual;

select coalesce (null , null , null,'efg','fgi')
from dual;

select ename , salary , commission , coalesce(commission , salary , 0)
from employee;

--decode �Լ� 
/*
    DECODE ( ǥ���� , ����1 , ���1 ,
                     ����2 , ���2,
                     ����3 , ���3,
                     �⺻���n
            )         
*/

select ename , dno , decode (dno , 10 , 'ACCOUNTING',
                                    20 , 'RESEARCH' ,
                                    30 , 'SALES' ,
                                    40 , 'OPERATION',
                                    'DEFAULT' ) as DNAME
from employee;


-- dno �÷��� 10�� �μ��� ��� ���޿��� + 300�� ó���ϰ� ,  20 �� �μ��� ��� ���޿� +500
        -- 30���� +700
select  ename , salary, dno ,decode ( dno , 10 , salary + 300,
                                            20 , salary + 500,
                                            30 , salary + 700) �μ�������
from employee;

-- case : if ~ esle if , else if ~~~
    /*
        case ǥ���� when ����1 then ���1 
                   when ����2 then ���2
                   when ����3 then ���3
                   else ���n
        end
    */

select ename , dno , case when dno = 10  then 'ACCOUNTING'
                          when dno = 20 then 'RESEARCH'
                          when dno = 30 then 'SALES'
                          else 'DEFAULT'
                    end as DNAME
from employee
order by dno asc;





