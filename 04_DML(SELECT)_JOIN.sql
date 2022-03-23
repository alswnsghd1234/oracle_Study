/*

    <JOIN>
    �ΰ� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ����ϴ� ���� -> SELECT�� �̿�
    ��ȸ �ܷΰ��� �ϳ��� �����(RESULT SET)���� ���´�
    JOIN�� �ؾ��ϴ� ����?
    ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����
    ��������� ������̺�, ���������� �������̺� ...��� ->�ߺ��� �ּ�ȭ�ϱ� ����
    -> ��, JOIN�� �̿��ؼ� �������� ���̺� ���� ���踦 �ξ ����Ѵ�
    -> ������ JOIN�� �ϴ°��� �ƴ϶� ���̺� ���� �����(�÷�)�� ��Ī���Ѽ� ��ȸ�ؾ��Ѵ�.
    
    ������ �з� : JOIN�� ũ�� "����Ŭ ���� ����" �� "ANSI(�̱� ���� ǥ�� ��ȸ)����"���� ������.
    
    ����� �з�
    ����Ŭ ���� ����           |        ANSI����(����Ŭ+�ٸ� DBMS)
    ==========================================================
    �����(EQUAL JOIN)      |        ��������(INNER JOIN) -> JOIN USING/ON
    --------------------------------------------------------------------------
    ��������                  |        �ܺ�����(OUTER JOIN) -> JOIN USING
    (LEFT OUTER JOIN)        |        ���� �ܺ����� (LEFT OUTER JOIN)
    (RIGHT OUTER JOIN)       |        ������ �ܺ����� (RIGHT OUTER JOIN)
                             |        ��ü �ܺ����� (FULL OUTER JOIN)
--------------------------------------------------------------------------------
    ī�׽þ� ��(CARTESIAN PRODUCT)|     ���� ����(CROSS JOIN)
    -------------------------------------------------------------------------
    ��ü����(SELF JOIN)       
    ������(NON EQUAL JOIN)
    -------------------------------------------------------------------------
    +��������(���̺� 3���̻� ����)

*/

--JOIN�� ������� ���� ��
--��ü ������� ���,�����,�μ��ڵ�,�μ������ �˾Ƴ��� �ʹ�.

SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT;

--��ü ������� ���,�����,�����ڵ�,���޸���� �˾Ƴ��� �ʹ�.
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE,JOB_NAME
FROM JOB;

/*
    1. �����(EQUAL JOIN) / ��������(INNER JOIN)
    �����Ű���� �ϴ� �÷��� ���� "��ġ�ϴ� ��鸸" ���εǾ� ��ȸ
    = ��ġ���� �ʴ� ������ ������� ���ܵȴ�.
    -> ����񱳿����� = ("��ġ�Ѵ�" ��� ������ ����)
    
    [ǥ����]
    �����(����Ŭ ����)
    SELECT ��ȸ�ϰ����ϴ� �÷��� ����
    FROM ��ȸ�ϰ��� �ϴ� ���̺��� ����
    WHERE ������ �÷��� ���� ������ ����("=")
    
    ��������(ANSI ����) : ON����
    SELECT ��ȸ�ϰ����ϴ� �÷��� ����
    FROM �������� ���� ���̺�� 1�� ����
    JOIN ���� �� ���̺�� 1�� ���� ON (������ �÷��� ���� ���� ���� ("=")
    
    ��������(ANSI ����):USING����
    SELECT ��ȸ�ϰ����ϴ� �÷��� ����
    FROM �������� ���� ���̺�� 1�� ����
    JOIN ������ ���̺�� 1�� ���� USING(�������÷��� 1������)
    *������ �÷����� �����ϴٸ� USING������ �����ϰ� ��������� ��� ���̺��� �÷������� ���������
        (���̺�� �Ǵ� ��Ī)

*/

--����Ŭ ���뱸��
--FROM���� ��ȸ�ϰ��� �ϴ� ���̺���� ���� (,��)
--WHERE���� ��Ī��ų �÷���(�����)�� ���� ������ ����

--��ü ������� ���,�����,�μ��ڵ�,�μ������ �˾Ƴ����� �Ѵٸ�?
--1)������ �� �÷����� �ٸ���� EX)EMPLOYEE-'DEPT_CODE' / DEPARTMENT - 'DEPT_ID')

SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; --DEPT_CODE�� DEPT_ID�� �����ϴٸ�
-->��ġ���� �ʴ� ���� ��ȸ���� ����(NULL,D3,D4,D7�� ��쿡�� ��ȸ�ȵ�)

