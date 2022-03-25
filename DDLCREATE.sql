/*

    DDL (DATA DEFINITION LANGUAGE) :������ ���� ���
    
    ����Ŭ���� �����ϴ� ��ü(OBJECT)��
    ���Ӱ� �����(CREATE),������ �����ϰ�(ALTER),����(DROP)�ϴ� ��ɹ�
    ��, ���� ��ü�� �����ϴ� ���� DB������, �����ڰ� ����Ѵ�.
    
    ����Ŭ������ ��ü(DB�� �̷�� ��������)
    ���̺�(TABLE),�����(USER),�Լ�(FUNCTION),��(VIEW)..���
    
    <CREATE TABLE>
    
    ���̺� : ��(ROW) ��(COLLUM)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü���� �� �ϳ���
    ��� �����ʹ� ���̺��� ���ؼ� �����(�����͸� �����ϰ��� �Ϸ��� ������ ���̺��� ������ �Ѵ�.
    
    [ǥ����]
    CREATE TABLE ���̺��(
    �÷��� �ڷ���,
    �÷��� �ڷ���,
    �÷��� �ڷ���,
    ...
    )
    
    <�ڷ���>
    - ���� (CHAR(ũ��)/VARCHAR2(ũ��): ũ��� BTYEũ��,(����,������,Ư������)=> 1���ڴ� 1BTYE, �ѱ� -> 1���ڴ� 3BTYE
    CHAR(����Ʈ��):�ִ� 2000BTYE���� ��������
        ��������(�ƹ��� ���� ���� ���͵� �������� ä���� ó�� �Ҵ��� ũ�⸦ �����ϰڴ�.)
        �ַ� ���� ���� ���ڼ��� ������ ���� ��� ���
        EX)���� : ��/��
            �ֹι�ȣ:6�ڸ�-7�ڸ� -> 14���� ->14 BTYE
    VARCHAR2(����Ʈ��): �ִ� 4000BTYE���� ��������
                �������� ( ���� ���� ���� ��� �� ��� ���� ���� ũ�Ⱑ �پ���)
                VAR�� ���� 2�� 2�踦 �ǹ�
                �ַ� ���� ���� ���ڼ��� �������� ���� ��� ���
                EX)�̸�,���̵�,��й�ȣ...
    ����(NUMBER) : ����/�Ǽ� ������� NUMBER�̴�.
    
    ����(DATE) : ��/��/��/��/��/�� �������� �ð� ����

*/
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
); --�÷��� ��ҹ��� ������ ���� �ʱ� ������ �ڹٿ��� �ϴ� ��Ÿ�� ǥ����� �ǹ̰� ���⶧���� _ �����¾���ٷ� �����Ѵ�.
SELECT *
FROM MEMBER;

--Ȯ�ι��2 : ������ ��ųʸ�(DATE DICTIONARY)
--������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�

SELECT *
FROM USER_TABLES;
--USER_TABLES : ���� �� ����� ������ ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� ������ ��ųʸ���.

--���� : �÷��� Ȯ�ι�
SELECT *
FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : ���� �� ����� ������ ������ �ִ� ���̺���� ��� �÷��� ������ ��ȸ�� �� �ִ� ������ ��ųʸ�

/*

    �÷��� �ּ� �ޱ� (�÷��� ���� ����)
    
    [ǥ����]
    COMMENT ON COLUMN (���̺��,�÷��� IS '�ּ�����';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� �̸�';
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '�������';

SELECT *
FROM MEMBER;

--INSERT (������ �߰� ����) -DML
-- �� ������ �߰�, �߰��� ���� ���(���� ���� ���Ѿ��Ѵ�)
-- INSERT INTO ���̺�� VALUES (ù��° �÷���,�ι�° �÷���,����°...)

INSERT INTO MEMBER VALUES('user01','pass01','�質��','1988-10-10');
INSERT INTO MEMBER VALUES('user01','pass01','�質��',SYSDATE);
INSERT INTO MEMBER VALUES('user01','pass01','�質��','1988-10-10');

SELECT *
FROM MEMBER;

--���� NULL���̳� �ߺ��� ID���� ��ȿ���� ���� ���̴�
--��ȿ�� �����Ͱ��� �����ϱ� ���ؼ� ���������� �ɾ�����Ѵ�.
--������ ���Ἲ ������ �����ؾ��Ѵ�.

/*
    <�������� CONSTRAINTS>
    -���ϴ� �����Ͱ��� �����ϱ� ���� Ư�� �÷����� �����ϴ� ����(������ ���Ἲ ������ ��������)
    -���������� �ο��� �÷��� ���� �����Ϳ� ������ �ִ��� ������ �ڵ����� �˻��� ����
    -���� : NOT NULL,UNIQUE,CHECK,PRIMARY KEY,FOREIGN KEY
    -�÷��� ���� ������ �ο��ϴ� ���:�÷��������/���̺������

*/

