@echo off

echo ~~~~~~~~~~~~~~~~~~ Table Creation ~~~~~~~~~~~~~~~~~~
sqlplus root/root@xepdb1 @table_drop
sqlplus root/root@xepdb1 @table_creation

echo ~~~~~~~~~~~~~~~~~~ sqlldr vendor ~~~~~~~~~~~~~~~~~~
sqlldr root/root@xepdb1 control=sqlldr/vendor.ctl log=sqlldr/log/vendor.log
echo ~~~~~~~~~~~~~~~~~~ sqlldr product ~~~~~~~~~~~~~~~~~~
sqlldr root/root@xepdb1 control=sqlldr/product.ctl log=sqlldr/log/product.log
echo ~~~~~~~~~~~~~~~~~~ sqlldr header ~~~~~~~~~~~~~~~~~~
sqlldr root/root@xepdb1 control=sqlldr/header.ctl log=sqlldr/log/header.log
echo ~~~~~~~~~~~~~~~~~~ sqlldr detail ~~~~~~~~~~~~~~~~~~
sqlldr root/root@xepdb1 control=sqlldr/detail.ctl log=sqlldr/log/detail.log

::echo ~~~~~~~~~~~~~~~~~~ Connection ~~~~~~~~~~~~~~~~~~
::sqlplus root/root@xepdb1