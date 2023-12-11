-- Only for debug, don't have to use in real condition
-- sqlplus system/root@xepdb1 @table_drop

-- Delete all the row
DELETE FROM purchaseorderdetail;
DELETE FROM purchaseorderheader;
DELETE FROM productvendor;
DELETE FROM vendor;

-- Drop the table
DROP TABLE purchaseorderdetail;
DROP TABLE purchaseorderheader;
DROP TABLE productvendor;
DROP TABLE vendor;

EXIT