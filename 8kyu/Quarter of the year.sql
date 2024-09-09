-- Description
-- Given a month as an integer from 1 to 12, return to which quarter of the year it belongs as an integer number.
-- For example: month 2 (February), is part of the first quarter; month 6 (June), is part of the second quarter; 
-- and month 11 (November), is part of the fourth quarter.
-- Constraint:
-- 1 <= month <= 12

SELECT
  month, 
  CASE
     WHEN month BETWEEN 1 and 3 THEN 1
     WHEN month BETWEEN 4 and 6 THEN 2
     WHEN month BETWEEN 7 and 9 THEN 3
     WHEN month BETWEEN 10 and 12 THEN 4
   END AS res
FROM quarterof;