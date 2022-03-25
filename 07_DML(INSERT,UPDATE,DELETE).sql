/*

    DML (DATA MANIPULATION LANGUAGE)
    데이터 조작언어
    테이블에 새로운 데이터를 삽입(INSERT)하거나
    기존의 데이터를 수정(UPDATE)하거나
    삭제(DELETE) 하는 구문.
    

*/

/*

    1.INSERT : 테이블에 새로운 "행"을 추가하는 구문
    [표현볍]
    INSERT INTO 계열
    
    1)INSERT INTO 테이블명 VALUES(값1,값2,값3..)
    ->해당 테이블에 "모든"컬럼에 대해 추가하고자 하는 값을 내가 직접 제시해서
    한 행을 INSERT하고자 할 때 사용하는 표현법
    주의사항 : 컬럼의 순서,자료형 개수를 맞춰서 VALUES괄호 안에 값을 나열해야한다.
    부족하게 값을 제시했을경우 : NOT ENOUGH VALUE 오류
    값을 더 많이 제시할 경우 : TOO MANY VALUES 오류
    
    2)INSERT INTO 테이블명(컬럼명1,컬럼명2,컬럼명3) VALAUES (값1,값2,값3);
    ->해당 테이블에 특정 컬러만 선택해서 추가할 값을 제시하고자 할때 사용
    - 선택되지 않은 컬럼은 기본값인 NULL이 들어간다
    - 단, DEFAULT 설정이 되어있을경우 DEFAULT 설정값이 들어간다.(기본값 설정)
    
    주의 : NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값을 넣어야한다.
    -단, DEFAULT 설정이 되어있다면 NOT NULL이라고해도 선택 안해도 된다. (DEFAULT값이 기본값이 되기때문에)
    
    
*/

--EMPLOYEE 테이블에 사원 정보 추가해보기

INSERT INTO EMPLOYEE VALUES(000,'구구구','902302-232321','DKDMDD@DSFD.COM',
                            '01034341231','D1','J7','S6',1999999,0.9,200,SYSDATE
                            ,NULL,DEFAULT);
                            
SELECT * FROM EMPLOYEE;                            

/*
    3)INSERT INTO 테이블명 (서브쿼리)
    -> VALUES()로 값을 직접 기입하는것이 아니라
    서브쿼리로 조회한 결과값을 통째로 INSERT하는 구문
    즉, 여러행을 한번에 INSERT 할 수있다.
    
*/

--새로운 테이블 만들기
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR(20)
    );
    
SELECT *
FROM EMP_01;

-- 전체 사원들의 사번, 이름, 부서명을 조회한 결과를 EMP_01 테이블에 통째로 추가
--1) 조회
SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);

--2)조회한 결과 INSERT 해보기
INSERT INTO EMP_01 (
        SELECT EMP_ID,EMP_NAME,DEPT_TITLE
        FROM EMPLOYEE, DEPARTMENT
        WHERE DEPT_CODE=DEPT_ID(+)
        );
        
SELECT * FROM EMP_01;

--EMP_011 테이블을 만들고 컬럼은 사원명,직급명
CREATE TABLE EMP_011(
    EMP_ID NUMBER,
    JOB_CODE VARCHAR2(30),
    BONUS VARCHAR(20)
    );

INSERT INTO EMP_011(
        SELECT EMP_ID,JOB_CODE,BONUS
        FROM EMPLOYEE
        );

DROP TABLE EMP_011;

/*
    INSERT ALL 계열
    두개 이상의 테이블에 각각 INSERT할때 사용
    조건 : 그 때 사용되는 서브쿼리가 동일해야한다.
    1)INSERT ALL
    INTO 테이블명1 VALUES(컬럼명,컬럼명..)
    INTO 테이블명2 VALUES(컬럼명,컬럼명..)
    서브쿼리;
*/

--새로운 테이블 만들기
--1)급여가 300만원 이상인 사원들의 사번,사원명,직급명 보관할 테이블
DROP TABLE EMP_JOB;
CREATE TABLE EMP_JOB 
AS SELECT EMP_ID,EMP_NAME,JOB_NAME
    FROM EMPLOYEE E, JOB J
    WHERE E.JOB_CODE=J.JOB_CODE
    AND 1=0;

