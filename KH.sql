/*전부 열결되서 보여주는 식*/
SELECT EMP_ID||EMP_NAME||SALARY AS "연결됨"
FROM EMPLOYEE;

/*
연산자 우선순위

1. 산술연산자
2. 연결연산자
3. 비교연산자
4. IS NULL, LIKE, IN
5. BETWEEN AND
6. NOT
7. AND
8. OR
*/

/*
    <ORDER BY>
    SELECT문 가장 마지막에 기입하는 구문뿐 아니라 가장 마지막에 실행되는 구문
    최종 조회된 결과물에 대해서 정렬 기준을 세워주는 구문
    
    [표현법]
    SELECT 조회 할 컬럼...
    FROM 조회할 테이블..
    WHERE 조건식...(생략가능)
    ORDER BY [정렬기준으로 정렬하고자하는 컬럼명/별칭] [ASC/DESC](생략가능) [NULLS FIRST/NULLS LAST](생략 가능)
    
    오름차순/내림차순
    - ASC :  오름차순 (생략했을때 기본 값)
    - DESC : 내림차순
    
    정렬하고자 하는 컬럼값에 NULL이 있을 경우
    - NULL FRIST : 해당 NULL값들을 먼저 보여주겠다. (내림차순일 경우에 기본값)
    - NULL LAST : 해당 NULL값들을 나중에 보여주겠다. (오름차순일 경우에 기본값)
    

*/
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- 연봉 기준 정렬
SELECT EMP_NAME,SALARY,(SALARY*12) "연봉"
FROM EMPLOYEE
ORDER BY "연봉" ASC;

--문자열도 정렬가능
SELECT EMP_NAME
FROM EMPLOYEE
ORDER BY EMP_NAME;

--날짜도 정렬가능
SELECT HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE;

--연산자 우선순위 예시
--J2 또는 J7 직급 코드 중 급여를 200만원보다 많이 받는 직원의 이름,급여,직급코드 조회
SELECT EMP_NAME,SALARY,JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE='J2') AND SALARY>=2000000;