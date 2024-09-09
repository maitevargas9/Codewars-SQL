-- Description
-- You are given a table called customer_purchases that contains information about customer purchases. 
-- You are required to write an SQL query to find the number of new unique customers (as num_new_customers column) on each date.
-- A new customer is defined as one making their first purchase.
-- Table schema
-- customer_id (integer) - The unique identifier for each customer
-- date (date) - The date of the purchase
-- product (varchar) - The product purchased by the customer
-- Here's an example of what the data table might look like:
-- customer_id |    date    | product
-- ------------+------------+----------
--       1     | 31-08-2023 | Orange
--       1     | 31-08-2023 | Orange
--       3     | 31-08-2023 | Apple
--       1     | 24-09-2023 | Apple
--       4     | 25-09-2023 | Orange
-- The result should be:
--     date     | num_new_customers |
-- -------------+--------------------
--  31-08-2023  | 2                 |
--  25-09-2023  | 1                 |
-- Resultant query should be ordered by date in ascending order
SELECT
    date,
    COUNT(*) AS num_new_customers
FROM
    (
        SELECT
            date,
            customer_id,
            ROW_NUMBER() OVER (
                PARTITION BY
                    customer_id
                ORDER BY
                    date
            ) AS row_number
        FROM
            customer_purchases
    ) AS ranked_puches
WHERE
    row_number = 1
GROUP BY
    date
ORDER BY
    date;