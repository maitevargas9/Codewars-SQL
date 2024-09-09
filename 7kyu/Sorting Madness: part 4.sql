-- Description
-- We have a table recipe_priority the following schema:
-- id (integer) - primary key
-- group_id (integer) - Identifier for grouping recipes, can have duplicate values
-- recipe (varchar) - Name or code representing the recipe, can have duplicate values within the same group
-- priority (integer) - Numerical value indicating the priority of a recipe within a group
-- Write an SQL query that sorts rows from this table based on the following hierarchy of importance:
-- Group ID: Sort by group in ascending order.
-- Max Priority within Group and Recipe: Sort by the highest priority associated with each recipe within each 
-- group in descending order.
-- Recipe: Sort by recipe name in ascending alphabetical order.
-- Priority: Sort by individual row priority in descending order.
-- ID: Sort by id in desc order to break ties.
-- Sample Data:
-- id | group_id| recipe | priority |
-- ---+---------+--------+----------+
-- 1  |    1    |   B    |   500    |
-- 2  |    1    |   B    |   100    |
-- 3  |    1    |   A    |   500    |
-- 4  |    1    |   A    |   200    |
-- 5  |    2    |   C    |   300    |
-- 6  |    2    |   C    |   300    |
-- 7  |    2    |   D    |   600    |
-- After sorting, the rows should appear in the following order:
-- id | group_id | recipe | priority
-- --------------|--------|
-- 3  |   1      | A      | 500  (max priority tie, but 'A' comes before 'B')
-- 4  |   1      | A      | 200
-- 1  |   1      | B      | 500  (max priority tie, but 'B' comes after 'A')
-- 2  |   1      | B      | 100
-- 7  |   2      | D      | 600
-- 6  |   2      | C      | 300  (id is larger)
-- 5  |   2      | C      | 300  (id is smaller)
SELECT
    *
FROM
    recipe_priority
ORDER BY
    group_id ASC,
    MAX(priority) OVER (
        PARTITION BY
            group_id,
            recipe
    ) DESC,
    recipe ASC,
    priority DESC,
    id DESC;