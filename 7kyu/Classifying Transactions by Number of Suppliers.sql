-- Description
-- You are a database administrator at a wholesale company that deals with multiple suppliers. 
-- The company keeps track of all its transactions in two PostgreSQL tables: transaction and transaction_content.
-- The transaction table contains information about each transaction, identified by a unique transaction_id and 
-- the date the transaction took place
-- | transaction_id | date       |
-- +----------------+------------+
-- |      1         | 2023-07-17 |
-- |      2         | 2023-07-17 |
-- The transaction_content table contains detailed information about the items in each transaction, including 
-- the product_code, supplier, and quantity of each item
-- | transaction_id | product_code | supplier  | quantity |
-- +----------------+--------------+-----------+----------+
-- |      1         |    8008554   | SupplierA |    3     |
-- |      1         |    8008579   | SupplierA |    4     |
-- |      1         |    9870560   | SupplierA |    5     |
-- |      2         |    8008554   | SupplierA |    7     |
-- |      2         |    8081784   | SupplierB |    1     |
-- |      2         |    8217471   | SupplierA |   23     |
-- As the company deals with multiple suppliers, a single transaction can include items from more than one supplier.
-- Write a SQL query to generate a report that shows the transaction_id, date, and supplier for each transaction. 
-- If a transaction includes items from multiple suppliers, the supplier column should display 'Several'. 
-- If all items in a transaction are from the same supplier, display the name of that supplier. 
-- The result should be ordered by transaction_id in ascending order.
-- So thus for above sample data, the solution would be
-- | transaction_id | date       | supplier  |
-- +----------------+------------+-----------+
-- |      1         | 2023-07-17 | SupplierA |
-- |      2         | 2023-07-17 | Several   |
SELECT
    transaction_id,
    date,
    CASE
        WHEN COUNT(DISTINCT supplier) > 1 THEN 'Several'
        ELSE MIN(supplier)
    END AS supplier
FROM
    transaction
    JOIN transaction_content USING (transaction_id)
GROUP BY
    transaction_id;