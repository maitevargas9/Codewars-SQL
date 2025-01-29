-- Description
-- Write a parameterized PostgreSQL query to find groups with the exact same set of employees as a specified group.
-- Schema (groups table):
-- employee_id (integer): identifier for each employee.
-- group_name (varchar): The name of the group.
-- Task Instructions:
-- Create a prepared SQL statement named find_groups_with_matching_employees.
-- The statement should take a group name as its parameter (of type text). Use $1 as a placeholder for this parameter.
-- Return groups that have the same exact set of employees as the group specified in the parameter.
-- The result should contain the columns group_name and employees (which is an ordered array of employee IDs. 
-- IDs are sorted in ascending order).
-- The result should be ordered by group_name in ascending order.
-- For this sample data:
--  employee_id | group_name 
-- -------------+------------
--     1        | a1         
--     2        | a1         
--     1        | b1         
--     2        | b1         
--     3        | c1         
--     4        | d1   
-- For the EXECUTE find_groups_with_matching_employees('a1'), the expected result would be:
--  group_name | employees 
-- ------------+-----------
--  b1         | {1,2}

PREPARE find_groups_with_matching_employees(TEXT) AS
WITH target_group AS (
    SELECT ARRAY_AGG(employee_id ORDER BY employee_id) AS employees
    FROM groups
    WHERE group_name = $1
)
SELECT g.group_name, ARRAY_AGG(g.employee_id ORDER BY g.employee_id) AS employees
FROM groups g
JOIN target_group tg
ON (SELECT array_agg(employee_id ORDER BY employee_id) FROM groups WHERE group_name = g.group_name) = tg.employees
WHERE g.group_name <> $1
GROUP BY g.group_name
ORDER BY g.group_name;