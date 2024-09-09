-- Description
-- You are a data analyst at a thriving startup that facilitates investments into high-potential business deals. 
-- Each deal is listed on your platform with a unique deal ID and deal name. Investors, each with a unique account ID, 
-- log in to peruse these deals and explore related documents to make informed investment decisions.
-- The startup is experiencing a high growth phase, and the management team is interested in understanding investor 
-- engagement with the platform. Specifically, they want to know which deals are actively being viewed by investors and 
-- when was the last time any investor logged in to explore a specific deal.
-- The schema that is needed to find this out consists of two tables:
-- deals: Contains columns deal_id and deal_name.
-- deal_login_fact: Contains columns deal_id, account_id, and occurred_at. The occurred_at column is a timestamp 
-- indicating when an investor logged in to view a deal.
-- Write a SQL query that retrieves information about deals, where deals are only included if there has been at 
-- least one login by an investor to read documents related to the deal. The query should include the following information 
-- in the result set: deal_id deal_name is_active boolean that is true if there has been at least one login within the last 90 
-- days and false otherwise.
-- last_login string that represents the number of days and hours since the last login for each deal, in the format 
-- "X days and Y hours ago". Even for durations of exactly 1 day or 1 hour, it should be displayed as "1 days" or "1 hours" 
-- (we are not bothering about single form).
-- The results should be ordered by deal_id in descending order.
-- Desired Output
-- The desired output should look like this:
-- deal_id	deal_name	                is_active	last_login
-- 33	    Rustic Silk Watch	        false	    90 days and 0 hours ago
-- 32	    Lightweight Leather Gloves	true	    89 days and 23 hours ago
-- 30	    Ergonomic Iron Shoes	    true	    57 days and 23 hours ago
SELECT
    deal_id,
    deal_name,
    current_timestamp - max(occurred_at) <= interval '90 days' as is_active,
    to_char (
        now () - max(occurred_at),
        'FMDD "days and" FMHH24 "hours ago"'
    ) as last_login
FROM
    deals
    JOIN deal_login_fact USING (deal_id)
GROUP BY
    deal_id
ORDER BY
    deal_id DESC;