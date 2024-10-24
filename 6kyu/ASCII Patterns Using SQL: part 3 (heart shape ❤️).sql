-- Description
-- This SQL task is a small token of my gratitude to those who have generously lent their time and expertise to help me create 
-- katas. Separately I want to express my gratitude to dfhwze who approved almost all my katas. Voile, Unnamed, Twilight_Sun, 
-- monadius and others for consistent solving of beta katas and providing valuable feeback. Your support has not only enriched 
-- my work but also inspiring me to pay the gift of knowledge forward!
-- Your task is to implement a PostgreSQL PL/pgSQL function called draw_heart that will generate an ASCII art representation of 
-- a heart shape. The function should return this representation as rows of text in a PostgreSQL table.
-- Your function should match the following signature:
-- create or replace function draw_heart(size integer)
-- returns table(heart_shape text) as $$
-- Your implementation goes here
-- $$ language plpgsql;
-- Input:
-- size (integer): An integer parameter indicating the size of the heart shape. The minimum size is 4.
-- Output
-- The function will return a table with a single column named heart_shape.
-- Each row in the table represents a row in the heart shape, filled with asterisks ("*") and spaces.
-- For example, for size 5, the pattern should be:
--  ** **      
-- *******
--  *****     
--   ***     
--    *
-- Look tests for more examples.

CREATE OR REPLACE FUNCTION draw_heart(size INTEGER)
RETURNS TABLE(heart_shape TEXT) AS $$
  SELECT REPEAT(' ' || REPEAT('*', size - 3), 2)
  UNION ALL
  SELECT REPEAT(' ', i) || REPEAT('*', 2 * size - i * 2 - 3) FROM GENERATE_SERIES(0, size - 2) AS t(i)
$$ LANGUAGE SQL;