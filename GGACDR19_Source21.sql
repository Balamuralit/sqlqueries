select * from dba_users;
create bigfile tablespace BTEST;
CREATE USER BTEST IDENTIFIED BY BTEST DEFAULT TABLESPACE BTEST;
grant dba to BTEST;

create table acdrtest ( ID VARCHAR2(4000 BYTE) NOT NULL primary key, First_name char(50) );
commit;
select OWNER,OBJECT_NAME from dba_objects where OWNER='BTEST';

-- AS sys OR master user
BEGIN
	DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'acdrtest');
END;
/

SELECT TABLE_OWNER,
       TABLE_NAME, 
       TOMBSTONE_TABLE,
       ROW_RESOLUTION_COLUMN 
  FROM ALL_GG_AUTO_CDR_TABLES
  ORDER BY TABLE_OWNER, TABLE_NAME;
  
 desc DT$_ACDRTEST; 
select * from DT$_ACDRTEST; 

select count(*)  from acdrtest; 

---- Load data into table acdrtest

begin
    for i in 1 .. 900000
    loop
        insert into acdrtest values ( i, 'ABCD' );
    end loop;
    commit;
end;
/


begin
    for i in 900001 .. 99900000
    loop
        insert into acdrtest values ( i, 'DEF' );
    end loop;
    commit;
end;
/

-- create service

exec dbms_service.create_service(service_name=>'ACDRLOAD_ON', network_name=>'ACDRLOAD_ON', dtp=>true);
exec dbms_service.start_service('ACDRLOAD_ON');

exec dbms_service.stop_service('ACDRLOAD_ON');


select * from v$active_services;

select * from v$active_services where name='ACDRLOAD_ON';
