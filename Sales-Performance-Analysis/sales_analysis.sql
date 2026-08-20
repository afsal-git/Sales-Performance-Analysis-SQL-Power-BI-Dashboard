-- ===============================
-- PHASE 1: Database & Table Check
-- ===============================

USE sales_analysis;

SHOW TABLES;

SELECT COUNT(*) AS total_rows FROM train;


-- ===============================
-- PHASE 2: Table Structure (Before Cleaning)
-- ===============================

DESCRIBE train;


-- ===============================
-- PHASE 3: Column Renaming (Data Cleaning)
-- ===============================

ALTER TABLE train
CHANGE `Row ID` row_id INT,
CHANGE `Order ID` order_id TEXT,
CHANGE `Order Date` order_date TEXT,
CHANGE `Ship Date` ship_date TEXT,
CHANGE `Customer ID` customer_id TEXT,
CHANGE `Customer Name` customer_name TEXT,
CHANGE `Product ID` product_id TEXT,
CHANGE `Product Name` product_name TEXT,
CHANGE `Postal Code` postal_code TEXT,
CHANGE `Sub-Category` sub_category TEXT,
CHANGE `Ship Mode` ship_mode TEXT;


-- ===============================
-- PHASE 4: Table Structure (After Cleaning)
-- ===============================

DESCRIBE train;


-- ===============================
-- PHASE 5: Data Profiling
-- ===============================

-- Total records
SELECT COUNT(*) AS total_records
FROM train;

-- Unique orders
SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM train;

-- Date range
SELECT 
    MIN(order_date) AS min_order_date,
    MAX(order_date) AS max_order_date
FROM train;


-- ===============================
-- PHASE 6: Data Quality Checks
-- ===============================

SELECT 
    SUM(order_date IS NULL) AS missing_order_date,
    SUM(customer_id IS NULL) AS missing_customer_id
FROM train;


-- ===============================
-- PHASE 7: Business KPIs
-- ===============================

SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(Sales) AS total_sales,
    ROUND(SUM(Sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM train;


-- ===============================
-- PHASE 8: Sales Performance Analysis
-- ===============================

-- Sales by Category
SELECT 
    Category,
    SUM(Sales) AS total_sales
FROM train
GROUP BY Category
ORDER BY total_sales DESC;

-- Top 5 Sub-Categories
SELECT 
    sub_category,
    SUM(Sales) AS total_sales
FROM train
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 5;

-- Sales by Region
SELECT 
    Region,
    SUM(Sales) AS total_sales
FROM train
GROUP BY Region
ORDER BY total_sales DESC;


-- ===============================
-- PHASE 9: Customer & Segment Analysis
-- ===============================

-- Sales by Segment
SELECT 
    Segment,
    SUM(Sales) AS total_sales
FROM train
GROUP BY Segment
ORDER BY total_sales DESC;

-- Top 10 Customers
SELECT 
    customer_name,
    SUM(Sales) AS total_sales
FROM train
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;


-- ===============================
-- PHASE 10: Operational Analysis
-- ===============================

-- Sales by Ship Mode
SELECT 
    ship_mode,
    SUM(Sales) AS total_sales
FROM train
GROUP BY ship_mode
ORDER BY total_sales DESC;


-- ===============================
-- PHASE 11: Product Performance
-- ===============================

-- Top 10 Products
SELECT 
    product_name,
    SUM(Sales) AS total_sales
FROM train
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;