--2)������ �� �÷����� ���� ��� EX)EMPLOYEE-'JOB_CODE' /JOB-'JOB_CODE'
--��ü ������� ���,�����,�����ڵ�,���޸���� �˾Ƴ���
--SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
--FROM EMPLOYEE,JOB
--WHERE JOB_CODE=JOB_CODE; -- ��������(�ָ��ϴ� ��ȣ�ϴ�)� ���̺� �÷����� ��ø� ������Ѵ�

--���1) ���̺���� �ٿ��� ����Ѵ� [ǥ����] ���̺��.�÷���
SELECT EMP_ID,EMP_NAME,EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE,JOB
WHERE EMPLOYEE.JOB_CODE=JOB.JOB_CODE;

--���2) ��Ī�� �ٿ��� ����Ѵ�. [ǥ����]��Ī.�÷���
SELECT EMP_ID,EMP_NAME,E.JOB_CODE,JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE;

-->ANSI ����
--FROM ���� ���� ���̺��� '�ϳ���' ��� �ѵ�
--�� �ڿ� JOIN������ ���� ��ȸ�ϰ��� �ϴ� ���̺� ���, ���� ��Ī��ų �÷��� ���� ���ǵ� ���� �ۼ�
--USING / ON ����

--��ü ������� ���,�����,�μ��ڵ�,�μ������ �˾Ƴ����� �Ѵ�.
--1)������ �� �÷��� �ٸ� ��� EX)EMPLOYEE-'DEPT_CODE' / DEPARTMENT-'DEPT_ID'
--�ٸ� ��� ON ������ ����ؾ��Ѵ�
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE
/*INNER*/JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID); --INNER��������

--��ü������� ���,�����,�����ڵ�,���޸���� �˾Ƴ�����.
--2)������ �� �÷��� ���� ��� EX)EMPLOYEE-'JOB_CODE' / JOB-'JOB_CODE'
--ON�� USING �� �� ��밡��
--ON����
SELECT EMP_ID,EMP_NAME,E.JOB_CODE,JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE);
--USING ���� --- �� ������ �÷����� �������
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE); --�÷����� ���Ƽ� � ���̺� �÷����� ��������� �ʴٵ� �˾Ƽ� ��Ī ������

--[����] �ڿ�����(NATURAL JOIN): ����� ����� �ϳ�
--> ������ Ÿ�԰� �̸��� ���� �÷��� ���� �������� �̿��ϴ� ���
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;
--�ΰ��� ���̺� ��ġ�ϴ� �÷��� �� �Ѱ��� ������ ��� �˾Ƽ� ��Ī�� �ȴ�.

-- ���� �� �������õ� ����
-- ������ �븮�� ������� ������ ��ȸ(���,�����,����,����(���޸�))

-- ����Ŭ ����
SELECT EMP_ID,EMP_NAME,SALARY,JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND JOB_NAME='�븮';

--ANSI����
SELECT EMP_ID,EMP_NAME,SALARY,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME='�븮';
--------------�ǽ� ����------------

-- ����Ŭ ����
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND DEPT_TITLE='�λ������';

--ANSI����
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE='�λ������';

-- ����Ŭ ����
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID
AND NOT DEPT_TITLE='�ѹ���';

--ANSI����
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE!='�ѹ���';

-- ����Ŭ ����
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID
AND BONUS IS NOT NULL;

--ANSI����
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE BONUS IS NOT NULL;

--4.�Ʒ��� �� ���̺��� �����ؼ� �μ��ڵ�,�μ���,�����ڵ�,������ ��ȸ
SELECT* FROM DEPARTMENT;
SELECT*FROM LOCATION;

-->����Ŭ ����
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT,LOCATION
WHERE LOCATION_ID=LOCAL_CODE;
-->ANSI ����
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE);

--�����/�������� : ��ġ���� ���� ����� ��ȸ���� ����

--------------------------------------------------

--��ü ������� �����, �޿�, �μ���
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--DEPT_CODE�� NULL ��� �θ��� ��ȸ���� ����
-- �μ���ġ�� ������ ����� ��ȸ���� ����
--�μ��� �ִµ� �ƹ��� �������� ���� �μ��� ��ȸ���� ���� (D3,D4,D7)
SELECT * FROM EMPLOYEE;

/*
    2.�������� / �ܺ�����(OUTER JOIN)
    ���̺��� JOIN�ÿ� "��ġ���� �ʴ� �൵" ���Խ��Ѽ� ��ȸ����
    ��,�ݵ�� LEFT/RIGHT �� �����ؾ� ��. -> ������ �Ǵ� ���̺��� �����ؾ��Ѵ�.
    ��ġ�ϴ� �� + ������ �Ǵ� ���̺� �������� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ
*/

