-- sqlplus ruben/root@xepdb1 @table_creation

CREATE TABLE vendor (
    businessentityid INT PRIMARY KEY,
    accountnumber VARCHAR(50),
    name VARCHAR(100),
    creditrating INT,
    preferredvendorstatus CHAR(1),
    activeflag CHAR(1),
    purchasingwebserviceurl VARCHAR2(255),
    modifieddate TIMESTAMP
);

CREATE TABLE productvendor (
    productid INT,
    businessentityid INT,
    averageleadtime INT,
    standardprice DECIMAL(10, 2),
    lastreceiptcost DECIMAL(6, 4),
    lastreceiptdate TIMESTAMP,
    minorderqty INT,
    maxorderqty INT,
    onorderqty INT,
    unitmeasurecode VARCHAR2(3),
    modifieddate TIMESTAMP,
    CONSTRAINT productvendor_primary_key PRIMARY KEY (productid, businessentityid),
    FOREIGN KEY (businessentityid) REFERENCES vendor(businessentityid)
);

CREATE TABLE purchaseorderheader (
    purchaseorderid INT PRIMARY KEY,
    revisionnumber INT,
    status INT,
    employeeid INT,
    vendorid INT,
    shipmethodid INT,
    orderdate TIMESTAMP,
    shipdate TIMESTAMP,
    subtotal DECIMAL(10, 2),
    taxamt DECIMAL(10, 4),
    freight DECIMAL(10, 4),
    modifieddate TIMESTAMP
);

CREATE TABLE purchaseorderdetail (
    purchaseorderid INT,
    purchaseorderdetailid INT PRIMARY KEY,
    duedate TIMESTAMP,
    orderqty INT,
    productid INT,
    unitprice DECIMAL(10, 2),
    receivedqty DECIMAL(10, 2),
    rejectedqty DECIMAL(10, 2),
    modifieddate TIMESTAMP,
    --FOREIGN KEY (productid) REFERENCES productvendor(productid),
    FOREIGN KEY (purchaseorderid) REFERENCES purchaseorderheader(purchaseorderid)
);

EXIT