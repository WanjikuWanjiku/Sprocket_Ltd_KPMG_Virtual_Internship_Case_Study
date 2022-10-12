-- DROP TABLE new_customers_to_target;
-- Create a table for customers the marketing team should focus on

CREATE TABLE new_customers_to_target AS

SELECT *
FROM new_customer_list_tbl
WHERE age BETWEEN 40 AND 49
AND 
property_valuation IN (7,8,9,10)
AND
past_3_years_bike_related_purchases > 10

UNION

SELECT *
FROM new_customer_list_tbl
WHERE (job_industry_category in ('Financial Services','Manufacturing', 'Health') OR
job_title IN ('Recruiting Manager'
, 'Project Manager'
, 'General Manager'
, 'Assistant Professor'
, 'Administrative Officer'
, 'Information Systems Manager'
, 'Social Worker'
, 'Speech Pathologist'
, 'Assistant Media Planner'
, 'Associate Professor') )
AND 
property_valuation IN (7,8,9,10)
AND
wealth_segment = 'Mass Customer'
AND
past_3_years_bike_related_purchases > 10

UNION

SELECT *
FROM new_customer_list_tbl
WHERE state = 'NSW'
AND 
property_valuation IN (7,8,9,10)
AND
wealth_segment = 'Mass Customer'
AND
past_3_years_bike_related_purchases > 10

;

-- Export the table to a csv file
SELECT "first_name", "last_name", "gender", "past_3_years_bike_related_purchases", "DOB",
"job_title", "job_industry_category", "wealth_segment", "deceased_indicator", 
"owns_car", "tenure", "postcode", "state", "country", "property_valuation", "age"


UNION ALL

SELECT 
	first_name, last_name, gender, past_3_years_bike_related_purchases, DOB, job_title, job_industry_category, wealth_segment, deceased_indicator, owns_car, tenure, postcode, state, country, property_valuation, age
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/new_customers_to_target.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM new_customers_to_target
;