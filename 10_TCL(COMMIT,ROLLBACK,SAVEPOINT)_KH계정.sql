/*
    TCL(TRANSACTION CONTROL LANGUAGE)
    트랜잭션을 제어하는 언어
    
    *트랜잭션(TRANSACTION)
    -데이터베이스의 논리적 작업 단위
    -데이터의 변경사항 (DML) 들을 하나의 트랜잭션으로 묶어서 처리
    -> COMMIT (확정) 하기 전까지의 변경사항들을 하나의 트랜잭션으로 담겠다.
    - 트랜잭션의 대상이 되는 SQL : INSERT,UPDATE,DELETE (DML)
    
    * 트랜잭션의 종류
    - COMMIT : 진행(CTRL+ENTER) : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠다는 의미
                                 실제 DB에 반영시킨 후 트랜잭션은 비워짐 (확정)
    -ROLLBACK : 진행(CRTL+ENTER) : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하지 않겠다는것을 의미
                                  트랜잭션에 담겨있는 변경사항도 다 삭제한 후 마지막 COMMIT 시점으로 돌아간다.
    -SAVEPOINT 포인트명; : 진행(CTRL+ENTER) : 현재 이 시점에 임시저장점을 정의해 두는것
    -ROLLBACK TO 포인트명; 진행(CTRL+ENTER) : 전체 변경사항들을 삭제(마지막 COMMIT 시점까지 돌려놓기) 하는것이 아니라
                                            해당 포인트 지점까지의 트랜잭션을 롤백한다.
    
*/
    SELECT * FROM EMP_01;
    
    DELETE FROM EMP_01
    WHERE DEPT_TITLE IS NULL;
    INSERT INTO EMP_01 VALUES(9999,'총무부','김팔');
    COMMIT;
    ROLLBACK;
------------------------------

-- 테이블 생성
CREATE TABLE TEST(
    TEST_ID NUMBER
    );
    
SELECT * FROM EMP_01;

ROLLBACK;

/*
    주의사항
    DDL구문 (CREATE,ALTER,DROP)을 실행하는 순간
    기존에 트랜잭션에 있던 모든 변경사항들을 무조건 실제 DB에 반영 (COMMIT을 시킨후 DDL 실행)
    DDL 수행 전 변경사항이 있었다면 정확히 COMMIT 또는 ROLLBACK을 진행한 후에 DDL을 실행 해야 한다.
    
*/