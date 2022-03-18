/*
    함수 <FUNCTION>
    자바로 따지면 메소드와 같은 존재
    매개변수로 전달된 값들을 읽어서 계산한 결과를 반환
    
    - 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴(매 행마다 함수 실행후 결과 반환)
    - 그룹 함수 : N개의 값을 읽어서 1개의 결과를 리턴 (하나의 그룹별로 함수 실행 후 결과 반환)
    
    단일행 함수와 그룹 함수는 함께 사용할 수 없음 : 결과 행의 개수가 다르기 때문에

*/

----------단일행 함수-------------

/*
    <문자열과 관련된 함수>
    LENGTH / LENGTHB
    
    - LENGTH(문자열) : 해당 전달된 문자열의 글자 수 반환
    - LENGTHB(문자열) : 해당 전달된 문자열의 바이트 수 반환
    
    결과값은 숫자로 반환 -> NUMBER
    문자열:문자열 형식의 리터럴, 문자열에 해당하는 컬럼
    
    한글:'김'->'ㄱ','ㅣ','ㅁ'->한글자당 3BTYE로 취급한다
    영문,숫자,특수문자는 한글자당 1BTYE로 취급
*/

SELECT LENGTH('오라클'),LENGTHB('오라클')
FROM DUAL; -- 가상테이블 : 산술연산이나 가상 컬럼등 값을 한번만 조회하기 위해 사용하는 가상 테이블

SELECT '오라클',1,2,'AAA'
FROM DUAL;

SELECT EMAIL,LENGTH(EMAIL),LENGTHB(EMAIL),EMP_NAME,LENGTH(EMP_NAME),LENGTHB(EMP_NAME)
FROM EMPLOYEE;

/*

    INSTR
    -INSTR(문자열,특정문자,찾을위치의 시작값, 순번): 문자열로부터 특정 문자의 위치값 반환
    찾을 위치의 시작값, 순번은 생략가능
    결과값은 NUMBER타입으로 반환
    찾을 위치의 시작값(1/-1)
    1:앞에서부터 찾겠다.(생략시 기본값)
    -1:뒤에서부터 찾겠다.
*/
SELECT INSTR('AAABCCBBCA','B')
FROM DUAL; -- 앞에서부터 첫번째에 위치하는 B의 위치값을 알려줌

SELECT INSTR('AABAACBAAB','B',1)
FROM DUAL; --앞에서부터 첫번째에 위치하는 B의 위치값을 앞에서부터
SELECT INSTR('AAABABACB','B',-1)
FROM DUAL;
SELECT INSTR('AAABBCAAAAB','B',-1,2)
FROM DUAL;--뒤에서부터 두번째에 위치하는 B의 위치값을 앞에서부터 세서 알려줌
SELECT INSTR('ABAABCBABABA','B',1,2)
FROM DUAL; --앞에서부터 두번째에 위치한 B의 위치값

--EMAIL에서 @위치 찾기
SELECT INSTR(EMAIL,'@',1)
FROM EMPLOYEE;

/*

    SUBSTR
    문자열로부터 특정 문자열을 추출하는 함수
    -SUBSTR(문자열,처음위치,추출할문자개수)
    결과값은 CHARACTER 타입으로 반환이 된다.(문자열)
    추출할 문자개수는 생략가능 (생략을 했을때 문자열 끝까지 추출)
    처음위치는 음수로 제시 가능 : 뒤에서부터 N번째 위치로부터 문자를 추출하겠다 라는 뜻
*/
SELECT SUBSTR('HELLO ORACLE',5)
FROM DUAL;
SELECT SUBSTR('HELLO ORACLE',5,2)
FROM DUAL;
SELECT SUBSTR('HELLO ORACLE',-2)
FROM DUAL;
SELECT SUBSTR('HELLO ORACLE',-7,3)
FROM DUAL;

-- 주민번호에서 성별 부분을 추출해서 확인하기
SELECT EMP_NAME,SUBSTR(EMP_NO,8,1) AS 성별
FROM EMPLOYEE;
--남자 사원들 뽑기
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('1','3');

--EMAIL부분에서 @찾기
SELECT EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS ID
FROM EMPLOYEE;

