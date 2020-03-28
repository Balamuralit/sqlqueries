select name,open_mode from v$database;

select * from dba_objects where owner = 'BTEST' ;

SELECT TABLE_OWNER,
       TABLE_NAME, 
       TOMBSTONE_TABLE,
       ROW_RESOLUTION_COLUMN 
  FROM ALL_GG_AUTO_CDR_TABLES
  ORDER BY TABLE_OWNER, TABLE_NAME;
  
purge dba_recyclebin;  

SELECT sum(bytes) / 1024 / 1024 / 1024 as "Size in GB"  FROM dba_segments  WHERE owner = 'BTEST';

SELECT DS.TABLESPACE_NAME, SEGMENT_NAME, ROUND(SUM(DS.BYTES) / (1024 * 1024)) AS MB
  FROM DBA_SEGMENTS DS
  WHERE SEGMENT_NAME IN (SELECT TABLE_NAME FROM DBA_TABLES)
 GROUP BY DS.TABLESPACE_NAME,
       SEGMENT_NAME;
       
SELECT * FROM (
  SELECT
    owner, object_name, object_type, table_name, ROUND(bytes)/1024/1024/1024 AS meg,
    tablespace_name, extents, initial_extent,
    ROUND(Sum(bytes/1024/1024) OVER (PARTITION BY table_name)) AS total_table_meg
  FROM (
    -- Tables
    SELECT owner, segment_name AS object_name, 'TABLE' AS object_type,
          segment_name AS table_name, bytes,
          tablespace_name, extents, initial_extent
    FROM   dba_segments
    WHERE  segment_type IN ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION')
    UNION ALL
    -- Indexes
    SELECT i.owner, i.index_name AS object_name, 'INDEX' AS object_type,
          i.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_indexes i, dba_segments s
    WHERE  s.segment_name = i.index_name
    AND    s.owner = i.owner
    AND    s.segment_type IN ('INDEX', 'INDEX PARTITION', 'INDEX SUBPARTITION')
    -- LOB Segments
    UNION ALL
    SELECT l.owner, l.column_name AS object_name, 'LOB_COLUMN' AS object_type,
          l.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_lobs l, dba_segments s
    WHERE  s.segment_name = l.segment_name
    AND    s.owner = l.owner
    AND    s.segment_type = 'LOBSEGMENT'
    -- LOB Indexes
    UNION ALL
    SELECT l.owner, l.column_name AS object_name, 'LOB_INDEX' AS object_type,
          l.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_lobs l, dba_segments s
    WHERE  s.segment_name = l.index_name
    AND    s.owner = l.owner
    AND    s.segment_type = 'LOBINDEX'
  )
  WHERE owner in UPPER('&schema_name')
)
WHERE total_table_meg > 10
ORDER BY total_table_meg DESC, meg DESC
/


DEFINE schema_name = 'BTEST'

SELECT * FROM (
  SELECT
    owner, object_name, object_type, table_name, ROUND(bytes)/1024/1024/1024 AS GB,
    tablespace_name, extents, initial_extent,
    ROUND(Sum(bytes/1024/1024) OVER (PARTITION BY table_name)) AS total_table_meg
  FROM (
    -- Tables
    SELECT owner, segment_name AS object_name, 'TABLE' AS object_type,
          segment_name AS table_name, bytes,
          tablespace_name, extents, initial_extent
    FROM   dba_segments
    WHERE  segment_type IN ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION')
    UNION ALL
    -- Indexes
    SELECT i.owner, i.index_name AS object_name, 'INDEX' AS object_type,
          i.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_indexes i, dba_segments s
    WHERE  s.segment_name = i.index_name
    AND    s.owner = i.owner
    AND    s.segment_type IN ('INDEX', 'INDEX PARTITION', 'INDEX SUBPARTITION')
    -- LOB Segments
    UNION ALL
    SELECT l.owner, l.column_name AS object_name, 'LOB_COLUMN' AS object_type,
          l.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_lobs l, dba_segments s
    WHERE  s.segment_name = l.segment_name
    AND    s.owner = l.owner
    AND    s.segment_type = 'LOBSEGMENT'
    -- LOB Indexes
    UNION ALL
    SELECT l.owner, l.column_name AS object_name, 'LOB_INDEX' AS object_type,
          l.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_lobs l, dba_segments s
    WHERE  s.segment_name = l.index_name
    AND    s.owner = l.owner
    AND    s.segment_type = 'LOBINDEX'
  )
  WHERE owner in UPPER('&schema_name')
)
WHERE total_table_meg > 10
ORDER BY total_table_meg DESC, GB DESC
/

select * from ACDRTEST

delete from ACDRTEST where FIRST_NAME='ABCD';

commit;

select owner, constraint_name, constraint_type, status, validated from dba_constraints where owner='BTEST' and TABLE_NAME = 'CARD_DETAILS';  

BEGIN
	DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(
    schema_name => 'BTEST',
    table_name  => 'CARD_DETAILS');
END;
/

select *   FROM ALL_GG_AUTO_CDR_TABLES;


select owner,sum(bytes)/1024/1024/1024 "SIZE in GB" from dba_segments where owner='BTEST' group by owner;

select * from dba_tables where owner='BTEST'