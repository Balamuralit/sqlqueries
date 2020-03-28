drop table Employee ;
drop table t CASCADE CONSTRAINTS ;
drop table Employee1 CASCADE CONSTRAINTS ;
drop table Employee2 CASCADE CONSTRAINTS ;




create table t ( x int NOT NULL primary key, y char(50) );


begin
    for i in 1 .. 100000
    loop
        insert into t values ( i, 'x' );
    end loop;
    commit;
end;
/

select count (*) from t;

create table Employee1(
  ID                 VARCHAR2(4 BYTE)         NOT NULL primary key,
  First_Name         VARCHAR2(10 BYTE)
);

commit;

BEGIN
  FOR v_LoopCounter IN 1..500 LOOP
    INSERT INTO employee1 (id)
      VALUES (v_LoopCounter);
  END LOOP;
END;
/
  
commit;

BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name       => 'BTEST',
    table_name        => 'employee1',
    tombstone_deletes => TRUE,
      record_conflicts => TRUE);
END;
/

BEGIN
  DBMS_GOLDENGATE_ADM.ALTER_AUTO_CDR(
    schema_name       => 'BTEST',
    table_name        => 'employee1',
    record_conflicts => TRUE);
END;
/

BEGIN
  DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name       => 'BTEST',
    table_name        => 'T',
    tombstone_deletes => TRUE,
	record_conflicts => TRUE);
END;
/


  