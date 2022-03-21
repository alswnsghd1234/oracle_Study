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


