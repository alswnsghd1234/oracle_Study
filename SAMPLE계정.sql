--3_1
--테이블 생성해보기

CREATE TABLE TEST(
    TEST_ID NUMBER
    );

--CREATE TABLE 권한 부여받아서 TABLE SPACE 할당받지 않으면 오류
    
SELECT * FROM TEST;

INSERT INTO TEST VALUES(10);

CREATE VIEW V_TEST
AS SELECT* FROM TEST;
--insufficient privileges 오류
--CREATE VIEW 권한이 없기 때문에 오류
--CREATE VIEW 권한 부여받은 후 생성오류

SELECT * FROM V_TEST; --CREATE VIEW 권한 부여받은 후 생성완료

--5.
--SAMPLE 계정에서 KH 계정에 있는 테이블에 접근해서 조회해보기

SELECT * FROM KH.EMPLOYEE;
-- "table or view does not exist" 오류

--6.행 삽입해보기
INSERT INTO KH.DEPARTMENT VALUES('D0','회계부','L2');

--7.
--REVOKE (회수) CREATE TABLE 권한이 잘 회수되었는지 확인
CREATE TABLE TEST2(
    TEST_ID NUMBER

);