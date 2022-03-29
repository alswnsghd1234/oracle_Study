/*
    DCL (DATA CONTROL LANGUAGE)
    데이터 제어 언어
    계정에서 시스템 권한 또는 객체 접근 권한을 부여(GRANT)하거나 회수(REVOKE)하는 언어
    
    -권한 부여 (GRANT)
    시스템 권한 : 특정 DB에 접근하는 권한, 객체들을 생성할 수 잇는 권한
    객체 접근 권한 : 특정 객체들에 접근해서 조작할 수 있는 권한
    
    -시스템 권한
    [표현법]
    GRANT 권한1,권한2,...TO 계정명
    
    -시스템 권한의 종류
    CREATE SESSION : 계정에 접속 할 수 있는 권한
    CREATE TABLE : 테이블을 생성할 수 있는 권한
    CREATE VIEW : 뷰를 생성할 수 있는 권한
    CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
    CREATE USER : 계정을 생성할 수 있는 권한

*/

--1. SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

--2. SMAPLE 계정에 접속하기 위해 CREATE SESSION 권한 부여하기
GRANT CREATE SESSION TO SAMPLE;

--3. SMAPLE 계정에 테이블을 생성하기 위해 CREATE TABLE 권한 부여 하기
GRANT CREATE TABLE TO SAMPLE;

--3_2. SAMPLE 계정에 테이블 스페이스를 할당해주기 (SYSDBA)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--QUOTA : 몫 -> 할당하다 나누어주다
-- 2M : 2 MEGABTYE
-- 테이블스페이스 공간 제한을 두지 않으려면 QUOTA UNLIMITED ON 유저명

--4. VIEW 만들어보기
GRANT CREATE VIEW TO SAMPLE;

/*
    객체권한
    특정 객체들을 조작할 수 있는 권한
    조작 : SELECT,INSERT,UPDATE,DELETE = DML
    
    [표현법]
    GRANT 권한 ON 특정객체 TO 계정명;
    
    권한종류 | 특정객체
    -----------------
    SELECT  | TABLE,VIEW,SEQUENCE
    INSERT  | TABLE,VIEW
    UPDATE  | TABLE,VIEW
    DELETE  | TABLE,VIEW


*/

--5. SAMPLE 계정에 KH.EMPLOYEE 테이블을 조회할 수 있는 권한 부여받기
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

--6. SAMPLE 계정에 KH.DEPARTMENT 테이블에 행을 삽입할 수 있는 권한은 부여하기.
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

--최소한의 권한만 부여받고 싶다면 CONNECT, RESOURCE만 부여하면 된다.

/*
    특정 권한을 모아놓은 
    
    CONNECT : CREATE SESSION(데이터베이스 접속 권한)
    RESOURCE : CREATE TABLE, CREATE SEQUENSE
*/

/*
    권한 회수
*/
--7.
REVOKE CREATE TABLE FROM SAMPLE;

----실습 ---
/*
    MYUSER 계정명과 비밀번호를 가진 계정 생성하고
    CONNECT,RESOURCE 권한은 부여한뒤 테이블 생성해보고 행삽입 한번 해보고 뷰도 생성해보기
   
*/