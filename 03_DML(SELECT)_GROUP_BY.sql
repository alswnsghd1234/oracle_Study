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



--�� ���޺� �޿� ����� 300���� �̻��� ���� �ڵ�,��� �޿�, �����,�ְ�޿�,�ּұ޿� ��ȸ
SELECT JOB_CODE,AVG(SALARY),COUNT(*),MIN(SALARY),MAX(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING AVG(SALARY) >=3000000;

-- �� �μ� �� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ

SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

-- �� �μ� �� ��� �޿��� 350���� ������ �μ�����

SELECT JOB_CODE
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING AVG(SALARY) <=3500000;

----------------------------------------------

/*

    <SELECT�� �ְ� �� �������>
    SELECT ��ȸ�ϰ��� �ϴ� �÷��� ���� /'*'/�Լ���/�����
    FROM ��ȸ�ϰ����ϴ� ���̺� �� / �������̺�(DUAL)
    WHERE ���ǽ� (��, �׷��Լ��� �ȵ�)
    GROUP BY �׷� ���ؿ� �ش��ϴ� �÷��� / �Լ���
    HAVING �׷��Լ��Ŀ� ���� ���ǽ�
    ORDER BY [���ɱ��ؿ� �ش��ϴ� �÷��� / ��Ī / �÷��� ����][ASC/DESC](��������)[NULLS FIRST/NULLS LAST](��������)
   
*/

/*
    <���� ������ SET OPERATOR>
    �������� �������� ������ �ϳ��� ���������� ����� ������

    -UNION(������) : �� �������� ������ ������� ���� �� �ߺ��Ǵ� �κ��� �ѹ��� ���� �ߺ��� �����Ѱ� -> OR
    -UNION ALL : �� �������� ������ ������� ���� �� �ߺ����Ÿ� ���� ���� �� -> ������ + ������
    -INTERSECT(������) : �� �������� ������ ������� �ߺ��� �κ� -> AND
    -MINUS(������) : ���� ������ ��������� ���� ������ ������� �� ������ �κ�
                    -> ���� ������ ����� - ������

    ���ǻ��� : �� �������� ����� ���ļ� �Ѱ��� ���̺�� ��������ϱ� ������ �� �������� SELECT�� �κ��� ���ƾ��Ѵ�.
    ��, ��ȸ�� �÷��� �����ؾ� ��

*/

-- 1. UNION(������) : �� �������� ������ ������� �������� �ߺ��� ����
-- �μ��ڵ尡 D5 �̰ų� �޿��� 300���� �ʰ��� ����� ��ȸ(���,�����,�μ��ڵ�,�޿�) -> OR
-- �μ��ڵ尡 D5�� ����鸸 ��ȸ

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

--�޿��� 300���� �ʰ��� ����� ��ȸ
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY>3000000; --8�� ��ȸ

--�μ��ڵ尡 D5 �̰ų� �޿��� 300���� �ʰ��� ����� ��ȸ(���,�����,�μ��ڵ�,�޿�) -> UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY>3000000;

--OR �����ڷ�
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR  SALARY>3000000;

--1. �����ڵ尡 J6�� ����鸸 ��ȸ(���
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6' OR DEPT_CODE='D1';

--2. UNION ALL : �������� ���� ����� ���ؼ� �����ִ� ������

SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
UNION ALL
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D1'; --9��

--3. INTERSECT : ������ ���� ���� ����� �ߺ��� ������� ��ȸ ->AND
--
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
INTERSECT
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

-- 4. MINUS : ������, ���� ���� ����� ���� ���� ����� �� ������
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
MINUS
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

