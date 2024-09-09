-- Description
-- Welcome to our digital restaurant! Your role is to be a chef but for data, not food. 
-- Our special menu item today is 10 rows of data, served fresh from the PostgreSQL oven. 
-- As a data chef, you have a table named sample_table with two columns, a and b. 
-- Column a contains unique positive (>=1) integer values, and column b contains single characters. 
-- The table can contain random amount of rows.
-- The recipe is tricky though: No matter the number of rows in the original table, your SQL query 
-- should always return exactly 10 rows! If there aren't enough rows in the table, you'll need to add 
-- some yourself, but with a twist. These extra rows should have 0 in column a and '-' in column b.
-- Requirements:
-- Your SQL query should always return exactly 10 rows, regardless of the number of rows available in the table.
-- If there are less than 10 rows in the table, the result should be filled with extra rows. These extra rows should 
-- have 0 in column A and '-' in column B.
-- If there are more than 10 rows in the table, your query should only return the first 10 rows.
-- The returned rows should be ordered by priority: rows from the original table first, followed by the extra rows, if any.
-- The rows from the original table should be sorted in ascending order according to column a
SELECT
    a,
    b
FROM
    (
        SELECT
            *
        FROM
            sample_table
        ORDER BY
            a
    ) AS original
UNION ALL
SELECT
    0,
    '-'
FROM
    generate_series (1, 10)
LIMIT
    10;