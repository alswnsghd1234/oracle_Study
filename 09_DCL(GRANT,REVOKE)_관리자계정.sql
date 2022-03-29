/*
    DCL (DATA CONTROL LANGUAGE)
    ������ ���� ���
    �������� �ý��� ���� �Ǵ� ��ü ���� ������ �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ���
    
    -���� �ο� (GRANT)
    �ý��� ���� : Ư�� DB�� �����ϴ� ����, ��ü���� ������ �� �մ� ����
    ��ü ���� ���� : Ư�� ��ü�鿡 �����ؼ� ������ �� �ִ� ����
    
    -�ý��� ����
    [ǥ����]
    GRANT ����1,����2,...TO ������
    
    -�ý��� ������ ����
    CREATE SESSION : ������ ���� �� �� �ִ� ����
    CREATE TABLE : ���̺��� ������ �� �ִ� ����
    CREATE VIEW : �並 ������ �� �ִ� ����
    CREATE SEQUENCE : �������� ������ �� �ִ� ����
    CREATE USER : ������ ������ �� �ִ� ����

*/

--1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

--2. SMAPLE ������ �����ϱ� ���� CREATE SESSION ���� �ο��ϱ�
GRANT CREATE SESSION TO SAMPLE;

--3. SMAPLE ������ ���̺��� �����ϱ� ���� CREATE TABLE ���� �ο� �ϱ�
GRANT CREATE TABLE TO SAMPLE;

--3_2. SAMPLE ������ ���̺� �����̽��� �Ҵ����ֱ� (SYSDBA)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--QUOTA : �� -> �Ҵ��ϴ� �������ִ�
-- 2M : 2 MEGABTYE
-- ���̺����̽� ���� ������ ���� �������� QUOTA UNLIMITED ON ������

--4. VIEW ������
GRANT CREATE VIEW TO SAMPLE;

/*
    ��ü����
    Ư�� ��ü���� ������ �� �ִ� ����
    ���� : SELECT,INSERT,UPDATE,DELETE = DML
    
    [ǥ����]
    GRANT ���� ON Ư����ü TO ������;
    
    �������� | Ư����ü
    -----------------
    SELECT  | TABLE,VIEW,SEQUENCE
    INSERT  | TABLE,VIEW
    UPDATE  | TABLE,VIEW
    DELETE  | TABLE,VIEW


*/

--5. SAMPLE ������ KH.EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ���� �ο��ޱ�
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

--6. SAMPLE ������ KH.DEPARTMENT ���̺� ���� ������ �� �ִ� ������ �ο��ϱ�.
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

--�ּ����� ���Ѹ� �ο��ް� �ʹٸ� CONNECT, RESOURCE�� �ο��ϸ� �ȴ�.

/*
    Ư�� ������ ��Ƴ��� 
    
    CONNECT : CREATE SESSION(�����ͺ��̽� ���� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENSE
*/

/*
    ���� ȸ��
*/
--7.
REVOKE CREATE TABLE FROM SAMPLE;

----�ǽ� ---
/*
    MYUSER ������� ��й�ȣ�� ���� ���� �����ϰ�
    CONNECT,RESOURCE ������ �ο��ѵ� ���̺� �����غ��� ����� �ѹ� �غ��� �䵵 �����غ���
   
*/