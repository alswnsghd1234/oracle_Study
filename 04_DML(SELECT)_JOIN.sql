/*

    <JOIN>
    두개 이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용하는 구문 -> SELECT문 이용
    조회 겨로가는 하나의 결과물(RESULT SET)으로 나온다
    JOIN을 해야하는 이유?
    관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있음
    사원정보는 사원테이블, 직급정보는 직급테이블 ...등등 ->중복을 최소화하기 위해
    -> 즉, JOIN을 이용해서 여러개의 테이블 간의 관계를 맺어서 사용한다
    -> 무작정 JOIN을 하는것이 아니라 테이블 간의 연결고리(컬럼)를 매칭시켜서 조회해야한다.
    
    문법상 분류 : JOIN은 크게 "오라클 전용 구문" 과 "ANSI(미국 국립 표준 협회)구문"으로 나뉜다.
    
    개념상 분류
    오라클 전용 구문           |        ANSI구문(오라클+다른 DBMS)
    ==========================================================
    등가조인(EQUAL JOIN)      |        내부조인(INNER JOIN) -> JOIN USING/ON
    --------------------------------------------------------------------------
    포괄조인                  |        외부조인(OUTER JOIN) -> JOIN USING
    (LEFT OUTER JOIN)        |        왼쪽 외부조인 (LEFT OUTER JOIN)
    (RIGHT OUTER JOIN)       |        오른쪽 외부조인 (RIGHT OUTER JOIN)
                             |        전체 외부조인 (FULL OUTER JOIN)
--------------------------------------------------------------------------------
    카테시안 곱(CARTESIAN PRODUCT)|     교차 조인(CROSS JOIN)
    -------------------------------------------------------------------------
    자체조인(SELF JOIN)       
    비등가조인(NON EQUAL JOIN)
    -------------------------------------------------------------------------
    +다중조인(테이블 3개이상 조인)

*/

--JOIN을 사용하지 않은 예
--전체 사원들의 사번,사원명,부서코드,부서명까지 알아내고 싶다.

SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT;

--전체 사원들의 사번,사원명,직급코드,직급명까지 알아내고 싶다.
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE,JOB_NAME
FROM JOB;

/*
    1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
    연결시키고자 하는 컬럼의 값이 "일치하는 행들만" 조인되어 조회
    = 일치하지 않는 값들은 결과에서 제외된다.
    -> 동등비교연산자 = ("일치한다" 라는 조건을 제시)
    
    [표현법]
    등가조인(오라클 구문)
    SELECT 조회하고자하는 컬럼명 나열
    FROM 조회하고자 하는 테이블명들 나열
    WHERE 연결할 컬럼에 대한 조건을 제시("=")
    
    내부조인(ANSI 구문) : ON구문
    SELECT 조회하고자하는 컬럼명 나열
    FROM 기준으로 삼을 테이블명 1개 제시
    JOIN 조인 할 테이블명 1개 제시 ON (연결할 컬럼에 대한 조건 제시 ("=")
    
    내부조인(ANSI 구문):USING구문
    SELECT 조회하고자하는 컬럼명 나열
    FROM 기준으로 삼을 테이블명 1개 제시
    JOIN 조인할 테이블명 1개 제시 USING(연결할컬럼명 1개제시)
    *연결할 컬럼명이 동일하다면 USING구문을 제외하고 명시적으로 어느 테이블의 컬럼명인지 적어줘야함
        (테이블명 또는 별칭)

*/

--오라클 전용구문
--FROM절에 조회하고자 하는 테이블들을 나열 (,로)
--WHERE절에 매칭시킬 컬럼명(연결고리)에 대한 조건을 제시

--전체 사원들의 사번,사원명,부서코드,부서명까지 알아내고자 한다면?
--1)연결할 두 컬럼명이 다를경우 EX)EMPLOYEE-'DEPT_CODE' / DEPARTMENT - 'DEPT_ID')

SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; --DEPT_CODE와 DEPT_ID가 동일하다면
-->일치하지 않는 값은 조회되지 않음(NULL,D3,D4,D7인 경우에는 조회안됨)

--2)연결할 두 컬럼명이 같을 경우 EX)EMPLOYEE-'JOB_CODE' /JOB-'JOB_CODE'
--전체 사원들의 사번,사원명,직급코드,직급명까지 알아내기
--SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
--FROM EMPLOYEE,JOB
--WHERE JOB_CODE=JOB_CODE; -- 구문오류(애매하다 모호하다)어떤 테이블에 컬럼인지 명시를 해줘야한다

