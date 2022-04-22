-- JOIN���� USING�� ����ϴ� ��� : 
    -- NATURAL JOIN : ���� Ű ������ Oracle ���ο��� �ڵ� ó��
            -- �ݵ�� �����̺��� ����Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�
    -- �����̺��� ���� Ű �÷��� ������ Ÿ���� �ٸ���� USING�� ����Ѵ� 
    -- �����̺��� ���� Ű �÷��� �������� ��� USING�� ����Ѵ�    
    
    select dno , job, loc 
    from employee e inner join department e
    using (dno)
    where dno = 10;
 
-- Self join : �ڱ� �ڽ��� ���̺��� ���� �Ѵ�  ( �ַ� ����� ��� ������ ����ҋ� ����� )
    -- ��Ī�� �ݵ�� ����ؾ� �Ѵ� 
    -- select ������ ������̺� �ִ� �÷����� �ݵ�� ����ؾ��Ѵ� ( ��Ī.�÷��� ) 
    
select eno , ename , manager 
from employee
where manager = 7788;

-- self join �� ����ؼ� ����� ���ӻ�� �̸� ���

--- equi join ���� self join �� ó�� 
select e.eno �����ȣ , e.ename ����̸� , e.manager ���ӻ����ȣ , m.ename ���ӻ���̸� 
from employee e  , employee m    -- self join
where e.manager = m.eno
order by e.ename;

select eno , ename , manager , eno , ename
from employee ;

-- ANSI ȣȯ : INNER JOIN ���� ó��
select e.eno �����ȣ , e.ename ����̸� , e.manager ���ӻ����ȣ , m.ename ���ӻ���̸� 
from employee e join employee m
on e.manager = m.eno
order by e.ename;

--- equi join ���� self join �� ó�� 
select e.ename  || '�� ���ۻ���� ' || e.manager || '�Դϴ�' 
from employee e , employee m 
where e.manager = m.eno
order by e.ename ;

-- ANSI ȣȯ : INNER JOIN ���� ó��
select e.ename  || '�� ���ۻ���� ' || e.manager || '�Դϴ�' 
from employee e join employee m 
on e.manager = m.eno
order by e.ename ;


-- outer join : 
    -- Ư�� �÷��� �� ���̺��� ���������� �ʴ� ������ ��� �ؾ� �Ҷ� 
    -- ���������� �ʴ� �÷��� null ���
    -- + ��ȣ�� ����ؼ� ��� : oracle
    -- OUTER JOIN ������ ����ؼ� ���  : ANSI ȣȯ 
    
    -- oracle
    select e.ename , m.ename
    from employee e join employee m
    on e.manager = m.eno (+)
    order by e.ename ;

    -- ANSI ȣȯ
        -- left outer join : �������� �κ��� ������  ������ ������ ��� ���
        -- right outer join : �������� �κ��� ������  �������� ������ ��� ���
        -- full outer join : �������� �κ��� ������ ������ ���� ��� ���
    select e.ename , m.ename
    from employee e right outer join employee m 
    on e.manager = m.eno
    order by e.ename;


