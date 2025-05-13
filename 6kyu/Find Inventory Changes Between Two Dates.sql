-- Description
-- In a retail or warehouse environment, it’s crucial to track changes in product availability over time. The 
-- inventory system records the state of inventory for every product and size combination on specific 
-- business-relevant days, such as stock-taking days or major operational dates. These records include all 
-- products and sizes, whether or not their availability has changed.
-- We have inventory table with the following structure:
-- id (int): primary key
-- product_id (int): identifier for the product.
-- product_size (varchar): Size of the product (e.g., "S", "M", "L").
-- inventory_date (date): Date when the inventory record was submitted
-- Your task is to write a parametrized SQL query that identifies:
-- Products and sizes that were present on the earlier date but are no longer available on the later date (i.e., they
-- were removed).
-- Products and sizes that were not available on the earlier date but became available on the later date (i.e., they 
-- were added).
-- The query should:
-- Accept two dates ($1 and $2) as parameters.
-- Identify inventory changes between the two dates:
-- "added": Present on the later date ($2) but not on the earlier date ($1).
-- "removed": Present on the earlier date ($1) but not on the later date ($2).
-- Sort the results by product_id in descending order and then by product_size in ascending order in case of a tie
-- Resultant columns:
-- product_id (int)
-- product_size (varchar)
-- change_type (varchar): either added or removed.
-- Notes:
-- The two dates provided as input will always be different. It is illogical to compare inventory for the same date, 
-- as no changes can occur within a single day.
-- The earlier date will always be passed as the first parameter. The later date will always be passed as the second 
-- parameter. You do not need to handle cases where the dates are swapped, as the application layer guarantees the 
-- correct order.
-- The system records the inventory state for all products and sizes every necessary for business days. As a result, 
-- there are no partial updates or missing days for a product in the dataset. Your query should therefore only analyze 
-- the records for the two specified dates. Records between these dates should not be included in the analysis because 
-- they are irrelevant to comparing the state of the inventory on the given dates.
-- For this sample data:
-- | product_id | product_size | inventory_date |
-- +------------+--------------+----------------+
-- | 1234       | S            | 2025-02-11     |
-- | 1234       | M            | 2025-02-11     |
-- | 9999       | L            | 2025-02-11     |
-- | 1234       | S            | 2025-02-13     |
-- | 1234       | M            | 2025-02-13     |
-- | 5555       | XL           | 2025-02-13     |
-- Execution of the parametrized query (EXECUTE find_inventory_changes('2025-02-11', '2025-02-13');) will provide the 
-- following result:
-- | product_id | product_size | change_type |
-- +------------+--------------+-------------+
-- | 9999       | L            | removed     |
-- | 5555       | XL           | added       |
-- Product 9999 (L): Present on 2025-02-11 but missing on 2025-02-13. Labeled as removed.
-- Product 5555 (XL): Not present on 2025-02-11 but added on 2025-02-13. Labeled as added.

PREPARE find_inventory_changes(date, date) AS
SELECT
    product_id,
    product_size,
    'removed' AS change_type
FROM
    inventory
WHERE
    inventory_date = $1
    AND (product_id, product_size) NOT IN (
        SELECT product_id, product_size
        FROM inventory
        WHERE inventory_date = $2
    )

UNION ALL

SELECT
    product_id,
    product_size,
    'added' AS change_type
FROM
    inventory
WHERE
    inventory_date = $2
    AND (product_id, product_size) NOT IN (
        SELECT product_id, product_size
        FROM inventory
        WHERE inventory_date = $1
    )
ORDER BY
    product_id DESC,
    product_size ASC;