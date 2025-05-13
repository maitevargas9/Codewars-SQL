-- Description
-- In this task you need to analyze the popularity of action movies by day of the week. Your goal is to determine 
-- which day of the week is the most popular for renting movies from "Action" category. In the resultant query you 
-- need to return film_id, film_title, and most_popular_day_of_week where most_popular_day_of_week is one of the 
-- following 3-letter abbreviations: MON, TUE, WED, THU, FRI, SAT, SUN. Result should be sorted by film title 
-- alphabetically, and if film title is the same - then by film_id in asc order.
-- Notes:
-- for the sample tests, static dump of DVD Rental Sample Database is used, for the final solution - random tests.
-- "most popular" = the most amount of rentals happened on that day of week for the film. If there is a tie, then 
-- simply return the day of week that appears first in alphabetical order.
-- lets assume that every film has non zero amount of rentals
-- as a hint, it can be done without using window functions
-- Schema
-- (not all columns - part of the domain required to solve this kata)
-- film table:
-- Column           | Type     | Modifiers
-- -----------------+----------+----------
-- film_id          | integer  | not null
-- title            | varchar  | not null
-- film_category table:
-- Column      | Type      | Modifiers
-- ----------+---------- +----------
-- film_id     | smallint  | not null
-- category_id | smallint  | not null
-- category table:
-- Column      | Type      | Modifiers
-- ------------+-----------+----------
-- category_id | smallint  | not null
-- name        | text      | not null
-- rental table:
-- Column       | Type      | Modifiers
-- -------------+-----------+----------
-- rental_id    | integer   | not null
-- inventory_id | integer   | not null
-- rental_date  | timestamp | not null
-- return_date  | timestamp | 
-- inventory table:
-- Column       | Type      | Modifiers
-- ------------ +-----------+----------
-- inventory_id | integer   | not null
-- film_id      | smallint  | not null
-- Desired Output
-- The desired output should look like this:
-- film_id | film_title             | most_popular_day_of_week |
-- --------+------------------------+--------------------------|
--    324  | Django Unchained       | MON                      | 
--    14   | 12 Years a Slave       | SAT                      |
-- ...
SELECT
    sub.film_id,
    sub.title AS film_title,
    MIN(sub.rental_day) AS most_popular_day_of_week
FROM
    (
        SELECT
            f.film_id,
            f.title,
            TO_CHAR (r.rental_date, 'DY') AS rental_day,
            COUNT(*) AS rental_count
        FROM
            film f
            JOIN film_category fc ON f.film_id = fc.film_id
            JOIN category c ON fc.category_id = c.category_id
            JOIN inventory i ON f.film_id = i.film_id
            JOIN rental r ON i.inventory_id = r.inventory_id
        WHERE
            c.name = 'Action'
        GROUP BY
            f.film_id,
            f.title,
            TO_CHAR (r.rental_date, 'DY')
    ) sub
    JOIN (
        SELECT
            film_id,
            MAX(rental_count) AS max_count
        FROM
            (
                SELECT
                    f.film_id,
                    TO_CHAR (r.rental_date, 'DY') AS rental_day,
                    COUNT(*) AS rental_count
                FROM
                    film f
                    JOIN film_category fc ON f.film_id = fc.film_id
                    JOIN category c ON fc.category_id = c.category_id
                    JOIN inventory i ON f.film_id = i.film_id
                    JOIN rental r ON i.inventory_id = r.inventory_id
                WHERE
                    c.name = 'Action'
                GROUP BY
                    f.film_id,
                    TO_CHAR (r.rental_date, 'DY')
            ) counts
        GROUP BY
            film_id
    ) max_counts ON sub.film_id = max_counts.film_id
    AND sub.rental_count = max_counts.max_count
GROUP BY
    sub.film_id,
    sub.title
ORDER BY
    sub.title,
    sub.film_id;