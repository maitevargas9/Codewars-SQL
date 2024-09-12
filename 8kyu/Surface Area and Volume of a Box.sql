-- Description
-- Write a function that returns the total surface area and volume of a box as an array: [area, volume]
-- write your SQL statement here: 
-- you are given a table 'box' with columns: width (int), height (int), depth (int)
-- return a query with columns: width, height, depth, area (int), volume (int)
-- sort results by area ascending, then volume ascending, then width ascending, 
-- then height ascending
SELECT
    width,
    height,
    depth,
    2 * width * height + 2 * width * depth + 2 * height * depth AS area,
    width * height * depth AS volume
FROM
    box
ORDER BY
    area ASC,
    volume ASC,
    width ASC,
    height ASC;