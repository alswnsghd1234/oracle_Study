/*
    <시퀀스 SEQUENCE>
    
    자동으로 번호를 발생시켜주는 역할을 하는 객체
    정수값을 자동으로 순차적으로 발생시켜줌(연속된 숫자)
    
    EX)회원번호,사원번호,게시글번호,
    -순차적으로 겹치지 않는 숫자로 정의할때 사용
    
    1.시퀀스 객체 생성 구문
    
    [표현법]
    CREATE SEQUENCE 시퀀스명
    START WITH 시작숫자 -> 생략가능,처음 발생시킬 시작 값 설정
    INCREMENT BY 증가값-> 생략가능,한번 시퀀스 증가 할 때마다 몇씩 증가할건지 설정
    MAXVALUE 최대값 -> 생략가능, 최대값 지정
    MINVALUE 최소값 -> 생략가능,최소값 지정
    CYCLE/NOCYCLE -> 생략가능, 값의 순환 여부를 결정
    CACHE 바이트크기/NOCACHE -> 생략가능, 캐시메모리 여부 지정(기본 SIZE = 20BTYE)
    
    *캐시 메모리란?
    시퀀스로부터 미리 발생될 값들을 생성해서 저장해두는 공간
    매번 호출할때마다 새로이 번호를 생성하는것보단
    캐시메모리 공간에 미리 생성된 값들을 가져다 쓰게되면 속도가 빠르다.
    단, 접속이 끊기고 나서 재접속 후 기존에 생성되어있던 값들은 사라짐.
    
*/

CREATE SEQUENCE SEQ_TEST;

--현재 접속한 계정이 소유하고 잇는 시퀀스에 대한 정보를 조회하고자 한다면
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMP_NO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    시퀀스 사용 구문
    
    시퀀스명,CURRVAL : 현재 시퀀스의 값 ( 마지막으로 성공적으로 발생된 NEXTVAL값)
    시퀀스명,NEXTVAL : 현재 시퀀스의 값을 증가시키고 그 증가된 시퀀스의 값 == CURRVAL + INCREMENT BY
    단, 시퀀스 생성 후 첫 NEXTVAL은 START WITH로 지정된 시작값으로 발생
    첫 시퀀스명.CURRVAL은 수행 불가
*/

SELECT SEQ_EMP_NO.CURRVAL FROM DUAL; --"sequence %s.CURRVAL is not yet defined in this session"
--시퀀스가 생성되고 나서 NEXTVAL를 한번이라도 수행하지 않는 이상 CURRVAL을 수행할 수 없음
-->CURRVAL는 마지막에 정상적으로 수행된 NEXTVAL의 값을 저장해서 보여주는 임시값이기 때문

SELECT SEQ_EMP_NO.NEXTVAL FROM DUAL;
SELECT SEQ_EMP_NO.CURRVAL FROM DUAL;

/*

    CREATE SEQUENCE 시퀀스명
    INCREMENT BY 증가값-> 생략가능,한번 시퀀스 증가 할 때마다 몇씩 증가할건지 설정
    MAXVALUE 최대값 -> 생략가능, 최대값 지정
    MINVALUE 최소값 -> 생략가능,최소값 지정
    CYCLE/NOCYCLE -> 생략가능, 값의 순환 여부를 결정
    CACHE 바이트크기/NOCACHE -> 생략가능, 캐시메모리 여부 지정(기본 SIZE = 20BTYE)
    
    ->START WITH 변경이 불가능 : 정 바꾸고 싶으면 삭제했다가 다시 생성해야 한다.
        
*/

ALTER SEQUENCE SEQ_EMP_NO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMP_NO.CURRVAL FROM DUAL;
SELECT SEQ_EMP_NO.NEXTVAL FROM DUAL;

--SEQUENCE 삭제하기

DROP SEQUENCE SEQ_EMP_NO;

SELECT * FROM EMPLOYEE;

--매번 새로운 사번이 생성되는 시퀀스 생성(시퀀스명 : SEQ_EID)
--223 시작 증가1 최대값은 300
CREATE SEQUENCE SEQ_EID
START WITH 223
INCREMENT BY 1
MAXVALUE 300
NOCYCLE
NOCACHE;

SELECT * FROM EMP_ID;
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '홍길동', '666666-3666666', 'hong_gd@kh.or.kr', '01012344444',
'D2', 'J7', 'S1', 5000000, SYSDATE);

