@echo off
sqlplus system/root@xepdb1 @table_creation.sql
sqlldr system/root@xepdb1 control=sqlldr/vendor.ctl log=sqlldr/log/vendor.log
sqlldr system/root@xepdb1 control=sqlldr/product.ctl log=sqlldr/log/product.log
sqlldr system/root@xepdb1 control=sqlldr/header.ctl log=sqlldr/log/header.log
sqlldr system/root@xepdb1 control=sqlldr/detail.ctl log=sqlldr/log/detail.log
sqlplus system/root@xepdb1