/*
    �Լ� <FUNCTION>
    �ڹٷ� ������ �޼ҵ�� ���� ����
    �Ű������� ���޵� ������ �о ����� ����� ��ȯ
    
    - ������ �Լ� : N���� ���� �о N���� ����� ����(�� �ึ�� �Լ� ������ ��� ��ȯ)
    - �׷� �Լ� : N���� ���� �о 1���� ����� ���� (�ϳ��� �׷캰�� �Լ� ���� �� ��� ��ȯ)
    
    ������ �Լ��� �׷� �Լ��� �Բ� ����� �� ���� : ��� ���� ������ �ٸ��� ������

*/

----------������ �Լ�-------------

/*
    <���ڿ��� ���õ� �Լ�>
    LENGTH / LENGTHB
    
    - LENGTH(���ڿ�) : �ش� ���޵� ���ڿ��� ���� �� ��ȯ
    - LENGTHB(���ڿ�) : �ش� ���޵� ���ڿ��� ����Ʈ �� ��ȯ
    
    ������� ���ڷ� ��ȯ -> NUMBER
    ���ڿ�:���ڿ� ������ ���ͷ�, ���ڿ��� �ش��ϴ� �÷�
    
    �ѱ�:'��'->'��','��','��'->�ѱ��ڴ� 3BTYE�� ����Ѵ�
    ����,����,Ư�����ڴ� �ѱ��ڴ� 1BTYE�� ���
*/

SELECT LENGTH('����Ŭ'),LENGTHB('����Ŭ')
FROM DUAL; -- �������̺� : ��������̳� ���� �÷��� ���� �ѹ��� ��ȸ�ϱ� ���� ����ϴ� ���� ���̺�

SELECT '����Ŭ',1,2,'AAA'
FROM DUAL;

SELECT EMAIL,LENGTH(EMAIL),LENGTHB(EMAIL),EMP_NAME,LENGTH(EMP_NAME),LENGTHB(EMP_NAME)
FROM EMPLOYEE;

/*

    INSTR
    -INSTR(���ڿ�,Ư������,ã����ġ�� ���۰�, ����): ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    ã�� ��ġ�� ���۰�, ������ ��������
    ������� NUMBERŸ������ ��ȯ
    ã�� ��ġ�� ���۰�(1/-1)
    1:�տ������� ã�ڴ�.(������ �⺻��)
    -1:�ڿ������� ã�ڴ�.
*/
SELECT INSTR('AAABCCBBCA','B')
FROM DUAL; -- �տ������� ù��°�� ��ġ�ϴ� B�� ��ġ���� �˷���

SELECT INSTR('AABAACBAAB','B',1)
FROM DUAL; --�տ������� ù��°�� ��ġ�ϴ� B�� ��ġ���� �տ�������
SELECT INSTR('AAABABACB','B',-1)
FROM DUAL;
SELECT INSTR('AAABBCAAAAB','B',-1,2)
FROM DUAL;--�ڿ������� �ι�°�� ��ġ�ϴ� B�� ��ġ���� �տ������� ���� �˷���
SELECT INSTR('ABAABCBABABA','B',1,2)
FROM DUAL; --�տ������� �ι�°�� ��ġ�� B�� ��ġ��

--EMAIL���� @��ġ ã��
SELECT INSTR(EMAIL,'@',1)
FROM EMPLOYEE;

/*

    SUBSTR
    ���ڿ��κ��� Ư�� ���ڿ��� �����ϴ� �Լ�
    -SUBSTR(���ڿ�,ó����ġ,�����ҹ��ڰ���)
    ������� CHARACTER Ÿ������ ��ȯ�� �ȴ�.(���ڿ�)
    ������ ���ڰ����� �������� (������ ������ ���ڿ� ������ ����)
    ó����ġ�� ������ ���� ���� : �ڿ������� N��° ��ġ�κ��� ���ڸ� �����ϰڴ� ��� ��
*/
SELECT SUBSTR('HELLO ORACLE',5)
FROM DUAL;
SELECT SUBSTR('HELLO ORACLE',5,2)
FROM DUAL;
SELECT SUBSTR('HELLO ORACLE',-2)
FROM DUAL;
SELECT SUBSTR('HELLO ORACLE',-7,3)
FROM DUAL;

-- �ֹι�ȣ���� ���� �κ��� �����ؼ� Ȯ���ϱ�
SELECT EMP_NAME,SUBSTR(EMP_NO,8,1) AS ����
FROM EMPLOYEE;
--���� ����� �̱�
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('1','3');

