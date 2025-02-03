-- --------------------------------------- Database Setup ---------------------------------------------------------------

CREATE DATABASE Retail;

USE Retail;

CREATE TABLE Retail_Sales(
	transaction_ID INT PRIMARY KEY,
	sale_date DATE, 
	sale_time TIME, 
	customer_ID INT, 
	gender VARCHAR(10), 
	age INT DEFAULT 0, 
	category VARCHAR(20),
	quantity INT ,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT

);

 -- --------------------------------------- 2. Data Exploration & Cleaning  ---------------------------------------------------------------
 
SELECT count(*) FROM Retail_Sales;  


-- ------------------------------ Data Cleaning

SELECT * FROM Retail_Sales
WHERE transaction_ID = NULL OR
	sale_date = NULL OR
	sale_time= NULL OR
	customer_ID = NULL OR
	gender = NULL OR
	age = NULL OR
	category = NULL OR
	quantity = NULL OR
	cogs = NULL OR
	price_per_unit = NULL OR
	total_sale = NULL ;

/*
 safe update mode is enabled, 
 preventing DELETE or UPDATE without a WHERE condition that includes a key column (like PRIMARY KEY).
 
*/
-- Temporarily Disable Safe Mode (Recommended for Testing)

SET SQL_SAFE_UPDATES = 0;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_ID IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    cogs IS NULL OR
    price_per_unit IS NULL OR
    total_sale IS NULL;

SET SQL_SAFE_UPDATES = 1;
 
 
-- ------------------------ Data Exploration

-- Read Data 
SELECT * FROM Retail_Sales; 

-- How many sales we have ?
SELECT count(*) FROM Retail_Sales;  

-- How many uniuque customers we have ?
SELECT count(DISTINCT customer_ID) FROM Retail_Sales;

-- How many uniuque category we have?
SELECT count(DISTINCT category) FROM Retail_Sales;


 -- --------------------------------------- 3. Data Analysis & Findings---------------------------------------------------------------

/*
 My Analysis & Findings
 
 -- Beginner 
 
 Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
 Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 Q.6 Calculate the profit margin for each transaction ((total_sale - cogs) / total_sale * 100).
 
 -- Intermediate 
 
 Q.7 Count the number of transactions made by each gender.
 Q.8 Get the total sales (total_sale) for each product category.
 Q.9 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 Q.10 Write a SQL query to find the number of unique customers who purchased items from each category.
 Q.11 Identify the day of the week that had the highest number of transactions.
 Q.12 Identify customers who have made more than 5 transactions.
 Q.13 Write a SQL query to find the top 5 customers based on the highest total sales 
 
 -- Advance
 
 Q.14 Find the customers who spent the least on a single transaction.
 Q.15 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 Q.16 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

*/

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM Retail_Sales
WHERE sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022


SELECT * FROM Retail_Sales
WHERE category = 'CLOTHING' 
	AND 
	  quantity > 3 
	AND
	  MONTH(sale_date) = '11' 
    AND 
	  YEAR(sale_date) = '2022' ;




-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.



SELECT category, SUM(total_Sale) as total_sales FROM Retail_Sales
GROUP BY category;



-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.


SELECT AVG(age) as Av_Age FROM Retail_Sales
WHERE category = 'Beauty' ;




-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.


SELECT * FROM Retail_Sales
WHERE total_sale > 1000;




--  Q.6 Calculate the profit margin for each transaction ((total_sale - cogs) / total_sale * 100).


SELECT transaction_ID, ((total_sale - cogs) / total_sale * 100) as Profit FROM Retail_Sales ;



-- Q.7 Count the number of transactions made by each gender.
SELECT gender, COUNT(*) FROM Retail_Sales
GROUP BY gender ;


-- Q.8 Get the total sales (total_sale) for each product category.

SELECT category, SUM(total_Sale) as total FROM Retail_Sales
GROUP BY category ;


-- Q.9 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.


SELECT gender, category, COUNT(*) as total FROM Retail_Sales
GROUP BY gender, category ;



-- Q.10. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT customer_ID) AS total FROM Retail_Sales
GROUP BY category;



-- Q.11 Identify the day of the week that had the highest number of transactions.

SELECT DAYNAME(sale_date) as dy , COUNT(*) as total
FROM Retail_Sales
GROUP BY dy
ORDER BY COUNT(*) Desc
LIMIT 1 ; 



-- Q.12  Identify customers who have made more than 5 transactions.


SELECT  customer_ID, Count(*) FROM Retail_Sales
GROUP BY customer_ID
HAVING COUNT(*) > 5
ORDER BY customer_ID;




-- Q.13 Write a SQL query to find the top 5 customers based on the highest total sales 


SELECT DISTINCT customer_ID, SUM(total_sale) FROM Retail_Sales
GROUP BY customer_ID
ORDER BY SUM(total_sale) DESC
LIMIT 5;
 
 
 
 
 
-- Q.14 Find the customers who spent the least on a single transaction.


SELECT customer_ID, total_sale
FROM Retail_Sales
WHERE total_sale = (SELECT MIN( total_sale ) FROM Retail_Sales)
ORDER BY total_sale ;
 
 




-- Q.15. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):



SELECT 
CASE
	WHEN HOUR(sale_time) < '12' THEN 'Morning'
	WHEN HOUR(sale_time) BETWEEN '12' AND '17' THEN 'Afternoon'
    ELSE 'Evening'
END AS shift,
Count(*) as total

FROM Retail_Sales
GROUP BY shift;



 


-- Q.16 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

-- Method 1 - Using Subquery
   /*
 1. First query Avg Sale of month in each year --> 
 2. Filter only Max of Avg Sale  from step 1
 3. select month of that Avg sale by comparing its value.
 */
 

SELECT YEAR(sale_date) as yr , MONTH(sale_date) as mnth, AVG(total_sale) as av_sales FROM Retail_Sales
GROUP BY YEAR(sale_date) , MONTH(sale_date)
HAVING AVG(total_sale) 
			IN ( SELECT MAX(ats)  
				 FROM ( SELECT YEAR(sale_date) as yr,MONTH(sale_date) as mon, AVG(total_sale) as ats 
						FROM Retail_Sales
						GROUP BY yr,mon
						ORDER BY yr,mon 
					  ) AS TEST
				GROUP BY YR
			  );
              
               

-- Method 2 - Using Windows Function
 
 SELECT * FROM 
 (
	SELECT YEAR(sale_date) as yr, MONTH(sale_date) as mon, AVG(total_sale) as ats,
	RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC ) AS RANKE 
	FROM Retail_Sales
	GROUP BY yr,mon
	ORDER BY  RANKE
 ) AS TEST

WHERE RANKE = 1; 
 


