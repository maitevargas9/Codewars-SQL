-- Description
-- You are working with a database that stores information about employees in a tech firm. The database includes a 
-- table named employees with the following columns:
-- employee_id: A unique integer identifier for each employee.
-- full_name: A string representing the employee's full name.
-- team: A string that specifies which team the employee is part of. The team can be one of the following four: 
-- "backend", "frontend", "devops", or "design".
-- birth_date: A date that represents the employee's birthdate.
-- The company is planning an event where the youngest employee from each team will be given a chance to share their 
-- vision of future technology trends.
-- Your task is to write an SQL query that retrieves the complete record for the youngest member of each team. You 
-- should consider the person with the latest birthdate as the youngest. Let's assume for this task that the are no 
-- youngest employees who share the same birthdate.
-- The classical solution of using aggregate function and group by is forbidden. Can you come up with something more 
-- witty?
-- The result should be ordered by team in asc alphabetical order.
-- Desired Output
-- The desired output should look like this:
-- employee_id	full_name	team	  birth_date
-- 11	        John Doe	backend	  1980-12-01
-- 7	        Jane Smith	design	  1985-05-03
-- 24	        Bob Jones	devops	  1990-04-15
-- 54	        Dana Smith	frontend  1995-05-03
SELECT
    e.*
FROM
    employees e
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            employees e2
        WHERE
            e2.team = e.team
            AND e2.birth_date > e.birth_date
    )
ORDER BY
    e.team;