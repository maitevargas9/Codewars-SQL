-- Description
-- You are given a PostgreSQL table named 'orders' with the following schema:
-- order_id (integer): A unique identifier for each order. This field serves as the primary key.
-- customer (varchar): A character string that indicates the customer who placed the order. 
-- It can be any single uppercase alphabet character.
-- order_type (varchar, nullable): A character string that represents the type of the order. It can either be 'S' or NULL.
-- Your task is to write a PostgreSQL query that retrieves all records from the 'orders' table. 
-- The results should be sorted as follows:
-- Customers who have at least one order of type 'S' should be displayed first. Within this group, customers should 
-- be sorted in alphabetical order and their orders of type 'S' should be displayed first, followed by NULL orders.
-- After displaying all 'S' orders for relevant customers, customers without 'S' orders should be displayed, also sorted 
-- in alphabetical order.
-- Within each group of customers, the orders should be sorted in ascending order by order_id.
-- So on the concrete example, for this sample dataset:
-- | order_id | customer | order_type |
-- +----------+----------+------------+
-- | 1        | A        | NULL       |
-- | 2        | A        | NULL       |
-- | 3        | B        | NULL       |
-- | 4        | C        | NULL       |
-- | 5        | D        | S          |
-- | 6        | B        | S          |
-- | 7        | D        | S          |
-- The result set after executing the query:
-- | order_id | customer | order_type |
-- +----------+----------+------------+
-- | 6        | B        | S          |
-- | 3        | B        | NULL       |
-- | 5        | D        | S          |
-- | 7        | D        | S          |
-- | 1        | A        | NULL       |
-- | 2        | A        | NULL       |
-- | 4        | C        | NULL       |
SELECT
    *
FROM
    orders
ORDER BY
    MAX(order_type) OVER (
        PARTITION BY
            customer
    ),
    2,
    3,
    1;