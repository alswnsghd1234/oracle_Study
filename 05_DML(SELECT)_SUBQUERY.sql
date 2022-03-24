/*
    <SUBQUERY(서브쿼리)>
    하나의 주된 SQL(SELECT,CREATE,INSERT,UPDATE,...)안에 포함된 또 하나의 SELECT문
    
    메인 SQL문을 위해 보조 역할을 하는 SELECT문
*/

--간단 서브쿼리 예시 1
-- 노옹철 사원과 같은 부서인 사원들
--1)먼저 노옹철 사원의 부서코드를 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='노옹철'; -- 노옹철 사원의 부서코드는 D9

--2)부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE='D9';--선동일,송종기.노옹철

--위에 두 단계를 합쳐보자
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE=(SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='노옹철'); --D9

--간단 서브쿼리 예시 2
--전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 이름,직급코드 조회

--1)전체 사원의 평균 급여를 구하기
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE;

--2)
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE
WHERE SALARY >(SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE);

/*
    서브쿼리 그분
    서브쿼리를 수행한 결과값이 몇행 몇열이냐에 따라서 분류
    
    -단일행(단일열) 서브쿼리 : 서브쿼리르 수행한 결과값이 오롤지 1개일 때 (한칸의 컬럼값으로 나올때)
    -다중행(단일열) 서브쿼리 : 서브쿼릴르 수행한 결과값이 여러 행일때
    -(단일행)다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 열일때
    -다중행 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 행 여러 열일때
    
    -> 서브쿼리를 수행한 결과값이 몇행 몇열이냐에 따라서 사용 가능한 연산자가 달라진다.

*/

/*
    1.단일행 (단일열) 서브쿼리(SINGLE ROW SUBQUERY)
    서브쿼리의 조회 결과값이 1개일때
    일반 연산자 가능 (=,!=,>,<,<=,>=..)
*/

--전 직원의 평균 급여보다 더 적게 받는 사원들의 사원명 직급코드 급여를 조회해보자
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);

--최저급여를 받는 사원의 사번,사원명,직급코드,급여,입사일을 조회해보자
SELECT EMP_NAME,JOB_CODE,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--노옹철 사원의 급여보다 더 많이 받는 사원들의 사번,이름,부서코드,급여
SELECT EMP_NAME,JOB_CODE,SALARY,EMP_NO
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철');

SELECT EMP_NAME,JOB_CODE,SALARY,EMP_NO,DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철');

--부서별 급여 합이 가장 큰 부서 하나만을 조회,부서코드,부서명,급여의 합(서브쿼리+GROUP BY+HAVING)
SELECT MAX(SUM(SALARY)),DEPT_TITLE,DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
GROUP BY DEPT_TITLE, DEPT_CODE
HAVING MAX(SALARY) IN (SELECT SUM(SALARY) FROM EMPLOYEE);

SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--합치기

SELECT DEPT_CODE,DEPT_TITLE,SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY DEPT_CODE,DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE);

/*
    2.다중행 서브쿼리 (MULTI ROW SUBQUERY)
    
    서브쿼리의 조회 결과값이 여러 행일 경우
    
    - IN (10,20,30) 서브쿼리 : 여러개의 결과값중에서 하나라도 일치하는것이 있다면 /NOT IN = 없다면
    > ANY (10,20,30) 서브쿼리 : 여러개의 결과값중에 하나라도 클 경우
    < ANY (10,20,30) 서브쿼리 : 여러개의 결과값중에 하나라도 작을 경우
    
    > ALL : 여러개의 결과값의 모든 값보다 클 경우 (결과값 중 가장 큰 값보다 클 경우)
    < ALL : 여러개의 결과값의 모든 값보다 작을 경우 (결과값 중 가장 작은 값보다 작을 경우)
    
*/

--각 부서 별 최고 급여를 받는 사원의 이름,직급코드, 급여 조회
--1) 각 부서 별 최고급여 조회 (여러행,단일열)
SELECT DEPT_CODE,MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--2)위에서 조회한 급여들을 받는 사원들 조회
SELECT DEPT_TITLE,DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
        FROM EMPLOYEE
        GROUP BY DEPT_CODE);

SELECT MAX(COUNT(*))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT DEPT_TITLE,COUNT(*) 인원수
FROM EMPLOYEE E,DEPARTMENT D
WHERE DEPT_CODE=DEPT_ID
GROUP BY DEPT_TITLE
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM EMPLOYEE
GROUP BY DEPT_CODE);

SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('선동일','유재식'));

SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('이오리','하동운');

SELECT EMP_NAME,JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('이오리','하동운'));

--대리직급임에도 과장보다 급여를 많이 받는 사원들 조회 (사번,이름,직급명,급여)
--1) 과장 직급들의 급여를 조회해보자
SELECT SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND J.JOB_NAME = '과장';

--2)위의 급여들 보다 하나라도 많이 받는 사원 조회

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY >= 2200000
AND JOB_NAME='대리';

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY > ANY (SELECT SALARY
        FROM EMPLOYEE E,JOB J
        WHERE E.JOB_CODE=J.JOB_CODE
        AND J.JOB_NAME = '과장')
AND JOB_NAME='대리';

