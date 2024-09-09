-- Description
-- We have a table named books with the following schema:
-- id (integer) - The unique identifier for each book entry.
-- title (varchar) - The title of the book.
-- author (varchar) - The author of the book.
-- genres (varchar[]) - An array of genres associated with the book.
-- Write a SQL query to achieve the following:
-- Return a list of genres.
-- Count the number of books in each genre.
-- List titles of the books in each genre as an array. The titles within this array should be sorted alphabetically.
-- The output should be ordered by the number of books in each genre in descending order, and then alphabetically by 
-- genre name for genres with the same book count.
-- Desired Output
-- The desired output should look like this:
-- genre	       count	books
-- Adventure	    2	    {"Harry Potter","Lord of the Rings"}
-- Dystopian	    2	    {1984,"Brave New World"}
-- Fantasy	        2	    {"Harry Potter","Lord of the Rings"}
-- Science Fiction	2	    {"Brave New World",Foundation}
-- Political	    1	    {1984}
SELECT
    genre,
    COUNT(title) AS count,
    ARRAY_AGG (
        title
        ORDER BY
            title
    ) AS books
FROM
    (
        SELECT
            unnest (genres) AS genre,
            title
        FROM
            books
    ) AS subquery
GROUP BY
    genre
ORDER BY
    count DESC,
    genre;