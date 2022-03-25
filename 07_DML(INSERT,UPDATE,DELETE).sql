/*

    DML (DATA MANIPULATION LANGUAGE)
    ������ ���۾��
    ���̺� ���ο� �����͸� ����(INSERT)�ϰų�
    ������ �����͸� ����(UPDATE)�ϰų�
    ����(DELETE) �ϴ� ����.
    

*/

/*

    1.INSERT : ���̺� ���ο� "��"�� �߰��ϴ� ����
    [ǥ����]
    INSERT INTO �迭
    
    1)INSERT INTO ���̺�� VALUES(��1,��2,��3..)
    ->�ش� ���̺� "���"�÷��� ���� �߰��ϰ��� �ϴ� ���� ���� ���� �����ؼ�
    �� ���� INSERT�ϰ��� �� �� ����ϴ� ǥ����
    ���ǻ��� : �÷��� ����,�ڷ��� ������ ���缭 VALUES��ȣ �ȿ� ���� �����ؾ��Ѵ�.
    �����ϰ� ���� ����������� : NOT ENOUGH VALUE ����
    ���� �� ���� ������ ��� : TOO MANY VALUES ����
    
    2)INSERT INTO ���̺��(�÷���1,�÷���2,�÷���3) VALAUES (��1,��2,��3);
    ->�ش� ���̺� Ư�� �÷��� �����ؼ� �߰��� ���� �����ϰ��� �Ҷ� ���
    - ���õ��� ���� �÷��� �⺻���� NULL�� ����
    - ��, DEFAULT ������ �Ǿ�������� DEFAULT �������� ����.(�⺻�� ����)
    
    ���� : NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� ���� �־���Ѵ�.
    -��, DEFAULT ������ �Ǿ��ִٸ� NOT NULL�̶���ص� ���� ���ص� �ȴ�. (DEFAULT���� �⺻���� �Ǳ⶧����)
    
    
*/

--EMPLOYEE ���̺� ��� ���� �߰��غ���

INSERT INTO EMPLOYEE VALUES(000,'������','902302-232321','DKDMDD@DSFD.COM',
                            '01034341231','D1','J7','S6',1999999,0.9,200,SYSDATE
                            ,NULL,DEFAULT);
                            
SELECT * FROM EMPLOYEE;                            

/*
    3)INSERT INTO ���̺�� (��������)
    -> VALUES()�� ���� ���� �����ϴ°��� �ƴ϶�
    ���������� ��ȸ�� ������� ��°�� INSERT�ϴ� ����
    ��, �������� �ѹ��� INSERT �� ���ִ�.
    
*/

--���ο� ���̺� �����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR(20)
    );
    
SELECT *
FROM EMP_01;

-- ��ü ������� ���, �̸�, �μ����� ��ȸ�� ����� EMP_01 ���̺� ��°�� �߰�
--1) ��ȸ
SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);

--2)��ȸ�� ��� INSERT �غ���
INSERT INTO EMP_01 (
        SELECT EMP_ID,EMP_NAME,DEPT_TITLE
        FROM EMPLOYEE, DEPARTMENT
        WHERE DEPT_CODE=DEPT_ID(+)
        );
        
SELECT * FROM EMP_01;

--EMP_011 ���̺��� ����� �÷��� �����,���޸�
CREATE TABLE EMP_011(
    EMP_ID NUMBER,
    JOB_CODE VARCHAR2(30),
    BONUS VARCHAR(20)
    );

INSERT INTO EMP_011(
        SELECT EMP_ID,JOB_CODE,BONUS
        FROM EMPLOYEE
        );

DROP TABLE EMP_011;

/*
    INSERT ALL �迭
    �ΰ� �̻��� ���̺� ���� INSERT�Ҷ� ���
    ���� : �� �� ���Ǵ� ���������� �����ؾ��Ѵ�.
    1)INSERT ALL
    INTO ���̺��1 VALUES(�÷���,�÷���..)
    INTO ���̺��2 VALUES(�÷���,�÷���..)
    ��������;
*/