--방법1) 테이블명을 붙여서 명시한다 [표현법] 테이블명.컬럼명
SELECT EMP_ID,EMP_NAME,EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE,JOB
WHERE EMPLOYEE.JOB_CODE=JOB.JOB_CODE;

--방법2) 별칭을 붙여서 명시한다. [표현법]별칭.컬럼명
SELECT EMP_ID,EMP_NAME,E.JOB_CODE,JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE;

-->ANSI 구문
--FROM 절에 기준 테이블을 '하나만' 기술 한뒤
--그 뒤에 JOIN절에서 같이 조회하고자 하는 테이블 기술, 또한 매칭시킬 컬럼에 대한 조건도 같이 작성
--USING / ON 구문

--전체 사원들의 사번,사원명,부서코드,부서명까지 알아내고자 한다.
--1)연결할 두 컬럼이 다를 경우 EX)EMPLOYEE-'DEPT_CODE' / DEPARTMENT-'DEPT_ID'
--다를 경우 ON 구문을 사용해야한다
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE
/*INNER*/JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID); --INNER생략가능

--전체사원들의 사번,사원명,직급코드,직급명까지 알아내보자.
--2)연결할 두 컬럼이 같을 경우 EX)EMPLOYEE-'JOB_CODE' / JOB-'JOB_CODE'
--ON과 USING 둘 다 사용가능
--ON구문
SELECT EMP_ID,EMP_NAME,E.JOB_CODE,JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE);
--USING 구문 --- 단 연결할 컬럼명이 같을경우
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE); --컬럼명이 같아서 어떤 테이블 컬럼인지 명시해주지 않다도 알아서 매칭 시켜줌

--[참고] 자연조인(NATURAL JOIN): 등가조인 방법중 하나
--> 동일한 타입과 이름을 가진 컬럼을 조인 조건으로 이용하는 방법
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;
--두개의 테이블에 일치하는 컬럼이 단 한개만 존재할 경우 알아서 매칭이 된다.

-- 조인 시 조건제시도 가능
-- 직급이 대리인 사원들의 정보를 조회(사번,사원명,월급,직급(직급명))

-- 오라클 구문
SELECT EMP_ID,EMP_NAME,SALARY,JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND JOB_NAME='대리';

--ANSI구문
SELECT EMP_ID,EMP_NAME,SALARY,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME='대리';
--------------실습 문제------------

-- 오라클 구문
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND DEPT_TITLE='인사관리부';

--ANSI구문
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE='인사관리부';

-- 오라클 구문
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID
AND NOT DEPT_TITLE='총무부';

--ANSI구문
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE!='총무부';

-- 오라클 구문
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID
AND BONUS IS NOT NULL;

--ANSI구문
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE BONUS IS NOT NULL;

--4.아래의 두 테이블을 참고해서 부서코드,부서명,지역코드,지역명 조회
SELECT* FROM DEPARTMENT;
SELECT*FROM LOCATION;

-->오라클 구문
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT,LOCATION
WHERE LOCATION_ID=LOCAL_CODE;
-->ANSI 구문
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE);

--등가조인/내부조인 : 일치하지 않은 행들은 조회되지 않음

--------------------------------------------------

--전체 사원들의 사원명, 급여, 부서명
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--DEPT_CODE가 NULL 사원 두명은 조회되지 않음
-- 부서배치를 못받은 사원도 조회되지 않음
--부서는 있는데 아무도 배정받지 않은 부서는 조회되지 않음 (D3,D4,D7)
SELECT * FROM EMPLOYEE;

/*
    2.포괄조인 / 외부조인(OUTER JOIN)
    테이블간의 JOIN시에 "일치하지 않는 행도" 포함시켜서 조회가능
    단,반드시 LEFT/RIGHT 를 지정해야 함. -> 기준이 되는 테이블을 지정해야한다.
    일치하는 행 + 기준이 되는 테이블 기준으로 일치하지 않는 행도 포함시켜서 조회
*/

/*
전체 사원들의 사원명,급여,부서명
1)LEFT OUTER JOIN : 두 테이블 중에 왼편에 기술한 테이블을 기준으로 JOIN
                    즉, 데이터값이 뭐가 됐든 외편에 기술된 테이블의 데이터는 무조건 조회하게 된다.
                    (일치하지 않아도 조회)

*/
--ANSI 구문
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID); 
--EMPLOYEE 테이블이 기준이 되었기 때문에 EMPLOYEE테이블에 존재하는 데이터를 다 조회해온다.

