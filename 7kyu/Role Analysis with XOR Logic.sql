-- Description
-- As a database manager, you're tasked with reviewing user roles to enhance system security. 
-- Your objective: Identify users with exclusively 'admin' or 'internal' roles, but not both, 
-- mirroring the XOR (exclusive OR) logic. This will aid in refining role-based access controls in the organization.
-- We have a table named user_roles with the following structure:
-- id (integer): the unique identifier of the record.
-- username (string) - the username of the user.
-- role (string) - the role assigned to the user. Can be 'admin', 'internal', or 'external'.
-- You need to write an SQL query which identifies users who have either the role admin or internal, but not both.
-- The result should be sorted by usernamre in ascending alphabetical order and have the following columns:
-- username (string)
-- internal (boolean) - has the value of true if the user has the 'internal' role and false otherwise.
-- admin (boolean) - has the value of true if the user has the 'admin' role and false otherwise.
-- Thus, on the concrete example, for this sample data:
-- id | username |   role   
-- ---+----------+----------
-- 1  | name1    | internal
-- 2  | name1    | admin
-- 3  | name2    | internal
-- 4  | name3    | admin
-- 5  | name4    | external
-- we need to get the following result:
--  username | internal | admin 
-- ----------+----------+---------
--  name2    |  true    |  false   
--  name3    |  false   |  true   
-- Notes
-- there are no duplicates for username/role pairs
SELECT
    username,
    bool_or (role = 'internal') AS internal,
    bool_or (role = 'admin') AS admin
FROM
    user_roles
GROUP BY
    username
HAVING
    bool_or (role = 'internal') <> bool_or (role = 'admin')
ORDER BY
    username;