--EMAIL�κп��� @ã��
SELECT EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS ID
FROM EMPLOYEE;

SELECT EMAIL, SUBSTR(EMAIL,INSTR(EMAIL,'@')+1) AS ID
FROM EMPLOYEE;

SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('2','4') ;

/*
    LAPD / RAPD
    -LAPD/RAPD(���ڿ�, ���������� ��ȯ�� ������ ����(BTYE),�����̰����ڴ� ����)
    - ������ ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N ���̸�ŭ�� ���ڿ��� ��ȯ
    
    ������� CAHRACTER Ÿ������ ��ȯ
    �����̰��� �ϴ� ���� : �������� (������ �⺻�� ' ')

*/

SELECT LPAD(EMAIL,16)
FROM EMPLOYEE;

SELECT RPAD(EMAIL,20,'#')
FROM EMPLOYEE;

--�ֹι�ȣ ��ȸ : 501010-122331 -> 501010-1******

SELECT EMP_NAME,EMP_NO
FROM EMPLOYEE;

SELECT EMP_NAME,EMP_NO
FROM EMPLOYEE;

SELECT RPAD('501010-1',14,'*')
FROM DUAL;
-- �տ� 8�ڸ� �����ؼ� �ڿ� *���̱�
SELECT EMP_NAME,SUBSTR(EMP_NO,1,8)
FROM EMPLOYEE;
--SUBSTR�� �̿��� ������ 8�ڸ��� RPAD�� �ֱ�
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS "�ֹ�"
FROM EMPLOYEE;

/*
    
    LTRIM / RTRIM
    - LTRIM/RTRIM(���ڿ�,���Ž�Ű�����ϴ� ����)
    - ���ڿ��� ���� �Ǵ� �����ʿ��� ���Ž�Ű�����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڸ� ��ȯ
    ������� CHARACTER �ڷ������� ����
    ���Ž�Ű���� �ϴ� ���ڴ� ��������(�⺻�� ' ' �������)
    
*/

SELECT LTRIM('               K   H    ')
FROM DUAL;

SELECT LTRIM('AAAAA�ȳ��ϼ���AAAAA','A')
FROM DUAL;

SELECT RTRIM('0000012345000',0)
FROM DUAL;

SELECT LTRIM('ABCABCACBCBCSDBS','ABC')
FROM DUAL;

/*

    TRIM
    - TRIM(BOTH,LEADING,TRAILING '�����ϰ����ϴ¹���' FROM '���ڿ�)
    - ���ڿ��� ����/����/���� �� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ
    ������� CHARACTERŸ������ ��ȯ
    BOTH/LEADING/TRAILING : ������ �⺻���� BOTH

*/

SELECT TRIM('A' FROM 'AAAAZCSAAA')
FROM DUAL;
SELECT TRIM(LEADING 'A' FROM 'AAAAZCSAAA')
FROM DUAL; -- LEADING ���ʿ� �ִ°͸� ����(LTRIM�� ����)
SELECT TRIM(TRAILING 'A'FROM'AAAAZCSAAA')
FROM DUAL; -- TRAILING �����ʿ� �ִ°͸� ����(RTRIM�� ����)

/*

    LOWER/UPPER/INITCAP
    -LOWER(���ڿ�)
    :�� �ҹ��ڷ� ����
    -UPPER(���ڿ�)
    :�� �빮�ڷ� ����
    -INITCAP(���ڿ�)
    :�� �ܾ��� ù���ڸ� �빮�ڷ� ����
    
    ���� ��ȯŸ���� CHARACTER

*/
SELECT LOWER('HELLO WOLRD'),UPPER('hello world'),INITCAP('hello world GODD')
FROM DUAL;

/*
    CONCAT
    -CONCAT(���ڿ�1,���ڿ�2)
    :���޵� ���ڿ� �ΰ��� �ϳ��� ���ڿ��� ���ļ� ��ȯ
    ������� CHARACTER �ڷ���
*/
SELECT CONCAT('������','����')
FROM DUAL;

SELECT CONCAT(CONCAT('������','������'),'�帲') -- �ΰ� �̻� �ϰ�ʹٸ�
FROM DUAL;

--���Ῥ���ڷ� ���غ��� ���� ������ ã�ƺ���

SELECT '������'||'������'||'����'
FROM DUAL;

/*
    REPLACE
    -REPLACE(���ڿ�,ã������,�ٲܹ���)
    :���ڿ��κ��� ã�����ڸ� ã�Ƽ� �ٲ� ���ڷ� �ٲ� ���ڿ��� ��ȯ
    ������� CHARACTER �ڷ���

*/
SELECT REPLACE('HELLO WORLD','WORLD','ORACLE')
FROM DUAL;