--���ο� ���̺� �����
--1)�޿��� 300���� �̻��� ������� ���,�����,���޸� ������ ���̺�
DROP TABLE EMP_JOB;
CREATE TABLE EMP_JOB 
AS SELECT EMP_ID,EMP_NAME,JOB_NAME
    FROM EMPLOYEE E, JOB J
    WHERE E.JOB_CODE=J.JOB_CODE
    AND 1=0;

SELECT * FROM EMP_JOB;

--2)�޿��� 300���� �̻��� ������� ���,�����,�μ��� ������ ���̺�

CREATE TABLE EMP_DEPT 
AS SELECT EMP_ID,EMP_NAME,DEPT_TITLE
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE=D.DEPT_ID
    AND 1=0;

SELECT * FROM EMP_DEPT;


INSERT ALL
    INTO EMP_JOB VALUES(EMP_ID,EMP_NAME,JOB_NAME)
    INTO EMP_DEPT VALUES(EMP_ID,EMP_NAME,DEPT_TITLE)
    SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
    FROM EMPLOYEE E ,JOB J,DEPARTMENT
    WHERE E.JOB_CODE=J.JOB_CODE
    AND DEPT_CODE=DEPT_ID
    AND SALARY >= 3000000;
    
SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

--��� ���̵� �̸� �ֹι�ȣ ���޸��� ���� �� �ִ� ���̺�
CREATE TABLE EMP_JOB_NAME
AS SELECT EMP_ID,EMP_NAME,JOB_NAME
    FROM EMPLOYEE E, JOB J
    WHERE E.JOB_CODE=J.JOB_CODE
    AND 1=0;

SELECT * FROM EMP_JOB;

--��� ���̵� �ֹι�ȣ �μ��� �޿��� ���� �� �մ� ���̺�
CREATE TABLE EMP_DEPT_TITLE
AS SELECT EMP_ID,EMP_NAME,DEPT_TITLE
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE=D.DEPT_ID
    AND 1=0;
-- ����� �� �� ������ ������� ������ �־�ÿ�.
INSERT ALL
    INTO EMP_JOB_NAME VALUES(EMP_ID,EMP_NAME,JOB_NAME)
    INTO EMP_DEPT_TITLE VALUES(EMP_ID,EMP_NAME,DEPT_TITLE)
    SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
    FROM EMPLOYEE E ,JOB J,DEPARTMENT
    WHERE E.JOB_CODE=J.JOB_CODE
    AND DEPT_CODE=DEPT_ID
    AND SUBSTR(EMP_NO,8,1)='2';
    
/*
    2)INSERT ALL
    WHEN ����1 THEN
        INTO~
    WHEN ����2 TEHN 
        INTO~
    ��������;
    -���ǿ� �´� ���鸸 �ְڴ�.

*/

--2010�⵵ �������� ������ �Ի��� ����� ���,�����,�Ի���,�޿��� ��� ���̺�
CREATE TABLE EMP_OLD
AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 0=1;
SELECT * FROM EMP_OLD;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 0=1;
SELECT * FROM EMP_NEW;

--1)���������� �Է��� �κ�
--2010�� ����,����
SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
FROM EMPLOYEE
WHERE HIRE_DATE<'/2010/01/01'; -- 2010�� ���� �Ի���
--WHERE HIRE_DATE>/'2010/01/01'; -- 2010�� ���� �Ի���

INSERT ALL
WHEN HIRE_DATE<'2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
WHEN HIRE_DATE>='2010/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
    SELECT *
    FROM EMPLOYEE; -- ������������ ��ü��ȸ�ص� �Ǵ���
    
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

