-- Description
-- Your task is to create a SQL query that generates an alternating pattern of stars (*) and numbers. 
-- The pattern should start with a single star, followed by the number "1". 
-- The stars increase one by one, and the number on the row should match the count of stars on the previous row.
-- Complete the SQL query started in the PREPARE statement. The query must accept a single integer parameter 
-- that refers to the variable number of steps. The placeholder $1 should be used for this parameter.
-- For 5 steps, the output should look like:
-- pattern
-- ---------
-- *
-- 1
-- **
-- 2
-- ***
-- Notes: The query should return a single column, pattern, where each row contains a string made up of stars or 
-- a number converted to text datatype

PREPARE alternate_star_and_number(int) AS
SELECT
CASE
  WHEN MOD(index, 2) = 0 THEN (index / 2)::text
  ELSE repeat('*', index / 2) || '*'
END
AS pattern FROM generate_series(1, $1) AS t(index);