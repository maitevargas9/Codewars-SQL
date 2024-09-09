-- Description
-- Intro
-- This Kata is a short introduction to the topic of database normalization. It's just a simple example of a 
-- decently complex topic with some details omitted for simplicity; to all interested, I advise further study.
-- Background
-- Normalization is a process of removing data redundancy from the database. Reduction of duplicated data 
-- means a lesser probability of inconsistencies and greater flexibility. Normal Forms are steps between which 
-- different forms of data redundancy are removed from the table. For a higher normal form to be satisfied all 
-- lower normal forms must also be satisfied.
-- First Normal Form (1NF)
-- To achieve First Normal Form (1NF) every column in the table must be atomic i.e. it can't contain a collection of values.
-- Task
-- You will be provided with a single table restaurants from which you have to extract two tables conforming to the First 
-- Normal Form
-- The first table must contain restaurants without a column with collection of values - menu field should be removed.
-- The second table must contain a dish column and a restaurant_id column - matching dishes to their restaurants
-- Ordering is not important
-- The solution should leave the database with two tables (restaurants and dishes) which will be queried by the tests.
-- Input table
-- --------------------------------------------------------------------------------------------------------
-- | Table       | Column | Type   | Notes                                                                |
-- |-------------+--------+-------------------------------------------------------------------------------|
-- | restaurants | id     | int    |                                                                      |
-- |             | menu   | string | comma-separated list of unique dishes (dish name may contain spaces) |
-- |             | name   | string |                                                                      |    
-- |             | stars  | int    |                                                                      |
-- --------------------------------------------------------------------------------------------------------
-- Output tables
-- ---------------------------------
-- | Table       | Column | Type   |
-- |-------------+--------+--------|
-- | restaurants | id     | int    |
-- |             | name   | string |    
-- |             | stars  | string |
-- ---------------------------------
-- -----------------------------------
-- | Table  | Column        | Type   |
-- |--------+---------------+--------|
-- | dishes | restaurant_id | int    |
-- |        | dish          | string |    
-- -----------------------------------
CREATE TABLE
    dishes AS
SELECT
    id AS restaurant_id,
    UNNEST (string_to_array (menu, ',')) AS dish
FROM
    restaurants;

ALTER TABLE restaurants
DROP COLUMN menu;