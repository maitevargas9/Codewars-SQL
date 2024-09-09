-- Description
-- Let's consider a situation where we have three tables:
-- users table:
-- Columns: id, name
-- Primary key: id
-- products table:
-- Columns: id, product_name
-- Primary key: id
-- orders table:
-- Columns: id, user_id, product_id
-- Primary key: id
-- Foreign keys: user_id references users(id), product_id references products(id)
-- In this kata, we need to find the most popular product (i.e., the product that has been ordered the most). 
-- In case of a tie in the number of orders, return all most ordered products ordered by product ID in descending order. 
-- Include in the result also the total number of orders for that product.
-- Desired Output
-- The desired output should look like this:
-- product_id	product_name	count_orders
-- 2	        Product2	    20
-- 1	        Product1	    20
SELECT
    product_id,
    product_name,
    count(*) AS count_orders
FROM
    orders
    INNER JOIN products ON orders.product_id = products.id
GROUP BY
    product_id,
    product_name
HAVING
    count(*) >= ALL (
        SELECT
            count(*)
        FROM
            orders
        GROUP BY
            product_id
    )
ORDER BY
    product_id DESC;