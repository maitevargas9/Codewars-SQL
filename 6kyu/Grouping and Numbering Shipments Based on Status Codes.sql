-- Description
-- You are working with an e-commerce company that wants to track the status of their product orders. You have been tasked with 
-- writing a SQL query that groups orders into shipping batches. Every time an order has a status code of 4 (shipped), the 
-- shipment batch number needs to restart at 1.
-- Table Schema (order_status):
-- order_id (integer) - primary key.
-- product_name (varchar) - Name of the product associated with the order.
-- status_code (integer) - Code representing the status of the order (e.g., 0 for received, 4 for shipped).
-- Sample Data:
-- | order_id  | product_name  | status_code  |
-- +-----------+---------------+--------------+
-- | 1         | Laptop        | 0            |
-- | 2         | Smartphone    | 1            |
-- | 3         | Tablet        | 1            |
-- | 4         | Monitor       | 2            |
-- | 5         | Headphones    | 3            |
-- | 6         | Keyboard      | 4            |
-- | 7         | Mouse         | 5            |
-- | 8         | Printer       | 5            |
-- | 9         | Webcam        | 6            |
-- | 10        | Laptop        | 4            |
-- | 11        | Smartphone    | 5            |
-- | 12        | Tablet        | 6            |
-- Write a SQL query that adds a new column named shipment_batch_number. This column should represent the shipment batch number 
-- and restart at 1 every time the status code is 4. When firststatus_code=4 is still not reached, it should be 0.
-- Expected Output:
-- | order_id  | product_name  | status_code  | shipment_batch_number |
-- +-----------+---------------+--------------+-----------------------+
-- | 1         | Laptop        | 0            | 0                     |
-- | 2         | Smartphone    | 1            | 0                     |
-- | 3         | Tablet        | 1            | 0                     |
-- | 4         | Monitor       | 2            | 0                     |
-- | 5         | Headphones    | 3            | 0                     |
-- | 6         | Keyboard      | 4            | 1                     |
-- | 7         | Mouse         | 5            | 2                     |
-- | 8         | Printer       | 5            | 3                     |
-- | 9         | Webcam        | 6            | 4                     |
-- | 10        | Laptop        | 4            | 1                     |
-- | 11        | Smartphone    | 5            | 2                     |
-- | 12        | Tablet        | 6            | 3                     |
-- The result should be ordered by order_id ascending order.
WITH
    shipment_batches AS (
        SELECT
            order_id,
            product_name,
            status_code,
            SUM(
                CASE
                    WHEN status_code = 4 THEN 1
                    ELSE 0
                END
            ) OVER (
                ORDER BY
                    order_id
            ) AS shipment_reset_count
        FROM
            order_status
    ),
    batch_numbering AS (
        SELECT
            order_id,
            product_name,
            status_code,
            shipment_reset_count,
            CASE
                WHEN shipment_reset_count = 0 THEN 0
                ELSE ROW_NUMBER() OVER (
                    PARTITION BY
                        shipment_reset_count
                    ORDER BY
                        order_id
                )
            END AS shipment_batch_number
        FROM
            shipment_batches
    )
SELECT
    order_id,
    product_name,
    status_code,
    shipment_batch_number
FROM
    batch_numbering
ORDER BY
    order_id;