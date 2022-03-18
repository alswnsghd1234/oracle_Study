/*
DML : 데이터 조작, SELECT(DQL), INSERT, UPDATE, DELETE
DDL : 데이터 정의, CREATE, ALTER, DROP
TCL : 트랜잭션 제어, COMMIT, ROLLBACK
DCL : 권한부여, GRANT, REVOKE

        <SELECT>
        데이터를 조회하거나 검색할 때 사용하는 명령어
        
        -RESULT SET : SELECT 구문을 통해 조회된 데이터의 결과물을 의미한다. 조호된 행들의 집합
        
        [표현법]
        SELECT 조회하고자하는 컬럼명,컬럼명2,컬럼명3...
        FROM 해당 테이블명;
        


*/
--EMPLOYEE 테이블의 전체 사원들의 사번,이름,급여 컬럼만을 조회해보자
SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE;

select emp_id,emp_name,salary
from employee;

-- 명령어,컬럼명,키워드, 테이블명은 대소문자를 가리지 않음
-- 하지만 대문자로 쓰자

--EMPLOYEE 테이블 전체 사원의 이름을 가져와보자
SELECT *
FROM EMPLOYEE;

SELECT EMP_NAME,EMAIL,PHONE
FROM EMPLOYEE;

-----실습 문제------

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
    <컬럼값을 통한 산술연산>
    조회하고자 하는 컬럼들을 나열하는 SELECT절에 산술연산(+-/*)을 기술해서 결과를 조회할 수 있다.

*/

--EMPLOYEE 테이블로부터 직원명, 월급,연봉(==월급*12)

SELECT EMP_NAME,SALARY,SALARY*12
FROM EMPLOYEE;

SELECT EMP_NAME,SALARY,BONUS,(SALARY+BONUS*SALARY)*12
FROM EMPLOYEE;

--산술연산 과정에서 NULL값이 존재할 경우 산술 연산 결과마저도 NULL이 된다.

/*
<컬럼명이 별칭 부여하기>
[표현법]
컬럼명 AS 별칭, 컬럼명 "별칭", 컬럼명 별칭, 컬럼명 "별칭"

AS를 붙이던 안붙이던 특수문자나 띄어쓰기가 포함될 경우엔 반드시 ""로 묶어서 표기해야함

*/

--EMPLOYEE 테이블로부터 직원명,월급,연봉(==*12)

SELECT EMP_NAME AS 사원명,SALARY AS "급여(월)",SALARY*12 AS "연봉(보너스 미포함)"
FROM EMPLOYEE;

/*
<리터럴>
임의로 지정한 문자열('')을 SELECT 절에 기술하면 실제 그 테이블에 존재하는 데이터처럼 조회가 가능하다.

*/

SELECT EMP_ID,EMP_NAME,SALARY,'원' 단위
FROM EMPLOYEE;
--SELECT절에 제시한 리터럴 값이 조회결과인 RESULT SET 행에 반복적으로 출력됨

/*
        <DISTINCT>
        조회하고자 하는 컬럼에 중복된 값을 딱 한번만 조회하고자 할때 사용
        해당 컬럼명 앞에 기술
        [표현법] DISTINCT 컬럼명
        단 SELECT절에 DISTINCT 구문은 단 한개만 가능하다.
        
*/
--EMPLOYEE 테이블에서 부서코드들만 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_CODE
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 직급코드들만 조회해보세요 JAB_CODE

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE
FROM EMPLOYEE;

--DEPT_CODE, JOB_CODE를 묶어서 중복판별
SELECT DISTINCT DEPT_CODE,JOB_CODE
FROM EMPLOYEE;

---------------------------
/*
<WHERE>
조회하고자 하는 테이블에 특정 조건을 제시해서
그 조건에 만족하는 데이터들만을 조회하고자 할 때 기술하는 구문
[표현법]
SELECT 조회하고자하는컬럼명,....
FROM 조회하고자하는 테이블명
WHERE 조건식;
실행순서
FROM->WHERE->SELECT
-조건식에 다양한 연산자 사용가능
<비교연산자>
<,>,<=,>=
= (일치하는가? 자바에선 ==)
=!일치하지않는가(^=,<>)세개 다 가능

*/

SELECT *
FROM EMPLOYEE WHERE SALARY >=4000000;

--EMPLOYEE 테이블로부터 부서코드가 D9인 사원
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
 <논리연산자>
 여러개의 조건을 엮을때 사용
 AND ,OR 
 
*/

--EMPLOYEE 테이블에서 부서코드가 D9이면서 급여가 500만원 이상인 사원들의 이름, 부서크드 급여 조회
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
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용
    
    [표현법]
    비교대상 컬럼명 BETWEEN 낮은값 AND 높은값
    
*/
--급여가 350만원 이상이고 600만원 이하인 사원들의 이름,사번,급여,직급코드 조회
SELECT EMP_NAME,EMP_ID,SALARY,JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--급여가 350만원 미만이고 600만원 초과인 사원들의 이름,사번,급여,직급코드 조회하기
SELECT EMP_NAME,EMP_ID,SALARY,JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

--입사일이 '90/01/01' ~'03/01/01'인 사원의 모든 컬럼을 조회하기

SELECT*
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

SELECT*
FROM EMPLOYEE
WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '03/01/01';

/*
< LIKE '특정패턴'>
    비교하고자 하는 컬럼값이 내가 지정한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼명 LIKE '특정패턴'
    - '%','_'를 가지고 제시
    '%' : 0글자 이상
        비교대상컬럼명 LIKE '문자%' -> 컬럼값중에 '문자'로 시작하는 것을 조회
        비교대상컬럼명 LIKE '%문자' -> 컬럼값중에 '문자'로 끝나는 것을 조회
        비교대상컬럼명 LIKE '%문자%' -> 컬럼값중에 '문자'가 포함되는 것을 조회
        
    '_' : 1글자
        비교대상컬럼명 LIKE '_문자' -> 해당 컬럼값 중에 '문자' 앞에 무조건 1글자가 존재하는 경우 조회
        비교대상컬럼명 LIKE '__문자' -> 해당 컬럼값 중에 '문자' 앞에 무조건 2글자가 존재하는 경우 조회

*/
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
--이름중에 '하'가 포함된 사원들의 이름,주민번호,부서코드 조회해보기
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

SELECT EMP_NAME,PHONE,EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

SELECT EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%해외영업%';

/*
    <IS NULL>
    해당 값이 NULL인지 비교
    [표현법]
    비교대상컬럼 IS NULL : 컬럼값이 NULL일 경우
    비교대상컬럼 IS NOT NULL : 컬럼값이 NULL이 아닐 경우

*/
SELECT*
FROM EMPLOYEE;

--보너스를 받지 않는 사람들(BONUS 컬럼값이 NULL인) 사번,이름,급여,보너스
SELECT EMP_ID,EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--사수도 없고 부서배치도 아직 받지 않은 사원들의 모든 컬럼 조회 -MANAGER_ID

SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
--보너스는 받지만 부서배치는 받지 못한 사원들의 모든 컬럼 조회

SELECT *
FROM EMPLOYEE
WHERE  BONUS IS NOT NULL AND MANAGER_ID IS NULL;

/*
    <IN>
    비교 대상 컬럼값에 내가 제시한 목록들 중에 일치하는 값이 있는지 판단
    [표현법]
    비교대상컬럼 IN(값,값,값...)
*/
-- 부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름 부서코드 급여 조회하기
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8','D5');

--직급 J1 J3 J4 모든 컬럼

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1','J3','J4');

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE NOT IN ('J1','J3','J4');

SELECT EMP_ID||EMP_NAME||SALARY AS "연결됨"
FROM EMPLOYEE;










