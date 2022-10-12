-- DROP TABLE customer_demographic_tbl;

-- Create new table
CREATE TABLE customer_demographic_tbl(
customer_id int, 
first_name varchar(30), 
last_name varchar(30),
gender varchar(10), 
past_3_years_bike_related_purchases int, 
DOB date,
job_title varchar(30), 
job_industry_category varchar(30), 
wealth_segment varchar(30), 
deceased_indicator varchar(10), 
owns_car varchar(30),
tenure int
);

-- Load data from the csv to the table
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer Demographic.csv'
INTO TABLE customer_demographic_tbl
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(@customer_id,@first_name,@last_name,@gender,@past_3_years_bike_related_purchases,@DOB,@job_title,@job_industry_category,@wealth_segment,
@deceased_indicator,@owns_car,@tenure
)
SET     
customer_id = IF(@customer_id ='', NULL, @customer_id),
first_name = IF(@first_name ='', NULL, @first_name), 
last_name = IF(@last_name ='', NULL, @last_name), 
gender = IF(@gender ='', NULL, @gender), 
past_3_years_bike_related_purchases = IF(@past_3_years_bike_related_purchases ='', NULL, @past_3_years_bike_related_purchases), 
DOB = IF(@DOB ='', NULL, @DOB),
job_title = IF(@job_title ='', NULL, @job_title), 
job_industry_category = IF(@job_industry_category ='', NULL, @job_industry_category), 
wealth_segment = IF(@wealth_segment ='', NULL, @wealth_segment), 
deceased_indicator = IF(@deceased_indicator ='', NULL, @deceased_indicator), 
owns_car = IF(@owns_car ='', NULL, @owns_car),  
tenure = IF(@tenure ='', NULL, @tenure) 

;

-- CUSTOMER DEMOGRAPHIC TABLE ANALYSIS
-- Create a new calculated column: age 
alter table customer_demographic_tbl
add column age int
;

-- Calculate and update the values of age column
UPDATE customer_demographic_tbl
SET age = date_format(from_days(datediff(now(),DOB)),'%Y') + 0 
;

-- COMPLETENESS
-- Find the number of blank/null or 0 fields in customer demographic table per column
select 'customer_id' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where customer_id is null or first_name = ''

union all

select 'first_name' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where first_name is null or first_name = ''

union all

select 'last_name' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where last_name is null or last_name = ''

union all

select 'gender' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where gender is null or gender = ''
 
union all

select 'past_3_years_bike_related_purchases' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where past_3_years_bike_related_purchases is null or past_3_years_bike_related_purchases = 0

union all

select 'DOB' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where DOB is null

union all

select 'job_title' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where job_title is null or job_title = ''

union all

select 'job_industry_category' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where job_industry_category is null or job_industry_category = ''

union all

select 'wealth_segment' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where wealth_segment is null or wealth_segment = ''

union all

select 'deceased_indicator' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where deceased_indicator is null or deceased_indicator = ''

union all

select 'owns_car' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where owns_car is null or owns_car = ''

union all

select 'tenure' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where tenure is null or tenure = 0

union all

select 'age' as Column_name, count(*) as 'Count of rows'
from customer_demographic_tbl
where age is null or age = 0

;

-- The blank last_names, DOB, past_3_years_bike_related_purchases and age be deleted without affecting the overall analysis negatively
-- Delete the rows with blank last_names and the rows with DOB, age or past_3_years_bike_related_purchases 0
delete  
from customer_demographic_tbl
where last_name is null or last_name =''
;

-- These deletes both DOB and Age rows that have age 0
delete 
from customer_demographic_tbl
where age is null or age = 0
;

delete 
from customer_demographic_tbl
where past_3_years_bike_related_purchases is null or past_3_years_bike_related_purchases = 0
;

-- The empty job_title values will be replaced with a placeholder "not_specified"
UPDATE customer_demographic_tbl
SET job_title = 'not_specified'
WHERE job_title is null or job_title = ''
;

-- STRUCTURAL ERRORS
-- Look for structural inconsistencies by checking the distinct values in each column
select distinct(first_name) 
from customer_demographic_tbl
;

select distinct(last_name) 
from customer_demographic_tbl
;

select distinct(gender) 
from customer_demographic_tbl
;

select distinct(past_3_years_bike_related_purchases) 
from customer_demographic_tbl
;

select distinct(DOB) 
from customer_demographic_tbl
;

select distinct(job_title) 
from customer_demographic_tbl
;

select distinct(job_industry_category) 
from customer_demographic_tbl
;

select distinct(wealth_segment) 
from customer_demographic_tbl
;

select distinct(deceased_indicator) 
from customer_demographic_tbl
;

select distinct(owns_car) 
from customer_demographic_tbl
;

select distinct(tenure) 
from customer_demographic_tbl
;

select distinct(age) 
from customer_demographic_tbl
;

-- Inconsistencies were noted in the gender column
-- Make the gender column consistent by presenting values as F, M or U

UPDATE customer_demographic_tbl
SET gender = 'F'
WHERE gender = 'Female' or gender = 'Femal'
;

UPDATE customer_demographic_tbl
SET gender = 'M'
WHERE gender = 'Male'
;

-- VALIDITY
-- Check that data has the correct datatypes
show columns from customer_demographic_tbl;

-- RELEVANCE
-- Delete rows where the customers are deceased
delete  
from customer_demographic_tbl
where deceased_indicator = 'Y'
;

-- Drop columns that are not relevant to this analysis or contain personal information identifiers
ALTER TABLE customer_demographic_tbl
DROP column first_name
;

ALTER TABLE customer_demographic_tbl
DROP column last_name
;
