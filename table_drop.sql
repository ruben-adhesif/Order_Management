-- Only for debug, don't have to use in real condition
-- sqlplus ruben/root@xepdb1 @table_drop

DELETE FROM purchaseorderdetail;
DELETE FROM purchaseorderheader;
DELETE FROM productvendor;
DELETE FROM vendor;

DROP TABLE purchaseorderdetail;
DROP TABLE purchaseorderheader;
DROP TABLE productvendor;
DROP TABLE vendor;

EXIT