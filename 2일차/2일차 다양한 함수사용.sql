------ �پ��� �Լ� ����ϱ� 
/*
    1. ���ڸ� ó���ϴ� �Լ�
        - UPPER : �빮�ڷ� ��ȯ
        - LOWER : �ҹ��ڷ� ��ȯ
        - INITCAP : ù�ڴ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
        
        dual ���̺� : �ϳ��� ����� ��� �ϵ��� �ϴ� ���̺�
*/

select '�ȳ��ϼ���' as �ȳ�
from dual;


select 'Oracle mania' , upper ('Oracle mania') , Lower ('Oracle mania') , initcap('Oracle mania')
from dual;

select ename , lower (ename) , initcap(ename) , upper (ename)
from employee;

select * from employee
where ename = 'allen';    -- �˻��� �ȵ�

select * from employee
where lower(ename) = 'allen';

select ename , initcap(ename) from employee
where initcap(ename) = 'Allen';

-- ���� ���̸� ��� �ϴ� �Լ� 
    -- length : ������ ���̸� ��ȯ
    -- lengthb : ������ ���̸� ��ȯ |   ���� : 1byte , �ѱ� : 3byte�� ��ȯ 
    
select length ('Oracle mania') , length ('����Ŭ �ŴϾ�') from dual;    
    
select lengthb ('Oracle mania') , lengthb ('����Ŭ �ŴϾ�') from dual;   

SELECT ename , length (ename) , job , length(job)  from EMPLOYEE;

-- ���� ���� �Լ� 
    -- concat : ���ڿ� ���ڸ� �����ؼ� ���
    
    -- substr : ���ڸ� Ư����ġ���� �߶���� �Լ� 
    -- substrb : ���ڸ� Ư����ġ���� �߶���� �Լ�  ������ 1byte  �ѱ��� 3byte �� ó�� 
    
    -- instr   : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
    -- instr   : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ  ������ 1byte  �ѱ��� 3byte �� ó�� 
    
    -- lpad , rpad : �Է� ���� ���ڿ����� Ư���� ���ڸ� ����
    
    -- trm  : �߶󳻰� ���� ���ڸ� ��ȯ 
    
select 'Oracle' , 'mania', concat ('Oracle' , 'mania') from dual;

select concat (ename ,' ' || job) from employee;

select '�̸��� : ' || ename || ' �̰� , ��å�� : ' || job || '�Դϴ�'
from employee;

select '�̸��� : ' || ename || ' �̰� , ���ӻ����� : ' || manager || '�Դϴ�'  ���ӻ�����
from employee;

select 'Oracle mania' , substr ('Oracle mania' , 4,3) , substr ('����Ŭ �ŴϾ�' , 2,4)
from dual;
    
select 'Oracle mania' , substr ('Oracle mania' , -4,3) , substr ('����Ŭ �ŴϾ�' , -6,4)
from dual;    
    
select ename , substr (ename , 2,3) , substr (ename , -5,2) from employee;

select 'Oracle mania' , substrb ('Oracle mania' , 3,3) , substrb ('����Ŭ �ŴϾ�' , 4,6)
from dual;


-- �̸��� N���� ������ ����� ����ϱ� (substr �Լ��� ���)
select ename from employee
where substr (ename, -1 , 1) = 'N';


-- 87�⵵ �Ի��� ����� ����ϱ� (substr �Լ��� ���)
select hiredate from employee
where substr (hiredate , 1 , 2) = '87';


-- instr ( ��� , ã�� ���� , ������ġ , ����� �߰� ) : ������� ã�� ������ �ε������� �߷�
select 'Oracle mania' , instr ('Oracle mania' , 'O') from dual;

select 'Oracle mania' , instr ('Oracle mania' , 'a' , 5,2) from dual;   

select 'Oracle mania' , instr ('Oracle mania' , 'a' , -5,1) from dual;   

select instr ( job , 'A' , 1,1)   from employee
where lower(job) = 'manager';


-- lpad , rpad : Ư�� ���̸�ŭ ���ڿ��� �����ؼ� ���� , �����ʿ� ������ Ư�� ���ڷ� ó�� 
    -- lpad ( ��� ,  �÷��� ���ڿ� ũ�� ,  Ư������ ���� ) 
SELECT lpad (1234 , 10 , '#') from dual;
SELECT rpad (1234 , 10 , '@') from dual;


-- TRIM : ���� ���� , Ư�� ���ڵ� ����
 -- LTRIM  : ���� ���� ����
 -- RTRIM  : ���� �� ���� ����
 -- TRIM :  ���� ,������ ���� ����
 
 select ltrim ( '     Oracle mania       ') , rtrim ( '     Oracle mania       ') , trim ( '     Oracle mania       ') as trim
 from dual;
    
    
    
    
    
