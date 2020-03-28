--------------------------------------------------------
--  File created - Friday-January-24-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger AUTOSTART_DATABASE_SERVICES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MASTER"."AUTOSTART_DATABASE_SERVICES" 
after startup on database
begin
    for i in (select name from dba_services where dtp='Y') loop
        begin
            dbms_service.start_service(i.name);
            -- continue if service already started
            exception when others then if sqlcode in (-44305) then null; else raise; end if;
        end;
    end loop;
end;
/
ALTER TRIGGER "MASTER"."AUTOSTART_DATABASE_SERVICES" ENABLE;
--------------------------------------------------------
--  DDL for Function VERIFY_FUNCTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "MASTER"."VERIFY_FUNCTION" 
    (username varchar2,
        password varchar2,
        old_password varchar2)
RETURN boolean IS
    n boolean;
    m integer;
    differ integer;
    isdigit boolean;
    ischar  boolean;
    digitarray varchar2(20);
    chararray varchar2(52);
BEGIN
    digitarray:= '0123456789';
    chararray:= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

    -- Check if the password is same as the username
    IF NLS_LOWER(password) = NLS_LOWER(username) THEN
        raise_application_error(-20001, 'Password same as or similar to user');
    END IF;

    -- Check for the minimum length of the password
    IF length(password) < 7 THEN
        raise_application_error(-20002, 'Password length less than 7');
    END IF;

    -- Check if the password is too simple. A dictionary of words may be
    -- maintained and a check may be made so as not to allow the words
    -- that are too simple for the password.
    IF NLS_LOWER(password) IN ('welcome', 'database', 'account', 'user', 'password', 'oracle', 'computer', 'abcd') THEN
        raise_application_error(-20002, 'Password too simple');
    END IF;

    -- Check if the password contains at least one letter  and one digit
    -- 1. Check for the digit
    isdigit:=FALSE;
    m := length(password);
    FOR i IN 1..10 LOOP
        FOR j IN 1..m LOOP
            IF substr(password,j,1) = substr(digitarray,i,1) THEN
                isdigit:=TRUE;
                GOTO findchar;
            END IF;
        END LOOP;
    END LOOP;
    IF isdigit = FALSE THEN
        raise_application_error(-20003, 'Password should contain at least one digit, one character and one punctuation');
    END IF;
    -- 2. Check for the character
    <<findchar>>
    ischar:=FALSE;
    FOR i IN 1..length(chararray) LOOP
        FOR j IN 1..m LOOP
            IF substr(password,j,1) = substr(chararray,i,1) THEN
                ischar:=TRUE;
            END IF;
        END LOOP;
    END LOOP;
    IF ischar = FALSE THEN
        raise_application_error(-20003, 'Password should contain at least one \
                digit  and one character ');
    END IF;
    -- Everything is fine; return TRUE ;
RETURN(TRUE);
END;

/
--------------------------------------------------------
--  DDL for Function VERIFY_FUNCTION2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "MASTER"."VERIFY_FUNCTION2" 
    (username varchar2,
        password varchar2,
        old_password varchar2)
RETURN boolean IS
    n boolean;
    m integer;
    differ integer;
    isdigit boolean;
    ischar  boolean;
    digitarray varchar2(20);
    chararray varchar2(52);
BEGIN
    digitarray:= '0123456789';
    chararray:= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

    -- Check if the password is same as the username
    IF NLS_LOWER(password) = NLS_LOWER(username) THEN
        raise_application_error(-20001, 'Password same as or similar to user');
    END IF;

    -- Check for the minimum length of the password
    IF length(password) < 10 THEN
        raise_application_error(-20002, 'Password length less than 10');
    END IF;

    -- Check if the password is too simple. A dictionary of words may be
    -- maintained and a check may be made so as not to allow the words
    -- that are too simple for the password.
    IF NLS_LOWER(password) IN ('welcome', 'database', 'account', 'user', 'password', 'oracle', 'computer', 'abcd') THEN
        raise_application_error(-20002, 'Password too simple');
    END IF;
    -- Check if the password contains at least one letter  and one digit
    -- 1. Check for the digit
    isdigit:=FALSE;
    m := length(password);
    FOR i IN 1..10 LOOP
        FOR j IN 1..m LOOP
            IF substr(password,j,1) = substr(digitarray,i,1) THEN
                isdigit:=TRUE;
                GOTO findchar;
            END IF;
        END LOOP;
    END LOOP;
    IF isdigit = FALSE THEN
        raise_application_error(-20003, 'Password should contain at least one digit, one character and one punctuation');
    END IF;
    -- 2. Check for the character
    <<findchar>>
    ischar:=FALSE;
    FOR i IN 1..length(chararray) LOOP
        FOR j IN 1..m LOOP
            IF substr(password,j,1) = substr(chararray,i,1) THEN
                ischar:=TRUE;
            END IF;
        END LOOP;
    END LOOP;
            IF ischar = FALSE THEN
        raise_application_error(-20003, 'Password should contain at least one \
                digit  and one character ');
    END IF;
    -- Everything is fine; return TRUE ;
RETURN(TRUE);
END;

/
