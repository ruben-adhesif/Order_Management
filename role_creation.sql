-- Creat a role to use SQL*Loader
CREATE USER ruben IDENTIFIED BY root;
GRANT DBA TO ruben;

-- Compulsory grant to use SQL*Loader
GRANT EXECUTE ON DBMS_SCHEDULER TO ruben;   -- execute external programs
GRANT EXECUTE ON UTL_FILE TO ruben;		    -- read/write files on database server
GRANT CREATE DIRECTORY TO ruben;		    -- create a directory object to specifies the location of input/output files

-- Check the role right
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'RUBEN';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RUBEN';
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'RUBEN';