--과장직급임에도 차장직급 급여보다 많이받는 직원 조회 (사번,이름,직급명,급여)

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY > ALL (SELECT SALARY
        FROM EMPLOYEE E,JOB J
        WHERE E.JOB_CODE=J.JOB_CODE
        AND J.JOB_NAME = '차장')
AND JOB_NAME='과장';

/*
    3.(단일행)다중열 서브쿼리
    서브쿼리 조회 결과가 값은 한 행이지만, 나열된 컬럼의 개수가 여러개일 경우
*/

--하이유 사원과 같은 부서코드,같은 직급코드에 해당하는 사람들 조회(사원명,부서코드,직급코드,입사일)

--1)하이유 사원의 부서코드,직급코드 조회하기
SELECT DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME='하이유';

--2)부서코드 D5 이며 직급코드 J5인 사원들 조회해보기(사원명,부서코드,직급코드,입사일)
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND JOB_CODE='J5';

SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) = (SELECT DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME='하이유');
--다중열 서브쿼리(비교할 값의 순서 맞추기)
--(비교대상컬럼1,비교대상컬럼2) = (비교할값1,비교할값2 => 서브쿼리 형식으로만 제시해야한다)

--박나라 사원과 같은 직급코드
SELECT EMP_NAME,EMP_ID,JOB_CODE,MANAGER_ID
FROM EMPLOYEE
    WHERE (MANAGER_ID,JOB_CODE) = (SELECT MANAGER_ID,JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME='박나라');


/*

    4.다중행 다중열 서브쿼리
    
    서브쿼리 조회 결과가 여러행 여러 컬럼일 경우
    
*/

--각 직급별 최소 급여를 받는 사원들 조회(사번,이름,직급코드,급여)
--1)각 직급별 최소 급여를 조회
SELECT JOB_CODE,MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE; 

--2)위웨서 구한 목록들에 해당하는 사원 조회하기
SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE,MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);
                            
SELECT EMP_ID,EMP_NAME,NVL(DEPT_CODE,'부서미지정') DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'부서미지정'),SALARY) IN (SELECT NVL(DEPT_CODE,'부서미지정'),MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE);
                            
/*
    5.인라인뷰(INLINE VIEW)
    FROM절에 서브쿼리를 제시하는것
    서브쿼리 수행한 결과(RESULT SET)을 테입르 대신 사용하겠다.
*/                            

--보너스 포함 연봉이 3000만원 이상인 사원들의 사번,이름,보너스 포함 연봉, 부서코드를 조회
SELECT EMP_ID,EMP_NAME,(SALARY+(SALARY*NVL(BONUS,0))*12) 연봉,DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY+(SALARY*NVL(BONUS,0))*12) >= 3000000;

SELECT EMP_NAME
FROM (SELECT EMP_ID,EMP_NAME,(SALARY+(SALARY*NVL(BONUS,0))*12) 연봉,DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY+(SALARY*NVL(BONUS,0))*12) >= 3000000);

--인라인뷰를 주로 사용하는 예
--TOP-N 분석 : 데이터베이스 상에 있는 자료중 최상위 N개의 자료를 보기위해 사용하는 기능

--전 직원중 급여가 가장 높은 상위 5명(순위,사원명,급여)
--ROWNUM : 오라클에서 제공해주는 컬럼으로 조회된 순서대로 1부터 순번을 부여해주는 컬럼이다.

SELECT ROWNUM,EMP_NAME,SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

--해결
SELECT ROWNUM,EMP_NAME,SALARY
FROM (SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC)
WHERE ROWNUM <=5;

--각 부서별 평균 급여가 높은 3개의 부서의 부서코드 평균 급여를 조회

SELECT DEPT_CODE,FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;

SELECT ROWNUM,E.*
FROM (SELECT DEPT_CODE,FLOOR(AVG(SALARY))
        FROM EMPLOYEE E
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC) E
WHERE ROWNUM <=3;

--가장 최근에 입사한 사원 5명 조회 -인라인뷰로 순위 매기기
SELECT DEPT_CODE,FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;

SELECT ROWNUM,E.*
FROM (SELECT EMP_NAME,HIRE_DATE
        FROM EMPLOYEE E
        ORDER BY HIRE_DATE DESC) E
WHERE ROWNUM <=5 ORDER BY HIRE_DATE ASC;

/*

    6.순위 매기는 함수 (WINDOW FUNCTION)
    
    RANK() OVER(정렬 기준)
    DENSE_RANK() OVER(정렬 기준)
    -RANK() OVER : 공동 1위가 3명이라고 하면 그 다음순위는 4위로 하겠다
    -DENSE_RANK() OVER : 공동 1위가 3명이어도 그 다음 순위는 2위로 하겠다
    
    정렬 기준:ORDER BY절(정렬기준컬럼이름 오름차순/내림차순)
    SELECT 절에서만 사용가능

*/

--사원들의 급여가 높은 순서대로 매겨서 사원명,급여,순위 조회 : RANK() OVER()
SELECT EMP_NAME,SALARY,RANK()OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;

SELECT EMP_NAME,SALARY,DENSE_RANK()OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
WHERE RANK() OVER(ORDER BY SALARY DESC) <=5; --RANK함수는 WHERE에서 사용 불가

--인라인뷰 사용
SELECT *
FROM (SELECT EMP_NAME,SALARY,RANK()OVER(ORDER BY SALARY DESC) 순위
        FROM EMPLOYEE)
WHERE 순위 <=5;