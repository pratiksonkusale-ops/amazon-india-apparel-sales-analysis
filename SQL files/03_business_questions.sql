-- ============================================
-- Amazon India Apparel Sales Analysis
-- Business Questions and Answers
-- Database: amazon_db | Table: amazon_sales
-- Period: 31 Mar 2022 - 29 Jun 2022
-- ============================================

-- 1. Which states bring the most revenue?

select ship_state, sum(revenue) 
from amazon_sales 
group by ship_state 
order by sum(revenue) 
desc limit 1;

-- 2. How does revenue change month by month?

select month, month_num, sum(revenue) 
from amazon_sales 
group by month_num, month 
order by month_num 
asc ; 

-- 3. How many orders were cancelled in each category?

select category, count(status)
from amazon_sales a where a.status = 'Cancelled' 
group by category order by count(status) desc;4. 

-- 4. How much value is lost to cancellations?

SELECT SUM(amount) AS recorded_amount,
SUM(revenue) AS actual_revenue,
SUM(amount) - SUM(revenue) AS value_lost,
ROUND(100.0 * (SUM(amount) - SUM(revenue)) / SUM(amount), 2) AS revenue_percentage_lost
FROM amazon_sales;


-- 5 Which size sells the most?

SELECT size, COUNT(*) AS orders
FROM amazon_sales
WHERE status <> 'Cancelled'
GROUP BY size
ORDER BY orders DESC;

--=========================================================================================











