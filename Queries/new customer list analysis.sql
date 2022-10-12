-- drop table new_customer_list_tbl;

-- Create a new table
CREATE TABLE new_customer_list_tbl(																																																																																																																																																																																																																																								
first_name	varchar(30), 
last_name varchar(30), 
gender varchar(30),
past_3_years_bike_related_purchases int, 
DOB date,
job_title varchar(250), 
job_industry_category varchar(30), 
wealth_segment varchar(30), 
deceased_indicator varchar (10),
owns_car varchar(10), 
tenure int, 
address varchar(250), 
postcode int, 
state varchar(10), 
country varchar(30), 
property_valuation int, 
Rank_number int, 
v_value float																																																																																																																																																																																																																																					
);

-- Load data from the csv to the table
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/New Customer List.csv'
INTO TABLE new_customer_list_tbl
FIELDS TERMINATED BY ','
IGNORE 1 LINES
	
;

-- CUSTOMER LIST ANALYSIS
-- Create a new calculated column: age 
alter table new_customer_list_tbl
add column age int
;

-- Calculate and update the values of age column
UPDATE new_customer_list_tbl
SET age = date_format(from_days(datediff(now(),DOB)),'%Y') + 0 
;

-- COMPLETENESS
-- Find the number of blank/null or 0 fields in new customer list table per column
select 'first_name' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where first_name is null or first_name = ''

union all

select 'last_name' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where last_name is null or last_name = ''

union all

select 'gender' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where gender is null or gender = ''
 
union all

select 'past_3_years_bike_related_purchases' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where past_3_years_bike_related_purchases is null or past_3_years_bike_related_purchases = 0

union all

select 'DOB' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where DOB is null

union all

select 'job_title' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where job_title is null or job_title = ''

union all

select 'job_industry_category' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where job_industry_category is null or job_industry_category = ''

union all

select 'wealth_segment' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where wealth_segment is null or wealth_segment = ''

union all

select 'deceased_indicator' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where deceased_indicator is null or deceased_indicator = ''

union all

select 'owns_car' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where owns_car is null or owns_car = ''

union all

select 'tenure' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where tenure is null or tenure = 0

union all

select 'address' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where address is null or address = ''

union all

select 'postcode' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where postcode is null or postcode = 0

union all

select 'state' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where state is null or state = ''

union all

select 'country' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where country is null or country = ''

union all

select 'property_valuation' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where property_valuation is null or property_valuation = 0

union all

select 'Rank_number' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where Rank_number is null or Rank_number = 0

union all

select 'v_value' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where v_value is null or v_value = 0

union all

select 'age' as Column_name, count(*) as 'Count of rows'
from new_customer_list_tbl
where age is null or age = 0

;

-- Delete the rows with age 0

delete 
from new_customer_list_tbl
where age is null or age = 0
;

-- The empty job_title values will be replaced with a placeholder "not_specified"
UPDATE new_customer_list_tbl
SET job_title = 'not_specified'
WHERE job_title is null or job_title = ''
;

-- STRUCTURAL ERRORS
-- Look for structural inconsistencies by checking the distinct values in each column
-- None were found
select distinct(first_name) 
from new_customer_list_tbl
;

select distinct(last_name) 
from new_customer_list_tbl
;

select distinct(gender) 
from new_customer_list_tbl
;

select distinct(past_3_years_bike_related_purchases) 
from new_customer_list_tbl
;

select distinct(DOB) 
from new_customer_list_tbl
;

select distinct(job_title) 
from new_customer_list_tbl
;

select distinct(job_industry_category) 
from new_customer_list_tbl
;

select distinct(wealth_segment) 
from new_customer_list_tbl
;

select distinct(deceased_indicator) 
from new_customer_list_tbl
;

select distinct(owns_car) 
from new_customer_list_tbl
;

select distinct(tenure) 
from new_customer_list_tbl
;

select distinct(address) 
from new_customer_list_tbl
;

select distinct(postcode) 
from new_customer_list_tbl
;

select distinct(state) 
from new_customer_list_tbl
;

select distinct(country) 
from new_customer_list_tbl
;

select distinct(property_valuation) 
from new_customer_list_tbl
;

select distinct(Rank_number) 
from new_customer_list_tbl
;

select distinct(v_value) 
from new_customer_list_tbl
;

select distinct(age) 
from new_customer_list_tbl
;

-- VALIDITY
-- Check that data has the correct datatypes
show columns from new_customer_list_tbl;

-- RELEVANCE
-- Delete rows where the customers are deceased
delete  
from new_customer_list_tbl
where deceased_indicator = 'Y'
;

-- Drop columns that are not relevant to this analysis or contain personal information identifiers
ALTER TABLE new_customer_list_tbl
DROP column v_value
;

ALTER TABLE new_customer_list_tbl
DROP column Rank_number
;

ALTER TABLE new_customer_list_tbl
DROP column address
;

-- CONSISTENCY
-- To maintain consitency with other tables change gender to F or M
UPDATE new_customer_list_tbl
SET gender = 'F'
WHERE gender = 'Female' 
;

UPDATE new_customer_list_tbl
SET gender = 'M'
WHERE gender = 'Male'
;

