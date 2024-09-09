-- Description
-- You are given a table named data with a single column num of type integer. 
-- The numbers in this column are supposed to be sequential (in ascending order), but some numbers are missing.
-- Your task is to write a SQL query to find the first missing number in the sequence.
-- Here's an example of what the data table might look like:
--  num
-- -----
--   1
--   2
--   4
--   5
--   6
--   8
--   9
--  11
-- For the given example data, your query should return the following result:
--  missing_number
-- ---------------
--       3
-- Notes
-- The values in the num column will be unique
SELECT
    num + 1 AS missing_number
FROM
    data
WHERE
    num + 1 NOT IN (
        SELECT
            num
        FROM
            data
    )
LIMIT
    1;