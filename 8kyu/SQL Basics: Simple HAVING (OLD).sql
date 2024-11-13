-- Description
-- For this challenge you need to create a simple HAVING statement, you want to find all the people with the age greater than 42
-- in the HAVING and GROUP BY the id.
-- people table schema
-- id
-- name
-- age
-- select table schema
-- id [group by]
-- name
-- age (having > 42)
-- NOTE: Your solution should use pure SQL. Ruby is used within the test cases to do the actual testing.
SELECT
    *
FROM
    people
GROUP BY
    id
HAVING
    age > 42;