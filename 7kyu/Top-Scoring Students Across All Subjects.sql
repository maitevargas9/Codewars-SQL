-- Description
-- Write an SQL query to identify the names of students who scored the highest mark in comparison to 
-- their peers in every subject they attended.
-- Table Schema:
-- students:
-- student_id (integer) - Unique identifier for each student.
-- student_name (varchar) - Name of the student.
-- details (varchar) - Additional details related to the student (for this challenge, it may have a static value like 'X').
-- subjects:
-- subject_id  (varchar) - Unique identifier for each subject (e.g., 'M' for Math).
-- subject_name (varchar) - Name of the subject (e.g., 'Math', 'English').
-- marks:
-- student_id (integer) - Identifier linking to the students table.
-- subject_id (varchar) - Identifier linking to the subjects table.
-- mark_rate (integer) - The mark or score the student has received for the subject.
-- Resultant Dataset Columns:
-- student_id - Unique identifier for the student.
-- student_name - The name of the student.
-- The result should be ordered by student_id in descending order.
SELECT
    s.student_id,
    s.student_name
FROM
    students s
    JOIN marks m USING (student_id)
GROUP BY
    s.student_id,
    s.student_name
HAVING
    EVERY (
        m.mark_rate = (
            SELECT
                MAX(mark_rate)
            FROM
                marks
            WHERE
                subject_id = m.subject_id
        )
    )
ORDER BY
    student_id DESC;