select * from v$database

select * from dba_services

select * from v$active_services


exec dbms_service.start_service('GGACDR19_GG')

SELECT * FROM PRODUCT_COMPONENT_VERSION;


show parameter aq_tm_processes

grant dba to gger

DECLARE
	 l_grantee varchar2(30) := 'GGER';
	 l_privilege_type varchar2(30) := 'APPLY';
	 l_grant_select_privileges boolean := TRUE;
	 l_do_grants boolean := TRUE;
BEGIN
	 $IF dbms_db_version.ver_le_12_1 $THEN
	     DBMS_GOLDENGATE_AUTH.GRANT_ADMIN_PRIVILEGE
	     (grantee=>l_grantee,privilege_type=>l_privilege_type,
	     grant_select_privileges=>l_grant_select_privileges, do_grants=>l_do_grants);
	 $ELSIF dbms_db_version.version >= 19 $THEN
	     rdsadmin.rdsadmin_dbms_goldengate_auth.grant_admin_privilege
	     (grantee=>l_grantee,privilege_type=>l_privilege_type,
	     grant_select_privileges=>l_grant_select_privileges, do_grants=>l_do_grants);
	 $END
END;
/

DBMS_GOLDENGATE_AUTH.GRANT_ADMIN_PRIVILEGE (grantee=>'GGER');
   privilege_type=>'capture',
   grant_select_privileges=>true,
   do_grants=>TRUE);
end;


DBMS_GOLDENGATE_AUTH.GRANT_ADMIN_PRIVILEGE('gger');


BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee');
END;
/


BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 't',
	record_conflicts => TRUE);
END;
/

BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee1',
	 record_conflicts => TRUE);
END;
/

SELECT * FROM PRODUCT_COMPONENT_VERSION;


SELECT TABLE_OWNER,
       TABLE_NAME, 
       TOMBSTONE_TABLE,
       ROW_RESOLUTION_COLUMN 
  FROM ALL_GG_AUTO_CDR_TABLES
  ORDER BY TABLE_OWNER, TABLE_NAME;
  
  
  BEGIN
  DBMS_GOLDENGATE_ADM.ALTER_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee',
	tombstone_deletes => TRUE);
END;
/

SELECT *  FROM ALL_GG_AUTO_CDR_COLUMNS;

SELECT TABLE_OWNER,
       TABLE_NAME, 
       COLUMN_GROUP_NAME,
       RESOLUTION_COLUMN 
  FROM ALL_GG_AUTO_CDR_COLUMN_GROUPS
  ORDER BY TABLE_OWNER, TABLE_NAME;
  
  
DBMS_GOLDENGATE_ADM.GG_PROCEDURE_REPLICATION_ON RETURN NUMBER;


BEGIN
  DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee');
END;
/
  
 select (*) from BTEST. EMPLOYEE;
  select (*) from BTEST. EMPLOYEE1;
   select (*) from BTEST. T;
   
desc  DBMS_GOLDENGATE_ADM.PURGE_TOMBSTONES;

desc PURGE_TOMBSTONES ;

DROP  USER BTEST CASCADE;

DROP  USER BTEST1 CASCADE;



DECLARE
open_count integer;
BEGIN
-- prevent any further connections
EXECUTE IMMEDIATE 'alter user BTEST account lock';
--kill all sessions
FOR session IN (SELECT sid, serial#
FROM v$session
WHERE username = 'BTEST')
LOOP
-- the most brutal way to kill a session
EXECUTE IMMEDIATE 'alter system kill session ''' || session.sid || ',' || session.serial# || ''' ';
END LOOP;
-- killing is done in the background, so we need to wait a bit
LOOP
SELECT COUNT(*)
INTO open_count
FROM v$session WHERE username = 'BTEST';
EXIT WHEN open_count = 0;
dbms_lock.sleep(0.5);
END LOOP;
-- finally, it is safe to issue the drop statement
EXECUTE IMMEDIATE 'drop user BTEST cascade';
END;

select service_name,count(*) from gv$session group by service_name;

select sid,serial# from v$session where SERVICE_NAME='GGACDR19';

select 'alter system kill session ''' ||sid|| ',' || serial#|| ''' immediate;' from gv$session where SERVICE_NAME='GGACDR49' and username='BTEST1';
select 'alter system kill session ''' ||sid|| ',' || serial#|| ''' immediate;' from gv$session where SERVICE_NAME='GGACDR49' and username='BTEST';

alter system kill session '5638,33593' immediate;

exec rdsadmin.rdsadmin_util.kill(1898,59691,'IMMEDIATE');