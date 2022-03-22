/*

    <GROUP BY절>
    그룹을 묶어줄 기준을 제시할 수 잇는 구문 -> 그룹함수와 같이 쓰임
    해당 제시된 기준별로 그룹을 묶을 수 있음
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
    
    [표현법]
    GROUP BY 묶어줄 기준 컬럼
*/

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 부서별로 그룹 짓겠다.

--'D1'의 부서의 총 급여 합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

--각 부서별 사원수
SELECT DEPT_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--각 부서별 총 급여합을 조회
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY SUM(SALARY);

--D1 부서의 사원명 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

--각 직급별 직급코드,총 급여의 합,사원수,보너스를 받는 사원수,평균급여,최고급여,최소급여
SELECT JOB_CODE,
        SUM(SALARY) "총 급여의 합",
        COUNT(*) "사원 수",
        COUNT(BONUS) "보너스를 받는 사원 수",
        ROUND(AVG(SALARY)) "평균 급여",
        MAX(SALARY) "최고 급여",
        MIN(SALARY) "최소 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--각 부서별 부서코드,보너스를 받는 사원수,사수가 있는 사원수,평균급여
SELECT DEPT_CODE,
        COUNT(*) "사원 수",
        COUNT(BONUS) "보너스를 받는 사원 수",
        ROUND(AVG(SALARY)) "평균 급여",
        COUNT(MANAGER_ID) "사수가 있는 사원 수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC;

-- 성별 별 사원 수
-- 성별 : SUBSTR(EMP_NO,8,1)
SELECT SUBSTR(EMP_NO,8,1) "성별"
    ,COUNT(*) "사원 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

--DECODE 함수 추가해보기
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여자') "성별"
    ,COUNT(*) "사원 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

--성별 기준으로 평균 급여
--CASE WHEN THEN 구문으로 작성해보세요

SELECT CASE WHEN SUBSTR(EMP_NO,8,1)='1' THEN '남자'
    WHEN SUBSTR(EMP_NO,8,1)='2' THEN '여자'
    END "성별",
    FLOOR(AVG(SALARY)) "평균 급여"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

/*
    <HAVING절>
    그룹에 댓한 조건을 제시하고자 할 때 사용되는 구문
    (주로 그룹함수를 가지고 조건 제시) -> GROUP BY 절과 함께 쓰인다.
    [표현법]
    SELECT
    FROM
    GROUP BY
    HAVING
*/
-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE,FLOOR(AVG(SALARY)) "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >=3000000;



--각 직급별 급여 평균이 300만원 이상인 직급 코드,평균 급여, 사원수,최고급여,최소급여 조회
SELECT JOB_CODE,AVG(SALARY),COUNT(*),MIN(SALARY),MAX(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING AVG(SALARY) >=3000000;

-- 각 부서 별 보너스를 받는 사원이 없는 부서만을 조회

SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

-- 각 부서 별 평균 급여가 350만원 이하인 부서만을

SELECT JOB_CODE
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING AVG(SALARY) <=3500000;

----------------------------------------------

/*

    <SELECT문 주고 및 실행순서>
    SELECT 조회하고자 하는 컬럼명 나열 /'*'/함수식/연산식
    FROM 조회하고자하는 테이블 명 / 가상테이블(DUAL)
    WHERE 조건식 (단, 그룹함수는 안됨)
    GROUP BY 그룹 기준에 해당하는 컬럼명 / 함수식
    HAVING 그룹함수식에 대한 조건식
    ORDER BY [정령기준에 해당하는 컬럼명 / 별칭 / 컬럼의 순번][ASC/DESC](생략가능)[NULLS FIRST/NULLS LAST](생략가능)
   
*/

/*
    <집합 연산자 SET OPERATOR>
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자

    -UNION(합집합) : 두 쿼리문을 수행한 결과값을 더한 후 중복되는 부분을 한번만 빼서 중복을 제거한것 -> OR
    -UNION ALL : 두 쿼리문을 수행한 결과값을 더한 후 중복제거를 하지 않은 것 -> 합집합 + 교집합
    -INTERSECT(교집합) : 두 쿼리문을 수행한 결과값의 중복된 부분 -> AND
    -MINUS(차집합) : 선행 쿼리문 결과값에서 후행 쿼리문 결과값을 뺀 나머지 부분
                    -> 선행 쿼리문 결과값 - 교집합

    주의사항 : 두 쿼리문의 결과를 합쳐서 한개의 테이블로 보여줘야하기 때문에 두 쿼리문의 SELECT절 부분은 같아야한다.
    즉, 조회할 컬럼이 동일해야 함

*/

-- 1. UNION(합집합) : 두 쿼리문을 수행한 결과값을 더하지만 중복은 제거
-- 부서코드가 D5 이거나 급여가 300만원 초과인 사원들 조회(사번,사원명,부서코드,급여) -> OR
-- 부서코드가 D5인 사원들만 조회

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

--급여가 300만원 초과인 사원들 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY>3000000; --8명 조회

--부서코드가 D5 이거나 급여가 300만원 초과인 사원들 조회(사번,사원명,부서코드,급여) -> UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY>3000000;

--OR 연산자로
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR  SALARY>3000000;

--1. 직급코드가 J6인 사원들만 조회(사번
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6' OR DEPT_CODE='D1';

--2. UNION ALL : 여러개의 쿼리 결과를 더해서 보여주는 연산자

SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
UNION ALL
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D1'; --9명

--3. INTERSECT : 교집합 여러 쿼리 결과의 중복된 결과만을 조회 ->AND
--
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
INTERSECT
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

-- 4. MINUS : 차집합, 선행 쿼리 결과에 후행 쿼리 결과를 뺀 나머지
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
MINUS
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

