/*
    *DDL(DATA DEFINITION LANGUAGE)
    ������ ���� ���
    
    ��ü���� ���Ӱ� ����(CREATE)�ϰ� ����(ALTER)�ϰ� ����(DROP)�ϴ� ����
    
    1.ALTER
    ��ü ������ �����ϴ� ����
    <���̺� ���� >
    [ǥ����]
    ALTER TABLE ���̺��� �����ҳ���;
    
    -������ ����
    1)�÷��߰�/����/����
    2)�������� �߰�/���� -> ������ �Ұ�(�����ϰ��� �Ѵٸ� ���� �� ������ �߰�)
    3)���̺��� / �÷��� /�������Ǹ� ����
*/

--1)�÷� �߰�/����/����
--1-1) �÷��߰� (ADD):ADD�߰����÷��� �ڷ��� DEFAULT �⺻��
--                    ��,DEFAULT�� ��������

SELECT * FROM DEPT_COPY;

--CNAME�÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--���ο� �÷��� ��������� �⺻���� NULL�� ä������.
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�⺻��';
--���ο� �÷��� ��������� DEFAULT������ ������ "�⺻��" ���� ä������

--DNAME�̶�� �÷��� �߰��ϰ� DATEŸ�� �⺻���� SYSDATE�� �Է��غ�����
ALTER TABLE DEPT_COPY ADD DNAME DATE DEFAULT SYSDATE;

--1_2)�÷� ���� (MODIFY)
--�÷��� �ڷ��� ���� : MODIFY �������÷��� �ٲٰ��� �ϴ� �ڷ���
--DEFAULT �� ���� : MODIFY �������÷��� DEFAULT �ٲٰ��� �ϴ� �⺻��.

--DEPT_COPY ���̺��� DEPT_ID �÷��� �ڷ����� CHAR(3)���� �����غ���
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

SELECT * FROM DEPT_COPY;

--���� �����ϰ��� �ϴ� �÷��� �̹� ����ִ� ���� ������ �ٸ� Ÿ������ �����غ��� (���� X)
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; --column to be modified must be empty to change datatype ����

--���� �����ϰ��� �ϴ� �÷��� ��� ������ ���� ũ��� ������ �� ����.
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1); --cannot decrease column length because some value is too big ����

--���� �����ϰ��� �ϴ� �÷��� ��� ������ ũ�� �����ϴ°��� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(10);

--����->NUMBER�� X / ������ ��� X / ������ Ȯ�� O

--�ѹ��� �����ð��� �÷� �����ϱ�
--DEPT_TITLE�÷��� ������Ÿ���� VARCHAR2(40)����
--LOCATION_ID �÷��� ������Ÿ���� VARCHAR2(2)��
--LNAME �÷��� �⺻���� '�̱�'����
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';

SELECT * FROM DEPT_COPY;
INSERT INTO DEPT_COPY(DEPT_ID,DEPT_TITLE,LOCATION_ID) VALUES('D0','������','L0');

--1_3)�÷� ���� (DROP COLUMN) : ALTER TABLE ���̺��� DROP COLUMN �����ϰ��� �ϴ� �÷���
CREATE TABLE DEPT_COPY2
AS SELECT *
    FROM DEPT_COPY;
    
SELECT*FROM DEPT_COPY2;

--DEPT_ID �÷� ����� 
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

ROLLBACK;--DDL������ �ѹ� �Ұ�

--DEPT_COPY2�� ����÷� ��������
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN DNAME;
--����  "cannot drop all columns in a table" 
--���̺��� �ּ� �Ѱ��� �÷��� �����ؾ��Ѵ�.



