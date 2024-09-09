-- Description
-- We need to identify hosts in a network that are missing a specific software title, in this case, "Title2" 
-- This query aims to support IT operations in understanding which hosts might be non-compliant with required 
-- software installations or may require updates.
-- host_software table:
-- id (integer) - primary key
-- host (varchar) - Represents the name of the host machine ('web_server_1', 'db_server_2' etc,)
-- software_title (varchar) - represents the name of the software installed on the host. ( 'Title1', 'Title2', 'Title3', etc.)
-- install_date (date) - Records the date of the software installation.
-- Requirements:
-- The query should return a list of host names.
-- Each host name in the list should represent a host machine where "Title2" is missing.
-- The query should also filter out hosts that haven't had any software installed in over a year from the current date, 
-- as these might be decommissioned or out-of-scope for immediate attention. In other words, if a host has all installations 
-- older than a year, it should not appear in the result set. Also, "one year from the current date" criterion should be 
-- inclusive of the current date. That is, any software installed exactly one year ago from today should also be considered 
-- "recent."
-- The result should contain only one column, host, and be sorted in ascending alphabetical order.
SELECT
    host
FROM
    host_software
GROUP BY
    host
HAVING
    EVERY (software_title <> 'Title2')
    AND MAX(install_date) >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY
    host;