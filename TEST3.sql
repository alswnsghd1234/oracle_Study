CREATE USER MYUSER IDENTIFIED BY MYUSER;
GRANT CREATE SESSION TO MYUSER;
GRANT CREATE TABLE TO MYUSER;
ALTER USER MYUSER QUOTA 2M ON SYSTEM;
GRANT CREATE VIEW TO MYUSER;
GRANT SELECT ON KH.EMPLOYEE TO MYUSER;
GRANT INSERT ON KH.EMPLOYEE TO MYUSER;