SELECT * FROM EMP_JOB;

--2)급여가 300만원 이상인 사원들의 사번,사원명,부서명 보관할 테이블

CREATE TABLE EMP_DEPT 
AS SELECT EMP_ID,EMP_NAME,DEPT_TITLE
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE=D.DEPT_ID
    AND 1=0;

SELECT * FROM EMP_DEPT;


INSERT ALL
    INTO EMP_JOB VALUES(EMP_ID,EMP_NAME,JOB_NAME)
    INTO EMP_DEPT VALUES(EMP_ID,EMP_NAME,DEPT_TITLE)
    SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
    FROM EMPLOYEE E ,JOB J,DEPARTMENT
    WHERE E.JOB_CODE=J.JOB_CODE
    AND DEPT_CODE=DEPT_ID
    AND SALARY >= 3000000;
    
SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

--사원 아이디 이름 주민번호 직급명을 담을 수 있는 테이블
CREATE TABLE EMP_JOB_NAME
AS SELECT EMP_ID,EMP_NAME,JOB_NAME
    FROM EMPLOYEE E, JOB J
    WHERE E.JOB_CODE=J.JOB_CODE
    AND 1=0;

SELECT * FROM EMP_JOB;

--사원 아이디 주민번호 부서명 급여를 담을 수 잇는 테이블
CREATE TABLE EMP_DEPT_TITLE
AS SELECT EMP_ID,EMP_NAME,DEPT_TITLE
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE=D.DEPT_ID
    AND 1=0;
-- 만들고 그 중 여자인 사원들의 정보만 넣어보시오.
INSERT ALL
    INTO EMP_JOB_NAME VALUES(EMP_ID,EMP_NAME,JOB_NAME)
    INTO EMP_DEPT_TITLE VALUES(EMP_ID,EMP_NAME,DEPT_TITLE)
    SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
    FROM EMPLOYEE E ,JOB J,DEPARTMENT
    WHERE E.JOB_CODE=J.JOB_CODE
    AND DEPT_CODE=DEPT_ID
    AND SUBSTR(EMP_NO,8,1)='2';
    
/*
    2)INSERT ALL
    WHEN 조건1 THEN
        INTO~
    WHEN 조건2 TEHN 
        INTO~
    서브쿼리;
    -조건에 맞는 값들만 넣겠다.

*/

--2010년도 기준으로 이전에 입사한 사원의 사번,사원명,입사일,급여를 담는 테이블
CREATE TABLE EMP_OLD
AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 0=1;
SELECT * FROM EMP_OLD;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 0=1;
SELECT * FROM EMP_NEW;

--1)서브쿼리로 입력할 부분
--2010년 이후,이전
SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
FROM EMPLOYEE
WHERE HIRE_DATE<'/2010/01/01'; -- 2010년 이전 입사자
--WHERE HIRE_DATE>/'2010/01/01'; -- 2010년 이후 입사자

INSERT ALL
WHEN HIRE_DATE<'2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
WHEN HIRE_DATE>='2010/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
    SELECT *
    FROM EMPLOYEE; -- 서브쿼리에서 전체조회해도 되는지
    
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

