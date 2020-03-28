select name,open_mode from v$database;

show user

select constraint_name, table_name from user_constraints


select * from dba_users;

create bigfile tablespace BTEST;


CREATE USER BTEST IDENTIFIED BY BTEST DEFAULT TABLESPACE BTEST;
grant dba to BTEST;

select * from dba_users;