/*

    1. NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� ���
    -NULL���� ���� ���ͼ��� �ȵǴ� �÷��� �ο��ϴ� ��������
    ������ ����/���� �� NULL���� ������� �ʰ� �����Ѵ�.
    - �÷�����������θ� �ۼ�����
*/

--NOT NULL ���������� ������ ���̺� �����
--�÷�������� : �÷��� �ڷ��� �������� -> ���������� �ο��ϰ��� �ϴ� �÷��ڿ� �ٷ� ���
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_IT VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    );
    
SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1,'USER01','PASSWORD01','�⸮����','��','010-2000-2000','GIDIGL@NAVER.COM');

SELECT *
FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(2,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO MEM_NOTNULL VALUES(2,'USER02','PASSWORD02','����',NULL,NULL,NULL);
INSERT INTO MEM_NOTNULL VALUES(2,'USER02','PASSWORD02','����',NULL,NULL,NULL);

/*
    2.UNIQUE ��������
    �÷��� �ߺ����� �����ϴ� ��������
    ���� / ���� �� ������ �ش� �÷��� �߿� �ߺ����� ���� ���
    �߰� �Ǵ� ������ ���� �ʰ� ����
    
    �÷��������,���̺������ �� �����ϴ�.
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --�Ѱ��� �÷��� �������� ���������� �ɼ��ִ�.
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    );
    
SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1,'USER02','PASSWORD02','����',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE VALUES(2,'USER01','PASSWORD02','����',NULL,NULL,NULL);

/*
    �������� �ο��� �������Ǹ� �����ϴ� ǥ����
    -�÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� ��������1,��������2
        �÷��� �ڷ��� CONSTRAINT �������Ǹ� ��������,
        �÷��� �ڷ���,
        ...
        )
        
        - ���̺������
        CREATE TABLE ���̺��(
            �÷��� �ڷ���,
            �÷��� �ڷ���,
            ...,
            �÷��� �ڷ���,
            CONSTRAINT �������Ǹ� ��������(�÷���)
            );
*/

CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NM NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) --���̺������
    
    );
    
    SELECT * FROM MEM_CON_NM;
    
    INSERT INTO MEM_CON_NM VALUES(10,'TEST01','TEST01','���׽�Ʈ',NULL,NULL,NULL);
    INSERT INTO MEM_CON_NM VALUES(12,'TEST01','TEST01','���׽�Ʈ',NULL,NULL,NULL);
    INSERT INTO MEM_CON_NM VALUES(12,'TEST01','TEST01','���׽�Ʈ',NULL,NULL,NULL);
    
    SELECT *
    FROM MEM_CON_NM;
    
    /*
    
    3.CHECK ��������
    �÷��� ��ϵ� �� �ִ� ���� ���� ������ ������ �� �ִ�.
    EX) ���� '��' OR '��'�� ���ü� �ְ� �ϰ�ʹ�.
    [ǥ����]
    CHECK (���ǽ�)
    
    */
    DROP TABLE MEM_CHECK;
 CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL --DEFAUL�� ���� �����ϰ� ���������� �ۼ��ؾ��Ѵ�
    );

    SELECT *
    FROM MEM_CHECK;
    
    INSERT INTO MEM_CHECK VALUES(1,'USER11','PASSWORD','�迭��','��','010-333-0442','DKFDSIFS@NAV.COM',DEFAULT);
    INSERT INTO MEM_CHECK VALUES(1,'USER11','PASSWORD','�迭��','��','010-333-0442','DKFDSIFS@NAV.COM',DEFAULT);
    INSERT INTO MEM_CHECK VALUES(1,'USER11','PASSWORD','�迭��','��','010-333-0442','DKFDSIFS@NAV.COM',DEFAULT);
    
    INSERT INTO MEM_CHECK (MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GENDER)VALUES(2,'USER12','PASSWORD2','�̻��','��');
    
    SELECT *
    FROM MEM_CHECK;
    --�÷� ������ �������ָ� ������ �ȵ� �÷��� ���ؼ� �⺻ NULL���� ���� DEFAULT ������ �Ǿ��ִٸ� DEFAULT ���� ����.
    
    
    /*
    4. PRIMARY KEY(�⺻Ű) ��������
        ���̺��� �� ����� ������ �����ϰ� �ĺ��� �� �ִ� �÷��� �ο��ϴ� ���� ����
        ->�� ����� ������ �� �ִ� �ĺ����� ����
      EX)���,�μ����̵�,����,ȸ����ȣ,�й�...
      -> �ĺ����� ���� : �ߺ� X ,NULL�� X (NOT NULL + UNIQUE)
      ���� : �����̺� �� �Ѱ��� �÷����� ���� ����.
    */
CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL 
    );

SELECT * FROM MEM_PRIMARYKEY1;

INSERT INTO MEM_PRIMARYKEY1 (MEM_NO,MEM_ID,MEM_PW,MEM_NAME) VALUES (1,'TEST1','TEST2','�Ͼ'));


/*
    5. FOREIGN KEY (�ܷ�Ű)
    �ش� �÷��� �ٸ� ���̺� ���礿�� ���� ���;� �ϴ� �÷��� �ο��ϴ� ��������
    ->"�ٸ����̺�"�� �����Ѵ� ��� ǥ���Ѵ� (�θ����̺�)
    -> ������ �ٸ� ���̺��� �����ϰ� �ִ� ���� ���� �� �ִ�.
    EX) KH �������� EMPLOYEE���̺� <----DEPARTMENT���̺�
            (�ڽ�)        (�θ�)
            DEPT_CODE   DEPT_ID
            ->DEPT_CODE���� DEPT_ID�� �����ϴ� ���鸸 ���� �� �ִ�.
        =FOREIGN KEY ��������(������) ���� �ٸ� ���̺�� ���踦 ���� �� �� �ִ�.(JOIN)
        
        [ǥ����]
        �÷��� �ڷ��� REFERENCES �������̺��(�����÷���)
        
        -�����÷��� ��������
        ->�ڵ����� �������̺��� PRIMARY KEY�� �ش�Ǵ� �÷��� ���� �÷����� ������.
        ���� : �����÷�Ÿ�԰� �ܷ�Ű �����÷�Ÿ���� ���ƾ���.

        --�θ� ���̺� �����
        --ȸ�� ��޿� ���� ������ (����ڵ�,��޸�) �����ϴ� ���̺�

*/
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR(20) NOT NULL
    );
    
    INSERT INTO MEM_GRADE VALUES('G1','�Ϲ�ȸ��');
    INSERT INTO MEM_GRADE VALUES('G2','���ȸ��');
    INSERT INTO MEM_GRADE VALUES('G3','Ư��ȸ��');

    SELECT * FROM MEM_GRADE;

--�ڽ����̺�
--ȸ�������� ��� ���̺�

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),--�ܷ�Ű ����
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL 
    );
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(1,'USER1','PW1','���н�','G1');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(2,'USER2','PW2','�農���н�','G2');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(3,'USER3','PW3','��þ��н�','G3');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(4,'USER4','PW4','��ƾ��н�','G4');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(5,'USER5','PW2','��ƾ��н�',NULL);--NULL���� �� ����.
    
    SELECT * FROM MEM;
    
    
    --�θ����̺�(MEM_GRADE)���� �����Ͱ��� �����ȴٸ�?
    --MEM GRADE ���̺�κ��� GRADE_CODE�� 'G1'�� �����͸� ��������
    DELETE FROM MEM_GRADE WHERE GRADE_CODE='G1';
 --   child record found : �ڽ� ���̺� �߿� G1���� �����ؼ� ����ϰ� �ֱ� ������ ���� �� �� ����.
