-- Description
-- At Company X, employee certifications are a big deal. Certificates are essential for promotions, training programs, 
-- and awards. But lately, there’s been an uproar: employees are fuming about typos in their names on official 
-- certificates.
-- Management has been inundated with complaints:
-- "Why does my certificate say 'Jon Smyth' when my name is 'John Smith'?"
-- "Who is 'Jane Do'? Is that supposed to be me?"
-- "I’m so tired of correcting my name for the third time!"
-- This chaos has sparked a blame game between data entry specialists. Management hears excuses like:
-- "It’s not my fault! The names were misspelled in the source data!"
-- "I only copy what’s given to me!"
-- "Maybe it was Alice who messed it up this time!"
-- Management is tired of the finger-pointing. They decide to settle this once and for all with hard metrics...
-- Objective
-- You, as a data analyst, are tasked with identifying errors in certification records created by data entry 
-- specialists. Complaints have surfaced about typos in certification names, and management wants actionable metrics 
-- to:
-- Identify the specialists responsible for the most errors.
-- Quantify the extent of these errors.
-- Improve data entry processes by retraining staff or implementing validation systems.
-- Your analysis must focus on records where the Levenshtein distance (edit distance) between the employee’s correct 
-- name and the name on their certificate is between 1 and 3, indicating likely typos. Direct string comparison 
-- (employees.name != certifications.cert_name) is insufficient because cert_name values sometimes may be entirely 
-- unrelated to the employee's name (e.g., an organization name or another person's name).
-- We have employees table:
-- id (int, primary key): Unique identifier for the employee.
-- name (varchar): Correct name of the employee.
-- and certifications table:
-- id (int, primary key): Unique identifier for the certification record.
-- employee_id (int): Foreign key referencing employees.id.
-- cert_name (varchar): Name on the certification record (entered by a specialist).
-- entered_by (int): Id of the data entry specialist who created or updated the record.
-- updated_at (timestamp): Date and time the certification record was last updated.
-- Requirements:
-- Use the Levenshtein function (levenshtein(string1, string2)) to calculate the edit distance between employees.name 
-- and certifications.cert_name. We take into account records where the Levenshtein distance is between 1 and 3, as 
-- these likely represent typos in the employee’s name. This function is included in the database setup - you don't 
-- need to enable/create it manually.
-- Calculate the percentage of total errors attributable to each specialist.
-- Resultant columns:
-- specialist_id (int): The unique ID of the specialist (certifications.entered_by).
-- error_count: Total number of records entered by the specialist with Levenshtein distances between 1 and 3.
-- error_percentage (varchar): The percentage of total errors caused by this specialist (calculated as (Error Count / 
-- Total Errors) * 100). It should be:
-- Rounded to two decimal places for clarity and precision.
-- Converted to a string (varchar) for better display and formatting in reports.
-- The primary ordering criterion is error_count desc (highest errors first). And secondly, by specialist_id in the 
-- case of a tie.
-- For this sample data:
-- employees: 
-- | id | name           |
-- +----+----------------+
-- | 1  | John Smith     |
-- | 2  | Jane Doe       |
-- | 3  | Annabelle Lee  |
-- certifications: 
-- | id  | employee_id | cert_name     | entered_by | updated_at          |
-- +-----+-------------+---------------+------------+---------------------+
-- | 101 | 1           | Jon Smith     | 1          | 2023-01-15 09:00:00 |
-- | 102 | 1           | John Smit     | 2          | 2023-02-10 14:00:00 |
-- | 103 | 2           | Jane Do       | 1          | 2023-01-20 08:00:00 |
-- | 104 | 2           | Acme Corp.    | 3          | 2023-01-25 12:00:00 |
-- | 105 | 3           | Annabel Lee   | 1          | 2023-03-01 10:00:00 |
-- the expected output is the following:
-- | specialist_id | error_count | error_percentage |
-- +---------------+-------------+------------------+
-- | 1             | 3           | 75.00            |
-- | 2             | 1           | 25.00            |
WITH
    typo_errors AS (
        SELECT
            c.entered_by AS specialist_id,
            COUNT(*) AS error_count
        FROM
            certifications c
            JOIN employees e ON c.employee_id = e.id
        WHERE
            levenshtein (e.name, c.cert_name) BETWEEN 1 AND 3
        GROUP BY
            c.entered_by
    ),
    total_errors AS (
        SELECT
            SUM(error_count) AS total
        FROM
            typo_errors
    )
SELECT
    te.specialist_id,
    te.error_count,
    ROUND((te.error_count * 100.0 / t.total), 2) || '' AS error_percentage
FROM
    typo_errors te
    JOIN total_errors t ON 1 = 1
ORDER BY
    te.error_count DESC,
    te.specialist_id;