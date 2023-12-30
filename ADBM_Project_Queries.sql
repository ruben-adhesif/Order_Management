---------------------- Question 1 ---------------------
----- A -----
//DESC vendor;
SELECT v.name, pv.productid
FROM vendor v
JOIN productvendor pv 
ON v.businessentityid = pv.businessentityid
WHERE v.creditrating = 5
    AND productid > 500;
-- optimization
DROP INDEX idx_vendor_credit_product;
CREATE INDEX idx_vendor_credit_product ON vendor (creditrating, businessentityid);

/*DROP MATERIALIZED VIEW vendor_product_mv;
CREATE MATERIALIZED VIEW vendor_product_mv
BUILD IMMEDIATE REFRESH FAST ON COMMIT
AS
SELECT v.businessentityid, v.name, p.productid
FROM vendor v
JOIN productvendor p ON v.businessentityid = p.businessentityid;

CREATE INDEX idx_mv_credit_product ON vendor_product_mv (creditrating, productid);
*/
-- Usage: SELECT * FROM vendor_product_mv;


----- B -----
SELECT pod.purchaseorderid, poh.orderdate, pod.purchaseorderdetailid, pod.orderqty, pod.productid
FROM purchaseorderdetail pod
JOIN purchaseorderheader poh
ON pod.purchaseorderid = poh.purchaseorderid
WHERE pod.orderqty > 500;
-- optimization
DROP INDEX idx_pod_order_qty;
CREATE INDEX idx_pod_order_qty ON purchaseorderdetail (orderqty, purchaseorderid);
DROP INDEX idx_pod_order_qty_poh;
CREATE INDEX idx_pod_order_qty_poh ON purchaseorderdetail (orderqty, purchaseorderid, purchaseorderdetailid);


----- C -----
SELECT pod.purchaseorderid, poh.vendorid, pod.purchaseorderdetailid, pod.productid, pod.unitprice
FROM purchaseorderdetail pod
JOIN purchaseorderheader poh
ON pod.purchaseorderid = poh.purchaseorderid
WHERE pod.purchaseorderid BETWEEN 1400 AND 1600;
-- optimization
DROP INDEX idx_poh_vendorid
CREATE INDEX idx_poh_vendorid ON purchaseorderheader (vendorid);

SELECT vendorid, v.name, COUNT(purchaseorderid) AS Nbr_order, SUM(subtotal+taxamt+freight) AS Order_price
FROM purchaseorderheader poh
JOIN vendor v
ON poh.vendorid = v.businessentityid
GROUP BY vendorid, v.name
ORDER BY order_price DESC;


----- D -----
SELECT vendorid, v.name, COUNT(purchaseorderid) AS Nbr_order, SUM(subtotal+taxamt+freight) AS Order_price
FROM purchaseorderheader poh
JOIN vendor v
ON poh.vendorid = v.businessentityid
GROUP BY vendorid, v.name
ORDER BY order_price DESC;
-- optimized solution


----- E -----
SELECT COUNT(purchaseorderid)/COUNT(DISTINCT vendorid) AS avg_nb_order, SUM(subtotal+taxamt+freight)/COUNT(DISTINCT vendorid) AS avg_cost
FROM purchaseorderheader;
-- optimized solution

----- F -----
SELECT poh.vendorid, v.name, AVG(pod.rejectedqty/pod.receivedqty) AS rej_rec_perc
FROM purchaseorderheader poh
JOIN purchaseorderdetail pod ON poh.purchaseorderid = pod.purchaseorderid
JOIN vendor v
ON poh.vendorid = v.businessentityid
GROUP BY poh.vendorid, v.name
ORDER BY rej_rec_perc DESC
FETCH FIRST 10 ROWS ONLY;
-- optimized solution

----- G -----
DROP INDEX idx_pod_orderqty;
CREATE INDEX idx_pod_orderqty ON purchaseorderdetail (orderqty);

