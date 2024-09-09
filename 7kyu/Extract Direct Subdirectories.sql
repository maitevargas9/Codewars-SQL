-- Definition
-- Given a table containing directory paths, write a SQL query to extract all direct subdirectories of a 
-- specified base directory. The results should be in alphabetical order.
-- We have directories table
-- id (integer): primary key
-- path (varchar): column containing directory paths.
-- Task Requirements:
-- Your query should extract direct subdirectories of the base path /home/user/pictures/.
-- The result should not contain the full path, but only the direct subdirectory name.
-- The result should not have duplicates.
-- The result should be sorted in alphabetical order.
-- The result should contain single subdirectory column
-- For this sample data:
-- | id |                   path                      |
-- +----+---------------------------------------------+
-- | 1  | /home/user/pictures/books/2022              |
-- | 2  | /home/user/pictures/vacation                |
-- | 3  | /home/user/pictures/work/2023/important     |
-- | 4  | /home/user/pictures/vacation/2023           |
-- query needs to return
-- | subdirectory |
-- +--------------+
-- | books        |
-- | vacation     |
-- | work         |
SELECT DISTINCT
    SPLIT_PART (path, '/', 5) AS subdirectory
FROM
    directories
WHERE
    path LIKE '/home/user/pictures/_%';