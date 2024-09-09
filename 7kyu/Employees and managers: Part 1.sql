-- Description
-- You have been provided with a PostgreSQL database that contains an employees table. 
-- The employees table has the following structure:
-- id: an integer column that uniquely identifies each employee.
-- name: a text column that contains the name of the employee.
-- manager_id: an integer column that identifies the manager of each employee. 
-- The manager_id corresponds to an id in the same employees table. 
-- This means that our table has a recursive relationship with itself - an employee can be a manager to other employees. 
-- It is nullable: top managers do not have managers above them.
-- Your task is to write a SQL query that meets the following requirements:
-- The query should output a list of all managers and their respective employees, grouped by the manager_id.
-- The output of your query should be a table with two columns:
-- manager_id: ID of each manager.
-- employee_names: an array of all the names of employees who have that manager.
-- Each entry in the array should be a string of the form employee_name (employee_id). 
-- The employees in each array should be ordered by their id in ascending order.
-- We should avoid displaying null for manager_id colummn in the result set.
-- The output rows should be ordered by manager_id in ascending order.
-- Desired Output
-- The desired output should look like this:
-- manager_id  | employee_names                                                       |
-- ------------+----------------------------------------------------------------------|
--  1          | {"Lewis Fadel (4)","Nicole Konopelski (7)","Dwayne Wilderman (10)"}  | 
--  2          | {"Katharina Ferry (43)","Williemae Ledner (79)"}                     |
-- ...

SELECT 
   e.manager_id, 
   ARRAY_AGG(concat(e.name, ' (', e.id::text, ')') ORDER BY e.id) AS employee_names
FROM 
   employees e 
WHERE 
   e.manager_id IS NOT NULL
GROUP BY 
   e.manager_id 
ORDER BY 
   e.manager_id;