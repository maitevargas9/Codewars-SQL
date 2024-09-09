-- Description
-- You are given a table named orders in a PostgreSQL database, which stores order details for an e-commerce application. 
-- order_id is the primary key and product_id represents the product ordered.
-- A sample set of data is as follows:
-- | order_id | product_id |
-- |----------|------------|
-- |    1     |     8      |
-- |    2     |     3      |
-- |    3     |     12     |
-- |    4     |     8      |
-- |    5     |     7      |
-- |    6     |     8      |
-- |    7     |     3      |
-- |    8     |     1      |
-- Your task is to write a PostgreSQL query that retrieves the orders in ascending order by order_id. However, 
-- there's a specific ordering condition - if there are multiple orders for the same product (product_id has duplicates), 
-- those orders should appear first. Within these groups and the remaining orders, they should be sorted by the smallest 
-- order_id of the group and then by order_id.
-- So thus the expected output of running this query with the provided sample data would be:
-- | order_id | product_id |
-- |----------|------------|
-- |    1     |     8      |
-- |    4     |     8      |
-- |    6     |     8      |
-- |    2     |     3      |
-- |    7     |     3      |
-- |    3     |     12     |
-- |    5     |     7      |
-- |    8     |     1      |
-- Let's break this down:
-- We need to group orders with the same product_id together: This is the reason why all orders for product_id=8 are together, 
-- and all orders for product_id=3 are together in the output. The groups are then positioned above the orders that have unique 
-- product_ids (1, 7, 12).
-- Sort by the smallest order_id of each group: This is why the group of orders for product_id=8 comes before the group of 
-- orders for product_id=3. Within the group for product_id 8, the smallest order_id is 1, and within the group for 
-- product_id 3, the smallest order_id is 2. Therefore, the group with the smallest order_id (product_id=8) comes first.
-- Then we need to sort by order_id in ascending order within each group and the remaining orders.
SELECT
    *
FROM
    orders
ORDER BY
    COUNT(order_id) OVER (
        PARTITION BY
            product_id
    ) = 1,
    MIN(order_id) OVER (
        PARTITION BY
            product_id
    ),
    order_id;