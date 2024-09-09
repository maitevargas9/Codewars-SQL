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
-- In this kata, we need to find out the names and IDs of all users who ordered every available product at least once. 
-- The result should be ordered by user_id in descending order.
-- Desired Output
-- The desired output should look like this:
-- user_id  name
-- 20	    Lelia Bergstrom Sr.
-- 15	    Johnathon Hoppe
-- 1	    Sen. Ashley Brakus
SELECT
    user_id,
    name
FROM
    users
    JOIN orders ON user_id = users.id
GROUP BY
    user_id,
    name
HAVING
    COUNT(DISTINCT product_id) = (
        SELECT
            COUNT(*)
        FROM
            products
    )
ORDER BY
    user_id DESC;