CREATE TABLE TEST01(
    NO NUMBER;
    STR VARCHAR2(30),
    STR2 VARCHAR2(40)
    
/*
    2.UPDATE
    ���̺� ��ϵ� ������ �����͸� �����ϴ� ����
    UPDATE ���̺��
    SET �÷���=���氪,�÷���=���氪,.... --�������� �÷����� ���ú��� ���� (,�� �����Ѵ�)
    WHERE ����; --WHERE ���� �������������� �����ϸ� ��� �࿡ �����Ͱ� ����Ǵ� �����ؾ��Ѵ�.
    
*/

--���纻 ���̺� ���� ����
CREATE TABLE DEPT_COPY
AS SELECT *
    FROM DEPARTMENT;
    
SELECT * FROM DEPT_COPY;
--DEPT_COPY ���̺��� D9�μ��� �μ����� ������ȹƴ���� �����ϱ�
UPDATE DEPT_COPY
SET DEPT_TITLE='������ȹ��'
WHERE DEPT_ID='D9';
--WHERE���� �����ϸ� ��� ���� �����Ͱ� ����ȴ�
ROLLBACK; --���� ���׿� ���� �ǵ����� ��ɾ�(DML����(INSERT,DELETE,UPDATE)) ������ Ŀ�� ��ġ�� ����

--���纻 ���̺� �����
--���̺�� EMP_SALARY / �÷� : EMPLOYEE���̺�κ��� EMP_ID,EMP_NAME,DEPT_CODE,SALARY,BONUS �����ͱ��� ����
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY,BONUS FROM EMPLOYEE;

--EMP_SALARY���̺��� ���ö ����� �޿��� 1000�������� ����
UPDATE EMP_SALARY
SET SALARY = '10000000'
WHERE EMP_NAME='���ö';

--EM_SALARY���̺��� ������ ����� �޿��� 700���� ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
SET SALARY = '70000000' , BONUS ='0.2'
WHERE EMP_NAME='������';

SELECT * FROM EMP_SALARY;

--��ü����� �޿��� ������ �޿��� �λ��� �ݾ����� �����Ͻÿ�
UPDATE EMP_SALARY
SET SALARY=(SALARY*1.2);

/*

    UPDATE�� �������� ���
    ���������� ������ ��������� ������ ���� �����ϰڴ�.
    
    -CREATE�ÿ� �������� ��� : ���������� ������ ����� ���̺� �ְڴ�.
    -INSERT�ÿ� �������� ��� : ���������� ������ ����� �ش� ���̺� �����ϰڴ�.
    
*/

--EMP_SALARY ���̺�� ���� ����� �μ��ڵ带 ������ ����� �μ��ڵ�� ����
--���� D1 ������ D9
--1)������ ����� �μ��ڵ带 ��ȸ�ϱ�
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='������';

--2)���� ����� �μ��ڵ带 ������ ����� �μ��ڵ�� ���� -D9
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='������')
WHERE EMP_NAME='����';

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='����';

--���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ������� ����
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY,BONUS
FROM EMP_SALARY
WHERE EMP_NAME='�����')
WHERE EMP_NAME='����';

--EMPLOYEE���� ������ ����� �����ȣ 200���� ����
UPDATE EMPLOYEE
SET EMP_ID=200
WHERE EMP_NAME='������'; --unique constraint (KH.EMPLOYEE_PK) violated
--PRIMARY KEY �������� ���� ����

SELECT * FROM EMPLOYEE

--EMP_ID �� 200�� ����� �̸��� NULL�� ����
UPDATE EMPLOYEE
SET EMP_NAME=NULL
WHERE EMP_ID=200; --NOT NULL �������� ���� ����

--UPDATE �������� �����Ҷ� ���������� ������ �� ����

/*
    4.DELETE
    ���̺� ��ϵ� �����͸� "��"������ �����ϴ� ����
    [ǥ����]
    DELETE FROM ���̺��
    WHERE ����; --WHERE���� ������ ���������� �����ÿ� ������� �����ȴ�.
    
*/
--EMPLOYEE ���̺��� ��� �� ����
DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

--0�� �� ��ȸ
--�����Ͱ� �� �������ͻ� ���̺��� �������� ����
ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_NAME IN ('������');
COMMIT;
--DEPARTMENT ���̺��� DEPT_ID = D1 �μ� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID='D1';

SELECT * FROM DEPARTMENT;
ROLLBACK;

/*
    TRUNCATE
    ���̺��� ��ü ���� ��� ���� �� �� ����ϴ� ����
    DELETE �������� �ӵ��� ������
    ������ ���� ���úҰ�
    ROLLBACK�� �ȵǱ⶧���� �����ؾ��Ѵ�.
    [ǥ����]
    TRUNCATE TABLE ���̺��;
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;




