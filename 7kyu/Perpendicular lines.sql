-- Description
-- You are given an input (n) which represents the amount of lines you are given, your job is to figure out what is the 
-- maximum amount of perpendicular bisectors you can make using these lines.
-- Note: A perpendicular bisector is one that forms a 90 degree angle
-- n will always be greater than or equal to 0
-- you are given a table 'perpendicular' with column 'n'
-- return a table with this column and your result in a column named 'res'.
SELECT
    n,
    (n * n) / 4 AS res
FROM
    perpendicular;