/*
    <SUBQUERY(��������)>
    �ϳ��� �ֵ� SQL(SELECT,CREATE,INSERT,UPDATE,...)�ȿ� ���Ե� �� �ϳ��� SELECT��
    
    ���� SQL���� ���� ���� ������ �ϴ� SELECT��
*/

--���� �������� ���� 1
-- ���ö ����� ���� �μ��� �����
--1)���� ���ö ����� �μ��ڵ带 ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='���ö'; -- ���ö ����� �μ��ڵ�� D9

--2)�μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE='D9';--������,������.���ö

--���� �� �ܰ踦 ���ĺ���
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE=(SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='���ö'); --D9

--���� �������� ���� 2
--��ü ����� ��� �޿����� �� ���� �޿��� �ް� �ִ� ������� ���, �̸�,�����ڵ� ��ȸ

--1)��ü ����� ��� �޿��� ���ϱ�
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE;

--2)
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE
WHERE SALARY >(SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE);

/*
    �������� �׺�
    ���������� ������ ������� ���� ��̳Ŀ� ���� �з�
    
    -������(���Ͽ�) �������� : ���������� ������ ������� ������ 1���� �� (��ĭ�� �÷������� ���ö�)
    -������(���Ͽ�) �������� : ���������� ������ ������� ���� ���϶�
    -(������)���߿� �������� : ���������� ������ ������� ���� ���϶�
    -������ ���߿� �������� : ���������� ������ ������� ���� �� ���� ���϶�
    
    -> ���������� ������ ������� ���� ��̳Ŀ� ���� ��� ������ �����ڰ� �޶�����.

*/

/*
    1.������ (���Ͽ�) ��������(SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� 1���϶�
    �Ϲ� ������ ���� (=,!=,>,<,<=,>=..)
*/

--�� ������ ��� �޿����� �� ���� �޴� ������� ����� �����ڵ� �޿��� ��ȸ�غ���
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);

--�����޿��� �޴� ����� ���,�����,�����ڵ�,�޿�,�Ի����� ��ȸ�غ���
SELECT EMP_NAME,JOB_CODE,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--���ö ����� �޿����� �� ���� �޴� ������� ���,�̸�,�μ��ڵ�,�޿�
SELECT EMP_NAME,JOB_CODE,SALARY,EMP_NO
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='���ö');

SELECT EMP_NAME,JOB_CODE,SALARY,EMP_NO,DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='���ö');

--�μ��� �޿� ���� ���� ū �μ� �ϳ����� ��ȸ,�μ��ڵ�,�μ���,�޿��� ��(��������+GROUP BY+HAVING)
SELECT MAX(SUM(SALARY)),DEPT_TITLE,DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
GROUP BY DEPT_TITLE, DEPT_CODE
HAVING MAX(SALARY) IN (SELECT SUM(SALARY) FROM EMPLOYEE);

SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--��ġ��

SELECT DEPT_CODE,DEPT_TITLE,SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY DEPT_CODE,DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE);

/*
    2.������ �������� (MULTI ROW SUBQUERY)
    
    ���������� ��ȸ ������� ���� ���� ���
    
    - IN (10,20,30) �������� : �������� ������߿��� �ϳ��� ��ġ�ϴ°��� �ִٸ� /NOT IN = ���ٸ�
    > ANY (10,20,30) �������� : �������� ������߿� �ϳ��� Ŭ ���
    < ANY (10,20,30) �������� : �������� ������߿� �ϳ��� ���� ���
    
    > ALL : �������� ������� ��� ������ Ŭ ��� (����� �� ���� ū ������ Ŭ ���)
    < ALL : �������� ������� ��� ������ ���� ��� (����� �� ���� ���� ������ ���� ���)
    
*/

--�� �μ� �� �ְ� �޿��� �޴� ����� �̸�,�����ڵ�, �޿� ��ȸ
--1) �� �μ� �� �ְ�޿� ��ȸ (������,���Ͽ�)
SELECT DEPT_CODE,MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--2)������ ��ȸ�� �޿����� �޴� ����� ��ȸ
SELECT DEPT_TITLE,DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
        FROM EMPLOYEE
        GROUP BY DEPT_CODE);

SELECT MAX(COUNT(*))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT DEPT_TITLE,COUNT(*) �ο���
FROM EMPLOYEE E,DEPARTMENT D
WHERE DEPT_CODE=DEPT_ID
GROUP BY DEPT_TITLE
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM EMPLOYEE
GROUP BY DEPT_CODE);

SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('������','�����'));

SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�̿���','�ϵ���');

SELECT EMP_NAME,JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�̿���','�ϵ���'));

--�븮�����ӿ��� ���庸�� �޿��� ���� �޴� ����� ��ȸ (���,�̸�,���޸�,�޿�)
--1) ���� ���޵��� �޿��� ��ȸ�غ���
SELECT SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND J.JOB_NAME = '����';

--2)���� �޿��� ���� �ϳ��� ���� �޴� ��� ��ȸ

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY >= 2200000
AND JOB_NAME='�븮';

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY > ANY (SELECT SALARY
        FROM EMPLOYEE E,JOB J
        WHERE E.JOB_CODE=J.JOB_CODE
        AND J.JOB_NAME = '����')
AND JOB_NAME='�븮';

--���������ӿ��� �������� �޿����� ���̹޴� ���� ��ȸ (���,�̸�,���޸�,�޿�)

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY > ALL (SELECT SALARY
        FROM EMPLOYEE E,JOB J
        WHERE E.JOB_CODE=J.JOB_CODE
        AND J.JOB_NAME = '����')
AND JOB_NAME='����';

