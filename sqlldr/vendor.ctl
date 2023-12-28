OPTIONS (SKIP=1)
LOAD DATA
INFILE 'data/vendor.csv'
BADFILE 'sqlldr/log/vendor.bad'
INTO TABLE vendor
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
  businessentityid,
  accountnumber,
  name,
  creditrating,
  preferredvendorstatus CHAR(1),
  activeflag CHAR(1),
  purchasingwebserviceurl,
  modifieddate TIMESTAMP "YYYY-MM-DD HH24:MI:SS.FF"
)