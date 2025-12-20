-- ======================RFM Segmentation on Sales Data=======================

-- Step 1: Create the Database and Table

CREATE DATABASE rfm_analysis;

USE rfm_analysis;

CREATE TABLE rfm_data(
ORDERNU INT,
QUANTITY INT,
PRICEEACI DECIMAL(10,2),
ORDERLIN INT,
SALES DECIMAL(10,2),
ORDERDA DATE,
STATUS VARCHAR(20),
QTRID INT,
MONTHIC INT,
YEARID INT,
PRODUCTIMSRP DECIMAL(10,2),
PRODUCTI VARCHAR(50),
CUSTOMEI INT,
PHONE VARCHAR(20),
ADDRESSL1 VARCHAR(100),
ADDRESSL2 VARCHAR(100),
CITY VARCHAR(50),
STATE VARCHAR(50),
POSTALCO VARCHAR(20),
COUNTRY VARCHAR(50),
TERRITROY VARCHAR(50),
CONTACTI VARCHAR(50),
CONTACTI2 VARCHAR(50),
DEALSIZE VARCHAR(20)
);


-- Inspecting Data
SELECT * FROM rfm_data_set LIMIT 10;

-- unique values
select distinct status from rfm_data_set;

select distinct status from rfm_data_set;
select distinct COUNTRY from rfm_data_set;

select distinct year_id from rfm_data_set;
select distinct PRODUCTLINE from rfm_data_set;

select distinct DEALSIZE from rfm_data_set;
select distinct TERRITORY from rfm_data_set;



-- ==================================================
-- Grouping sales by product line to understand the distribution of sales across different product categories.alter
-- We'are calculationg the total revenue and the number of orders for each product line.
select PRODUCTLINE, ROUND(sum(sales),0) AS Revenue, COUNT(DISTINCT ORDERNUMBER) AS NO_OF_ORDERS
from rfm_data_set
group by PRODUCTLINE
order by 3 desc;


-- Analyzing sales revenue by year to identify trends or changes over time.
SELECT YEAR_ID, SUM(sales) Revenue
FROM rfm_data_set
GROUP BY YEAR_ID
ORDER BY 2 DESC;














