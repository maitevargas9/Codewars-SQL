-- Description
-- As a data analyst at an online store, you are analyzing the purchasing behavior of your customers. 
-- Each customer can have multiple transactions, each transaction is either a purchase 
-- (represented by is_return column value of false) or a return (represented by is_return column value of true).
-- The transactions are recorded in a table called orders. The table structure is as follows:
-- customer_id | is_return
-- -----------------------
-- 1           |   true
-- 1           |   true
-- 1           |   false
-- 1           |   false
-- 2           |   true
-- 2           |   true
-- 2           |   true
-- 2           |   false
-- 3           |   false
-- Your task is to write a PostgreSQL SQL query that orders the data in the following way:
-- First, order by customer_id.
-- Then, within each customer, try to alternate between is_return = true (return) and is_return = false (purchase) 
-- as much as possible (starting with true). This means that, ideally, each return transaction should be followed 
-- by a purchase transaction, and vice versa. However, please note that it might not always be possible to alternate 
-- perfectly if a customer has more returns than purchases, or vice versa.
-- Here is an example of the desired output from the sample data above:
-- customer_id | is_return
-- -----------------------
-- 1           |   true
-- 1           |   false
-- 1           |   true
-- 1           |   false
-- 2           |   true
-- 2           |   false
-- 2           |   true
-- 2           |   true
-- 3           |   false
-- In this output, within each customer group, the is_return values alternate as much as possible. 
-- For instance, for customer 1, the sequence is true, false, true, false. For customer 2, the sequence 
-- is true, false, true, true. The perfect alternation is not possible for 2 as there are more returns 
-- than purchases. Lastly, for customer 3, there is only a purchase, so no alternation is possible.
SELECT
    customer_id,
    is_return
FROM
    orders
ORDER BY
    customer_id,
    ROW_NUMBER() OVER (
        PARTITION BY
            customer_id,
            is_return
    ),
    is_return DESC;