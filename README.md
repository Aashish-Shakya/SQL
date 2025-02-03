# Retail Sales Analysis SQL Project

## 📊 Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Retail`
**DBMS**: MySQL

This project demonstrates SQL skills and techniques used by data analysts to explore, clean, and analyze retail sales data. The goal is to set up a retail sales database, perform exploratory data analysis (EDA), and answer business-driven questions using SQL queries. It's an excellent resource for beginners looking to build a solid foundation in data analysis and SQL.

## 🎯 Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## 🗂️ Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail`.

- **Table Creation**: A table named `Retail_Sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.


```sql

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

```

### 2. Data Exploration & Cleaning

- **Record Count**: Count the total number of records in the dataset.
- **Customer Count**: Find how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories.
- **Null Value Check**: Identify and remove records with missing data.

```sql
-- Count total records
SELECT count(*) FROM Retail_Sales;  


-- --------------- --- Data Cleaning - Remove NULL values

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
IN MYSQL
 Safe update mode is enabled, 
 preventing DELETE or UPDATE without a WHERE condition that includes a key column (like PRIMARY KEY).
 
*/
-- Temporarily Disable Safe Mode 

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

-- Safe update mode is enabled again

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


```

### 3. Data Analysis & Findings

## Sample Business Questions:
 
 **Beginner** 
 
 Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
 Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 Q.6 Calculate the profit margin for each transaction ((total_sale - cogs) / total_sale * 100).
 
 **Intermediate**  
 
 Q.7 Count the number of transactions made by each gender.
 Q.8 Get the total sales (total_sale) for each product category.
 Q.9 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 Q.10 Write a SQL query to find the number of unique customers who purchased items from each category.
 Q.11 Identify the day of the week that had the highest number of transactions.
 Q.12 Identify customers who have made more than 5 transactions.
 Q.13 Write a SQL query to find the top 5 customers based on the highest total sales 
 
 **Advance** 
 
 Q.14 Find the customers who spent the least on a single transaction.
 Q.15 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 Q.16 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year



### 📝 SQL Queries

# Examples of SQL Queries Answering Key Business Questions:



1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

```sql
SELECT * FROM Retail_Sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM Retail_Sales
WHERE category = 'CLOTHING' 
	AND 
	  quantity > 3 
	AND
	  MONTH(sale_date) = '11' 
    AND 
	  YEAR(sale_date) = '2022' ;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category, SUM(total_Sale) as total_sales FROM Retail_Sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT AVG(age) as Av_Age FROM Retail_Sales
WHERE category = 'Beauty' ;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM Retail_Sales
WHERE total_sale > 1000;
```

6. **Calculate the profit margin for each transaction ((total_sale - cogs) / total_sale * 100).**:
```sql
SELECT transaction_ID, 
       ((total_sale - cogs) / total_sale * 100) as Profit
 FROM Retail_Sales ;
```


7. **Count the number of transactions made by each gender.**:
```sql
SELECT gender, COUNT(*) FROM Retail_Sales
GROUP BY gender ;
```

8. **Get the total sales (total_sale) for each product category.**:
```sql
SELECT category, SUM(total_Sale) as total FROM Retail_Sales
GROUP BY category ;
```

9. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT gender, category, COUNT(*) as total FROM Retail_Sales
GROUP BY gender, category ;
```


10. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category, COUNT(DISTINCT customer_ID) AS total FROM Retail_Sales
GROUP BY category;
```

11. **Identify the day of the week that had the highest number of transactions.**:
```sql
SELECT DAYNAME(sale_date) as dy , COUNT(*) as total
FROM Retail_Sales
GROUP BY dy
ORDER BY COUNT(*) Desc
LIMIT 1 ; 
```

12. **Identify customers who have made more than 5 transactions.**:

```sql
SELECT  customer_ID, Count(*) FROM Retail_Sales
GROUP BY customer_ID
HAVING COUNT(*) > 5
ORDER BY customer_ID;
```

13. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT DISTINCT customer_ID, SUM(total_sale) FROM Retail_Sales
GROUP BY customer_ID
ORDER BY SUM(total_sale) DESC
LIMIT 5;
 
```

14. **Find the customers who spent the least on a single transaction.**:
```sql
SELECT customer_ID, total_sale
FROM Retail_Sales
WHERE total_sale = (SELECT MIN( total_sale ) FROM Retail_Sales)
ORDER BY total_sale ;
```
 
15. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT 
CASE
	WHEN HOUR(sale_time) < '12' THEN 'Morning'
	WHEN HOUR(sale_time) BETWEEN '12' AND '17' THEN 'Afternoon'
    ELSE 'Evening'
END AS shift,
Count(*) as total

FROM Retail_Sales
GROUP BY shift;

```





16. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT yr,mon,ats FROM 
 (
	SELECT YEAR(sale_date) as yr, MONTH(sale_date) as mon, AVG(total_sale) as ats,
	RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC ) AS RANKE 
	FROM Retail_Sales
	GROUP BY yr,mon
	ORDER BY  RANKE
 ) AS TEST

WHERE RANKE = 1; 

```



## 📈 Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.

- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.

- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.

- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.



## 📑Reports

- **Sales Summary**: Total sales, customer demographics, and category performance summaries.

- **Trend Analysis**:  Insights into sales trends, both monthly and seasonal.

- **Customer Insights**: A detailed report on top customers and unique customer counts per category.


## ✅Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## 🚀How to Use
 
1. **Clone the Repository**: Clone this repository to your local machine using Git.

2. **Set Up the Database**: Execute the SQL scripts provided to set up the database and tables.
       
3. **Import Data**: Import the dataset into the database (make sure the date format is YYYY-MM-DD and time format is HH:MM:SS).

4. **Run the Queries**: Use the SQL queries in the retailSales.sql file to perform your analysis.

5. **Explore and Modify**: Modify the queries to explore more insights or answer additional questions.

## 📝 Author - Aashish Shakya

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### 🌟 Stay Updated and Join the Community
For more content on SQL, data analysis, and other data-related topics, follow me [@Aashish-Shakya] or star this repository.

Thank you for your support, and I look forward to connecting with you!
