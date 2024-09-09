-- Description
-- Return the list of films that have not been rented out at all in the past month, 
-- but have been rented at least 10 times in total. Include the film_id, title of the 
-- film and in the brackets, its rating, rental count, and the date of the most recent rental. 
-- Since the business is in America, please use American date notation (for example, 'April 09, 2023').
-- Notes:
-- Sort by count of rented films from higher to lower. If two or more films have the same amount of 
-- rentals then sort by last rental date in descending order, if even last rental dates are the same - 
-- then by film title alphabetically.
-- "in the past month" - interval inclusive of 1 month from CURRENT_DATE. We are not taking time part of 
-- today into account for this task
-- "sort by last rental date" means by final text presentation, not the date itself.
-- Schema
-- (not all columns - part of the domain required to solve this kata)
-- inventory table:
-- Column       | Type      | Modifiers
-- ------------ +-----------+----------
-- inventory_id | integer   | not null
-- film_id      | smallint  | not null
-- film table:
-- Column           | Type     | Modifiers
-- -----------------+----------+----------
-- film_id          | integer  | not null
-- title            | varchar  | not null
-- rating           | varchar  | not null
-- rental table:
-- Column       | Type      | Modifiers
-- -------------+-----------+----------
-- rental_id    | integer   | not null
-- inventory_id | integer   | not null
-- rental_date  | timestamp | not null
-- Desired Output
-- The desired output should look like this:
-- film_id | film_title         | rental_count | last_rental_date
-- --------+----------------+------------------+------------------
--    32   | Chinatown (G)      | 23           | January 31, 2023
--    14   | The Terminator (R) | 17           | March 01, 2023
SELECT
    f.film_id,
    CONCAT (f.title, ' (', f.rating, ')') AS film_title,
    COUNT(*) AS rental_count,
    to_char (MAX(r.rental_date), 'FMMonth DD, YYYY') AS last_rental_date
FROM
    rental r
    INNER JOIN inventory i ON r.inventory_id = i.inventory_id
    INNER JOIN film f ON f.film_id = i.film_id
GROUP BY
    f.film_id
HAVING
    COUNT(*) >= 10
    AND MAX(r.rental_date) < current_date - interval '1' month
ORDER BY
    rental_count DESC,
    last_rental_date DESC,
    film_title;