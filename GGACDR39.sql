select * from v$database

select * from dba_services

select * from v$active_services


BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee');
END;
/


BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee');
END;
/


BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee');
END;
/

SELECT TABLE_OWNER,
       TABLE_NAME, 
       TOMBSTONE_TABLE,
       ROW_RESOLUTION_COLUMN 
  FROM ALL_GG_AUTO_CDR_TABLES
  ORDER BY TABLE_OWNER, TABLE_NAME;
  
  
BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee');
END;
/


BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee3',
	 record_conflicts => TRUE);
END;
/

desc BTEST.Employee2;

select * from dba_objects where owner='BTEST'

exec dbms_service.start_service('GGACDR39_GG');

SELECT * FROM PRODUCT_COMPONENT_VERSION;


show parameter aq_tm_processes


alter user gger identified by gger


create bigfile tablespace BTEST;

CREATE USER BTEST IDENTIFIED BY BTEST DEFAULT TABLESPACE BTEST;
grant dba to BTEST;

grant dba to gger;


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


show parameter  gold