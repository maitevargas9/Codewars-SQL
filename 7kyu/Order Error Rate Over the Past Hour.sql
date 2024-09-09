-- Description
-- You work in an online retail company that uses two tables to track order processing and error handling. 
-- The first table, order_processing, keeps track of all the orders. The second table, order_errors, tracks 
-- any errors that occurred while processing these orders. Both tables have the same schema:
-- id (integer) - primary Key
-- order_id (integer) - The identifier of the order.
-- order_time (datetime) - Timestamp indicating when the order was processed/had an error.
-- Now, the business wants to know the percentage of orders in the last hour that resulted in an error. 
-- They want to monitor this closely to ensure that the order processing system is working efficiently and 
-- to identify any potential issues.
-- Write a SQL query that calculates the percentage of orders that resulted in an error in the last hour. 
-- "last hour" refers to the most recent 60-minute period leading up to the current time excluding the exact 
-- boundary of 1 hour. You will need to count the number of entries in both order_processing and order_errors 
-- that have an order_time within this period and use these counts to calculate the error percentage.
-- The result should be a single value representing the error percentage, with the alias error_percentage, 
-- of numeric datatype and it should be rounded to two decimal places.
-- Notes:
-- You must ensure that division by zero does not occur in the query. If the count from order_processing is zero, 
-- the result should be NULL
-- The 1-hour interval is exclusive, meaning that records with an order_time exactly 1 hour before the current time 
-- should not be included in the counts.
SELECT
    ROUND(
        (
            SELECT
                COUNT(*)
            FROM
                order_errors
            WHERE
                order_time > NOW () - INTERVAL '1 HOUR'
        ) * 100.0 / NULLIF(
            (
                SELECT
                    COUNT(*)
                FROM
                    order_processing
                WHERE
                    order_time > NOW () - INTERVAL '1 HOUR'
            ),
            0
        ),
        2
    ) AS error_percentage;