-- Description
-- For this challenge you need to PIVOT data. You have two tables, products and details. 
-- Your task is to pivot the rows in products to produce a table of products which have rows of their detail. 
-- Group and Order by the name of the Product.
-- products table schema
-- - id   - integer
-- - name - text
-- details table schema
-- - id          - integer
-- - product_id  - integer
-- - detail      - text
-- You must use the CROSSTAB statement to create a table that has the schema as below:
-- CROSSTAB table schema
-- - name  - text
-- - bad   - bigint
-- - good  - bigint
-- - ok    - bigint
-- If the values aren't assigned to the last three columns within the query directly, it's assumed they will 
-- be presented in the lexicographical order (i.e. if we have three values, a, b and c, then bad, good and ok 
-- will have these values respectively).
-- Compare your table to the expected table to view the expected results.

CREATE EXTENSION tablefunc;

SELECT *
FROM crosstab(
  $$ 
    SELECT p.name, d.detail, COUNT(*)
    FROM products AS p
    INNER JOIN details AS d ON d.product_id = p.id
    GROUP BY p.name, d.detail
    ORDER BY p.name, CASE d.detail WHEN 'good' THEN 1 
                                   WHEN 'ok' THEN 2 
                                   WHEN 'bad' THEN 3 
                     END
  $$
) AS (name text, good bigint, ok bigint, bad bigint);