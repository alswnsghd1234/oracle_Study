/*
    *DDL(DATA DEFINITION LANGUAGE)
    데이터 정의 언어
    
    객체들을 새롭게 생성(CREATE)하고 수정(ALTER)하고 삭제(DROP)하는 구문
    
    1.ALTER
    객체 구조를 수정하는 구문
    <테이블 수정 >
    [표현법]
    ALTER TABLE 테이블명 수정할내용;
    
    -수정할 내용
    1)컬럼추가/수정/삭제
    2)제약조건 추가/삭제 -> 수정은 불가(수정하고자 한다면 삭제 후 새로이 추가)
    3)테이블명 / 컬럼명 /제약조건명 수정
*/

--1)컬럼 추가/수정/삭제
--1-1) 컬럼추가 (ADD):ADD추가할컬럼명 자료형 DEFAULT 기본값
--                    단,DEFAULT값 생략가능

SELECT * FROM DEPT_COPY;

--CNAME컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--새로운 컬럼이 만들어지고 기본값인 NULL로 채워진다.
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '기본값';
--새로운 컬럼이 만들어지고 DEFAULT값으로 설정한 "기본값" 으로 채워졌다

--DNAME이라는 컬럼을 추가하고 DATE타입 기본값은 SYSDATE로 입력해보세요
ALTER TABLE DEPT_COPY ADD DNAME DATE DEFAULT SYSDATE;

--1_2)컬럼 수정 (MODIFY)
--컬럼의 자료형 수정 : MODIFY 수정할컬럼명 바꾸고자 하는 자료형
--DEFAULT 값 수정 : MODIFY 수정할컬럼명 DEFAULT 바꾸고자 하는 기본값.

--DEPT_COPY 테이블의 DEPT_ID 컬럼의 자료형을 CHAR(3)으로 변경해보기
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

SELECT * FROM DEPT_COPY;

--현재 변경하고자 하는 컬럼에 이미 담겨있는 값과 완전히 다른 타입으로 변경해보기 (변경 X)
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; --column to be modified must be empty to change datatype 오류

--현재 변경하고자 하는 컬럼에 담긴 값보다 작은 크기로 설정할 수 없다.
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1); --cannot decrease column length because some value is too big 오류

--현재 변경하고자 하는 컬럼에 담긴 값보다 크게 변경하는것은 가능
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(10);

--문자->NUMBER는 X / 사이즈 축소 X / 사이즈 확대 O

--한번에 여러ㅓ개의 컬럼 변경하기
--DEPT_TITLE컬럼의 데이터타입을 VARCHAR2(40)으로
--LOCATION_ID 컬럼의 데이터타입을 VARCHAR2(2)로
--LNAME 컬럼의 기본값을 '미국'으로
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';

SELECT * FROM DEPT_COPY;
INSERT INTO DEPT_COPY(DEPT_ID,DEPT_TITLE,LOCATION_ID) VALUES('D0','이이이','L0');

--1_3)컬럼 삭제 (DROP COLUMN) : ALTER TABLE 테이블명 DROP COLUMN 삭제하고자 하는 컬럼명
CREATE TABLE DEPT_COPY2
AS SELECT *
    FROM DEPT_COPY;
    
SELECT*FROM DEPT_COPY2;

--DEPT_ID 컬럼 지우기 
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

ROLLBACK;--DDL구문은 롤백 불가

--DEPT_COPY2의 모든컬럼 지워보기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN DNAME;
--오류  "cannot drop all columns in a table" 
--테이블에 최소 한개의 컬럼은 존재해야한다.




