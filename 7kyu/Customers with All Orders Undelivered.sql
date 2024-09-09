-- Description
-- You are working as a data analyst for an e-commerce company. The company has a database containing all orders 
-- placed by customers. The management team wants to understand their delivery performance. Specifically, 
-- they want to identify customers for whom all their orders are still undelivered.
-- You are given an orders table in a PostgreSQL database. Each row in the table represents an order from a customer. 
-- The order may or may not have been delivered.
-- The table schema is as follows:
-- id (integer) - The unique identifier for each order.
-- customer_id (integer) - The identifier of the customer who placed the order. A customer can place multiple orders.
-- delivery_date (date) - The date when the order was delivered. If the order has not been delivered yet, this field is NULL.
-- Here's a sample representation of the data:
-- id | customer_id | delivery_date
-- ----+-------------+---------------
--   1 |           1 | 2023-07-01
--   2 |           1 | NULL
--   3 |           2 | NULL
--   4 |           2 | NULL
--   5 |           3 | 2023-07-03
--   6 |           3 | 2023-07-04
--   7 |           4 | NULL
--   8 |           4 | NULL
--   9 |           5 | 2023-07-05
--  10 |           5 | NULL
-- Your task is to write an SQL query that selects all customers for whom all orders are undelivered. 
-- In other words, select the distinct customer_id values (no other columns) for which every corresponding delivery_date is NULL.
-- Return the result sorted in descending order by customer_id.
-- Desired Output
-- The desired output should look like this:
-- customer_id
-- 4
-- 2
SELECT DISTINCT
    customer_id
FROM
    orders
GROUP BY
    customer_id
HAVING
    EVERY (delivery_date IS NULL)
ORDER BY
    customer_id DESC;