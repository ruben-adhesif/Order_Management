@echo off

echo ~~~~~~~~~~~~~~~~~~ Table Creation ~~~~~~~~~~~~~~~~~~
sqlplus ruben/root@xepdb1 @table_drop
sqlplus ruben/root@xepdb1 @table_creation

echo ~~~~~~~~~~~~~~~~~~ sqlldr vendor ~~~~~~~~~~~~~~~~~~
sqlldr ruben/root@xepdb1 control=sqlldr/vendor.ctl log=sqlldr/log/vendor.log
echo ~~~~~~~~~~~~~~~~~~ sqlldr product ~~~~~~~~~~~~~~~~~~
sqlldr ruben/root@xepdb1 control=sqlldr/product.ctl log=sqlldr/log/product.log
echo ~~~~~~~~~~~~~~~~~~ sqlldr header ~~~~~~~~~~~~~~~~~~
sqlldr ruben/root@xepdb1 control=sqlldr/header.ctl log=sqlldr/log/header.log
echo ~~~~~~~~~~~~~~~~~~ sqlldr detail ~~~~~~~~~~~~~~~~~~
sqlldr ruben/root@xepdb1 control=sqlldr/detail.ctl log=sqlldr/log/detail.log

::echo ~~~~~~~~~~~~~~~~~~ Connection ~~~~~~~~~~~~~~~~~~
::sqlplus ruben/root@xepdb1