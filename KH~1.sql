/*
DML : ������ ����, SELECT(DQL), INSERT, UPDATE, DELETE
DDL : ������ ����, CREATE, ALTER, DROP
TCL : Ʈ����� ����, COMMIT, ROLLBACK
DCL : ���Ѻο�, GRANT, REVOKE

        <SELECT>
        �����͸� ��ȸ�ϰų� �˻��� �� ����ϴ� ��ɾ�
        
        -RESULT SET : SELECT ������ ���� ��ȸ�� �������� ������� �ǹ��Ѵ�. ��ȣ�� ����� ����
        
        [ǥ����]
        SELECT ��ȸ�ϰ����ϴ� �÷���,�÷���2,�÷���3...
        FROM �ش� ���̺��;
        


*/
--EMPLOYEE ���̺��� ��ü ������� ���,�̸�,�޿� �÷����� ��ȸ�غ���
SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE;

select emp_id,emp_name,salary
from employee;

-- ��ɾ�,�÷���,Ű����, ���̺���� ��ҹ��ڸ� ������ ����
-- ������ �빮�ڷ� ����

--EMPLOYEE ���̺� ��ü ����� �̸��� �����ͺ���
SELECT *
FROM EMPLOYEE;

SELECT EMP_NAME,EMAIL,PHONE
FROM EMPLOYEE;

-----�ǽ� ����------

SELECT *
FROM JOB;

SELECT JOB_NAME
FROM JOB;

SELECT *
FROM DEPARTMENT;

SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE
FROM EMPLOYEE;

SELECT HIRE_DATE,EMP_NAME,SALARY
FROM EMPLOYEE;

/*
    <�÷����� ���� �������>
    ��ȸ�ϰ��� �ϴ� �÷����� �����ϴ� SELECT���� �������(+-/*)�� ����ؼ� ����� ��ȸ�� �� �ִ�.

*/

--EMPLOYEE ���̺�κ��� ������, ����,����(==����*12)

SELECT EMP_NAME,SALARY,SALARY*12
FROM EMPLOYEE;

SELECT EMP_NAME,SALARY,BONUS,(SALARY+BONUS*SALARY)*12
FROM EMPLOYEE;

--������� �������� NULL���� ������ ��� ��� ���� ��������� NULL�� �ȴ�.

/*
<�÷����� ��Ī �ο��ϱ�>
[ǥ����]
�÷��� AS ��Ī, �÷��� "��Ī", �÷��� ��Ī, �÷��� "��Ī"

AS�� ���̴� �Ⱥ��̴� Ư�����ڳ� ���Ⱑ ���Ե� ��쿣 �ݵ�� ""�� ��� ǥ���ؾ���

*/

--EMPLOYEE ���̺�κ��� ������,����,����(==*12)

SELECT EMP_NAME AS �����,SALARY AS "�޿�(��)",SALARY*12 AS "����(���ʽ� ������)"
FROM EMPLOYEE;

/*
<���ͷ�>
���Ƿ� ������ ���ڿ�('')�� SELECT ���� ����ϸ� ���� �� ���̺� �����ϴ� ������ó�� ��ȸ�� �����ϴ�.

*/

SELECT EMP_ID,EMP_NAME,SALARY,'��' ����
FROM EMPLOYEE;
--SELECT���� ������ ���ͷ� ���� ��ȸ����� RESULT SET �࿡ �ݺ������� ��µ�

/*
        <DISTINCT>
        ��ȸ�ϰ��� �ϴ� �÷��� �ߺ��� ���� �� �ѹ��� ��ȸ�ϰ��� �Ҷ� ���
        �ش� �÷��� �տ� ���
        [ǥ����] DISTINCT �÷���
        �� SELECT���� DISTINCT ������ �� �Ѱ��� �����ϴ�.
        
*/
--EMPLOYEE ���̺��� �μ��ڵ�鸸 ��ȸ
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_CODE
FROM EMPLOYEE;

--EMPLOYEE ���̺��� �����ڵ�鸸 ��ȸ�غ����� JAB_CODE

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE
FROM EMPLOYEE;

--DEPT_CODE, JOB_CODE�� ��� �ߺ��Ǻ�
SELECT DISTINCT DEPT_CODE,JOB_CODE
FROM EMPLOYEE;

---------------------------
/*
<WHERE>
��ȸ�ϰ��� �ϴ� ���̺� Ư�� ������ �����ؼ�
�� ���ǿ� �����ϴ� �����͵鸸�� ��ȸ�ϰ��� �� �� ����ϴ� ����
[ǥ����]
SELECT ��ȸ�ϰ����ϴ��÷���,....
FROM ��ȸ�ϰ����ϴ� ���̺��
WHERE ���ǽ�;
�������
FROM->WHERE->SELECT
-���ǽĿ� �پ��� ������ ��밡��
<�񱳿�����>
<,>,<=,>=
= (��ġ�ϴ°�? �ڹٿ��� ==)
=!��ġ�����ʴ°�(^=,<>)���� �� ����

*/