/*
    3.(������)���߿� ��������
    �������� ��ȸ ����� ���� �� ��������, ������ �÷��� ������ �������� ���
*/

--������ ����� ���� �μ��ڵ�,���� �����ڵ忡 �ش��ϴ� ����� ��ȸ(�����,�μ��ڵ�,�����ڵ�,�Ի���)

--1)������ ����� �μ��ڵ�,�����ڵ� ��ȸ�ϱ�
SELECT DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME='������';

--2)�μ��ڵ� D5 �̸� �����ڵ� J5�� ����� ��ȸ�غ���(�����,�μ��ڵ�,�����ڵ�,�Ի���)
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND JOB_CODE='J5';

SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) = (SELECT DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME='������');
--���߿� ��������(���� ���� ���� ���߱�)
--(�񱳴���÷�1,�񱳴���÷�2) = (���Ұ�1,���Ұ�2 => �������� �������θ� �����ؾ��Ѵ�)

--�ڳ��� ����� ���� �����ڵ�
SELECT EMP_NAME,EMP_ID,JOB_CODE,MANAGER_ID
FROM EMPLOYEE
    WHERE (MANAGER_ID,JOB_CODE) = (SELECT MANAGER_ID,JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME='�ڳ���');


/*

    4.������ ���߿� ��������
    
    �������� ��ȸ ����� ������ ���� �÷��� ���
    
*/

--�� ���޺� �ּ� �޿��� �޴� ����� ��ȸ(���,�̸�,�����ڵ�,�޿�)
--1)�� ���޺� �ּ� �޿��� ��ȸ
SELECT JOB_CODE,MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE; 

--2)������ ���� ��ϵ鿡 �ش��ϴ� ��� ��ȸ�ϱ�
SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE,MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);
                            
SELECT EMP_ID,EMP_NAME,NVL(DEPT_CODE,'�μ�������') DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'�μ�������'),SALARY) IN (SELECT NVL(DEPT_CODE,'�μ�������'),MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE);
                            
/*
    5.�ζ��κ�(INLINE VIEW)
    FROM���� ���������� �����ϴ°�
    �������� ������ ���(RESULT SET)�� ���Ը� ��� ����ϰڴ�.
*/                            

--���ʽ� ���� ������ 3000���� �̻��� ������� ���,�̸�,���ʽ� ���� ����, �μ��ڵ带 ��ȸ
SELECT EMP_ID,EMP_NAME,(SALARY+(SALARY*NVL(BONUS,0))*12) ����,DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY+(SALARY*NVL(BONUS,0))*12) >= 3000000;

SELECT EMP_NAME
FROM (SELECT EMP_ID,EMP_NAME,(SALARY+(SALARY*NVL(BONUS,0))*12) ����,DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY+(SALARY*NVL(BONUS,0))*12) >= 3000000);

--�ζ��κ並 �ַ� ����ϴ� ��
--TOP-N �м� : �����ͺ��̽� �� �ִ� �ڷ��� �ֻ��� N���� �ڷḦ �������� ����ϴ� ���

--�� ������ �޿��� ���� ���� ���� 5��(����,�����,�޿�)
--ROWNUM : ����Ŭ���� �������ִ� �÷����� ��ȸ�� ������� 1���� ������ �ο����ִ� �÷��̴�.

SELECT ROWNUM,EMP_NAME,SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

--�ذ�
SELECT ROWNUM,EMP_NAME,SALARY
FROM (SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC)
WHERE ROWNUM <=5;

--�� �μ��� ��� �޿��� ���� 3���� �μ��� �μ��ڵ� ��� �޿��� ��ȸ

SELECT DEPT_CODE,FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;

SELECT ROWNUM,E.*
FROM (SELECT DEPT_CODE,FLOOR(AVG(SALARY))
        FROM EMPLOYEE E
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC) E
WHERE ROWNUM <=3;

--���� �ֱٿ� �Ի��� ��� 5�� ��ȸ -�ζ��κ�� ���� �ű��
SELECT DEPT_CODE,FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;

SELECT ROWNUM,E.*
FROM (SELECT EMP_NAME,HIRE_DATE
        FROM EMPLOYEE E
        ORDER BY HIRE_DATE DESC) E
WHERE ROWNUM <=5 ORDER BY HIRE_DATE ASC;

/*

    6.���� �ű�� �Լ� (WINDOW FUNCTION)
    
    RANK() OVER(���� ����)
    DENSE_RANK() OVER(���� ����)
    -RANK() OVER : ���� 1���� 3���̶�� �ϸ� �� ���������� 4���� �ϰڴ�
    -DENSE_RANK() OVER : ���� 1���� 3���̾ �� ���� ������ 2���� �ϰڴ�
    
    ���� ����:ORDER BY��(���ı����÷��̸� ��������/��������)
    SELECT �������� ��밡��

*/

--������� �޿��� ���� ������� �Űܼ� �����,�޿�,���� ��ȸ : RANK() OVER()
SELECT EMP_NAME,SALARY,RANK()OVER(ORDER BY SALARY DESC) ����
FROM EMPLOYEE;

SELECT EMP_NAME,SALARY,DENSE_RANK()OVER(ORDER BY SALARY DESC) ����
FROM EMPLOYEE
WHERE RANK() OVER(ORDER BY SALARY DESC) <=5; --RANK�Լ��� WHERE���� ��� �Ұ�

--�ζ��κ� ���
SELECT *
FROM (SELECT EMP_NAME,SALARY,RANK()OVER(ORDER BY SALARY DESC) ����
        FROM EMPLOYEE)
WHERE ���� <=5;