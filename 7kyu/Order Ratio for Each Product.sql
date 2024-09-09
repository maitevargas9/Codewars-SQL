-- Description
-- As a data analyst at a thriving e-commerce company, you've been assigned to understand the distribution 
-- of orders across different products. Your task is to write a PostgreSQL query that calculates the ratio of 
-- orders for each product in relation to all orders.
-- You are given a table named orders with the following schema:
-- product_id (integer): The unique identifier of a product.
-- order_id (integer): The unique identifier of an order.
-- quantity (integer): The quantity of product in the order.
-- The orders table represents all orders made in an online store. Each row represents a single order for a product, 
-- so the same product could have multiple orders and therefore appear multiple times in the table.
-- Your need to write a query that returns the following columns:
-- product_id: The unique identifier of a product.
-- count: The total number of orders for the product.
-- ratio: The ratio of number of orders for this product to number of all orders in the table, represented as a percentage. 
-- This should be of numeric type, rounded to 2 decimal places
-- The table should be sorted by product_id in ascending order.
-- On the concrete example, if the orders table is:
--  product_id | order_id | quantity 
-- ------------+----------+----------
--          1  |     1001 |       2
--          1  |     1002 |       1
--          2  |     1003 |       1
--          3  |     1004 |       1
--          3  |     1005 |       1
--          3  |     1006 |       2
-- The output based on the table above should be:
-- product_id  | count | ratio 
-- ------------+-------+-------
--          1  |     2 | 0.3333e2
--          2  |     1 | 0.1667e2
--          3  |     3 | 0.5e2

SELECT 
   product_id, 
   COUNT(order_id) AS count, 
   ROUND(COUNT(quantity) / (select COUNT(quantity)  * 0.01 FROM orders)::decimal , 2) AS ratio
FROM 
   orders 
GROUP BY
   product_id 
ORDER BY 
   product_id ASC;