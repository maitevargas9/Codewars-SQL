-- Description
-- In an e-commerce company, an inventory of products is maintained. Each product has a certain quantity in stock. 
-- For reporting purposes, we need to display the data of the inventory where each product appears as many times as 
-- its quantity in stock.
-- We have a table called products. The products table has the following columns: product_id (an integer representing 
--the unique ID of the product), product_name (a text string representing the name of the product), and quantity_in_stock 
-- (an integer representing the quantity of the product in stock).
-- You need to write a SQL query that generates a representation where each product appears as many times as its quantity 
-- in stock.
-- Here is a simple example of what the products table might look like:
--  product_id | product_name | quantity_in_stock 
-- ------------+--------------+-------------------
--           1 | product1     |                 4
--           2 | product2     |                 7
-- The output of your query should look something like this:
-- product_id  | product_name | quantity_in_stock 
-- ------------+--------------+-------------------
--          2  | product2     |                 7
--          2  | product2     |                 7
--          2  | product2     |                 7
--          2  | product2     |                 7
--          2  | product2     |                 7
--          2  | product2     |                 7
--          2  | product2     |                 7
--          1  | product1     |                 4
--          1  | product1     |                 4
--          1  | product1     |                 4
--          1  | product1     |                 4          
-- The output should be sorted by product_id in descending order.
SELECT
    product_id,
    product_name,
    quantity_in_stock
FROM
    products
    CROSS JOIN generate_series (1, quantity_in_stock)
ORDER BY
    product_id DESC;