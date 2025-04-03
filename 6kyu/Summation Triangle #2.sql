-- Description
-- The task
-- You have to make a program capable of returning the sum of all the elements of a triangle with side of size n + 1. 
-- If you have not seen the previous Kata, take a look.
-- The problem
-- Your solution has to support 0≤n≤106. Brute-forcing will not work!
-- The definition
-- A triangle element a ij where i is the column and j is the row can be defined as a ij =(2j+i+1)⋅(−1) 2j+i
-- where 0≤j≤i≤n
-- Examples
-- For n = 2:
-- 1 -2  3      \
--   -4  5       \__ 1-2+3-4+5+7 sums to: 10
--       7       /
-- sum(2) = 10
-- For n = 3:
-- 1 -2  3 -4   \
--   -4  5 -6    \__ 1-2+3-4-4+5-6+7-8-10 sums to: -18
--       7 -8    /
--        -10   /
-- sum(3) = -18
-- Hints
-- Euler transform
-- Sums of powers
-- Continuation of #1
-- you are given a table 'getsum' with column 'n' (the bounds in SQL translation: 0 <= n <= 10^5)
-- return a table with this column and your result in a column named 'res'.
SELECT 
  n, 
  (((n + 1) ^ 2 + n - n / 2) * (-1) ^ n)::BIGINT AS res
FROM getsum;