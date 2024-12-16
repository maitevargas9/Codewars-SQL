-- Description
-- Your task is to write and execute a SQL query that illustrates the various stages in a developer's career, 
-- along with their associated attributes.
-- We have developer_attributes table with the following columns:
-- developer_title: A String column representing the title of the developer (e.g., Trainee, Junior, Middle, Senior, Architect).
-- attribute: A String column representing an attribute of the developer at that level.
-- Write a SQL query that does the following:
-- Selects and highlights each distinct developer_title from the table.
-- Lists the attributes associated with each title below it.
-- The output should be ordered by the developer title and then by the attributes - both in ascending alphabetical order.
-- In your result set, use the column name description to display the data. Developer titles should be distinctively formatted to
-- stand out. Enclose them in whitespaces and asterisks like *** Trainee ***.
-- The output should be a list where each developer title is followed by its respective attributes, clearly differentiating 
-- between the titles and their attributes.
-- Desired Output
-- The desired output should look like this:
-- description
-- *** Architect ***
-- Attends meetings about meetings
-- Draws diagrams on napkins
-- *** Junior ***
-- Celebrates first pull request
-- Writes "Hello World" in 5 languages
-- *** Middle ***
-- Debugs with print statements
-- Googles Stack Overflow answers
-- *** Senior ***
-- Has more coffee than blood
-- Refactors code in sleep
-- *** Trainee ***
-- Asks "What is Git?"
-- Constantly searches for "How to program"
SELECT
    UNNEST (title || attributes) AS description
FROM
    (
        SELECT
            '*** ' || developer_title || ' ***' AS title,
            ARRAY_AGG (
                attribute
                ORDER BY
                    attribute
            ) AS attributes
        FROM
            developer_attributes
        GROUP BY
            developer_title
        ORDER BY
            developer_title
    ) AS x