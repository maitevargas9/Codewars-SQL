-- Description
-- You work for a DVD rental store that wants to understand which movie genres are the most popular among customers 
-- who have rented at least one movie during multiple months. By analyzing rental data over a longer period of time, 
-- the store owner hopes to gain insights into most active customer's preferences and identify trends that can inform 
-- their business decisions as well as which genres may be experiencing a surge or decline in popularity.
-- Your task is to write a SQL query to identify the top five most popular movie genres among customers who have rented 
-- at least one movie during the months of May, June, and July of 2005 (in each of these 3 months), regardless of 
-- whether they rented movies in other months.
-- Notes:
-- for the sample tests, static dump of DVD Rental Sample Database is used, for the final solution - random tests.
-- by popularity is meant the quantity of rentals by the eligible customers, regardless of the period in which the 
-- rental was made
-- by genre- category.name from category table
-- List should be sorted by the quantaty of rentals from higher to lower and if number of rentals is the same - then 
-- by title of category alphabetically
-- Schema
-- customer table:
-- Column       | Type     | Modifiers
-- ------------ +----------+----------
-- customer_id  | integer  | not null
-- first_name   | varchar  | not null
-- last_name    | varchar  | not null
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
--   genre   |  total_rentals |
-- ----------+----------------|
--   Action  |  1035          | 
--   Sci-Fi  |  1004          |
SELECT
    category.name AS genre,
    COUNT(rental.rental_id) AS total_rentals
FROM
    rental
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
WHERE
    rental.customer_id IN (
        SELECT DISTINCT
            customer_id
        FROM
            rental
        WHERE
            date_trunc ('month', rental_date) IN ('2005-05-01', '2005-06-01', '2005-07-01')
        GROUP BY
            customer_id
        HAVING
            COUNT(DISTINCT date_trunc ('month', rental_date)) = 3
    )
GROUP BY
    category.name
ORDER BY
    total_rentals DESC,
    category.name
LIMIT
    5;