CREATE TABLE TEST01(
    NO NUMBER;
    STR VARCHAR2(30),
    STR2 VARCHAR2(40)
    
/*
    2.UPDATE
    테이블에 기록된 기존의 데이터를 수정하는 구문
    UPDATE 테이블명
    SET 컬럼명=변경값,컬럼명=변경값,.... --여러개의 컬럼값을 동시변경 가능 (,로 나열한다)
    WHERE 조건; --WHERE 절은 생략가능하지만 생략하면 모든 행에 데이터가 변경되니 주의해야한다.
    
*/

--복사본 테이블 만들어서 진행
CREATE TABLE DEPT_COPY
AS SELECT *
    FROM DEPARTMENT;
    
SELECT * FROM DEPT_COPY;
--DEPT_COPY 테이블에서 D9부서의 부서명을 전략기획틈으로 변경하기
UPDATE DEPT_COPY
SET DEPT_TITLE='전략기획팀'
WHERE DEPT_ID='D9';
--WHERE절을 생략하면 모든 행의 데이터가 변경된다
ROLLBACK; --변경 사항에 대해 되돌리는 명령어(DML한정(INSERT,DELETE,UPDATE)) 마지막 커밋 위치로 간다

--복사본 테이블 만들기
--테이블명 EMP_SALARY / 컬럼 : EMPLOYEE테이블로부터 EMP_ID,EMP_NAME,DEPT_CODE,SALARY,BONUS 데이터까지 복사
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY,BONUS FROM EMPLOYEE;

--EMP_SALARY테이블에서 노옹철 사원의 급여를 1000만원으로 변경
UPDATE EMP_SALARY
SET SALARY = '10000000'
WHERE EMP_NAME='노옹철';

--EM_SALARY테이블에서 선동일 사원의 급여를 700만원 보너스를 0.2로 변경
UPDATE EMP_SALARY
SET SALARY = '70000000' , BONUS ='0.2'
WHERE EMP_NAME='선동일';

SELECT * FROM EMP_SALARY;

--전체사원의 급여를 기존의 급여에 인상한 금액으로 변경하시오
UPDATE EMP_SALARY
SET SALARY=(SALARY*1.2);

/*

    UPDATE에 서브쿼리 사용
    서브쿼리를 수행한 결과값으로 기존의 값을 변경하겠다.
    
    -CREATE시에 서브쿼리 사용 : 서브쿼리를 수행한 결과를 테이블에 넣겠다.
    -INSERT시에 서브쿼리 사용 : 서브쿼리를 수행한 결과를 해당 테이블에 삽입하겠다.
    
*/

--EMP_SALARY 테이블명에 방명수 사원의 부서코드를 선동일 사원의 부서코드로 변경
--방명수 D1 선동일 D9
--1)선동일 사원의 부서코드를 조회하기
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='선동일';

--2)방명수 사원의 부서코드를 선동일 사원의 부서코드로 변경 -D9
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='선동일')
WHERE EMP_NAME='방명수';

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='방명수';

--방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스값으로 변경
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY,BONUS
FROM EMP_SALARY
WHERE EMP_NAME='유재식')
WHERE EMP_NAME='방명수';

--EMPLOYEE에서 송종기 사원의 사원번호 200으로 변경
UPDATE EMPLOYEE
SET EMP_ID=200
WHERE EMP_NAME='송종기'; --unique constraint (KH.EMPLOYEE_PK) violated
--PRIMARY KEY 제약조건 위배 오류

SELECT * FROM EMPLOYEE

--EMP_ID 가 200인 사원의 이름을 NULL로 변경
UPDATE EMPLOYEE
SET EMP_NAME=NULL
WHERE EMP_ID=200; --NOT NULL 제약조건 위배 오류

--UPDATE 구문으로 변경할때 제약조건을 위배할 수 없음

/*
    4.DELETE
    테이블에 기록된 데이터를 "행"단위로 삭제하는 구문
    [표현법]
    DELETE FROM 테이블명
    WHERE 조건; --WHERE절은 생략이 가능하지만 생략시에 모든행이 삭제된다.
    
*/
--EMPLOYEE 테이블의 모든 행 삭제
DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

--0개 행 조회
--데이터가 다 지워진것뿐 테이블이 삭제되진 않음
ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_NAME IN ('구구구');
COMMIT;
--DEPARTMENT 테이블에서 DEPT_ID = D1 부서 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID='D1';

SELECT * FROM DEPARTMENT;
ROLLBACK;

/*
    TRUNCATE
    테이블의 전체 행을 모두 삭제 할 때 사용하는 구문
    DELETE 구문보다 속도가 빠르다
    별도의 조건 제시불가
    ROLLBACK이 안되기때문에 주의해야한다.
    [표현법]
    TRUNCATE TABLE 테이블명;
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;




