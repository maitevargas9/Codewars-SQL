-- Description
-- For this task we need to get film_id, film title and length from the film table in the DVD rental database, but with a twist: 
-- we need to exclude films with a length between the minimum length of R-rated films and the median length of PG-13 rated films. 
-- This means that the selected films will be either strictly shorter than the shortest R-rated film or strictly longer than of 
-- median length PG-13 rated film
-- Notes:
-- for the sample tests, static dump of DVD Rental Sample Database is used, for the final solution - random tests.
-- List should be sorted by the length of film from to lower higher and if length is the same - then by title of film 
-- alphabetically, if even titles are the same - then by film_id in asc order.
-- Since length is an integer, we should use PERCENTILE_DISC to calculate a median. percentile_disc returns a discrete value 
-- from the dataset that matches the specified percentile, while percentile_cont returns an interpolated value that lies between 
-- two adjacent data points. So for a dataset of discrete values, like integer lengths of films in our task, percentile_disc 
-- would be more appropriate to use for calculating percentiles, while for a dataset of continuous values, like temperature 
-- measurements, percentile_cont would be more appropriate.
-- (kudos to Voile for bringing this out)
-- Schema:
-- film table:
-- Column            | Type      | Modifiers
-- ------------------+-----------+-----------
-- film_id           | integer   | not null
-- title             | varchar   | not null
-- description       | text      | not null
-- release_year      | integer   | not null
-- language_id       | integer   | not null 
-- rental_duration   | integer   | not null
-- rental_rate       | numeric   | not null
-- length            | integer   | not null
-- replacement_cost  | numeric   | not null
-- rating            | varchar   | not null
-- last_update       | timestamp | not null
-- Desired Output
-- The desired output should look like this:
-- film_id | title                             | length |
-- --------+-----------------------------------+--------|
--    32   | The Shawshank Redemption          | 40     | 
--    14   | Monty Python and the Holy Grail   | 41     |
-- ...
WITH
    min_r_rating AS (
        SELECT
            MIN(length) AS min_r_length
        FROM
            film
        WHERE
            rating = 'R'
    ),
    median_pg13_rating AS (
        SELECT
            PERCENTILE_DISC(0.5) WITHIN GROUP (
                ORDER BY
                    length
            ) AS median_pg13_length
        FROM
            film
        WHERE
            rating = 'PG-13'
    )
SELECT
    film_id,
    title,
    length
FROM
    film,
    min_r_rating,
    median_pg13_rating
WHERE
    length < min_r_rating.min_r_length
    OR length > median_pg13_rating.median_pg13_length
ORDER BY
    length ASC,
    title ASC,
    film_id ASC;