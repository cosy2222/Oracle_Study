-- dno �÷��� 10�� �μ��� ��� ���޿��� + 300�� ó���ϰ� ,  20 �� �μ��� ��� ���޿� +500
        -- 30���� +700
select  ename , salary, dno ,decode ( dno , 10 , salary + 300,
                                            20 , salary + 500,
                                            30 , salary + 700) �μ�������
from employee;