--    ���� �ܷ�Ű �������� �ο��� ������ ���� ����� ���� �ο����� �ʾҴ�.
-->   �⺻������ ���� ���� �ɼ��� �ɷ��ִ�.

DROP TABLE MEM;

/*
    �ڽ� ���̺� ���� ��(==�ܷ�Ű ���������� �ο����� ��)
    �θ����̺��� �����Ͱ� �����Ǿ����� �ڽ� ���̺��� ��� ó���Ұ����� �ɼ����� ��������.
    FOREIGN KEY ���� �ɼ�
    -ON DELETE SET NULL : �θ����͸� ������ �� �ش� �����͸� ����ϴ� �ڽ� �����͸�  NULL�� �ٲٰڴ�.
    -ON DELETE CASCADE : �θ����͸� ������ �� �ش� �����͸� ����ϴ� �ڽ� �����͸� ���� �����ϰڴ�.
    -ON DELETE RESTRICTED : ���� ���� (�⺻ �ɼ�)
*/
--1)ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE,--�ܷ�Ű ����
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL 
    );
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(1,'USER1','PW1','���н�','G1');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(2,'USER2','PW2','�農���н�','G2');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(3,'USER3','PW3','��þ��н�','G3');
    
    
SELECT * FROM MEM;
    
    --�θ����̺�(MEM_GRADE)���� �����Ͱ��� �����ȴٸ�?
    --MEM GRADE ���̺�κ��� GRADE_CODE�� 'G1'�� �����͸� ��������
    DELETE FROM MEM_GRADE WHERE GRADE_CODE='G1';

--��ü ȸ���� ȸ����ȣ, ���̵�,��й�ȣ,�̸�,��޸� ��ȸ

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE,--�ܷ�Ű ����
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL 
    );

SELECT MEM_NO, MEM_ID,MEM_PW,MEM_NAME,GRADE_ID
FROM MEM;

-----------------------------------------------------------

/*
    SUBQUERY�� �̿��� ���̺� ����(���̺� �����ϴ� ����)
    ���� SQL�� (SELECT,CREATE,INSERT,UPDATE)�� �����ϴ� ������ ����
    
    [ǥ����]
    CREATE TABLE ���̺��
    AS ��������;

*/

--EMPLOYEE ���̺� ��ȸ
SELECT * FROM EMPLOYEE;

--EMPLOYEE ���̺��� ������ ���ο� ���̺� ����(EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
/*
    �÷���, ��ȸ����� �����Ͱ����� ����� �����Ѵ�.
    EMPLOYEE KEY ����
    PRIMARY KEY ���� X
    --> ���������� ���� ���̺��� ������ ��� ���������� NOT NULL �������Ǹ� ����ȴ�.
    
*/

SELECT * FROM EMPLOYEE_COPY;

--EMPLOYEE ���̺��� �����͸��� �÷� ������ �����ϰ� ������ (���Ǻο�)
CREATE TABLE EMPLOYEE_COPY2
AS SELECT *
    FROM EMPLOYEE
    WHERE 0=1;

SELECT *
FROM EMPLOYEE
WHERE 1=1; --TRUE

SELECT *
FROM EMPLOYEE
WHERE 0=1; --FALSE

SELECT * FROM EMPLOYEE_COPY2;

--��ü ����� �� �޿��� 300���� �̻��� ������� ���,�̸�,�μ��ڵ�,�޿�,�÷��� ������ ��� �����غ���
--���̺�� EMPLOYEE_COPY3 �� ����

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
    FROM EMPLOYEE
    WHERE SALARY<=3000000;
SELECT * FROM EMPLOYEE_COPY3;

CREATE TABLE EMPLOYEE_COPY4
AS SELECT EMP_ID,EMP_NAME,SALARY,(SALARY*12) ����
    FROM EMPLOYEE;
--������������ ������� �Ǵ� �Լ����� ����� ��쿡�� ��Ī�� �ٿ�����Ѵ�.
SELECT * FROM EMPLOYEE_COPY4;