/*

    DDL (DATA DEFINITION LANGUAGE) :데이터 정의 언어
    
    오라클에서 제공하는 객체(OBJECT)를
    새롭게 만들고(CREATE),구조를 변경하고(ALTER),삭제(DROP)하는 명령문
    즉, 구조 자체를 정의하는 언어로 DB관리자, 설계자가 사용한다.
    
    오라클에서의 객체(DB를 이루는 구조물들)
    테이블(TABLE),사용자(USER),함수(FUNCTION),뒤(VIEW)..등등
    
    <CREATE TABLE>
    
    테이블 : 행(ROW) 열(COLLUM)로 구성되는 가장 기본적인 데이터베이스 객체종류 중 하나로
    모든 데이터는 테이블을 통해서 저장됨(데이터를 조직하고자 하려면 무조건 테이블을 만들어야 한다.
    
    [표현법]
    CREATE TABLE 테이블명(
    컬럼명 자료형,
    컬럼명 자료형,
    컬럼명 자료형,
    ...
    )
    
    <자료형>
    - 문자 (CHAR(크기)/VARCHAR2(크기): 크기는 BTYE크기,(숫자,영무낮,특수문자)=> 1글자당 1BTYE, 한글 -> 1글자당 3BTYE
    CHAR(바이트수):최대 2000BTYE까지 지정가능
        고정길이(아무리 적은 값이 들어와도 공백으로 채워서 처음 할당한 크기를 유지하겠다.)
        주로 들어올 값의 글자수가 정해져 있을 경우 사용
        EX)성별 : 남/여
            주민번호:6자리-7자리 -> 14글자 ->14 BTYE
    VARCHAR2(바이트수): 최대 4000BTYE까지 지정가능
                가변길이 ( 적은 값이 들어온 경우 그 담긴 값에 맞춰 크기가 줄어든다)
                VAR는 가변 2는 2배를 의미
                주로 들어올 값의 글자수가 정해지지 않은 경우 사용
                EX)이름,아이디,비밀번호...
    숫자(NUMBER) : 정수/실수 상관없이 NUMBER이다.
    
    날씨(DATE) : 년/월/일/시/분/초 형식으로 시간 지정

*/
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
); --컬럼명 대소문자 구분을 하지 않기 때문에 자바에서 하던 낙타봉 표기법이 의미가 없기때문에 _ 하이픈언더바로 구분한다.
SELECT *
FROM MEMBER;

--확인방법2 : 데이터 딕셔너리(DATE DICTIONARY)
--데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블

SELECT *
FROM USER_TABLES;
--USER_TABLES : 현재 이 사용자 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 데이터 딕셔너리다.

--참고 : 컬럼들 확인법
SELECT *
FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 현재 이 사용자 계정이 가지고 있는 테이블들의 모든 컬럼의 정보를 조회할 수 있는 데이터 딕셔너리

/*

    컬럼에 주석 달기 (컬럼에 대한 설명)
    
    [표현법]
    COMMENT ON COLUMN (테이블명,컬럼명 IS '주석내용';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '생년월일';

SELECT *
FROM MEMBER;

--INSERT (데이터 추가 구문) -DML
-- 한 행으로 추가, 추가할 값을 기술(값의 순서 지켜야한다)
-- INSERT INTO 테이블명 VALUES (첫번째 컬럼값,두번째 컬럼값,세번째...)

INSERT INTO MEMBER VALUES('user01','pass01','김나영','1988-10-10');
INSERT INTO MEMBER VALUES('user01','pass01','김나영',SYSDATE);
INSERT INTO MEMBER VALUES('user01','pass01','김나영','1988-10-10');

SELECT *
FROM MEMBER;

--위에 NULL값이나 중복된 ID값은 유효하지 않은 값이다
--유효한 데이터값을 유지하기 위해서 제약조건을 걸어줘야한다.
--데이터 무결성 보장이 가능해야한다.

/*
    <제약조건 CONSTRAINTS>
    -원하는 데이터값만 유지하기 위해 특정 컬럼마다 설정하는 제약(데이터 무결성 보장을 목적으로)
    -제약조건이 부여된 컬럼에 들어올 데이터에 문제가 있는지 없는지 자동으로 검사할 목적
    -종류 : NOT NULL,UNIQUE,CHECK,PRIMARY KEY,FOREIGN KEY
    -컬럼에 제약 조건을 부여하는 방식:컬럼레벨방식/테이블레벨방식

*/

