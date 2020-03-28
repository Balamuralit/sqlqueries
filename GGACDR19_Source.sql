select name,open_mode from v$database;

show user

select * from dba_users;

create bigfile tablespace BTEST;


CREATE USER BTEST IDENTIFIED BY BTEST DEFAULT TABLESPACE BTEST;
grant dba to BTEST;

desc scott.emp;