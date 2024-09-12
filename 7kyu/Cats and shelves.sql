-- Description
-- An infinite number of shelves are arranged one above the other in a staggered fashion.
-- The cat can jump either one or three shelves at a time: from shelf i to shelf i+1 or i+3 (the cat cannot climb on the shelf 
-- directly above its head).
-- Input
-- Start and finish shelf numbers (always positive integers, finish no smaller than start)
-- Task
-- Find the minimum number of jumps to go from start to finish
-- Example
-- Start 1, finish 5, then answer is 2 (1 => 4 => 5 or 1 => 2 => 5)
-- write your SQL statement here: 
-- you are given a table 'jumps' with columns 'a' (start) and 'b' (finish).
-- return a table with:
-- these columns and your result in a column named 'res'

SELECT 
  a, 
  b, 
  (b - a) % 3 + (b - a) / 3 AS res 
FROM jumps;