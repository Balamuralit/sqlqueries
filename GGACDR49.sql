select * from v$database;

select * from dba_services;

select * from v$active_services;

select * from dba_tablespaces;

exec dbms_service.create_service(service_name=>'GGACDR49_GG', network_name=>'GGACDR49_GG', dtp=>true);
exec dbms_service.start_service('GGACDR49_GG')

exec dbms_service.delete_service('GGACDR19_A')

select CAPTURE_NAME,status from DBA_CAPTURE; 

exec DBMS_CAPTURE_ADM.DROP_CAPTURE('OGG$CAP_LACDR1');

SELECT * FROM PRODUCT_COMPONENT_VERSION;


select FORCE_LOGGING,SUPPLEMENTAL_LOG_DATA_MIN,SUPPLEMENTAL_LOG_DATA_PK,SUPPLEMENTAL_LOG_DATA_UI,SUPPLEMENTAL_LOG_DATA_FK,SUPPLEMENTAL_LOG_DATA_ALL from v$database;

exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD');


exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD', p_type=>'UNIQUE');


exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD', p_type=>'FOREIGN KEY');


exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD', p_type=>'ALL');

exec rdsadmin.rdsadmin_util.alter_supplemental_logging(p_action=>'ADD', p_type=>'PRIMARY KEY');

exec  rdsadmin.rdsadmin_util.force_logging(p_enable => true);


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
  
  select sum(bytes)/power(1024,2) m, segment_name, segment_type
from dba_segments where owner = 'BTEST'
group by segment_name, segment_type
order by 1;
  
select * from dba_objects where OWNER='BTEST';

select * from dba_users where username='BTEST';
    
select owner,sum(bytes)/1024/1024/1024 "SIZE in GB" from dba_segments where owner='BTEST' group by owner;
  
   
  select name,open_mode from v$database;
  
  desc dba_objects
  
  select OWNER,OBJECT_NAME from dba_objects where OWNER='BTEST';
  
  select owner,sum(bytes)/1024/1024/1024 "SIZE in GB" from dba_segments where owner='BTEST' group by owner;
  
  desc 
  