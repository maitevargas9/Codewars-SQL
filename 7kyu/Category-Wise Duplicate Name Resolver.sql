-- Description
-- Imagine you are working with a database for a medium-sized retail company that manages an extensive inventory of products. 
-- The database has a table named items where each item is categorized into different categories (e.g., electronics, clothing, 
-- kitchenware). Within each category, items are named, but due to the vast diversity of products, some item names are 
-- duplicated within the same category. The company needs to organize its inventory system to identify these items uniquely 
-- while keeping their original names. Your task is to write an SQL query that adds numeric suffixes to duplicate item names 
-- within each category, maintaining the original name for the first occurrence.
-- We have items table:
-- item_id (integer): The unique identifier for an item.
-- category_id (integer): The identifier for the category to which an item belongs.
-- item_name (string): The name of the item.
-- In this SQL task, you are required to address the issue of duplicate item names within the same category in a retail 
-- inventory database. Your goal is to uniquely identify these duplicates by appending a numerical suffix to each duplicate name. 
-- The suffix assignment should be based on the item_id in ascending order, ensuring that the item with the lowest item_id 
-- retains its original name, and subsequent duplicates receive incrementally higher suffixes (e.g., _2, _3, etc.). 
-- This process should be case-insensitive, treating item names with different cases as duplicates if they are otherwise identical.
-- Your query should produce columns item_id, category_id, and modified item_name (where item_name is the item name with any 
-- necessary suffix).
-- Output should be ordered by category_id in ascending order, and within each category, by item_id in ascending order.
-- For this sample data:
-- | item_id | category_id | item_name |
-- +---------+-------------+-----------+
-- | 1       | 1           | hoge      |
-- | 2       | 1           | hoge      |
-- | 3       | 2           | fuga      |
-- | 4       | 2           | fuga      |
-- | 5       | 2           | fuga      |
-- | 6       | 2           | piyo      |
-- | 7       | 3           | foo       |
-- | 8       | 4           | bar       |
-- | 9       | 4           | bar       |
-- the expected output should be:
-- item_id  category_id item_name
-- 1	    1	        hoge
-- 2	    1	        hoge_2
-- 3	    2	        fuga
-- 4	    2	        fuga_2
-- 5	    2	        fuga_3
-- 6	    2	        piyo
-- 7	    3	        foo
-- 8	    4	        bar
-- 9	    4	        bar_2
SELECT
    item_id,
    category_id,
    CASE
        WHEN rank = 1 THEN item_name
        ELSE item_name || '_' || rank
    END AS item_name
FROM
    (
        SELECT
            item_id,
            category_id,
            item_name,
            ROW_NUMBER() OVER (
                PARTITION BY
                    category_id,
                    LOWER(item_name)
                ORDER BY
                    item_id
            ) as rank
        FROM
            items
    ) AS t
ORDER BY
    category_id,
    item_id ASC;