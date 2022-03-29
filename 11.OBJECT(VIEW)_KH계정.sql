/*

    OBJECT
    데이터베이스를 이루는 논리적인 구조물들
    
    OBJECT의 종류
    -TABLE,USER,VIEW,SEQUENCE,INDEX,PACKAGE,TRIGGER,FUNCTION,PROCEDURE
    
    <VIEW>
    SELECT를 저장해둘수있는 객체
    (자주 사용할 SELECT 문을 VIEW에 담아놓고 사용하면 매번 긴 SELECT문을 작성할 필요가 없어진다.
    -> 조회용 임시테이블(실제로 값이 담겨있는것이 아니다)
    
    1.VIEW 생성 방법
    [표현법]
    CREATE VIEW 뷰명 AS 서브쿼리;
    
    CREATE OR REPLACE VIEW 뷰명
    AS 서브쿼리;
    ->뷰 생성시 기존에 중복된 이름의 뷰가 없다면 새롭게 생성하고 중복된 이름이 있다면 해당 뷰에 덮어쓰기(갱신)한다.
    -OR REPLACE 옵션은 생략가능
*/

--'한국'에서 근무하는 사원들의 사번,이름,부서명,급여,근무국가명,직급명을 조회하시오

SELECT EMP_NO,EMP_NAME,E.SALARY,D.DEPT_TITLE,N.NATIONAL_NAME,J.JOB_NAME
FROM EMPLOYEE E,NATIONAL N,DEPARTMENT D,JOB J,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND J.JOB_CODE =E.JOB_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND N.NATIONAL_CODE = L.NATIONAL_CODE
AND NATIONAL_NAME ='한국';

CREATE VIEW VM_EMPLOYEE
AS SELECT EMP_NO,EMP_NAME,E.SALARY,D.DEPT_TITLE,N.NATIONAL_NAME,J.JOB_NAME
FROM EMPLOYEE E,NATIONAL N,DEPARTMENT D,JOB J,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND J.JOB_CODE =E.JOB_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND N.NATIONAL_CODE = L.NATIONAL_CODE;

DROP VIEW VM_EMPLOYEE;
--위에 코드를 VM+EMPLOYEE로 조회해보기

SELECT * FROM VM_EMPLOYEE WHERE NATIONAL_NAME='한국';

--VIEW "insufficient privileges" 생성 권한 오류

--VIEW 생성 권한 부여하기
GRANT CREATE VIEW TO KH;

SELECT * FROM VM_EMPLOYEE;

--러시아에 근무하는 사원들의 사번,이름,직급명,급여,보너스
SELECT *
FROM VM_EMPLOYEE;

CREATE VIEW VM_EMPLOYEE
AS SELECT EMP_NO,EMP_NAME,E.SALARY,D.DEPT_TITLE,N.NATIONAL_NAME,J.JOB_NAME,E.BONUS
FROM EMPLOYEE E,NATIONAL N,DEPARTMENT D,JOB J,LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID
AND J.JOB_CODE =E.JOB_CODE
AND D.LOCATION_ID=L.LOCAL_CODE
AND N.NATIONAL_CODE = L.NATIONAL_CODE;

SELECT * FROM USER_VIEWS;

/*
    뷰 컬럼에 별칭 부여하기
    서브쿼리 부분에 SELECT 절에 함수나 산술연산식이 기술되어 있는 경우 반드시 별칭 지정
    
*/

-- 사원의 사번,이름,직급명,성별,근무년수를 조회할 수있는 SELECT문을 VIEW로 정의해보자.

CREATE VIEW VM_EMP_JOB
AS SELECT EMP_ID
        ,EMP_NAME
        ,JOB_NAME
        ,DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') 성별
        ,EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) 근무년수
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE); --서브쿼리 부분에 SELECT절에 함수나 산술연산식이 기술되어 잇는 경우 반드시 별칭 지정
        
SELECT * FROM VM_EMP_JOB;

--다른 방법으로 별칭 지어주기 (주의-모든 컬럼에 대해서 별칭을 기술해야한다.)
CREATE OR REPLACE VIEW VM_EMP_JOB(사번,사원명,직급명,성별,근무년수)
AS SELECT EMP_ID
        ,EMP_NAME
        ,JOB_NAME
        ,DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') 성별
        ,EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) 근무년수
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
        
