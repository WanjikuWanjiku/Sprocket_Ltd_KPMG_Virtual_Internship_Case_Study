-- CUSTOMER ADDRESS TABLE

CREATE TABLE customer_address_tbl (
customer_id int,
address varchar(250), 
postcode int, 
state varchar(10), 
country varchar(30), 
property_valuation int
																																																																																																																																																																																																																																																	
);

-- Load data from the csv to the table
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer Address.csv'
INTO TABLE  customer_address_tbl
FIELDS TERMINATED BY ','
IGNORE 1 LINES
;

-- CUSTOMER ADDRESS TABLE ANALYSIS
-- Relevance
-- Drop columns that are not relevant to this analysis or contain personal information identifiers

ALTER TABLE customer_address_tbl
DROP column address
;

-- STRUCTURAL ERRORS
-- Look for structural inconsistencies by checking the distinct values in each column
SELECT distinct(state)
FROM customer_address_tbl
;

-- Inconsistencies were noted in the state column
-- Make the state column consistent by presenting values as NSW, QLD or VIC

UPDATE customer_address_tbl
SET state = 'NSW'
WHERE state = 'New South '
;

UPDATE customer_address_tbl
SET state = 'VIC'
WHERE state = 'Victoria'
;

