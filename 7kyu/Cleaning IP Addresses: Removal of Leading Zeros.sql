-- Description
-- In this task, you will work with a PostgreSQL database that contains a table named ip_addresses. 
-- This table has two columns, id (an integer that uniquely identifies each row) and ip (a string that contains an IP address). 
-- Some of the IP addresses have leading zeros.
-- Your task is to write a SQL query that returns each id and its associated IP address, but with all leading zeros removed 
-- from the IP address. The result should be a new column named cleaned_ip.
-- Notes
-- The IP addresses in the table are guaranteed to be valid and always contain exactly four octets, separated by dots. 
-- Note that an octet with all zeros (e.g., 000) should be transformed into 0, not removed entirely.
-- The result should be ordered by id in descending order.
SELECT
    id,
    regexp_replace (ip, '(^|\.)0+(\d)', '\1\2', 'g') AS cleaned_ip
FROM
    ip_addresses
ORDER BY
    id DESC;