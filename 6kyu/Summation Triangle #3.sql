-- Description
-- The task
-- You have to make a program capable of returning the sum of all the elements of all the triangles with side of 
-- smaller or equal than n+1. If you have not seen the previous Kata, take a look.
-- The problem
-- Your solution has to support 0≤n≤106. Beware, some sequences computed by hand for a few values of n may not have a 
-- very trivial solution, even if it looks like it. Brute-forcing will not work!
-- The definition
-- An element a ij where i is the column and j is the row can be defined as a ij =(2j+i+1)(−1) 3j+3i−j(−1) n + i(−1) n
-- where 0≤j≤i≤n. The sum of all elements composing the triangle is defined by T(n):=∑ (i,j)∈T a ij. The answer for 
-- this Kata is returning sum(n):=∑ i=0..n T(i).
-- Examples
-- For n = 3:
-- 1 -2  3 -4   \
--   -4  5 -6    \__ 1-2+3-4-4+5-6+7-8-10 sums to: -18
--       7 -8    /
--        -10   /
-- 1  2  3      \
--   -4 -5       \__ 1+2+3-4-5+7 sums to: 4
--       7       /
-- 1 -2          \__ 1-2-4 sums to: -5
--   -4          / 
-- 1              __ sums to: 1
-- Therefore:
-- sum(3) = -18 +4 -5 +1 = -18
-- Hints
-- Euler transform
-- Sums of powers
-- Special case of #2
-- you are given a table 'getsum' with column 'n' (the bounds in SQL translation: 0 <= n <= 10^5)
-- return a table with this column and your result in a column named 'res'.
SELECT
  n,
  (-(n / 2 + 2 * (n % 2) - 1) * (n / 2 + n % 2 + 1) ^ 2)::BIGINT AS res
FROM getsum;