/*
��ü ������� �����,�޿�,�μ���
1)LEFT OUTER JOIN : �� ���̺� �߿� ���� ����� ���̺��� �������� JOIN
                    ��, �����Ͱ��� ���� �Ƶ� ���� ����� ���̺��� �����ʹ� ������ ��ȸ�ϰ� �ȴ�.
                    (��ġ���� �ʾƵ� ��ȸ)

*/
--ANSI ����
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID); 
--EMPLOYEE ���̺��� ������ �Ǿ��� ������ EMPLOYEE���̺� �����ϴ� �����͸� �� ��ȸ�ؿ´�.

--����Ŭ ����=D
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);
--> ���� �������� ���� ���̺��� �÷����� �ƴ϶� �ݴ� ���̺��� �÷��� (+)�� �ٿ��ش�

--2) RIGHT OUTER JOIN : �� ���̺��� ������ ����� ���̺��� �������� JOIN
--                        ��,�����Ͱ��� ���� �Ƶ� ������ ����� ���̺��� ������ ��ȸ�ϰ� �ȴ�.
--                        (��ġ���� �ʾƵ� ��ȸ)
-- >ANSI ����
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

-->����Ŭ ����
SELECT EMP_NAME,SALARY,DEPT,TITLE
FROM EMPLOYEE,DEPARTMEN;
/*

    4.�� ���� (NON EQUAL JOIN)
    '='��ȣ�� ������� ���� ���ι�
    
*/
--�����,�޿�
SELECT EMP_NAME,SALARY
FROM EMPOYEE;

--SAL GRADE ���̺� ��ȸ
SELECT *
FROM SAL_GRADE;

--�����,�޿�,�޿����(SAL_LEVEL)
-->����Ŭ����
SELECT EMP_NAME,E.SALARY,S.SAL_LEVEL
FROM EMPLOYEE E,SAL_GRADE S
--WHERE E.SALARY >= S.MIN_SAL AND E.SALARY <= S.MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->ANSI
SELECT EMP_NAME,SALARY,S.SAL_LEVEL
FROM EMPLOYEE E
--JOIN SAL_GRADE S ON (SALARY>=MIN_SAL AND SALARY<=MAX_SAL);
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

/*
    5.��ü����(SELF JOIN)
    
    ���� ���̺��� �����ϴ� ���
    ��, �ڱ� �ڽŰ� �����ϰڴ�
    -> ��ü ������ ��� ���̺� �ݵ�� ��Ī�� �ٿ�����Ѵ�. (���� �ٸ� ���̺��ΰ�ó�� �����ϰڴ�)
*/

SELECT * FROM EMPLOYEE E; --����� ���� ������ ������ ���̺�
SELECT * FROM EMPLOYEE M; --����� ���� ������ ������ ���̺�

--����� ���, �����, ����� ���,�����
-->����Ŭ ����
SELECT E.EMP_ID ���,E.EMP_NAME �����,E.MANAGER_ID ������,M.EMP_NAME �����
FROM EMPLOYEE E,EMPLOYEE M
WHERE E.MANAGER_ID=M.EMP_ID(+); --LEFT OUTER JOIN

-->ANSI ����
SELECT E.EMP_ID ���,E.EMP_NAME �����,E.MANAGER_ID ������,M.EMP_NAME �����
FROM EMPLOYEE E
LEFT OUTER JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

/*
    <��������>
    
    3�� �̻��� ���̺��� �����ؼ� ��ȸ�ϰڴ�.
    ���� ������ �߿��ϴ�.
*/
--���,�����,�μ���,���޸�
--�ϴ� �� ���̺��� ���� ��ȸ�غ���
SELECT *FROM EMPLOYEE; --EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
SELECT * FROM DEPARTMENT;   --DEPT_ID,DEPT_TITLE
SELECT * FROM JOB;                 --JOB_CODE,JOB_NAME

--���ĺ���
-->����Ŭ ����
SELECT EMP_ID ���,EMP_NAME �����,DEPT_TITLE �μ���,JOB_NAME ���޸�
FROM EMPLOYEE E , DEPARTMENT D,JOB J
WHERE E.DEPT_CODE=D.DEPT_ID(+)
AND E.JOB_CODE=J.JOB_CODE(+);

-->ANSI����
SELECT EMP_ID ���,EMP_NAME �����,DEPT_TITLE �μ���,JOB_NAME ���޸�
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE);

------------�ǽ� ����--------------


