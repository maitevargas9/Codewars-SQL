-- Description
-- Let's consider a case where we have a students table and a courses table. The tables have the following structure:
-- students:
-- | id  | name     | email               |
-- |-----|----------|---------------------|
-- | 1   | John     | john@example.com    |
-- | 2   | Sarah    | sarah@example.com   |
-- | 3   | Robert   | robert@example.com  |
-- ...
-- courses:
-- | id  | student_id | course_name | score |
-- |-----|------------|-------------|-------|
-- | 1   | 1          | Math        | 90    |
-- | 2   | 1          | Science     | 85    |
-- | 3   | 1          | Physics     | 92    |
-- | 4   | 1          | Literature  | 80    |
-- ...
-- Your task is to write a SQL query that identifies the students who have the highest combined score in 'Math' and 'Science' 
-- and assigns each student a unique ordinal number (which we will call 'rank') based on their total score. The student with 
-- the highest combined score should receive a rank of 1. If students have the same total score, the student with the smaller 
-- student ID should receive the lower rank.
-- Your query should return the following columns:
-- rank: The unique ordinal number
-- student_id: The ID of the student
-- name: The name of the student
-- total_score: The total score of the student in 'Math' and 'Science'
-- The result should be ordered by the rank in asc order
-- Good Luck!
-- Desired Output
-- The desired output should look like this:
-- rank	student_id	name	            total_score
-- 1	28	        Dr. Emelda Klocko	192
-- 2	39	        Eleonor Lynch	    191
-- 3	26	        Jannet Schoen V	    189
-- ...
SELECT
    RANK() OVER (
        ORDER BY
            SUM(c.score) DESC,
            c.student_id ASC
    ) AS rank,
    c.student_id,
    s.name,
    SUM(c.score) AS total_score
FROM
    courses c
    JOIN students s ON s.id = c.student_id
WHERE
    c.course_name IN ('Math', 'Science')
GROUP BY
    c.student_id,
    s.name
ORDER BY
    rank ASC;