SELECT EMAIL, SUBSTR(EMAIL,INSTR(EMAIL,'@')+1) AS ID
FROM EMPLOYEE;

SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('2','4') ;

/*
    LAPD / RAPD
    -LAPD/RAPD(문자열, 최종적으로 반환할 문자의 길이(BTYE),덧붙이고하자는 문자)
    - 제시한 문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N 길이만큼의 문자열을 반환
    
    결과값은 CAHRACTER 타입으로 반환
    덧붙이고자 하는 문자 : 생략가능 (공백이 기본값 ' ')

*/

SELECT LPAD(EMAIL,16)
FROM EMPLOYEE;

SELECT RPAD(EMAIL,20,'#')
FROM EMPLOYEE;

--주민번호 조회 : 501010-122331 -> 501010-1******

SELECT EMP_NAME,EMP_NO
FROM EMPLOYEE;

SELECT EMP_NAME,EMP_NO
FROM EMPLOYEE;

SELECT RPAD('501010-1',14,'*')
FROM DUAL;
-- 앞에 8자리 추출해서 뒤에 *붙이기
SELECT EMP_NAME,SUBSTR(EMP_NO,1,8)
FROM EMPLOYEE;
--SUBSTR을 이용해 추출한 8자리를 RPAD에 넣기
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS "주번"
FROM EMPLOYEE;

/*
    
    LTRIM / RTRIM
    - LTRIM/RTRIM(문자열,제거시키고자하는 문자)
    - 문자열의 왼쪽 또는 오른쪽에서 제거시키고자하는 문자들을 찾아서 제거한 나머지 문자를 반환
    결과값은 CHARACTER 자료혀으로 나옴
    제거시키고자 하는 문자는 생략가능(기본값 ' ' 공백삭제)
    
*/

SELECT LTRIM('               K   H    ')
FROM DUAL;

SELECT LTRIM('AAAAA안녕하세요AAAAA','A')
FROM DUAL;

SELECT RTRIM('0000012345000',0)
FROM DUAL;

SELECT LTRIM('ABCABCACBCBCSDBS','ABC')
FROM DUAL;

/*

    TRIM
    - TRIM(BOTH,LEADING,TRAILING '제거하고자하는문자' FROM '문자열)
    - 문자열의 양쪽/앞쪽/뒤쪽 에 있는 특정 문자를 제거한 나머지 문자열을 반환
    결과값은 CHARACTER타입으로 반환
    BOTH/LEADING/TRAILING : 생략시 기본값은 BOTH

*/

SELECT TRIM('A' FROM 'AAAAZCSAAA')
FROM DUAL;
SELECT TRIM(LEADING 'A' FROM 'AAAAZCSAAA')
FROM DUAL; -- LEADING 왼쪽에 있는것만 삭제(LTRIM과 유사)
SELECT TRIM(TRAILING 'A'FROM'AAAAZCSAAA')
FROM DUAL; -- TRAILING 오른쪽에 있는것만 삭제(RTRIM과 유사)

/*

    LOWER/UPPER/INITCAP
    -LOWER(문자열)
    :다 소문자로 변경
    -UPPER(문자열)
    :다 대문자로 변경
    -INITCAP(문자열)
    :각 단어의 첫글자만 대문자로 변경
    
    전부 반환타입은 CHARACTER

*/
SELECT LOWER('HELLO WOLRD'),UPPER('hello world'),INITCAP('hello world GODD')
FROM DUAL;

/*
    CONCAT
    -CONCAT(문자열1,문자열2)
    :전달된 문자열 두개를 하나의 문자열로 합쳐서 반환
    결과값은 CHARACTER 자료형
*/
SELECT CONCAT('오늘의','날씨')
FROM DUAL;

SELECT CONCAT(CONCAT('오늘의','날씨는'),'흐림') -- 두개 이상 하고싶다면
FROM DUAL;

--연결연산자로 더해보고 둘의 차이점 찾아보기

SELECT '오늘의'||'날씨는'||'맑음'
FROM DUAL;

/*
    REPLACE
    -REPLACE(문자열,찾을문자,바꿀문자)
    :문자열로부터 찾을문자를 찾아서 바꿀 문자로 바꾼 문자열을 반환
    결과값은 CHARACTER 자료형

*/
SELECT REPLACE('HELLO WORLD','WORLD','ORACLE')
FROM DUAL;

