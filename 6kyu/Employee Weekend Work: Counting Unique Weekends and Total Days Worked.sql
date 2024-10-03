-- Description
-- You are a Data Analyst at a medium-sized retail company, known for its dynamic work schedule. The management is interested 
-- in understanding the weekend work patterns of their employees to make informed decisions about staffing and employee 
-- incentives. Your task is to analyze the employee attendance data for the year 2023, focusing on weekends.
-- Write an SQL query to analyze weekend attendance of employees in the year 2023. Your query should identify how many unique 
-- weekends each employee worked and the total number of weekend days they worked. Consider a weekend to include both Saturday 
-- and Sunday, and count consecutive Saturday and Sunday as one weekend.
-- We have employee_attendance table:
-- employee_id (integer): ID of the employee.
-- attendance_date (date): The date on which the employee worked.
-- Expected Output:
-- employee_id: ID of the employee.
-- weekends_worked: Number of unique weekends during which the employee worked at least once.
-- total_weekend_days_worked: Total number of individual weekend days (Saturdays and Sundays) the employee worked.
-- Sorting: Descending order of weekends_worked, and then by total_weekend_days_worked in desccending order, and finally by 
-- employee_id - also in descending order.
-- Note: In the provided employee_attendance data, each employee is recorded only once per date, ensuring no duplicate dates or 
-- double shifts for the same employee. This unique entry per employee per day must be considered in your analysis.
-- For this sample data:
-- | employee_id | attendance_date |
-- +-------------+-----------------+
-- |           1 |      2023-01-07 |
-- |           1 |      2023-01-08 |
-- |           1 |      2023-01-14 |
-- |           1 |      2023-01-22 |
-- |           1 |      2023-02-04 |
-- |           1 |      2023-02-05 |
-- |           2 |      2023-01-14 |
-- |           2 |      2023-01-21 |
-- |           2 |      2023-01-22 |
-- |           2 |      2023-02-11 |
-- |           3 |      2023-01-08 |
-- |           4 |      2023-02-04 |
-- the expected output is the following:
-- employee_id	weekends_worked	 total_weekend_days_worked
-- 1	        4	             6
-- 2	        3	             4
-- 3	        1	             1
-- 4	        1	             1
SELECT
    employee_id,
    COUNT(DISTINCT DATE_TRUNC ('week', attendance_date)) AS weekends_worked,
    COUNT(attendance_date) AS total_weekend_days_worked
FROM
    employee_attendance
WHERE
    EXTRACT(
        YEAR
        FROM
            attendance_date
    ) = 2023
    AND EXTRACT(
        ISODOW
        FROM
            attendance_date
    ) IN (6, 7)
GROUP BY
    employee_id
ORDER BY
    weekends_worked DESC,
    total_weekend_days_worked DESC,
    employee_id DESC;