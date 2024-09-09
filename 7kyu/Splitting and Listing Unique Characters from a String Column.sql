-- Description
-- Imagine we have a table named products with columns product_id and features. 
-- In this case, features is a string containing various single-character codes that 
-- represent different attributes or features of a product. 
-- For instance, each character could stand for a feature like 'waterproof', 'rechargeable', 'wireless', etc. 
-- There are no duplicate symbols within the features column for each product - each character in the features 
-- string is unique for that product (both uppercase and lowercase are allowed, but no repetitions).
-- The table structure is product_id (varchar, primary key) features (varchar(50))
-- Example Data:
-- product_id  features
-- P001	       AB
-- P002	       C
-- P003	       ADE
-- In this scenario, we want to break down the features string into individual characters so that we can analyze 
-- or operate on each feature separately.
-- Write a query that will produce a result where each row represents a single feature of a product. 
-- For instance, for a product with 'AB' in the features column, there will be two rows in the output: 
-- one for 'A' and one for 'B'. This is useful for analyzing, reporting, or even joining with another table that 
-- explains what each feature code stands for.
-- Results need to have 2 columns (product_id and feature) and should be ordered by product_id (asc) and then by 
-- the sequence of the letters as they appear in the features string for each product.
-- Desired Output
-- The desired output should look like this:
-- product_id feature
-- P001	      A
-- P001	      B
-- P002	      C
-- P003	      A
-- P003	      D
-- P003	      E
SELECT
    product_id,
    regexp_split_to_table (features, '') AS feature
FROM
    products
ORDER BY
    1;