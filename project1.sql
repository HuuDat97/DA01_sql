select * from SALES_DATASET_RFM_PRJ
1.
alter table SALES_DATASET_RFM_PRJ

alter column priceeach type numeric using (trim(priceeach)::numeric),
alter column orderdate type date using (trim(orderdate)::date),
alter column ordernumber type integer using (trim(ordernumber)::integer),
alter column quantityordered type numeric using (trim(quantityordered)::numeric),
alter column sales type numeric using (trim(sales)::numeric),
alter column orderlinenumber type numeric using (trim(orderlinenumber)::numeric)

2.
SELECT *
FROM SALES_DATASET_RFM_PRJ
WHERE
    ORDERNUMBER IS NULL OR
    CAST(ORDERNUMBER AS TEXT) = '' OR
    QUANTITYORDERED IS NULL OR
    CAST(QUANTITYORDERED AS TEXT) = '' OR
    PRICEEACH IS NULL OR
    CAST(PRICEEACH AS TEXT) = '' OR
    ORDERLINENUMBER IS NULL OR
    CAST(ORDERLINENUMBER AS TEXT) = '' OR
    SALES IS NULL OR
    CAST(SALES AS TEXT) = '' OR
    ORDERDATE IS NULL OR
    CAST(ORDERDATE AS TEXT) = ''

3.
SELECT
    CONTACTFULLNAME,
    INITCAP(SPLIT_PART(CONTACTFULLNAME, '-', 1)) AS CONTACTFIRSTNAME,
    INITCAP(SPLIT_PART(CONTACTFULLNAME, '-', 2)) AS CONTACTLASTNAME
FROM
    SALES_DATASET_RFM_PRJ;
	
4.
-- Thêm cột QTR_ID, MONTH_ID, YEAR_ID
ALTER TABLE SALES_DATASET_RFM_PRJ
ADD COLUMN QTR_ID INTEGER,
ADD COLUMN MONTH_ID INTEGER,
ADD COLUMN YEAR_ID INTEGER;

-- Cập nhật dữ liệu cho cột QTR_ID, MONTH_ID, YEAR_ID
UPDATE SALES_DATASET_RFM_PRJ
SET
    QTR_ID = EXTRACT(QUARTER FROM ORDERDATE),
    MONTH_ID = EXTRACT(MONTH FROM ORDERDATE),
    YEAR_ID = EXTRACT(YEAR FROM ORDERDATE);

5. CÁCH 1: Z-SCORE
WITH z_score_cte AS (
    SELECT
        ORDERNUMBER,
        QUANTITYORDERED,
        (QUANTITYORDERED - AVG(QUANTITYORDERED) OVER ()) / STDDEV(QUANTITYORDERED) OVER () AS z_score
    FROM SALES_DATASET_RFM_PRJ
)
SELECT
    ORDERNUMBER,
    QUANTITYORDERED,
    z_score
FROM z_score_cte
WHERE ABS(z_score) > 3

DELETE FROM SALES_DATASET_RFM_PRJ
WHERE ORDERNUMBER IN (
    SELECT ORDERNUMBER
    FROM z_score_cte
    WHERE ABS(z_score) > 3
)

Cách 2: IQR
WITH iqr_cte AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY QUANTITYORDERED) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY QUANTITYORDERED) AS q3
    FROM SALES_DATASET_RFM_PRJ
)
SELECT
    q1 - 1.5 * (q3 - q1) AS min,
    q3 + 1.5 * (q3 - q1) AS max
FROM iqr_cte;

WITH iqr_cte AS (
    SELECT
        percentile_cont(0.25) WITHIN GROUP (ORDER BY QUANTITYORDERED) - 1.5 * percentile_cont(0.75) WITHIN GROUP (ORDER BY QUANTITYORDERED) AS min,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY QUANTITYORDERED) + 1.5 * percentile_cont(0.75) WITHIN GROUP (ORDER BY QUANTITYORDERED) AS max
    FROM SALES_DATASET_RFM_PRJ
)
DELETE FROM SALES_DATASET_RFM_PRJ
WHERE QUANTITYORDERED < (SELECT min FROM iqr_cte)
   OR QUANTITYORDERED > (SELECT max FROM iqr_cte);
   
6. CREATE TABLE SALES_DATASET_RFM_PRJ_CLEAN AS
SELECT
    ORDERNUMBER,
    QUANTITYORDERED,
    PRICEEACH,
    ORDERLINENUMBER,
    SALES,
    ORDERDATE,
    status,
    productline,
    msrp,
    productcode,
    customername,
    phone,
    ADDRESSLINE2,
    CITY,
    addressline1,
    state,
    postalcode,
    country,
    territory,
    contactfullname,
    dealsize
FROM SALES_DATASET_RFM_PRJ
