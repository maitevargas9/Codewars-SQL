-- Description
-- Given a table client_parents that describes parent-child relationships, write an SQL query to determine how many siblings 
-- each child has. A sibling is defined as another child who shares at least one parent with the given child.
-- Each child (represented by client_id) has exactly two parents (represented by parent_id). There can be no duplicate rows 
-- in the table; that is, a particular combination of client_id and parent_id is unique.
-- The sibling relationship is not transitive: If Client X is a sibling of Client Y, and Client Y is a sibling of Client Z, 
-- it does not necessarily mean that Client X is a sibling of Client Z unless they directly share a parent.
-- parent:   1   2   3   4
--            \ / \ / \ /
-- child:      A   B   C
-- In the above example, Child A and Child B are siblings because they share Parent 2. Child B and Child C are siblings because 
-- they share Parent 3. However, Child A and Child C are not siblings because they don't share a direct parent, showcasing 
-- the non-transitive nature of the sibling relationship.
-- Schema
-- client_parents:
-- client_id (integer) - Represents the ID of the client.
-- parent_id (integer) - Represents the ID of the parent.
-- For this sample data:
-- | client_id | parent_id |
-- +-----------+-----------+
-- |     1     |     1     |
-- |     1     |     2     |
-- |     2     |     3     |
-- |     2     |     4     |
-- |     3     |     3     |
-- |     3     |     5     |
-- |     4     |     3     |
-- |     4     |     4     |
-- |     5     |     1     |
-- |     5     |     6     |
-- |     6     |     7     |
-- |     6     |     8     |
-- Expected output is:
-- | client_id | num_siblings |
-- +-----------+--------------+
-- |     1     |      1       |
-- |     2     |      2       |
-- |     3     |      2       |
-- |     4     |      2       |
-- |     5     |      1       |
-- |     6     |      0       |
-- Result should be sorted by client_id in ascending order.
-- Columns in the resultant dataset:
-- client_id (integer) - Represents the ID of the client.
-- num_siblings (integer) - Represents the number of siblings the client has.
-- Explanation of the Expected Output:
-- Client 1 has parents 1 and 2.
-- Shares parent 1 with Client 5.
-- Total siblings = 1 (Client 5).
-- Client 2 has parents 3 and 4.
-- Shares parent 3 with Clients 3 and 4.
-- Shares parent 4 also with Client 4.
-- Total siblings = 2 (Clients 3 and 4).
-- Client 3 has parents 3 and 5.
-- Shares parent 3 with Clients 2 and 4.
-- Total siblings = 2 (Clients 2 and 4).
-- Client 4 has parents 3 and 4.
-- Shares parent 3 with Clients 2 and 3.
-- Shares parent 4 also with Client 2.
-- Total siblings = 2 (Clients 2 and 3).
-- Client 5 has parents 1 and 6.
-- Shares parent 1 with Client 1.
-- Total siblings = 1 (Client 1).
-- Client 6 has parents 7 and 8.
-- Doesn't share parents with any other client.
-- Total siblings = 0.
SELECT
    A.client_id,
    COUNT(DISTINCT B.client_id) AS num_siblings
FROM
    client_parents A
    LEFT OUTER JOIN client_parents B ON A.parent_id = B.parent_id
    AND A.client_id <> B.client_id
GROUP BY
    A.client_id
ORDER BY
    A.client_id;