--사원 이름과 이메일 출력하는데 이메일 뒤에 주소를 GMAIL.COM으로 변경 출력
SELECT EMP_NAME,REPLACE(EMAIL,'kh.or.kr','GMAIL.COM')
FROM EMPLOYEE;


---------------------------------------

/*
    <숫자와 관련된 함수>
    ABS
    -ABS(절대값을 구할 숫자) : 절대값을 구해주는 함수
    결과값은 NUMBER 자료형으로 반환
*/
SELECT ABS(-10)
FROM DUAL;
SELECT ABS(-10.9)
FROM DUAL;

/*
    MOD
    -MOD(숫자,나눌값):두 수를 나눈 나머지값을 반환하느 ㄴ함수
    결과값 NUMBER

*/

SELECT MOD(10,3)
FROM DUAL;
SELECT MOD(-10,3)
FROM DUAL;
SELECT MOD(10.9,3)
FROM DUAL;

/*
    ROUND
    -ROUND(반올림하고자하는수 ,반올림할위치):반올림 처리 함수
    
    반올림할위치 : 소숫점 기준으로 아래 N번째 수에서 반올림 하겠다.
                생략 가능(위치 생략시 기본값은 0, 소숫점 첫번째 자리에서 반올림을 하겠다.
                - 반올림 결과가 소숫점이 0개이다.)
    결과값은 NUMBER 타입으로 반환

*/
SELECT ROUND(123,456)
FROM DUAL; --123
SELECT ROUND(123.456,1)
FROM DUAL; --123.5
SELECT ROUND(123.456,2)
FROM DUAL; --123.45
SELECT ROUND(123.456,-2)
FROM DUAL; --100

/*

    CEIL
    -CEIL(올림처리할숫자):소수점 아래의 수를 무조건 올림하는 함수
    반환형은 NUMBER타입

*/

SELECT CEIL(123.456)
FROM DUAL;
SELECT CEIL(451.089)
FROM DUAL;

/*
    FLOOR
    -FLOOR(버림처리하고자 하는 숫자) : 소수점아래의 수를 무조건 버림처리해주는 함수
    
    반환형은 NUMBER타입

*/

SELECT FLOOR(123.456)
FROM DUAL;
SELECT FLOOR(2078.33)
FROM DUAL;


/*
    TRUNC
    -TRUNC(버림처리할숫자,위치):위치가 지정가능한 버림 처리르 해주는 함수
    결과값은 NUMBER타입
    위치 : 생략가능,생략시 기본값음 0 (==FLOOR함수)
*/

SELECT TRUNC(123.678)
FROM DUAL;
SELECT TRUNC(123.456,1)
FROM DUAL;

SELECT TRUNC(123.456,1)
FROM DUAL;

/*
    <날짜 관련 함수>
    DATE 타입 : 년도,월,일,시,분,초를 다 포함한 자료형
    SYSDATE : 현재 시스템 날짜 반환
*/

SELECT SYSDATE
FROM DUAL;

/*
MONTHS_BETWEEN(dATE1,DATE2) : 두 날짜 사이의 개월수를 반환(결과값은 NUMBER타입)
--만약 DATE2가 더 미래의 날이라면 음수로 반화됩니다.
-- 각 지원별 근무일수,근무 개월수

*/

SELECT EMP_NAME
       ,FLOOR(SYSDATE-HIRE_DATE)||'일' 근무일수
       ,FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))|| '월' 근무개월수
FROM EMPLOYEE;

/*
    ADD_MONTHS(DATE,NUMBER) : 특정 날짜에 해당 숫자만큼 개월수를 더한 날짜를 반환한다.(결과값은 DATE타입)
    오늘 잘짜로부터 5개월 이후
*/

SELECT ADD_MONTHS(SYSDATE,5)
FROM DUAL;

SELECT SYSDATE+100 AS "100일후"
FROM DUAL;

--사원들의 입사 1주년
SELECT EMP_NAME,HIRE_DATE,ADD_MONTHS(HIRE_DATE,12)
FROM EMPLOYEE;

