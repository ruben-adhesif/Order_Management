@echo off
sqlplus ruben/root@xepdb1 @table_creation
sqlldr ruben/root@xepdb1 control=sqlldr/vendor.ctl log=sqlldr/log/vendor.log
sqlldr ruben/root@xepdb1 control=sqlldr/product.ctl log=sqlldr/log/product.log
sqlldr ruben/root@xepdb1 control=sqlldr/header.ctl log=sqlldr/log/header.log
sqlldr ruben/root@xepdb1 control=sqlldr/detail.ctl log=sqlldr/log/detail.log

echo:
echo ~~~~~~~~~~~~~~~~~~~~~~
echo ~~Intialisation done~~
echo ~~~~~~~~~~~~~~~~~~~~~~
sqlplus ruben/root@xepdb1