/*
            TEST��
*/

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME,DEPT_CODE,CONCAT(SUBSTR(EMP_NO,1,2),'��')||CONCAT(SUBSTR(EMP_NO,3,2),'��')||CONCAT(SUBSTR(EMP_NO,5,2),'��') ��ģ��
        ,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) "����"
FROM EMPLOYEE;

--ANSI ����
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE);

--����Ŭ ����
SELECT DEPT_ID,DEPT_TITLE,SALARY
FROM EMPLOYEE E,DEPARTMENT D
WHERE DEPT_CODE(+)=DEPT_ID;
-->���� �������� ���� ���̺������� �÷����� �ƴ϶� �ݴ� ���̺��� �÷��翡 (+)�� �ٿ��ش�.

-->ANSI ����
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE E
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE E
FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

--ANSI
SELECT EMP_NAME,SALARY,S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

SELECT E.EMP_ID ���,E.EMP_NAME �����,E.MANAGER_ID ������,M.EMP_NAME �����
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.EMP_ID(+)=M.MANAGER_ID;

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

-- �� ���ĺ���
SELECT E.EMP_ID ���,E.EMP_NAME �����,E.MANAGER_ID ������,M.EMP_NAME �����
FROM EMPLOYEE E,DEPARTMENT D, JOB J
WHERE E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE=J.JOB_CODE;