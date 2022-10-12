# Queries

These are the queries used to clean and analyse the data. 

The queries are stored in 6 files. 


***1. Transactions Analysis***
- Create the transactions table
- Load data from csv files to the table
- Find null/blank fields
- Delete entries with blank values
- Look for inconsistencies by checking the distinct values in each column
- Check that data has correct data types
- Create new calculated columns for day_of_week, month and profit
- Calculate and update the values of new columns day_of_week, month_of_transaction, and profit
- Show distinct number of days and months
- Only retain data from the last three months


***2. Customer Demographic Analysis***
- Create the customer demographic table
- Load data from csv files to the table
- Create a new calculated column: age 
- Calculate and update the values of age column
- Find the number of blank/null or 0 fields in transactions table per column
-  Delete the rows with blank last_names and the rows with DOB, age or past_3_years_bike_related_purchases 0
- Delete both DOB and Age rows that have age 0
- Replace empty job_title values with a placeholder "not_specified"
- Look for structural inconsistencies by checking the distinct values in each column
- Make the gender column consistent by presenting values as F, M or U
- Check that data has the correct datatypes
- Delete rows where the customers are deceased
- Drop columns that are not relevant to this analysis or contain personal information identifiers
		
***3. Customer Address Analysis***
- Create the customer address table
- Load data from csv files to the table
- Drop columns that are not relevant to this analysis or contain personal information identifiers
- Look for structural inconsistencies by checking the distinct values in each column
- Make the state column consistent by presenting values as NSW, QLD or VIC
	
***4. New Customer List Analysis***
- Create the new customer list table
- Load data from csv files to the table
- Create a new calculated column: age 
- Calculate and update the values of age column
- Find the number of blank/null or 0 fields per column
- Delete the rows with age 0
- Replace empty job_title values with a placeholder "not_specified"
- Look for structural inconsistencies by checking the distinct values in each column
- Check that data has the correct datatypes
- Delete rows where the customers are deceased
- Drop columns that are not relevant to this analysis or contain personal information identifiers
- To maintain consistency with other tables change gender to F or M
		
***5. Master Customer Demographic Table***
- Join the three tables: address, demographic and transactions
- Store the result of joining the queries in a new table: master customer demographic table
-  Delete records with NULL Values
-  Load the table to a csv file
-  Export the clean data to a csv file
- Analyse different fields to identify which ones bring the highest profits
- Calculate Age Group with highest profit

***6. New Customers To Target Analysis***
- Create a table for customers the marketing team should focus on
- Export the table to a csv file

