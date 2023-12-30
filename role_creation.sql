-- IF EXIST DROP USER OWNER
DROP USER owner CASCADE;

-- Creat a role to use SQL*Loader
CREATE USER owner IDENTIFIED BY root;
GRANT DBA TO owner;

-- Compulsory grant to use SQL*Loader
GRANT EXECUTE ON DBMS_SCHEDULER TO owner;   -- execute external programs
GRANT EXECUTE ON UTL_FILE TO owner;		    -- read/write files on database server
GRANT CREATE DIRECTORY TO owner;		    -- create a directory object to specifies the location of input/output files

-- Check the role right
-- SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'OWNER';
-- SELECT PRIVILEGE FROM DBA_SYS_PRIVS WHERE GRANTEE = 'OWNER';

EXIT