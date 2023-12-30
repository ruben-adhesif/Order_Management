@echo off

echo ~~~~~~~~~~~~~~~~~~ Initialisation ~~~~~~~~~~~~~~~~~~
:: May modify the code with your password system
sqlplus "sys/root@xepdb1 as sysdba" @role_creation
sqlplus owner/root@xepdb1 @table_creation

echo:
echo ~~~~~~~~~~~~~~~~~~ SQL Loader ~~~~~~~~~~~~~~~~~~
sqlldr owner/root@xepdb1 control=sqlldr/vendor.ctl log=sqlldr/log/vendor.log bad=sqlldr/bad/vendor.bad
sqlldr owner/root@xepdb1 control=sqlldr/product.ctl log=sqlldr/log/product.log bad=sqlldr/bad/product.bad
sqlldr owner/root@xepdb1 control=sqlldr/header.ctl log=sqlldr/log/header.log bad=sqlldr/bad/header.bad
sqlldr owner/root@xepdb1 control=sqlldr/detail.ctl log=sqlldr/log/detail.log bad=sqlldr/bad/detail.bad

echo:
echo ~~~~~~~~~~~~~~~~~~ Connection ~~~~~~~~~~~~~~~~~~
sqlplus owner/root@xepdb1