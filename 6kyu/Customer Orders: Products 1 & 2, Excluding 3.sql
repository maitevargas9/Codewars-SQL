-- Description
-- Business sells only three unique products: "Product 1," "Product 2," and "Product 3."
-- Write an SQL query to find customers who have ordered "Product 1" and "Product 2" but not "Product 3." 
-- Additionally, provide a summary of how many times they have ordered the first two products.
-- Schema:
-- customers:
-- customer_id (integer) - primary key
-- name (varchar) - Name of the customer.
-- orders:
-- order_id (integer) - primary key
-- customer_id (integer) - Identifier for the customer who placed the order.
-- product_name (varchar) - Name of the ordered product. It can only be one of the three values: "Product 1," 
-- "Product 2," or "Product 3."
-- Write a query that returns the following columns:
-- customer_id: The unique identifier of the customer.
-- name: The name of the customer.
-- product_summary: A string that describes how many times the customer has ordered "Product 1" and "Product 2," 
-- formatted as "Product 1: {N} times || Product 2: {N} times."
-- The results should be ordered by customer_id in descending order.
-- Desired Output
-- The desired output should look like this:
-- customer_id	name	         product_summary
-- 92	        Jeri Auer	     Product 1: 25 times || Product 2: 25 times
-- 83	        Chang Sporer	 Product 1: 8 times || Product 2: 8 times
-- 82	        Regan Schimmel	 Product 1: 15 times || Product 2: 15 times
-- ...
WITH
    product_orders AS (
        SELECT
            o.customer_id,
            c.name,
            o.product_name,
            COUNT(*) AS order_count
        FROM
            orders o
            JOIN customers c ON o.customer_id = c.customer_id
        WHERE
            o.product_name IN ('Product 1', 'Product 2', 'Product 3')
        GROUP BY
            o.customer_id,
            c.name,
            o.product_name
    ),
    filtered_customers AS (
        SELECT
            customer_id,
            name
        FROM
            product_orders
        GROUP BY
            customer_id,
            name
        HAVING
            SUM(
                CASE
                    WHEN product_name = 'Product 1' THEN 1
                    ELSE 0
                END
            ) > 0
            AND SUM(
                CASE
                    WHEN product_name = 'Product 2' THEN 1
                    ELSE 0
                END
            ) > 0
            AND SUM(
                CASE
                    WHEN product_name = 'Product 3' THEN 1
                    ELSE 0
                END
            ) = 0
    ),
    summary AS (
        SELECT
            po.customer_id,
            po.name,
            MAX(
                CASE
                    WHEN po.product_name = 'Product 1' THEN po.order_count
                    ELSE 0
                END
            ) AS product1_count,
            MAX(
                CASE
                    WHEN po.product_name = 'Product 2' THEN po.order_count
                    ELSE 0
                END
            ) AS product2_count
        FROM
            product_orders po
            JOIN filtered_customers fc ON po.customer_id = fc.customer_id
        GROUP BY
            po.customer_id,
            po.name
    )
SELECT
    customer_id,
    name,
    'Product 1: ' || product1_count || ' times || Product 2: ' || product2_count || ' times' AS product_summary
FROM
    summary
ORDER BY
    customer_id DESC;