-- Description
-- You work for a real estate company that has multiple property listings across various towns and cities. The company maintains 
-- a table called customer_preferences where each record signifies a customer's interest in a particular type of property in a 
-- specific town or city.
-- It's important to note that not all customer preferences end up in actual orders.
-- The marketing department has requested a ranking of property types across different towns. They want this ranking to include 
-- all combinations of towns and property types indicated in customer_preferences, even if no actual order has been placed for a 
-- given combination. This will help the marketing team understand market gaps and opportunities.
-- Schema:
-- customer_preferences:
-- customer_id (integer) - Unique identifier for each customer
-- town (varchar) - Name of the town or city where the customer is interested in finding a property
-- property_type (varchar) - The type of property the customer is interested in, e.g., Apartment, TownHouse, Condo, MultiFamily
-- order_info:
-- order_id (integer) - Unique identifier for each order
-- customer_id (integer) - Foreign Key, references the unique identifier in the customer_preferences table
-- Write an SQL query to:
-- Rank each unique combination of town and property_type in the customer_preferences table. The ranking should be ordered first 
-- by town in ascending alphabetical order and then by property_type in ascending alphabetical order.
-- Include this ranking in the output, even if there are no corresponding orders for that combination in the order_info table. In 
-- such cases, display NULL for the order_id.
-- Expected Output:
-- rank_order (integer) - Rank for each unique combination of town and property_type
-- town (varchar) - The name of the town or city
-- property_type (varchar) - The type of property
-- customer_id (integer) - The ID of the customer interested in this type of property and town
-- order_id (integer/null) - The order ID related to the customer, or NULL if no order is associated with that combination
-- Sort the output first by rank_order, then by customer_id, and finally by order_id — all in ascending order.
-- Desired Output
-- The desired output should look like this:
-- rank_order  town	    property_type  customer_id  order_id
-- 1	       Austin	Condo	       3	        
-- 2	       Dallas	MultiFamily	   4	        2
-- 3	       Houston  Apartment	   1	        1
-- 3	       Houston	Apartment	   1	        5
-- 4	       Houston	TownHouse	   2	        3
-- 4	       Houston	TownHouse	   2	        4
SELECT
    DENSE_RANK() OVER (
        ORDER BY
            c.town,
            c.property_type
    ) AS rank_order,
    c.town,
    c.property_type,
    c.customer_id,
    o.order_id
FROM
    customer_preferences AS c
    LEFT JOIN order_info AS o ON c.customer_id = o.customer_id
ORDER BY
    rank_order,
    c.customer_id,
    o.order_id;