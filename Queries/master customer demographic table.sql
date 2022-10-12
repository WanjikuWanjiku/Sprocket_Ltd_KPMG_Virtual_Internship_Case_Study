-- Join the three tables: address, demographic and transactions
-- Store the result of joining the queries in a new table: master customer demographic table
CREATE TABLE master_customer_demographic_tbl as
SELECT cdt.customer_id, 
gender, 
past_3_years_bike_related_purchases, 
DOB, 
job_title, 
job_industry_category, 
wealth_segment, 
deceased_indicator, 
owns_car, 
tenure, 
age, 
transaction_id, 
product_id, 
transaction_date, 
online_order, 
order_status, 
brand, 
product_line, 
product_class, 
product_size, 
list_price, 
standard_cost, 
product_first_sold_date, 
day_of_week, 
month_of_transaction, 
profit, 
postcode, 
state, 
country, 
property_valuation

FROM customer_demographic_tbl as cdt

LEFT JOIN

transactions_tbl as tt
ON cdt.customer_id = tt.customer_id

LEFT JOIN

customer_address_tbl as cat
ON cdt.customer_id = cat.customer_id
;

-- COMPLETENESS
-- Delete records with NULL Values
-- NULL transaction_id's mean the customer didn't make any purchases in the past 3 months

DELETE FROM master_customer_demographic_tbl
WHERE transaction_id is NULL
;

-- NULL address values will not be useful in the analysis
-- DELETE the 4 records with NULL address values
DELETE FROM master_customer_demographic_tbl
WHERE postcode is NULL
;

-- Load the table to a csv file
-- Export the clean data to a csv file
SELECT "customer_id", 
"gender", "past_3_years_bike_related_purchases", "DOB", "job_title",
"job_industry_category", "wealth_segment", "deceased_indicator", "owns_car",
"tenure", "age", "transaction_id", "product_id", "transaction_date",
"online_order", "order_status", "brand", "product_line", "product_class", 
"product_size", "list_price", "standard_cost", "product_first_sold_date", "day_of_week", 
"month_of_transaction", "profit", "postcode", "state", "country", "property_valuation"

UNION ALL

SELECT 
	customer_id, gender, past_3_years_bike_related_purchases, DOB, job_title, job_industry_category, wealth_segment, deceased_indicator, owns_car, tenure, age, transaction_id, product_id, transaction_date, online_order, order_status, brand, product_line, product_class, product_size, list_price, standard_cost, product_first_sold_date, day_of_week, month_of_transaction, profit, postcode, state, country, property_valuation
    INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/master_customer_demographic.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM master_customer_demographic_tbl
;

-- Analyse different fields to identify which ones bring the highest profits

SELECT sum(profit) as highest_profit_brands , brand 
FROM master_customer_demographic_tbl
GROUP BY brand
;

SELECT sum(profit) as highest_profit_product_line , product_line 
FROM master_customer_demographic_tbl
GROUP BY product_line
;

SELECT sum(profit) as highest_profit_product_class , product_class 
FROM master_customer_demographic_tbl
GROUP BY product_class
;

SELECT sum(profit) as highest_profit_product_size , product_size 
FROM master_customer_demographic_tbl
GROUP BY product_size
;

SELECT sum(profit) as highest_profit_day_of_week , day_of_week 
FROM master_customer_demographic_tbl
GROUP BY day_of_week
;

SELECT sum(profit) as highest_profit_month, month_of_transaction
FROM master_customer_demographic_tbl
GROUP BY month_of_transaction
;

SELECT sum(profit) as highest_profit_customer, customer_id, state
FROM master_customer_demographic_tbl
GROUP BY customer_id, state
;

SELECT sum(profit) as highest_profit_job_title, job_title
FROM master_customer_demographic_tbl
GROUP BY job_title 
ORDER BY highest_profit_job_title DESC
LIMIT 10
;

SELECT sum(profit) as highest_profit_job_industry, job_industry_category
FROM master_customer_demographic_tbl
GROUP BY job_industry_category
ORDER BY job_industry_category DESC
;

SELECT sum(profit) as highest_profit_wealth, wealth_segment
FROM master_customer_demographic_tbl
GROUP BY wealth_segment
ORDER BY wealth_segment DESC
;

SELECT sum(profit) as highest_profit_owns_car, owns_car
FROM master_customer_demographic_tbl
GROUP BY owns_car
;

SELECT sum(profit) as highest_profit_tenure, tenure
FROM master_customer_demographic_tbl
GROUP BY tenure
;

SELECT sum(profit) as highest_profit_age, age
FROM master_customer_demographic_tbl
GROUP BY age
;

-- Calculate Age Group with highest profit
SELECT sum(profit) as highest_profit_age_group,
	CASE 
    WHEN age < 20 THEN '<20'
    WHEN age >= 20 AND age < 30 THEN '20\'s'
    WHEN age >= 30 AND age < 40 THEN '30\'s'
	WHEN age >= 40 AND age < 50 THEN '40\'s'
	WHEN age >= 50 AND age < 60 THEN '50\'s'
    ELSE '60 +'
    END AS 'age_group'
FROM master_customer_demographic_tbl
GROUP BY age_group
ORDER BY highest_profit_age_group DESC
;

SELECT sum(profit) as highest_profit_online_order, online_order
FROM master_customer_demographic_tbl
GROUP BY online_order
;

SELECT sum(profit) as highest_profit_postcode, postcode
FROM master_customer_demographic_tbl
GROUP BY postcode
ORDER BY highest_profit_postcode DESC
;

SELECT sum(profit) as highest_profit_state , state 
FROM master_customer_demographic_tbl
GROUP BY state
;

SELECT sum(profit) as highest_profit_property_valuation , property_valuation 
FROM master_customer_demographic_tbl
GROUP BY property_valuation
ORDER BY highest_profit_property_valuation DESC
;
