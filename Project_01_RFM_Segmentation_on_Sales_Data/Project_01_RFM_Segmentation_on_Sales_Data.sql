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
USE rfm_analysis;
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


-- Investigating sales revenue by deal size to understand the impact of deal sizes on revenue.alter
SELECT DEALSIZE, SUM(sales) Revenue
FROM rfm_data_set
GROUP BY DEALSIZE
ORDER BY 2 DESC;


-- Identifying the city with the highest sales in a specific country(e.g., 'UK').
SELECT city, SUM(sales) AS Revenue
FROM rfm_data_set
WHERE country = 'UK'
GROUP BY city
ORDER BY Revenue DESC
LIMIT 0, 1000;


-- Finding the best month for sales in a specific year (e.g., 2003) and calculationg revenue and frequencey.
SELECT MONTH_ID, SUM(sales) Revenue, COUNT(ORDERNUMBER) Frequency
FROM rfm_data_set
WHERE YEAR_ID = 2003
GROUP BY MONTH_ID
ORDER BY 2 DESC;


-- Finding the best month for sales in a specific year (e.g., 2004) and calculationg revenue and frequencey.
SELECT MONTH_ID, SUM(sales) Revenue, COUNT(ORDERNUMBER) Frequency
FROM rfm_data_set
WHERE YEAR_ID = 2004
GROUP BY MONTH_ID
ORDER BY 2 DESC;


-- Finding the best month for sales in a specific year (e.g., 2005) and calculationg revenue and frequencey.
SELECT MONTH_ID, SUM(sales) Revenue, COUNT(ORDERNUMBER) Frequency
FROM rfm_data_set
WHERE YEAR_ID = 2005
GROUP BY MONTH_ID
ORDER BY 2 DESC;


-- Identifying the top-selling product line in a specific month(e.g., November 2004).
SELECT MONTH_ID, PRODUCTLINE, SUM(sales) Revenue, COUNT(ORDERNUMBER)
FROM rfm_data_set
WHERE YEAR_ID = 2004 AND MONTH_ID = 11
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY 3 DESC;


-- Determining the best-selling product in the united satates.
SELECT country, Year_ID, PRODUCTLINE, SUM(sales) Revenue
FROM rfm_data_set
WHERE country = 'USA'
GROUP BY country, YEAR_ID, PRODUCTLINE
ORDER BY 4 DESC;

-- Identifying the top-selling product line in a specific month (e.g., November 2004).
SELECT MONTH_ID, PRODUCTLINE, SUM(SALES) Revenue, COUNT(ORDERNUMBER)
FROM rfm_data_set
WHERE YEAR_ID = 2004 AND MONTH_ID = 11
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY 3 DESC;



-- We need to calculate each metrics
SELECT 
    MAX(ORDERDATE)
FROM
    rfm_data;

with cte1 as (
select customername,
sum(sales) as monetaryvalue,
avg(sales) as AVGmonetaryvalue,
count(distinct ordernumber) as Frequency,
max(orderdate) as last_order_date,
(select max(ORDERDATE) from rfm_data)  as final_date
from rfm_data
group by CUSTOMERNAME
),
cte2 as (
select*,datediff(final_date,last_order_date)+1 as Recency from cte1
order by Recency
),
cte3 as (
select*,
ntile(4) over(order by recency desc) as rfm_recency,
ntile(4) over(order by frequency ) as rfm_frequency,
ntile(4) over(order by monetaryvalue) as rfm_monetary
 from cte2),
























