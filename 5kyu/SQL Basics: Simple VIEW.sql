-- Description
-- For this challenge you need to create a VIEW. This VIEW is used by a sales store to give out vouches to members 
-- who have spent over $1000 in departments that have brought in more than $10000 total ordered by the members id. 
-- The VIEW must be called members_approved_for_voucher then you must create a SELECT query using the view.
-- resultant table schema
-- id
-- name
-- email
-- total_spending
-- NOTE: Your solution should use pure SQL. Ruby is used within the test cases to do the actual testing.
CREATE VIEW
    members_approved_for_voucher AS
SELECT
    memb.id,
    memb.name,
    email,
    total_spending
FROM
    (
        SELECT
            member_id AS "id",
            m.name,
            email,
            SUM(price) AS "total_spending"
        FROM
            sales s
            JOIN products p ON (s.product_id = p.id)
            JOIN members m ON (s.member_id = m.id)
            JOIN (
                SELECT
                    department_id AS "id",
                    SUM(price)
                FROM
                    sales s
                    JOIN products p ON (s.product_id = p.id)
                    JOIN departments d ON (s.department_id = d.id)
                GROUP BY
                    s.department_id
                HAVING
                    SUM(price) > 10000
            ) d ON (s.department_id = d.id)
        GROUP BY
            s.member_id,
            m.name,
            email
        HAVING
            SUM(price) > 1000
    ) memb;

SELECT
    id,
    name,
    email,
    total_spending
FROM
    members_approved_for_voucher
ORDER BY
    id;