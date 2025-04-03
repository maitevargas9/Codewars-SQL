-- Description
-- Give the summation of all even numbers in a Fibonacci sequence up to, but not including, the number passed to your 
-- function. Or, in other words, sum all the even Fibonacci numbers that are lower than the given number n (n is not 
-- the nth element of Fibonacci sequence) without including n.
-- The Fibonacci sequence is a series of numbers where the next value is the addition of the previous two values. The 
-- series starts with 0 and 1:
-- 0 1 1 2 3 5 8 13 21...
-- For example:
-- Kata.Fibonacci(0) // returns 0
-- Kata.Fibonacci(33) // returns 10
-- Kata.Fibonacci(25997544) // returns 19544084
-- you are given a table 'evenfib' with column 'n'.
-- return a table with:
-- this column and your result in a column named 'res'
-- ordered ascending by 'n'
-- distinct results (remove duplicates)
WITH RECURSIVE fib_sequence (a, b) AS (
    SELECT 0::BIGINT, 1::BIGINT
    UNION ALL
    SELECT b, a + b FROM fib_sequence WHERE b < (SELECT MAX(n) FROM evenfib)
),
even_fibs AS (
    SELECT a FROM fib_sequence WHERE a % 2 = 0 
)
SELECT DISTINCT e.n,
   CAST(
    CASE 
        WHEN e.n = 0 THEN 0
        ELSE (SELECT COALESCE(SUM(a),0) FROM even_fibs WHERE a < e.n)
    END AS BIGINT
) AS res 

FROM evenfib e
ORDER BY e.n;