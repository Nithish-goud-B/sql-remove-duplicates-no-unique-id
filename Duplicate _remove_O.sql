-- identifying and deleting duplicates while there is no unique column exists --

-- first we need to create a database --
 
create database duplicate_cleaning;

-- make sure your using the database you created by setting it as a default schema--
-- let's import data from another file csv--
-- actually the data is stored in .xlsx format but it can't be accessible by this version so i converted it into .csv--
-- let's observe our data first --

select * from customer_data;

-- creating a copy file to avoide any data manipulation in original data--
 create table customer_data1(
 select * from customer_data);
 
 -- let's check our customer copy data --
 
 select * from customer_data1;
  -- we are successfully copied --
  -- now let's first identify duplicates --
   select *, 
		row_number() over(
        partition by Customer_ID,Customer_Name,City,Department,Product,Quantity,Unit_Price,Order_Date,Total_Sales
        order by Customer_ID) AS row_num
	from customer_data1;
    
    -- since we are dealing seperatly using window functions we can't filter for that we are creating another table  to avoid the confusion--
    
    CREATE TABLE `customer_data2` (
  `Customer_ID` int DEFAULT NULL,
  `Customer_Name` text,
  `City` text,
  `Department` text,
  `Product` text,
  `Quantity` int DEFAULT NULL,
  `Unit_Price` int DEFAULT NULL,
  `Order_Date` text,
  `Total_Sales` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- here we created a seperate row for flagging using window function , make sure change the table name if its already exists--
 -- now let's insert into this table --
 insert into customer_data2
 select *, 
		row_number() over(
        partition by Customer_ID,Customer_Name,City,Department,Product,Quantity,Unit_Price,Order_Date,Total_Sales
        order by Customer_ID) AS row_num
	from customer_data1;
    
    -- let's check our table and filter it using where clause-- 
    select * from customer_data2
    where row_num >1;
    
    -- we found 150 duplicate rows overall . Let's delete them--
    -- to do updates or delete we need to set our safe mode off --
    set sql_safe_updates = 0;
    
    -- now we are go to delete. if you can't set safe mode off you can not delete  them and it shows error--
     delete from customer_data2
     where row_num > 1;
     
	-- we found that 150 rows effected . now let's check whether ther any duplicates exist still..--
     select * from customer_data2
     where row_num > 1;
     
     -- 0 exists that's it we removed all duplicates --
     -- let's see our data after removing duplicates --
     
     select * from customer_data2;
     
     -- we have to make secure afte deleting  by setting safe mode back on --
     
     set sql_safe_updates = 1;
     
     -- that's it -- thank you --
     
     