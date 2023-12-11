LOAD DATA
INFILE 'data/purchaseorderdetail.csv'
BADFILE 'sqlldr/log/purchaseorderdetail.bad'
INTO TABLE purchaseorderdetail
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  purchaseorderid,
  purchaseorderdetailid,
  duedate TIMESTAMP "YYYY-MM-DD HH24:MI:SS.FF",
  orderqty,
  productid,
  unitprice,
  receivedqty,
  rejectedqty,
  modifieddate TIMESTAMP "YYYY-MM-DD HH24:MI:SS.FF"
)