--��� �̸��� �̸��� ����ϴµ� �̸��� �ڿ� �ּҸ� GMAIL.COM���� ���� ���
SELECT EMP_NAME,REPLACE(EMAIL,'kh.or.kr','GMAIL.COM')
FROM EMPLOYEE;


---------------------------------------

/*
    <���ڿ� ���õ� �Լ�>
    ABS
    -ABS(���밪�� ���� ����) : ���밪�� �����ִ� �Լ�
    ������� NUMBER �ڷ������� ��ȯ
*/
SELECT ABS(-10)
FROM DUAL;
SELECT ABS(-10.9)
FROM DUAL;

/*
    MOD
    -MOD(����,������):�� ���� ���� ���������� ��ȯ�ϴ� ���Լ�
    ����� NUMBER

*/

SELECT MOD(10,3)
FROM DUAL;
SELECT MOD(-10,3)
FROM DUAL;
SELECT MOD(10.9,3)
FROM DUAL;

/*
    ROUND
    -ROUND(�ݿø��ϰ����ϴ¼� ,�ݿø�����ġ):�ݿø� ó�� �Լ�
    
    �ݿø�����ġ : �Ҽ��� �������� �Ʒ� N��° ������ �ݿø� �ϰڴ�.
                ���� ����(��ġ ������ �⺻���� 0, �Ҽ��� ù��° �ڸ����� �ݿø��� �ϰڴ�.
                - �ݿø� ����� �Ҽ����� 0���̴�.)
    ������� NUMBER Ÿ������ ��ȯ

*/
SELECT ROUND(123,456)
FROM DUAL; --123
SELECT ROUND(123.456,1)
FROM DUAL; --123.5
SELECT ROUND(123.456,2)
FROM DUAL; --123.45
SELECT ROUND(123.456,-2)
FROM DUAL; --100

/*

    CEIL
    -CEIL(�ø�ó���Ҽ���):�Ҽ��� �Ʒ��� ���� ������ �ø��ϴ� �Լ�
    ��ȯ���� NUMBERŸ��

*/

SELECT CEIL(123.456)
FROM DUAL;
SELECT CEIL(451.089)
FROM DUAL;

/*
    FLOOR
    -FLOOR(����ó���ϰ��� �ϴ� ����) : �Ҽ����Ʒ��� ���� ������ ����ó�����ִ� �Լ�
    
    ��ȯ���� NUMBERŸ��

*/

SELECT FLOOR(123.456)
FROM DUAL;
SELECT FLOOR(2078.33)
FROM DUAL;


/*
    TRUNC
    -TRUNC(����ó���Ҽ���,��ġ):��ġ�� ���������� ���� ó���� ���ִ� �Լ�
    ������� NUMBERŸ��
    ��ġ : ��������,������ �⺻���� 0 (==FLOOR�Լ�)
*/

SELECT TRUNC(123.678)
FROM DUAL;
SELECT TRUNC(123.456,1)
FROM DUAL;

SELECT TRUNC(123.456,1)
FROM DUAL;

/*
    <��¥ ���� �Լ�>
    DATE Ÿ�� : �⵵,��,��,��,��,�ʸ� �� ������ �ڷ���
    SYSDATE : ���� �ý��� ��¥ ��ȯ
*/

SELECT SYSDATE
FROM DUAL;

/*
MONTHS_BETWEEN(dATE1,DATE2) : �� ��¥ ������ �������� ��ȯ(������� NUMBERŸ��)
--���� DATE2�� �� �̷��� ���̶�� ������ ��ȭ�˴ϴ�.
-- �� ������ �ٹ��ϼ�,�ٹ� ������

*/

SELECT EMP_NAME
       ,FLOOR(SYSDATE-HIRE_DATE)||'��' �ٹ��ϼ�
       ,FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))|| '��' �ٹ�������
FROM EMPLOYEE;

/*
    ADD_MONTHS(DATE,NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ �������� ���� ��¥�� ��ȯ�Ѵ�.(������� DATEŸ��)
    ���� ��¥�κ��� 5���� ����
*/

SELECT ADD_MONTHS(SYSDATE,5)
FROM DUAL;

SELECT SYSDATE+100 AS "100����"
FROM DUAL;

--������� �Ի� 1�ֳ�
SELECT EMP_NAME,HIRE_DATE,ADD_MONTHS(HIRE_DATE,12)
FROM EMPLOYEE;