--오라클 구문=D
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);
--> 내가 기준으로 삼을 테이블의 컬럼명이 아니라 반대 테이블의 컬럼명에 (+)를 붙여준다

--2) RIGHT OUTER JOIN : 두 테이블중 오른편에 기술된 테이블을 기준으로 JOIN
--                        즉,데이터값이 뭐가 됐든 오른편에 기술된 테이블의 무조건 조회하게 된다.
--                        (일치하지 않아도 조회)
-- >ANSI 구문
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

-->오라클 구문
SELECT EMP_NAME,SALARY,DEPT,TITLE
FROM EMPLOYEE,DEPARTMEN;
/*

    4.비등가 조인 (NON EQUAL JOIN)
    '='등호를 사용하지 않은 조인문
    
*/
--사원명,급여
SELECT EMP_NAME,SALARY
FROM EMPOYEE;

--SAL GRADE 테이블 조회
SELECT *
FROM SAL_GRADE;

--사원명,급여,급여등급(SAL_LEVEL)
-->오라클구문
SELECT EMP_NAME,E.SALARY,S.SAL_LEVEL
FROM EMPLOYEE E,SAL_GRADE S
--WHERE E.SALARY >= S.MIN_SAL AND E.SALARY <= S.MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->ANSI
SELECT EMP_NAME,SALARY,S.SAL_LEVEL
FROM EMPLOYEE E
--JOIN SAL_GRADE S ON (SALARY>=MIN_SAL AND SALARY<=MAX_SAL);
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

/*
    5.자체조인(SELF JOIN)
    
    같은 테이블끼리 조인하는 경우
    즉, 자기 자신과 조인하겠다
    -> 자체 조인의 경우 테이블에 반드시 별칭을 붙여줘야한다. (서로 다른 테이블인것처럼 조인하겠다)
*/

SELECT * FROM EMPLOYEE E; --사원에 대한 정보를 추출할 테이블
SELECT * FROM EMPLOYEE M; --사수에 대한 정보를 추출할 테이블

--사원의 사번, 사원명, 사수의 사번,사수명
-->오라클 구문
SELECT E.EMP_ID 사번,E.EMP_NAME 사원명,E.MANAGER_ID 사수사번,M.EMP_NAME 사수명
FROM EMPLOYEE E,EMPLOYEE M
WHERE E.MANAGER_ID=M.EMP_ID(+); --LEFT OUTER JOIN

-->ANSI 구문
SELECT E.EMP_ID 사번,E.EMP_NAME 사원명,E.MANAGER_ID 사수사번,M.EMP_NAME 사수명
FROM EMPLOYEE E
LEFT OUTER JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

/*
    <다중조인>
    
    3개 이상의 테이블을 조인해서 조회하겠다.
    조인 순서가 중요하다.
*/
--사번,사원명,부서명,직급명
--일단 각 테이블을 따로 조회해보자
SELECT *FROM EMPLOYEE; --EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
SELECT * FROM DEPARTMENT;   --DEPT_ID,DEPT_TITLE
SELECT * FROM JOB;                 --JOB_CODE,JOB_NAME

--합쳐보자
-->오라클 구문
SELECT EMP_ID 사번,EMP_NAME 사원명,DEPT_TITLE 부서명,JOB_NAME 직급명
FROM EMPLOYEE E , DEPARTMENT D,JOB J
WHERE E.DEPT_CODE=D.DEPT_ID(+)
AND E.JOB_CODE=J.JOB_CODE(+);

-->ANSI구문
SELECT EMP_ID 사번,EMP_NAME 사원명,DEPT_TITLE 부서명,JOB_NAME 직급명
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE);

------------실습 문제--------------


SELECT EMP_ID ,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE E ,LOCATION L,NATIONAL N,DEPARTMENT D
WHERE L.NATIONAL_CODE=N.NATIONAL_CODE(+)
AND D.LOCATION_ID=L.LOCAL_CODE(+)
AND E.DEPT_CODE=D.DEPT_ID(+);


SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID=L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE=N.NATIONAL_CODE);

SELECT EMP_ID ,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME,S.SAL_LEVEL
FROM EMPLOYEE E ,LOCATION L,JOB J,NATIONAL N,DEPARTMENT D,SAL_GRADE S
WHERE L.NATIONAL_CODE=N.NATIONAL_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND E.DEPT_CODE=D.DEPT_ID
AND E.JOB_CODE=J.JOB_CODE
AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;

