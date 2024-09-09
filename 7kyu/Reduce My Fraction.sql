-- Description
-- Write a function which reduces fractions to their simplest form! Fractions will
-- be presented as an array/tuple (depending on the language) of strictly positive integers, 
-- and the reduced fraction must be returned as an array/tupl
-- input: [numerator, denominator]
-- output: [reduced numerator, reduced denominator]
-- example: [45, 120] --> [3, 8]
-- All numerators and denominators will be positive integers.
-- Note: This is an introductory Kata for a series... coming soon!
SELECT
    numerator,
    denominator,
    numerator / GCD (numerator, denominator) AS reduced_numerator,
    denominator / GCD (numerator, denominator) AS reduced_denominator
FROM
    fraction
ORDER BY
    numerator ASC,
    denominator ASC;