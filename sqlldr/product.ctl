OPTIONS (SKIP=1)
LOAD DATA
INFILE 'data/productvendor.csv'
BADFILE 'sqlldr/log/productvendor.bad'
INTO TABLE productvendor
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  productid,
  businessentityid,
  averageleadtime,
  standardprice,
  lastreceiptcost,
  lastreceiptdate TIMESTAMP "YYYY-MM-DD HH24:MI:SS.FF",
  minorderqty,
  maxorderqty,
  onorderqty,
  unitmeasurecode,
  modifieddate TIMESTAMP "YYYY-MM-DD HH24:MI:SS.FF"
)