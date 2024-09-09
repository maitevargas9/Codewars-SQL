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
-- | 3   | 2          | Math        | 92    |
-- | 4   | 2          | Science     | 80    |
-- ...
-- We need to find the students who have a higher score in Science than in Math.
-- Your SQL query should return the student_id, name (the name of the student), and his or her difference in scores between 
-- these courses (named as score_difference).
-- Order the result by the difference in scores in descending order, and if diffrence is the same, then by student_id in 
-- ascending order.
-- Good Luck!
-- Desired Output
-- The desired output should look like this:
-- student_id	name	score_difference
-- 3	        Robert	25
-- 5	        Emma	3
-- 6	        Olivia	2
-- 10	        James	2
SELECT
    student_id,
    name,
    score_difference
FROM
    (
        SELECT
            student_id,
            students.name,
            SUM(
                CASE
                    WHEN course_name IN ('Science') THEN score
                    WHEN course_name IN ('Math') THEN - score
                END
            ) AS score_difference
        FROM
            students
            JOIN courses ON students.id = courses.student_id
        GROUP BY
            student_id,
            students.name
    ) AS difference
WHERE
    score_difference > 0
ORDER BY
    score_difference DESC,
    student_id;