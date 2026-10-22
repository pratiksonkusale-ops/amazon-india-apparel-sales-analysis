-- ============================================
-- Amazon India Apparel Sales Analysis
-- Data Checks (run after loading data from Python)
-- Database: amazon_db | Table: amazon_sales
-- ============================================


-- 1. row count matches the cleaned data

select count(*) from amazon_sales;
-- expected- 120378

-- 2. date range of the data
SELECT MIN(date) AS first_date,
       MAX(date) AS last_date
FROM amazon_sales;
-- Expected 2022-03-31 to 2022-06-29

-- 3. no repeated order IDs(primary column)
SELECT COUNT(*) - COUNT(DISTINCT order_id) AS repeated_order_ids
FROM amazon_sales;
-- Expected. 0

-- 4: total revenue vs total recorded amount
SELECT SUM(amount)  AS recorded_amount,
       SUM(revenue) AS actual_revenue
FROM amazon_sales;
-- Compare actual_revenue with df_clean["revenue"].sum() in Python
-----------------------------------------------------------------------
