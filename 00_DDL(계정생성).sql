-- DDL 공부할 새로운 계정 만들기
CREATE USER DDL IDENTIFIED BY DDL;

-- 최소한의 권한 부여
GRANT CONNECT, RESOURCE TO DDL;