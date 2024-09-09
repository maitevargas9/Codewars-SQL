-- Description
-- Your goal is to write SQL query that will generate a descending star pattern. 
-- The number of stars in the first line should be parameterized. 
-- You will use PostgreSQL's support for prepared statements to achieve this.
-- Complete the SQL query started in the PREPARE statement. The query must accept a 
-- single integer parameter that specifies the number of stars in the first line. 
-- The placeholder $1 should be used for this parameter.
-- if the parameter is 3, the query should return:
-- ***
-- **
-- *
-- Notes: The query should return a single column, star_pattern, where each row contains a string made up of stars.

PREPARE draw_pattern(int) AS
SELECT REPEAT('*', generate_series($1,1,-1)) star_pattern;