/*���� ����Ǽ� �����ִ� ��*/
SELECT EMP_ID||EMP_NAME||SALARY AS "�����"
FROM EMPLOYEE;

/*
������ �켱����

1. ���������
2. ���Ῥ����
3. �񱳿�����
4. IS NULL, LIKE, IN
5. BETWEEN AND
6. NOT
7. AND
8. OR
*/

/*
    <ORDER BY>
    SELECT�� ���� �������� �����ϴ� ������ �ƴ϶� ���� �������� ����Ǵ� ����
    ���� ��ȸ�� ������� ���ؼ� ���� ������ �����ִ� ����
    
    [ǥ����]
    SELECT ��ȸ �� �÷�...
    FROM ��ȸ�� ���̺�..
    WHERE ���ǽ�...(��������)
    ORDER BY [���ı������� �����ϰ����ϴ� �÷���/��Ī] [ASC/DESC](��������) [NULLS FIRST/NULLS LAST](���� ����)
    
    ��������/��������
    - ASC :  �������� (���������� �⺻ ��)
    - DESC : ��������
    
    �����ϰ��� �ϴ� �÷����� NULL�� ���� ���
    - NULL FRIST : �ش� NULL������ ���� �����ְڴ�. (���������� ��쿡 �⺻��)
    - NULL LAST : �ش� NULL������ ���߿� �����ְڴ�. (���������� ��쿡 �⺻��)
    

*/
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- ���� ���� ����
SELECT EMP_NAME,SALARY,(SALARY*12) "����"
FROM EMPLOYEE
ORDER BY "����" ASC;

--���ڿ��� ���İ���
SELECT EMP_NAME
FROM EMPLOYEE
ORDER BY EMP_NAME;

--��¥�� ���İ���
SELECT HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE;

--������ �켱���� ����
--J2 �Ǵ� J7 ���� �ڵ� �� �޿��� 200�������� ���� �޴� ������ �̸�,�޿�,�����ڵ� ��ȸ
SELECT EMP_NAME,SALARY,JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE='J2') AND SALARY>=2000000;