--NEXT_DAY(DATE,����(����/����)) : Ư�� ��¥���� ���� ����� �ش� ������ ã�� �� ��¥�� ��ȯ(������� DATEŸ��)
SELECT NEXT_DAY(SYSDATE,5)
--1:�� ~ 7:��
FROM DUAL;

--����� :SATURDAY
--SELECT NEXT_DAY(SYSDATE,'SATURDAY')
--FROM DUAL;

--����
--DDL(������ ���� ���):CREATE,ALTER,DROP
--ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--LAST DAY(DATE) : �ش� Ư�� ��¥���� ������ ��¥�� ���ؼ� ��ȯ(������� DATEŸ��)
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--�̸�,�Ի���,�Ի��� ���� �������� ��ȸ
SELECT EMP_NAME,HIRE_DATE,LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

--EXTRACT : �⵵ �Ǵ� �� �Ǵ� �� ������ �����ؼ� ��ȯ
    --EXTRACT(YEAR FROM ��¥) : Ư�� ��¥�κ��� �⵵�� ����
    --EXTRACT(MONTH FROM ��¥) : Ư�� ��¥�κ��� �⵵�� ����
    --EXTRACT(DAY FROM ��¥) : Ư�� ��¥�κ��� �ϸ� ����
    
SELECT EXTRACT(YEAR FROM SYSDATE)
        ,EXTRACT(MONTH FROM SYSDATE)
        ,EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

--�����,�Ի�⵵,�Ի��,�Ի��� ��ȸ

SELECT EMP_NAME "�����"
        ,EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵"
        ,EXTRACT(MONTH FROM HIRE_DATE) "�Ի� ��"
        ,EXTRACT(DAY FROM HIRE_DATE) "�Ի� ��"
FROM EMPLOYEE;

-----------------------------------------------

/*
    <����ȯ �Լ�>
    
    NUMBER/DATE -> CHARCTER
    :TO_CHAR(NUMBER/DATE)
    :������ �Ǵ� ��¥�� ������Ÿ���� ������ Ÿ������ ��ȯ(���˿� ���缭)

*/

--���ڸ� ���ڿ���
SELECT TO_CHAR(1234)
FROM DUAL;

SELECT TO_CHAR(1234,'00000')
FROM DUAL;

SELECT TO_CHAR(1234,'99999')
FROM DUAL; --������ ��ĭ�� ' ' �������� ä��

SELECT TO_CHAR(1234,'L00000')
FROM DUAL; --L : LOCAL ȭ�����ǥ��

SELECT TO_CHAR(1234,'L99999')
FROM DUAL;

--�޿������� 3�ڸ����� , �� ��� Ȯ��, ȭ�� ������ �־
SELECT TO_CHAR(SALARY,'L999,999,999') AS "�޿�����"
FROM EMPLOYEE;

--��¥�� ���ڿ���
SELECT TO_CHAR(SYSDATE)
FROM DUAL; --22/03/18

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')
FROM DUAL; --2022-03-18

--�� �� �� : ����(AM)/����(PM)
SELECT TO_CHAR(SYSDATE,'PM HH:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'HH24:MI:SS')
FROM DUAL; -- 24�ð� ���� HH24

SELECT TO_CHAR(SYSDATE,'MON DY,YYYY')
FROM DUAL; --MON�� ����, DY�����ε� X���Ͽ��� X�� ǥ�� �����̶�� ������ ���ŵ� ����

SELECT TO_CHAR(SYSDATE,'MON DAY,YYYY')
FROM DUAL; --DAY��� �ϸ� - ���� ������ ����

--�⵵�� ǥ���� �� �ִ� ����

SELECT TO_CHAR(SYSDATE,'YYYY') AS "YYYY"
        ,TO_CHAR(SYSDATE,'RRRR') AS"YY"
        ,TO_CHAR(SYSDATE,'YY') AS "YY"
        ,TO_CHAR(SYSDATE,'RR') AS "RR"
        ,TO_CHAR(SYSDATE,'YEAR')AS "YEAR"
FROM DUAL;

--���� ǥ���Ҽ��ִ� ����
SELECT TO_CHAR(SYSDATE,'MM') AS "MM���� ǥ��"
        ,TO_CHAR(SYSDATE,'MON') AS "MON"
        ,TO_CHAR(SYSDATE,'MONTH') AS "MONTH�� ǥ��"
        ,TO_CHAR(SYSDATE, 'RM') AS "RM���� ǥ��"
FROM DUAL;

--�Ϸ� ǥ���� �� �ִ� ����
SELECT TO_CHAR(SYSDATE,'D') --1���� �������� �Ͽ��Ϻ��� ��ĥ°���� �˷��ִ� ����
    ,TO_CHAR(SYSDATE,'DD') -- 1�� �������� 1�Ϻ��� ��ĥ°���� �˷��ִ� ����
    ,TO_CHAR(SYSDATE,'DDD') -- 1�� �������� 1��1�Ϻ��� ��ĥ°���� �˷��ִ� ����
FROM DUAL;

--���Ϸ� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE,'DY') --���� ���� ���� ���
    ,TO_CHAR(SYSDATE,'DAY') -- ���� ����
