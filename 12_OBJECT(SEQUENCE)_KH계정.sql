/*
    <������ SEQUENCE>
    
    �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� �߻�������(���ӵ� ����)
    
    EX)ȸ����ȣ,�����ȣ,�Խñ۹�ȣ,
    -���������� ��ġ�� �ʴ� ���ڷ� �����Ҷ� ���
    
    1.������ ��ü ���� ����
    
    [ǥ����]
    CREATE SEQUENCE ��������
    START WITH ���ۼ��� -> ��������,ó�� �߻���ų ���� �� ����
    INCREMENT BY ������-> ��������,�ѹ� ������ ���� �� ������ � �����Ұ��� ����
    MAXVALUE �ִ밪 -> ��������, �ִ밪 ����
    MINVALUE �ּҰ� -> ��������,�ּҰ� ����
    CYCLE/NOCYCLE -> ��������, ���� ��ȯ ���θ� ����
    CACHE ����Ʈũ��/NOCACHE -> ��������, ĳ�ø޸� ���� ����(�⺻ SIZE = 20BTYE)
    
    *ĳ�� �޸𸮶�?
    �������κ��� �̸� �߻��� ������ �����ؼ� �����صδ� ����
    �Ź� ȣ���Ҷ����� ������ ��ȣ�� �����ϴ°ͺ���
    ĳ�ø޸� ������ �̸� ������ ������ ������ ���ԵǸ� �ӵ��� ������.
    ��, ������ ����� ���� ������ �� ������ �����Ǿ��ִ� ������ �����.
    
*/

CREATE SEQUENCE SEQ_TEST;

--���� ������ ������ �����ϰ� �մ� �������� ���� ������ ��ȸ�ϰ��� �Ѵٸ�
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMP_NO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    ������ ��� ����
    
    ��������,CURRVAL : ���� �������� �� ( ���������� ���������� �߻��� NEXTVAL��)
    ��������,NEXTVAL : ���� �������� ���� ������Ű�� �� ������ �������� �� == CURRVAL + INCREMENT BY
    ��, ������ ���� �� ù NEXTVAL�� START WITH�� ������ ���۰����� �߻�
    ù ��������.CURRVAL�� ���� �Ұ�
*/

SELECT SEQ_EMP_NO.CURRVAL FROM DUAL; --"sequence %s.CURRVAL is not yet defined in this session"
--�������� �����ǰ� ���� NEXTVAL�� �ѹ��̶� �������� �ʴ� �̻� CURRVAL�� ������ �� ����
-->CURRVAL�� �������� ���������� ����� NEXTVAL�� ���� �����ؼ� �����ִ� �ӽð��̱� ����

SELECT SEQ_EMP_NO.NEXTVAL FROM DUAL;
SELECT SEQ_EMP_NO.CURRVAL FROM DUAL;

/*

    CREATE SEQUENCE ��������
    INCREMENT BY ������-> ��������,�ѹ� ������ ���� �� ������ � �����Ұ��� ����
    MAXVALUE �ִ밪 -> ��������, �ִ밪 ����
    MINVALUE �ּҰ� -> ��������,�ּҰ� ����
    CYCLE/NOCYCLE -> ��������, ���� ��ȯ ���θ� ����
    CACHE ����Ʈũ��/NOCACHE -> ��������, ĳ�ø޸� ���� ����(�⺻ SIZE = 20BTYE)
    
    ->START WITH ������ �Ұ��� : �� �ٲٰ� ������ �����ߴٰ� �ٽ� �����ؾ� �Ѵ�.
        
*/

ALTER SEQUENCE SEQ_EMP_NO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMP_NO.CURRVAL FROM DUAL;
SELECT SEQ_EMP_NO.NEXTVAL FROM DUAL;

--SEQUENCE �����ϱ�

DROP SEQUENCE SEQ_EMP_NO;

SELECT * FROM EMPLOYEE;

--�Ź� ���ο� ����� �����Ǵ� ������ ����(�������� : SEQ_EID)
--223 ���� ����1 �ִ밪�� 300
CREATE SEQUENCE SEQ_EID
START WITH 223
INCREMENT BY 1
MAXVALUE 300
NOCYCLE
NOCACHE;

SELECT * FROM EMP_ID;
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '666666-3666666', 'hong_gd@kh.or.kr', '01012344444',
'D2', 'J7', 'S1', 5000000, SYSDATE);

