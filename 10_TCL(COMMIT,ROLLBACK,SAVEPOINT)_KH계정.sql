/*
    TCL(TRANSACTION CONTROL LANGUAGE)
    Ʈ������� �����ϴ� ���
    
    *Ʈ�����(TRANSACTION)
    -�����ͺ��̽��� ���� �۾� ����
    -�������� ������� (DML) ���� �ϳ��� Ʈ��������� ��� ó��
    -> COMMIT (Ȯ��) �ϱ� �������� ������׵��� �ϳ��� Ʈ��������� ��ڴ�.
    - Ʈ������� ����� �Ǵ� SQL : INSERT,UPDATE,DELETE (DML)
    
    * Ʈ������� ����
    - COMMIT : ����(CTRL+ENTER) : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ��ϰڴٴ� �ǹ�
                                 ���� DB�� �ݿ���Ų �� Ʈ������� ����� (Ȯ��)
    -ROLLBACK : ����(CRTL+ENTER) : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ����� �ʰڴٴ°��� �ǹ�
                                  Ʈ����ǿ� ����ִ� ������׵� �� ������ �� ������ COMMIT �������� ���ư���.
    -SAVEPOINT ����Ʈ��; : ����(CTRL+ENTER) : ���� �� ������ �ӽ��������� ������ �δ°�
    -ROLLBACK TO ����Ʈ��; ����(CTRL+ENTER) : ��ü ������׵��� ����(������ COMMIT �������� ��������) �ϴ°��� �ƴ϶�
                                            �ش� ����Ʈ ���������� Ʈ������� �ѹ��Ѵ�.
    
*/
    SELECT * FROM EMP_01;
    
    DELETE FROM EMP_01
    WHERE DEPT_TITLE IS NULL;
    INSERT INTO EMP_01 VALUES(9999,'�ѹ���','����');
    COMMIT;
    ROLLBACK;
------------------------------

-- ���̺� ����
CREATE TABLE TEST(
    TEST_ID NUMBER
    );
    
SELECT * FROM EMP_01;

ROLLBACK;

/*
    ���ǻ���
    DDL���� (CREATE,ALTER,DROP)�� �����ϴ� ����
    ������ Ʈ����ǿ� �ִ� ��� ������׵��� ������ ���� DB�� �ݿ� (COMMIT�� ��Ų�� DDL ����)
    DDL ���� �� ��������� �־��ٸ� ��Ȯ�� COMMIT �Ǵ� ROLLBACK�� ������ �Ŀ� DDL�� ���� �ؾ� �Ѵ�.
    
*/