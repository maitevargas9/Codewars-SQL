-- Description
-- Write a PostgreSQL query that selects film_id, the title and special_features columns from the film table in the DVD rental 
-- database, and returns all films that have the most popular feature as one of their features. By "most popular" is meant that 
-- it appears most frequently among all the special features amidst all films of film table
-- Notes:
-- for the sample tests, static dump of DVD Rental Sample Database is used, for the final solution - random tests.
-- The result should be ordered by title alphabetically, if title is the same - then by film_id in asc order.
-- let's assume that there are no ties for the most frequent special feature
-- in special_features there are no duplicates - all values are unique
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
-- special_features  | text[]    | not null
-- Desired Output
-- The desired output should look like this:
-- film_id | title                             | special_features                       |
-- --------+-----------------------------------+----------------------------------------|
--    32   | A Shawshank Redemption            | {Trailers, Deleted Scenes}             | 
--    14   | Monty Python and the Holy Grail   | {Trailers, Deleted Scenes}             |
-- ...
WITH
    feature_counts AS (
        SELECT
            UNNEST (special_features) AS feature,
            COUNT(*) AS count
        FROM
            film
        GROUP BY
            feature
        ORDER BY
            count DESC
        LIMIT
            1
    )
SELECT
    f.film_id,
    f.title,
    f.special_features
FROM
    film f
    JOIN feature_counts fc ON fc.feature = ANY (f.special_features)
ORDER BY
    f.title ASC,
    f.film_id ASC;