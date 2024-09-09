-- Description
-- As a newly hired developer at a startup, you've been tasked with refactoring the existing codebase. 
-- As usually happens in startups, the initial code has been written by a bunch of students that were doing it for free. 
-- Sinking more and more into depression as you study the code, you stumbled upon this gem:
-- SELECT * FROM (
--   SELECT DISTINCT city_name FROM stations WHERE city_name LIKE 'A%'
--   UNION
--   SELECT DISTINCT city_name FROM stations WHERE city_name LIKE 'E%'
--   UNION
--   SELECT DISTINCT city_name FROM stations WHERE city_name LIKE 'I%'
--   UNION
--   SELECT DISTINCT city_name FROM stations WHERE city_name LIKE 'O%'
--   UNION
--   SELECT DISTINCT city_name FROM stations WHERE city_name LIKE 'U%'
-- ) AS subquery
-- ORDER BY city_name ASC;
-- You need to do the refactoring of the above query without using the UNION operator.
-- The schema of stations table is following:
-- id (integer): primary key
-- city_name (string): the name of the city
SELECT DISTINCT
    city_name
FROM
    stations
WHERE
    city_name LIKE 'A%'
    OR city_name LIKE 'E%'
    OR city_name LIKE 'I%'
    OR city_name LIKE 'O%'
    OR city_name LIKE 'U%'
ORDER BY
    city_name ASC;