/*

    <GROUP BY��>
    �׷��� ������ ������ ������ �� �մ� ���� -> �׷��Լ��� ���� ����
    �ش� ���õ� ���غ��� �׷��� ���� �� ����
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
    
    [ǥ����]
    GROUP BY ������ ���� �÷�
*/

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- �μ����� �׷� ���ڴ�.

--'D1'�� �μ��� �� �޿� ��
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

--�� �μ��� �����
SELECT DEPT_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--�� �μ��� �� �޿����� ��ȸ
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY SUM(SALARY);

--D1 �μ��� ����� ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

--�� ���޺� �����ڵ�,�� �޿��� ��,�����,���ʽ��� �޴� �����,��ձ޿�,�ְ�޿�,�ּұ޿�
SELECT JOB_CODE,
        SUM(SALARY) "�� �޿��� ��",
        COUNT(*) "��� ��",
        COUNT(BONUS) "���ʽ��� �޴� ��� ��",
        ROUND(AVG(SALARY)) "��� �޿�",
        MAX(SALARY) "�ְ� �޿�",
        MIN(SALARY) "�ּ� �޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--�� �μ��� �μ��ڵ�,���ʽ��� �޴� �����,����� �ִ� �����,��ձ޿�
SELECT DEPT_CODE,
        COUNT(*) "��� ��",
        COUNT(BONUS) "���ʽ��� �޴� ��� ��",
        ROUND(AVG(SALARY)) "��� �޿�",
        COUNT(MANAGER_ID) "����� �ִ� ��� ��"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC;

-- ���� �� ��� ��
-- ���� : SUBSTR(EMP_NO,8,1)
SELECT SUBSTR(EMP_NO,8,1) "����"
    ,COUNT(*) "��� ��"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

--DECODE �Լ� �߰��غ���
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','����') "����"
    ,COUNT(*) "��� ��"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

--���� �������� ��� �޿�
--CASE WHEN THEN �������� �ۼ��غ�����

SELECT CASE WHEN SUBSTR(EMP_NO,8,1)='1' THEN '����'
    WHEN SUBSTR(EMP_NO,8,1)='2' THEN '����'
    END "����",
    FLOOR(AVG(SALARY)) "��� �޿�"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

/*
    <HAVING��>
    �׷쿡 ���� ������ �����ϰ��� �� �� ���Ǵ� ����
    (�ַ� �׷��Լ��� ������ ���� ����) -> GROUP BY ���� �Բ� ���δ�.
    [ǥ����]
    SELECT
    FROM
    GROUP BY
    HAVING
*/
-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE,FLOOR(AVG(SALARY)) "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >=3000000;


