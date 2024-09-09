-- Description
-- Imagine a company that has many stores, and each store sells many different products. Each row in the sales table represents 
-- a single sale transaction in a specific store on a specific date, including the product sold, the quantity sold, and the unit 
-- price.
-- The table has the following columns:
-- id (integer): A unique identifier for each record in the table.
-- store_id (integer): The identifier of the store where the transaction took place.
-- product_id (integer): The identifier of the product that was sold.
-- quantity (integer): The number of units of the product that were sold in this transaction.
-- transaction_date (date): The date when the transaction took place.
-- price (float): The price per unit of the product for this transaction.
-- Your task is to write a SQL query that, for each product and store combination, finds the date of the highest 
-- single-transaction sale (i.e., the transaction in which the most units of that product were sold in one go), and the total 
-- quantity of that product sold on that day. If there is a tie for the maximum_quantity, we need to select the earliest date 
-- when this maximum quantity happened.
-- The query should return a result set with the following columns:
-- store_id: The identifier of the store.
-- product_id: The identifier of the product.
-- transaction_date: The date of the highest single-transaction sale for this store and product. If there are multiple dates 
-- with the highest single-transaction sale, we need to take the earliest.
-- max_quantity: The quantity sold in the highest single-transaction sale for this store and product.
-- total_quantity_on_max_day: The total quantity of this product sold in the store on the date of the highest single-transaction 
-- sale.
-- The result set should be ordered by store_id in ascending order, and then by product_id in ascending order.
-- Let's provide a concrete example. Here's a simplified version of what the sales table might look like:
-- +----+----------+------------+----------+-------------------+-------+
-- | id | store_id | product_id | quantity | transaction_date  | price |
-- +----+----------+------------+----------+-------------------+-------+
-- | 1  |    1     |     1      |    3     |   2023-06-01      |   5   |
-- | 2  |    1     |     1      |    7     |   2023-06-01      |   5   |
-- | 3  |    1     |     1      |    5     |   2023-06-02      |   5   |
-- | 4  |    2     |     1      |    2     |   2023-06-01      |   7   |
-- | 5  |    2     |     1      |    10    |   2023-06-02      |   7   |
-- | 6  |    2     |     2      |    4     |   2023-06-01      |   3   |
-- | 7  |    2     |     2      |    6     |   2023-06-01      |   3   |
-- +----+----------+------------+----------+-------------------+-------+
-- Let's break down the query result:
-- For store 1 and product 1, the highest single-transaction sale day was 2023-06-01 with a quantity of 7. On that day, 
-- the total quantity sold was 10 (7 from the highest single sale and 3 from the other transaction).
-- For store 2 and product 1, the highest single-transaction sale day was 2023-06-02 with a quantity of 10.
-- For store 2 and product 2, the highest single-transaction sale day was 2023-06-01 with a quantity of 6. On that day, 
-- the total quantity sold was 10 (6 from the highest single sale and 4 from the other transaction).
-- So the result of the query would be:
-- +----------+------------+-------------------+--------------+---------------------------+
-- | store_id | product_id | transaction_date  | max_quantity | total_quantity_on_max_day |
-- +----------+------------+-------------------+--------------+---------------------------+
-- |    1     |     1      |   2023-06-01      |     7        |           10              |
-- |    2     |     1      |   2023-06-02      |     10       |           10              |
-- |    2     |     2      |   2023-06-01      |     6        |           10              |
-- +----------+------------+-------------------+--------------+---------------------------+
SELECT DISTINCT
    ON (store_id, product_id) store_id,
    product_id,
    transaction_date,
    MAX(quantity) AS max_quantity,
    SUM(quantity) AS total_quantity_on_max_day
FROM
    sales
GROUP BY
    store_id,
    product_id,
    transaction_date
ORDER BY
    store_id,
    product_id,
    max_quantity DESC,
    transaction_date;