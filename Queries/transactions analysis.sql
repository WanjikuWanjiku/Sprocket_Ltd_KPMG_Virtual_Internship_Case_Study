-- drop table transactions_tbl;

-- Create a table and define columns
CREATE TABLE transactions_tbl (
transaction_id int,
product_id int,
customer_id	int,
transaction_date date,
online_order varchar(10), 
order_status varchar(30),
brand varchar(250),
product_line varchar(30),
product_class varchar(50),
product_size varchar(10),
list_price decimal(10,2),	
standard_cost decimal(10,2),
product_first_sold_date date																																																																																																																																																																																																																																																		

);

-- SHOW GLOBAL VARIABLES LIKE 'local_infile';
-- SET GLOBAL local_infile = true;

-- Load data from the csv to the table
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Transactions.csv'
INTO TABLE  transactions_tbl
FIELDS TERMINATED BY ','
IGNORE 1 LINES
;



-- TRANSACTION TABLE ANALYSIS
-- COMPLETENESS
-- Find the number of blank/null or 0 fields in transactions table per column
select 'transaction_id' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where transaction_id is null or transaction_id = ''

union all

select 'product_id' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where product_id is null or product_id = ''

union all

select 'customer_id' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where customer_id is null or customer_id = ''
 
union all

select 'transaction_date' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where transaction_date is null

union all

select 'online_order' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where online_order is null or online_order = ''

union all

select 'order_status' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where order_status is null or order_status = ''

union all

select 'brand' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where brand is null or brand = ''

union all

select 'product_line' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where product_line is null or product_line = ''

union all

select 'product_class' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where product_class is null or product_class = ''

union all

select 'product_size' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where product_size is null or product_size = ''

union all

select 'list_price' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where list_price is null or list_price = ''

union all

select 'standard_cost' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where standard_cost is null or standard_cost = ''

union all

select 'product_first_sold_date' as Column_name, count(*) as 'Count of rows'
from transactions_tbl
where product_first_sold_date is null
;

-- The columns with blank values can be deleted without affecting the overall analysis negatively
-- Delete all rows with blank values
delete  
from transactions_tbl
where transaction_id is null or transaction_id =''
;

delete  
from transactions_tbl
where product_id is null or product_id =''
;

delete  
from transactions_tbl
where customer_id is null or customer_id ='' 
;

delete  
from transactions_tbl
where transaction_date is null
;

delete  
from transactions_tbl
where online_order is null or online_order ='' 
;

delete  
from transactions_tbl
where order_status is null or order_status ='' 
;

delete  
from transactions_tbl
where brand is null or brand ='' 
;

delete  
from transactions_tbl
where product_line is null or product_line ='' 
;

delete  
from transactions_tbl
where product_class is null or product_class ='' 
;

delete  
from transactions_tbl
where product_size is null or product_size ='' 
;

delete  
from transactions_tbl
where list_price is null or list_price =  0.00
;

delete  
from transactions_tbl
where standard_cost is null or standard_cost = 0.00
;

delete  
from transactions_tbl
where product_first_sold_date is null
;

-- STRUCTURAL ERRORS
-- Look for inconsistencies by checking the distinct values in each column

SELECT distinct(online_order)
FROM transactions_tbl
;


SELECT distinct(order_status)
FROM transactions_tbl
;

SELECT distinct(brand)
FROM transactions_tbl
;

SELECT distinct(product_line)
FROM transactions_tbl
;

SELECT distinct(product_class)
FROM transactions_tbl
;

SELECT distinct(product_size)
FROM transactions_tbl
;

SELECT distinct(product_first_sold_date)
FROM transactions_tbl
GROUP BY year(product_first_sold_date)
;

-- VALIDITY
-- Check that data has the correct datatypes
show columns from transactions_tbl;

-- Create new calculated columns: day_of_week, month and profit
alter table transactions_tbl
add column day_of_week varchar(30)
;

alter table transactions_tbl
add column month_of_transaction varchar(30)
;

alter table transactions_tbl
add column profit decimal(10,2)
;

-- Calculate and update the values of day_of_week, month_of_transaction, profit column
UPDATE transactions_tbl
SET day_of_week = date_format(transaction_date, '%a')
;

UPDATE transactions_tbl
SET month_of_transaction = date_format(transaction_date, '%m')
;

UPDATE transactions_tbl
SET profit = (list_price - standard_cost)
;

-- Show distinct number of days and months
select distinct(day_of_week)
from transactions_tbl
;

select distinct(month_of_transaction)
from transactions_tbl
;

-- Only retain data from the last three months
DELETE FROM transactions_tbl
WHERE month_of_transaction not in ('10','11','12')
;



