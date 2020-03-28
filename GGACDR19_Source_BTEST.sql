create table Employee(
  ID                 VARCHAR2(4 BYTE)         NOT NULL primary key,
  First_Name         VARCHAR2(10 BYTE),
  Last_Name          VARCHAR2(10 BYTE)
)

create table Employee(
  ID                 VARCHAR2(4000 BYTE)         NOT NULL primary key,
  First_Name         VARCHAR2(10 BYTE),
  Last_Name          VARCHAR2(10 BYTE)
)

desc Employee
select * from employee;



BEGIN
  FOR v_LoopCounter IN 1..50 LOOP
    INSERT INTO employee (id)
      VALUES (v_LoopCounter);
  END LOOP;
END;
/


BEGIN
  FOR v_LoopCounter IN 1500001..9500000 LOOP
    INSERT INTO employee (id)
      VALUES (v_LoopCounter);
  END LOOP;
  commit;
END;
/
commit;

select * from employee;

select count(*)  from employee;

create table acdrtest ( x int NOT NULL primary key, y char(50) );

create table acdrtest ( ID VARCHAR2(4000 BYTE) NOT NULL primary key, First_name char(50) );

commit;

select * from acdrtest;

desc DT$_ACDRTEST; 
select * from DT$_ACDRTEST; 

select count(*)  from acdrtest;

BEGIN
	DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'acdrtest');
END;
/

delete from acdrtest where FIRST_NAME='DEF'; COMMIT;

delete from acdrtest where FIRST_NAME='ABC'; COMMIT;

begin
    for i in 200001 .. 300000
    loop
        insert into acdrtest values ( i, 'DEF' );
    end loop;
    commit;
end;
/

begin
    for i in 1 .. 900000
    loop
        insert into acdrtest values ( i, 'ABCD' );
    end loop;
    commit;
end;
/

select * from acdrtest order by 1;

update acdrtest set first_name='DEF' where first_name='XYZ'; COMMIT;

select count(*) from acdrtest;
select * from acdrtest where first_name='ABC';
select * from acdrtest where first_name='XYZ';

select * from acdrtest where ID like '1%'

select count (*) from acdrtest;


create table Employee1(
  ID                 VARCHAR2(4 BYTE)         NOT NULL primary key,
  First_Name         VARCHAR2(10 BYTE)
) 

commit;

BEGIN
  FOR v_LoopCounter IN 1..500 LOOP
    INSERT INTO employee1 (id)
      VALUES (v_LoopCounter);
  END LOOP;
END;
/
  
commit;

create table Employee2(
  ID                 VARCHAR2(4 BYTE)         NOT NULL primary key,
  First_Name         VARCHAR2(10 BYTE)
) 

commit;

BEGIN
  FOR v_LoopCounter IN 1..500 LOOP
    INSERT INTO employee2 (id)
      VALUES (v_LoopCounter);
  END LOOP;
END;
/
  
commit;

desc employee1;

select * from employee1;

drop table Employee CASCADE CONSTRAINTS ;
drop table t CASCADE CONSTRAINTS ;
drop table Employee1 CASCADE CONSTRAINTS ;
drop table Employee2 CASCADE CONSTRAINTS ;

COMMIT;

commit;


select count(*) from EMPLOYEE;
select count(*) from EMPLOYEE1;
select count (*) from T;

select * from EMPLOYEE;
select * from EMPLOYEE1;
select * from T;

delete from EMPLOYEE where First_Name IS NULL;

delete from t where y='x';

commit;


