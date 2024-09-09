-- Description
-- The business tracks its product sales and product returns in two separate tables: table_sales and table_returns. 
-- Both tables have the same structure:
-- id (integer): primary key
-- product_id (string): ID of the product.
-- quantity (integer): Number of products sold/returned.
-- date (date): Date of the sale/return.
-- Fetch the consolidated data such that the output columns are:
-- product_id: ID of the product.
-- sale_qty: Quantity sold on the date. If no sales are available for that date, show NULL.
-- return_qty: Quantity returned on the date. If no returns are available for that date, show NULL.
-- date: Date of the transaction.
-- Notes:
-- Only one transaction for a product_id per date is possible.
-- The results should be sorted by product_id and then by date both in ascending order.
-- So thus for such a sample data:
-- table_sales:
-- id | product_id | quantity |    date    
-- ---+------------+----------+------------
--  1 | c001       |       20 | 2023-08-03
--  2 | t008       |       30 | 2023-08-01
--  3 | t008       |       20 | 2023-08-03
--  4 | c001       |       90 | 2023-08-09
-- table_returns:
-- id | product_id | quantity |    date    
-- ---+------------+----------+------------
--  1 | t008       |       40 | 2023-08-08
--  2 | t008       |       30 | 2023-08-01
--  3 | c001       |       10 | 2023-08-03
-- The desired out is the following:
-- product_id | sale_qty | return_qty |    date    
-- -----------+----------+------------+------------
-- c001       |       20 |         10 | 2023-08-03
-- c001       |       90 |     NULL   | 2023-08-09
-- t008       |       30 |         30 | 2023-08-01
-- t008       |       20 |     NULL   | 2023-08-03
-- t008       |    NULL  |         40 | 2023-08-08
SELECT
    product_id,
    ts.quantity AS sale_qty,
    tr.quantity AS return_qty,
    date
FROM
    table_sales ts
    FULL JOIN table_returns tr USING (product_id, date)
ORDER BY
    product_id,
    date ASC;