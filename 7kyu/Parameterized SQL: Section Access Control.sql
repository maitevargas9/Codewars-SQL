-- Description
-- Your task is to write a parameterized PostgreSQL query to fetch the accessible sections based on a given user ID. 
-- The query should only return sections to which the user has access. The result set should contain the columns id 
-- and section_name and should be ordered by id in ascending order.
-- section_access schema:
-- id (integer) - A unique identifier for each row.
-- section_name (varchar) - The name of the section.
-- user_access (varchar) - A comma-separated string of user IDs who have access to this section.
-- Write a prepared SQL statement named find_sections that takes a user ID as a parameter (of integer type). 
-- Use $1 as a placeholder for the user ID parameter.
-- For this sample data:
-- | id | section_name | user_access |
-- +----+--------------+-------------+
-- |  1 | editNews     | 1,13,15     |
-- |  2 | deleteNews   | 2,13,14     |
-- |  3 | createNews   | 1,2,3       |
-- The expected result for EXECUTE find_sections(1) would be:
-- | id | section_name |
-- +----+--------------+
-- |  1 | editNews     |
-- |  3 | createNews   |

PREPARE find_sections(int) AS
SELECT 
   id, section_name 
FROM 
   section_access 
WHERE 
   ','||user_access||',' LIKE '%,' || $1::text || ',%' 
ORDER BY 
   id ASC;