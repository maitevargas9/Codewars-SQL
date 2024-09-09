-- Description
-- We have the messages table that has the following structure:
-- id (integer) - primary key
-- message (text) - message with or without 'apple` occurencies
-- The table contains textual messages. Your task is to identify messages where the word "apple" appears at least twice, 
-- even if it's within a larger word like "apples" (regardless of word boundaries) The search should be case-insensitive, 
-- meaning "Apple", "APPLE", and "aPpLe" should all be treated as valid occurrences of the word "apple".
-- The query should return three columns:
-- id
-- message: The full message text.
-- second_occurrence_position: The position (starting index) of the second occurrence of the word "apple" in the message. 
-- Keep im mind that in PostgreSQL, string indexing starts at 1, not 0. So the first character of a string is at position 1.
-- Only messages with at least two occurrences of the word "apple" should be returned. The result should be ordered by id 
-- in descending order.
SELECT
    id,
    message,
    POSITION(
        'apple' IN REGEXP_REPLACE (LOWER(message), 'apple', '_____')
    ) AS second_occurrence_position
FROM
    messages
WHERE
    CARDINALITY(STRING_TO_ARRAY (LOWER(message), 'apple')) >= 3
ORDER BY
    id DESC;