SELECT poh.vendorid, v.name, poh.purchaseorderid,SUM(pod.orderqty) AS total_order
FROM purchaseorderheader poh
JOIN purchaseorderdetail pod
ON poh.purchaseorderid = pod.purchaseorderid
JOIN vendor v
ON poh.vendorid = v.businessentityid
GROUP BY poh.vendorid, v.name, poh.purchaseorderid
ORDER BY total_order DESC
FETCH FIRST 10 ROWS ONLY;
-- optimized solution

----- H -----
SELECT productid, SUM(orderqty) AS  total
FROM purchaseorderdetail
GROUP BY productid
ORDER BY total DESC
FETCH FIRST 10 ROWS ONLY;
-- optimized solution

----- I -----
-- 1. Calculate the Running Total and Average
SELECT
    distinct(duedate),
    orderqty,
    SUM(orderqty) OVER (ORDER BY duedate) AS running_total,
    AVG(orderqty) OVER (ORDER BY duedate) AS running_avg
FROM purchaseorderdetail;
-- 2. Rank Vendors Based on Total Sales
SELECT
    vendorid,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS vendor_rank
FROM (
    SELECT
        vendorid,
        SUM(subtotal) AS total_sales
    FROM purchaseorderheader
    GROUP BY vendorid
) vendor_sales;
-- 3.Calculate the Difference in Order Quantity from Previous Row
SELECT
    duedate,
    orderqty,
    orderqty - LAG(orderqty) OVER (ORDER BY duedate) AS qty_difference
FROM purchaseorderdetail;


---------------------- Question 2 ---------------------
----- J -----
DROP TABLE Transaction_History
CREATE TABLE Transaction_History (
    purchaseorderid NUMBER,
    purchaseorderdetailid NUMBER,
    duedate TIMESTAMP(3) NULL,
    orderqty NUMBER NULL,
    productid NUMBER NULL,
    unitprice NUMBER NULL,
    receivedqty NUMBER NULL,
    rejectedqty NUMBER NULL,
    modifieddate TIMESTAMP(3) NULL
);


CREATE OR REPLACE TRIGGER trg_purchaseorderdetail_update
BEFORE UPDATE ON PurchaseOrderDetail
FOR EACH ROW
BEGIN
    -- Insert row into Transaction_History
    INSERT INTO Transaction_History
    VALUES (:OLD.purchaseorderid, :OLD.purchaseorderdetailid, :OLD.duedate, :OLD.orderqty,
            :OLD.productid, :OLD.unitprice, :OLD.receivedqty, :OLD.rejectedqty, :OLD.modifieddate);

    -- Update ModifiedDate in PurchaseOrderDetail
    :NEW.modifieddate := SYSTIMESTAMP;

    -- Update PurchaseOrderHeader.SubTotal column
    UPDATE PurchaseOrderHeader
    SET SubTotal = (
        SELECT SUM(subtotal)
        FROM PurchaseOrderDetail
        WHERE purchaseorderid = :NEW.purchaseorderid
    )
    WHERE purchaseorderid = :NEW.purchaseorderid;

END;
/

----- K -----
CREATE OR REPLACE TRIGGER trg_prevent_inconsistent_subtotal_update
BEFORE UPDATE OF subtotal ON PurchaseOrderHeader
FOR EACH ROW
DECLARE
    v_calculated_subtotal NUMBER;
BEGIN
    -- Calculate SubTotal from PurchaseOrderDetail for the corresponding PurchaseOrderHeader
    SELECT SUM(productid*orderqty)
    INTO v_calculated_subtotal
    FROM PurchaseOrderDetail
    WHERE purchaseorderid = :NEW.purchaseorderid;

    -- If the calculated SubTotal doesn't match the new SubTotal value, raise an error
    IF :NEW.subtotal <> v_calculated_subtotal THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot update SubTotal if corresponding data in PurchaseOrderDetail is inconsistent.');
    END IF;
END;
/