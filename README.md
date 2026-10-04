# sql-remove-duplicates-no-unique-id
MySQL data cleaning project: find and delete duplicates using window functions (no primary key needed).  Removing 150 duplicate rows from a 1,000-row dataset in MySQL using ROW_NUMBER() and PARTITION BY.
# MySQL Duplicate Cleaning (No Unique Column)

Identifying and removing duplicate rows in MySQL when the table
has no primary key or unique identifier.

## Dataset
- File: `MySQL_Duplicate_Practice_1000_Rows.csv`
- 1,000 rows of customer orders
- Columns: Customer_ID, Customer_Name, City, Department, Product,
  Quantity, Unit_Price, Order_Date, Total_Sales

## Approach
1. Created a database and imported the CSV
2. Made a backup copy of the original table (`customer_data1`)
3. Used `ROW_NUMBER() OVER (PARTITION BY ...)` across all columns
   to flag duplicates
4. Stored the flagged result in a staging table (`customer_data2`),
   since window functions can't be used directly in a `WHERE` clause
5. Deleted rows where `row_num > 1`

## Result
- 150 duplicate rows found and removed
- 850 unique rows remain

## Skills Used
`ROW_NUMBER()`, `PARTITION BY`, `CREATE TABLE`, `INSERT ... SELECT`,
`DELETE`, `sql_safe_updates`

## How to Run
1. Import the CSV into a table named `customer_data`
2. Run `duplicate_cleaning.sql` step by step
