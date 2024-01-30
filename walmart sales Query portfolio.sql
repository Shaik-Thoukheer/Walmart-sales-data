create database walmart_sales_data;
use walmart_sales_data;
create table W_sales (
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10, 2) NOT NULL,
quantity INT NOT NULL,
VAT DECIMAL(6, 4) NOT NULL,
total DECIMAL(12, 4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_method VARCHAR(15) NOT NULL,
cogs DECIMAL(10, 2) NOT NULL,
gross_margin_pct DECIMAL(11, 9),
gross_income DECIMAL(12, 4) NOT NULL,
rating DECIMAL(2, 1)
);

select * from W_sales;

#Data Wrangling: This is the first step where inspection of data is done to make sure,
# NULL values and missing values are detected 
# & data replacement methods are used to replace, missing or NULL values.
###it is already removed because we have not null code in every column.
## data cleaning by removing null cells, 

--------------------------------------------------------------------------------------
------------------------------ feature engineering------------------------------------
#Feature Engineering: This will help use generate some new columns from existing ones.

--------------------------------------------------------------------------------------------
-- adding time_of_day column to have insights on which part of day sales hpnd.

ALTER TABLE W_sales
ADD time_of_day VARCHAR(10) AS (
  CASE
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN time BETWEEN '12:00:01' AND '16:00:00' THEN 'Afternoon'
    WHEN time BETWEEN '16:00:01' AND '21:00:00' THEN 'Evening'
    ELSE 'Night'
  END
);
#dont use literal string 'time' instead of the column name for time comparison. 

SELECT time_of_day, COUNT(*) AS count_per_category
FROM W_sales
GROUP BY time_of_day;
# more sales in evening > afternoon > mrng
---------------------------------------------------------------------------------------------------------
#Add a new column named day_names which the gives when transaction took place (Mon, Tue, Wed, Thur, Fri).
-- day_name
 
ALTER TABLE W_sales
ADD COLUMN day_name VARCHAR(10);

UPDATE W_sales
SET day_name = DAYNAME(date);

SELECT day_name, COUNT(*) AS count_per_category
FROM W_sales
GROUP BY day_name
ORDER BY count_per_category DESC;

#more sales on sat>tue>wed>thrus>fri>sun>mon
---------------------------------------------------------------------------------------------
--- month_name

alter table w_sales
add column month varchar(10);

update w_sales 
set month = monthname(date);

select * from w_sales;

SELECT month, COUNT(*) AS count_per_category
FROM W_sales
GROUP BY month
ORDER BY count_per_category DESC;

#sales in jan > march > feb
---------------------------------------------------------------------------------------------------
#Exploratory Data Analysis (EDA): it is done to answer the listed questions & aims of this project.

----------------------------------------------------------------------------------------------------
## Generic Questions
-- #1 How many unique cities does the data have?

select distinct city, count(city) 
from w_sales 
group by city ;

-- #2 in which city has which branch? 

select distinct city, branch from w_sales;

-----------------------------------------------------------------------------------------------------
## Questions on Product
-- #1 How many unique product lines does the data have?

SELECT 
  ROW_NUMBER() OVER (ORDER BY product_line) AS serial_number,
  product_line,
  COUNT(product_line) AS product_count
FROM w_sales
GROUP BY product_line
ORDER BY product_count DESC;

# ORDER BY serial_number DESC to know how m

# 2. What is the most common payment method?

SELECT
payment_method,
COUNT(payment_method)
FROM w_sales
GROUP BY payment_method
ORDER BY count(payment_method) DESC;

## 3. What is the most selling product line?

WITH ProductCounts AS (
  SELECT product_line, COUNT(*) AS most_sold
  FROM w_sales
  GROUP BY product_line
)

SELECT product_line, most_sold,
  ROW_NUMBER() OVER (ORDER BY most_sold DESC) AS serial_number
FROM ProductCounts
ORDER BY most_sold DESC;

## 4. What is the total revenue by month?

select month, sum(total) 
from w_sales
group by month
order by sum(total) desc;
#jan > mar > feb

## 5. What month had the largest COGS?

select month, sum(cogs)
from w_sales
group by month
order by sum(cogs) desc;

#result same as above, revenue proportional to cogs

## 6. What product line had the largest revenue?

Select product_line, sum(total) 
from w_sales
group by product_line
order by sum(total) desc;

##food & beverages > fashion....

## 7. What is the city with the largest revenue?

select city, sum(total) as total
from w_sales
group by city
order by total desc;

# Naypyitaw city > yangon > mandalay

## 8. What product line had the largest VAT? (answered wrong in explainatory video duration 54 min)