SELECT *
FROM EMPLOYEE WHERE SALARY >=4000000;

--EMPLOYEE ���̺�κ��� �μ��ڵ尡 D9�� ���
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE= 'D9';

SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE!= 'D9';

SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >=3000000;

SELECT EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

SELECT EMP_ID,EMP_NAME,HIRE_DATE
FROM EMPLOYEE 
WHERE ENT_YN = 'Y';

SELECT EMP_NAME,SALARY,SALARY*12,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY*12 >=50000000; 

/*
 <��������>
 �������� ������ ������ ���
 AND ,OR 
 
*/

--EMPLOYEE ���̺��� �μ��ڵ尡 D9�̸鼭 �޿��� 500���� �̻��� ������� �̸�, �μ�ũ�� �޿� ��ȸ
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D9' AND SALARY>=5000000;

SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D6' AND SALARY>=3000000;

SELECT EMP_NAME,EMP_NO,JOB_CODE
FROM EMPLOYEE
WHERE SALARY<=6000000 AND SALARY>=3500000;

/*
    <BETWEEN AND>
    �� �̻� �� ������ ������ ���� ������ ������ �� ���
    
    [ǥ����]
    �񱳴�� �÷��� BETWEEN ������ AND ������
    
*/
--�޿��� 350���� �̻��̰� 600���� ������ ������� �̸�,���,�޿�,�����ڵ� ��ȸ
SELECT EMP_NAME,EMP_ID,SALARY,JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--�޿��� 350���� �̸��̰� 600���� �ʰ��� ������� �̸�,���,�޿�,�����ڵ� ��ȸ�ϱ�
SELECT EMP_NAME,EMP_ID,SALARY,JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

--�Ի����� '90/01/01' ~'03/01/01'�� ����� ��� �÷��� ��ȸ�ϱ�

SELECT*
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

SELECT*
FROM EMPLOYEE
WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '03/01/01';

/*
< LIKE 'Ư������'>
    ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴���÷��� LIKE 'Ư������'
    - '%','_'�� ������ ����
    '%' : 0���� �̻�
        �񱳴���÷��� LIKE '����%' -> �÷����߿� '����'�� �����ϴ� ���� ��ȸ
        �񱳴���÷��� LIKE '%����' -> �÷����߿� '����'�� ������ ���� ��ȸ
        �񱳴���÷��� LIKE '%����%' -> �÷����߿� '����'�� ���ԵǴ� ���� ��ȸ
        
    '_' : 1����
        �񱳴���÷��� LIKE '_����' -> �ش� �÷��� �߿� '����' �տ� ������ 1���ڰ� �����ϴ� ��� ��ȸ
        �񱳴���÷��� LIKE '__����' -> �ش� �÷��� �߿� '����' �տ� ������ 2���ڰ� �����ϴ� ��� ��ȸ

*/
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';
--�̸��߿� '��'�� ���Ե� ������� �̸�,�ֹι�ȣ,�μ��ڵ� ��ȸ�غ���
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

SELECT EMP_NAME,PHONE,EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

SELECT EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%�ؿܿ���%';

/*
    <IS NULL>
    �ش� ���� NULL���� ��
    [ǥ����]
    �񱳴���÷� IS NULL : �÷����� NULL�� ���
    �񱳴���÷� IS NOT NULL : �÷����� NULL�� �ƴ� ���

*/
SELECT*
FROM EMPLOYEE;

--���ʽ��� ���� �ʴ� �����(BONUS �÷����� NULL��) ���,�̸�,�޿�,���ʽ�
SELECT EMP_ID,EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--����� ���� �μ���ġ�� ���� ���� ���� ������� ��� �÷� ��ȸ -MANAGER_ID

SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
--���ʽ��� ������ �μ���ġ�� ���� ���� ������� ��� �÷� ��ȸ

SELECT *
FROM EMPLOYEE
WHERE  BONUS IS NOT NULL AND MANAGER_ID IS NULL;

/*
    <IN>
    �� ��� �÷����� ���� ������ ��ϵ� �߿� ��ġ�ϴ� ���� �ִ��� �Ǵ�
    [ǥ����]
    �񱳴���÷� IN(��,��,��...)
*/
-- �μ��ڵ尡 D6�̰ų� �Ǵ� D8�̰ų� �Ǵ� D5�� ������� �̸� �μ��ڵ� �޿� ��ȸ�ϱ�
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8','D5');

--���� J1 J3 J4 ��� �÷�

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1','J3','J4');

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE NOT IN ('J1','J3','J4');

SELECT EMP_ID||EMP_NAME||SALARY AS "�����"
FROM EMPLOYEE;