select owner,
       segment_name,
       partition_name,
       segment_type,
       bytes / 1024/1024 /1024 "GB" 
  from dba_segments 
 where owner = 'BTEST' order by bytes;
 
 select * from ORDERS;
 
 desc CARD_DETAILS;
 
 desc ACDR_ARD_DETAILS
 
 select * from CARD_DETAILS order by 1;
 
 
  select * from ACDR_ARD_DETAILS order by 1;
 
 select count(*) from GGACDR_CARD_DETAILS;
 
 
 
 ALTER TABLE CARD_DETAILS ADD CONSTRAINT CARD_ID_PK PRIMARY KEY (CARD_ID);
 
 
 INSERT INTO GGACDR_CARD_DETAILS SELECT * FROM CARD_DETAILS where CARD_ID > 100;
 
 desc dba_constraints
 
 select * from dba_constraints where owner='BTEST' order by 4;
 
 
  CREATE TABLE "BTEST"."ACDR_ARD_DETAILS" 
   (	"CARD_ID" NUMBER(12,0) CONSTRAINT "ACDR_CARD_ID_NN" NOT NULL ENABLE, 
	"CUSTOMER_ID" NUMBER(12,0) CONSTRAINT "ACDR_CARD_CUST_ID_NN" NOT NULL ENABLE, 
	"CARD_TYPE" VARCHAR2(30 CHAR) CONSTRAINT "ACDR_CARD_TYPE_NN" NOT NULL ENABLE, 
	"CARD_NUMBER" NUMBER(12,0) CONSTRAINT "ACDR_CARD_NUMBER_NN" NOT NULL ENABLE, 
	"EXPIRY_DATE" DATE CONSTRAINT "ACDR_EXPIRY_DATE_NN" NOT NULL ENABLE, 
	"IS_VALID" VARCHAR2(1 CHAR) CONSTRAINT "ACDR_IS_VALID_NN" NOT NULL ENABLE, 
	"SECURITY_CODE" NUMBER(6,0), 
	SUPPLEMENTAL LOG DATA (ALL) COLUMNS
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 16 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 8388608 NEXT 8388608 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "BTEST" ;
  CREATE UNIQUE INDEX "BTEST"."ACDR_ARD_DETAILS_PK" ON "BTEST"."ACDR_ARD_DETAILS" ("CARD_ID") REVERSE 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "BTEST" 
  PARALLEL 5 ;
ALTER TABLE "BTEST"."ACDR_ARD_DETAILS" ADD CONSTRAINT "ACDR_ARD_DETAILS_PK" PRIMARY KEY ("CARD_ID") USING INDEX "BTEST"."ACDR_ARD_DETAILS_PK"  ENABLE NOVALIDATE;



  CREATE TABLE "BTEST"."GGACDR_CARD_DETAILS" 
   (	"CARD_ID" NUMBER(12,0) CONSTRAINT "GGACDR_CARD_ID_NN" NOT NULL ENABLE, 
	"CUSTOMER_ID" NUMBER(12,0) CONSTRAINT "GGACDR_CARD_CUST_ID_NN" NOT NULL ENABLE, 
	"CARD_TYPE" VARCHAR2(30 CHAR) CONSTRAINT "GGACDR_CARD_TYPE_NN" NOT NULL ENABLE, 
	"CARD_NUMBER" NUMBER(12,0) CONSTRAINT "GGACDR_CARD_NUMBER_NN" NOT NULL ENABLE, 
	"EXPIRY_DATE" DATE CONSTRAINT "GGACDR_EXPIRY_DATE_NN" NOT NULL ENABLE, 
	"IS_VALID" VARCHAR2(1 CHAR) CONSTRAINT "GGACDR_IS_VALID_NN" NOT NULL ENABLE, 
	"SECURITY_CODE" NUMBER(6,0), 
	SUPPLEMENTAL LOG DATA (ALL) COLUMNS
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 16 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 8388608 NEXT 8388608 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "BTEST" ;
  CREATE UNIQUE INDEX "BTEST"."GGACDR_CARD_DETAILS_PK" ON "BTEST"."GGACDR_CARD_DETAILS" ("CARD_ID") REVERSE 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "BTEST" 
  PARALLEL 5 ;
ALTER TABLE "BTEST"."GGACDR_CARD_DETAILS" ADD CONSTRAINT "GGACDR_CARD_DETAILS_PK" PRIMARY KEY ("CARD_ID") USING INDEX "BTEST"."GGACDR_CARD_DETAILS_PK"  ENABLE NOVALIDATE;