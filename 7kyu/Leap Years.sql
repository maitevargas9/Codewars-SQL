-- Description
-- In this kata you should simply determine, whether a given year is a leap year or not. In case you don't know the rules, here 
-- they are:
-- Years divisible by 4 are leap years,
-- but years divisible by 100 are not leap years,
-- but years divisible by 400 are leap years.
-- Tested years are in range 1600 ≤ year ≤ 4000.
-- Notes
-- Table years has two columns: id, and year.
-- Your query has to return rows with two columns: year, and is_leap.
-- Returned rows have to be sorted ascending by the year.
-- select
--   year,
--   false as is_leap  -- your code here
-- from years
-- order by year;      -- result has to be sorted by year, ascending

SELECT
  year,
  (year % 4 = 0 AND year % 100 <> 0 ) OR (year % 400 = 0) AS is_leap
FROM years
ORDER BY year ASC;