FROM DUAL;

--2022�� 03�� 18�� (��) �̷� �������� ��ȸ�ϰ� �ʹ�.
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"(DY)')
FROM DUAL;

--���� ������ �̿��ؼ� ����� �̸��� �Ի����� ��ȸ�غ��ÿ�.

SELECT EMP_NAME,TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"(DY)')
FROM EMPLOYEE;

--2010�� ���Ŀ� �Ի��� ������� �̸��� �Ի����� ���� �������� ��ȸ�ض�

SELECT EMP_NAME,TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"(DY)')
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYYY')>=2010; --�ڵ� ����ȯ


/*
NUMBER/CHARACTER
-TO DATE(NUMBER/CHARACTER,����) : ������ �Ǵ� ������ �����͸� ��¥�� �����ͷ� ��ȯ(����� DATEŸ��)

*/

SELECT TO_DATE(20211010)
FROM DUAL; --�⺻ ������ YY/MM/DD
SELECT TO_DATE(000101)
FROM DUAL; --0���� �����ϴ� ���ڷ� �ν��ؼ� ����
SELECT TO_DATE('000101')
FROM DUAL; --0���� �����ϸ� ���ڷ� �ν��ϱ� ������ ���ڿ� Ÿ������ �־������

SELECT TO_DATE('20020203')
FROM DUAL;
SELECT TO_DATE('031019 020225','YYMMDD HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('031019 020225','YYMMDD HH24:MI:SS'),'YYMMDD HH24:MI:SS')
FROM DUAL;

/*
    CHARACTER -> NUMBER
    -TO)NUMBER(������,����) : ������ �����͸� ���������� ��ȯ(������� NUMBERŸ��)
    
*/

--�ڵ�����ȯ�� ����(���ڿ�->����)
SELECT '123'+'123'
FROM DUAL; --246 �ڵ�����ȯ �� ���������� ����

SELECT '100,000,000'+'5,000'
FROM DUAL; --����(,)�� ���ԵǾ��ֱ� ������ �ڵ�����ȯ�� �ȵ�

SELECT TO_NUMBER('100,000,000','999,999,999')+TO_NUMBER('50,000','99,999')
FROM DUAL; -- ����ȯ �Ŀ� ������� ���� TO_NUMBER��

SELECT TO_NUMBER('0123')
FROM DUAL;

--------------------------------------------------
--NULL : ���� �������� ������ ��Ÿ���� ��
--NULL ó�� �Լ��� : NVL,NVL2,NULLIF -> ���׿�����

/*
    <NULLó�� �Լ�>
    NVL(�÷���,�ش��÷����� NULL�� ��� ��ȯ�� ��)
    �ش� �÷����� ������ ��� (NULL)�� �ƴҰ��) ������ �÷��� ��ȯ
    �ش� �÷����� �������� ���� ��� (NULL���� ���) ���� ������ Ư������ ��ȯ�Ѵ�.
*/

SELECT BONUS
FROM EMPLOYEE;
--�����, ���ʽ��� ��ȸ�ϴµ� ���ʽ��� ������ 0���� ���
SELECT EMP_NAME,BONUS,NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME,NVL(DEPT_CODE,'����')
FROM EMPLOYEE;

/*

    NVL2(�÷���,�����1,�����2)
    �ش� �÷��� �����Ͱ� �����Ѵٸ� (NULL�� �ƴҰ��) �����1 ��ȯ
    �ش� �÷��� �����Ͱ� �������� �ʴ´ٸ� (NULL�ϰ��) �����2 ��ȯ
    
*/

--���ʽ��� �ִ� ����� ���ʽ� ����, ���ʽ��� ���� ����� ���ʽ��� ������ ��ȸ�غ���
SELECT EMP_NAME,BONUS,NVL2(BONUS,'���ʽ�����','���ʽ�����')
FROM EMPLOYEE;