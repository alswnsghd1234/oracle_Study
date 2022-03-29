/*

    OBJECT
    �����ͺ��̽��� �̷�� ������ ��������
    
    OBJECT�� ����
    -TABLE,USER,VIEW,SEQUENCE,INDEX,PACKAGE,TRIGGER,FUNCTION,PROCEDURE
    
    <VIEW>
    SELECT�� �����صѼ��ִ� ��ü
    (���� ����� SELECT ���� VIEW�� ��Ƴ��� ����ϸ� �Ź� �� SELECT���� �ۼ��� �ʿ䰡 ��������.
    -> ��ȸ�� �ӽ����̺�(������ ���� ����ִ°��� �ƴϴ�)
    
    1.VIEW ���� ���
    [ǥ����]
    CREATE VIEW ��� AS ��������;
    
    CREATE OR REPLACE VIEW ���
    AS ��������;
    ->�� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ���Ӱ� �����ϰ� �ߺ��� �̸��� �ִٸ� �ش� �信 �����(����)�Ѵ�.
    -OR REPLACE �ɼ��� ��������
*/

--'�ѱ�'���� �ٹ��ϴ� ������� ���,�̸�,�μ���,�޿�,�ٹ�������,���޸��� ��ȸ�Ͻÿ�

SELECT EMP_NO,EMP_NAME,E.SALARY,D.DEPT_TITLE,N.NATIONAL_NAME,J.JOB_NAME
FROM EMPLOYEE E,NATIONAL N,DEPARTMENT D,JOB J,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND J.JOB_CODE =E.JOB_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND N.NATIONAL_CODE = L.NATIONAL_CODE
AND NATIONAL_NAME ='�ѱ�';

CREATE VIEW VM_EMPLOYEE
AS SELECT EMP_NO,EMP_NAME,E.SALARY,D.DEPT_TITLE,N.NATIONAL_NAME,J.JOB_NAME
FROM EMPLOYEE E,NATIONAL N,DEPARTMENT D,JOB J,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND J.JOB_CODE =E.JOB_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND N.NATIONAL_CODE = L.NATIONAL_CODE;

DROP VIEW VM_EMPLOYEE;
--���� �ڵ带 VM+EMPLOYEE�� ��ȸ�غ���

SELECT * FROM VM_EMPLOYEE WHERE NATIONAL_NAME='�ѱ�';

--VIEW "insufficient privileges" ���� ���� ����

--VIEW ���� ���� �ο��ϱ�
GRANT CREATE VIEW TO KH;

SELECT * FROM VM_EMPLOYEE;

--���þƿ� �ٹ��ϴ� ������� ���,�̸�,���޸�,�޿�,���ʽ�
SELECT *
FROM VM_EMPLOYEE;

CREATE VIEW VM_EMPLOYEE
AS SELECT EMP_NO,EMP_NAME,E.SALARY,D.DEPT_TITLE,N.NATIONAL_NAME,J.JOB_NAME,E.BONUS
FROM EMPLOYEE E,NATIONAL N,DEPARTMENT D,JOB J,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND J.JOB_CODE =E.JOB_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND N.NATIONAL_CODE = L.NATIONAL_CODE;

SELECT * FROM USER_VIEWS;

/*
    �� �÷��� ��Ī �ο��ϱ�
    �������� �κп� SELECT ���� �Լ��� ���������� ����Ǿ� �ִ� ��� �ݵ�� ��Ī ����
    
*/

-- ����� ���,�̸�,���޸�,����,�ٹ������ ��ȸ�� ���ִ� SELECT���� VIEW�� �����غ���.

CREATE VIEW VM_EMP_JOB
AS SELECT EMP_ID
        ,EMP_NAME
        ,JOB_NAME
        ,DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') ����
        ,EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE); --�������� �κп� SELECT���� �Լ��� ���������� ����Ǿ� �մ� ��� �ݵ�� ��Ī ����
        
SELECT * FROM VM_EMP_JOB;

--�ٸ� ������� ��Ī �����ֱ� (����-��� �÷��� ���ؼ� ��Ī�� ����ؾ��Ѵ�.)
CREATE OR REPLACE VIEW VM_EMP_JOB(���,�����,���޸�,����,�ٹ����)
AS SELECT EMP_ID
        ,EMP_NAME
        ,JOB_NAME
        ,DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') ����
        ,EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
        
