create bigfile tablespace BTEST;

CREATE USER BTEST IDENTIFIED BY BTEST DEFAULT TABLESPACE BTEST;
grant dba to BTEST;

create bigfile tablespace BTEST1;

CREATE USER BTEST1 IDENTIFIED BY BTEST1 DEFAULT TABLESPACE BTEST1;
grant dba to BTEST1;

select * from dba_users;

select * from dba_tablespaces;

exec dbms_service.start_service('GGACDR29_GG');

select * from dba_services;
select * from v$active_services;

select FORCE_LOGGING,SUPPLEMENTAL_LOG_DATA_MIN,SUPPLEMENTAL_LOG_DATA_PK,SUPPLEMENTAL_LOG_DATA_UI,SUPPLEMENTAL_LOG_DATA_FK,SUPPLEMENTAL_LOG_DATA_ALL from v$database;


exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD');
exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD', p_type=>'UNIQUE');
exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD', p_type=>'FOREIGN KEY');
exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD', p_type=>'ALL');

select FORCE_LOGGING,SUPPLEMENTAL_LOG_DATA_MIN,SUPPLEMENTAL_LOG_DATA_PK,SUPPLEMENTAL_LOG_DATA_UI,SUPPLEMENTAL_LOG_DATA_FK,SUPPLEMENTAL_LOG_DATA_ALL from v$database;



 select count(*) from GGACDR_CARD_DETAILS;