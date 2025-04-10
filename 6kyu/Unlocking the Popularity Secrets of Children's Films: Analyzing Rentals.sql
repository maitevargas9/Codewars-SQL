-- Description
-- You work for a video rental store that has a large collection of films, including a wide selection of children's 
-- films. The store wants to analyze the popularity of its children's films in order to make better decisions about 
-- which films to stock and promote. To do this, you have been tasked with analyzing rental data in the store's 
-- Postgres database.
-- Your task is to write an SQL query that analyzes the popularity of children's films based on their rental history.
-- The query should display a list of all children's films, along with their popularity level and rental count. The 
-- popularity level should be based on the number of unique customers who have rented each film, and should be divided 
-- into four categories: "not popular" (<= 5 rentals), "slightly popular" (<= 15 rentals), "moderately popular" 
-- (<=30 rentals), and "very popular" (> 30 rentals). The rental count should reflect the total number of times each 
-- film has been rented.
-- The query should display the following columns:
-- film_id: The unique identifier of the film.
-- popularity: A string that shows the popularity level of the film, as described above. It should be in the format 
-- [film_title] is [popularity according to quantity of rentals]
-- rental_count: The total number of times the film has been rented.
-- Notes:
-- for the sample tests, static dump of DVD Rental Sample Database is used, for the final solution - random tests.
-- children's films meaning that they belong to Children category
-- We need to ensure that films with no rentals are to be ignored from the result set
-- We need to ensure that each customer is counted only once per film, even if they have rented the same film multiple times (this applies both for popularity and rental_count columns).
-- List should be sorted by quantaty of rentals from higher to lower and if number of rentals is the same - then by 
-- title of film alphabetically
-- Schema
-- film table:
-- Column           | Type     | Modifiers
-- -----------------+----------+----------
-- film_id          | integer  | not null
-- title            | varchar  | not null
-- description      | text     | not null
-- rating           | varchar  | not null
-- film_category table:
-- Column      | Type      | Modifiers
-- ------------+---------- +----------
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
-- customer_id  | integer   | not null
-- inventory_id | integer   | not null
-- rental_date  | timestamp | not null
-- return_date  | timestamp | 
-- inventory table:
-- Column       | Type      | Modifiers
-- ------------ +-----------+----------
-- inventory_id | integer   | not null
-- film_id      | smallint  | not null
-- store_id     | smallint  | not null
-- Desired Output
-- The desired output should look like this:
-- film_id | popularity                              | rental_count |
-- --------+-----------------------------------------+---------------
--    32   | Robbers Joon is very popular            | 31           | 
--    14   | Invasion Cyclone is moderately popular  | 28           |
-- ...
WITH
    children_films AS (
        SELECT
            f.film_id,
            f.title
        FROM
            film f
            JOIN film_category fc ON f.film_id = fc.film_id
            JOIN category c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Children'
    ),
    film_rentals AS (
        SELECT
            cf.film_id,
            cf.title,
            COUNT(DISTINCT r.customer_id) AS rental_count
        FROM
            children_films cf
            JOIN inventory i ON cf.film_id = i.film_id
            JOIN rental r ON r.inventory_id = i.inventory_id
        GROUP BY
            cf.film_id,
            cf.title
    )
SELECT
    fr.film_id,
    fr.title || ' is ' || CASE
        WHEN rental_count <= 5 THEN 'not popular'
        WHEN rental_count <= 15 THEN 'slightly popular'
        WHEN rental_count <= 30 THEN 'moderately popular'
        ELSE 'very popular'
    END AS popularity,
    rental_count
FROM
    film_rentals fr
ORDER BY
    rental_count DESC,
    fr.title ASC;