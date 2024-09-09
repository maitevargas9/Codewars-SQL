-- Description
-- Complete the SQL query started in the PREPARE statement.
-- prepare generate_factorial(int) as
-- Your SQL here
-- The objective is to write a SQL query that generates a table of factorials for the numbers from 1 to a given integer n. 
-- The query must accept a single integer parameter to specify this upper bound n. Use the placeholder $1 for this parameter.
-- Input and Output
-- Input: Single integer parameter n (where 1 <= n <= 12)
-- Output: A table containing integers from 1 to n in the column n and their corresponding factorials in the column result. 
-- result should be of integer datatype
-- For example, if the parameter is 5, the query should return a table like this:
-- n	result
-- 1	1
-- 2	2
-- 3	6
-- 4	24
-- 5	120

PREPARE generate_factorial(INT) AS
SELECT 
  n, 
  factorial(n)::INT AS result 
FROM generate_series(1,$1) AS n;