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
    -- lengthb : ������ ���̸� ��ȯ , �ѱ� 3byte�� ��ȯ 
