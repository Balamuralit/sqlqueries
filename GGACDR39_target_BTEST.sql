SELECT TABLE_OWNER,
       TABLE_NAME, 
       TOMBSTONE_TABLE,
       ROW_RESOLUTION_COLUMN 
  FROM ALL_GG_AUTO_CDR_TABLES
  ORDER BY TABLE_OWNER, TABLE_NAME;
  
desc Employee;

select * from Employee;

create table Employee3(
  ID                 VARCHAR2(4 BYTE)         NOT NULL primary key,
  First_Name         VARCHAR2(10 BYTE)
) 

commit;

BEGIN
  FOR v_LoopCounter IN 1..500 LOOP
    INSERT INTO Employee3 (id)
      VALUES (v_LoopCounter);
  END LOOP;
END;
/
  
commit;

BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'Employee3',
	 record_conflicts => TRUE);
END;
/

desc dba_objects;


