-- Description
-- Oh no! Timmys been moved into the database divison of his software company but as we know Timmy loves making mistakes. 
-- Help Timmy keep his job by fixing his query...
-- Timmy works for a statistical analysis company and has been given a task of totaling the number of sales on a given 
-- day grouped by each department name and then each day.
-- Resultant table:
-- day (type: date) {group by} [order by asc]
-- department (type: text) {group by} [In a real world situation it is bad practice to name a column after a table]
-- sale_count (type: int)
SELECT
    DATE (s.transaction_date) AS day,
    d.name AS department,
    COUNT(s.id) AS sale_count
FROM
    sale s
    INNER JOIN department d ON s.department_id = d.id
GROUP BY
    day,
    department
ORDER BY
    day ASC;