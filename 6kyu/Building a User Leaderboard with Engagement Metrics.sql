-- Description
-- You are working with a database that tracks user engagement in an online platform. Users can link their profiles 
-- to GitHub accounts to showcase their coding portfolios.
-- We have users table:
-- id (int, primary key): Unique identifier for the user.
-- username (varchar): The user's username.
-- likes_count (int): Total number of likes received by the user.
-- comments_count (int): Total number of comments received by the user.
-- shares_count (int): Total number of shares received by the user.
-- date_joined (date): The date the user joined the platform.
-- and github_accounts table:
-- id (int, primary key): Unique identifier for the GitHub account.
-- user_id (int, foreign key on users table): The user ID this GitHub account is linked to.
-- github_handle (varchar): the GitHub handle or username.
-- Write a query to generate the top 10 most engaged users. Calculate their engagement points using this formula:
-- engagement_points = likes_count * 1  + comments_count * 2 + shares_count * 3
-- If a user has a linked GitHub account, they receive a bonus of 50 points to their engagement score. Include this 
-- bonus when calculating engagement points.
-- Ranking Logic:
-- Users are ranked by their engagement points in descending order.
-- If two users have the same engagement points, the one who joined earlier ranks higher.
-- If both engagement points and join dates are the same, the user whose username comes first alphabetically ranks 
-- higher.
-- Your query should include the following columns:
-- rank (int)
-- username (varchar).
-- engagement_points (int): including the GitHub bonus, if applicable
-- date_joined (date).
-- github_handle (varchar, nullable).
-- For this sample data:
-- users: 
-- | id | username | likes_count | comments_count | shares_count | date_joined|
-- +----+----------+-------------+----------------+-------------+------------+
-- | 1  | Alice    | 10          | 5              | 2           | 2023-01-01 |
-- | 2  | Bob      | 8           | 10             | 5           | 2023-02-01 |
-- | 3  | Charlie  | 15          | 3              | 8           | 2023-03-01 |
-- | 4  | Diana    | 5           | 2              | 1           | 2023-04-01 |
-- | 5  | Eve      | 20          | 7              | 3           | 2023-05-01 |
-- | 6  | Frank    | 12          | 8              | 4           | 2023-06-01 |
-- | 7  | Grace    | 7           | 3              | 6           | 2023-07-01 |
-- | 8  | Heidi    | 9           | 4              | 2           | 2023-08-01 |
-- | 9  | Ivan     | 6           | 3              | 1           | 2023-09-01 |
-- | 10 | Judy     | 25          | 10             | 12          | 2023-10-01 |
-- github_accounts:
-- | id | user_id | github_handle    |
-- +----+---------+------------------+
-- | 1  | 1       | alice_dev        |
-- | 2  | 3       | charlie_coder    |
-- | 3  | 5       | eve_tech         |
-- | 4  | 7       | grace_code       |
-- | 5  | 10      | judy_programmer  |
-- the desired output is the following:
-- | rank | username | engagement_points  | date_joined  | github_handle    |
-- +------+----------+--------------------+-------------+-------------------+
-- | 1    | Judy     | 131                | 2023-10-01  | judy_programmer   |
-- | 2    | Charlie  | 95                 | 2023-03-01  | charlie_coder     |
-- | 3    | Eve      | 93                 | 2023-05-01  | eve_tech          |
-- | 4    | Grace    | 81                 | 2023-07-01  | grace_code        |
-- | 5    | Alice    | 76                 | 2023-01-01  | alice_dev         |
-- | 6    | Bob      | 43                 | 2023-02-01  | NULL              |
-- | 7    | Frank    | 40                 | 2023-06-01  | NULL              |
-- | 8    | Heidi    | 23                 | 2023-08-01  | NULL              |
-- | 9    | Ivan     | 15                 | 2023-09-01  | NULL              |
-- | 10   | Diana    | 12                 | 2023-04-01  | NULL              |
SELECT
    RANK() OVER (
        ORDER BY
            (
                likes_count * 1 + comments_count * 2 + shares_count * 3 + CASE
                    WHEN github_accounts.id IS NOT NULL THEN 50
                    ELSE 0
                END
            ) DESC,
            users.date_joined ASC,
            users.username ASC
    ) AS rank,
    users.username,
    (
        likes_count * 1 + comments_count * 2 + shares_count * 3 + CASE
            WHEN github_accounts.id IS NOT NULL THEN 50
            ELSE 0
        END
    ) AS engagement_points,
    users.date_joined,
    github_accounts.github_handle
FROM
    users
    LEFT JOIN github_accounts ON users.id = github_accounts.user_id
ORDER BY
    rank
LIMIT
    10;