select product_line, sum(vat)
from w_sales
group by product_line
order by sum(vat) desc;
#limit 1 to get only largest value

## if largest vat per product line is asked then?

select product_line, avg(vat)
from w_sales
group by product_line
order by avg(vat) desc;

## 9. Which branch sold more products than average product sold?

SELECT
  branch,
  SUM(quantity) AS qty
FROM w_sales
GROUP BY branch;
## HAVING SUM(quantity) > (SELECT AVG(quantity) FROM w_sales);

## 10. what is the most common product line by gender?

select distinct product_line, gender, count(gender) 
from w_sales
group by gender, product_line
order by count(gender) desc;

## 11. what is the average rating of product line ?

select distinct product_line, Round(avg(rating),2) as avg_rating
from w_sales
group by product_line
order by avg_rating desc;

SHOW COLUMNS FROM w_sales;
## 12. Fetch each product line and
# add a column to those product line showing "Good", "Bad". Good if its greater than average sales ?
SELECT
  product_line, SUM(total) AS total_sales,
  CASE
    WHEN SUM(total) > (SELECT AVG(total) FROM w_sales) THEN 'Good'
    ELSE 'Bad'
  END AS sales_category
FROM w_sales
GROUP BY product_line;

-- ------------------------------------------------------------------------------------------------------------
-- -------------------------------- sales questions-----------------------------------------------------

## 1. Number of sales made in each time of the day per weekday?

select time_of_day as 'sunday' , count(*) as total_sales
from w_sales
where day_name = 'sunday'
group by day_name, time_of_day
order by total_sales;

## for no of sales hpnd in the morning, afternoon, and evening for each day of the week.

SELECT
  day_name,
  SUM(CASE WHEN time_of_day = 'Morning' THEN 1 ELSE 0 END) AS Morning,
  SUM(CASE WHEN time_of_day = 'Afternoon' THEN 1 ELSE 0 END) AS Afternoon,
  SUM(CASE WHEN time_of_day = 'Evening' THEN 1 ELSE 0 END) AS Evening
FROM w_sales
GROUP BY day_name
ORDER BY day_name;

## 2. Which of the customer types brings the most revenue?

select customer_type, sum(total) as revenue
from w_sales
group by customer_type
order by revenue desc;

# members > revenue

## 3. Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT city, avg(VAT) AS VAT
FROM w_sales
GROUP BY city
ORDER BY VAT DESC;
# it is the city with the highest average VAT rate.

-- city that collects the most VAT revenue in total
SELECT city, sum(VAT) AS VAT
FROM w_sales
GROUP BY city
ORDER BY VAT DESC;

## 4. Which customer type pays the most in VAT?

select customer_type, sum(VAT) as VAT
from w_sales
group by customer_type
order by VAT desc;
----------------------------------------------------------------------------------------------------------
-- -----------------------------------Customer Questions--------------------------------------------------------
## 1. How many unique customer types does the data have?

select distinct customer_type from w_sales;

## 2. How many unique payment methods does the data have?

select distinct payment_method from w_sales;

## 3. What is the most common customer type?

select distinct customer_type as customer, count(customer_type) as type
 from w_sales
 group by customer
 order by type desc;

##4. Which customer type buys the most?

select customer_type as customer, sum(total) as freq_buyer
from w_sales
group by customer
order by freq_buyer desc;

## 5. What is the gender of most of the customers?

select distinct gender as gender, count(customer_type) as customer
from w_sales
group by gender
order by customer desc;

## 6. What is the gender distribution per branch?

SELECT branch, gender, COUNT(*) AS count_per_gender
FROM w_sales
GROUP BY branch, gender
ORDER BY branch, gender;         

## 7. Which time of the day do customers give most ratings?

SELECT time_of_day, COUNT(rating) AS rating_count
FROM w_sales
GROUP BY time_of_day
ORDER BY rating_count DESC;

-- in select, DISTINCT(tod) is not req bcz GROUP BY clause automatically groups the data by specified column.

## 8. Which time of the day do customers give most ratings per branch?

select time_of_day, branch, count(rating)
from w_sales
group by time_of_day, branch
order by count(rating) desc;

## 9. Which day of the week has the best avg ratings?

select day_name, avg(rating) as avg_ratings
from w_sales
group by day_name
order by avg_ratings desc;

## 10. Which day of the week has the best average ratings per branch?

select day_name, avg(rating) as avg_ratings, branch
from w_sales
group by day_name, branch
order by avg_ratings desc 
limit 3;

-- -----------------------------------------------------------------------------------------------------