/*

    1. NOT NULL 제약조건
    해당 컬럼에 반드시 값이 존재해야만 할 경우 사용
    -NULL값이 절대 들어와서는 안되는 컬럼에 부여하는 제약조건
    데이터 삽입/수정 시 NULL값을 허용하지 않게 제한한다.
    - 컬럼레벨방식으로만 작성가능
*/

--NOT NULL 제약조건을 설정한 테이블 만들기
--컬럼레벨방식 : 컬럼명 자료형 제약조건 -> 제약조건을 부여하고자 하는 컬럼뒤에 바로 기술
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_IT VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    );
    
SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1,'USER01','PASSWORD01','기리보이','남','010-2000-2000','GIDIGL@NAVER.COM');

SELECT *
FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(2,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO MEM_NOTNULL VALUES(2,'USER02','PASSWORD02','혁오',NULL,NULL,NULL);
INSERT INTO MEM_NOTNULL VALUES(2,'USER02','PASSWORD02','혁오',NULL,NULL,NULL);

/*
    2.UNIQUE 제약조건
    컬럼에 중복값을 제한하는 제약조건
    삽입 / 수정 시 기존에 해당 컬럼값 중에 중복값이 있을 경우
    추가 또는 수정이 되지 않게 제약
    
    컬럼레벨방식,테이블레벨방식 다 가능하다.
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --한개의 컬럼에 여러가지 제약조건을 걸수있다.
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    );
    
SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1,'USER02','PASSWORD02','혁오',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE VALUES(2,'USER01','PASSWORD02','혁오',NULL,NULL,NULL);

/*
    제약조건 부여시 제약조건명도 지정하는 표현법
    -컬럼레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 제약조건1,제약조건2
        컬럼명 자료형 CONSTRAINT 제약조건명 제약조건,
        컬럼명 자료형,
        ...
        )
        
        - 테이블레벨방식
        CREATE TABLE 테이블명(
            컬럼명 자료형,
            컬럼명 자료형,
            ...,
            컬럼명 자료형,
            CONSTRAINT 제약조건명 제약조건(컬럼명)
            );
*/

CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NM NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) --테이블레벨방식
    
    );
    
    SELECT * FROM MEM_CON_NM;
    
    INSERT INTO MEM_CON_NM VALUES(10,'TEST01','TEST01','김테스트',NULL,NULL,NULL);
    INSERT INTO MEM_CON_NM VALUES(12,'TEST01','TEST01','김테스트',NULL,NULL,NULL);
    INSERT INTO MEM_CON_NM VALUES(12,'TEST01','TEST01','김테스트',NULL,NULL,NULL);
    
    SELECT *
    FROM MEM_CON_NM;
    
    /*
    
    3.CHECK 제약조건
    컬럼에 기록될 수 있는 값에 대한 조건을 설정할 수 있다.
    EX) 성별 '남' OR '여'만 들어올수 있게 하고싶다.
    [표현법]
    CHECK (조건식)
    
    */
    DROP TABLE MEM_CHECK;
 CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL --DEFAUL를 먼저 설정하고 제약조건을 작성해야한다
    );

    SELECT *
    FROM MEM_CHECK;
    
    INSERT INTO MEM_CHECK VALUES(1,'USER11','PASSWORD','김열싦','남','010-333-0442','DKFDSIFS@NAV.COM',DEFAULT);
    INSERT INTO MEM_CHECK VALUES(1,'USER11','PASSWORD','김열싦','여','010-333-0442','DKFDSIFS@NAV.COM',DEFAULT);
    INSERT INTO MEM_CHECK VALUES(1,'USER11','PASSWORD','김열싦','어','010-333-0442','DKFDSIFS@NAV.COM',DEFAULT);
    
    INSERT INTO MEM_CHECK (MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GENDER)VALUES(2,'USER12','PASSWORD2','이상순','여');
    
    SELECT *
    FROM MEM_CHECK;
    --컬럼 형식을 지정해주면 지정이 안된 컬럼에 대해선 기본 NULL값이 들어가고 DEFAULT 설정이 되어있다면 DEFAULT 값이 들어간다.
    
    
    /*
    4. PRIMARY KEY(기본키) 제약조건
        테이블에서 각 행들의 정보를 유일하게 식별할 수 있는 컬럼에 부여하는 제약 조건
        ->각 행들을 구분할 수 있는 식별자의 역할
      EX)사번,부서아이디,직급,회원번호,학번...
      -> 식별자의 조건 : 중복 X ,NULL값 X (NOT NULL + UNIQUE)
      주의 : 한테이블 당 한개의 컬럼에만 지정 가능.
    */
CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL 
    );

SELECT * FROM MEM_PRIMARYKEY1;

INSERT INTO MEM_PRIMARYKEY1 (MEM_NO,MEM_ID,MEM_PW,MEM_NAME) VALUES (1,'TEST1','TEST2','일어나'));


/*
    5. FOREIGN KEY (외래키)
    해당 컬럼에 다른 테이블에 존재ㅏ는 값만 들어와야 하는 컬럼에 부여하는 제약조건
    ->"다른테이블"을 참조한다 라고 표현한다 (부모테이블)
    -> 참조된 다른 테이블이 제공하고 있는 값만 들어올 수 있다.
    EX) KH 계정에서 EMPLOYEE테이블 <----DEPARTMENT테이블
            (자식)        (부모)
            DEPT_CODE   DEPT_ID
            ->DEPT_CODE에는 DEPT_ID에 존재하는 값들만 들어올 수 있다.
        =FOREIGN KEY 제약조건(연결고기) 으로 다른 테이블과 관계를 형성 할 수 있다.(JOIN)
        
        [표현법]
        컬럼명 자료형 REFERENCES 참조테이블명(참조컬럼명)
        
        -참조컬럼명 생략가능
        ->자동으로 참조테이블의 PRIMARY KEY에 해당되는 컬럼이 참조 컬럼으로 잡힌다.
        주의 : 참조컬럼타입과 외래키 지정컬럼타입이 같아야함.

        --부모 테이블 만들기
        --회원 등급에 대한 데이터 (등급코드,등급명) 보관하는 테이블

*/
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR(20) NOT NULL
    );
    
    INSERT INTO MEM_GRADE VALUES('G1','일반회원');
    INSERT INTO MEM_GRADE VALUES('G2','우수회원');
    INSERT INTO MEM_GRADE VALUES('G3','특수회원');

    SELECT * FROM MEM_GRADE;

--자식테이블
--회원정보를 담는 테이블

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),--외래키 지정
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL 
    );
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(1,'USER1','PW1','김패스','G1');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(2,'USER2','PW2','김쓰루패스','G2');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(3,'USER3','PW3','김시아패스','G3');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(4,'USER4','PW4','김아야패스','G4');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(5,'USER5','PW2','김아야패스',NULL);--NULL값은 잘 들어간다.
    
    SELECT * FROM MEM;
    
    
    --부모테이블(MEM_GRADE)에서 데이터값이 삭제된다면?
    --MEM GRADE 테이블로부터 GRADE_CODE가 'G1'인 데이터만 지워보자
    DELETE FROM MEM_GRADE WHERE GRADE_CODE='G1';
 --   child record found : 자식 테이블 중에 G1값을 참조해서 사용하고 있기 때문에 삭제 할 수 없다.
