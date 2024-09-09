-- Description
-- Write an SQL query to retrieve the total number of sales and total amount for each category for the previous week. 
-- The term "previous week" refers to the time period that begins on the Monday immediately preceding the current week 
-- and ends on the following Sunday. This time period is considered to be the last complete week that has passed.
-- Database Schema:
-- categories:
-- category_id (integer, primary key) - Unique identifier for the category.
-- category_name (varchar) - Name of the category (e.g., Electronics, Clothing).
-- products:
-- product_id (integer, primary key) - Unique identifier for the product.
-- category_id (integer, foreign key) - References the category_id in the categories table.
-- product_name (varchar) - Name of the product.
-- sales:
-- sale_id (integer, primary key) - Unique identifier for the sale.
-- product_id (integer, foreign key) - References the product_id in the products table.
-- sale_date (date) - The date when the sale occurred.
-- amount (integer) - The amount of the sale in currency.
-- Resultant Dataset:
-- category_name (text) - Name of the category.
-- total_products_sold (integer) - Count of sales within the previous week for the given category.
-- total_sales_amount (integer) - Total amount of sales within the previous week for the given category.
-- The results should be ordered by the count of sales in descending order, then by the total amount in descending order, 
-- and finally by the category name in ascending order.
-- Desired Output
-- The desired output should look like this:
-- category_name    total_products_sold total_sales_amount
-- Electronics	    7	                1529
-- Clothing	        7	                1078
-- Furniture	    7	                1056
-- Books	        7	                465
-- Groceries	    7	                465
-- Beauty Products	5	                1045
-- Sports Equipment	5	                952
SELECT
    c.category_name AS category_name,
    COUNT(*) AS total_products_sold,
    SUM(s.amount) AS total_sales_amount
FROM
    categories c
    JOIN products USING (category_id)
    JOIN sales s USING (product_id)
WHERE
    s.sale_date >= DATE_TRUNC ('week', CURRENT_DATE - INTERVAL '1 week')
    AND s.sale_date < DATE_TRUNC ('week', CURRENT_DATE)
GROUP BY
    1
ORDER BY
    2 DESC,
    3 DESC,
    1;