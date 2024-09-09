-- Description
-- You are a computer science student interning at a dynamic online media company. The company hosts a popular platform 
-- where users can discuss a wide range of topics. Your project involves developing a feature that shows the total number 
-- of votes and visits for each topic on the site. This feature is intended to help the content team gauge user engagement 
-- and interest in different topics.
-- Challenge: After deploying your initial SQL query for this feature, you notice the data doesn't seem right. 
-- The total votes and visits for topics are much higher than expected. Furthermore, you encountered a specific issue: 
-- when topics had no votes and no visits, the total votes are displayed as NULL instead of 0. This inconsistency occurs 
-- only when both votes and visits are zero; if there are visits but no votes, the total votes correctly show as 0.
-- You need to revise the SQL query to ensure it accurately calculates the total ratings and visits for each topic.
-- Initial incorrect query:
-- SELECT topics.id, SUM(votes.rating) AS total_rating, COUNT(visits.id) AS total_visits
-- FROM topics
-- LEFT JOIN visits ON visits.content_id = topics.id
-- LEFT JOIN votes ON votes.content_id = topics.id
-- GROUP BY topics.id
-- ORDER BY topics.id DESC;
-- Table Schemas:
-- topics:
-- id (int): Unique identifier for each topic.
-- name (varchar): The name of the topic.
-- message (varchar): A description or message of the topic.
-- uid (int): User ID of the topic creator.
-- votes:
-- id (int): Unique identifier for each vote.
-- rating (tinyint): The rating given by the user (assumed to be a positive or negative vote).
-- content_id (int): The ID of the topic that the vote is associated with.
-- uid (int): User ID of the user who voted.
-- visits:
-- id (int): Unique identifier for each visit.
-- content_id (int): The ID of the topic that was visited.
-- uid (int): User ID of the visitor.
-- The task is to revise the query to avoid the incorrect inflation of vote and visit counts, ensuring that the content 
-- team receives accurate data for their analysis. The output should still list the topic.id, followed by the total sum 
-- of votes' ratings, and the count of visits for each topic, ordered by topic.id in descending order. Query must handle 
-- cases where topics may have zero votes or/and visits ensuring the correct display of 0 instead of NULL for the total 
-- votes in such scenarios.
SELECT
    topics.id,
    COALESCE(SUM(votes.rating), 0) AS total_rating,
    (
        SELECT
            COUNT(visits.id)
        FROM
            visits
        WHERE
            visits.content_id = topics.id
    ) AS total_visits
FROM
    topics
    LEFT JOIN votes ON votes.content_id = topics.id
GROUP BY
    topics.id
ORDER BY
    topics.id DESC;