SELECT 사번,사원명,성별
FROM VM_EMP_JOB;

SELECT *
FROM VM_EMP_JOB
WHERE 근무년수>=20;

DROP VIEW VM_EMP_JOB;

/*
    생성된 뷰에 DML 구문을 사용해보자
    INSERT,DELETE,UPDATE
    주의사항) VIEW를 통해서 조작하게 된다면 실제 데이터가 담겨있던 기준테이블에 변경사항이 적용된다.
    
*/

CREATE VIEW VW_JOB
AS SELECT * FROM JOB;

SELECT * FROM JOB;
SELECT * FROM VW_JOB;

--뷰에 INSERT
INSERT INTO VW_JOB
VALUES('J8','인턴');

UPDATE VW_JOB
SET JOB_NAME='알바'
WHERE JOB_CODE = 'J8'; 

DELETE FROM VW_JOB 
WHERE JOB_CODE='J8';

/*
    VIEW에 DML이 가능한 경우 : 서브쿼리를 이용해서 기존의 테이블을 별도의 처리없이 복제하고자 할 경우.
    
    * 불가능한 경우 : 한번이라도 처리가 들어간 구문은 DML이 불가능하다.
    1)뷰에 정의되지 않은 컬럼을 조작하려는 경우
    2)뷰에 정의되어 있지 않은 컬럼중에 베이스테이블 상에 NOT NULL 제약조건이 지정된 경우
    3)산술연산식 또는 함수식으로 작성되어 정의된 경우
    4)그룹함수나 GROUP BY절이 포함된 경우
    5)DISTINCT 구문이 포함된 경우
    6)JOIN 을 이용해서 여러테이블을 매칭시킨 경우
    
*/

--2)뷰에 정의되어 있지 않은 컬럼중에 베이스테이블 상에 NOT NULL 제약조건이 지정된 경우
CREATE  OR REPLACE  VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;

--INSERT
INSERT INTO VW_JOB VALUES('J9'); --(NULL,'인턴') 처럼 들어가려고 했는데 NOT NULL 제약조건이 걸려있다.



CREATE VIEW VM_학생일반정보
AS SELECT STUDENT_NO,STUDENT_NAME,STUDENT_ADDRESS
FROM TB_STUDENT;

SELECT *FROM VM_학생일반정보;

DROP VIEW VM_지도면담;

CREATE VIEW VM_지도면담
AS SELECT STUDENT_NAME ,DEPARTMENT_NAME,PROFESSOR_NAME
FROM TB_PROFESSOR P,TB_STUDENT S,TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO(+)
AND S.COACH_PROFESSOR_NO=P.PROFESSOR_NO(+)
ORDER BY DEPARTMENT_NAME;

SELECT * FROM VM_지도면담;


CREATE VIEW VW_학과별학생수(시발 ,왜안돼)
AS SELECT DEPARTMENT_NAME,COUNT(*)
FROM TB_DEPARTMENT
LEFT JOIN TB_STUDENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

SELECT * FROM VW_학과별학생수;


UPDATE VM_학생일반정보
SET STUDENT_NAME='본인이름'
WHERE STUDENT_NO='A213046';

CREATE OR REPLACE VIEW VM_학생일반정보
AS SELECT *FROM VM_학생일반정보;

--WITH READ ONLY 구문으로 작성하기(조회만 가능하고 추가,수정,삭제)

--VIEW 옵션
--FORCE/NOFORCE - NOFORCE가 기본옵션 (기준테이블이나 컬럼이 없으면 뷰 생성 불가)
-- FORCE : 기준 테이블이나 컬럼이 없어도 뷰 생성 가능
/*
    [표현법]
    CREATE FORCE VIEW 뷰명
*/
CREATE OR REPLACE FORCE VIEW VW_TEST
AS SELECT * FROM TB_TSET;

SELECT * FROM VW_TEST;
-- 뷰는 생성되었지만 기준테이블이 없기때문에 조회불가

CREATE TABLE TB_TEST(
    TB_ID NUMBER
    ,TB_NAME VARCHAR2(20)
    );
    
    SELECT * FROM TB_TEST;