-- Description
-- We're analyzing data for a customer support center for a tech company. The "No" outcomes represent failed attempts 
-- by companies automated voice assistant to understand customer requests.
-- Now, if the voice assistant fails to understand the same customer six times in a row, a live support agent takes 
-- over the call.
-- Table Schema (calls):
-- call_id (integer) - The unique identifier for each call.
-- user_id (integer) - The unique identifier for the customer.
-- outcome (varchar) - The outcome of the voice assistant's attempt to understand the customer's request. Can be 
-- either 'Yes' (understood) or 'No' (not understood).
-- date_of_call (timestamp) - The date and time when the call occurred.
-- Your task is to write a PostgreSQL query to find instances where the voice assistant failed to understand the same 
-- customer six times in a row. The result should include the details of the sixth consecutive "No" call.
-- The result set should include user_id (integer) and date_of_call (text) columns and be sorted by user_id and 
-- date_of_call in ascending order.
-- Notes:
-- It is guaranteed that each call for user has unique timestamp and in ascending chronological order.
-- If a user has 12 consecutive "No" outcomes, the query should only return the 6th "No," not both the 6th and 12th.
-- If a user has two separate series of 6 consecutive "No" outcomes, each separated by a different outcome, both 
-- occurrences of the 6th "No" should be returned.
-- Desired Output
-- The desired output should look like this:
-- user_id	date_of_call
-- 1	    2022-01-01 00:50:00
-- 1	    2022-01-01 02:00:00
-- 2	    2022-01-01 01:20:00
-- ...

WITH calls_with_flags AS (
    SELECT
        call_id,
        user_id,
        outcome,
        date_of_call,
        CASE 
            WHEN outcome = 'No' THEN 1 
            ELSE 0 
        END AS is_no
    FROM calls
),
no_streaks AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date_of_call) -
        SUM(is_no) OVER (PARTITION BY user_id ORDER BY date_of_call ROWS UNBOUNDED PRECEDING) AS streak_group
    FROM calls_with_flags
),
consecutive_nos AS (
    SELECT
        user_id,
        date_of_call,
        outcome,
        COUNT(*) OVER (PARTITION BY user_id, streak_group ORDER BY date_of_call ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS count_in_window,
        ROW_NUMBER() OVER (PARTITION BY user_id, streak_group ORDER BY date_of_call) AS row_in_streak
    FROM no_streaks
    WHERE outcome = 'No'
)
SELECT
    user_id,
    date_of_call::text
FROM consecutive_nos
WHERE row_in_streak = 6
ORDER BY user_id, date_of_call;