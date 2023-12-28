-- Creat a role to use SQL*Loader
CREATE USER root IDENTIFIED BY root;
GRANT DBA TO root;

-- Compulsory grant to use SQL*Loader
GRANT EXECUTE ON DBMS_SCHEDULER TO root;   -- execute external programs
GRANT EXECUTE ON UTL_FILE TO root;		    -- read/write files on database server
GRANT CREATE DIRECTORY TO root;		    -- create a directory object to specifies the location of input/output files

-- Check the role right
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'ROOT';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'ROOT';
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'ROOT';