SELECT EMP_ID ,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE E ,LOCATION L,NATIONAL N,DEPARTMENT D
WHERE L.NATIONAL_CODE=N.NATIONAL_CODE(+)
AND D.LOCATION_ID=L.LOCAL_CODE(+)
AND E.DEPT_CODE=D.DEPT_ID(+);


SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID=L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE=N.NATIONAL_CODE);

SELECT EMP_ID ,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME,S.SAL_LEVEL
FROM EMPLOYEE E ,LOCATION L,JOB J,NATIONAL N,DEPARTMENT D,SAL_GRADE S
WHERE L.NATIONAL_CODE=N.NATIONAL_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE=J.JOB_CODE
AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;

--ANSI

SELECT EMP_ID ,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME,S.SAL_LEVEL
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE)
LEFT JOIN LOCATION L ON(D.LOCATION_ID=L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE=N.NATIONAL_CODE)
LEFT JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);
---------------------- JOIN ���� �ǽ����� ----------------------
-- 1. ������ �븮�̸鼭 ASIA ������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE,NATIONAL_NAME,SALARY
FROM EMPLOYEE E,JOB J,DEPARTMENT D,LOCATION L,NATIONAL N
WHERE E.JOB_CODE=J.JOB_CODE
AND   E.DEPT_CODE=D.DEPT_ID
AND   D.LOCATION_ID=L.LOCAL_CODE
AND   L.NATIONAL_CODE=N.NATIONAL_CODE
AND   J.JOB_NAME ='�븮'
AND   L.LOCAL_NAME LIKE 'ASIA%';
-->> ANSI ����
SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE,NATIONAL_NAME,SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID=L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE=N.NATIONAL_CODE)
WHERE J.JOB_NAME='�븮'
AND   L.LOCAL_NAME LIKE 'ASIA%';
-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--   �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME,EMP_NO,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE E,DEPARTMENT D,JOB J
WHERE E.DEPT_CODE=D.DEPT_ID
AND   E.JOB_CODE=J.JOB_CODE
AND   SUBSTR(EMP_NO,1,2) LIKE '7%'
AND   SUBSTR(EMP_NO,8,1) ='2'
AND   EMP_NAME LIKE '��%';
-->> ANSI ����
-- 3. �̸��� '��'�ڰ� ����ִ� �������� 
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_ID,EMP_NAME,JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND EMP_NAME LIKE ('%��%');
-->> ANSI ����
-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME,JOB_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE E,JOB J,DEPARTMENT D
WHERE E.JOB_CODE=J.JOB_CODE
AND   E.DEPT_CODE=D.DEPT_ID
AND  D.DEPT_TITLE LIKE ('�ؿܿ���%');
-->> ANSI ����
-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_NAME,BONUS,(SALARY*12) ����,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND D.LOCATION_ID=L.LOCAL_CODE
AND BONUS IS NOT NULL;
-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_NAME,JOB_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,JOB J,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND   E.JOB_CODE=J.JOB_CODE
AND   D.LOCATION_ID=L.LOCAL_CODE;
-- 7. '�ѱ�' �� '�Ϻ�' �� �ٹ��ϴ� ��������
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,LOCATION L,NATIONAL N
WHERE E.DEPT_CODE=D.DEPT_ID
AND   D.LOCATION_ID=L.LOCAL_CODE
AND   L.NATIONAL_CODE=N.NATIONAL_CODE
AND   N.NATIONAL_NAME IN ('�ѱ�','�Ϻ�');
-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7 �� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
SELECT EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND  E.BONUS IS NULL
AND  E.JOB_CODE IN ('J4','J7');
-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �� ��, ���п� �ش��ϴ� ����
--    �޿������ S1, S2 �� ��� '���'
--    �޿������ S3, S4 �� ��� '�߱�'
--    �޿������ S5, S6 �� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�
SELECT EMP_ID,EMP_NAME,JOB_NAME,SAL_LEVEL
        ,CASE WHEN SAL_LEVEL IN ('S1','S2') THEN '���'
        WHEN SAL_LEVEL IN('S3','S4') THEN '�߱�'
        WHEN SAL_LEVEL IN('S5','S6') THEN '�ʱ�'
        END ����
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE;
-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �� ��, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
SELECT DEPT_TITLE,SUM(SALARY)�޿���
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)>=10000000;
--ANSI
SELECT DEPT_TITLE,SUM(SALARY)�޿���
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;
-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��) �� ��ȸ�Ͻÿ�
--     ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�(�÷����� �μ������� ���� ��������)
SELECT NVL(DEPT_TITLE,'�μ�������') �μ���,FLOOR(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID(+)
GROUP BY DEPT_TITLE;
