--NEXT_DAY(DATE,요일(문자/숫자)) : 특정 날짜에서 가장 가까운 해당 요일을 찾아 그 날짜를 반환(결과값이 DATE타입)
SELECT NEXT_DAY(SYSDATE,5)
--1:일 ~ 7:토
FROM DUAL;

--토요일 :SATURDAY
--SELECT NEXT_DAY(SYSDATE,'SATURDAY')
--FROM DUAL;

--언어변경
--DDL(데이터 정의 언어):CREATE,ALTER,DROP
--ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--LAST DAY(DATE) : 해당 특정 날짜달의 마지막 날짜를 구해서 반환(결과값은 DATE타입)
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--이름,입사일,입사한 달의 마지막날 조회
SELECT EMP_NAME,HIRE_DATE,LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

--EXTRACT : 년도 또는 월 또는 일 정보를 추출해서 반환
    --EXTRACT(YEAR FROM 날짜) : 특정 날짜로부터 년도만 추출
    --EXTRACT(MONTH FROM 날짜) : 특정 날짜로부터 년도만 추출
    --EXTRACT(DAY FROM 날짜) : 특정 날짜로부터 일만 추출
    
SELECT EXTRACT(YEAR FROM SYSDATE)
        ,EXTRACT(MONTH FROM SYSDATE)
        ,EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

--사원명,입사년도,입사월,입사일 조회

SELECT EMP_NAME "사원명"
        ,EXTRACT(YEAR FROM HIRE_DATE) "입사년도"
        ,EXTRACT(MONTH FROM HIRE_DATE) "입사 월"
        ,EXTRACT(DAY FROM HIRE_DATE) "입사 일"
FROM EMPLOYEE;

-----------------------------------------------

/*
    <형변환 함수>
    
    NUMBER/DATE -> CHARCTER
    :TO_CHAR(NUMBER/DATE)
    :숫자형 또는 날짜형 데이터타입을 문자형 타입으로 반환(포맷에 맞춰서)

*/

--숫자를 문자열로
SELECT TO_CHAR(1234)
FROM DUAL;

SELECT TO_CHAR(1234,'00000')
FROM DUAL;

SELECT TO_CHAR(1234,'99999')
FROM DUAL; --나머지 빈칸을 ' ' 공백으로 채움

SELECT TO_CHAR(1234,'L00000')
FROM DUAL; --L : LOCAL 화폐단위표시

SELECT TO_CHAR(1234,'L99999')
FROM DUAL;

--급여정보를 3자리마다 , 로 끊어서 확인, 화폐 단위도 넣어서
SELECT TO_CHAR(SALARY,'L999,999,999') AS "급여정보"
FROM EMPLOYEE;

--날짜를 문자열로
SELECT TO_CHAR(SYSDATE)
FROM DUAL; --22/03/18

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')
FROM DUAL; --2022-03-18

