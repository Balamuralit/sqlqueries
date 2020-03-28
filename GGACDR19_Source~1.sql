select 

create bigfile tablespace BTEST;

CREATE USER BTEST IDENTIFIED BY BTEST DEFAULT TABLESPACE BTEST;
grant dba to BTEST;

create bigfile tablespace BTEST1;

CREATE USER BTEST1 IDENTIFIED BY BTEST1 DEFAULT TABLESPACE BTEST1;
grant dba to BTEST1

select username from dba_users;

select * from dba_tablespaces;

desc dba_objects;

select * from dba_objects where OWNER='BTEST';
select * from dba_objects where OWNER='BTEST1';

select 'alter system kill session ''' ||sid|| ',' || serial#|| ''' immediate;' from gv$session where  username='BTEST';

exec rdsadmin.rdsadmin_util.kill(2826,34273,'IMMEDIATE');

desc dba_segments;

select sum (BYTES/1024/1024/1024) from dba_segments where OWNER='BTEST';

SELECT o.name FROM sys.obj$ o, sys.user$ u, sys.sum$ s WHERE o.type# = 42 AND bitand(s.mflags, 8) =8; 

desc DBA_APPLY_ERROR_MESSAGES

select * from DBA_APPLY_ERROR_MESSAGES;

alter user gger identified by gger

show parameter gold

select * from global_name;

declare
 v_cnt number;
begin
 for i in (select table_name from dba_tables where owner='BTEST') loop
  execute immediate 'select count(*) from BTEST.' || i.table_name into v_cnt;
  dbms_output.put_line(i.table_name || ' - ' || to_char(v_cnt, '999,999,999'));
 end loop;
end;
/

SELECT *   FROM ALL_GG_AUTO_CDR_TABLES   ORDER BY TABLE_OWNER, TABLE_NAME;


desc DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR;

select * from BTEST.DT$_ACDRTEST order by 2;

select count(*) from BTEST.DT$_ACDRTEST; 


SELECT TABLE_OWNER,
       TABLE_NAME, 
       TOMBSTONE_TABLE,
       ROW_RESOLUTION_COLUMN 
  FROM ALL_GG_AUTO_CDR_TABLES
  ORDER BY TABLE_OWNER, TABLE_NAME;
  
select * from ALL_GG_AUTO_CDR_TABLES;

select * from BTEST.DT$_ACDR_ARD_DETAILS;
  
 SELECT TABLE_OWNER,
       TABLE_NAME,
       COLUMN_GROUP_NAME,
       COLUMN_NAME,
       RESOLUTION_COLUMN
  FROM ALL_GG_AUTO_CDR_COLUMNS
  ORDER BY TABLE_OWNER, TABLE_NAME;

BEGIN
	DBMS_GOLDENGATE_ADM.ALTER_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'acdrtest',
	tombstone_deletes => TRUE );
END;
/


BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'CARD_DETAILS');
END;
/

BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'GGACDR_CARD_DETAILS');
END;
/


BEGIN
  DBMS_GOLDENGATE_ADM.ALTER_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'GGACDR_CARD_DETAILS',
    RECORD_CONFLICTS => 'TRUE');
END;
/


BEGIN
  DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'GGACDR_CARD_DETAILS');
END;
/
