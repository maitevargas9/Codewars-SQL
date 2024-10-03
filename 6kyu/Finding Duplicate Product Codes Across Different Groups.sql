-- Description
-- Write an SQL query to identify products that:
-- Have at least one other product with the same product_code but from a different group_id.
-- For a given product_code and group_id combination, if multiple entries exist, the output 
-- should only return the entry with the highest product_id.
-- If a product has a product_code that isn't found in any other group_id, then it should 
-- not appear in the result set.
-- products table:
-- product_id (integer): A unique identifier for each product.
-- group_id (integer): An identifier representing the group to which the product belongs.
-- product_code (varchar): A code assigned to the product. Multiple products, possibly from 
-- different groups, can have the same code.
-- The desired output should include all the columns of the products table. Results should be 
-- ordered by product_code first in asc order and then by group_id in descending order. Thus for this sample dataset:
-- product_id | group_id | product_code
-- -----------+----------+--------------
--     1      |    1     |      A
--     2      |    1     |      A 
--     3      |    2     |      B
--     4      |    3     |      B
-- the expected output would be:
-- product_id | group_id | product_code
-- -----------+----------+-------------
--     4      |    3     |      B
--     3      |    2     |      B
WITH
    dis AS (
        SELECT
            product_code
        FROM
            products
        GROUP BY
            product_code
        HAVING
            COUNT(DISTINCT group_id) > 1
    )
SELECT
    MAX(product_id) AS product_id,
    group_id,
    product_code
FROM
    dis
    JOIN products USING (product_code)
GROUP BY
    group_id,
    product_code
ORDER BY
    product_code,
    group_id DESC;