--시 분 초 : 오전(AM)/오후(PM)
SELECT TO_CHAR(SYSDATE,'PM HH:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'HH24:MI:SS')
FROM DUAL; -- 24시간 형식 HH24

SELECT TO_CHAR(SYSDATE,'MON DY,YYYY')
FROM DUAL; --MON월 형식, DY요일인데 X요일에서 X만 표시 요일이라는 단위는 제거된 형태

SELECT TO_CHAR(SYSDATE,'MON DAY,YYYY')
FROM DUAL; --DAY라고 하면 - 요일 단위도 포함

--년도로 표현할 수 있는 포멧

SELECT TO_CHAR(SYSDATE,'YYYY') AS "YYYY"
        ,TO_CHAR(SYSDATE,'RRRR') AS"YY"
        ,TO_CHAR(SYSDATE,'YY') AS "YY"
        ,TO_CHAR(SYSDATE,'RR') AS "RR"
        ,TO_CHAR(SYSDATE,'YEAR')AS "YEAR"
FROM DUAL;

--월로 표현할수있는 포멧
SELECT TO_CHAR(SYSDATE,'MM') AS "MM으로 표현"
        ,TO_CHAR(SYSDATE,'MON') AS "MON"
        ,TO_CHAR(SYSDATE,'MONTH') AS "MONTH로 표현"
        ,TO_CHAR(SYSDATE, 'RM') AS "RM으로 표현"
FROM DUAL;

--일로 표현할 수 있는 포멧
SELECT TO_CHAR(SYSDATE,'D') --1주일 기준으로 일요일부터 며칠째이지 알려주는 포맷
    ,TO_CHAR(SYSDATE,'DD') -- 1달 기준으로 1일부터 며칠째인지 알려주는 포맷
    ,TO_CHAR(SYSDATE,'DDD') -- 1년 기준으로 1월1일부터 며칠째인지 알려주는 포맷
FROM DUAL;

--요일로 쓸 수 있는 포멧
SELECT TO_CHAR(SYSDATE,'DY') --요일 단위 없이 출력
    ,TO_CHAR(SYSDATE,'DAY') -- 요일 포함
FROM DUAL;

--2022년 03월 18일 (금) 이런 포맷으로 조회하고 싶다.
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"(DY)')
FROM DUAL;

--위에 포멧을 이용해서 사원의 이름과 입사일을 조회해보시오.

SELECT EMP_NAME,TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"(DY)')
FROM EMPLOYEE;

--2010년 이후에 입사한 사원들의 이름과 입사일을 위에 포멧으로 조회해라

SELECT EMP_NAME,TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"(DY)')
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYYY')>=2010; --자동 형변환


/*
NUMBER/CHARACTER
-TO DATE(NUMBER/CHARACTER,포멧) : 숫자형 또는 문자형 데이터를 날짜형 데이터로 변환(결과값 DATE타입)

*/

SELECT TO_DATE(20211010)
FROM DUAL; --기본 포멧은 YY/MM/DD
SELECT TO_DATE(000101)
FROM DUAL; --0으로 시작하는 숫자로 인식해서 오류
SELECT TO_DATE('000101')
FROM DUAL; --0으로 시작하면 숫자로 인식하기 때문에 문자열 타입으로 넣어줘야함

SELECT TO_DATE('20020203')
FROM DUAL;
SELECT TO_DATE('031019 020225','YYMMDD HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('031019 020225','YYMMDD HH24:MI:SS'),'YYMMDD HH24:MI:SS')
FROM DUAL;

/*
    CHARACTER -> NUMBER
    -TO)NUMBER(문자형,포멧) : 문자형 데이터를 숫자형으로 변환(결과값은 NUMBER타입)
    
*/

--자동형변환의 예시(문자열->숫자)
SELECT '123'+'123'
FROM DUAL; --246 자동형변환 후 산술연산까지 가능

SELECT '100,000,000'+'5,000'
FROM DUAL; --문자(,)가 포함되어있기 때문에 자동형변환이 안됨

SELECT TO_NUMBER('100,000,000','999,999,999')+TO_NUMBER('50,000','99,999')
FROM DUAL; -- 형변환 후에 산술연산 진행 TO_NUMBER로

SELECT TO_NUMBER('0123')
FROM DUAL;

--------------------------------------------------
--NULL : 값이 존재하지 않음을 나타내는 값
--NULL 처리 함수들 : NVL,NVL2,NULLIF -> 삼항연산자

/*
    <NULL처리 함수>
    NVL(컬럼명,해당컬럼명이 NULL일 경우 반환할 값)
    해당 컬럼값이 존재할 경우 (NULL)이 아닐경우) 기존의 컬럼값 반환
    해당 컬럼값이 존재하지 않을 경우 (NULL값일 경우) 내가 제시한 특정값을 반환한다.
*/

SELECT BONUS
FROM EMPLOYEE;
--사원명, 보너스를 조회하는데 보너스가 없으면 0으로 출력
SELECT EMP_NAME,BONUS,NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME,NVL(DEPT_CODE,'없음')
FROM EMPLOYEE;

/*

    NVL2(컬럼명,결과값1,결과값2)
    해당 컬럼에 데이터가 존재한다면 (NULL이 아닐경우) 결과값1 반환
    해당 컬럼에 데이터가 존재하지 않는다면 (NULL일경우) 결과값2 반환
    
*/

--보너스가 있는 사원은 보너스 있음, 보너스가 없는 사람은 보너스가 없음을 조회해보자
SELECT EMP_NAME,BONUS,NVL2(BONUS,'보너스있음','보너스없음')
FROM EMPLOYEE;