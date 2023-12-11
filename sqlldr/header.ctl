LOAD DATA
INFILE 'data/purchaseorderheader.csv'
BADFILE 'sqlldr/log/purchaseorderheader.bad'
INTO TABLE purchaseorderheader
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  purchaseorderid,
  revisionnumber,
  status,
  employeeid,
  vendorid,
  shipmethodid,
  orderdate TIMESTAMP "YYYY-MM-DD HH24:MI:SS.FF",
  shipdate TIMESTAMP "YYYY-MM-DD HH24:MI:SS.FF",
  subtotal DECIMAL EXTERNAL,
  taxamt DECIMAL EXTERNAL,
  freight DECIMAL EXTERNAL,
  modifieddate TIMESTAMP "YYYY-MM-DD HH24:MI:SS.FF"
)