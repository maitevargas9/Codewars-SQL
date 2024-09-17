-- Description
-- In the UK, companies are required to file financial reports annually based on their fiscal year end. This task involves 
--calculating the next fiscal year-end date for each company after their last filing.
-- You are given a PostgreSQL database containing a table named uk_company_filings. This table represents the filing dates of 
-- various UK companies and their respective fiscal year ends. Your task is to write a SQL query that calculates the next fiscal 
-- year-end date following each company's filing.
-- The uk_company_filings table has the following structure:
-- id (int): primary key
-- filing_date (date): The date when the company filed its report
-- fiscal_year_end(varchar(4)): The official end of the company's fiscal year, in 'MMDD' format
-- Task Requirements
-- Write a SQL query that selects all columns from the uk_company_filings table and calculates the next fiscal year-end date for 
-- each record.
-- The next fiscal year-end date should be calculated based on the filing_date and fiscal_year_end.
-- The output should have a new column next_fiscal_year_end that shows this calculated date.
-- Ensure your query handles the year transition correctly. For example, if the filing_date is in December 2023 and the 
-- fiscal_year_end is in January, the next_fiscal_year_end should be in January 2024.
-- When the filing_date and the fiscal_year_end fall within the same month, the decision about whether the next_fiscal_year_end 
-- is in the current year or the next year depends on the day component of these dates:
-- If the day of the fiscal_year_end is after the day of the filing_date: In this case, the next_fiscal_year_end should be in 
-- the same year as the filing_date.
-- If the day of the fiscal_year_end is on or before the day of the filing_date: Here, the next_fiscal_year_end should be in the 
-- following year.
-- Result should be ordered first by filing_date in ascending order and then by id in descending order:
-- Additional Notes:
-- Ensure your query correctly handles the scenario where the filing_date and fiscal_year_end are the same. In such cases, the 
-- next_fiscal_year_end should be set to the same date in the following year.
-- We'll exclude February 29th from possible fiscal year-end dates, avoiding complications with leap years.
-- Desired Output
-- The desired output should look like this:
-- filing_date	fiscal_year_end	next_fiscal_year_end
-- 2023-07-31	0801	        2023-08-01
-- 2023-07-31	0601	        2024-06-01
-- 2023-12-31	0101	        2024-01-01
-- 2023-12-31	1130	        2024-11-30
-- 2023-12-31	1231	        2024-12-31
SELECT
    filing_date,
    fiscal_year_end,
    CASE
        WHEN CAST(
            CONCAT (
                EXTRACT(
                    YEAR
                    FROM
                        filing_date
                ),
                fiscal_year_end
            ) AS Date
        ) <= filing_date THEN CAST(
            CONCAT (
                EXTRACT(
                    YEAR
                    FROM
                        filing_date
                ) + 1,
                fiscal_year_end
            ) AS Date
        )
        ELSE CAST(
            CONCAT (
                EXTRACT(
                    YEAR
                    FROM
                        filing_date
                ),
                fiscal_year_end
            ) AS Date
        )
    END AS next_fiscal_year_end
FROM
    uk_company_filings
ORDER BY
    filing_date ASC,
    id DESC;