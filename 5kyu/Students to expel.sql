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
-- The university is considering expelling students who either quit their studies or are consistently performing 
-- poorly in their courses. A student who quits is defined as a student with no records in the courses table. A 
-- student who is performing poorly is defined as a student with 3 or more courses with a grade less than 60.
-- Write a SQL query that retrieves a list of students who qualify for expulsion based on the criteria described above.
-- The query should return the following columns:
-- student_id: The ID of the student
-- name: The name of the student
-- reason: The reason for expelling the student. It should say either "quit studying" if the student has no records in 
-- the courses table, or "failed in [List of Courses]" where [List of Courses] is a comma-separated list of the courses 
-- that the student has failed. Each course in the list should be followed by the grade in parentheses. Failed courses 
-- should be sorted in ascending alphabetical order.
-- The result should be ordered by the student ID in ascending order.
-- Desired Output
-- The desired output should look like this:
-- student_id  name    reason
-- 10	       James   failed in Math(59), Physics(57), Science(58)
-- 11	       David   failed in Literature(58), Math(55), Physics(57), Science(56)
-- 12	       Lucy	   quit studying
-- 13	       Daniel  quit studying
-- 14	       Grace   quit studying
WITH
    failed_courses AS (
        SELECT
            student_id,
            course_name,
            score
        FROM
            courses
        WHERE
            score < 60
    ),
    failed_students AS (
        SELECT
            s.id AS student_id,
            s.name,
            COUNT(f.course_name) AS failed_count,
            STRING_AGG (
                f.course_name || '(' || f.score || ')',
                ', '
                ORDER BY
                    f.course_name
            ) AS failed_list
        FROM
            students s
            JOIN failed_courses f ON s.id = f.student_id
        GROUP BY
            s.id,
            s.name
        HAVING
            COUNT(f.course_name) >= 3
    ),
    students_with_courses AS (
        SELECT DISTINCT
            student_id
        FROM
            courses
    ),
    students_quit AS (
        SELECT
            s.id AS student_id,
            s.name
        FROM
            students s
            LEFT JOIN students_with_courses c ON s.id = c.student_id
        WHERE
            c.student_id IS NULL
    )
SELECT
    student_id,
    name,
    'failed in ' || failed_list AS reason
FROM
    failed_students
UNION ALL
SELECT
    student_id,
    name,
    'quit studying' AS reason
FROM
    students_quit
ORDER BY
    student_id;