--    현재 외래키 제약조건 부여시 삭제에 대한 욥션을 따로 부여하지 않았다.
-->   기본적으로 삭제 제한 옵션이 걸려있다.

DROP TABLE MEM;

/*
    자식 테이블 생성 시(==외래키 제약조건을 부여했을 때)
    부모테이블의 데이터가 삭제되었을때 자식 테이블에는 어떻게 처리할것인지 옵션으로 지정가능.
    FOREIGN KEY 삭제 옵션
    -ON DELETE SET NULL : 부모데이터를 삭제할 때 해당 데이터를 사용하는 자식 데이터를  NULL로 바꾸겠다.
    -ON DELETE CASCADE : 부모데이터를 삭제할 때 해당 데이터를 사용하는 자식 데이터를 같이 삭제하겠다.
    -ON DELETE RESTRICTED : 삭제 제한 (기본 옵션)
*/
--1)ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE,--외래키 지정
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL 
    );
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(1,'USER1','PW1','김패스','G1');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(2,'USER2','PW2','김쓰루패스','G2');
    
    INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PW,MEM_NAME,GRADE_ID)
    VALUES(3,'USER3','PW3','김시아패스','G3');
    
    
SELECT * FROM MEM;
    
    --부모테이블(MEM_GRADE)에서 데이터값이 삭제된다면?
    --MEM GRADE 테이블로부터 GRADE_CODE가 'G1'인 데이터만 지워보자
    DELETE FROM MEM_GRADE WHERE GRADE_CODE='G1';

--전체 회원의 회원번호, 아이디,비밀번호,이름,등급명 조회

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE,--외래키 지정
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(40),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL 
    );

SELECT MEM_NO, MEM_ID,MEM_PW,MEM_NAME,GRADE_ID
FROM MEM;

-----------------------------------------------------------

/*
    SUBQUERY를 이용한 테이블 생성(테이블 복사하는 개념)
    메인 SQL문 (SELECT,CREATE,INSERT,UPDATE)을 보조하는 역할의 쿼리
    
    [표현법]
    CREATE TABLE 테이블명
    AS 서브쿼리;

*/

--EMPLOYEE 테이블 조회
SELECT * FROM EMPLOYEE;

--EMPLOYEE 테이블을 복제한 새로운 테이블 생성(EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
/*
    컬럼들, 조회결과의 데이터값들은 제대로 복사한다.
    EMPLOYEE KEY 복사
    PRIMARY KEY 복사 X
    --> 서브쿼리를 통해 테이블을 생성할 경우 제약조건은 NOT NULL 제약조건만 복사된다.
    
*/

SELECT * FROM EMPLOYEE_COPY;

--EMPLOYEE 테이블의 데이터말고 컬럼 구조만 복사하고 싶을때 (조건부여)
CREATE TABLE EMPLOYEE_COPY2
AS SELECT *
    FROM EMPLOYEE
    WHERE 0=1;

SELECT *
FROM EMPLOYEE
WHERE 1=1; --TRUE

SELECT *
FROM EMPLOYEE
WHERE 0=1; --FALSE

SELECT * FROM EMPLOYEE_COPY2;

--전체 사원들 중 급여가 300만원 이상이 사원들의 사번,이름,부서코드,급여,컬럼과 데이터 모두 복제해보기
--테이블명 EMPLOYEE_COPY3 로 지정

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
    FROM EMPLOYEE
    WHERE SALARY<=3000000;
SELECT * FROM EMPLOYEE_COPY3;

CREATE TABLE EMPLOYEE_COPY4
AS SELECT EMP_ID,EMP_NAME,SALARY,(SALARY*12) 연봉
    FROM EMPLOYEE;
--서브쿼리에서 산술연산 또는 함수식이 기술된 경우에는 별칭을 붙여줘야한다.
SELECT * FROM EMPLOYEE_COPY4;