--ANSI

SELECT EMP_ID ,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME,S.SAL_LEVEL
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE)
LEFT JOIN LOCATION L ON(D.LOCATION_ID=L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE=N.NATIONAL_CODE)
LEFT JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);
---------------------- JOIN 종합 실습문제 ----------------------
-- 1. 직급이 대리이면서 ASIA 지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
-->> 오라클 전용 구문
SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE,NATIONAL_NAME,SALARY
FROM EMPLOYEE E,JOB J,DEPARTMENT D,LOCATION L,NATIONAL N
WHERE E.JOB_CODE=J.JOB_CODE
AND   E.DEPT_CODE=D.DEPT_ID
AND   D.LOCATION_ID=L.LOCAL_CODE
AND   L.NATIONAL_CODE=N.NATIONAL_CODE
AND   J.JOB_NAME ='대리'
AND   L.LOCAL_NAME LIKE 'ASIA%';
-->> ANSI 구문
SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE,NATIONAL_NAME,SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID=L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE=N.NATIONAL_CODE)
WHERE J.JOB_NAME='대리'
AND   L.LOCAL_NAME LIKE 'ASIA%';
-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--   사원명, 주민번호, 부서명, 직급명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_NAME,EMP_NO,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE E,DEPARTMENT D,JOB J
WHERE E.DEPT_CODE=D.DEPT_ID
AND   E.JOB_CODE=J.JOB_CODE
AND   SUBSTR(EMP_NO,1,2) LIKE '7%'
AND   SUBSTR(EMP_NO,8,1) ='2'
AND   EMP_NAME LIKE '전%';
-->> ANSI 구문
-- 3. 이름에 '형'자가 들어있는 직원들의 
--    사번, 사원명, 직급명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_ID,EMP_NAME,JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND EMP_NAME LIKE ('%형%');
-->> ANSI 구문
-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_NAME,JOB_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE E,JOB J,DEPARTMENT D
WHERE E.JOB_CODE=J.JOB_CODE
AND   E.DEPT_CODE=D.DEPT_ID
AND  D.DEPT_TITLE LIKE ('해외영업%');
-->> ANSI 구문
-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
SELECT EMP_NAME,BONUS,(SALARY*12) 연봉,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND D.LOCATION_ID=L.LOCAL_CODE
AND BONUS IS NOT NULL;
-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오
SELECT EMP_NAME,JOB_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,JOB J,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND   E.JOB_CODE=J.JOB_CODE
AND   D.LOCATION_ID=L.LOCAL_CODE;
-- 7. '한국' 과 '일본' 에 근무하는 직원들의
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오
SELECT EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE E,DEPARTMENT D,LOCATION L,NATIONAL N
WHERE E.DEPT_CODE=D.DEPT_ID
AND   D.LOCATION_ID=L.LOCAL_CODE
AND   L.NATIONAL_CODE=N.NATIONAL_CODE
AND   N.NATIONAL_NAME IN ('한국','일본');
-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7 인 직원들의
--    사원명, 직급명, 급여를 조회하시오
SELECT EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE
AND  E.BONUS IS NULL
AND  E.JOB_CODE IN ('J4','J7');
-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이 때, 구분에 해당하는 값은
--    급여등급이 S1, S2 인 경우 '고급'
--    급여등급이 S3, S4 인 경우 '중급'
--    급여등급이 S5, S6 인 경우 '초급' 으로 조회되게 하시오
SELECT EMP_ID,EMP_NAME,JOB_NAME,SAL_LEVEL
        ,CASE WHEN SAL_LEVEL IN ('S1','S2') THEN '고급'
        WHEN SAL_LEVEL IN('S3','S4') THEN '중급'
        WHEN SAL_LEVEL IN('S5','S6') THEN '초급'
        END 구분
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE;
-- 10. 각 부서별 총 급여합을 조회하되
--     이 때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오
SELECT DEPT_TITLE,SUM(SALARY)급여합
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)>=10000000;
--ANSI
SELECT DEPT_TITLE,SUM(SALARY)급여합
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;
-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리) 로 조회하시오
--     단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오(컬럼값은 부서미지정 으로 나오도록)
SELECT NVL(DEPT_TITLE,'부서미지정') 부서명,FLOOR(AVG(SALARY)) 평균급여
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID(+)
GROUP BY DEPT_TITLE;
















