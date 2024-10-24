-- Description
-- You are given a classical database for an e-commerce platform that includes information about products, their categories, 
-- and subcategories. The database uses a soft deletion approach to handle product removals.
-- categories table:
-- id (int): primary key
-- name (varchar)
-- subcategories table:
-- id (int): primary key
-- name (varchar)
-- category_id (int): foreign key (references id in categories table)
-- products table:
-- id (int): primary key
-- name (varchar)
-- subcategory_id (int): foreign key (references id in subcategories table)
-- last_updated (dateTime)
-- deleted_at(dateTime): NULL if not deleted, otherwise the date of soft deletion
-- Write a SQL query to find categories where the total number of active products (not marked as deleted) was 10 or more 30 days 
-- ago but has decreased to less than 10 today (current_date).
-- The query should output the category_id and name of categories, along with two additional columns: current_quantity (number 
-- of active products today) and quantity_30_days_ago (number of active products 30 days ago).
-- Note that products can have a deleted_at field set in the future. For instance, for obsolete products that are bound to become 
-- inactive. Such products should be considered active today.
-- Query should be ordered by category_id in descending order.
-- The desired output should look like this:
-- category_id	name                 current_quantity  quantity_30_days_ago
-- 11	        Shoes, Toys & Baby   7	               14
-- 10	        Industrial & Garden  6	               18
-- 5	        Music	             5	               21
WITH
    product_counts AS (
        SELECT
            c.id AS category_id,
            c.name AS name,
            COUNT(
                CASE
                    WHEN p.deleted_at IS NULL
                    OR p.deleted_at > current_date - INTERVAL '30 days' THEN 1
                END
            ) AS quantity_30_days_ago,
            COUNT(
                CASE
                    WHEN p.deleted_at IS NULL
                    OR p.deleted_at > current_date THEN 1
                END
            ) AS current_quantity
        FROM
            categories c
            JOIN subcategories s ON c.id = s.category_id
            JOIN products p ON s.id = p.subcategory_id
        GROUP BY
            c.id,
            c.name
    )
SELECT
    category_id,
    name,
    current_quantity,
    quantity_30_days_ago
FROM
    product_counts
WHERE
    quantity_30_days_ago >= 10
    AND current_quantity < 10
ORDER BY
    category_id DESC;