select * from employee;

select * from t;

select count(*) from EMPLOYEE;
select count(*) from EMPLOYEE1;
select count (*) from T;


begin
    for i in 1 .. 100000
    loop
        insert into t values ( i, 'x' );
    end loop;
    commit;
end;
/