SELECT ���,�����,����
FROM VM_EMP_JOB;

SELECT *
FROM VM_EMP_JOB
WHERE �ٹ����>=20;

DROP VIEW VM_EMP_JOB;

/*
    ������ �信 DML ������ ����غ���
    INSERT,DELETE,UPDATE
    ���ǻ���) VIEW�� ���ؼ� �����ϰ� �ȴٸ� ���� �����Ͱ� ����ִ� �������̺� ��������� ����ȴ�.
    
*/

CREATE VIEW VW_JOB
AS SELECT * FROM JOB;

SELECT * FROM JOB;
SELECT * FROM VW_JOB;

--�信 INSERT
INSERT INTO VW_JOB
VALUES('J8','����');

UPDATE VW_JOB
SET JOB_NAME='�˹�'
WHERE JOB_CODE = 'J8'; 

DELETE FROM VW_JOB 
WHERE JOB_CODE='J8';

/*
    VIEW�� DML�� ������ ��� : ���������� �̿��ؼ� ������ ���̺��� ������ ó������ �����ϰ��� �� ���.
    
    * �Ұ����� ��� : �ѹ��̶� ó���� �� ������ DML�� �Ұ����ϴ�.
    1)�信 ���ǵ��� ���� �÷��� �����Ϸ��� ���
    2)�信 ���ǵǾ� ���� ���� �÷��߿� ���̽����̺� �� NOT NULL ���������� ������ ���
    3)�������� �Ǵ� �Լ������� �ۼ��Ǿ� ���ǵ� ���
    4)�׷��Լ��� GROUP BY���� ���Ե� ���
    5)DISTINCT ������ ���Ե� ���
    6)JOIN �� �̿��ؼ� �������̺��� ��Ī��Ų ���
    
*/

--2)�信 ���ǵǾ� ���� ���� �÷��߿� ���̽����̺� �� NOT NULL ���������� ������ ���
CREATE  OR REPLACE  VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;

--INSERT
INSERT INTO VW_JOB VALUES('J9'); --(NULL,'����') ó�� ������ �ߴµ� NOT NULL ���������� �ɷ��ִ�.



CREATE VIEW VM_�л��Ϲ�����
AS SELECT STUDENT_NO,STUDENT_NAME,STUDENT_ADDRESS
FROM TB_STUDENT;

SELECT *FROM VM_�л��Ϲ�����;

DROP VIEW VM_�������;

CREATE VIEW VM_�������
AS SELECT STUDENT_NAME ,DEPARTMENT_NAME,PROFESSOR_NAME
FROM TB_PROFESSOR P,TB_STUDENT S,TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO(+)
AND S.COACH_PROFESSOR_NO=P.PROFESSOR_NO(+)
ORDER BY DEPARTMENT_NAME;

SELECT * FROM VM_�������;


CREATE VIEW VW_�а����л���(�ù� ,�־ȵ�)
AS SELECT DEPARTMENT_NAME,COUNT(*)
FROM TB_DEPARTMENT
LEFT JOIN TB_STUDENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

SELECT * FROM VW_�а����л���;


UPDATE VM_�л��Ϲ�����
SET STUDENT_NAME='�����̸�'
WHERE STUDENT_NO='A213046';

CREATE OR REPLACE VIEW VM_�л��Ϲ�����
AS SELECT *FROM VM_�л��Ϲ�����;

--WITH READ ONLY �������� �ۼ��ϱ�(��ȸ�� �����ϰ� �߰�,����,����)

--VIEW �ɼ�
--FORCE/NOFORCE - NOFORCE�� �⺻�ɼ� (�������̺��̳� �÷��� ������ �� ���� �Ұ�)
-- FORCE : ���� ���̺��̳� �÷��� ��� �� ���� ����
/*
    [ǥ����]
    CREATE FORCE VIEW ���
*/
CREATE OR REPLACE FORCE VIEW VW_TEST
AS SELECT * FROM TB_TSET;

SELECT * FROM VW_TEST;
-- ��� �����Ǿ����� �������̺��� ���⶧���� ��ȸ�Ұ�

CREATE TABLE TB_TEST(
    TB_ID NUMBER
    ,TB_NAME VARCHAR2(20)
    );
    
    SELECT * FROM TB_TEST;