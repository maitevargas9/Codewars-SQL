-- Description
-- Write a PostgreSQL query that selects film_id, the title and special_features columns from the film table in the DVD rental 
-- database, and returns all films that have a unique combination of special features, regardless of the order of these features 
-- in the special_features array.
-- Notes:
-- for the sample tests, static dump of DVD Rental Sample Database is used, for the final solution - random tests.
-- The result should be ordered by title alphabetically, if title is the same - then by film_id in asc order.
-- by unique is meant that a film has a special features array that doesn't match any other special features array in the film 
-- table.
-- by regardless of the order is meant that, for example, {Trailers, Deleted Scenes} and {Deleted Scenes, Trailers} is the same 
-- array. We are interested only in fully unique set of features
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
--    14   | Monty Python and the Holy Grail   | {Trailers}                             |
-- ...
SELECT
    film_id,
    title,
    special_features
FROM
    film
WHERE
    special_features IS NOT NULL
    AND ARRAY (
        SELECT
            UNNEST (special_features)
        ORDER BY
            1
    ) IN (
        SELECT
            ARRAY (
                SELECT
                    UNNEST (special_features)
                ORDER BY
                    1
            )
        FROM
            film
        WHERE
            special_features IS NOT NULL
        GROUP BY
            ARRAY (
                SELECT
                    UNNEST (special_features)
                ORDER BY
                    1
            )
        HAVING
            COUNT(*) = 1
    )
ORDER BY
    title,
    film_id ASC;