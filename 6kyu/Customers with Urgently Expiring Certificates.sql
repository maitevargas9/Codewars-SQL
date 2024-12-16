-- Description
-- You are working with a database for a company that manages certifications for its customers. The company needs to identify 
-- customers who have certificates expiring within the next 14 days and do not have any other certificates that expire later. 
-- This information is crucial for sending timely reminders to customers for renewals.
-- We have customers table:
-- id (int): primary key.
-- ssn (string): The social security number of the customer. Serves as a unique identifier.
-- name (string): The name of the customer.
-- and certs table:
-- id (int): primary key.
-- cert_num (string): The unique number of the certificate.
-- ssn (string): The social security number of the customer to whom the certificate belongs. This is a foreign key referencing 
-- the Customers table.
-- cert_start (date): The start date of the certificate's validity.
-- cert_finish (date): The expiration date of the certificate.
-- Construct an SQL query that selects the appropriate data from these tables. The query should:
-- Identify certificates that are expiring within the next 14 days from the current_date.
-- For each customer, the query should include every certificate that is expiring within the next 14 days. This means a single 
-- customer might have multiple certificates listed in the results if all of them are expiring within the 14-day window.
-- Exclude customers who have any other certificates with expiration dates beyond this 14-day window.
-- Order the results by the customer's name then by customer's SSN, and finally by certificate number - all in ascending order.
-- Expected Result Columns:
-- name: The name of the customer.
-- ssn: The social security number of the customer.
-- cert_num: The number of the certificate.
-- cert_start: The start date of the certificate's validity.
-- cert_finish: The expiration date of the certificate.
WITH
    ExpiringSoon AS (
        SELECT
            c.name,
            c.ssn,
            ct.cert_num,
            ct.cert_start,
            ct.cert_finish
        FROM
            customers c
            INNER JOIN certs ct ON c.ssn = ct.ssn
        WHERE
            ct.cert_finish BETWEEN CURRENT_DATE AND CURRENT_DATE  + INTERVAL '14 DAYS'
    ),
    NonExpiringCertificates AS (
        SELECT
            ssn
        FROM
            certs
        WHERE
            cert_finish > CURRENT_DATE + INTERVAL '14 DAYS'
        GROUP BY
            ssn
    )
SELECT
    es.name,
    es.ssn,
    es.cert_num,
    es.cert_start,
    es.cert_finish
FROM
    ExpiringSoon es
WHERE
    es.ssn NOT IN (
        SELECT
            ssn
        FROM
            NonExpiringCertificates
    )
ORDER BY
    es.name ASC,
    es.ssn ASC,
    es.cert_num ASC;