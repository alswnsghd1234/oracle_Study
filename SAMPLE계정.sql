--3_1
--���̺� �����غ���

CREATE TABLE TEST(
    TEST_ID NUMBER
    );

--CREATE TABLE ���� �ο��޾Ƽ� TABLE SPACE �Ҵ���� ������ ����
    
SELECT * FROM TEST;

INSERT INTO TEST VALUES(10);

CREATE VIEW V_TEST
AS SELECT* FROM TEST;
--insufficient privileges ����
--CREATE VIEW ������ ���� ������ ����
--CREATE VIEW ���� �ο����� �� ��������

SELECT * FROM V_TEST; --CREATE VIEW ���� �ο����� �� �����Ϸ�

--5.
--SAMPLE �������� KH ������ �ִ� ���̺� �����ؼ� ��ȸ�غ���

SELECT * FROM KH.EMPLOYEE;
-- "table or view does not exist" ����

--6.�� �����غ���
INSERT INTO KH.DEPARTMENT VALUES('D0','ȸ���','L2');

--7.
--REVOKE (ȸ��) CREATE TABLE ������ �� ȸ���Ǿ����� Ȯ��
CREATE TABLE TEST2(
    TEST_ID NUMBER

);