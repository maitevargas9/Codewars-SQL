-- Description
-- In this task, you are given the DVD Rental database. Your objective is to write a SQL query that accomplishes the 
-- following:
-- Select rentals for a specific customer with customer_id = 1
-- For each day that the selected customer rented a movie, identify groups of consecutive rental days. In other words,
-- find sequences of days where each day is directly following the previous one (e.g., 14th, 15th, and 16th of 
-- February would form a group of three consecutive days).
-- For each rental day, determine the size of its group of consecutive days.
-- Ensure each date appears only once in your results. If the customer rented more than one movie on the same day, 
-- that day should still only be counted once.
-- The output of your query should be a list of all rental dates for the selected customer, along with the size of 
-- the consecutive day group that each date belongs to. For dates that are not part of a consecutive sequence, the 
-- group size should be 1.
-- The result should consist of the following columns:
-- name: This column represents the full name of the customer. It is a concatenation of the first_name and last_name
-- date_rental_occurred: This column represents the date without the time component when the customer rented a DVD. 
-- The dates are sorted in ascending order (from the earliest to the latest).
-- consecutive_days: This column represents the size of the group of consecutive rental days that each date belongs 
-- to. For each rental day, it counts the number of consecutive days, including the day itself, during which the 
-- customer rented DVDs. If a date is not part of a consecutive sequence (i.e., the customer didn't rent a DVD on the 
-- day before or after), the group size is 1.
-- Notes:
-- for the sample tests, static dump of DVD Rental Sample Database is used, for the final solution - random tests.
-- Schema
-- (not all columns - part of the domain required to solve this kata)
-- customer table:
-- Column       | Type     | Modifiers
-- ------------ +----------+----------
-- customer_id  | integer  | not null
-- first_name   | varchar  | not null
-- last_name    | varchar  | not null
-- rental table:
-- Column       | Type      | Modifiers
-- -------------+-----------+----------
-- rental_id    | integer   | not null
-- customer_id  | integer   | not null
-- rental_date  | timestamp | not null
-- Desired Output
-- The desired output should look like this:
--   name        | date_rental_occurred   | consecutive_days
-- --------------+-----------------------+------------------
--  John Smith   | 2005-05-25            | 1             
--  John Smith   | 2005-05-28            | 1  
--  John Smith   | 2005-06-15            | 2             
--  John Smith   | 2005-06-16            | 2   
--  John Smith   | 2005-06-21            | 1
--  ...
WITH
    customer_rentals AS (
        SELECT DISTINCT
            c.first_name || ' ' || c.last_name AS name,
            DATE (r.rental_date) AS date_rental_occurred
        FROM
            rental r
            JOIN customer c ON r.customer_id = c.customer_id
        WHERE
            r.customer_id = 1
    ),
    numbered_dates AS (
        SELECT
            name,
            date_rental_occurred,
            ROW_NUMBER() OVER (
                ORDER BY
                    date_rental_occurred
            ) AS rn
        FROM
            customer_rentals
    ),
    grouped_dates AS (
        SELECT
            name,
            date_rental_occurred,
            date_rental_occurred - INTERVAL '1 day' * rn AS grp_key
        FROM
            numbered_dates
    ),
    group_sizes AS (
        SELECT
            grp_key,
            COUNT(*) AS consecutive_days
        FROM
            grouped_dates
        GROUP BY
            grp_key
    ),
    final_result AS (
        SELECT
            gd.name,
            gd.date_rental_occurred,
            gs.consecutive_days
        FROM
            grouped_dates gd
            JOIN group_sizes gs ON gd.grp_key = gs.grp_key
    )
SELECT
    *
FROM
    final_result
ORDER BY
    date_rental_occurred;