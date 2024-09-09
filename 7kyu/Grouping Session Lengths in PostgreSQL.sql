-- Definition
-- You are working for a company that provides a video streaming platform. 
-- They are interested in understanding the length of video streaming sessions their users have. 
-- To do this, they've collected data for each session and stored it in a PostgreSQL database.
-- The database has a table called sessions with the following columns:
-- session_id (integer): A unique identifier for each streaming session.
-- length_seconds (integer): The length of the streaming session in seconds.
-- Write a SQL query to count the number of sessions that fall within five-second intervals (e.g., 0-4, 5-9, etc.).
-- Your query should return a result set with two columns:
-- bucket (text): This represents the five-second interval. It should be a string in the format "start-end", 
-- where "start" is the beginning of the interval and "end" is the end of the interval. For example, a session length 
-- of 25 seconds should fall into the "25-29" bucket.
-- count (integer): The number of sessions that fall within the interval represented by the bucket.
-- So on the concrete example, for this sample dataset:
-- | session_id | length_seconds |
-- |------------|----------------|
-- |     1      |      25        |
-- |     2      |      453       |
-- |     3      |      27        |
-- The result of the SQL query will be:
-- |  bucket  | count |
-- |----------|-------|
-- |  25-29   |   2   |
-- | 450-454  |   1   |
SELECT
    (length_seconds / 5 * 5) || '-' || (length_seconds / 5 * 5 + 4) AS bucket,
    COUNT(*) AS count
FROM
    sessions
GROUP BY
    length_seconds / 5
ORDER BY
    length_seconds / 5;